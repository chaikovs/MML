function res = idSaveStruct(structToSave, fileNameCore, idName, addTime, dispData)
%% Description
%Saves the structure "structToSave" into a .mat file.
% 1)The name of the file is :   - fileNameCore if addTime=0
%                               - fileNameCore with time information if addTime=1
% 2) The directory where the file is stored is defined by idName and  setoperationalmode.m
% (usually /home/data/GMI/HU36_SIRIUS, for instance)
% 3) if dispData=1, displays the name of the file
% 4) Returns full name of created file if succeeded, or '' if failed

% Modified by F. Briquez 20/06/2011 : new input arg "addTime" in order to merge former scripts : idSaveStruct, idSaveStructNoTime and idSaveStruct_NoTime 

%% Init
res = '';
DirStart = pwd;
WrongDirectory=0;
%% Check fileNameCore
if strcmp(fileNameCore, '')
	fprintf('idSaveStruct : fileNameCore ''%s'' is not correct\n', fileNameCore);
end

%% Get directory name and check idName
DirectoryName = getfamilydata('Directory',idName);
if isempty(DirectoryName)
    WrongDirectory=1;
else
    [DirectoryName, WrongDirectory] = gotodirectory(DirectoryName);
end
if WrongDirectory
    fprintf('idSaveStruct : idName ''%s'' is incorrect -> check idName or modify ''setoperationalmode.m''\n', idName)
    return
end

%% Add time if necessary
if addTime
    FileName=appendtimestamp(fileNameCore);
else
    FileName=fileNameCore;
end

%% Save structure
save(FileName,'-struct', 'structToSave');

%% Check the file is correctly created
if (strcmp(FileName(length(FileName)-3:length(FileName)), '.mat')==0)
    FileName=[FileName '.mat'];
end
fileID=fopen(FileName);
if (fileID==-1)
    fprintf ('idSaveStruct : file ''%s'' not created\n', FileName);
    return
else
    Status=fclose(fileID);
    if (Status==-1)
        fprintf ('idSaveStruct : file ''%s'' could not be closed correctly\n', FileName);
        return
    end
end
% res = fullfile(DirectoryName, FileName);
res = FileName;
%% Go back to initial directory
cd(DirStart);

%% Display data if necessary
if dispData ~= 0
	fprintf('Sauvegarde:  %s\n', FileName);
end
