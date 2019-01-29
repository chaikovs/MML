%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Calibrations des tables K et offset d'XBPM vs gap
%                   Groupe diagnostics - mai 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function xbpm_calibrate_vs_gap_with_MOT(xbpm_param)


XBPM_config         =   xbpm_config(xbpm_param);
XBPM_config.output  =   xbpm_param.output;
Param.ID_type       =   XBPM_config.ID_type;
XBPM_config


% Check that operator is ready
choice          =   questdlg('Launch XBPM calibration vs gap ?', ...
 'XBPM calibration', ...
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
 'XBPM calibration', ...
 'YES','NO','NO');
    % Handle response
switch choice
    case 'YES'
        disp([choice ' ->> mesurement launched...  '])
        choice_opt  = 1;  
    case 'NO'
        disp([choice ' ->> Abort.  '])
        choice_opt  = 2;
       return
end

% Check device XBPM mode 
clear temp
XBPM_config.devXbpm_base
temp                    =   tango_read_attribute2(XBPM_config.devXbpm_base,'computationMode')
mode_xbpm               =   temp.quality_str

if (mode_xbpm>=0) 
   % Check machine status
choice          =   questdlg('XBPM device not set in mode 0. Change mode ?', ...
 'XBPM test calibration', ...
 'YES','NO','NO');
    % Handle response
switch choice
    case 'YES'
        disp([choice ' ->> Mode changing...  '])
        choice_opt  = 1;                          
    % Initialize both XBPMs tp take into account new tables
    tango_command_inout2(XBPM_config.devXbpm_base,'Stop');
    %
    pause(4);
    tango_write_attribute2(XBPM_config.devXbpm_base,'computationMode',uint16(0));
    %
    pause(2)
    tango_command_inout2(XBPM_config.devXbpm_base,'Init');
    %
    pause(2);
    disp([choice ' ->> Mode XBPM changed.  '])
    %    
    case 'NO'
        disp([choice ' ->> Measurement aborted...  '])
        choice_opt  = 2;
       return
end 
end


% Output files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Directory and file names for intermediate files 
if (XBPM_config.rep==0)
    rep_4_files_name            =   strcat('/home/data/DG/XBPM/XBPMs-TDL/TDL-I',XBPM_config.cell,'-',XBPM_config.section,'_DG_XBPM.',num2str(xbpm_param.xbpm_nb),'/');
elseif (XBPM_config.rep==1)
    rep_4_files_name            =   uigetdir('/home/data/');
end

    % Directory and file names for final tables
rep_4_tables_name               =   strcat('/usr/Local/configFiles/DIAG/XBPM/TDL-I',XBPM_config.cell,'-',XBPM_config.section,'_DG_XBPM.',num2str(xbpm_param.xbpm_nb),'/');
if (XBPM_config.output==0)  % Replace existing files (with a backup of the previous version)
    filename_table_offset       =   strcat(rep_4_tables_name,'TDL-I',XBPM_config.cell,'-',XBPM_config.section,'-XBPM',num2str(XBPM_config.xbpm_nb),'-Offset_Table.txt');
    filename_table_K            =   strcat(rep_4_tables_name,'TDL-I',XBPM_config.cell,'-',XBPM_config.section,'-XBPM',num2str(XBPM_config.xbpm_nb),'-K_Table.txt');
    copyfile(filename_table_offset,strcat(rep_4_tables_name,'TDL-I',XBPM_config.cell,'-',XBPM_config.section,'-XBPM',num2str(XBPM_config.xbpm_nb),'-Offset_Table_Backup_',appendtimestamp(''),'.txt'));
    copyfile(filename_table_K,strcat(rep_4_tables_name,'TDL-I',XBPM_config.cell,'-',XBPM_config.section,'-XBPM',num2str(XBPM_config.xbpm_nb),'-K_Table_Backup_',appendtimestamp(''),'.txt'));
    delete(filename_table_offset,filename_table_K);
elseif (XBPM_config.output==1) % Do not replace existing files
    filename_table_offset       =   strcat(rep_4_tables_name,'TDL-I',XBPM_config.cell,'-',XBPM_config.section,'-XBPM',num2str(XBPM_config.xbpm_nb),'-Offset_Table_',appendtimestamp(''),'.txt');
    filename_table_K            =   strcat(rep_4_tables_name,'TDL-I',XBPM_config.cell,'-',XBPM_config.section,'-XBPM',num2str(XBPM_config.xbpm_nb),'-K_Table_',appendtimestamp(''),'.txt');
end


% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        

% Set undulator at minimum gap
gtol                    =   0.05;
tango_write_attribute2(XBPM_config.devID,'gap', XBPM_config.gap_min);
attr_val_list_ID        =   tango_read_attributes2(XBPM_config.devID,XBPM_config.attr_list_ID);
gap_read                =   attr_val_list_ID.value(1);
fprintf('Waiting undulator arrival...\n');
while(abs(gap_read-XBPM_config.gap_min)>gtol)
    attr_val_list_ID    =   tango_read_attributes2(XBPM_config.devID,XBPM_config.attr_list_ID);
    gap_read            =   attr_val_list_ID.value(1);
    pause(1);   
end
fprintf('Undulator arrived at gap min:\n');
gap_read                =   attr_val_list_ID.value(1)

% Check xbpm motor device state
attr_val_list_motXBPM   =   tango_read_attributes2(XBPM_config.devXbpm_mx,XBPM_config.attr_list_motXBPM(2));
state_mot               =   attr_val_list_motXBPM.quality_str

% Check XBPM device
attr_val_list_XBPM      =   tango_read_attributes2(XBPM_config.devXbpm,XBPM_config.attr_list_XBPM(7));
state_xbpm              =   attr_val_list_XBPM.quality_str

% Check that XBPM is centred
choice          =   questdlg('Is XBPM centered at gap min ?', ...
 'XBPM calibration', ...
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


% Record position of centred XBPM
fprintf('Reference position of XBPM is :\n');
attr_val_list_motXBPM   =   tango_read_attributes2(XBPM_config.devXbpm_mx,XBPM_config.attr_list_motXBPM(1));
Pos_refx                =   attr_val_list_motXBPM.value(1)
attr_val_list_motXBPM   =   tango_read_attributes2(XBPM_config.devXbpm_mz,XBPM_config.attr_list_motXBPM(1));
Pos_refz                =   attr_val_list_motXBPM.value(1)

% Acquisition loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ngg                     =   length(XBPM_config.gap_scan);

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
pause(10);
    
% Calibrate H plane
axe                     =   'X';
Param.axe               =   axe;
    % Launch data acquisition for calibration
filename_data           =   xbpm_Calib_Acquisition_Vs_Mot(XBPM_config.devXbpm_mx,XBPM_config.devXbpm,gap_read,rep_4_files_name);
    % Calculate calibration coefficients
coefs_X                 =   [0 0];
coefs_X                 =   xbpm_Calib_Calculation(filename_data,Param);

% Calibrate V plane
axe                     =   'Z';
Param.axe               =   axe;
    % Launch data acquisition for calibration
filename_data           =   xbpm_Calib_Acquisition_Vs_Mot(XBPM_config.devXbpm_mz,XBPM_config.devXbpm,gap_read,rep_4_files_name);
    % Calculate calibration coefficients
coefs_Z                 =   [0 0];
coefs_Z                 =   xbpm_Calib_Calculation(filename_data,Param);

% Store data
Data_xbpm_K(gg,:)       =   [gap_read,coefs_X(1),coefs_Z(1)];
Data_xbpm_offset(gg,:)  =   [gap_read,-coefs_X(2),coefs_Z(2)];

end

% End acquisition loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tango_giveInformationMessage(strcat('Fin de Calibration X.B.P.M ', xbpm_param.ID));

% Put back the undulator at gap min
tango_write_attribute2(XBPM_config.devID,'gap', XBPM_config.gap_min);

% Write table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nb_cols                 =   3;
nb_lines                =   length(Data_xbpm_K);
    % K table  
dlmwrite(filename_table_K,nb_cols,'-append','delimiter',' ');
dlmwrite(filename_table_K,nb_lines,'-append','delimiter',' ');
dlmwrite(filename_table_K,'GAP	KX	KZ','-append','delimiter','');
dlmwrite(filename_table_K,Data_xbpm_K,'-append','delimiter',' ');
    % Offset table
dlmwrite(filename_table_offset,nb_cols,'-append','delimiter',' ');
dlmwrite(filename_table_offset,nb_lines,'-append','delimiter',' ');
dlmwrite(filename_table_offset,'ENERGY	OFFSETX OFFSETZ','-append','delimiter','');
dlmwrite(filename_table_offset,Data_xbpm_offset,'-append','delimiter',' ');

% End of the calibration vs gap
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Close Figures
choice          =   questdlg('Calibration finished. Close calibration intermediate figures ?', ...
 'XBPM calibration', ...
 'YES','NO','NO');
    % Handle response
switch choice
    case 'YES'
        close(101)
        close(201)
        close(202)
    case 'NO'        
       return
end

% Initialize devices to take new tables into account
choice          =   questdlg('Initialize XBPM devices to take new tables into account ?', ...
 'XBPM calibration', ...
 'YES','NO','NO');
    % Handle response
switch choice
    case 'YES'
        disp([choice ' ->> initialization launched...  '])
        choice_opt  = 1;  
        tango_command_inout2(XBPM_config.devXbpm_base,'Stop');        
        %
        pause(3);
        tango_command_inout2(XBPM_config.devXbpm_base,'Init');
        pause(2);
    case 'NO'
        disp([choice ' ->> initialization aborted...  '])
        choice_opt  = 2;
       return
end



