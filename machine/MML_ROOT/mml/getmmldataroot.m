function MMLDATAROOT = getmmldataroot(varargin)
%GETMMLDATAROOT - Returns data root directory of the Matlab Middle Layer
%
%  NOTES
%  1. 25 February 2009. Use of the Active circle at SOLEIL to store data only
%  2. 4 March 2015. Use of /home/data to store the data

%
%%  Written by Laurent S. Nadolski

MMLDATAROOT = '';

% This is legacy
MMLDATAROOT = getenv('MLDATAROOT');
if isempty(MMLDATAROOT)    
    if iscontrolroom
        error('MMLDATAROOT not known (bashrc_ICA wrong?): contact an administrator')
    else
        MMLDATAROOT = getmmlroot;
    end
end

if exist(MMLDATAROOT, 'dir') ~= 7
   error('Directory %s not mounted. Contact an administrator', MMLDATAROOT) 
end

%MMLDATAROOT = getenv('MLROOT');

% End MMLDATAROOT with a file separator
if ~strcmp(MMLDATAROOT(end), filesep)
    MMLDATAROOT = [MMLDATAROOT, filesep];
end
