function savegoldenorbit(FileName)
%SAVEGOLDENORBIT - Save present orbit as golden orbit into a file
%
%  INPUTS
%  1. FileName 
%
%  See Also saveoffsetorbit, getgolden, getoffset, plotgoldenorbit, plotoffsetorbit

%
%  Written by Gregory J. Portmann

Xgolden = getgolden(gethbpmfamily, 'Struct');
Ygolden = getgolden(getvbpmfamily, 'Struct');

if nargin < 1
    FileName = '';
end

if isempty(FileName)
    FileName = appendtimestamp([getfamilydata('Default', 'BPMArchiveFile'), 'Golden'], clock);
    %DirectoryName = getfamilydata('Directory', 'BPMData');
    %DirectoryName = [getfamilydata('Directory', 'BPMData') 'GoldenOrbit',filesep];
    DirectoryName = getfamilydata('Directory', 'BPMGolden');
    if isempty(DirectoryName)
        DirectoryName = [getfamilydata('Directory','DataRoot') 'BPM', filesep];
    end

    % Make sure default directory exists
    DirStart = pwd;
    [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
    cd(DirStart);

    [FileName, DirectoryName] = uiputfile('*.mat', 'Save Golden BPM File to ...', [DirectoryName FileName]);
    if FileName == 0
        FileName = '';
        return
    end
    FileName = [DirectoryName, FileName];
end

Data1=Xgolden;
Data2=Ygolden
%save(FileName, 'Xgolden', 'Ygolden');
save(FileName, 'Data1', 'Data2');