function copybpmresp4FOFBfile(DataFileName, ToFileName)
%COPYBPMRESPFILE - Copies a BPM response matrix file to the golden file 
%  copybpmrespfile(DataFileName, ToFileName)
%
%  INPUTS
%  1. DataFileName
%  2. toFileName - Default: Golden Filename 
%
%  See Also copychrorespfile, copybpmsigmafile, copydispersionfile,
%  copydisprespfile, copymachineconfigfile, copytunerespfile

%
%  Written by Gregory J. Portmann

if nargin < 1
    DataFileName = '';
end

if nargin < 2
    ToFileName = 'Golden';
end


% Get the file
if isempty(DataFileName)
    DataDirectoryName = getfamilydata('Directory','BPMResponse');
    if isempty(DataDirectoryName)
        DataDirectoryName = getfamilydata('Directory','DataRoot');
    end
    [DataFileName, DataDirectoryName, FilterIndex] = uigetfile('*.mat','Select the BPM Response Matrix File to Copy', DataDirectoryName);
    if FilterIndex == 0 
        fprintf('   File not copied (copybpmrespfile)\n');
        return;
    end
else
    [DataDirectoryName, DataFileName, ExtName] = fileparts(DataFileName);
    DataDirectoryName = [DataDirectoryName, filesep];
    DataFileName = [DataFileName, ExtName];
end


% Where is it going
if strcmpi(ToFileName, 'Golden')
    FileName = [getfamilydata('OpsData','BPMResp4FOFBFile'),'.mat'];
    DirectoryName = getfamilydata('Directory','OpsData');
    
    if exist([DirectoryName FileName],'file')
        AnswerString = questdlg(strvcat(strvcat(strvcat('Are you sure you want to overwrite the default BPM response matrix file?',sprintf('%s',[DirectoryName FileName])),'With file:'),[DataDirectoryName, DataFileName]),'Default BPM Response','Yes','No','No');
    else
        AnswerString = 'Yes';
    end

    if strcmp(AnswerString,'Yes')
        DirStart = pwd;
        [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
        cd(DirStart);
    else
        fprintf('   File not copied (copybpmrespfile)\n');
        return;
    end
end


% Backup first
BackupDirectoryName = [getfamilydata('Directory','DataRoot') 'Backup' filesep];
BackupDataFileName  = prependtimestamp(FileName);
if exist([DirectoryName, FileName],'file')
    DirStart = pwd;
    [FinalDir, ErrorFlag] = gotodirectory(BackupDirectoryName);
    if ~ErrorFlag
        copyfile([DirectoryName, FileName], [BackupDirectoryName, BackupDataFileName], 'f');
        fprintf('   File %s backup to %s\n', [DirectoryName, FileName], [BackupDirectoryName, BackupDataFileName]);
    else
        fprintf('   Problem finding/creating backup directory, hence backup made to ops directory.\n');
        copyfile([DirectoryName, FileName], [DirectoryName, BackupDataFileName], 'f');
    end
    cd(DirStart);
end


% Do the copy
copyfile([DataDirectoryName, DataFileName], [DirectoryName, FileName], 'f');
fprintf('   File %s copied to %s\n', [DataDirectoryName, DataFileName], [DirectoryName, FileName]);
