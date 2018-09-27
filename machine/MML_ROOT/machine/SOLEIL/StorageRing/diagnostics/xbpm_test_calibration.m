%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test XBPM (U20/U24) calibration tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This function scans the ID gap and records the XBPM signal vs gap
% This function uses the XBPM.base mode set in the device
% This function records in a text file the XBPM and gap data in XXX
% This function plots the XBPM position recorded versus gap in both planes

function xbpm_test_calibration(xbpm_param)

% Load ID and XBPM configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
XBPM_config         =   xbpm_config(xbpm_param)

% Output files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (XBPM_config.rep==0)
    rep_name            =   strcat('/home/data/DG/XBPM/XBPMs-TDL/TDL-I',XBPM_config.cell,'-',XBPM_config.section,'_DG_XBPM.1/');
elseif (XBPM_config.rep==1)
    rep_name            =   uigetdir('/home/data/');
end
    
filename_data       =   strcat(rep_name,'TDL-I',XBPM_config.cell,'-',XBPM_config.section,'-Test-Calib-',XBPM_config.comment,appendtimestamp(''),'.txt');
filename_image      =   strcat(rep_name,'TDL-I',XBPM_config.cell,'-',XBPM_config.section,'-Test-Calib-',XBPM_config.comment,appendtimestamp(''),'.jpg');

% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
% Check that operator is ready
choice          =   questdlg('Launch test of XBPM calibration tables ?', ...
 'XBPM offset correction', ...
 'YES','NO','NO');
    % Handle response
switch choice
    case 'YES'
        disp([choice ' ->> mesurement launched...  '])
        choice_opt  = 1;  
    case 'NO'
        disp([choice ' ->> measurement aborted...  '])
        choice_opt  = 2;
       return
end

% Check machine status
choice          =   questdlg('Are SOFB and FOFB on ?', ...
 'XBPM offset correction', ...
 'YES','NO','NO');
    % Handle response
switch choice
    case 'YES'
        disp([choice ' ->> mesurement launched...  '])
        choice_opt  = 1;  
    case 'NO'
        disp([choice ' ->> measurement aborted...  '])
        choice_opt  = 2;
       return
end

% Check XBPM device
XBPM_config.devXbpm1        =   ['TDL-I',XBPM_config.cell,'-',XBPM_config.section,'/DG/XBPM.1'];
XBPM_config.devXbpm2        =   ['TDL-I',XBPM_config.cell,'-',XBPM_config.section,'/DG/XBPM.2'];
XBPM_config.devXbpm1_base   =   ['TDL-I',XBPM_config.cell,'-',XBPM_config.section,'/DG/XBPM.1-base'];
XBPM_config.devXbpm2_base   =   ['TDL-I',XBPM_config.cell,'-',XBPM_config.section,'/DG/XBPM.2-base'];

attr_val_list_XBPM1     =   tango_read_attributes2(XBPM_config.devXbpm1,XBPM_config.attr_list_XBPM(7));
state_xbpm1             =   attr_val_list_XBPM1.quality_str
attr_val_list_XBPM2     =   tango_read_attributes2(XBPM_config.devXbpm2,XBPM_config.attr_list_XBPM(7));
state_xbpm2             =   attr_val_list_XBPM2.quality_str
clear temp
temp                    =   tango_read_attribute2(XBPM_config.devXbpm1_base,'computationMode');
mode_xbpm1              =   temp.quality_str;
clear temp
temp                    =   tango_read_attribute2(XBPM_config.devXbpm2_base,'computationMode');
mode_xbpm2              =   temp.quality_str;
if (mode_xbpm1>=0) 
   % Check machine status
choice          =   questdlg('XBPM.1 device not set in mode 0. Change mode ?', ...
 'XBPM test calibration', ...
 'YES','NO','NO');
    % Handle response
switch choice
    case 'YES'
        disp([choice ' ->> Mode changing...  '])
        choice_opt  = 1;                          
    % Initialize both XBPMs tp take into account new tables
    tango_command_inout2(XBPM_config.devXbpm1_base,'Stop');
    %
    pause(2);
    tango_write_attribute2(XBPM_config.devXbpm1_base,'computationMode',uint16(0));
    %
    pause(2)
    tango_command_inout2(XBPM_config.devXbpm1_base,'Init');
    %
    pause(2);
    disp([choice ' ->> Mode XBPM.1 changed.  '])
    %    
    case 'NO'
        disp([choice ' ->> Measurement aborted...  '])
        choice_opt  = 2;
       return
end 
end

if (mode_xbpm2>=0) 
   % Check machine status
choice          =   questdlg('XBPM.2 device not set in mode 0. Change mode ?', ...
 'XBPM test calibration', ...
 'YES','NO','NO');
    % Handle response
switch choice
    case 'YES'
        disp([choice ' ->> Mode changing...  '])
        choice_opt  = 1;                          
    % Initialize both XBPMs tp take into account new tables
    tango_command_inout2(XBPM_config.devXbpm2_base,'Stop');
    %
    pause(2);
    tango_write_attribute2(XBPM_config.devXbpm2_base,'computationMode',uint16(0));
    %
    pause(2)
    tango_command_inout2(XBPM_config.devXbpm2_base,'Init');
    %
    pause(2);
    disp([choice ' ->> Mode XBPM.2 changed.  '])
    %    
    case 'NO'
        disp([choice ' ->> Measurement aborted...  '])
        choice_opt  = 2;
       return
end 
end

% Acquisition loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ngg                     =   length(XBPM_config.gap_scan);
gtol                  	=   0.05;
sleep_xbpm              =   1;


for gg=1:Ngg
    
% Moove undulator to gap_temp
gap_temp                =   XBPM_config.gap_scan(gg);
tango_write_attribute2(XBPM_config.devID,'gap', gap_temp);
fprintf('Waiting undulator arrival...\n');

% Check that undulator is arrived
attr_val_list_ID        =   tango_read_attributes2(XBPM_config.devID,XBPM_config.attr_list_ID);
gap_read                =   attr_val_list_ID.value(1);
while(abs(gap_read-gap_temp)>gtol)
    attr_val_list_ID    =   tango_read_attributes2(XBPM_config.devID,XBPM_config.attr_list_ID);
    gap_read            =   attr_val_list_ID.value(1);
    pause(0.5);
end
fprintf('Undulator arrived at:\n');
gap_read                =   attr_val_list_ID.value(1)
pause(5);
    
% Read XBPM position
pause(sleep_xbpm);    
attr_val_list_XBPM      =   tango_read_attributes2(XBPM_config.devXbpm1,XBPM_config.attr_list_XBPM);
xPos_xbpm1              =   attr_val_list_XBPM(5).value;          % [mm]
zPos_xbpm1              =   attr_val_list_XBPM(6).value;          % [mm]   
attr_val_list_XBPM      =   tango_read_attributes2(XBPM_config.devXbpm2,XBPM_config.attr_list_XBPM);
xPos_xbpm2              =   attr_val_list_XBPM(5).value;          % [mm]
zPos_xbpm2              =   attr_val_list_XBPM(6).value;          % [mm]   

% Store data
Data_xbpm               =   [gap_temp,xPos_xbpm1,zPos_xbpm1,xPos_xbpm2,zPos_xbpm2];
dlmwrite(filename_data,Data_xbpm,'-append','delimiter',' ');

    % Plot current results
Data_xbpmR              =   dlmread(filename_data); 

h101 = figure(101);
subplot(2,1,1)
plot(Data_xbpmR(:,1), Data_xbpmR(:,2),'-.r*');
hold on;
plot(Data_xbpmR(:,1), Data_xbpmR(:,3),'-.b*');
hold off;
title(strcat('XBPM 1 - ',XBPM_config.name))
legend('X','Z');
ylabel('Position [mm]');
xlabel('Gap [mm]');
subplot(2,1,2)
plot(Data_xbpmR(:,1), Data_xbpmR(:,4),'-.r*');
hold on;
plot(Data_xbpmR(:,1), Data_xbpmR(:,5),'-.b*');
hold off;
title(strcat('XBPM 2 - ',XBPM_config.name))
legend('X','Z');
ylabel('Position [mm]');
xlabel('Gap [mm]');

end

saveas(h101,filename_image,'jpg');
tango_giveInformationMessage(strcat('Fin de mesure Test Calibration X.B.P.M ', xbpm_param.ID));

% End acquisition loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Moove back undulator to gap min
gap_temp                =   XBPM_config.gap_scan(1);
tango_write_attribute2(XBPM_config.devID,'gap', gap_temp);
fprintf('Waiting undulator arrival...\n');

% Check that undulator is arrived
attr_val_list_ID        =   tango_read_attributes2(XBPM_config.devID,XBPM_config.attr_list_ID);
gap_read                =   attr_val_list_ID.value(1);
while(abs(gap_read-gap_temp)>gtol)
    attr_val_list_ID    =   tango_read_attributes2(XBPM_config.devID,XBPM_config.attr_list_ID);
    gap_read            =   attr_val_list_ID.value(1);
    pause(0.5);
end
fprintf('Undulator back at:\n');
gap_read                =   attr_val_list_ID.value(1)
pause(5);

fprintf('End of calibration test \n')