function  [AM, tout, DataTime, ErrorFlag] = get_vorbit_boo(varargin)
% Get vertical orbit at injection using status 1 BPM

%
% Written by Laurent S. Nadolski

t0 = clock;  % starting time for getting data
DataTime = 0;
ErrorFlag = 1;
Field = 'Monitor';
DeviceListTotal = family2dev('BPMz');

if isempty(varargin)
    DeviceList = DeviceListTotal;
else
    DeviceList = varargin{3};
end

istart = 27; %first turn
iend = 100; %first turn

% get data on all BPM
tmp = getbpmrawdata(DeviceList,'nodisplay','struct','NoGroup');
AM =  mean(tmp.Data.Z(:,istart:iend),2);

tout = etime(clock, t0);

