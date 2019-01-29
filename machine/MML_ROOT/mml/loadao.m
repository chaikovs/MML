function  loadao(FileName)
%LOADAO - Loads the AO and AD from a .mat file
%  loadao(FileName)
%  loadao('Golden') to load the golden MML setup file from the operations directory (MMLSetup.mat)
%
%  See also saveao
%
%  Written by Greg Portmann


if nargin < 1
    FileName = '';
end

if ischar(FileName)
    if isempty(FileName)
        [FileName, DirectoryName, FilterIndex] = uigetfile('*.mat','Select an MML setup file');
        if FilterIndex == 0
            return;
        end
        FileName = [DirectoryName, FileName];
    elseif strcmpi(FileName, 'Golden')
        FileName = [getfamilydata('Directory','OpsData'), 'MMLSetup.mat'];
    end
else
    error('Filename input must be a string');
end

load(FileName);

setao(AO);
setad(AD);
