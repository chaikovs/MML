function plot_bpm_timephase
% reset_bpm_time_phase - Reset bpm time phse to 0
%
% See Also set_bpm_timephase, plot_bpm_timephase

% Modified by Laurent S. Nadolski, December 2010

GroupId = getfamilydata('BPMx', 'GroupId');

rep = tango_group_read_attribute2(GroupId, 'TimePhase');

figure;
bar(rep)
xlabel('BPM #')
ylabel('Time phase')




