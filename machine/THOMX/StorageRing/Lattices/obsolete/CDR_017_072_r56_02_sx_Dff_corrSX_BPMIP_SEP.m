function varargout = CDR_017_072_r56_02_sx_Dff_corrSX_BPMIP_SEP
%************************************************************
% ThomX ring lattice for AT (Accelrator Toolbox). 
%   Based on the Alexandre Loulergue's
%   Beta lattice file:
%     CDR_0.17_0.72_r56_0.2_sx_Dff_corrSX_BPMIP.str,
%   which has the *** VERSION ***
%   BETA-LNS v8.00 /10/07/12/ 2012/12/12 14:48:0                                    
%CLS  - hexagone - tune=3.17  1.64 - C=16.80m h=28 - corr                       
%
%
% DON'T change the Lattice element names, since
% the lattice element names are fixed in the 
% MML file: /machine/THOMX/StorageRing/updateatindex.m
%
%  Written by Jianfeng Zhang @ LAL, 22/02/2013.
%
%  Jianfeng Zhang @ LAL, 24/03/2014
%   Add septum and the injection & extraction kickers.
%     not finished yet, need to be verified....  24/03/2014...
%
%************************************************************
 
 global FAMLIST THERING GLOBVAL
 
 
 GLOBVAL.E0 = 50e6; % Ring energy [eV]
 GLOBVAL.LatticeFile = mfilename;
 FAMLIST = cell(0);
 
 disp(['** Loading THOMX ring lattice ', mfilename]);
 
 
 L0 = 16.789703999999997; % design circumference length [m]; 
                          % 6D COD of the ThomX machine is very sensitive
                          %  to the accuracy of the circumference !!!!!!!!
 C0 = 2.99792458e8; % speed of light [m/s]
% HarmNumber = 28.0899; % RF harmonic number
 HarmNumber = 28; % RF harmonic number

 %% ======================
%  RF Cavity
% ========================
%              NAME   L     U[V]       f[Hz]          h        method
RF = rfcavity('RF', 0.0,  300e3, HarmNumber*C0/L0, HarmNumber, ...
               'CavityPass');

%% =======================
% drift
%%========================
%sextupole length
LSX = 0.06;
%LSX = 0.1000000E-05;


SD0 = drift('SD0', 0.1000000E+00, 'DriftPass');
SD1 = drift('SD1', 0.1300000E+00, 'DriftPass');

SD1S1 = drift('SD1S1', 0.1950000E+00-LSX/2, 'DriftPass');
SD1S = drift('SD1S', 0.6500000E-01-LSX/2, 'DriftPass');

SD2 = drift('SD2', 0.2000000E+00, 'DriftPass');
SD3 = drift('SD3', 0.2000000E+00, 'DriftPass');
SD31 = drift('SD31', 0.6095000E+00, 'DriftPass');
SD4 = drift('SD4', 0.1500000E+00, 'DriftPass');
SD5 = drift('SD5', 0.7750000E+00, 'DriftPass');

SD3S = drift('SD3S', 0.7500000E-01-LSX/2, 'DriftPass');
SD3S1 = drift('SD3S1', 0.1250000E+00-LSX/2, 'DriftPass');

SD2S = drift('SD2S', 0.1000000E+00, 'DriftPass');

%% =======================
% dipole
%========================
L = 0.27646;
theta = 0.785398;
thetae = 0.0;
thetas = 0.0;
K =0.0;
beta_gap=0.04;
tracy_gap = beta_gap*2*0.348;
fullgap = tracy_gap;
edge_effect1 = 1;
edge_effect2 = 1;

BEND  =  rbend3('BEND', L, theta, thetae, thetas, K,fullgap,edge_effect1,edge_effect2, ...
               'BndMPoleSymplecticNew4Pass');
 %DIP=         rbend2('DIP', L, theta, thetae, thetas, K,fullgap, ...
 %             'BndMPoleSymplectic4Pass');

COE = drift('COE',0.0,'DriftPass');
COS = drift('COS',0.0,'DriftPass');

%% =======================
% quadrupole
%========================
LQP = 0.15; % quadrupole length
QPassMethod = 'StrMPoleSymplectic4Pass'; % tracking method

QP1 = quadrupole('QP1', LQP, -.5043991E+01, QPassMethod);
QP2 = quadrupole('QP2', LQP, 0.1043595E+02, QPassMethod);
QP3 = quadrupole('QP3', LQP, -.1840107E+02, QPassMethod);
QP4 = quadrupole('QP4', LQP, 0.1525533E+02, QPassMethod);
QP31 = quadrupole('QP31', LQP, -.1316000E+02, QPassMethod);
QP41 = quadrupole('QP41', LQP, 0.9683240E+01, QPassMethod);

  
%% =======================
% sextupole
%========================
SPassMethod = 'StrMPoleSymplectic4Pass';

SX1  =  sextupole('SX1' , LSX,  -.8967247E+01/LSX*1, SPassMethod);
SX2  =  sextupole('SX2' , LSX,  0.2486272E+01/LSX*1, SPassMethod);
SX3  =  sextupole('SX3' , LSX,  -.2060268E+01/LSX*1, SPassMethod);

%% =======================
% BPM
% installed before or after quadrupole
%========================
% horizontal
BPMx = marker('BPMx', 'IdentityPass');
% vertical
BPMz = marker('BPMz', 'IdentityPass');
 
%% =======================
% correctors
% the same location as sextupole
%========================
% length kick, angle x/y
 HCOR = corrector('HCOR',1.0e-6,[0.0, 0],'CorrectorPass');
 
 VCOR = corrector('VCOR',1.0e-6,[0, 0.0],'CorrectorPass');

 %%==========================
 %   MARKER
 %%==========================
 
 DEBUT = drift('DEBUT',0.0,'DriftPass');
 FIN   = drift('FIN',0.0,'DriftPass');


 %%================================
 %   septum and injection kickers
 %
 %   Pulsed magnets
 %%================================
 % 160 mrad --- 170 mrad
 SEP = corrector('SEP', 1.0e-10,[0.0,0.0],'CorrectorPass');
 
 % These two kickers are only connected to TANGO, not connected to AT
 % 11 mrad --- 15 mrad
 % injection kicker
 KICKERIN = corrector('KICKERIN', 1.0e-10,[0.0,0.0],'CorrectorPass');
 % extraction kicker 
 KICKEREX = corrector('KICKEREX', 1.0e-10,[0.0,0.0],'CorrectorPass');

 
%% Lattice definition
%=======================
% build lattice
%========================
ELIST =[DEBUT ... 
  SEP ...
  SD5           BPMx          BPMz          QP1           SD2           QP2 ...         
  SD31          COE           BEND           COS           SD3S1         SX1 ...         
  HCOR          VCOR          SD3S          QP31          SD3S          SX3 ...         
  HCOR          VCOR          SD3S1         QP41          BPMx          BPMz...         
  SD1S1         SX2           HCOR          VCOR          SD1S          QP4 ...         
  SD2           QP3           SD2S          BPMx          BPMz          SD2S...         
  COE           BEND           COS           SD0            ...
  SD0           COE           ...
  BEND           COS           SD2S          BPMx          BPMz          SD2S  ...       
  QP3           SD2           QP4           SD1S          SX2           HCOR  ...       
  VCOR          SD1S1         BPMx          BPMz          QP41          SD3S1 ...       
  SX3           HCOR          VCOR          SD3S          QP31          SD3S ...        
  SX1           HCOR          VCOR          SD3S1         COE           BEND ...         
  COS           SD31          QP2           SD2           QP1         BPMx         BPMz      ....        
                SD5           SD5           BPMx          BPMz          QP1 ...         
  SD2           QP2           SD31          COE           BEND           COS ...         
  SD3S1         SX1           HCOR          VCOR          SD3S          QP31...         
  SD3S          SX3           HCOR          VCOR          SD3S1         QP41...         
  BPMx          BPMz          SD1S1         SX2           HCOR          VCOR ...        
  SD1S          QP4           SD2           QP3           SD2S          BPMx ...        
  BPMz          SD2S          COE           BEND           COS           SD0  ...        
  SD0           COE           BEND           COS           SD2S          BPMx ...        
  BPMz          SD2S          QP3           SD2           QP4           SD1S ...        
  SX2           HCOR          VCOR          SD1S1         BPMx          BPMz ...        
  QP41          SD3S1         SX3           HCOR          VCOR          SD3S ...        
  QP31          SD3S          SX1           HCOR          VCOR          SD3S1 ...       
  COE           BEND           COS           SD31          QP2           SD2   ...       
  QP1           BPMx          BPMz          SD5            RF ...
  FIN];         

buildlat(ELIST);

% Set all magnets to same energy
THERING = setcellstruct(THERING,'Energy',1:length(THERING),GLOBVAL.E0);
    
evalin('caller','global THERING FAMLIST GLOBVAL');

% print the summary of the lattice
atsummary;

if nargout
    varargout{1} = THERING;
end











  
