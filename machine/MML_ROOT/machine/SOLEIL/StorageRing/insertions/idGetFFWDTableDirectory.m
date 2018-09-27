function Result=idGetFFWDTableDirectory(idName)
% idGetFFWDTableDirectory - return directory for ID FFWD
% 1) Input : idName. Such as 'HU36_SIRIUS'
% 2) Output : the name of the directory where FFWD tables are stored. It should be something like:
% '/usr/Local/configFiles/InsertionFFTables/ANS-C08-HU44'
% 3) If idName is unknown, returned Result is empty string.

%% Written by F. Briquez

%%
    DeviceServer=idGetUndDServer(idName);
    if (isempty(DeviceServer))
        fprintf ('Error in ''idGetFFWDTableDirectory'': idName ''%s'' is unknown''\n', idName);
        Result='';
        return
    end
    % DeviceServer is something like 'ANS-C08/EI/M-HU44.1'
    SeparatorPositions=strfind(DeviceServer, '/');
    if size(SeparatorPositions, 2)~=2
        fprintf('Error in ''idGetFFWDTableDirectory'' : Wrong format of DeviceServer\n');
    end
    FirstSeparatorPosition=SeparatorPositions(1);
    SecondSeparatorPosition=SeparatorPositions(2);
    Cell=DeviceServer(1:FirstSeparatorPosition-1);
    UndulatorNameWithStraightSectiontype=DeviceServer(SecondSeparatorPosition+1:size(DeviceServer, 2));
    SeparatorPositions=strfind(idName, '_');
    if size(SeparatorPositions, 2)~=1
        fprintf('Error in ''idGetFFWDTableDirectory'' : Wrong format of idName\n');
    end
    UndulatorName=idName(1:SeparatorPositions(1)-1);
    Result=['/usr/Local/configFiles/InsertionFFTables/', Cell, '-', UndulatorName];
    return
end