function MMLCONFIGROOT = getmmlconfigroot(varargin)
%GETMMLCONFIGROOT - Returns configuration root directory of the Matlab Middle Layer
%
%  NOTES

%
%%  Written by Laurent S. Nadolski

MMLCONFIGROOT = '';

% This is legacy
MMLCONFIGROOT = getenv('MLCONFIGROOT');
if isempty(MMLCONFIGROOT)    
    if iscontrolroom,
        error('MMLCONFIGROOT not known (bashrc_ICA wrong?): contact an administrator')
    else
        MMLCONFIGROOT = getmmlroot;
    end
end

if exist(MMLCONFIGROOT, 'dir') ~= 7
   error('Directory %s not mounted. Contact an administrator', MMLCONFIGROOT) 
end

%MMLCONFIGROOT = getenv('MLROOT');

% End MMLCONFIGROOT with a file separator
if ~strcmp(MMLCONFIGROOT(end), filesep)
    MMLCONFIGROOT = [MMLCONFIGROOT, filesep];
end
