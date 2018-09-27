function [hoffset voffset] = getbpmsnifferoffset
% GETBPMSNIFFEROFFSET - get BPM offset between orbit from sniffer and 10 Hz data flow
%
%
% See Also getsnifferoffset

dirName = '/home/operateur/GrpPhysiqueMachine/Laurent/matlab/FOFB/';
fileName = 'offset_sniffer_10Hz';
A = load([dirName fileName]);

hoffset = A.hoffset;
voffset = A.voffset;