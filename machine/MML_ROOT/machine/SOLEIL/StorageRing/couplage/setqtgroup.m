function ErrorFlag = setqtgroup(varargin)
%GETQTGROUP - Sets Skew Quadrupole current for status=1 using TANGO groups
%
%  INPUTS
%  1. Familyname
%  2. Field
%  3. DeviceList - QT devicelist
%  4. time
%
%  OUTPUTS
%  1. ErrorFlag - 0   -> OK

%
% NOTES
% First shot
% Need Structure

%
% Written by Laurent S. Nadolski

t0 = clock;  % starting time for getting data
DataTime = 0;
ErrorFlag = 0;
Field = 'Setpoint';
ifam = 'QT';
DeviceListTotal = family2dev(ifam);

if nargin < 1,
    fprintf('setqtgroup: setpoint value missing\n');
    ErrorFlag = 1;
    return;
else
    val = varargin{1};
end

if nargin <2,
    DeviceList = DeviceListTotal;
else
    DeviceList = varargin{3};
end

GroupID = getfamilydata(ifam, 'GroupId');


% Config 1
%AM = getqtgroup;

% Config 2
AM = NaN*ones(size(family2dev('QT'),1),1);

% Select only Status = 1 power supplies
Status = findrowindex(DeviceList, DeviceListTotal);

if size(val,1) ~= 1 % if vector of values
    if size(Status,1) ~= size(val,1)
        fprintf('setqtgroup: size of Setpoint values does not match number of QTs\n');
        ErrorFlag = 1;
        return;
    end
end

AM(Status) = val;

R = tango_group_write_attribute(GroupID, 'currentPM', 0,AM');

% Error Parser
if tango_error
    tango_print_error_stack;
    ErrorFlag = 1;
    tout = etime(clock, t0);
    return;
else
    if R.has_failed > 0
        ErrorFlag = 1;
        for k=1:length(R.dev_replies),
            if R.dev_replies(k).hasfailed
                fprintf('%s %s has failed \n', ifam, R.dev_replies(k).dev_name)
            end
        end
        ErrorFlag = 1;
        tout = etime(clock, t0);
        return;
    end
end

tout = etime(clock, t0);
