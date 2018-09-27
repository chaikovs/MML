function  saveao(FileName)
%SAVEAO - Saves the AO and AD to a .mat file
%  saveao(FileName)
%  saveao('Golden') to save the MML setup file to the operations directory (MMLSetup.mat)
%
%  See also loadao
%
%  Written by Greg Portmann


if nargin < 1
    FileName = '';
end

if ischar(FileName)
    if isempty(FileName)
        [FileName, DirectoryName, FilterIndex] = uiputfile('*.mat','Save the MML setup to ...', getfamilydata('Directory','DataRoot'));
        if FilterIndex == 0
            return;
        end
        FileName = [DirectoryName, FileName];
    elseif strcmpi(FileName, 'Golden')
        FileName = [getfamilydata('Directory','OpsData'), 'MMLSetup'];
    end
else
    error('Filename input must be a string');
end


AO = getao;
AD = getad;


save(FileName, 'AO', 'AD');



