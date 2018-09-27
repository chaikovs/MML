function [AM, tout, DataTime, ErrorFlag] = getphotonbpmaverage(varargin)
%GETPHOTONBPMAVERAGE - Gets vertical orbit read on XBPMmanager
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
%  See Also getphotonbpm

%
% NOTES
% First shot


%
% Written by Laurent S. Nadolski

t0 = clock;  % starting time for getting data
DataTime = 0;
ErrorFlag = 1;
Field = 'Monitor';
DeviceListTotal = family2dev('PBPMz',0);
% get XBPM status 1 or 0 (assumed to to be in XBPMmanager)
FullDeviceListXBPM = DeviceListTotal(getfamilydata('PBPMz', 'Type',DeviceListTotal)==0,:); % get device list XBPM status 1 or 0

if isempty(varargin) | nargin < 3
    DeviceListXBPM = FullDeviceListXBPM;
else
    DeviceListXBPM = varargin{3};
end

% get TANGO data
R = tango_read_attribute2('TDL/DG/XBPM-MANAGER', 'zMeanOrbit');

% construct data
AM(:,1) = R.value;

tout = etime(clock, t0);
DataTime = R.time; %time when data was measured according to Tango system
% Status = findrowindex(DeviceListXBPM, FullDeviceListXBPM);
% AM = AM(Status);
AM = AM;
