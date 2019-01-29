function [ConfigSetpoint, ConfigMonitor, FileName] = getproductionlattice(varargin)
% GETPRODUCTIONLATTICE - Read the Golden lattice from file GoldenLattice
%
%  [ConfigSetpoint, ConfigMonitor, FileName] = getproductionlattice(Field1, Field2, ...)
%
%  INPUTS
%  1. Family - Selected families (Default: All)
%
%  OUTPUTS
%  1. ConfigSetpoint - Set value structure
%  2. ConfigMonitor  - Monitor value structure
%
%  See Also configgui, getinjectionlattice, getmachineconfig,
%  setmachineconfig

%
%  Written by Gregory J. Portmann.

% Get the production file name (full path)
% AD.OpsData.LatticeFile could have the full path else default to AD.Directory.OpsData

FileName = getfamilydata('OpsData','LatticeFile');
[DirectoryName, FileName, Ext, VerNumber] = fileparts(FileName);
if isempty(DirectoryName)
    DirectoryName = getfamilydata('Directory', 'OpsData');
end
FileName = fullfile(DirectoryName,[FileName, '.mat']);


% Load the lattice 
load(FileName);

% Loop for keeping only asked family set values
if nargin > 0
    for i = 1:length(varargin)
        if isfield(ConfigSetpoint, varargin{i})
            ConfigSetpoint = ConfigSetpoint.(varargin{i});
        end
    end
end

% Loop for keeping only asked family Monitor values

if nargout >= 2
if nargin > 0
    for i = 1:length(varargin)
        if isfield(ConfigMonitor, varargin{i})
            ConfigMonitor = ConfigMonitor.(varargin{i});
        end
    end
end
end
