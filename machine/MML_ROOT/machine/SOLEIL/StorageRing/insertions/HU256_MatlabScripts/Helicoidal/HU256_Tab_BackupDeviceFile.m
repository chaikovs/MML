function Result=HU256_Tab_BackupDeviceFile(Directory, FileName)
% Written by F.Briquez 09/10/2008
% 1) Creates the backup directory if not existing yet
% 2) Copies the file specified by Directory and FileName in the backup directory
%  Returns 1 if completed, -1 if not, 0 if no file to backup exists

    Result=-1;
    if (exist(Directory, 'dir')==0)
    fprintf('HU256_Tab_BackupDeviceFile : Directory ''%s'' is incorrect\n', Directory)
        return
    end
    if (strcmp(Directory(size(Directory, 2)), filesep))
        Directory=Directory(1:size(Directory, 2)-1);
    end
    FileNameLength=size(FileName, 2);
    if (strcmp(FileName(FileNameLength-3:FileNameLength), '.txt')==0)
        FileName=[FileName '.txt'];
    end
    FileFullName=[Directory filesep FileName];
    BackupDirectoryName=[Directory filesep 'Backup_' datestr(now, 31)];
    if (exist(BackupDirectoryName, 'dir')==0)
        Status=mkdir(BackupDirectoryName);
        if (Status==0)
            fprintf('HU256_Tab_BackupDeviceFile : Could not create ''%s''\n', BackupDirectoryName)
            return
        end
        fprintf('Directory ''%s'' created\n', BackupDirectoryName)
    end
    BackupFileName=[BackupDirectoryName filesep FileName];
    if (exist(FileFullName, 'file'))
        Status=copyfile(FileFullName, BackupFileName);
        if (Status==0)
            fprintf('HU256_Tab_BackupDeviceFile : Could not copy ''%s'' to ''%s''\n', FileFullName, BackupFileName)
        return
        end
    else
        fprintf('''%s'' was not existing yet => no backup can be done!\n', FileFullName);
        Result=0;
        return
    end
    fprintf('''%s'' --> ''%s''\n', FileFullName, BackupFileName)
    Result=1;
end