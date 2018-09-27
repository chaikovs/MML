function U0 = physics_energyloss(E,rho)
%  PHYSICS_ENERGYLOSS - Computed energy loss per turn
%
%  INPUTS
%  1. E - Energy in GeV
%  2. rho - Curvature radius in meters 
%
%  OUPUTS
%  1. U0 - Energy loss per turn in keV
%
%  EXAMPLES
%  1. physics_energyloss(2.75,5.36)
%
%  See Also physics_srpower, physics_[TAB] 

%
% Written by Laurent S. Nadolski
%
% rho 12.376 m for Booster
% rho 5.360 m for storage ring

re = PhysConstant.classical_electron_radius.value;
E0 = PhysConstant.electron_mass_energy_equivalent_in_MeV.value*1e-3; % GeV

U0 = 4/3*pi*re/E0^3*power(E,4)/rho*1e6; % keV
%U0 = 88.46270*power(E,4)/rho;
