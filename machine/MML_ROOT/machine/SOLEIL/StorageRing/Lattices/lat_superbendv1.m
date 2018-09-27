function varargout = lat_superbendv1 
%
% C---------------------------------------------------------------------
% TITLE OF THE JOB: CATS, May 15th, 2012
%    ****************************************************************************
%    *    2.75 GEV QBA CELL: STUDY OF SOLEIL CELL WITH A SHORT STRAIGHT SECTION *
%    *    "SB-QBA-2.inp"                                                        *
%    *    ENERGY              = 2.75 GEV                                        *
%    *    EMITTANCE           = 0.97 NMRAD                                      * 
%    *    CELL LENGTH         = 23.0634 M (INSTEAD OF 22.232 M)                 *
%    *    SUPERBEND (BENDING ANGLE = 8 DEG, LENGTH = 0.8 M):                    *
%    *    DIPOLE FIELD  = (7.2 T OVER 0.1 M AND 0.80 T OVER 0.7 M)              *
%    *    RHO = (1.27315 / 11.46021 M)      << mu = 0.125 >>                    *
%    *    EXTERNAL DISP SUPPRESS BEND (3.25 DEG, 0.304 M AND COMBINED FUNC):    *
%    *    DIPOLE FIELD  = 1.71 T                                                *
%    *    RHO = 5.36 M                                                          *
%    ****************************************************************************
% END_OF_TITLE----------------------------------------------------------

global FAMLIST THERING GLOBVAL

GLOBVAL.E0 = 2.75e9; % Ring energy
GLOBVAL.LatticeFile = mfilename;
FAMLIST = cell(0);

disp(['** Loading SOLEIL magnet lattice ', mfilename]);

L0 = 23.06336;% design length [m]
C0 = 2.99792458e8;           % speed of light [m/s]
HarmNumber = 416;

%% Marker and apertures
SYM2  =  marker('SYM2', 'IdentityPass');
SYM3  =  marker('SYM3', 'IdentityPass');

%% RF Cavity
%              NAME   L     U[V]       f[Hz]          h        method
CAV = rfcavity('RF' , 0.0 , 4.0e+6 , HarmNumber*C0/L0, HarmNumber ,'CavityPass');

%% QUADRUPOLES (compensation de l'effet des defauts de focalisation des
QPassMethod = 'StrMPoleSymplectic4Pass';

QD11s   =  quadrupole('QD11s' , 0.30000, -2.62700035, QPassMethod);
QF12s   =  quadrupole('QF12s' , 0.40000,  4.15713997, QPassMethod);
QF13s   =  quadrupole('QF13s' , 0.50000,  5.07914949, QPassMethod);
QF23s   =  quadrupole('QF23s' , 0.20000,  0.95396845, QPassMethod);
QF14s   =  quadrupole('QF14s' , 0.48000,  5.29026719, QPassMethod);
QD15s   =  quadrupole('QD15s' , 0.40000, -6.13983470, QPassMethod);
QD22s   =  quadrupole('QD22s' , 0.20000, -0.05400650, QPassMethod);
QF25s   =  quadrupole('QF25s' , 0.20000,  2.77473343, QPassMethod);

%% DIPOLES
BDE3  =  sbend('BDE3', 0.30400, 0.30400/5.36, 0, 0, -4.209110,'BndMPoleSymplectic4Pass');
BND2  =  sbend('BDE3', 0.35000, 0.35000/11.46021, 0, 0, -3.0000109,'BndMPoleSymplectic4Pass');
BND3s  =  sbend('BDE3', 0.35000, 0.35000/11.46021, 0, 0, -3.119809,'BndMPoleSymplectic4Pass');
BSB2  =  sbend('BDE3', 0.05000, 0.05000/1.27315, 0, 0,  0.000000,'BndMPoleSymplectic4Pass');
 
%% DRIFT SPACES

SD14 = drift('SD14',  3.48300, 'DriftPass');
SD15 = drift('SD15',  0.27, 'DriftPass');
SD16 = drift('SD16',  0.35, 'DriftPass');
SD17 = drift('SD17',  0.29, 'DriftPass');
SD21 = drift('SD21',  0.27, 'DriftPass');
SD22 = drift('SD22',  0.27, 'DriftPass');
SD23s = drift('SD23s',  1.90468, 'DriftPass');
SD25 = drift('SD25',  0.26, 'DriftPass');
SD30 = drift('SD30',  0.25, 'DriftPass'); % upstream V V-scraper % TO BE UPDATED
SD31 = drift('SD31',  0.20, 'DriftPass'); % downstream H-scraper
SD42 = drift('SD42',  0.20, 'DriftPass');

%% Lattice
% Superperiods

% SUPERPERIOD #1
CELLS  = [...
     SYM2 ...
     SD14 QD11s SD15 QF12s SD16 ...
     QD22s SD31 ...
     BDE3...
     SD25 QF23s SD17 QF13s SD30...
     BND2 BSB2...
     BSB2 BND3s...
     SD21 QF14s SD22 QD15s...
     SD42 QF25s...
     SD23s...
     SYM3...
     SD23s ...
     QF25s SD42  ...
     QD15s SD22 QF14s SD21...
     BND3s BSB2...
     BSB2 BND2...
     SD30 QF13s SD17 QF23s SD25 ...
     BDE3...
     SD31 QD22s...
     SD16 QF12s SD15 QD11s SD14...
     SYM2...
     ];


%THE STORAGE RING
ELIST = [...
    CELLS ...
    CAV];

buildlat(ELIST);

% Set all magnets to same energy
THERING = setcellstruct(THERING,'Energy',1:length(THERING),GLOBVAL.E0);

evalin('caller','global THERING FAMLIST GLOBVAL');
atsummary;


if nargout
    varargout{1} = THERING;
end