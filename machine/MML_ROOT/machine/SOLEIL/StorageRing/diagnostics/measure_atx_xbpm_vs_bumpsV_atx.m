%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Measure atx xbpm response vs bump nanoscopium
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

% Define atx gap for operation
gap_atx         =   5.5;

% Define nano gap for operation
gap_nano        =   30;

% Define bumps in ATX to do
bump_amp        =   0.7;   % [mm]
bpm_amont       =   [13 1];
bpm_aval        =   [13 8];
bump_bpms       =   [bpm_amont;bpm_aval];
nb_phase        =   4;

% Define devices of interest
devID_nano      =   'ans-c13/ei/l-u18.1';
devID_atx       =   'ans-c13/ei/l-u20.2';
attr_list_ID    =   {'gap'};

% Define tolerance for gap positionning
gtol            =   0.001;

% Define time to wait for XBPM response to stabilize
tempo_xbpm      =   3;

% Load reference data
dir_name        =   '/home/data/matlab/data4mml/measdata/SOLEIL/StorageRingdata/SDL13/';   
data_ref        =   load(strcat(dir_name,'160418-Blades-current-vs-bumpsATX-ATX-5p5mm-ABS-EN.mat'));

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


% Check that feedback is OFF
user_entry = input('Are the SOFB and FOFB off ? (y/n) \n', 's')
Cy=strcmp(user_entry,'y');
while(Cy==0)
    user_entry = input('Are the SOFB and FOFB off ? (y/n) \n', 's')
    Cy=strcmp(user_entry,'y');
end

% Check that seuils d'interlock modifiés
user_entry = input('Les seuils d interlock BPM sont_ils passes à 0.8 mm ? (y/n) \n', 's')
Cy=strcmp(user_entry,'y');
while(Cy==0)
    user_entry = input('Les seuils d interlock BPM sont_ils passes à 0.8 mm ? (y/n) \n', 's')
    Cy=strcmp(user_entry,'y');
end

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
    %
    subplot(1,2,1)
    plot(data.Zposbpm1,data.Ia./data.current*1e6,'*r');hold on;
    plot(data_ref.data.Zposbpm1,data_ref.data.Ia./data_ref.data.current*1e6,'or');hold on;
    plot(data.Zposbpm1,data.Ib./data.current*1e6,'*b');hold on;
    plot(data.Zposbpm1,data.Ic./data.current*1e6,'*g');hold on;
    plot(data.Zposbpm1,data.Id./data.current*1e6,'*k');hold on;
    plot(data_ref.data.Zposbpm1,data_ref.data.Ib./data_ref.data.current*1e6,'ob');hold on;
    plot(data_ref.data.Zposbpm1,data_ref.data.Ic./data_ref.data.current*1e6,'og');hold on;
    plot(data_ref.data.Zposbpm1,data_ref.data.Id./data_ref.data.current*1e6,'ok');hold on;
        hold off;
    grid on;
    set(gca,'fontsize',10)
    legend('Current data','Ref. data','Location','Best')
    set(gca,'fontsize',16)  
    xlabel('Bump in ATX [mm]')
    ylabel('Normalized blades current [-]')
    %
    subplot(1,2,2)
    plot(data.Zposbpm1,data.Isum./data.current*1e6,'b*');hold on;
    plot(data_ref.data.Zposbpm1,data_ref.data.Isum./data_ref.data.current*1e6,'bo');hold on;
    hold off;
    grid on;
    set(gca,'fontsize',10)
    legend('Current data','Ref. data','Location','Best')
    set(gca,'fontsize',16)  
    xlabel('Bump in ATX [mm]')
    ylabel('Total normalized blades current [-]')

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

% End of the measurement
fprintf('Fin de la mesure et des enregistrements. \n');

% Check that seuils d'interlock remis
user_entry = input('Les seuils d interlock BPM sont_ils remis à 0.5/0.3 mm ? (y/n) \n', 's')
Cy=strcmp(user_entry,'y');
while(Cy==0)
    user_entry = input('Les seuils d interlock BPM sont_ils remis à 0.5/0.3 ? (y/n) \n', 's')
    Cy=strcmp(user_entry,'y');
end
