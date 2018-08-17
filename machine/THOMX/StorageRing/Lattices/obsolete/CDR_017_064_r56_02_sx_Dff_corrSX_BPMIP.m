function varargout = CDR_017_064_r56_02_sx_Dff_corrSX_BPMIP 
%!!****************************************************        }
%! Nominal lattice of Thom-X for AT, with zero dispersion }
%! in the straight sections.                                   }
%!                                                             }
%! Based on                                                    }
%! BETA-LNS v7.70 /26/09/08/  3-Jan-12 14:43:44                }
%! *** AUTHOR ***                                              }
%!              Jianfeng Zhang @ LAL  14/02/2012               }
%!****************************************************         }

global FAMLIST  THERING  GLOBVAL

GLOBVAL.E0 = 50E6;
GLOBVAL.LatticeFile  = mfilename;
FAMLIST = cell(0);

disp(['** Loading THOMX ring lattice ',mfilename]);

L0 =   16.800115999999992;   % the 6D COD of ThomX ring is very sensitive to the 
             %   longitudinal setting, so defind the 
             %   value of L0 as the value getting from "getcircumfenrence"!!!
C0 = 2.99792458e8; % speed of light [m/s]
% HarmNumber = 28.0899; % RF harmonic number
 HarmNumber = 28; % RF harmonic number

 %% ======================
%  RF Cavity
% =======================
%              NAME   L     U[V]       f[Hz]          h        method
RF = rfcavity('RF', 0.0,  300e3, HarmNumber*C0/L0, HarmNumber, ...
               'CavityPass');



%!------------------------------------}
%! DRIFT                              }
%!------------------------------------}
 SD0        = drift('SD0',0.1000000E+00,'DriftPass');
 SD1        = drift('SD1',0.1300000E+00,'DriftPass');
 SD1S1      = drift('SD1S1',0.2000000E+00,'DriftPass');
 SD1S       = drift('SD1S',0.6000000E-01,'DriftPass');

 SD2        = drift('SD2',0.2000000E+00,'DriftPass');
 SD3        = drift('SD3',0.2000000E+00,'DriftPass');
 SD31       = drift('SD31',0.6000000E+00,'DriftPass');

 SD4        = drift('SD4',0.1500000E+00,'DriftPass');
 SD5        = drift('SD5',0.7871000E+00,'DriftPass');
 SD3S       = drift('SD3S',0.6000000E-01,'DriftPass');
SD3S1      = drift('SD3S1',0.1400000E+00,'DriftPass');

% half length of SD3
SD2S = drift('SD2S', 0.1000000E+00, 'DriftPass');
%!------------------------------------}
%! DIPOLE                             }
%!------------------------------------}
%****** For Thom-X lattice ******}
beta_gap=0.04;
%tracy_gap=beta_gap*2*1/6;}
%Due to the Tanh-like fringe field, K1=0.2, and tracy_gap = gap * FINT (K brown para.)}
tracy_gap = beta_gap*2*0.348;


 COE    = drift('COE', 0.0000000E+00, 'DriftPass'); 
 BEND    = rbend3('BEND',0.27646,0.785398, 0.0, 0.0,0.0,tracy_gap,1,1,'BndMPoleSymplecticNew4Pass');
 COS    = drift('COS', 0.0000000E+00, 'DriftPass'); 

%!------------------------------------}
%! QUADRUPOLE                         }
%!------------------------------------}
QPassMethod = 'StrMPoleSymplectic4Pass';
 QP1       = quadrupole('QP1', 0.15, -0.4742248E+01, QPassMethod);

 QP2       = quadrupole('QP2', 0.15, 0.1027936E+02, QPassMethod); 

 QP3       = quadrupole('QP3', 0.15, -0.1835696E+02, QPassMethod);

 QP4       = quadrupole('QP4', 0.15, 0.1526965E+02, QPassMethod); 

 QP31       = quadrupole('QP31', 0.15, -0.1304719E+02, QPassMethod);

 QP41       = quadrupole('QP41', 0.15, 0.9634002E+01, QPassMethod); 

%!---------------------------------------------------------------------}
%! SEXTUPOLE                                                           }
%!                                                                     }
%!---------------------------------------------------------------------}

sx_on=1;
SPassMethod = 'StrMPoleSymplectic4Pass';

 % SX1        = sextupole('SX1', 0.06e-10, -3.91653e+12/2, SPassMethod);
 % SX2        = sextupole('SX2', 0.06e-10, 7.19423e+11/2, SPassMethod);
 % SX3        = sextupole('SX3', 0.06e-10, -0.1903113E+07*sx_on*0, SPassMethod);

 SX1       = sextupole('SX1', 0.1000000E-05, -0.8375307E+07*sx_on, SPassMethod);
 SX2       = sextupole('SX2', 0.1000000E-05,  0.2405303E+07*sx_on, SPassMethod);
 SX3       = sextupole('SX3', 0.1000000E-05, -0.1903113E+07*sx_on, SPassMethod);

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
ELIST = [DEBUT,...
         SD5,    BPMx,   BPMz,... 
         QP1,    SD2,    QP2,    SD31,    COE, ...
         BEND,   COS,    SD3S1,...  
         SX1,     HCOR,  VCOR, ...
         SD3S,...
         QP31,...
         SD3S,   SX3,    HCOR,   VCOR,... 
         SD3S1,  QP41,   BPMx,   BPMz,...
         SD1S1,  SX2,    HCOR,   VCOR,...
         SD1S,   QP4,    SD2,    QP3,    SD2S,...    
         BPMx,   BPMz,   SD2S,...
         COE,...
         BEND,   COS,    SD0,    SD0,     COE,...
         BEND,...  
         COS,    SD2S,   BPMx,   BPMz,    SD2S,...
         QP3,    SD2,    QP4,     SD1S,...
         SX2,    HCOR,   VCOR,...
         SD1S1,  BPMx,   BPMz,...
         QP41,   SD3S1,  SX3,   HCOR,   VCOR,...     
         SD3S,...   
         QP31,   SD3S,   SX1,   HCOR,   VCOR,...    
         SD3S1,  COE,     BEND,...       
         COS,    SD31,   QP2,    SD2,    QP1,...
         BPMx,   BPMz,...
         SD5,...
         SD5,    BPMx,   BPMz,...   
         QP1,    SD2,    QP2,    SD31,    COE,...
         BEND,   COS,    SD3S1,  ...
         SX1,    HCOR,   VCOR,...
         SD3S,...
         QP31,...    
         SD3S,   SX3,    HCOR,   VCOR,...
         SD3S1,  QP41,   BPMx,   BPMz,...
         SD1S1,  SX2,    HCOR,   VCOR,...
         SD1S,   QP4,    SD2,    QP3,    SD2S,...
         BPMx,   BPMz,   SD2S,   COE,...
         BEND,   COS,    SD0,    SD0,     COE,...
         BEND,...       
         COS,    SD2S,    BPMx,  BPMz,    SD2S...
         QP3,    SD2,    QP4,     SD1S,...
         SX2,    HCOR,   VCOR,...
         SD1S1,  BPMx,   BPMz,...
         QP41,   SD3S1,  SX3,   HCOR,   VCOR,...  
         SD3S,...
         QP31,   SD3S,   SX1,   HCOR,   VCOR,... 
         SD3S1,  COE,     BEND,...   
         COS,    SD31,   QP2,    SD2,    QP1, BPMx, BPMz,...    
         SD5,...
         RF,     FIN];
 

buildlat(ELIST);
      
THERING = setcellstruct(THERING,'Energy',1:length(THERING), ...
                                GLOBVAL.E0);
evalin('caller','global THERING FAMLIST GLOBVAL');

atsummary;

if nargout
  varargout{1} = THERING;
end


