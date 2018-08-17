function varargout = CDR_017_064_r56_02_sx_Dff_1_cro0_NoDipFF  
%************************************************
%
%  AT (Accelerator Toolbox) file 
%
%  This is a test lattice of the ThomX ring:
%   dipole fringe field is zero.
%
%    Based on the original lattice written by 
%    writen by Alex Loulergue: 
%    BETA lattice-LNS v7.80 /14/11/11/ 11-Mar-13 11:49:20 
%"CDR_0.17_0.64_r56_0.2_sx_Dff_1_cro0_NoDipFF.str"
%Thomx- hexagone tune=3.17/1.64 chro=0/0  r56=-0.22  LDff=83.5mm                
% 
%                                            
%
%Modified by Jianfeng Zhang @ LAL, 03/2013 for AT.
%*************************************************** 


global FAMLIST THERING GLOBVAL
 
 
 GLOBVAL.E0 = 50e6; % Ring energy [eV]
 GLOBVAL.LatticeFile = mfilename;
 FAMLIST = cell(0);
 
 disp(['** Loading THOMX ring lattice ', mfilename]);
 
 L0 = 16.8;% design circumference length [m]
 C0 = 2.99792458e8; % speed of light [m/s]
 %HarmNumber = 28.0899; % RF harmonic number
 HarmNumber = 46; % RF harmonic number

    %% Lattice definition

%% ======================
%  RF Cavity
% =======================
%              NAME   L     U[V]       f[Hz]          h        method
%CAV = rfcavity('CAV' , 0.0 , 0*300.0e+3 , HarmNumber*C0/L0, HarmNumber ,'CavityPass');
RF = rfcavity('RF' , 0.0 , 0 , HarmNumber*C0/L0, HarmNumber,'CavityPass');
 
%!------------------------------------}
%! DRIFT                              }
%!------------------------------------} 
SD0        =drift('SD0',0.1000000E+00, 'DriftPass');
SD1        =drift('SD1',0.1300000E+00, 'DriftPass');
SD1S1      =drift('SD1S1', 0.2000000E+00, 'DriftPass');
SD1S       =drift('SD1S', 0.6000000E-01, 'DriftPass');
SD2        =drift('SD2', 0.2000000E+00, 'DriftPass');
SD3        =drift('SD3', 0.2000000E+00, 'DriftPass');
SD31       =drift('SD31', 0.6000000E+00, 'DriftPass');
SD4        =drift('SD4', 0.1500000E+00, 'DriftPass');
SD5        =drift('SD5', 0.7871000E+00, 'DriftPass');
SD3S       =drift('SD3S', 0.6000000E-01, 'DriftPass');
SD3S1      =drift('SD3S1', 0.1400000E+00, 'DriftPass');

%!------------------------------------}
%! DIPOLE                             }
%!------------------------------------}
L = 0.27646;
theta = 0.785398;
thetae = 0.0;
thetas = 0.0;
K =0.0;  %quadrupole component in the dipole
edge_effect1 = 0;
edge_effect2 = 0;
COE = drift('COE',0.0,'DriftPass');
COS = drift('COS',0.0,'DriftPass');
BEND = rbend2('BEND', L, theta, thetae, thetas, K, 0.0,...
              'BndMPoleSymplectic4Pass'); 
          
% DIP = rbend3('DIP', L, theta, thetae, thetas, K, 0.0,...
%               edge_effect1,edge_effect2,'BndMPoleSymplecticNew4Pass'); 


%!------------------------------------}
%! QUADRUPOLE                         }
%!------------------------------------}      
 LQP = 0.15; % quadrupole length
 QPassMethod = 'StrMPoleSymplectic4Pass'; % tracking method
 QP1=quadrupole('QP1',LQP,-.4206018E+01,QPassMethod);
 QP2=quadrupole('QP2',LQP,0.9886623E+01,QPassMethod);
 QP3=quadrupole('QP3',LQP,-.1805450E+02,QPassMethod);
 QP4=quadrupole('QP4',LQP,0.1549883E+02,QPassMethod);
 QP31=quadrupole('QP31',LQP,-.1192025E+02,QPassMethod);
 QP41=quadrupole('QP41',LQP,0.9056717E+01,QPassMethod);

 
%!----------------------------------}
%! SEXTUPOLE                        }
%!----------------------------------}
LSX = 0.1000000E-05;
SPassMethod = 'StrMPoleSymplectic4Pass';

 SX1        =sextupole('SX1', LSX, -.8374793E+07*1, SPassMethod);
 SX2        =sextupole('SX2', LSX, 0.2416536E+07*1, SPassMethod);
 SX3        =sextupole('SX3', LSX, -.1901670E+07*1, SPassMethod);
 
 %% =======================
% BPM
%========================
% horizontal
BPMx = marker('BPMx', 'IdentityPass');
% vertical
BPMz = marker('BPMz', 'IdentityPass');
 
%% =======================
% correctors
%=========================
%
 HCOR = corrector('HCOR',1.0e-6,[0.0, 0],'CorrectorPass');
 
 VCOR = corrector('VCOR',1.0e-6,[0, 0.0],'CorrectorPass');

%=====================================
% !MARKER                 
%=====================================
DEBUT =  marker('DEBUT','IdentityPass');
FIN   =  marker('FIN','IdentityPass');


%!=====================================}
%! RING LATTICE                        }  
%!=====================================}

ELIST=[DEBUT, ...
 SD5        BPMx        BPMz      QP1        SD2... 
 QP2        SD31       COE...       
 BEND        COS        SD3S1      SX1        HCOR...
 VCOR       SD3S       QP31...      
 SD3S       SX3        HCOR       VCOR       SD3S1...
 QP41       BPMx       BPMz       SD1S1      SX2... 
 HCOR       VCOR...
 SD1S       QP4        SD2        QP3        SD3...
 BPMx       BPMz       COE...       
 BEND        COS        SD0        SD0        COE...
 BEND...       
 COS        SD3        BPMx       BPMz       QP3        SD2        QP4...
 SD1S       HCOR       VCOR...      
 SX2        SD1S1      BPMx       BPMz       QP41       SD3S1      SX3...
 HCOR       VCOR       SD3S...      
 QP31       SD3S       HCOR       VCOR       SX1...
 SD3S1      COE...
 BEND...       
 COS        SD31       QP2        SD2        QP1...
 BPMx       BPMz       SD5...       
 SD5        BPMx       BPMz       QP1        SD2        QP2        SD31...
 COE...       
 BEND        COS        SD3S1      SX1        HCOR...
 VCOR       SD3S...
 QP31...      
 SD3S       SX3        HCOR       VCOR       SD3S1...
 QP41       BPMx       BPMz       SD1S1...
 HCOR       VCOR       SX2...       
 SD1S       QP4        SD2        QP3        SD3...
 BPMx       BPMz       COE...       
 BEND        COS        SD0        SD0        COE...
 BEND...       
 COS        SD3        BPMx       BPMz       QP3        SD2        QP4...
 SD1S       HCOR       VCOR...      
 SX2        SD1S1      BPMx       BPMz       QP41       SD3S1      SX3...
 HCOR       VCOR       SD3S...      
 QP31       SD3S       SX1        HCOR       VCOR...
 SD3S1      COE...
 BEND...       
 COS        SD31       QP2        SD2        QP1...
 BPMx       BPMz       SD5...       
 RF,        FIN];

buildlat(ELIST);

% Set all magnets to same energy
THERING = setcellstruct(THERING,'Energy',1:length(THERING),GLOBVAL.E0);

    
evalin('caller','global THERING FAMLIST GLOBVAL');

% print the summary of the lattice
atsummary;

if nargout
    varargout{1} = THERING;
end



    
