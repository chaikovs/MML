function saveoffsetorbit(FileName)
%SAVEOFFSETORBIT - Save offset orbit into file
%
%  INPUTS
%  1. FileName 
%
%  See Also getoffset, setoffset, plotoffsetorbit

%
%  Written by Gregory J. Portmann
%  Adapted by Laurent S. Nadolski

BPMxFamily = gethbpmfamily;
BPMyFamily = getvbpmfamily;

Xoffset = getoffset(BPMxFamily, 'Struct');
Yoffset = getoffset(BPMyFamily, 'Struct');

if nargin < 1
    FileName = '';
end

if isempty(FileName)
    FileName = appendtimestamp([getfamilydata('Default', 'BPMArchiveFile'), 'Offset'], clock);
    DirectoryName = getfamilydata('Directory', 'BPMData');
    if isempty(DirectoryName)
        DirectoryName = [getfamilydata('Directory','DataRoot') 'BPM', filesep];
    end

    % Make sure default directory exists
    DirStart = pwd;
    [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
    cd(DirStart);

    [FileName, DirectoryName] = uiputfile('*.mat', 'Save Offset BPM File to ...', [DirectoryName FileName]);
    if FileName == 0
        FileName = '';
        return
    end
    FileName = [DirectoryName, FileName];
end

save(FileName, 'Xoffset', 'Yoffset');
