function varargout = TDR_017_064_r56_02_sx_Dff

% {**************************************************************************}
% {                                                                          }
% { Tracy3 lattice for the ThomX ring.                                       }
% {         Modified By Jianfeng Zhang @ LAL, 03/06/2014                     }
% {         based on the lattice written by Alex Loulergue @ SOLEIL          }
% {        TDR_0.17_0.64_r56_0.2_sx_Dff.str                                  }
% {                                                                          } 
% { *** VERSION ***                                                          } 
% { BETA-LNS v8.03 /11/03/13/ 2014/05/23 15:53:4                             }    
% {*** AUTHOR ***                                                            }
% {                                                                          }
% { *** TITRE ***                                                            }
% { Thomx- hexagone tune=3.17/1.64 chro=0/0  r56=-0.22  LDff=83.5mm  h=30    } 
% {                                                                          }
% {**************************************************************************}
global FAMLIST  THERING  GLOBVAL

GLOBVAL.E0 = 50E6;
GLOBVAL.LatticeFile  = mfilename;
FAMLIST = cell(0);

disp(['** Loading THOMX ring lattice ',mfilename]);

L0 =  17.98669;   % the 6D COD of ThomX ring is very sensitive to the 
             %   longitudinal setting, so defind the 
             %   value of L0 as the value getting from "getcircumfenrence"!!!
C0 = 2.99792458e8; % speed of light [m/s]
% HarmNumber = 28.0899; % RF harmonic number
 HarmNumber = 30; % RF harmonic number

 
 %% ======================
%  RF Cavity
% =======================
%              NAME   L     U[V]       f[Hz]          h        method
CAV = rfcavity('CAV', 0.0,  300e3, HarmNumber*C0/L0, HarmNumber, ...
               'CavityPass');


%{****************}
%{      Drift     }
%{****************}
 
 
 SD0  = drift('SD0', 0.1000000E+00, 'DriftPass');
 SD1  = drift('SD1', 0.1300000E+00, 'DriftPass');
 SD1S1= drift('SD1S1', 0.2450000E+00, 'DriftPass');
 SD1S = drift('SD1S', 0.7500000E-01, 'DriftPass');
 SD2  = drift('SD2', 0.2100000E+00, 'DriftPass');
 SD3S = drift('SD3S', 0.7500000E-01, 'DriftPass');
 SD3S1= drift('SD3S1', 0.1400000E+00, 'DriftPass');
 SD3S2= drift('SD3S2', 0.1250000E+00, 'DriftPass');
 SD3  = drift('SD3', 0.2350000E+00, 'DriftPass');
 SD31 = drift('SD31', 0.7537500E+00, 'DriftPass');
 SD4  = drift('SD4', 0.1500000E+00, 'DriftPass');
 SD5  = drift('SD5', 0.8000000E+00, 'DriftPass');

 SD31h= drift('SD31h', 0.7537500E+00/2, 'DriftPass');

%{*****************}
%{      Dipole     }
%{*****************}

beta_gap=0.04;
%{tracy_gap=beta_gap*2*1/6;}
%{Due to the Tanh-like fringe field, K1=0.2, and tracy_gap = gap * FINT (K brown para.)}
tracy_gap = beta_gap*2*0.348;

 COE = drift('COE', 0.0000000E+00, 'DriftPass');
 DIP = rbend3('BEND',0.27646,0.785398, 0.0, 0.0,0.0,tracy_gap,1,1,'BndMPoleSymplecticNew4Pass');
 COS = drift('COS', 0.0000000E+00, 'DriftPass');


%{*********************}
%{     Quadrupole      }
%{*********************}
QPassMethod = 'StrMPoleSymplectic4Pass';

 QP1 = quadrupole('QP1', 0.15, -0.4477139E+01, QPassMethod);
 QP2 = quadrupole('QP2', 0.15, 0.9230164E+01, QPassMethod);
 QP3 = quadrupole('QP3', 0.15, -0.1768641E+02, QPassMethod);
 QP4 = quadrupole('QP4', 0.15, 0.1505913E+02, QPassMethod);
 QP31= quadrupole('QP31', 0.15, -0.1204307E+02, QPassMethod);
 QP41= quadrupole('QP41', 0.15, 0.8689866E+01, QPassMethod);

%{********************}
%{      Sextupole     }
%{********************}
sx_on = 1; 

 SPassMethod = 'StrMPoleSymplectic4Pass';

 SX1 = sextupole('SX1', 0.1000000E-05, -0.6204968E+07*sx_on, SPassMethod); 
 SX2 = sextupole('SX2', 0.1000000E-05,  0.2381947E+07*sx_on, SPassMethod); 
 SX3 = sextupole('SX3', 0.1000000E-05, -0.3115290E+07*sx_on, SPassMethod); 


%{**************}
%{   marker     } 
%{**************}
DEBUT =  marker('DEBUT','IdentityPass');
FIN   =  marker('FIN','IdentityPass');

%{**************}
%{  injection   }
%{**************}
 SEPT = marker('SEPT','IdentityPass');
 KICKer = marker('KICKer','IdentityPass');

%{*********************}
%{   RING   LATTICE    }
%{*********************}

ELIST = [DEBUT,    SEPT,...
 SD5,           QP1,           SD2,           QP2, ... 
 SD31h,         KICKer,          SD31h,...
 COE,          DIP,           COS,...         
 SD3S2,        ...
 SX1,           SD3S,          QP31,          SD3S,...          
 SX3,           SD3S1,         QP41,          SD1S1,         SX2,...
 SD1S,          QP4,           SD2,           QP3,...   
 SD3,... 
 COE,           DIP,           COS,...          
 SD0,           SD0,...           
 COE,           DIP,          COS,...       
 SD3,           QP3,          SD2,           QP4,           SD1S,...
 SX2,           SD1S1,         QP41,          SD3S1,         SX3,...
 SD3S,          QP31,          SD3S,          SX1,...  
 SD3S2,...        
 COE,           DIP,          COS,...           
 SD31,          QP2,           SD2,           QP1,           SD5,...
 SD5,           QP1,           SD2,           QP2,           SD31,...
 COE,           DIP,           COS,...           
 SD3S2,         SX1,           SD3S,          QP31,         SD3S,...
 SX3,           SD3S1,         QP41,          SD1S1,        SX2,...
 SD1S,          QP4,           SD2,           QP3,          SD3,...
 COE,           DIP,           COS,...           
 SD0,           SD0,...           
 COE,           DIP,          COS,...           
 SD3,           QP3,           SD2,           QP4,           SD1S,...
 SX2,           SD1S1,         QP41,          SD3S1,         SX3,...
 SD3S,          QP31,          SD3S,          SX1,           SD3S2,...
 COE,           DIP,           COS,           SD31h,         KICKer,...
 SD31h,          QP2,           SD2,           QP1,           SD5,...     
 SEPT,  CAV,           FIN]; 
          
buildlat(ELIST);
      
THERING = setcellstruct(THERING,'Energy',1:length(THERING), ...
                                GLOBVAL.E0);
evalin('caller','global THERING FAMLIST GLOBVAL');

atsummary;

if nargout
  varargout{1} = THERING;
end
