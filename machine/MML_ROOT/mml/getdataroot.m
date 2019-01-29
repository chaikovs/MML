function DATAROOT = getdataroot(varargin)
%GETDATAROOT - Returns data root directory for storing data of SOLEIL controlroom
%
% See Also getmmdataroot, getmmlroot

%
%%  Written by Laurent S. Nadolski

MMLDATAROOT = '';

% This is legacy
MMLDATAROOT = getenv('MLDATAROOT');
if isempty(MMLDATAROOT)
    if iscontrolroom
        error('MMLDATAROOT not known (bashrc_ICA wrong?): contact an administrator')
    else
        DATAROOT = getmmlroot;
    end
end

if iscontrolroom
    if exist(MMLDATAROOT, 'dir') ~= 7
        error('Directory %s not mounted. Contact an administrator', MMLDATAROOT)
    end
    
    DATAROOT = fullfile(MMLDATAROOT, filesep, '..',filesep, '..');
    % resolved path using java function
    file = java.io.File(DATAROOT);
    DATAROOT = char(file.getCanonicalPath());
    
    % End DATAROOT with a file separator
    if ~strcmp(DATAROOT(end), filesep)
        DATAROOT = fullfile(DATAROOT, filesep);
    end
else
    DATAROOT = getmmlroot;
end
