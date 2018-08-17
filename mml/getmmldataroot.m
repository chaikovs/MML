function MMLDATAROOT = getmmldataroot(varargin)
%GETMMLDATAROOT - Returns data root directory of the Matlab Middle Layer
%
%  NOTES
%  1. 25 February 2009. Use of the Active circle at SOLEIL to store data only

%
%%  Written by Laurent S. Nadolski

MMLDATAROOT = getmmlroot;
return;

%% Attente redefinition architecture

MMLDATAROOT = '';


% This is legacy
MMLDATAROOT = getenv('MLDATAROOT');
if isempty(MMLDATAROOT)
    error('MMLDATAROOT not known (.bash_profile wrong?): contact an administrator')
end

if exist(MMLDATAROOT, 'dir') ~= 7
   error('Directory %s not mounted. Contact an administrator', MMLDATAROOT) 
end

%MMLDATAROOT = getenv('MLROOT');

% End MMLDATAROOT with a file separator
if ~strcmp(MMLDATAROOT(end), filesep)
    MMLDATAROOT = [MMLDATAROOT, filesep];
end
