function SRPower = physics_srpower(E,rho,Ic)
%  PHYSICS_SRPOWER - Computed energy loss per turn
%
%  INPUTS
%  1. E   - Energy in GeV
%  2. rho - Curvature radius in meters
%  3. Ic  - Stored beam (A)
%
%  OUPUTS
%  1. SRPower - Synchrotron radiation Power in (kW)
%
%  EXAMPLES
%  1. physics_srpower(2.7391,5.36,0.5)
%
%  See Also  

%
% Written by Laurent S. Nadolski
%
% rho 12.376 m for Booster
% rho 5.360 m for storage ring

SRPower = physics_energyloss(E,rho)*Ic;
