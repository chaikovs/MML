function [Setpoint, Monitor, FileName] = getlattice(varargin)
%GETLATTICE - Get data from a lattice file 
%  [ConfigSetpoint, ConfigMonitor, FileName] = getlattice(Field1, Field2, ...)
%

DirectoryName = getfamilydata('Directory', 'ConfigData');
[FileName, DirectoryName] = uigetfile('*.mat', 'Select a configuration file', DirectoryName);
if FileName == 0
    Setpoint = []; 
    Monitor = [];
    return
end

load([DirectoryName FileName]);
FileName = [DirectoryName FileName];

if nargin == 0
    Setpoint = ConfigSetpoint;
else
    for i = 1:length(varargin)
        if isfield(ConfigSetpoint, varargin{i})
            Setpoint.(varargin{i}) = ConfigSetpoint.(varargin{i});
        end
    end
end

if nargout >= 2
if nargin == 0
    Monitor = ConfigMonitor;
else
    for i = 1:length(varargin)
        if isfield(ConfigMonitor, varargin{i})
            ConfigMonitor.(varargin{i}) = ConfigMonitor.(varargin{i});
        end
    end
end
end
