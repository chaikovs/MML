function varargout = TLlattice
% Lattice definition file
% Lattice for ThomX transfer line
%
%
%
%
%  (1) By Jianfeng Zhang @ LAL, 24/02/2014
%         Need to check the definition of BEND1 and BEND2 in the future.
%         The simualtion model seems to be questionable.
%
%
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
 SD1L  = drift('SD1L', 0.200000E+00,'DriftPass');
 SD2L  = drift('SD2L', 0.200000E+00,'DriftPass');
 SD4L  = drift('SD4L', 0.400000E+00,'DriftPass');
 SD31L = drift('SD31L', 0.500000E+00,'DriftPass');
 SD32L = drift('SD32L', 0.300000E+00,'DriftPass');
 SDDL  = drift('SDDL', 0.10000E+00,'DriftPass');
 SDDL1 = drift('SDDL1', 0.106000E+01,'DriftPass');
 SDDL2 = drift('SDDL2', 0.121500E+00,'DriftPass');
 SDDL3 = drift('SDDL3', 0.1918500E+01,'DriftPass');
 SDIL2 = drift('SDIL2', 0.145000E+01,'DriftPass');
 SDIL3 = drift('SDIL3', 0.3300000E+01,'DriftPass');
 SDIL31 = drift('SDIL31', 0.1000000E+00,'DriftPass');
 SDIL32 = drift('SDIL32', 0.2570000E+00,'DriftPass');
 SDIL21 = drift('SDIL21', 0.186840E+01,'DriftPass');
 SDIL22 = drift('SDIL22', 0.486000E+00,'DriftPass');
 SDIL23 = drift('SDIL22', 0.588600E+00,'DriftPass');


%% QUADRUPOLES 
LQP= 0.15; %Quadrupole length
QPassMethod = 'StrMPoleSymplectic4Pass'; % tracking method


QP1L  =  quadrupole('QP1L', LQP, 0.0000000E+00, QPassMethod);
QP2L  =  quadrupole('QP2L', LQP, 0.9948792E+01, QPassMethod);
QP3L  =  quadrupole('QP3L', LQP,-0.9966793E+01, QPassMethod);
QP4L  =  quadrupole('QP4L', LQP, 0.6937059E+01, QPassMethod);
QP5L  =  quadrupole('QP5L', LQP, 0.6902230E+01, QPassMethod);
QP6L  =  quadrupole('QP6L', LQP,-0.1141482E+02, QPassMethod);
QP7L  =  quadrupole('QP7L', LQP, 0.1126759E+02, QPassMethod);


%% DIPOLES

% main dipoles, bending angle 45 degree, the same as the ones in the ring.
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


% small injection dipole
Ldil3 = 0.2009579;
thetadil3=0.169000;
thetae_1 = 0.0;
thetas_1 = 0.169;
K_1 =0.0;
fullgap_1 = 0.0;
	       
BEND2  =  rbend3('BEND2', Ldil3, thetadil3, thetae_1, thetas_1, K_1, fullgap_1,0,0, ...
               'BndMPoleSymplecticNew4Pass');

	       
CO3E = drift('CO3E',0.0,'DriftPass');
CO3S = drift('CO3S',0.0,'DriftPass');
	       
%%Marker

DEBUT = drift('DEBUT',0.0,'DriftPass');
FIN = drift('FIN',0.0,'DriftPass');
	      

% Lattice
% definition of BPMX must be followed by BPMz
ELIST =[DEBUT ...
 SD1L   HCOR    VCOR    SD1L     QP1L     SD2L    QP2L     SD2L   QP3L ...
 SD1L   BPMx    BPMz    SD31L    BEND1    SDDL     BEND1   SD4L   QP4L...
 SDDL1  HCOR    VCOR 	SDDL2    BPMx    BPMz     SDDL3  QP5L    SD4L     BEND1   SDDL ...
 BEND1   SD32L   QP6L    SD2L     QP7L    SDIL31   BPMx   BPMz   SDIL32  HCOR   VCOR    ...
 SDIL21 BPMx    BPMz    SDIL22   HCOR    VCOR     SDIL23 CO3E   BEND2    CO3S    SDIL2 ...
        FIN];

buildlat(ELIST);

% Set all magnets to same energy
THERING = setcellstruct(THERING,'Energy',1:length(THERING),GLOBVAL.E0);

evalin('caller','global THERING FAMLIST GLOBVAL');
disp('** Done **');


