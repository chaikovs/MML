function reset_bpm_timephase
% reset_bpm_time_phase - Reset bpm time phse to 0
%
% See Also set_bpm_timephase, plot_bpm_timephase

% Modified by Laurent S. Nadolski, December 2010

% Ecriture
GroupId = getfamilydata('BPMx', 'GroupId');

tango_group_write_attribute2(GroupId, 'TimePhase', int32(0));
pause(1);
tango_group_command_inout2(GroupId, 'SetTimeOnNextTrigger');
pause(0.5);

disp('Time phase set to 0')




