function [UpdateFileFullName, BackupState]=idBackupFFWDTableFile(idName, CorrectorName, idMode)
% Written by F. Briquez 30/03/2011
% Saves a backup of a FFWD table used by the device server.
% The backup is made in a directory called as idBackupDirectoryName in the
% id directory (created if necessary).
%
% 1) Inputs : - idName : such as 'HU36_SIRIUS'
%           : - CorrectorName : 'CHE', 'CHS', 'CVE' or 'CVS'
%           : - idMode : 'ii' or 'x' for parallel or anti-parallel modes.
%               (Not case-sensitive)
% 2) Output : - UpdateFileFullName : String containing the full name where to copy the updated
%               table, in the backup directory.
%           : - BackupState : -1 : backup necessary (existing old table) but failed
%                             1  : backup necessary and succeeded
%                             0  : backup unnecessary (no existing old table)

%% Initialisation
idBackupDirectoryName='Backup_Of_FFWD_Tables';
BackupFileSuffix='Backup';
UpdateFileSuffix='Update';

UpdateFileFullName='';
BackupState=-1;
%% Get name of the table used by the device
FFWDTableFullFileName=idGetFFWDTableFullFileName(idName, CorrectorName, idMode);
if (strcmp(FFWDTableFullFileName, ''))
   fprintf('Error in ''idBackupFFWDTableFile'' : could not construct table file name\n');
    return
end

%% Get name of the directory of the id
idDirectoryName=getfamilydata('Directory',idName);
if (exist(idDirectoryName, 'dir')~=7)
   fprintf('Error in ''idBackupFFWDTableFile'' : could not find directory ''%s''\n', idDirectoryName);
    return
end

%% Create the backup directory of the id if does not exist yet
idBackupDirectoryFullName=fullfile(idDirectoryName, idBackupDirectoryName);
if (exist(idBackupDirectoryFullName, 'dir')~=7)
    Status=mkdir(idBackupDirectoryFullName);
    if (Status==0)
       fprintf('Error in ''idBackupFFWDTableFile'' : could not create backup directory ''%s''\n', idBackupDirectoryFullName);
        return
    end
    if (exist(idBackupDirectoryFullName, 'dir')~=7)
        fprintf('Error in ''idBackupFFWDTableFile'' : could not create backup directory ''%s''\n', idBackupDirectoryFullName);
        return
    end
end

[~, FFWDTableFileCoreName, ext, ~] = fileparts(FFWDTableFullFileName);

%% If table exists, duplicates it to backup directory
if (exist(FFWDTableFullFileName, 'file')==2) % Existing former table file => it is duplicated
    BackupFileCoreName=[FFWDTableFileCoreName '_' BackupFileSuffix];
    BackupFileName=appendtimestamp(BackupFileCoreName);
    BackupFileName=[BackupFileName ext];
    BackupFileFullName=fullfile(idBackupDirectoryFullName, BackupFileName);
    [Status, message] = copyfile(FFWDTableFullFileName, BackupFileFullName);
    if (Status==0)  % Copy reports error!
        if (exist(BackupFileFullName, 'file')==2)   % double check (since status = 0 even if the copy worked)
            fprintf ('Old table copied in ''%s''\n', BackupFileFullName);
            BackupState=1;
        else
            fprintf('Error in ''idBackupFFWDTableFile'' : could not create backup file ''%s''\nMessage : %s\n', BackupFileFullName, message);
            BackupState=0;
            return
        end
    else
        fprintf ('Old table copied in ''%s''\n', BackupFileFullName);
        BackupState=1;
    end
else
    fprintf('''idBackupFFWDTableFile'' : no existing previous table file ''%s'' to backup\n', FFWDTableFullFileName);
    BackupState=0;
end

%% Construct and return full name of the new file
UpdateFileCoreName=[FFWDTableFileCoreName '_' UpdateFileSuffix];
UpdateFileName=appendtimestamp(UpdateFileCoreName);
UpdateFileName=[UpdateFileName ext];
UpdateFileFullName=fullfile(idBackupDirectoryFullName, UpdateFileName);

    
    
    