function varargout = lat_nano_5m_20_30
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
% November 24th 2007, Laurent S. Nadolski
% Bpms 5 on the wrong side of sextupole in cell 4, 8, 12 and 16
% December 7th, 2007, Laurent S. Nadolski
% Added KEM V & H, K1 & K2 markers modelled as thin element
% October 1, 2008
% Lattice with tunes 18.2020 and 10.3170
% Octobre 27, 2008
% Lattice with tunes 18.2020 and 10.3170
% Lattice with chromaticities 2.0 and 2.0
% March 4, 2009
% FHCOR and FVCOR [1 1] steerer moved 2180 mm upstream, 
% closed to entrance of vertical kicker
% March 2009 - New quadrupole model from MAT with intermediate length
% June 2009 - magnetcoefficient with index June 9 was changed 
%             for sextupoles calibration
%             for quadrupole Just all ranges for quad variation with fit are present
% July 2009 - Add PX2 Chicane
% December 2009 - Add Nanonscopium

global FAMLIST THERING GLOBVAL

GLOBVAL.E0 = 2.7391e9; % Ring energy
GLOBVAL.LatticeFile = mfilename;
FAMLIST = cell(0);

disp(['** Loading SOLEIL magnet lattice ', mfilename]);

L0 = 354.0968203999998;      % design length [m]
C0 = PhysConstant.speed_of_light_in_vacuum.value;           % speed of light [m/s]
HarmNumber = 416;

%% Cavity
%              NAME   L     U[V]       f[Hz]          h        method
CAV = rfcavity('RF' , 0 , 4.0e+6 , HarmNumber*C0/L0, ...
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
K1 = marker('K1', 'IdentityPass');
K2 = marker('K2', 'IdentityPass');
K3 = marker('K3', 'IdentityPass');
K4 = marker('K4', 'IdentityPass');

%% BPM
BPM    =  marker('BPM', 'IdentityPass');

%% DRIFT SPACES

SD1a = drift('SD1a',  1.4125, 'DriftPass');
SD1b = drift('SD1b',  0.7575, 'DriftPass');
SD2 = drift('SD2',  0.369900, 'DriftPass');
SD3 = drift('SD3',   0.181900, 'DriftPass');
SD5 = drift('SD5',  0.179900, 'DriftPass');
SD6 = drift('SD6',  0.79000, 'DriftPass');
SD7 = drift('SD7',  0.419900, 'DriftPass');
SD8 = drift('SD8',  0.1799000, 'DriftPass');
SD12= drift('SD12', 0.44990, 'DriftPass');
SD1d = drift('SD1d',  0.5170, 'DriftPass');
SD14a = drift('SD14a', 0.38500000, 'DriftPass');
SD9a = drift('SD9a',  0.204200	, 'DriftPass');
SD10a = drift('SD10a', 0.172300	, 'DriftPass');
SDAC1 = drift('SDAC1', 1.48428	, 'DriftPass');
SD13a= drift('SD13a', 3.141452 	, 'DriftPass');
SD1e = drift('SD1e',  5.6589, 'DriftPass');
SD1c1 = drift('SD1c1',  0.8410, 'DriftPass'); % K3 - FCOR
SD1c2 = drift('SD1c2',  0.601, 'DriftPass');  % FCOR KEMH
SD1c3 = drift('SD1c3',  1.560, 'DriftPass');  % KEMH - K4
SD91 = drift('SD91',  0.251240, 'DriftPass');
SD41 = drift('SD41',  0.2521, 'DriftPass');
SD42 = drift('SD42',  0.205, 'DriftPass');
SD92 = drift('SD92',  0.204300, 'DriftPass');
SD93 = drift('SD93',  0.251300	, 'DriftPass');
SD43 = drift('SD43', 0.2051	, 'DriftPass');
SD141 = drift('SD141', 0.431900, 'DriftPass');
SDB1 = drift('SDB1', 0.29100, 'DriftPass');
SDB2 = drift('SDB2', 0.16680000, 'DriftPass');
SDB3 = drift('SDB3', 0.252,  'DriftPass');
SDB4 = drift('SDB4', 0.2776 ,'DriftPass');
SDB5 = drift('SDB5', 0.205  ,'DriftPass');
SDB6 = drift('SDB6', 0.119800 ,'DriftPass');
SDB7 = drift('SDB7', 0.166900 , 'DriftPass');
SDB8 = drift('SDB8', 0.252 , 'DriftPass');
SDB9 = drift('SDB9', 0.119800 ,'DriftPass');
SDB10= drift('SDB10',0.166900 , 'DriftPass');
SDB11= drift('SDB11',0.2519, 'DriftPass');
SDB12= drift('SDB12',0.2049, 'DriftPass');
SDB13= drift('SDB13',0.119800, 'DriftPass');
SDB14= drift('SDB14',0.1668000, 'DriftPass');
SDB15= drift('SDB15',0.252 , 'DriftPass');
SDB17= drift('SDB17',0.205 , 'DriftPass');
SDB18= drift('SDB18', 0.119900, 'DriftPass');
SDC1 = drift('SDC1' , 0.241900,  'DriftPass');
SDC2 = drift('SDC2' , 0.079000,  'DriftPass');
SDC3 = drift('SDC3' , 0.078450, 'DriftPass');
SDC4 = drift('SDC4' , 0.335800,  'DriftPass');
SDC5 = drift('SDC5' , 0.084600,  'DriftPass');
SDC6 = drift('SDC6' , 0.079000,   'DriftPass');
SDC7 = drift('SDC7' , 0.342000,  'DriftPass');
SDC8 = drift('SDC8' , 0.241900,  'DriftPass');
SDC9 = drift('SDC9' , 0.079000, 'DriftPass');
SDC10= drift('SDC10',0.07845, 'DriftPass');
SDC11= drift('SDC11',0.2419000  , 'DriftPass');
SDC12= drift('SDC12',0.3358 , 'DriftPass');
SDC13= drift('SDC13',0.0846 , 'DriftPass');
SDC14= drift('SDC14',0.0788 , 'DriftPass');
SDC15= drift('SDC15',0.3422 , 'DriftPass');
SDC16= drift('SDC16',0.241900  , 'DriftPass');
SDC17= drift('SDC17',0.079  , 'DriftPass');
SDC18= drift('SDC18',0.07845, 'DriftPass');
SDC19= drift('SDC19',0.24190  , 'DriftPass');
SDC20= drift('SDC20',0.241900  , 'DriftPass');
SDC21= drift('SDC21',0.079  , 'DriftPass');
SDC22= drift('SDC22',0.29090  , 'DriftPass');
SDC24= drift('SDC24',1.379  , 'DriftPass');
%SDC23a= drift('SDC23a',0.632  , 'DriftPass'); % BPM - K1
SDC23b= drift('SDC23b',1.983  , 'DriftPass'); % K1 - KEMV
SDC23c= drift('SDC23c',1.019  , 'DriftPass'); % KEMV - K2
SDC23d= drift('SDC23d',0.676  , 'DriftPass'); % K2 - FCOR
SDC23e= drift('SDC23a',0.147  , 'DriftPass'); % BPM - FCOR [1 1]
SDC23f= drift('SDC23a',0.485  , 'DriftPass'); % FCOR [1 1] next SD
SDPX2a= drift('SDC23a',0.363902, 'DriftPass'); % FCOR [1 1] next SD
SDPX2b= drift('SDC23a',2.85755, 'DriftPass'); % FCOR [1 1] next SD
SDPX2c= drift('SDC23a', 0.203902, 'DriftPass'); % FCOR [1 1] next SD
% nanoscopium
SDNSC1 = drift('SDNSC', 4.5888, 'DriftPass'); 
SDNSC2 = drift('SDNSC', 0.4618, 'DriftPass'); 

% HU640 straight section
SDHU640a = drift('SDHU640a',  1.7394, 'DriftPass');
SDHU640b = drift('SDHU640b',  0.64, 'DriftPass');
SDHU640c = drift('SDHU640c',  3.2795, 'DriftPass');
SDHU640d = drift('SDHU640d',  3.1195, 'DriftPass');
SDHU640e = drift('SDHU640e',  0.64, 'DriftPass');
SDHU640f = drift('SDHU640f',  1.8994, 'DriftPass');

%% QUADRUPOLES (compensation de l'effet des défauts de focalisation des
LQC = 0.180100E+00*2;
LQL = 0.248100E+00*2;
Q1   =  quadrupole('Q1' , LQC, -0.1162513E+01, 'QuadLinearPass');
Q2   =  quadrupole('Q2' , LQL,  0.1684635E+01, 'QuadLinearPass');
Q3   =  quadrupole('Q3' , LQC, -0.6900854E+00, 'QuadLinearPass');
Q4   =  quadrupole('Q4' , LQC, -0.1209553E+01, 'QuadLinearPass');
Q5   =  quadrupole('Q5' , LQC,  0.1699387E+01, 'QuadLinearPass');
Q6   =  quadrupole('Q6' , LQC, -0.1173207E+01, 'QuadLinearPass');
Q7   =  quadrupole('Q7' , LQL,  0.2016571E+01, 'QuadLinearPass');
Q8   =  quadrupole('Q8' , LQC, -0.1325158E+01, 'QuadLinearPass');
Q9   =  quadrupole('Q9' , LQC, -0.1377265E+01 , 'QuadLinearPass');
Q10  =  quadrupole('Q10', LQC,  0.1735168E+01 , 'QuadLinearPass');
Q11  =  quadrupole('Q11', LQC, -0.1695592E+01 , 'QuadLinearPass');
Q12  =  quadrupole('Q12', LQL,  0.1695717E+01, 'QuadLinearPass');


%% SEXTUPOLES chromaticités nulles dans TracyII
%avec defauts de focalisation des dipoles
%P. Brunelle 02/05/06
F = 1e8;
Finv = 1/F;

S1  =  sextupole('S1' , Finv,  0.300*5*F, 'StrMPoleSymplectic4Pass');
S2  =  sextupole('S2' , Finv, -0.715*5*F, 'StrMPoleSymplectic4Pass');
S3  =  sextupole('S3' , Finv, -0.338*5*F, 'StrMPoleSymplectic4Pass');
S4  =  sextupole('S4' , Finv,  0.697*5*F, 'StrMPoleSymplectic4Pass');
S5  =  sextupole('S5' , Finv, -0.672*5*F, 'StrMPoleSymplectic4Pass');
S6  =  sextupole('S6' , Finv,  0.667*5*F, 'StrMPoleSymplectic4Pass');
S7  =  sextupole('S7' , Finv, -0.992*5*F, 'StrMPoleSymplectic4Pass');
S8  =  sextupole('S8' , Finv,  0.778*5*F, 'StrMPoleSymplectic4Pass');
S9  =  sextupole('S9' , Finv, -0.791*5*F, 'StrMPoleSymplectic4Pass');
S10 =  sextupole('S10', Finv,  0.468*5*F, 'StrMPoleSymplectic4Pass');

%% Skew quadrupoles
QT    =  skewquad('SkewQuad', 1e-8, 0.0, 'StrMPoleSymplectic4Pass');
QTPX2    =  skewquad('QTPX2', 1e-10, 0.0, 'StrMPoleSymplectic4Pass');

%% Slow feedback correctors
COR  =  corrector('COR',0.0,[0 0],'CorrectorPass');

%% PX2C H-correctors
PX2 =  corrector('PX2C',0.0,[0 0],'CorrectorPass');
PX2C= [QTPX2 PX2];

%% Machine study kickers
KEMH =  corrector('KEMH',0.0,[0 0],'CorrectorPass');
KEMV =  corrector('KEMV',0.0,[0 0],'CorrectorPass');

%% HU640
HCMHU640 =  corrector('HCMHU640',0.0,[0 0],'CorrectorPass');
VCMHU640 =  corrector('VCMHU640',0.0,[0 0],'CorrectorPass');

HU640upstream   = [SDHU640a VCMHU640 SDHU640b HCMHU640 SDHU640c];
HU640downstream = [SDHU640d HCMHU640 SDHU640e VCMHU640 SDHU640f];

%% Fast feedback correctors
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
    SD1a   PtINJ   SD1b   K3  SD1c1 FCOR  SD1c2  KEMH SD1c3   K4     SD1d ...
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
    BEND   SD7    Q6    SD5     SX7    SD41   ...
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
    BPM     SD9a   Q5      SD12   ...
    SX4  SDB4  BPM     SD10a Q5     SD93 ...
    BPM  SDB17  SX3     SD8    Q4     SD7   ...
    BEND    SD6     SX2      SD5     Q3     SD141 ...
    BPM  SDB18  Q2     SD3   SX1     SD2     Q1 ...
    SDC20 FCOR  SDC21   BPM     HU640upstream  ];

SUP2  = [  ...
    HU640downstream  BPM SDC2 FCOR SDC1   ...
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
    BPM     SD9a   Q5      SD12   ...
    SX4   SDB4  BPM     SD10a   Q5     SD93 ...
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
    FCOR  SDC2  BPM     SDPX2a PX2C SDPX2b PX2C SDPX2b PX2C SDPX2c  ...
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
    BPM     SD9a   Q5      SD12   ...
    SX4   SDB4  BPM     SD10a    Q5     SD93 ...
    BPM  SD42  SX3     SD8    Q4     SD7   ...
    BEND    SD6     SX2      SD5     Q3     SD141 ...
    BPM  SDB18  Q2     SD3   SX1     SD2     Q1 ...
    SDC1 FCOR  SDC2   BPM     SDNSC1 Q11 SDNSC2 Q12];
%    SDC1 FCOR  SDC2   BPM     SD1e  ];

%SUP4  = [  ...
%    SD1e  BPM SDC2 FCOR SDC1   ...
SUP4  = [  ...
    SDNSC2 Q11 SDNSC1 BPM SDC2 FCOR SDC1   ...
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
    BPM     SD9a   Q5      SD12   ...
    SX4   SDB4  BPM     SD10a    Q5     SD93 ...
    BPM  SD42  SX3     SD8    Q4     SD7   ...
    BEND    SD6     SX2      SD5     Q3     SD141 ...
    BPM  SDB18  Q2     SD3   SX1     SD2     Q1 ...
    SDC22   BPM  SDC23e  FCOR SDC23f K1 SDC23b ...
    KEMV SDC23c K2 SDC23d SDC24];


ELIST = [DEBUT INJ SECT1 SUP1 SECT2 SUP2 SECT3 SUP3 SECT4 SUP4 CAV FIN];
%ELIST = [DEBUT INJ SECT1 SUP1 SECT2 SUP2 SECT3 SUP3 SECT4 SUP4 FIN];

buildlat(ELIST);

% Set all magnets to same energy
THERING = setcellstruct(THERING,'Energy',1:length(THERING),GLOBVAL.E0);

ATIndexList = atindex;
% set PX2 chicane
THERING{ATIndexList.PX2C(1)}.KickAngle(1) =  -2.25e-3; % rad
THERING{ATIndexList.PX2C(2)}.KickAngle(1) = 2*2.25e-3; % rad
THERING{ATIndexList.PX2C(3)}.KickAngle(1) =  -2.25e-3; % rad

evalin('caller','global THERING FAMLIST GLOBVAL');

% set nanoscopium triplets upstream and downstream of SDL13
THERING = setNanoscopium(THERING,ATIndexList);

atsummary;

if nargout
    varargout{1} = THERING;
end

function THERING= setNanoscopium(THERING,ATIndexList)

QP1N = -0.1269903E+01;
QP2N =  0.1859323E+01;
QP3N = -0.1143006E+01;
THERING = setquad(THERING, ATIndexList.Q1(6), QP1N);
THERING = setquad(THERING, ATIndexList.Q1(7), QP1N);
THERING = setquad(THERING, ATIndexList.Q2(6), QP2N);
THERING = setquad(THERING, ATIndexList.Q2(7), QP2N);
THERING = setquad(THERING, ATIndexList.Q3(6), QP3N);
THERING = setquad(THERING, ATIndexList.Q3(7), QP3N);

function THERING = setquad(THERING, Idx, K)

THERING{Idx}.K = K;
THERING{Idx}.PolynomB(2) = K;
fprintf('%s %03d %+f %+f\n', THERING{Idx}.FamName, Idx, THERING{Idx}.K, THERING{Idx}.PolynomB(2));

