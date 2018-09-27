%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Measure xbpm response reference (ID closed + ABS EN)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

% Define devices of interest
devID_nano      =   'ans-c13/ei/l-u18.1';
devID_atx       =   'ans-c13/ei/l-u20.2';

% Check that operator is ready
choice          =   questdlg('Launch acquisition of reference data ?', ...
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

% Check that ABSORBER sdl13 is EN
clear temp
temp                        =   tango_read_attribute('ANS-C13/VI/ABS.1','Absorbeur_EN');
if (temp.value==0)
    errordlg('ABSORBER is HORS. Please insert ABSORBER before proceeding.','File Error') 
    break
end
fprintf('ABSORBER is EN.\n');
    
% % Check current is between 5 and 6 mA
% clear temp
% temp                =   tango_read_attribute('ans/dg/current_interlock_ctrl','current');
% if (temp.value < 5)
%     errordlg('Current is below 5 mA. Store between 5 and 6 mA.','File Error') 
%     break
% elseif (temp.value > 6.5)
%     errordlg('Current is above 6 mA. Store between 5 and 6 mA.','File Error')
%     break
% end
% fprintf('Current is OK.\n');

% Check that SOFB is on
clear temp
temp                =   tango_read_attribute('ans/ca/service-locker','sofb');
if (temp.value == 0 )
    errordlg('Please start SOFB before launching measurement.','File Error') 
    break
end
fprintf('SOFB is ON.\n');

% Check that ATX gap is 5.5 mm
clear temp
temp                =   tango_read_attribute(devID_atx,'gap');
if (abs(temp.value-5.5) > 0.01 )
    %errordlg('Please set ATX gap to 5.5 mm.','File Error')
    ButtonName = questdlg('Please set ATX gap to 5.5 mm.','set Gap','Yes','No','No')
    switch ButtonName,
     case 'Yes',
         tango_write_attribute(devID_atx,'gap',5.5);
         pause(20)
     case 'No',   
        break
    end
    
end
fprintf('ATX gap is 5.5 mm.\n');

% Check that NANO gap is 5.5 mm
clear temp
temp                =   tango_read_attribute(devID_nano,'gap');
if (abs(temp.value-5.5) > 0.01 )
    %errordlg('Please set NANO gap to 5.5 mm.','File Error') 
    ButtonName = questdlg('Please set NANO gap to 5.5 mm.','set Gap','Yes','No','No')
    switch ButtonName,
     case 'Yes',
         tango_write_attribute(devID_atx,'gap',5.5);
         pause(20)
     case 'No',   
        break
    end
end
fprintf('NANO gap is 5.5 mm.\n');



%%%%%%%%%%%%%%%%%%%%%%%%%
if (choice_opt==1)
    
% Define time to wait for XBPM response to stabilize
tempo_xbpm          =   3;

% Read NANO offset
clear temp
temp                =   tango_read_attribute(devID_nano,'offset');
data.offset_nano    =   temp.value;    

% Wait for XBPM response to stabilize
pause(tempo_xbpm);

% Read ATX XBPM blade currents
clear temp
temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IaSA');
data.Ia_atx         =   temp.value;
clear temp
temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IbSA');
data.Ib_atx         =   temp.value;
clear temp
temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IcSA');
data.Ic_atx         =   temp.value;
clear temp
temp                =   tango_read_attribute('tdl-i13-lt/dg/xbpm_lib.1','IdSA');
data.Id_atx         =   temp.value;    
data.Isum_atx       =   data.Ia_atx+data.Ib_atx+data.Ic_atx+data.Id_atx;

% Read NANO XBPM blade currents
clear temp
temp                =   tango_read_attribute('tdl-i13-ln/dg/xbpm_lib.1','IaSA');
data.Ia_nano        =   temp.value;
clear temp
temp                =   tango_read_attribute('tdl-i13-ln/dg/xbpm_lib.1','IbSA');
data.Ib_nano        =   temp.value;
clear temp
temp                =   tango_read_attribute('tdl-i13-ln/dg/xbpm_lib.1','IcSA');
data.Ic_nano        =   temp.value;
clear temp
temp                =   tango_read_attribute('tdl-i13-ln/dg/xbpm_lib.1','IdSA');
data.Id_nano        =   temp.value;    
data.Isum_nano      =   data.Ia_atx+data.Ib_atx+data.Ic_atx+data.Id_atx;

% Read machine current
clear temp
temp                =   tango_read_attribute('ans/dg/current_interlock_ctrl','current');
data.current        =   temp.value;

% Read BPM infos about orbit in ATX
clear temp    
temp                =   tango_read_attribute('ans-c13/dg/bpm.1','ZPosSA');
data.Zposbpm1       =   temp.value;
clear temp
temp                =   tango_read_attribute('ans-c13/dg/bpm.8','ZPosSA');
data.Zposbpm8       =   temp.value;
clear temp
temp                =   tango_read_attribute('ans-c13/dg/bpm.1','XPosSA');
data.Xposbpm1       =   temp.value;
clear temp
temp                =   tango_read_attribute('ans-c13/dg/bpm.8','XPosSA');
data.Xposbpm8       =   temp.value;
clear temp
temp                        =   tango_read_attribute('TDL-I13-LT/DG/CALC-XBPM-PROJ','positionX_at_XBPM');
data.atx_XposXBPMproj       =   temp.value;
clear temp
temp                        =   tango_read_attribute('TDL-I13-LT/DG/CALC-XBPM-PROJ','positionZ_at_XBPM');
data.atx_ZposXBPMproj       =   temp.value;

% Read BPM infos about orbit in NANO
clear temp    
temp                =   tango_read_attribute('ans-c13/dg/bpm.9','ZPosSA');
data.Zposbpm9       =   temp.value;
clear temp
temp                =   tango_read_attribute('ans-c13/dg/bpm.2','ZPosSA');
data.Zposbpm2       =   temp.value;
clear temp
temp                =   tango_read_attribute('ans-c13/dg/bpm.9','XPosSA');
data.Xposbpm9       =   temp.value;
clear temp
temp                =   tango_read_attribute('ans-c13/dg/bpm.2','XPosSA');
data.Xposbpm2       =   temp.value;
clear temp
temp                        =   tango_read_attribute('tdl-i13-ln/dg/calc-xbpm-proj','positionX_at_XBPM');
data.nano_XposXBPMproj      =   temp.value;
clear temp
temp                        =   tango_read_attribute('tdl-i13-ln/dg/calc-xbpm-proj','positionZ_at_XBPM');
data.nano_ZposXBPMproj      =   temp.value;

% Read absorber position
clear temp
temp                        =   tango_read_attribute('ANS-C13/VI/ABS.1','Absorbeur_EN');
data.ABS                    =   temp.value; % 0 = HORS / 1 = EN

% Read time
clear temp
temp                        =   datestr(clock,2);
data.date                   =   temp;

% Save data
dir_name                    =   '/home/data/matlab/data4mml/measdata/SOLEIL/StorageRingdata/SDL13/';   
data_filename               =   strcat(dir_name,'/',appendtimestamp('XBPM_response_reference'));
save(data_filename,'data');

% End of the measurement
fprintf('End of measurements. \n');

elseif (choice_opt==2)
    fprintf('No measurement done. \n');
end


