function [B0 dRF] = idGap2Bfield(gap)
% idGap2Bfield - return W164 B-field with respect to the gap value

%
%  INPUTS
%  1. gap - gap value in mm
%
%  OUTPUTS
%  1. B0 - Magnetic field in T
%  2. dR - RF variation in Hz to compensate for circumference variation
%
%  EXAMPLE
%  gap = 5.5:0.1:240;
%  [B0 dRF] = idGap2Bfield(gap);
%  plot(gap, B0); xlabel('gap (mm)'); ylabel('B-field (T)')
%  plot(gap, dRF); xlabel('gap (mm)'); ylabel('RF variation (Hz)')
%
%  NOTE: this formula is based on a lattice before RUN5 in 2013
%  TODO: make it generic with lattice

%See http://controle/mantis/view.php?id=25157 

% dRF=K*Bo^2 avec K=6.6888 et Bo le champ magnétique qui s'exprime:

 % W164
 A=0.13029;
 B=2.49940;
 C=0.035552;
 K=6.6888;
 
 B0=A+B.*exp(-C.*gap);
 
 dRF=K*B0.^2;
 
