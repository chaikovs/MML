function varargout = TLlattice
% Lattice definition file
% Lattice for ThomX transfer line with leq for the quadrupoles and 30
% periods
%


global FAMLIST THERING GLOBVAL
GLOBVAL.E0 = 50e6; % Ring energy
GLOBVAL.LatticeFile = mfilename;
FAMLIST = cell(0);

disp(['** Loading THOMX transfer line lattice ', mfilename]);

%%=======================
% BPM
%========================
% horizontal
BPMx = marker('BPMx', 'IdentityPass');
% vertical
BPMz = marker('BPMz', 'IdentityPass');

%%=======================
% correctors
%========================
 HCOR = corrector('HCOR',1.0e-6,[0, 0],'CorrectorPass');
 
 VCOR = corrector('VCOR',1.0e-6,[0, 0],'CorrectorPass');



%% DRIFT SPACES
 SD1L1  = drift('SD1L1', 0.300000E+00,'DriftPass');
 SD1L2  = drift('SD1L2', 0.0953000E+00,'DriftPass');
 SD2L  = drift('SD2L', 0.190600E+00,'DriftPass');
 SD3L  = drift('SD3L', 0.075300E+00,'DriftPass');
 SD3L1  = drift('SD3L1', 0.1205000E+00,'DriftPass');
 SD3L2  = drift('SD3L2', 0.4995000E+00,'DriftPass');
 SD4L  = drift('SD4L', 0.395300E+00,'DriftPass');
 SDDL1 = drift('SDDL1', 0.114760E+01,'DriftPass');
 SDDL2 = drift('SDDL2', 0.118000E+00,'DriftPass');
 SDDL3 = drift('SDDL3', 0.1858050E+01,'DriftPass');
 SDIL31 = drift('SDIL31', 0.1058000E+00,'DriftPass');
 SDIL32 = drift('SDIL32', 0.2570000E+00,'DriftPass');
 SDIL21 = drift('SDIL21', 0.1344770E+01,'DriftPass');
 SDIL22 = drift('SDIL22', 0.118000E+00,'DriftPass');
 SDIL23 = drift('SDIL23', 0.753500E+00,'DriftPass');
 SDIL2 = drift('SDIL2', 0.185000E+01,'DriftPass');
 SDDL  = drift('SDDL', 0.20000E+00,'DriftPass');


%% QUADRUPOLES 
LQP= 0.1594; %Quadrupole length
QPassMethod = 'StrMPoleSymplectic4Pass'; % tracking method


QP1L  =  quadrupole('QP1L', LQP, -0.2937140E+00, QPassMethod);
QP2L  =  quadrupole('QP2L', LQP, 0.9533940E+01, QPassMethod);
QP3L  =  quadrupole('QP3L', LQP,-0.9021910E+01, QPassMethod);
QP4L  =  quadrupole('QP4L', LQP, 0.5539960E+01, QPassMethod);
QP5L  =  quadrupole('QP5L', LQP, 0.4800870E+01, QPassMethod);
QP6L  =  quadrupole('QP6L', LQP,-0.9601260E+01, QPassMethod);
QP7L  =  quadrupole('QP7L', LQP, 0.1045480E+02, QPassMethod);
QP1 = quadrupole('QP1', LQP, -0.4327698E+01, QPassMethod);
QP2 = quadrupole('QP2', LQP, 0.9150185E+01, QPassMethod);       

%% =======================
% dipole anneau
%========================
L = 0.2000042;
theta = -0.1100000E-01;
thetae = 0.0;
thetas = 0.0;
K =0.0;
fullgap = 0.0;
edge_effect1 = 1;
edge_effect2 = 1;

BEND  =  rbend3('BEND', L, theta, thetae, thetas, K,fullgap,edge_effect1,edge_effect2, ...
               'BndMPoleSymplecticNew4Pass');
 %DIP=         rbend2('DIP', L, theta, thetae, thetas, K,fullgap, ...
 %             'BndMPoleSymplectic4Pass');

COE = drift('COE',0.0,'DriftPass');
COS = drift('COS',0.0,'DriftPass');


%% DIPOLES TL
L = 0.27646;
theta = 0.785398;
thetae = 0.0;
thetas = 0.0;
K =0.0;
fullgap=0;
edge_effect1 = 0;
edge_effect2 = 0;

BEND1  =  rbend3('BEND1', L, theta, thetae, thetas, K,fullgap,edge_effect1,edge_effect2, ...
               'BndMPoleSymplecticNew4Pass');


Ldil3 = 0.2009579;
%Ldil3 = 0.21169;
thetadil3=0.169000;
thetae_1 = 0.0;
thetas_1 = 0.169;
thetas_1= 0
K_1 =0.0;
fullgap_1 = 0.0;
	       
BEND2  =  rbend3('BEND2', Ldil3, thetadil3, thetae_1, thetas_1, K_1, fullgap_1,0,0, ...
               'BndMPoleSymplecticNew4Pass');

	       
CO3E = drift('CO3E',0.0,'DriftPass');
CO3S = drift('CO3S',0.0,'DriftPass');

%Septum

Lsept = 0.251072;
thetasept=-0.16000;
thetae_2 = -0.160;
thetas_2 = 0.0;
K_2 =0.0;
fullgap_2 = 0.0;
	       
SEP  =  rbend3('SEP', Lsept, thetasept, thetae_2, thetas_2, K_2, fullgap_2,0,0, ...
               'BndMPoleSymplecticNew4Pass');


	       
%%Marker

DEBUT = drift('DEBUT',0.0,'DriftPass');
FIN = drift('FIN',0.0,'DriftPass');
	      

% Lattice
ELIST =[DEBUT ...
 SD1L1   HCOR    VCOR    SD1L2     QP1L     SD2L    QP2L     SD2L   QP3L ...
 SD3L   HCOR    VCOR     SD3L1     BPMx    BPMz    SD3L2    BEND1    SDDL     BEND1  ...  
 SD4L   QP4L    SDDL1  HCOR    VCOR 	SDDL2    BPMx    BPMz  ...   
 SDDL3  QP5L    SD4L     BEND1   SDDL    BEND1 ...   
 SD4L   QP6L    SD2L     QP7L    SDIL31   BPMx   BPMz   SDIL32  HCOR   VCOR    ...
 SDIL21   HCOR   VCOR     SDIL22   BPMx    BPMz    SDIL23   CO3E   BEND2    CO3S  ...  
 SDIL2 ...
FIN];

buildlat(ELIST);

% Set all magnets to same energy
THERING = setcellstruct(THERING,'Energy',1:length(THERING),GLOBVAL.E0);

evalin('caller','global THERING FAMLIST GLOBVAL');
disp('** Done **');


