function [ConfigSetpoint, ConfigMonitor, FileName] = getinjectionlattice(varargin)
%GETINJECTIONLATTICE - Get data from the production lattice file
%  [ConfigSetpoint, ConfigMonitor, FileName] = getinjectionlattice(Field1, Field2, ...)
%
%  See also getproductionlattice, getmachineconfig, setmachineconfig
%
%  Written by Greg Portmann


% Get the injection file name (full path)
% AD.OpsData.InjectionFile could have the full path else default to AD.Directory.OpsData
FileName = getfamilydata('OpsData','InjectionFile');
[DirectoryName, FileName, Ext, VerNumber] = fileparts(FileName);
if isempty(DirectoryName)
    DirectoryName = getfamilydata('Directory', 'OpsData');
end
FileName = fullfile(DirectoryName,[FileName, '.mat']);


% Load the lattice 
load(FileName);


if nargin > 0
    for i = 1:length(varargin)
        if isfield(ConfigSetpoint, varargin{i})
            ConfigSetpoint = ConfigSetpoint.(varargin{i});
        end
    end
end

if nargout >= 2
if nargin > 0
    for i = 1:length(varargin)
        if isfield(ConfigMonitor, varargin{i})
            ConfigMonitor = ConfigMonitor.(varargin{i});
        end
    end
end
end

end

