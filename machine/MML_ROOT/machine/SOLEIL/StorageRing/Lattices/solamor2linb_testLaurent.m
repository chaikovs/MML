function varargout = solamor2linb
%solamor2 - soleil lattice w/o ID
% Lattice definition file
% Lattice for SOLEIL: perfect lattice no magnetic errors

% Compiled by Laurent Nadolski and Amor Nadji
% 09/01/02, ALS
% mai 2006 : mis à jour vraies cotes BPM, correcteurs, dipole (coins,
% chamd de fuite et gradient)
% A. Nadji et P. Brunelle
% Controlroom : set linearpass for quad (closed orbit)
%               No cavity; No Radiation PassMethod
% April 20th 2007, Laurent S. nadolski
% BPM downstream injection section had wrong location by
% 30 mm, 2 FCOR in injection straight section was not at their proper
% location


global FAMLIST THERING GLOBVAL

GLOBVAL.E0 = 2.7391e9; % Ring energy
GLOBVAL.LatticeFile = mfilename;
FAMLIST = cell(0);

disp(['** Loading SOLEIL magnet lattice ', mfilename]);

%L0 = 354.0967224000159;      % design length [m]
L0 = 354.0968203999998;      % design length [m]
C0 = PhysConstant.speed_of_light_in_vacuum.value;           % speed of light [m/s]
HarmNumber = 416;

%% Cavity
%              NAME   L     U[V]       f[Hz]          h        method
% CAV = rfcavity('RF' , 0 , 4.0e+6 , HarmNumber*C0/L0, ...
%     HarmNumber ,'CavityPass');
CAV = rfcavity('RF' , 0 , 2.0e+6 , HarmNumber*C0/L0, ...
    HarmNumber ,'CavityPass');

%% Marker and apertures
SECT1  =  marker('SECT1', 'IdentityPass');
SECT2  =  marker('SECT2', 'IdentityPass');
SECT3  =  marker('SECT3', 'IdentityPass');
SECT4  =  marker('SECT4', 'IdentityPass');
DEBUT  =  marker('DEBUT', 'IdentityPass');
FIN    =  marker('FIN', 'IdentityPass');

INJ = aperture('INJ',[-0.035 0.035 -0.0125 0.0125],'AperturePass');

%% Injection section
PtINJ = marker('PtINJ', 'IdentityPass');
K3 = marker('K3', 'IdentityPass');
K4 = marker('K4', 'IdentityPass');

%% BPM
BPM    =  marker('BPM', 'IdentityPass');

%% DRIFT SPACES

SD13= drift('SD13', 3.48255, 'DriftPass');
SD1 = drift('SD1',  6.00000, 'DriftPass');
SD1a = drift('SD1a',  1.4125, 'DriftPass');
SD1b = drift('SD1b',  0.7575, 'DriftPass');
SD1c = drift('SD1c',  3.002, 'DriftPass');
SD2 = drift('SD2',  0.39000, 'DriftPass');
SD3 = drift('SD3',  0.20000, 'DriftPass');
SD4 = drift('SD4',  0.39000, 'DriftPass');
SD14= drift('SD14', 0.59000, 'DriftPass');
SD5 = drift('SD5',  0.20000, 'DriftPass');
SD6 = drift('SD6',  0.79000, 'DriftPass');
SD7 = drift('SD7',  0.44000, 'DriftPass');
SD8 = drift('SD8',  0.20000, 'DriftPass');
SD9 = drift('SD9',  0.47634, 'DriftPass');
SD10= drift('SD10', 0.47000, 'DriftPass');
SD12= drift('SD12', 0.47000, 'DriftPass');
SDAC= drift('SDAC', 1.90468, 'DriftPass');

% SD existantes et modifi?es
SD1d = drift('SD1d',  0.5170, 'DriftPass');
SD14a = drift('SD14a', 0.4051, 'DriftPass');
SD9a = drift('SD9a',  0.2243	, 'DriftPass');
SD10a = drift('SD10a', 0.1924	, 'DriftPass');
SDAC1 = drift('SDAC1', 1.48428	, 'DriftPass');
SD13a= drift('SD13a', 3.141452 	, 'DriftPass');
SD1e = drift('SD1e',  5.6589, 'DriftPass');

% SD créées
SD1c1 = drift('SD1e',  0.8410, 'DriftPass');
SD1c2 = drift('SD1e',  2.161, 'DriftPass');
SD91 = drift('SD91',  0.27134, 'DriftPass');
SD41 = drift('SD41',  0.2521, 'DriftPass');
SD42 = drift('SD42',  0.205, 'DriftPass');
SD92 = drift('SD92',  0.2244, 'DriftPass');
SD93 = drift('SD93',  0.2714	, 'DriftPass');
SD43 = drift('SD43', 0.2051	, 'DriftPass');
SD101 = drift('SD101', 0.2394, 'DriftPass');
SD141 = drift('SD141', 0.452, 'DriftPass');

SDB1 = drift('SDB1', 0.3111, 'DriftPass');
SDB2 = drift('SDB2', 0.1849, 'DriftPass');
SDB3 = drift('SDB3', 0.252,  'DriftPass');
SDB4 = drift('SDB4', 0.2776 ,'DriftPass');
SDB5 = drift('SDB5', 0.205  ,'DriftPass');
SDB6 = drift('SDB6', 0.1379 ,'DriftPass');
SDB7 = drift('SDB7', 0.185 , 'DriftPass');
SDB8 = drift('SDB8', 0.252 , 'DriftPass');
SDB9 = drift('SDB9', 0.1379 ,'DriftPass');
SDB10= drift('SDB10',0.185 , 'DriftPass');
SDB11= drift('SDB11',0.2519, 'DriftPass');
SDB12= drift('SDB12',0.2049, 'DriftPass');
SDB13= drift('SDB13',0.1379, 'DriftPass');
SDB14= drift('SDB14',0.1849, 'DriftPass');
SDB15= drift('SDB15',0.252 , 'DriftPass');
SDB16= drift('SDB16',0.2306 , 'DriftPass');
SDB17= drift('SDB17',0.205 , 'DriftPass');
SDB18= drift('SDB18',0.138 , 'DriftPass');

SDC1 = drift('SDC1' , 0.262 ,  'DriftPass');
SDC2 = drift('SDC2' , 0.079 ,  'DriftPass');
SDC3 = drift('SDC3' , 0.07845, 'DriftPass');
SDC4 = drift('SDC4' , 0.3358,  'DriftPass');
SDC5 = drift('SDC5' , 0.0846,  'DriftPass');
SDC6 = drift('SDC6' , 0.079,   'DriftPass');
SDC7 = drift('SDC7' , 0.342 ,  'DriftPass');
SDC8 = drift('SDC8' , 0.262 ,  'DriftPass');
SDC9 = drift('SDC9' , 0.079  , 'DriftPass');
SDC10= drift('SDC10',0.07845, 'DriftPass');
SDC11= drift('SDC11',0.262  , 'DriftPass');
SDC12= drift('SDC12',0.3358 , 'DriftPass');
SDC13= drift('SDC13',0.0846 , 'DriftPass');
SDC14= drift('SDC14',0.0788 , 'DriftPass');
SDC15= drift('SDC15',0.3422 , 'DriftPass');
SDC16= drift('SDC16',0.262  , 'DriftPass');
SDC17= drift('SDC17',0.079  , 'DriftPass');
SDC18= drift('SDC18',0.07845, 'DriftPass');
SDC19= drift('SDC19',0.262  , 'DriftPass');
SDC20= drift('SDC20',0.262  , 'DriftPass');
SDC21= drift('SDC21',0.079  , 'DriftPass');
SDC22= drift('SDC21',0.311  , 'DriftPass');
SDC23= drift('SDC21',4.310  , 'DriftPass');
SDC24= drift('SDC21',1.379  , 'DriftPass');


%% QUADRUPOLES (compensation de l'effet des défauts de focalisation des
%% dipoles P. Brunelle 02/05/06)
de=1-4e-3*0;
Q1   =  quadrupole('Q1' , 0.32,  -1.193917*de , 'QuadLinearPass');
Q2   =  quadrupole('Q2' , 0.46,   1.712124*de , 'QuadLinearPass');
Q3   =  quadrupole('Q3' , 0.32,  -0.7195554*de , 'QuadLinearPass');
Q4   =  quadrupole('Q4' , 0.32,  -1.404293*de , 'QuadLinearPass');
Q5   =  quadrupole('Q5' , 0.32,   1.895744*de , 'QuadLinearPass');
Q6   =  quadrupole('Q6' , 0.32,  -1.117271*de , 'QuadLinearPass');
Q7   =  quadrupole('Q7' , 0.46,   2.223070*de , 'QuadLinearPass');
Q8   =  quadrupole('Q8' , 0.32,  -1.724227*de , 'QuadLinearPass');
Q9   =  quadrupole('Q9' , 0.32,  -1.689030*de , 'QuadLinearPass');
Q10  =  quadrupole('Q10', 0.32,   1.963458*de , 'QuadLinearPass');


%% SEXTUPOLES chromaticités nulles dans TracyII
%avec défauts de focalisation des dip?les
%P. Brunelle 02/05/06
F = 1e8;
Finv = 1/F;

S1  =  sextupole('S1' , Finv,  1.71919*F, 'StrMPoleSymplectic4Pass');
S2  =  sextupole('S2' , Finv, -4.10456*F, 'StrMPoleSymplectic4Pass');
S3  =  sextupole('S3' , Finv, -2.16938*F, 'StrMPoleSymplectic4Pass');
S4  =  sextupole('S4' , Finv,  3.60465*F, 'StrMPoleSymplectic4Pass');
S5  =  sextupole('S5' , Finv, -3.69821*F, 'StrMPoleSymplectic4Pass');
S6  =  sextupole('S6' , Finv,  3.24667*F, 'StrMPoleSymplectic4Pass');
S7  =  sextupole('S7' , Finv, -5.00352*F, 'StrMPoleSymplectic4Pass');
S8  =  sextupole('S8' , Finv,  4.19372*F, 'StrMPoleSymplectic4Pass');
S9  =  sextupole('S9' , Finv, -3.152295*F, 'StrMPoleSymplectic4Pass');
S10 =  sextupole('S10', Finv,  1.936432*F, 'StrMPoleSymplectic4Pass');

%% Skew quadrupoles
%QT    =  marker('SkewQuad', 'IdentityPass');
QT    =  skewquad('SkewQuad', 1e-8, 0.0, 'StrMPoleSymplectic4Pass');

%% Slow feedback correctors
% HCOR =  corrector('HCOR',0.0,[0 0],'CorrectorPass');
% VCOR =  corrector('VCOR',0.0,[0 0],'CorrectorPass');
% COR = [HCOR VCOR];
COR =  corrector('COR',0.0,[0 0],'CorrectorPass');
KHU640 =  corrector('KHU640',0.0,[0 0],'CorrectorPass');
CHU640 =  corrector('CHU640',0.0,[0 0],'CorrectorPass');

ODECOR =  corrector('ODECOR',0.0,[0 0],'CorrectorPass');

%% Fast feedback correctors
% FHCOR =  corrector('FHCOR',0.0,[0 0],'CorrectorPass');
% FVCOR =  corrector('FVCOR',0.0,[0 0],'CorrectorPass');
% FCOR = [FHCOR,FVCOR];
FCOR =  corrector('FCOR',0.0,[0 0],'CorrectorPass');

SX1   = [S1  COR  QT];
SX2   = [S2  COR  QT];
SX3   = [S3  COR  QT];
SX4   = [S4  COR  QT];
SX5   = [S5  COR  QT];
SX6   = [S6  COR  QT];
SX7   = [S7  COR  QT];
SX8   = [S8  COR  QT];
SX9   = [S9  COR  QT];
SX10  = [S10 COR  QT];

%% DIPOLES
%BEND  =  rbend('BEND'  , 1.05243,  ...
% 0.19635, 0.098175, 0.098175, 0.0,'BendLinearPass');

%% DIPOLES
% {** 1.3815 factor to fit with BETA ??? strange **}
%theta = 2*pi/32;
%fullgap = 0.105*0.724*2/6*1.3815*0.;
% BEND  =  rbend2('BEND', L, theta, theta/2, theta/2, 0.0, ...
%                 fullgap,'BendLinearFringeTiltPass');
theta = 2*pi/32;
%theta2 = theta/2;
thetae = theta/2 - 0.6e-3*1;
thetas = theta/2 + 0.9e-3*1;
K = 0.00204*1;
fullgap = 0.037*0.724*2*1;
BEND  =  rbend2('BEND', 1.05243, theta, thetae, thetas, K,fullgap,'BendLinearPass');


%% Lattice
% Superperiods

SUP1  = [...
    SD1a   PtINJ   SD1b   K3  SD1c1 FCOR SD1c2     K4     SD1d ...
    BPM  SDB1   Q1     SD2    SX1   SD3     Q2 ...
    SDB2  BPM    SD14a   Q3      SD5    SX2    SD6 ...
    BEND    SD7     Q4  SD8     SX3    ...
    SDB3  BPM     SD9a   Q5     SD12  SX4 ...
    SDB4  BPM     SD10a    Q5     SD91     ...
    BPM  SDB5  SX3    SD8   Q4      SD7     BEND ...
    SD7     Q6      SD5    SX5     SD41    ...
    BPM  SDB6  Q7    SD3     SX6      SD2     Q8 ...
    SDC1 FCOR SDC2   BPM    SD13a  SD13a BPM ...
    SDC3    FCOR   SDC1 ...
    Q8      SD2    SX8     SD3    Q7  SDB7 ...
    BPM   SD42     SX7      SD5     Q6     SD7 ...
    BEND   SD7    Q9    SD8     SX9  SDB8 ...
    BPM     SD9a    Q10    SD8     SX10  SDC4  ...
    FCOR SDC5  BPM   SDAC1    SDAC1 ...
    BPM   SDC6  FCOR  SDC7 SX10    SD8    Q10    SD91 ...
    BPM   SD42  SX9      SD8     Q9     SD7    ...
    ODECOR   BEND   SD7    Q6    SD5     SX7    SD41   ...
    BPM  SDB9  Q7      SD3    SX8    SD2   Q8 SDC8 ...
    FCOR  SDC9  BPM     SD13a    SD13a  ...
    BPM  SDC10   FCOR  SDC11  Q8     SD2   SX8   SD3   Q7 ...
    SDB10  BPM   SD42    SX7    SD5   Q6      SD7  ...
    BEND    SD7     Q9     SD8     SX9  SDB11    ...
    BPM    SD92   Q10     SD8     SX10 SDC12 ...
    FCOR  SDC13  BPM    SDAC1    SDAC1   ...
    BPM  SDC14  FCOR   SDC15   SX10   SD8     Q10    SD93 ...
    BPM  SDB12  SX9    SD8   Q9      SD7 ...
    BEND    SD7    Q6      SD5    SX7    SD41 ...
    BPM  SDB13   Q7      SD3    SX8     SD2    Q8  SDC16 ...
    FCOR SDC17  BPM    SD13a SD13a   ...
    BPM   SDC18  FCOR  SDC19   Q8     SD2     SX6    SD3    Q7 ...
    SDB14  BPM    SD43    SX5     SD5    Q6      SD7    ...
    BEND   SD7   Q4      SD8     SX3  SDB15 ...
    BPM     SD9a   Q5      SD101   ...
    BPM  SDB16  SX4   SD12    Q5     SD93 ...
    BPM  SDB17  SX3     SD8    Q4     SD7   ...
    BEND    SD6     SX2      SD5     Q3     SD141 ...
    BPM  SDB18  Q2     SD3   SX1     SD2     Q1 ...
    SDC20 FCOR  SDC21   BPM     CHU640 SD1e  ];

SUP2  = [  ...
    KHU640 SD1e CHU640  BPM SDC2 FCOR SDC1   ...
    Q1     SD2    SX1   SD3     Q2 ...
    SDB7  BPM    SD14a   Q3      SD5    SX2    SD6 ...
    BEND    SD7     Q4  SD8     SX3    ...
    SDB3  BPM     SD9a   Q5     SD12  SX4 ...
    SDB4  BPM     SD10a    Q5     SD93     ...
    BPM  SDB5  SX3    SD8   Q4      SD7     BEND ...
    SD7     Q6      SD5    SX5     SD41    ...
    BPM  SDB6  Q7    SD3     SX6      SD2     Q8 ...
    SDC1 FCOR SDC2   BPM    SD13a  SD13a  BPM ...
    SDC2    FCOR   SDC1 ...
    Q8      SD2    SX8     SD3    Q7  SDB7 ...
    BPM   SDB5     SX7      SD5     Q6     SD7 ...
    BEND   SD7    Q9    SD8     SX9  SDB3 ...
    BPM     SD9a    Q10    SD8     SX10  SDC4  ...
    FCOR SDC5  BPM   SDAC1    SDAC1 ...
    BPM   SDC14  FCOR  SDC15 SX10    SD8    Q10    SD93 ...
    BPM   SDB12  SX9      SD8     Q9     SD7    ...
    BEND   SD7    Q6    SD5     SX7    SD41   ...
    BPM  SDB6  Q7      SD3    SX8    SD2   Q8 SDC1 ...
    FCOR  SDC2  BPM     SD13a  SD13a  ...
    BPM  SDC2   FCOR  SDC1  Q8     SD2   SX8   SD3   Q7 ...
    SDB7  BPM   SDB5    SX7    SD5   Q6      SD7  ...
    BEND    SD7     Q9     SD8     SX9   SDB3    ...
    BPM    SD9a   Q10     SD8     SX10  SDC4 ...
    FCOR  SDC5  BPM    SDAC1    SDAC1   ...
    BPM  SDC14  FCOR   SDC15   SX10   SD8     Q10    SD93 ...
    BPM  SDB12  SX9    SD8   Q9      SD7 ...
    BEND    SD7    Q6      SD5    SX7    SD41 ...
    BPM  SDB6   Q7      SD3    SX8     SD2    Q8  SDC1 ...
    FCOR SDC2  BPM    SD13a   SD13a   ...
    BPM   SDC2  FCOR  SDC1   Q8     SD2     SX6    SD3    Q7 ...
    SDB7  BPM    SD42    SX5     SD5    Q6      SD7    ...
    BEND   SD7   Q4      SD8     SX3  SDB3 ...
    BPM     SD9a   Q5      SD101   ...
    BPM  SDB16  SX4   SD12    Q5     SD93 ...
    BPM  SD42  SX3     SD8    Q4     SD7   ...
    BEND    SD6     SX2      SD5     Q3     SD141 ...
    BPM  SDB18  Q2     SD3   SX1     SD2     Q1 ...
    SDC1 FCOR  SDC2   BPM     SD1e  ];

SUP3  = [  ...
    SD1e  BPM SDC2 FCOR SDC1   ...
    Q1     SD2    SX1   SD3     Q2 ...
    SDB7  BPM    SD14a   Q3      SD5    SX2    SD6 ...
    BEND    SD7     Q4  SD8     SX3    ...
    SDB3  BPM     SD9a   Q5     SD12  SX4 ...
    SDB4  BPM     SD10a    Q5     SD93     ...
    BPM  SDB5  SX3    SD8   Q4      SD7     BEND ...
    SD7     Q6      SD5    SX5     SD41    ...
    BPM  SDB6  Q7    SD3     SX6      SD2     Q8 ...
    SDC1 FCOR SDC2   BPM    SD13a  SD13a  BPM ...
    SDC2    FCOR   SDC1 ...
    Q8      SD2    SX8     SD3    Q7  SDB7 ...
    BPM   SDB5     SX7      SD5     Q6     SD7 ...
    BEND   SD7    Q9    SD8     SX9  SDB3 ...
    BPM     SD9a    Q10    SD8     SX10  SDC4  ...
    FCOR SDC5  BPM   SDAC1    SDAC1 ...
    BPM   SDC14  FCOR  SDC15 SX10    SD8    Q10    SD93 ...
    BPM   SDB12  SX9      SD8     Q9     SD7    ...
    BEND   SD7    Q6    SD5     SX7    SD41   ...
    BPM  SDB6  Q7      SD3    SX8    SD2   Q8 SDC1 ...
    FCOR  SDC2  BPM     SD13a  SD13a  ...
    BPM  SDC2   FCOR  SDC1  Q8     SD2   SX8   SD3   Q7 ...
    SDB7  BPM   SDB5    SX7    SD5   Q6      SD7  ...
    BEND    SD7     Q9     SD8     SX9   SDB3    ...
    BPM    SD9a   Q10     SD8     SX10  SDC4 ...
    FCOR  SDC5  BPM    SDAC1    SDAC1   ...
    BPM  SDC14  FCOR   SDC15   SX10   SD8     Q10    SD93 ...
    BPM  SDB12  SX9    SD8   Q9      SD7 ...
    BEND    SD7    Q6      SD5    SX7    SD41 ...
    BPM  SDB6   Q7      SD3    SX8     SD2    Q8  SDC1 ...
    FCOR SDC2  BPM    SD13a   SD13a   ...
    BPM   SDC2  FCOR  SDC1   Q8     SD2     SX6    SD3    Q7 ...
    SDB7  BPM    SD42    SX5     SD5    Q6      SD7    ...
    BEND   SD7   Q4      SD8     SX3  SDB3 ...
    BPM     SD9a   Q5      SD101   ...
    BPM  SDB16  SX4   SD12    Q5     SD93 ...
    BPM  SD42  SX3     SD8    Q4     SD7   ...
    BEND    SD6     SX2      SD5     Q3     SD141 ...
    BPM  SDB18  Q2     SD3   SX1     SD2     Q1 ...
    SDC1 FCOR  SDC2   BPM     SD1e  ];

SUP4  = [  ...
    SD1e  BPM SDC2 FCOR SDC1   ...
    Q1     SD2    SX1   SD3     Q2 ...
    SDB7  BPM    SD14a   Q3      SD5    SX2    SD6 ...
    BEND    SD7     Q4  SD8     SX3    ...
    SDB3  BPM     SD9a   Q5     SD12  SX4 ...
    SDB4  BPM     SD10a    Q5     SD93     ...
    BPM  SDB5  SX3    SD8   Q4      SD7     BEND ...
    SD7     Q6      SD5    SX5     SD41    ...
    BPM  SDB6  Q7    SD3     SX6      SD2     Q8 ...
    SDC1 FCOR SDC2   BPM    SD13a  SD13a  BPM ...
    SDC2    FCOR   SDC1 ...
    Q8      SD2    SX8     SD3    Q7  SDB7 ...
    BPM   SDB5     SX7      SD5     Q6     SD7 ...
    BEND   SD7    Q9    SD8     SX9  SDB3 ...
    BPM     SD9a    Q10    SD8     SX10  SDC4  ...
    FCOR SDC5  BPM   SDAC1    SDAC1 ...
    BPM   SDC14  FCOR  SDC15 SX10    SD8    Q10    SD93 ...
    BPM   SDB12  SX9      SD8     Q9     SD7    ...
    BEND   SD7    Q6    SD5     SX7    SD41   ...
    BPM  SDB6  Q7      SD3    SX8    SD2   Q8 SDC1 ...
    FCOR  SDC2  BPM     SD13a  SD13a  ...
    BPM  SDC2   FCOR  SDC1  Q8     SD2   SX8   SD3   Q7 ...
    SDB7  BPM   SDB5    SX7    SD5   Q6      SD7  ...
    BEND    SD7     Q9     SD8     SX9   SDB3    ...
    BPM    SD9a   Q10     SD8     SX10  SDC4 ...
    FCOR  SDC5  BPM    SDAC1    SDAC1   ...
    BPM  SDC14  FCOR   SDC15   SX10   SD8     Q10    SD93 ...
    BPM  SDB12  SX9    SD8   Q9      SD7 ...
    BEND    SD7    Q6      SD5    SX7    SD41 ...
    BPM  SDB6   Q7      SD3    SX8     SD2    Q8  SDC1 ...
    FCOR SDC2  BPM    SD13a   SD13a   ...
    BPM   SDC2  FCOR  SDC1   Q8     SD2     SX6    SD3    Q7 ...
    SDB7  BPM    SD42    SX5     SD5    Q6      SD7    ...
    BEND   SD7   Q4      SD8     SX3  SDB3 ...
    BPM     SD9a   Q5      SD101   ...
    BPM  SDB16  SX4   SD12    Q5     SD93 ...
    BPM  SD42  SX3     SD8    Q4     SD7   ...
    BEND    SD6     SX2      SD5     Q3     SD141 ...
    BPM  SDB18  Q2     SD3   SX1     SD2     Q1 ...
    SDC22   BPM  SDC23 FCOR  SDC24  ];


ELIST = [DEBUT INJ SECT1 SUP1 SECT2 SUP2 SECT3 SUP3 SECT4 SUP4 CAV FIN];
%ELIST = [DEBUT INJ SECT1 SUP1 SECT2 SUP2 SECT3 SUP3 SECT4 SUP4 FIN];

buildlat(ELIST);

% Set all magnets to same energy
THERING = setcellstruct(THERING,'Energy',1:length(THERING),GLOBVAL.E0);

evalin('caller','global THERING FAMLIST GLOBVAL');

atsummary;

if nargout
    varargout{1} = THERING;
end