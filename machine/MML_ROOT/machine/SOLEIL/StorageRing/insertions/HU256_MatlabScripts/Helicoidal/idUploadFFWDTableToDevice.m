function [BackupStatus, UploadStatus]=idUploadFFWDTableToDevice(FFWDTableWithArgs, idName, CorrectorName, idMode)
% Written by F. Briquez 30/03/2011. TO BE FINISHED !!!!
% NB : MISMATCH BETWEEN OUTPUT ARGS!!!!
% Creates or overwrites the FFWD table used by the device
% 1) Inputs : - FFWDTableWithArgs : matrix of corrector currents to put in
%               the table. It must contains headers with phase and gap values!
%             - idName : such as 'HU36_SIRIUS'
%           : - CorrectorName : 'CHE', 'CHS', 'CVE' or 'CVS'
%           : - idMode : 'ii' or 'x' for parallel or anti-parallel modes.
%               (Not case-sensitive)
% 2) Outputs : - BackupStatus : -1 if old table backup failed
%                               0  if old table backup succeeded
%                               0  if old table backup succeeded
%% Initialisation
BackupStatus=-1;
UploadStatus=-1;

%% Get full name of FFWD table file
FFWDTableFullFileName=idGetFFWDTableFullFileName(idName, CorrectorName, idMode);
if (strcmp(FFWDTableFullFileName, ''))
   fprintf('Error in ''idUploadFFWDTableToDevice'' : could not construct table file name\n');
    return
end
%% Backup old file of FFWD table
[UpdateFileFullName, BackupState]=idBackupFFWDTableFile(idName, CorrectorName, idMode);
if (BackupState==-1)
    fprintf ('Error in ''idUploadFFWDTableToDevice'' : could not backup old table => new table is not uploaded!\n');
    return
end
%% Backup new file of FFWD table
if (exist(UpdateFileFullName, 'file')==2)
    ExistingFile=1;
else
    ExistingFile=0;
end

save (UpdateFileFullName, FFWDTableWithArgs, '-ascii');
if (ExistingFile==0)
    if (exist(UpdateFileFullName, 'file')~=2)
        fprintf ('Error in ''idUploadFFWDTableToDevice'' : could not backup new table!\n');
        return
    else
        fprintf ('Backup of new table in ''%s''\n', UpdateFileFullName);
        BackupStatus=1;
    end
else
    fprintf ('Warning in ''idUploadFFWDTableToDevice'' : could not check wether backup of new table succeeded or not!\n');
    BackupStatus=0;
end

if (exist(FFWDTableFullFileName, 'file')==2)
    delete(FFWDTableFullFileName);
    ExistingFile=1;
else
    ExistingFile=0;
end
save (FFWDTableFullFileName, FFWDTableWithArgs, '-ascii');

if (exist(FFWDTableFullFileName, 'file')~=2)
    if (ExistingFile==0)
        fprintf ('ERROR in ''idUploadFFWDTableToDevice'' : could not recreate FFWD table file ''%s''. FILE IS NOW MISSING!\n', FFWDTableFullFileName);
    else
         fprintf ('ERROR in ''idUploadFFWDTableToDevice'' : could not create FFWD table file ''%s''. FILE IS NOW MISSING!\n', FFWDTableFullFileName);
    end
else
    if (ExistingFile==0)
        fprintf ('FFWD table ''%s'' created succesfully\n', FFWDTableFullFileName);
    else
        fprintf ('FFWD table ''%s'' updated succesfully\n', FFWDTableFullFileName);
    end
    UploadStatus=1;
end