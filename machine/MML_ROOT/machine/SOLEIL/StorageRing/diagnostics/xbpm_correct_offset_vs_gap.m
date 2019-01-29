%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Correction des tables d'offset XBPM
%                   Groupe diagnostics - mai 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function xbpm_correct_offset_vs_gap(xbpm_param)

XBPM_config                 =   xbpm_config(xbpm_param);
XBPM_config.devXbpm1        =   ['TDL-I',XBPM_config.cell,'-',XBPM_config.section,'/DG/XBPM.1'];
XBPM_config.devXbpm2        =   ['TDL-I',XBPM_config.cell,'-',XBPM_config.section,'/DG/XBPM.2'];
XBPM_config.devXbpm1_base   =   ['TDL-I',XBPM_config.cell,'-',XBPM_config.section,'/DG/XBPM.1-base'];
XBPM_config.devXbpm2_base   =   ['TDL-I',XBPM_config.cell,'-',XBPM_config.section,'/DG/XBPM.2-base'];

% Check that operator is ready
choice          =   questdlg('Launch XBPM offset correction vs gap ?', ...
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
clear temp
temp                    =   tango_read_attribute2(XBPM_config.devXbpm1_base,'computationMode');
mode_xbpm1              =   temp.quality_str;
clear temp
temp                    =   tango_read_attribute2(XBPM_config.devXbpm2_base,'computationMode');
mode_xbpm2              =   temp.quality_str;

if (mode_xbpm1>=0) 
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



% Correction settings
    % Nb of iterations
nb_cycles           =   xbpm_param.nb_it;
    % Define gaps
gap_value           =   XBPM_config.gap_scan;
Ngg                 =   length(gap_value);
    % Time to wait after gap arrival to read XBPM values
sleep_xbpm      =   5;

% Start iterate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h101 = figure(101);clf;
hold on;

for i_cycle=1:nb_cycles  

    % Start loop versus gap
    for i_gg=1:Ngg

        gap_temp                =   gap_value(i_gg);
        tango_write_attribute2(XBPM_config.devID,'gap', gap_temp);
        fprintf('Waiting undulator arrival...\n');

        % Check that undulator is arrived
        attr_val_list_ID        =   tango_read_attributes2(XBPM_config.devID,XBPM_config.attr_list_ID);
        gap_read                =   attr_val_list_ID.value(1);
        while(abs(gap_read-gap_temp)>XBPM_config.gtol)
        attr_val_list_ID        =   tango_read_attributes2(XBPM_config.devID,XBPM_config.attr_list_ID);
        gap_read                =   attr_val_list_ID.value(1);
        pause(0.5);
        end
        fprintf('Undulator arrived at:\n');
        gap_read                =   attr_val_list_ID.value(1)
        pause(3);
    
        % Read XBPM position
        pause(sleep_xbpm);    
        attr_val_list_XBPM      =   tango_read_attributes2(XBPM_config.devXbpm1,XBPM_config.attr_list_XBPM);
        xPos_xbpm1              =   attr_val_list_XBPM(5).value;          % [mm]
        zPos_xbpm1              =   attr_val_list_XBPM(6).value;          % [mm]   
        attr_val_list_XBPM      =   tango_read_attributes2(XBPM_config.devXbpm2,XBPM_config.attr_list_XBPM);
        xPos_xbpm2              =   attr_val_list_XBPM(5).value;          % [mm]
        zPos_xbpm2              =   attr_val_list_XBPM(6).value;          % [mm]   

        % Store data
        Data_xbpm(i_gg,:)       =   [gap_temp xPos_xbpm1 zPos_xbpm1 gap_temp xPos_xbpm2 zPos_xbpm2];
        
        % Plot current results
        %
        subplot(2,1,1)
        plot(Data_xbpm(:,1), Data_xbpm(:,2),'-.r*');
        hold on;
        plot(Data_xbpm(:,1), Data_xbpm(:,3),'-.b*');
        hold off;
        %set(gca,'Fontsize','14');
        title('XBPM 1');
        legend('X','Z');
        ylabel('Position [mm]');
        xlabel('Gap [mm]');
        %
        subplot(2,1,2)
        plot(Data_xbpm(:,4), Data_xbpm(:,5),'-.r*');
        hold on;
        plot(Data_xbpm(:,4), Data_xbpm(:,6),'-.b*');
        hold off;
        %set(gca,'Fontsize','14');
        title('XBPM 2');
        legend('X','Z');
        ylabel('Position [mm]');
        xlabel('Gap [mm]');
    
    end

    for i_xbpm=1:2
        % Rename previous offset tables        
        table_name                      =   strcat('TDL-I',XBPM_config.cell,'-',XBPM_config.section,'-XBPM',num2str(i_xbpm),'-Offset_Table.txt');
        rep_name{i_xbpm}                =   strcat('TDL-I',XBPM_config.cell,'-',XBPM_config.section,'_DG_XBPM.',num2str(i_xbpm),'/');
        table_name_old{i_xbpm}          =   strcat(XBPM_config.config_files_path,rep_name{i_xbpm},table_name ,'_it',num2str(i_cycle-1));
        table_name_new{i_xbpm}          =   strcat(XBPM_config.config_files_path,rep_name{i_xbpm},table_name );
        table_name_backup{i_xbpm}       =   strcat(XBPM_config.config_files_path,rep_name{i_xbpm},'TDL-I',XBPM_config.cell,'-',XBPM_config.section,'-XBPM',num2str(i_xbpm),'-Offset_Table_Backup_',appendtimestamp(''),'.txt');
        if (i_cycle==1) copyfile(table_name_new{i_xbpm},table_name_backup{i_xbpm}); end
        movefile(table_name_new{i_xbpm},table_name_old{i_xbpm});

    % Compute new offset values
    fid{i_xbpm}     =   fopen(table_name_old{i_xbpm});
    dummy           =   textscan(fid{i_xbpm},'%s',1,'delimiter','\n');
    nb_cols         =   str2num(char(dummy{1}));
    dummy           =   textscan(fid{i_xbpm},'%s',1,'delimiter','\n');
    nb_lines        =   str2num(char(dummy{1}));
    names           =   textscan(fid{i_xbpm},'%s',1,'delimiter','\n');    
    data_old        =   fscanf(fid{i_xbpm},'%g %g %g \n',[3 nb_lines]);
    data_new        =   data_old';
    if(i_xbpm==1)
    data_new(:,2)   =   data_old(2,:)'-Data_xbpm(:,2);
    data_new(:,3)   =   data_old(3,:)'-Data_xbpm(:,3);
    elseif(i_xbpm==2)
    data_new(:,2)   =   data_old(2,:)'-Data_xbpm(:,5);
    data_new(:,3)   =   data_old(3,:)'-Data_xbpm(:,6);
    end
    fclose(fid{i_xbpm});
    
    % Write new offset tables
    dlmwrite(table_name_new{i_xbpm},nb_cols,'-append','delimiter',' ')
    dlmwrite(table_name_new{i_xbpm},nb_lines,'-append','delimiter',' ');
    dlmwrite(table_name_new{i_xbpm},'ENERGY	OFFSETX OFFSETZ','-append','delimiter','');
    dlmwrite(table_name_new{i_xbpm},data_new,'-append','delimiter',' ');
    end

    % Initialize both XBPMs tp take into account new tables
    tango_command_inout2(XBPM_config.devXbpm1_base,'Stop');
    tango_command_inout2(XBPM_config.devXbpm2_base,'Stop');
    %
    pause(3);
    tango_command_inout2(XBPM_config.devXbpm1_base,'Init');
    tango_command_inout2(XBPM_config.devXbpm2_base,'Init');
    pause(2);
    
   
end

tango_giveInformationMessage(strcat('Fin diteration Calibration X.B.P.M ', xbpm_param.ID));


