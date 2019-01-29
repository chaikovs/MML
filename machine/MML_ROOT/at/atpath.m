function atpath(ATROOT)
%ATPATH adds the AT directories to the MATLAB search path
% ATPATH(ATROOT) adds the top-level Accelerator Toolbox
%    directory ATROOT and required subdirectories to the
%    MATLAB search path

if ~isdir(ATROOT)
    error('Argument must be a full  directory name');
end
if strcmp(computer,'PCWIN')
    addpath(fullfile(ATROOT,'pubtools','misalignment', 'additional_AT_functions'));
elseif strcmp(computer,'PCWIN64')
    %
elseif isunix
    %addpath(strcat(ATROOT,'/dev'));
else
    warning('Unsupported platform! Path not updated!');
end

addpath(ATROOT);
addpath(fullfile(ATROOT,'simulator', 'element'));
addpath(fullfile(ATROOT,'simulator', 'track'));
addpath(fullfile(ATROOT,'lattice'));
addpath(fullfile(ATROOT,'atphysics'));
addpath(fullfile(ATROOT,'atgui'));
addpath(fullfile(ATROOT,'atdemos'));
addpath(fullfile(ATROOT,'atmatchtestfolder'));
addpath(fullfile(ATROOT,'pubtools'));
addpath(fullfile(ATROOT,'pubtools','create_elems'));
addpath(fullfile(ATROOT,'pubtools','fmagui'));
addpath(fullfile(ATROOT,'pubtools','misalignment'));
%addpath(fullfile(ATROOT,'pubtools','misalignment', 'additional_AT_functions'));
