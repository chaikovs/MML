function [ConfigSetpoint, ConfigMonitor, FileName] = getmachineconfig(varargin)
%GETMACHINECONFIG - Returns or saves to file the present storage ring setpoints and monitors 
%  [ConfigSetpoint, ConfigMonitor, FileName] = getmachineconfig(Family, FileName, ExtraInputs ...)
%  [ConfigSetpoint, ConfigMonitor, FileName] = getmachineconfig(FileName, ExtraInputs ...)
%  
%  INPUTS
%  1. Family - String, string matrix, cell array of families
%              {Default: all families that are a memberof 'MachineConfig'}
%  2. FileName - File name to storage data (if necessary, include full path)
%                'Archive' will archive to the default <Directory\ConfigData\CNFArchiveFile>
%                          use '' to browse for a directory and file.  As usual, 'Archive',''
%                          and 'Archive', Filename will also work.
%                'Golden' will make the present lattice the "golden lattice" which is
%                         stored in <OpsData.LatticeFile>
%                If FileName is not input, then the configuration will not be saved to file.
%  3. ExtraInputs - Extra inputs get passed to getsp and getam (like 'Online' or 'Simulator')
%
%  OUTPUTS
%  1. ConfigSetpoint - Structure of setpoint structures
%                      each field being a family 
%  2. ConfigMonitor - Structure of monitor structures
%                     each field being a family 
%  3. FileName - If data was archived, filename where the data was saved (including the path)
%
%  NOTE
%  1. Use setmachineconfig to save a configuration to file
%  2. Unknown families will be ignored
%  3. Use getmachineconfig('Golden') to store the default golden lattice
%  4. Use getmachineconfig('Archive') to archive a lattice
%
%  See also setmachineconfig, getproductionlattice, getinjectionlattice

%
% Written by Jeff Corbett & Greg Portmann
% Laurent S. Nadolski - October 2010 Modification
% Main Config if output is empty
% Main Config result in a temporary file


DirStart = pwd;

ConfigSetpoint = [];
ConfigMonitor = [];
if nargout == 0
    ArchiveFlag = 1;
    FileName = '';
else
    ArchiveFlag = 0;
    FileName = -1;
end
DisplayFlag = 1;

FileName = '';

% Look for keywords on the input line
InputFlags = {};
for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignor structures
    elseif iscell(varargin{i})
        % Ignor cells
    elseif strcmpi(varargin{i},'struct')
        % Remove
        varargin(i) = [];
    elseif strcmpi(varargin{i},'numeric')
        % Remove
        varargin(i) = [];
    elseif strcmpi(varargin{i},'simulator') || strcmpi(varargin{i},'model')
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Online')
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Manual')
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'physics')
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'hardware')
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'archive')
        ArchiveFlag = 1;
        if length(varargin) > i
            % Look for a filename as the next input
            if ischar(varargin{i+1})
                FileName = varargin{i+1};
                varargin(i+1) = [];
            end
        end
        varargin(i) = [];
    elseif strcmpi(varargin{i},'noarchive')
        ArchiveFlag = 0;
        varargin(i) = [];
    end
end


if isempty(varargin)
    FamilyName = getfamilylist;
else
    if iscell(varargin{1})
        FamilyName = varargin{1};
    elseif size(varargin{1},1) > 1
        FamilyName = varargin{1};
    elseif isfamily(varargin{1})
        FamilyName = varargin{1};
    else
        FamilyName = getfamilylist;
        FileName = varargin{1};
        ArchiveFlag = 1;
    end
    varargin(1) = [];
end
if length(varargin) >= 1
    FileName = varargin{1};
    varargin(1) = [];
    ArchiveFlag = 1;
end



% Archive data structure
if ArchiveFlag
    if isempty(FileName)
        FileName = appendtimestamp(getfamilydata('Default', 'CNFArchiveFile'));
        DirectoryName = getfamilydata('Directory','ConfigData');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot') 'MachineConfig', filesep];
        else
            % Make sure default directory exists
            DirStart = pwd;
            [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
            cd(DirStart);
        end
        [FileName, DirectoryName] = uiputfile('*.mat', 'Save Lattice to ...', [DirectoryName FileName]);
        if FileName == 0
            disp('   Lattice configuration not saved (getmachineconfig).');
            return
        end
        FileName = [DirectoryName, FileName];
        
    elseif FileName == -1
        FileName = appendtimestamp(getfamilydata('Default', 'CNFArchiveFile'));
        DirectoryName = getfamilydata('Directory','ConfigData');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot') 'MachineConfig', filesep];
        end
        FileName = [DirectoryName, FileName];
        
    elseif strcmpi(FileName, 'Golden') || strcmpi(FileName, 'Production')
        % Get the production file name (full path)
        % AD.OpsData.LatticeFile could have the full path else default to AD.Directory.OpsData
        FileName = getfamilydata('OpsData','LatticeFile');
        [DirectoryName, FileName, Ext, VerNumber] = fileparts(FileName);
        if isempty(DirectoryName)
            DirectoryName = getfamilydata('Directory', 'OpsData');
        end
        FileNameGolden = [FileName, '.mat'];
        FileName = fullfile(DirectoryName,[FileName, '.mat']);
        
        if exist(FileName,'file')
            AnswerString = questdlg({'Are you sure you want to overwrite the default lattice file?',sprintf('%s',FileName)},'Default Lattice','Yes','No','No');
        else
            AnswerString = 'Yes';
        end

        if ~strcmp(AnswerString,'Yes')
            disp('   Lattice configuration not saved (getmachineconfig).');
            return;
        end
        
        % Backup first
        if exist(FileName,'file')
            DirStart = pwd;
            %BackupDirectoryName = [getfamilydata('Directory','DataRoot') 'Backup' filesep];
            %BackupDataFileName  = prependtimestamp(FileNameGolden);
            BackupDirectoryName = [getfamilydata('Directory','ConfigData'), 'GoldenBackup', filesep];

            try
                load(FileName,'ConfigSetpoint');
                Fields = fieldnames(ConfigSetpoint);
                BackupDataFileName = prependtimestamp(FileNameGolden, ConfigSetpoint.(Fields{1}).Setpoint.TimeStamp);
                clear ConfigSetpoint
            catch
                fprintf('   Unknown time stamp on the old production lattice file, so backup file has the present time in the filename.\n');
                BackupDataFileName = prependtimestamp(FileNameGolden);
            end

            [FinalDir, ErrorFlag] = gotodirectory(BackupDirectoryName);
            if ~ErrorFlag
                copyfile(FileName, [BackupDirectoryName, BackupDataFileName], 'f');
                fprintf('   File %s backup to %s\n', FileName, [BackupDirectoryName, BackupDataFileName]);
            else
                fprintf('   Problem finding/creating backup directory, hence backup made to the present directory.\n');
                copyfile(FileName, BackupDataFileName, 'f');
            end
            cd(DirStart);
        end
    elseif strcmpi(FileName, 'Injection')
        % Get the injection file name (full path)
        % AD.OpsData.InjectionFile could have the full path else default to AD.Directory.OpsData
        FileName = getfamilydata('OpsData','InjectionFile');
        [DirectoryName, FileName, Ext, VerNumber] = fileparts(FileName);
        if isempty(DirectoryName)
            DirectoryName = getfamilydata('Directory', 'OpsData');
        end
        FileNameGolden = [FileName, '.mat'];
        FileName = fullfile(DirectoryName,[FileName, '.mat']);
                
        if exist(FileName,'file')
            AnswerString = questdlg({'Are you sure you want to overwrite the default injection file?',sprintf('%s',FileName)},'Default Lattice','Yes','No','No');
        else
            AnswerString = 'Yes';
        end
        if ~strcmp(AnswerString,'Yes')
            disp('   Injection configuration not saved (getmachineconfig).');
            return;
        end
        
        % Backup first
        if exist(FileName,'file')
            DirStart = pwd;
            %BackupDirectoryName = [getfamilydata('Directory','DataRoot') 'Backup' filesep];
            BackupDirectoryName = [getfamilydata('Directory','ConfigData'), 'GoldenBackup', filesep];

            try
                load(FileName,'ConfigSetpoint');
                Fields = fieldnames(ConfigSetpoint);
                BackupDataFileName = prependtimestamp(FileNameGolden, ConfigSetpoint.(Fields{1}).Setpoint.TimeStamp);
                clear ConfigSetpoint
            catch
                fprintf('   Unknown time stamp on the old injection lattice file, so backup file has the present time in the filename.\n');
                BackupDataFileName = prependtimestamp(FileNameGolden);
            end

            [FinalDir, ErrorFlag] = gotodirectory(BackupDirectoryName);
            if ~ErrorFlag
                copyfile(FileName, [BackupDirectoryName, BackupDataFileName], 'f');
                fprintf('   File %s backup to %s\n', FileName, [BackupDirectoryName, BackupDataFileName]);
            else
                fprintf('   Problem finding/creating backup directory, hence backup made to the present directory.\n');
                copyfile(FileName, BackupDataFileName, 'f');
            end
            cd(DirStart);
        end
    end
end


% Get the number of families
if iscell(FamilyName)
    N = length(FamilyName);
else
    N = size(FamilyName,1);
end


% Loop over all families
for i = 1:N
    if iscell(FamilyName)
        Family = deblank(FamilyName{i});        
    else
        Family = deblank(FamilyName(i,:));
    end
            
    
    % Get the setpoint
    if ismemberof(Family, 'MachineConfig')
        % Get the Setpoint field
        Field = 'Setpoint';
        try
            if ~isempty(getfamilydata(Family, Field))
                ConfigSetpoint.(Family).(Field) = getpv(Family, Field, 'Struct', InputFlags{:});
            end
        catch
            fprintf('   Trouble with getpv(''%s'',''%s''), hence ignored (getmachineconfig)\n', Family, Field);
        end
    end
    
    % Look if any other fields are part of the MachineConfig
    AOFamily = getfamilydata(Family);
    FieldNameCell = fieldnames(AOFamily);
    for j = 1:size(FieldNameCell,1)
        if isfield(AOFamily.(FieldNameCell{j}),'MemberOf')
            if any(strcmpi(AOFamily.(FieldNameCell{j}).MemberOf, 'MachineConfig'))
                try
                    ConfigSetpoint.(Family).(FieldNameCell{j}) = getpv(Family, FieldNameCell{j}, 'Struct', InputFlags{:});
                catch
                    fprintf('   Trouble with getpv(''%s'',''%s''), hence ignored (getmachineconfig)\n', Family, FieldNameCell{j});
                end                
            end
        end
    end
    
    
    % Get the monitors
    if nargout >= 2 || ArchiveFlag
        if ismemberof(Family, 'MachineConfig') || ismemberof(Family, 'Setpoint', 'MachineConfig') || ismemberof(Family, 'BPM') || strcmp(Family, 'DCCT')
            try
                if ~isempty(getfamilydata(Family, 'Monitor'))
                    ConfigMonitor.(Family).Monitor = getam(Family, 'Struct', InputFlags{:});
                end
            catch
                fprintf('   Trouble with getam(%s), hence ignored (getmachineconfig)\n', Family);
            end
        end
    end
end


% % Get other RF channels
% if nargout >= 2 | ArchiveFlag
%     try
%         ConfigMonitor.RFPower = getpv('RF', 'Power', 'Struct', InputFlags{:});
%         ConfigMonitor.RFVoltage = getpv('RF', 'Voltage', 'Struct', InputFlags{:});
%         ConfigMonitor.KlysPower = getpv('RF', 'KlysPower', 'Struct', InputFlags{:});
%     catch
%         %fprintf('   Trouble getting RF KlysPower, hence ignored (getmachineconfig)\n');
%     end
% end



% Put fields in alphabetical order 
% (Not a good idea to change the set order)
% if ~isempty(ConfigSetpoint)
%     ConfigSetpoint = orderfields(ConfigSetpoint);
% end


if nargout >= 2 || ArchiveFlag
    if ~isempty(ConfigMonitor)
        ConfigMonitor = orderfields(ConfigMonitor);
    end
end


if ArchiveFlag
    % If the filename contains a directory then make sure it exists
    [DirectoryName, FileName, Ext] = fileparts(FileName);
    DirStart = pwd;
    [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
    save(FileName, 'ConfigMonitor', 'ConfigSetpoint');
    cd(DirStart);
    FileName = [DirectoryName FileName];
    
    if DisplayFlag
        fprintf('   Machine configuration data saved to %s.mat\n', FileName);
        if ErrorFlag
            fprintf('   Warning:  The lattice file was saved, but it did not go the desired directory');
            fprintf('   Check %s for your data\n', DirectoryName);
        end
    end
else
    FileName = '';
end



% Special function call for further updates
% Note that the eval allows one to run it has a script (for better or worse).
ExtraSetFunction = getfamilydata('getmachineconfigfunction');

if ~isempty(ExtraSetFunction)
    try
        eval(ExtraSetFunction);
    catch
        fprintf('\n%s\n', lasterr);
        fprintf('   Warning: %s did not compete without error in getmachineconfig.', ExtraSetFunction);
    end
end
