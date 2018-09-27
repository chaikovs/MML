function soft_trigger
% SOFT_TRIGGER - Ask a trig on the timing system

%% Written by Laurent S. NADOLSKI

tango_command_inout2('ANS/SY/CENTRAL','FireSoftEvent'); pause(1)
