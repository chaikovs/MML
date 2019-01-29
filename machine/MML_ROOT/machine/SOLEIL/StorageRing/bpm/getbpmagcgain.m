function gain = getbpmagcgain
% GETBPMGAIN - Get automatic Gain from BPM dedicated for tune measurement.
%
%  OUPUTS
%  1. gain : Gain in dBm
% 
%  NOTES:
%  1. The BPM for Tune has alway its AGC set to 1. 
%  2. 10 Janray 2010. Timing borad (and electronics) is hosted in C08
%

%% Written by Laurent S.Nadolski
% 9th December 2010 - Add NaN if not only


if strcmp(family2mode('BPMx'), 'Online')
    gain = readattribute('ANS-C09/DG/BPM.NOD/Gain');
else
    gain = NaN;
end
