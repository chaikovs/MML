%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Measure atx xbpm response vs offset nanoscopium
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

% Define atx gap for operation
gap_atx         =   5.5;

% Define nano gap for operation
gap_nano        =   5.5;

% Define nano offsets to scan
offset_nano     =   [-0.400 : 0.05 : 1.1] ; % [mm]

% Define devices of interest
devID_nano      =   'ans-c13/ei/l-u18.1';
devID_atx       =   'ans-c13/ei/l-u20.2';
attr_list_ID    =   {'gap'};

% Read initial offset
clear temp
temp                =   tango_read_attribute(devID_nano,'offset');
offset_nano_init    =   temp.value;
fprintf('Initial offset of nano : %f mm \n',offset_nano_init)

% Define tolerance for gap positionning
gtol            =   0.001;

% Define tolerance for offset positionning
gtol_offset     =   0.0005;

% Define time to wait for XBPM response to stabilize
tempo_xbpm      =   3;

% Load reference data
dir_name        =   '/home/data/matlab/data4mml/measdata/SOLEIL/StorageRingdata/SDL13/';   
data_ref        =   load(strcat(dir_name,'160418-Blades-current-vs-offset-nano-NANO-5p5mm-ATX-5p5mm-ABS-EN.mat'));

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

% Scan NANO offset
for i=1:length(offset_nano)
    
    % Send NANO to current offset value
    tango_command_inout2(devID_nano,'GotoOffset',offset_nano(i));
    clear temp
    temp                =   tango_read_attribute(devID_nano,'offset');
    offset_read         =   temp.value;
    fprintf('Waiting NANO offset arrival...\n');
    while(abs(offset_read-offset_nano(i))>gtol_offset)
        clear temp
        temp                =   tango_read_attribute(devID_nano,'offset');
        offset_read         =   temp.value;
        pause(1);
    end
    fprintf('NANO offset arrived at offset: %f \n',offset_read);
    data.offset_nano(i)     =   offset_read;
    
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
    plot(data.offset_nano,data.Ia./data.current*1e6,'*r');hold on;
    plot(data_ref.data.offset_U18,data_ref.data.Ia./data_ref.data.current*1e6,'or');hold on;
    plot(data.offset_nano,data.Ib./data.current*1e6,'*b');hold on;
    plot(data.offset_nano,data.Ic./data.current*1e6,'*g');hold on;
    plot(data.offset_nano,data.Id./data.current*1e6,'*k');hold on;
    plot(data_ref.data.offset_U18,data_ref.data.Ib./data_ref.data.current*1e6,'ob');hold on;
    plot(data_ref.data.offset_U18,data_ref.data.Ic./data_ref.data.current*1e6,'og');hold on;
    plot(data_ref.data.offset_U18,data_ref.data.Id./data_ref.data.current*1e6,'ok');hold on;
        hold off;
    grid on;
    set(gca,'fontsize',10)
    legend('Current data','Ref. data','Location','Best')
    set(gca,'fontsize',16)  
    xlabel('Offset Nano [mm]')
    ylabel('Normalized blades current [-]')
    %
    subplot(1,2,2)
    plot(data.offset_nano,data.Isum./data.current*1e6,'b*');hold on;
    plot(data_ref.data.offset_U18,data_ref.data.Isum./data_ref.data.current*1e6,'bo');hold on;
    hold off;
    grid on;
    set(gca,'fontsize',10)
    legend('Current data','Ref. data','Location','Best')
    set(gca,'fontsize',16)  
    xlabel('Offset Nano [mm]')
    ylabel('Total normalized blades current [-]')

end

tango_command_inout2(devID_nano,'GotoOffset',offset_nano_init);

% Save data
data_filename           =   strcat(dir_name,'/',appendtimestamp('XBPM_ATX_response_vs_NANO_offset'));
save(data_filename,'data');

% Save image to data directory
image_filename          =   strcat(dir_name,'/',appendtimestamp('XBPM_ATX_response_vs_NANO_offset'));
image_filename          =   strcat(image_filename,'.jpeg');
saveas(h1,image_filename);

% Save image to elog directory
dir_name                =   uigetdir('/home/data/FC/Elog/Photo Elog/');
image_filename          =   strcat(dir_name,'/',appendtimestamp('XBPM_ATX_response_vs_NANO_offset'));
image_filename          =   strcat(image_filename,'.jpeg');
saveas(h1,image_filename);

% End of the measurement
fprintf('Fin de la mesure et des enregistrements. \n');

