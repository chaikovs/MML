function timeout = tango_getbpmtimeout
% tango_setbpmtimeout - set timeout (10s) for bpm
%
% 
% 

%
%  Written by Laurent S. Nadolski


devList = family2tangodev('BPMx');
timeout = zeros(1,size(devList,1));
for k=1:length(devList),
    timeout(k) = tango_get_timeout(devList{k});
    if tango_error == 1
        tango_print_error_stack;
    end
end

if mean(timeout) ~= timeout(1)
    fprintf('A least one BPM is not configured as others\n');
end
