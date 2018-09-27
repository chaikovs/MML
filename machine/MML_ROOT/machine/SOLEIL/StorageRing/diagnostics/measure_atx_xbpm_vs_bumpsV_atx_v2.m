%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Measure atx xbpm + imager response vs bump nanoscopium
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

% Define devices of interest
devID_nano      =   'ans-c13/ei/l-u18.1';
devID_atx       =   'ans-c13/ei/l-u20.2';
attr_list_ID    =   {'gap'};
device_ccd_img  =   'tdl-i13-l/dg/img.1-cam.1';
device_MT_Tz    =   'tdl-i13-l/dg/img.1-mt_tx.1';

% Check that operator is ready
choice          =   questdlg('Launch measurement vs bumps V ?', ...
 'Check SDL13', ...
 'YES','NO','NO');
    % Handle response
switch choice
    case 'YES'
        disp([choice ' ->> mesurement launched...  '])
        choice_opt  = 1;
    case 'NO'
        disp([choice ' ->> measurement aborted...  '])
        choice_opt  = 2;
       break
end

% Choose if diags = XBPM only or XBPM + Imager
choice          =   questdlg('Record XBPM only or XBPM + Imager ?', ...
 'Check SDL13', ...
 'XBPM only','XBPM + Imager','XBPM + Imager');
    % Handle response
switch choice
    case 'XBPM only'
        disp([choice ' ->> mesurement with XBPM only launched...  '])
        nb_diags    = 1;
    case 'XBPM + Imager'
        disp([choice ' ->> measurement with XBPM + Imager launched...  '])
        nb_diags    = 2;
end

% Check that ABSORBER sdl13 is EN
clear temp
temp                        =   tango_read_attribute('ANS-C13/VI/ABS.1','Absorbeur_EN');
if (temp.value==0)
    errordlg('ABSORBER is HORS. Please insert ABSORBER before proceeding.','File Error') 
    break
end
fprintf('ABSORBER is EN.\n');

% Check that IMG is inserted and start camera
if (nb_diags==2)
clear temp
temp                        =   tango_read_attribute('tdl-i13-l/dg/img.1-mt_tx.1','Insere');
if (temp.value==0)
    errordlg('IMAGER is EXTRAIT. Please insert IMAGER before proceeding.','File Error') 
    break
end
fprintf('IMAGER is INSERE.\n');
% 
tango_command_inout2(device_ccd_img,'Start');
end

% Check current is between 5 and 6.5 mA
clear temp
temp                =   tango_read_attribute('ans/dg/current_interlock_ctrl','current');
if (temp.value < 5)
    errordlg('Current is below 5 mA. Store between 5 and 6.5 mA.','File Error') 
    break
elseif (temp.value > 6.5)
    errordlg('Current is above 6.5 mA. Store between 5 and 6.5 mA.','File Error')
    break
end
fprintf('Current is OK.\n');

% Check that SOFB is off
clear temp
temp                =   tango_read_attribute('ans/ca/service-locker','sofb');
if (temp.value == 1 )
    errordlg('Please stop SOFB before launching measurement.','File Error') 
    break
end
fprintf('SOFB is OFF.\n');

% Check that seuils d'interlock modifiés
user_entry = input('Les seuils d interlock BPM sont_ils passes à 0.8 mm ? (y/n) \n', 's')
Cy=strcmp(user_entry,'y');
while(Cy==0)
    user_entry = input('Les seuils d interlock BPM sont_ils passes à 0.8 mm ? (y/n) \n', 's')
    Cy=strcmp(user_entry,'y');
end

    
% Define atx gap for operation
gap_atx         =   5.5;

% Define nano gap for operation
gap_nano        =   30;

% Define bumps in ATX to do
bump_amp        =   0.5;   % [mm]
bpm_amont       =   [13 1];
bpm_aval        =   [13 8];
bump_bpms       =   [bpm_amont;bpm_aval];
nb_phase        =   4;

% Define tolerance for gap positionning
gtol            =   0.001;

% Define time to wait for XBPM response to stabilize
tempo_xbpm      =   3;

% Load reference data
dir_name        =   '/home/data/matlab/data4mml/measdata/SOLEIL/StorageRingdata/SDL13/';   
% data_ref        =
% load(strcat(dir_name,'160418-Blades-current-vs-bumpsATX-ATX-5p5mm-ABS-EN.mat'));    % Reference before change ATX XBPM cables
data_ref        =   load(strcat(dir_name,'XBPM_ATX_response_vs_bumpsV_atx_2017-09-11_19-49-56.mat'));   % REF after changing ATX cables @ 6 mA

% Send ATX to operation gap
tango_write_attribute2(devID_atx,'gap', gap_atx);
attr_val_list_ID    =   tango_read_attributes2(devID_atx,attr_list_ID);
gap_read            =   attr_val_list_ID.value(1);
fprintf('Waiting ATX ID arrival...\n');
while(abs(gap_read-gap_atx)>gtol)
    attr_val_list_ID    =   tango_read_attributes2(devID_atx,attr_list_ID);
    gap_read            =   attr_val_list_ID.value(1);
    pause(1);
end
fprintf('ATX ID arrived at gap: %f \n',gap_read);
data.gap_atx            =   gap_read;

% Send NANO to operation gap
tango_write_attribute2(devID_nano,'gap', gap_nano);
attr_val_list_ID    =   tango_read_attributes2(devID_nano,attr_list_ID);
gap_read            =   attr_val_list_ID.value(1);
fprintf('Waiting NANO ID arrival...\n');
while(abs(gap_read-gap_nano)>gtol)
    attr_val_list_ID    =   tango_read_attributes2(devID_nano,attr_list_ID);
    gap_read            =   attr_val_list_ID.value(1);
    pause(1);
end
fprintf('NANO ID arrived at gap: %f \n',gap_read);
data.gap_nano            =   gap_read;

fprintf('Measurement in progress...\n');
clear i
i       =   1;

% Read ATX XBPM blade currents
clear temp
temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IaSA');
data.Ia(i)          =   temp.value;
clear temp
temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IbSA');
data.Ib(i)          =   temp.value;
clear temp
temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IcSA');
data.Ic(i)          =   temp.value;
clear temp
temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IdSA');
data.Id(i)          =   temp.value;    
data.Isum(i)        =   data.Ia(i)+data.Ib(i)+data.Ic(i)+data.Id(i);

% Read ATX Imager image
if (nb_diags==2)
clear temp
temp                    =   tango_read_attributes2(device_ccd_img,{'exposureTime'});
data.img_TpsPose(i)     =   temp(1).value(1);
clear temp
temp                    =   tango_read_attributes2(device_ccd_img,{'image'});
data.img_image(i,:,:)   =   temp(1).value';
data.img_Itot(i)        =   squeeze(squeeze(sum(sum(data.img_image(i,:,:),2),3)));
clear temp
temp                    =   tango_read_attributes2(device_MT_Tz,{'Insere'})
data.img_pos_MT_Tz(i)   =   temp(1).value(1);
mask                    =   squeeze(data.img_image(1,:,:)).*0+1;
for ii=1:1216
    for jj=700:1400
        mask(jj,ii)       =   0;
    end
end
end

% Read machine current
clear temp
temp                =   tango_read_attribute('ans/dg/current_interlock_ctrl','current');
data.current(i)     =   temp.value;

% Read BPM infos about orbit in ATX
clear temp    
temp                =   tango_read_attribute('ans-c13/dg/bpm.1','ZPosSA');
data.Zposbpm1(i)    =   temp.value;
clear temp
temp                =   tango_read_attribute('ans-c13/dg/bpm.8','ZPosSA');
data.Zposbpm8(i)    =   temp.value;
clear temp
temp                =   tango_read_attribute('ans-c13/dg/bpm.1','XPosSA');
data.Xposbpm1(i)    =   temp.value;
clear temp
temp                =   tango_read_attribute('ans-c13/dg/bpm.8','XPosSA');
data.Xposbpm8(i)    =   temp.value;
clear temp
temp                        =   tango_read_attribute('TDL-I13-LT/DG/CALC-XBPM-PROJ','positionX_at_XBPM');
data.atx_XposXBPMproj(i)    =   temp.value;
clear temp
temp                        =   tango_read_attribute('TDL-I13-LT/DG/CALC-XBPM-PROJ','positionZ_at_XBPM');
data.atx_ZposXBPMproj(i)    =   temp.value;

% Read absorber position
clear temp
temp                        =   tango_read_attribute('ANS-C13/VI/ABS.1','Absorbeur_EN');
data.ABS(i)                 =   temp.value; % 0 = HORS / 1 = EN
if (data.ABS(i)==0)
    fprintf('ATTENTION : ABSORBEUR HORS !!!!!!!!!!!!!!!!!!! \n')
end
    
i   =   i+1;    

% Scan bumps V in ATX 
for index=1:nb_phase
    if (index==1)
        bump_step       =   0.05;   % [mm]  Steps between acquisition points
        nb_step         =   round(bump_amp/bump_step);
        ramp            =   2;        
    elseif (index==2)
        bump_step       =   -nb_step*bump_step;   
        ramp            =   2*nb_step;
        nb_step         =   1;
    elseif (index==3)
        bump_step       =   -0.05;   % [mm]  Steps between acquisition points
        nb_step         =   abs(round(bump_amp/bump_step));
        ramp            =   2;  
    elseif(index==4)
        bump_step       =   -nb_step*bump_step;   
        ramp            =   2*nb_step;
        nb_step         =   1;
    end
    
    
for j=1:nb_step
    
    % Make bump
    setorbitbump('BPMz',bump_bpms,[bump_step;bump_step],'VCOR',[-2 -1 1 2],1,'Incremental','RampSteps',ramp);
          
    % Wait for the orbit
    pause(1);
    
    % Wait for XBPM response to stabilize
    pause(tempo_xbpm);
    
    % Read ATX XBPM blade currents
    clear temp
    temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IaSA');
    data.Ia(i)          =   temp.value;
    clear temp
    temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IbSA');
    data.Ib(i)          =   temp.value;
    clear temp
    temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IcSA');
    data.Ic(i)          =   temp.value;
    clear temp
    temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IdSA');
    data.Id(i)          =   temp.value;    
    data.Isum(i)        =   data.Ia(i)+data.Ib(i)+data.Ic(i)+data.Id(i);
    
    % Read ATX Imager image
    if (nb_diags==2)
    clear temp
    temp                    =   tango_read_attributes2(device_ccd_img,{'exposureTime'});
    data.img_TpsPose(i)     =   temp(1).value(1);
    clear temp
    temp                    =   tango_read_attributes2(device_ccd_img,{'image'});
    data.img_image(i,:,:)   =   temp(1).value';
    data.img_Itot(i)        =   squeeze(squeeze(sum(sum(data.img_image(i,:,:),2),3)));
    clear temp
    temp                    =   tango_read_attributes2(device_MT_Tz,{'Insere'})
    data.img_pos_MT_Tz(i)   =   temp(1).value(1);
    %
    data.img_image_m(i,:,:) =   squeeze(data.img_image(i,:,:)).*mask;
    data.img_Itot_m(i)      =   squeeze(squeeze(sum(sum(data.img_image_m(i,:,:),3),2)));
    end
    
    % Read machine current
    clear temp
    temp                =   tango_read_attribute('ans/dg/current_interlock_ctrl','current');
    data.current(i)     =   temp.value;
    
    % Read BPM infos about orbit in ATX
    clear temp    
    temp                =   tango_read_attribute('ans-c13/dg/bpm.1','ZPosSA');
    data.Zposbpm1(i)    =   temp.value;
    clear temp
    temp                =   tango_read_attribute('ans-c13/dg/bpm.8','ZPosSA');
    data.Zposbpm8(i)    =   temp.value;
    clear temp
    temp                =   tango_read_attribute('ans-c13/dg/bpm.1','XPosSA');
    data.Xposbpm1(i)    =   temp.value;
    clear temp
    temp                =   tango_read_attribute('ans-c13/dg/bpm.8','XPosSA');
    data.Xposbpm8(i)    =   temp.value;
    clear temp
    temp                        =   tango_read_attribute('TDL-I13-LT/DG/CALC-XBPM-PROJ','positionX_at_XBPM');
    data.atx_XposXBPMproj(i)    =   temp.value;
    clear temp
    temp                        =   tango_read_attribute('TDL-I13-LT/DG/CALC-XBPM-PROJ','positionZ_at_XBPM');
    data.atx_ZposXBPMproj(i)    =   temp.value;
    
    % Read absorber position
    clear temp
    temp                        =   tango_read_attribute('ANS-C13/VI/ABS.1','Absorbeur_EN');
    data.ABS(i)                 =   temp.value; % 0 = HORS / 1 = EN
    if (data.ABS(i)==0)
        fprintf('ATTENTION : ABSORBEUR HORS !!!!!!!!!!!!!!!!!!! \n')
    end

    % Plot current results
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    h1=figure(1);clf;
    x_lim   =   [-1;1];
    
    %
    subplot(2,2,1)
    plot(data.Zposbpm1,data.Ia./data.current*1e6,'or','MarkerFaceColor','r');hold on;
    plot(data_ref.data.Zposbpm1,data_ref.data.Ia./data_ref.data.current*1e6,'or');hold on;
    plot(data.Zposbpm1,data.Ib./data.current*1e6,'ob','MarkerFaceColor','b');hold on;
    plot(data.Zposbpm1,data.Ic./data.current*1e6,'og','MarkerFaceColor','g');hold on;
    plot(data.Zposbpm1,data.Id./data.current*1e6,'ok','MarkerFaceColor','k');hold on;
    plot(data_ref.data.Zposbpm1,data_ref.data.Ib./data_ref.data.current*1e6,'ob');hold on;
    plot(data_ref.data.Zposbpm1,data_ref.data.Ic./data_ref.data.current*1e6,'og');hold on;
    plot(data_ref.data.Zposbpm1,data_ref.data.Id./data_ref.data.current*1e6,'ok');hold on;
    hold off;
    grid on;
    xlim(x_lim)
    set(gca,'fontsize',8)
    legend('Now data','Ref. data','Location','Best')
    xlabel('Bump in ATX [mm]')
    ylabel('Blade currents norm. to current [-]')
    %
    subplot(2,2,2)
    plot(data.Zposbpm1,data.Isum./data.current*1e6,'bo','MarkerFaceColor','b');hold on;
    plot(data_ref.data.Zposbpm1,data_ref.data.Isum./data_ref.data.current*1e6,'bo');hold on;
    if (nb_diags==2)    
    plot(data.Zposbpm1,data.img_Itot./data.current*1e-8,'^r','MarkerFaceColor','r');hold on;
    plot(data_ref.data.Zposbpm1,data_ref.data.img_Itot./data_ref.data.current*1e-8,'^r');hold on;
    end
    hold off;
    grid on;
    xlim(x_lim)    
    set(gca,'fontsize',8)
    if (nb_diags==2)
        legend('xbpm - now data','xbpm - ref data','imager - now data','imager - ref data','Location','Best')
        ylabel('Total signal norm. to current [-]')
    else
        legend('xbpm - now data','xbpm - ref data','Location','Best')
        ylabel('Total blade currents norm. to current [-]')
    end
    xlabel('Bump in ATX [mm]')
    %
    subplot(2,2,3)
    plot(data.Zposbpm1,(data.Ia-data.Ia(1))./data.Ia(1).*100,'or','MarkerFaceColor','r');hold on;
    plot(data.Zposbpm1,(data.Ib-data.Ib(1))./data.Ib(1).*100,'ob','MarkerFaceColor','b');hold on;
    plot(data.Zposbpm1,(data.Ic-data.Ic(1))./data.Ic(1).*100,'og','MarkerFaceColor','g');hold on;
    plot(data.Zposbpm1,(data.Id-data.Id(1))./data.Id(1).*100,'ok','MarkerFaceColor','k');hold on;
    hold off;
    grid on;
    xlim(x_lim)    
    ylim([-100;100])
    set(gca,'fontsize',8)
    legend('A','B','C','D','Location','Best')
    xlabel('Bump in ATX [mm]')
    ylabel('Blade currents variation [%]')
    %
    subplot(2,2,4)
    plot(data.Zposbpm1,(data.Isum-data.Isum(1))./data.Isum(1).*100,'ob','MarkerFaceColor','b');hold on;
    if (nb_diags==2)
%         plot(data.Zposbpm1,(data.img_Itot-data.img_Itot(end))./data.img_Itot(end).*100,'^k','MarkerFaceColor','k');hold on;
        plot(data.Zposbpm1,(data.img_Itot_m-data.img_Itot_m(end))./data.img_Itot_m(end).*100,'^r','MarkerFaceColor','r');hold on;
    end
    hold off;
    grid on;
    xlim(x_lim)    
    ylim([-35;10])
    set(gca,'fontsize',8)
    if (nb_diags==2)
        legend('XBPM','Imager','Location','Best')        
    else
        legend('XBPM','Location','Best')
    end
    xlabel('Bump in ATX [mm]')
    ylabel('Total signal variation [%]')    
        
    i   =   i+1;
end
end

% Save data
data_filename           =   strcat(dir_name,'/',appendtimestamp('XBPM_ATX_response_vs_bumpsV_atx'));
save(data_filename,'data');

% Save image to data directory
image_filename          =   strcat(dir_name,'/',appendtimestamp('XBPM_ATX_response_vs_bumpsV_atx'));
image_filename          =   strcat(image_filename,'.jpeg');
saveas(h1,image_filename);

% Save image to elog directory
dir_name                =   uigetdir('/home/data/FC/Elog/Photo Elog/');
image_filename          =   strcat(dir_name,'/',appendtimestamp('XBPM_ATX_response_vs_bumpsV_atx'));
image_filename          =   strcat(image_filename,'.jpeg');
saveas(h1,image_filename);

% Check that seuils d'interlock remis
user_entry = input('Les seuils d interlock BPM sont_ils remis à 0.5/0.3 mm ? (y/n) \n', 's')
Cy=strcmp(user_entry,'y');
while(Cy==0)
    user_entry = input('Les seuils d interlock BPM sont_ils remis à 0.5/0.3 ? (y/n) \n', 's')
    Cy=strcmp(user_entry,'y');
end

% Send back IDs to nominal gaps
tango_write_attribute2(devID_atx,'gap', 17.1);    
pause(1);
tango_write_attribute2(devID_nano,'gap', 17.1);
pause(1);

% End of the measurement
fprintf('End of the measurements. \n');