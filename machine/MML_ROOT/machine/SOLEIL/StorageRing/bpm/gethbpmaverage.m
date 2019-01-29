function [AM, tout, DataTime, ErrorFlag] = gethbpmaverage(varargin)
%GETHBPMAVERAGE - Gets horizontal orbit read into valid BPMS using TANGO groups
%
%  INPUTS
%  1. Familyname
%  2. Field
%  3. DeviceList - BPM devicelist
%  4. time
%
%  OUTPUTS
%  1. AM - horizontal beam position
%
%  NOTES
%  First shot
%
%  See Also gethbpmgroup, gethbpmmanager


%
% Written by Laurent S. Nadolski

t0 = clock;  % starting time for getting data
DataTime = 0;
ErrorFlag = 1;
Field = 'Monitor';
DeviceListTotal = family2dev('BPMx');

if isempty(varargin)
    DeviceList = DeviceListTotal;
else
    DeviceList = varargin{3};
end

R = tango_read_attribute2('ANS/DG/BPM-MANAGER', 'xMeanOrbit');

% construct data
AM(:,1) = R.value;

tout = etime(clock, t0);

%% Get real TANGO time stamp
DataTime = tango_shift_time(R.time); %time when data was measured according to Tango system

Status = findrowindex(DeviceList, DeviceListTotal);
AM = AM(Status);
