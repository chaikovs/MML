function tango_setbpmtimeout(varargin)
% tango_setbpmtimeout - set timeout (10s) for bpm
%

%
%  Written by Laurent S. Nadolski

checkFlag = 0;

if isempty(varargin)
    timeout = 10000; % ms
else
    timeout = varargin{1};
end

devList = family2tangodev('BPMx');

for k=1:length(devList),
    tango_set_timeout(devList{k}, timeout);
    if tango_error == 1
        tango_print_error_stack;
    end
end


% Checking factorys
if checkFlag
    data= [];
    for k=1:length(devList),
        data(k) = tango_get_timeout(devList{k});
        if tango_error == 1
            tango_print_error_stack;
        end
        if mean(data) ~= data(1)
            printf('At least one BPM is not set properly')
        end

    end
end