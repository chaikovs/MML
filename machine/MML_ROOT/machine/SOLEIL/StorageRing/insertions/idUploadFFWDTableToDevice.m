function UploadState=idUploadFFWDTableToDevice(FFWDTableWithArgs, idName, CorrectorName, idMode)
%% Written by F.Briquez 25/04/2011
% Creates the FFWD table text file (used by the Device Server) containing the matrix 'FFWDTableWithArgs'
% - Backup the old file in /home/data/GMI/.../Backup_Of_FFWD_Tables
% - Backup the new file in /home/data/GMI/.../Backup_Of_FFWD_Tables
% - Deletes the old file in /usr/Local/configFiles/InsertionFFTables/...
% - Creates the new file in /usr/Local/configFiles/InsertionFFTables/...
% 1) Inputs : FFWDTableWithArgs : matrix containing the FFWD correction currents with headers (phase and gap values as first column and first row)
%           : idName : such as 'HU36_SIRIUS'
%           : CorrectorName : 'CHE', 'CHS', 'CVE' or 'CVS'
%           : idMode : 'ii' or 'x' for parallel or anti-parallel modes.
%               (Not case-sensitive)
% 2) Output : -1 if failed. 1 if succeeded

%%
UploadState=-1;

%% If existing, backup of old FFWD table used by the Device Server
[UpdateFileFullName, BackupState]=idBackupFFWDTableFile(idName, CorrectorName, idMode);
if (BackupState==-1)
    fprintf('Error in ''idUploadFFWDTableToDevice'' : Backup of old FFWD table failed => New table was not uploaded\n');
    return
end
TemporaryFFWDTableToCopyForBackupAndDeviceServer=FFWDTableWithArgs;

%% Create backup of new FFWD table
save (UpdateFileFullName, 'TemporaryFFWDTableToCopyForBackupAndDeviceServer', '-ascii');
if (exist(UpdateFileFullName, 'file')~=2)
    fprintf('Error in ''idUploadFFWDTableToDevice'' : could not create backup of new FFWD table file  ''%s'' => New table was not uploaded\n', UpdateFileFullName);
    return
end

%% If existing, delete old FFWD table used by the Device Server
FFWDTableFileName=idGetFFWDTableFullFileName(idName, CorrectorName, idMode);
if (exist(FFWDTableFileName, 'file')==2)
    delete(FFWDTableFileName);
    if (exist(FFWDTableFileName, 'file')==2)
        fprintf ('Error in ''idUploadFFWDTableToDevice'' : could not delete old FFWD table used by the Device Server => New table was not uploaded\n');
        return
    end
end

%% Create new FFWD table for Device Server

save (FFWDTableFileName, 'TemporaryFFWDTableToCopyForBackupAndDeviceServer', '-ascii');
if (exist(FFWDTableFileName, 'file')~=2)
    fprintf('Error in ''idUploadFFWDTableToDevice'' : could not create new FFWD table file ''%s''\n', FFWDTableFileName);
    return
end
clear('TemporaryFFWDTableToCopyForBackupAndDeviceServer');
UploadState=1;
end