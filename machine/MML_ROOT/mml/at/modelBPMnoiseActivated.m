function modelBPMnoiseActivated(NoiseBPM)
% Activate/disactive RMSnoise on BPM readings
% Use of the field AO.BPMx.Simulated.NoiseActivated and AO.BPMz.Simulated.NoiseActivated
%  INPUTS
%  1. NoiseBPM - 1 (activate)
%
%  See Also soleilinit, getpvmodel

%
%% Written by Renaud Cuoq

% If boolean is 1, NoiseBPM is activated
if (NoiseBPM == 1) || (NoiseBPM == 0)
	setfamilydata(NoiseBPM, 'BPMx','Simulated','NoiseActivated');
	setfamilydata(NoiseBPM, 'BPMz','Simulated','NoiseActivated');
else 
	disp('Input value should be 0 or 1')
end
