function [fs, nus] = physics_synchrotrontune(eVRF,E,rho)
%  PHYSICS_ENERGYLOSS - Computed synchrotron tune
%
%  INPUTS
%  1. eVRF - RF voltage in keV
%  2. E - Energy in GeV
%  3. rho - Curvature radius in meters 
%
%  OUPUTS
%  1. nus - synchrotron tune
%
%  EXAMPLES
%  1. physics_synchrotrontune(4000,2.75,5.36)
%
%  See Also  physics_RFacceptance, physics_quantumlifetime,
%  physics_energyloss, physics_synchronousphase

%
% Written by Laurent S. NAdolski
%
% rho 12.376 m for Booster
% rho 5.360  m for storagering

DisplayFlag = 1;

if nargin < 3
    rho = 5.360;
    if nargin < 2
        E = getenergy;
        if nargin < 1
            eVRF = 2472;
        end
    end
end
            
% Analytical formula
h     = getharmonicnumber;
alpha = getmcf('Model');
cosPhis = cos(physics_synchronousphase(eVRF,E,rho));
% synchrotron tune
nus = sqrt(alpha*h*cosPhis/2/pi.*eVRF*1e-6/E);

frev = getrf/h*1e6;
% synchrotron frequency
fs = nus * frev;

if DisplayFlag
    fprintf('E = %4.3f GeV, rho = %4.3f m\n', E, rho) 
    fprintf('fs = %e kHz\n', fs)
end