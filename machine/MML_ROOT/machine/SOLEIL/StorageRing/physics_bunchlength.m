function sigmaL = physics_bunchlength(eVRF,E,rho,varargin)
%  physics_bunchlength - Compute bunch length
%
%  INPUTS
%  1. E - Energy in GeV
%  2. eVRF - RF voltage in keV
%  3. rho - Curvature radius in meters 
%
%  OUPUTS
%  1. sigmaL - bunch length [m] or [ps] RMS ou FHWM depending on options
%
%  EXAMPLES
%  1. physics_bunchlength(4000,2.75,5.36)
%  2. physics_bunchlength(getcavityvoltage*1e-3,getenergy,5.36)
%
%  See Also  physics_RFacceptance, physics_quantumlifetime,
%  physics_energyloss, physics_synchronousphase, physics_bunchlengtheningfactor

%
% Written by Laurent S. Nadolski
%
% rho 12.376 m for Booster
% rho 5.360  m for storage ring

% EXAMPLES
% plot(1000:4000,physics_bunchlength(1000:4000,2.7391,5.36)/2.99792458e8*1e12*2.35); grid on
% xlabel('VRF [kV]')
% ylabel('sigmaL FWHM (ps)')

clight = PhysConstant.speed_of_light_in_vacuum.value; 

MM2PS = 1e3; % meter to millimiter and then meter to ps
RMS2FWHM = 1; % RMS to FHWM
BUNCHLENGTHNING = 1; 

% switch factory
for i = length(varargin):-1:1
    if strcmpi(varargin{i}, 'FWHM')
        RMS2FWHM = 2.35;
        varargin(i) = [];
    elseif strcmpi(varargin{i}, 'RMS')
        RMS2FWHM = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i}, 'PS')
        MM2PS = 1/clight*1e12;
        varargin(i) = [];
    elseif strcmpi(varargin{i}, 'MM')
        MM2PS = 1e3;
        varargin(i) = [];
    elseif strcmpi(varargin{i}, 'BL')
        if length(varargin) > i && isnumeric(varargin{i+1}),
            % read current per bunch in mA
            current = varargin{i+1};
            varargin(i) = [];
        else
            current = 445/312; %mA
        end
        BUNCHLENGTHNING = physics_bunchlengtheningfactor(current);        
        varargin(i) = [];
    end
end

FACTOR = RMS2FWHM*MM2PS*BUNCHLENGTHNING;

% check that ATmodel is well configured
EPSILON = 1e-6;
if abs(getcavityvoltage-eVRF*1e3) > EPSILON,
    setcavityvoltage(eVRF*1e3);
end

ATsummary = atsummary('NoDisplay');

h        = getharmonicnumber;
alpha    = ATsummary.compactionFactor; %4.218076388294455e-04
OmegaRF  = 2*pi*getrf('Model','Physics');
OmegaRF2 = OmegaRF*OmegaRF;
%sigmaEoE = 1.016e-3;
sigmaEoE = ATsummary.naturalEnergySpread;
cosPhis  = cos(physics_synchronousphase(eVRF,E,rho));
sigmaL   = sqrt(2*pi*alpha*h*clight*clight./cosPhis/OmegaRF2./eVRF/1e-6*E)*sigmaEoE;

% convertion
sigmaL = sigmaL*FACTOR;