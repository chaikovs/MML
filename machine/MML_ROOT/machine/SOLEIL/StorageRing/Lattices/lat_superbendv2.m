function varargout = lat_superbendv2 
%
% C---------------------------------------------------------------------
% TITLE OF THE JOB: CATS, May 15th, 2012
%    ****************************************************************************
%    *    2.75 GEV QBA CELL: STUDY OF SOLEIL CELL HAVING SDL AND SDM            *
%    *    "SB-QBA-3.inp"                                                        *
%    *    ENERGY              = 2.75 GEV                                        *
%    *    EMITTANCE           = 0.98 NMRAD                                      * 
%    *    CELL LENGTH         = 22.030 M                                        *
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

L0 = 44.06000;% design length [m]
C0 = 2.99792458e8;           % speed of light [m/s]
HarmNumber = 416;

%% Marker and apertures
SYM0  =  marker('SYM0', 'IdentityPass');
SYM1  =  marker('SYM1', 'IdentityPass');
SYM2  =  marker('SYM2', 'IdentityPass');

%% RF Cavity
%              NAME   L     U[V]       f[Hz]          h        method
CAV = rfcavity('RF' , 0.0 , 4.0e+6 , HarmNumber*C0/L0, HarmNumber ,'CavityPass');

%% QUADRUPOLES (compensation de l'effet des defauts de focalisation des
QPassMethod = 'StrMPoleSymplectic4Pass';

QD11   =  quadrupole('QD11' , 0.30000, -1.6913147, QPassMethod);
QF12   =  quadrupole('QF12' , 0.40000,  3.6256564, QPassMethod);
QF13   =  quadrupole('QF13' , 0.50000,  5.0791495, QPassMethod);
QF23   =  quadrupole('QF23' , 0.20000,  0.9539685, QPassMethod);
QF14   =  quadrupole('QF14' , 0.48000,  5.3945733, QPassMethod);
QD15   =  quadrupole('QD15' , 0.40000, -4.2761077, QPassMethod);
QD22   =  quadrupole('QD22' , 0.20000, -0.0399759, QPassMethod);
QF25   =  quadrupole('QF25' , 0.20000,  -3.6479849, QPassMethod);
QD82   =  quadrupole('QF25' , 0.20000,  -0.0540065, QPassMethod);
QD71   =  quadrupole('QF25' , 0.30000,  -2.6270004, QPassMethod);
QF72   =  quadrupole('QF25' , 0.40000,   4.1571400, QPassMethod);

%% DIPOLES
BDE3  =  sbend('BDE3', 0.30400, 0.30400/5.36, 0, 0, -4.209110,'BndMPoleSymplectic4Pass');
BND2  =  sbend('BDE3', 0.35000, 0.35000/11.46021, 0, 0, -3.0000109,'BndMPoleSymplectic4Pass');
BND3  =  sbend('BDE3', 0.35000, 0.35000/11.46021, 0, 0, -2.3790756,'BndMPoleSymplectic4Pass');
BSB2  =  sbend('BDE3', 0.05000, 0.05000/1.27315, 0, 0,  0.000000,'BndMPoleSymplectic4Pass');
 
%% DRIFT SPACES

SD1  = drift('SD1',  6.0000, 'DriftPass');
SD14 = drift('SD14',  3.48300, 'DriftPass');
SD15 = drift('SD15',  0.27, 'DriftPass');
SD16 = drift('SD16',  0.35, 'DriftPass');
SD17 = drift('SD17',  0.29, 'DriftPass');
SD21 = drift('SD21',  0.27, 'DriftPass');
SD22 = drift('SD22',  0.27, 'DriftPass');
SD23 = drift('SD23',  0.12950, 'DriftPass');
SD25 = drift('SD25',  0.26, 'DriftPass');
SD30 = drift('SD30',  0.25, 'DriftPass'); 
SD31 = drift('SD31',  0.20, 'DriftPass'); 
SD42 = drift('SD42',  0.20, 'DriftPass');

%% Lattice
% Superperiods

% SUPERPERIOD #1
CELLML  = [...
     SYM0...
     SD1 ... 
     QD11 SD15 QF12 SD16...
     QD22 SD31...
     BDE3...
     SD25 QF23 SD17 QF13 SD30...
     BND2 BSB2...
     BSB2 BND3...
     SD21 QF14 SD22 QD15...
     SD42 QF25...
     SD23...
     SYM1...
     SD23 ...
     QF25 SD42  ...
     QD15 SD22 QF14 SD21...
     BND3 BSB2...
     BSB2 BND2...
     SD30 QF13 SD17 QF23 SD25 ...
     BDE3...
     SD31 QD82...
     SD16 QF72 SD15 QD71...
     SD14  ...
     SYM2...
     ];


%THE STORAGE RING
ELIST = [...
    CELLML reverse(CELLML) ...
    CAV];

buildlat(ELIST);

% Set all magnets to same energy
THERING = setcellstruct(THERING,'Energy',1:length(THERING),GLOBVAL.E0);

evalin('caller','global THERING FAMLIST GLOBVAL');
atsummary;


if nargout
    varargout{1} = THERING;
end