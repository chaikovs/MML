function burst_trigger
% SOFT_TRIGGER - Ask a trig on the timing system

tango_command_inout2('ANS/SY/CENTRAL','FireBurstEvent'); pause(1)
