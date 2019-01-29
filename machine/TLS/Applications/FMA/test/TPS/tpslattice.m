function tpslattice


global FAMLIST THERING GLOBVAL
Energy = 3.0e9;
GLOBVAL.E0 = 3e9;
GLOBVAL.LatticeFile = 'DBA24P79H2-1828';
FAMLIST = cell(0);

disp(['   Loading TPS 3GeV magnet lattice ', mfilename]);
AP       =  aperture('AP',  [-0.1, 0.1, -0.1, 0.1],'AperturePass');
 
L0 = 518.40000000000513280787070372276;	% design length [m]
C0 =   299792458; 				% speed of light [m/s]
HarmNumber = 864;
CAV	= rfcavity('RF' , 0 , 3.5e+6 , HarmNumber*C0/L0, HarmNumber ,'ThinCavityPass');  
BCOR =  corrector('BCOR',0.0,[0 0],'CorrectorPass');
TBTC =  corrector('TBT',0.0,[0 0],'CorrectorPass');
% COR =  corrector('COR',0.0,[0 0],'CorrectorPass');

% BPM #168
BPM  =  marker('BPM','IdentityPass');
R1BPM0 = BPM;
R1BPM1 = BPM;
R1BPM2 = BPM;
R1BPM3 = BPM;
R1BPM4 = BPM;
R1BPM5 = BPM;
R1BPM6 = BPM;

R2BPM0 = BPM;
R2BPM1 = BPM;
R2BPM2 = BPM;
R2BPM3 = BPM;
R2BPM4 = BPM;
R2BPM5 = BPM;
R2BPM6 = BPM;

R3BPM0 = BPM;
R3BPM1 = BPM;
R3BPM2 = BPM;
R3BPM3 = BPM;
R3BPM4 = BPM;
R3BPM5 = BPM;
R3BPM6 = BPM;

R4BPM0 = BPM;
R4BPM1 = BPM;
R4BPM2 = BPM;
R4BPM3 = BPM;
R4BPM4 = BPM;
R4BPM5 = BPM;
R4BPM6 = BPM;

R5BPM0 = BPM;
R5BPM1 = BPM;
R5BPM2 = BPM;
R5BPM3 = BPM;
R5BPM4 = BPM;
R5BPM5 = BPM;
R5BPM6 = BPM;

R6BPM0 = BPM;
R6BPM1 = BPM;
R6BPM2 = BPM;
R6BPM3 = BPM;
R6BPM4 = BPM;
R6BPM5 = BPM;
R6BPM6 = BPM;

R7BPM0 = BPM;
R7BPM1 = BPM;
R7BPM2 = BPM;
R7BPM3 = BPM;
R7BPM4 = BPM;
R7BPM5 = BPM;
R7BPM6 = BPM;

R8BPM0 = BPM;
R8BPM1 = BPM;
R8BPM2 = BPM;
R8BPM3 = BPM;
R8BPM4 = BPM;
R8BPM5 = BPM;
R8BPM6 = BPM;

R9BPM0 = BPM;
R9BPM1 = BPM;
R9BPM2 = BPM;
R9BPM3 = BPM;
R9BPM4 = BPM;
R9BPM5 = BPM;
R9BPM6 = BPM;

R10BPM0 = BPM;
R10BPM1 = BPM;
R10BPM2 = BPM;
R10BPM3 = BPM;
R10BPM4 = BPM;
R10BPM5 = BPM;
R10BPM6 = BPM;

R11BPM0 = BPM;
R11BPM1 = BPM;
R11BPM2 = BPM;
R11BPM3 = BPM;
R11BPM4 = BPM;
R11BPM5 = BPM;
R11BPM6 = BPM;

R12BPM0 = BPM;
R12BPM1 = BPM;
R12BPM2 = BPM;
R12BPM3 = BPM;
R12BPM4 = BPM;
R12BPM5 = BPM;
R12BPM6 = BPM;

R13BPM0 = BPM;
R13BPM1 = BPM;
R13BPM2 = BPM;
R13BPM3 = BPM;
R13BPM4 = BPM;
R13BPM5 = BPM;
R13BPM6 = BPM;

R14BPM0 = BPM;
R14BPM1 = BPM;
R14BPM2 = BPM;
R14BPM3 = BPM;
R14BPM4 = BPM;
R14BPM5 = BPM;
R14BPM6 = BPM;

R15BPM0 = BPM;
R15BPM1 = BPM;
R15BPM2 = BPM;
R15BPM3 = BPM;
R15BPM4 = BPM;
R15BPM5 = BPM;
R15BPM6 = BPM;

R16BPM0 = BPM;
R16BPM1 = BPM;
R16BPM2 = BPM;
R16BPM3 = BPM;
R16BPM4 = BPM;
R16BPM5 = BPM;
R16BPM6 = BPM;

R17BPM0 = BPM;
R17BPM1 = BPM;
R17BPM2 = BPM;
R17BPM3 = BPM;
R17BPM4 = BPM;
R17BPM5 = BPM;
R17BPM6 = BPM;

R18BPM0 = BPM;
R18BPM1 = BPM;
R18BPM2 = BPM;
R18BPM3 = BPM;
R18BPM4 = BPM;
R18BPM5 = BPM;
R18BPM6 = BPM;

R19BPM0 = BPM;
R19BPM1 = BPM;
R19BPM2 = BPM;
R19BPM3 = BPM;
R19BPM4 = BPM;
R19BPM5 = BPM;
R19BPM6 = BPM;

R20BPM0 = BPM;
R20BPM1 = BPM;
R20BPM2 = BPM;
R20BPM3 = BPM;
R20BPM4 = BPM;
R20BPM5 = BPM;
R20BPM6 = BPM;

R21BPM0 = BPM;
R21BPM1 = BPM;
R21BPM2 = BPM;
R21BPM3 = BPM;
R21BPM4 = BPM;
R21BPM5 = BPM;
R21BPM6 = BPM;

R22BPM0 = BPM;
R22BPM1 = BPM;
R22BPM2 = BPM;
R22BPM3 = BPM;
R22BPM4 = BPM;
R22BPM5 = BPM;
R22BPM6 = BPM;

R23BPM0 = BPM;
R23BPM1 = BPM;
R23BPM2 = BPM;
R23BPM3 = BPM;
R23BPM4 = BPM;
R23BPM5 = BPM;
R23BPM6 = BPM;

R24BPM0 = BPM;
R24BPM1 = BPM;
R24BPM2 = BPM;
R24BPM3 = BPM;
R24BPM4 = BPM;
R24BPM5 = BPM;
R24BPM6 = BPM;

% Horizontal Corrector #168
HCOR =  corrector('HCOR',0.0,[0 0],'CorrectorPass');
R1HC0 = HCOR;
R1HC1 = HCOR;
R1HC2 = HCOR;
R1HC3 = HCOR;
R1HC4 = HCOR;
R1HC5 = HCOR;
R1HC6 = HCOR;

R2HC0 = HCOR;
R2HC1 = HCOR;
R2HC2 = HCOR;
R2HC3 = HCOR;
R2HC4 = HCOR;
R2HC5 = HCOR;
R2HC6 = HCOR;

R3HC0 = HCOR;
R3HC1 = HCOR;
R3HC2 = HCOR;
R3HC3 = HCOR;
R3HC4 = HCOR;
R3HC5 = HCOR;
R3HC6 = HCOR;

R4HC0 = HCOR;
R4HC1 = HCOR;
R4HC2 = HCOR;
R4HC3 = HCOR;
R4HC4 = HCOR;
R4HC5 = HCOR;
R4HC6 = HCOR;

R5HC0 = HCOR;
R5HC1 = HCOR;
R5HC2 = HCOR;
R5HC3 = HCOR;
R5HC4 = HCOR;
R5HC5 = HCOR;
R5HC6 = HCOR;

R6HC0 = HCOR;
R6HC1 = HCOR;
R6HC2 = HCOR;
R6HC3 = HCOR;
R6HC4 = HCOR;
R6HC5 = HCOR;
R6HC6 = HCOR;

R7HC0 = HCOR;
R7HC1 = HCOR;
R7HC2 = HCOR;
R7HC3 = HCOR;
R7HC4 = HCOR;
R7HC5 = HCOR;
R7HC6 = HCOR;

R8HC0 = HCOR;
R8HC1 = HCOR;
R8HC2 = HCOR;
R8HC3 = HCOR;
R8HC4 = HCOR;
R8HC5 = HCOR;
R8HC6 = HCOR;

R9HC0 = HCOR;
R9HC1 = HCOR;
R9HC2 = HCOR;
R9HC3 = HCOR;
R9HC4 = HCOR;
R9HC5 = HCOR;
R9HC6 = HCOR;

R10HC0 = HCOR;
R10HC1 = HCOR;
R10HC2 = HCOR;
R10HC3 = HCOR;
R10HC4 = HCOR;
R10HC5 = HCOR;
R10HC6 = HCOR;

R11HC0 = HCOR;
R11HC1 = HCOR;
R11HC2 = HCOR;
R11HC3 = HCOR;
R11HC4 = HCOR;
R11HC5 = HCOR;
R11HC6 = HCOR;

R12HC0 = HCOR;
R12HC1 = HCOR;
R12HC2 = HCOR;
R12HC3 = HCOR;
R12HC4 = HCOR;
R12HC5 = HCOR;
R12HC6 = HCOR;

R13HC0 = HCOR;
R13HC1 = HCOR;
R13HC2 = HCOR;
R13HC3 = HCOR;
R13HC4 = HCOR;
R13HC5 = HCOR;
R13HC6 = HCOR;

R14HC0 = HCOR;
R14HC1 = HCOR;
R14HC2 = HCOR;
R14HC3 = HCOR;
R14HC4 = HCOR;
R14HC5 = HCOR;
R14HC6 = HCOR;

R15HC0 = HCOR;
R15HC1 = HCOR;
R15HC2 = HCOR;
R15HC3 = HCOR;
R15HC4 = HCOR;
R15HC5 = HCOR;
R15HC6 = HCOR;

R16HC0 = HCOR;
R16HC1 = HCOR;
R16HC2 = HCOR;
R16HC3 = HCOR;
R16HC4 = HCOR;
R16HC5 = HCOR;
R16HC6 = HCOR;

R17HC0 = HCOR;
R17HC1 = HCOR;
R17HC2 = HCOR;
R17HC3 = HCOR;
R17HC4 = HCOR;
R17HC5 = HCOR;
R17HC6 = HCOR;

R18HC0 = HCOR;
R18HC1 = HCOR;
R18HC2 = HCOR;
R18HC3 = HCOR;
R18HC4 = HCOR;
R18HC5 = HCOR;
R18HC6 = HCOR;

R19HC0 = HCOR;
R19HC1 = HCOR;
R19HC2 = HCOR;
R19HC3 = HCOR;
R19HC4 = HCOR;
R19HC5 = HCOR;
R19HC6 = HCOR;

R20HC0 = HCOR;
R20HC1 = HCOR;
R20HC2 = HCOR;
R20HC3 = HCOR;
R20HC4 = HCOR;
R20HC5 = HCOR;
R20HC6 = HCOR;

R21HC0 = HCOR;
R21HC1 = HCOR;
R21HC2 = HCOR;
R21HC3 = HCOR;
R21HC4 = HCOR;
R21HC5 = HCOR;
R21HC6 = HCOR;

R22HC0 = HCOR;
R22HC1 = HCOR;
R22HC2 = HCOR;
R22HC3 = HCOR;
R22HC4 = HCOR;
R22HC5 = HCOR;
R22HC6 = HCOR;

R23HC0 = HCOR;
R23HC1 = HCOR;
R23HC2 = HCOR;
R23HC3 = HCOR;
R23HC4 = HCOR;
R23HC5 = HCOR;
R23HC6 = HCOR;

R24HC0 = HCOR;
R24HC1 = HCOR;
R24HC2 = HCOR;
R24HC3 = HCOR;
R24HC4 = HCOR;
R24HC5 = HCOR;
R24HC6 = HCOR;

% Vertical Corrector #168
VCOR =  corrector('VCOR',0.0,[0 0],'CorrectorPass');
R1VC0 = VCOR;
R1VC1 = VCOR;
R1VC2 = VCOR;
R1VC3 = VCOR;
R1VC4 = VCOR;
R1VC5 = VCOR;
R1VC6 = VCOR;

R2VC0 = VCOR;
R2VC1 = VCOR;
R2VC2 = VCOR;
R2VC3 = VCOR;
R2VC4 = VCOR;
R2VC5 = VCOR;
R2VC6 = VCOR;

R3VC0 = VCOR;
R3VC1 = VCOR;
R3VC2 = VCOR;
R3VC3 = VCOR;
R3VC4 = VCOR;
R3VC5 = VCOR;
R3VC6 = VCOR;

R4VC0 = VCOR;
R4VC1 = VCOR;
R4VC2 = VCOR;
R4VC3 = VCOR;
R4VC4 = VCOR;
R4VC5 = VCOR;
R4VC6 = VCOR;

R5VC0 = VCOR;
R5VC1 = VCOR;
R5VC2 = VCOR;
R5VC3 = VCOR;
R5VC4 = VCOR;
R5VC5 = VCOR;
R5VC6 = VCOR;

R6VC0 = VCOR;
R6VC1 = VCOR;
R6VC2 = VCOR;
R6VC3 = VCOR;
R6VC4 = VCOR;
R6VC5 = VCOR;
R6VC6 = VCOR;

R7VC0 = VCOR;
R7VC1 = VCOR;
R7VC2 = VCOR;
R7VC3 = VCOR;
R7VC4 = VCOR;
R7VC5 = VCOR;
R7VC6 = VCOR;

R8VC0 = VCOR;
R8VC1 = VCOR;
R8VC2 = VCOR;
R8VC3 = VCOR;
R8VC4 = VCOR;
R8VC5 = VCOR;
R8VC6 = VCOR;

R9VC0 = VCOR;
R9VC1 = VCOR;
R9VC2 = VCOR;
R9VC3 = VCOR;
R9VC4 = VCOR;
R9VC5 = VCOR;
R9VC6 = VCOR;

R10VC0 = VCOR;
R10VC1 = VCOR;
R10VC2 = VCOR;
R10VC3 = VCOR;
R10VC4 = VCOR;
R10VC5 = VCOR;
R10VC6 = VCOR;

R11VC0 = VCOR;
R11VC1 = VCOR;
R11VC2 = VCOR;
R11VC3 = VCOR;
R11VC4 = VCOR;
R11VC5 = VCOR;
R11VC6 = VCOR;

R12VC0 = VCOR;
R12VC1 = VCOR;
R12VC2 = VCOR;
R12VC3 = VCOR;
R12VC4 = VCOR;
R12VC5 = VCOR;
R12VC6 = VCOR;

R13VC0 = VCOR;
R13VC1 = VCOR;
R13VC2 = VCOR;
R13VC3 = VCOR;
R13VC4 = VCOR;
R13VC5 = VCOR;
R13VC6 = VCOR;

R14VC0 = VCOR;
R14VC1 = VCOR;
R14VC2 = VCOR;
R14VC3 = VCOR;
R14VC4 = VCOR;
R14VC5 = VCOR;
R14VC6 = VCOR;

R15VC0 = VCOR;
R15VC1 = VCOR;
R15VC2 = VCOR;
R15VC3 = VCOR;
R15VC4 = VCOR;
R15VC5 = VCOR;
R15VC6 = VCOR;

R16VC0 = VCOR;
R16VC1 = VCOR;
R16VC2 = VCOR;
R16VC3 = VCOR;
R16VC4 = VCOR;
R16VC5 = VCOR;
R16VC6 = VCOR;

R17VC0 = VCOR;
R17VC1 = VCOR;
R17VC2 = VCOR;
R17VC3 = VCOR;
R17VC4 = VCOR;
R17VC5 = VCOR;
R17VC6 = VCOR;

R18VC0 = VCOR;
R18VC1 = VCOR;
R18VC2 = VCOR;
R18VC3 = VCOR;
R18VC4 = VCOR;
R18VC5 = VCOR;
R18VC6 = VCOR;

R19VC0 = VCOR;
R19VC1 = VCOR;
R19VC2 = VCOR;
R19VC3 = VCOR;
R19VC4 = VCOR;
R19VC5 = VCOR;
R19VC6 = VCOR;

R20VC0 = VCOR;
R20VC1 = VCOR;
R20VC2 = VCOR;
R20VC3 = VCOR;
R20VC4 = VCOR;
R20VC5 = VCOR;
R20VC6 = VCOR;

R21VC0 = VCOR;
R21VC1 = VCOR;
R21VC2 = VCOR;
R21VC3 = VCOR;
R21VC4 = VCOR;
R21VC5 = VCOR;
R21VC6 = VCOR;

R22VC0 = VCOR;
R22VC1 = VCOR;
R22VC2 = VCOR;
R22VC3 = VCOR;
R22VC4 = VCOR;
R22VC5 = VCOR;
R22VC6 = VCOR;

R23VC0 = VCOR;
R23VC1 = VCOR;
R23VC2 = VCOR;
R23VC3 = VCOR;
R23VC4 = VCOR;
R23VC5 = VCOR;
R23VC6 = VCOR;

R24VC0 = VCOR;
R24VC1 = VCOR;
R24VC2 = VCOR;
R24VC3 = VCOR;
R24VC4 = VCOR;
R24VC5 = VCOR;
R24VC6 = VCOR;


%Standard Long Cell Drifts
DL1      =    drift('DL1' ,6.000000,'DriftPass');
DL1A      =    drift('DL1A' ,5.208,'DriftPass');
DL1B      =    drift('DL1B' ,6.000000-5.208,'DriftPass');

DL2      =    drift('DL2' ,0.73,'DriftPass');
DL2A     =    drift('DL2A' ,0.48-0.125,'DriftPass');
DL2B     =    drift('DL2B' ,0.25-0.125,'DriftPass');
DL3      =    drift('DL3' ,0.700,'DriftPass');
DL3A     =    drift('DL3A' ,0.700-0.095,'DriftPass');
DL3B     =    drift('DL3B' ,0.095,'DriftPass');
DL3A1     =    drift('DL3A1' ,0.700-0.1,'DriftPass');
DL3B1     =    drift('DL3B1' ,0.1,'DriftPass');

DL4      =    drift('DL4' ,0.75,'DriftPass');
DL4A     =    drift('DL4A' ,0.25-0.125,'DriftPass');
DL4B     =    drift('DL4B' ,0.50-0.125,'DriftPass');
DC5      =    drift('DC5' ,0.55,'DriftPass');

DC6      =    drift('DC6' ,0.95,'DriftPass');
DC6A     =    drift('DC6A' ,0.275,'DriftPass');
DC6AA     =    drift('DC6AA' ,0.095,'DriftPass');
DC6AB     =    drift('DC6AB' ,0.275-0.095,'DriftPass');
DC6B     =    drift('DC6B' ,0.425,'DriftPass');
DC7      =    drift('DC7' ,0.38-0.125,'DriftPass');
DC7A     =    drift('DC7A' ,0.160,'DriftPass');
DC7B     =    drift('DC7B' ,0.38-0.125-0.160,'DriftPass');

DS1      =    drift('DS1' ,3.5,'DriftPass');
DS1A     =    drift('DS1A' ,3.5-0.782,'DriftPass');
DS1B     =    drift('DS1B' ,0.782,'DriftPass');
DS1A1     =    drift('DS1A1' ,3.5-0.792,'DriftPass');
DS1B1     =    drift('DS1B1' ,0.792,'DriftPass');
DS2      =    drift('DS2' ,0.68,'DriftPass');
DS2A     =    drift('DS2A' ,0.43-0.125,'DriftPass');
DS2B     =    drift('DS2B' ,0.25-0.125,'DriftPass');
DS3      =    drift('DS3' ,0.8000,'DriftPass');
DS3A     =    drift('DS3A' ,0.55-0.125,'DriftPass');
DS3AB     =    drift('DS3AB' ,0.1,'DriftPass');
DS3AA     =    drift('DS3AA' ,0.55-0.125-0.1,'DriftPass');
DS3AB1     =    drift('DS3AB1' ,0.095,'DriftPass');
DS3AA1     =    drift('DS3AA1' ,0.55-0.125-0.095,'DriftPass');
DS3B     =    drift('DS3B' ,0.25-0.125,'DriftPass');
DS4      =    drift('DS4' ,0.320,'DriftPass');

%DS1RF    =    drift('DL1RF' ,3.25,'DriftPass');
%DL1RF    =    drift('DL1RF' ,5.61,'DriftPass');


%Standard Cell Dipoles
BEND	=	rbend('BEND'  , 1.1,  ...
            0.1308996939,0.1308996939/2, 0.1308996939/2,...
           0.000,'BendLinearPass');
% BENDL	=	rbend('BEND'  , 1.1/10,  ...
%             0.13089969/10,0.13089969/2, 0.0,...
%            0.000,'BendLinearPass');
% BENDM	=	rbend('BEND'  , 1.1/10,  ...
%             0.13089969/10,0.0, 0.0,...
%            0.000,'BendLinearPass');
% BENDR	=	rbend('BEND'  , 1.1/10,  ...
%             0.13089969/10,0.0, 0.13089969/2,...
%            0.000,'BendLinearPass');
% BEND=[BCOR, BENDL,BENDM,BENDM,BENDM,BENDM,BCOR,BENDM,BENDM,BENDM,BENDM,BENDR ,BCOR];

%Standard Cell Quadrupoles
QS5		=	quadrupole('QF5S' ,0.3     ,  1.6011, 'QuadLinearPass');
QS4		=	quadrupole('QD4S' ,0.300000, -0.9773, 'QuadLinearPass');
QS3		=	quadrupole('QD3S' ,0.300000, -1.3537, 'QuadLinearPass');
QS2		=	quadrupole('QF2S' ,0.600000,  1.5445, 'QuadLinearPass');
QS1		=	quadrupole('QD1S' ,0.300000, -1.6934, 'QuadLinearPass');
QL3		=	quadrupole('QD3L' ,0.300000, -1.2343, 'QuadLinearPass');
QL2		=	quadrupole('QF2L' ,0.600000,  1.3010, 'QuadLinearPass');
QL1		=	quadrupole('QD1L' ,0.300000, -1.0879, 'QuadLinearPass');
 
R1QL1 = QL1;
R4QL1 = QL1;
R5QL1 = QL1;
R8QL1 = QL1;
R9QL1 = QL1;
R12QL1 = QL1;
R13QL1 = QL1;
R16QL1 = QL1;
R17QL1 = QL1;
R20QL1 = QL1;
R21QL1 = QL1;
R24QL1 = QL1;

R1QL2 = QL2;
R4QL2 = QL2;
R5QL2 = QL2;
R8QL2 = QL2;
R9QL2 = QL2;
R12QL2 = QL2;
R13QL2 = QL2;
R16QL2 = QL2;
R17QL2 = QL2;
R20QL2 = QL2;
R21QL2 = QL2;
R24QL2 = QL2;

R1QL3 = QL3;
R4QL3 = QL3;
R5QL3 = QL3;
R8QL3 = QL3;
R9QL3 = QL3;
R12QL3 = QL3;
R13QL3 = QL3;
R16QL3 = QL3;
R17QL3 = QL3;
R20QL3 = QL3;
R21QL3 = QL3;
R24QL3 = QL3;



%Standard Cell Sextupoles
SS1 =  11.89;
SS2 =  -27.95;
SS3 =  39.03;
SS4 =  -42.29;     
SS5 =  32.86;
SS6 =  -40.67;
SSD =  -27.89;
SSF =  38.30;
% SS1 =  0;
% SS2 =  0;
% SS3 =  0;
% SS4 =  0; 
% SS5 =  0;
% SS6 =  0;
% SSD =  0;
% SSF =  0;
S1 = sextupole('SF1', 0.125, SS1, 'StrMPoleSymplectic4Pass');   
S2 = sextupole('SD2', 0.125, SS2, 'StrMPoleSymplectic4Pass');   
S3 = sextupole('SF3', 0.125, SS3, 'StrMPoleSymplectic4Pass');  
S4 = sextupole('SD4', 0.125, SS4, 'StrMPoleSymplectic4Pass');    
S5 = sextupole('SF5', 0.125, SS5, 'StrMPoleSymplectic4Pass');    
S6 = sextupole('SD6', 0.125, SS6, 'StrMPoleSymplectic4Pass');    
SD = sextupole('SD', 0.125, SSD, 'StrMPoleSymplectic4Pass');    
SF = sextupole('SF', 0.125, SSF, 'StrMPoleSymplectic4Pass');

%Standard Cell Sextupoles
% S1 = sextupole('S', 0.25/2, 0.000, 'StrMPoleSymplectic4Pass'); 
% S2 = sextupole('S', 0.25/2, 0.000, 'StrMPoleSymplectic4Pass');
% SD = sextupole('S', 0.25/2, 0.000, 'StrMPoleSymplectic4Pass'); 
% SF = sextupole('S', 0.25/2, 0.000, 'StrMPoleSymplectic4Pass');
% S5 = sextupole('S', 0.25/2, 0.000, 'StrMPoleSymplectic4Pass'); 
% S6 = sextupole('S', 0.25/2, 0.000, 'StrMPoleSymplectic4Pass');
% S3 = sextupole('S', 0.25/2, 0.000, 'StrMPoleSymplectic4Pass'); 
% S4 = sextupole('S', 0.25/2, 0.000, 'StrMPoleSymplectic4Pass');


LLONG     =[DL1A,BPM,DL1B, QL1, DL2A, S1, HCOR, VCOR, S1, DL2B, QL2, DL3A, BPM,DL3B,QL3, DL4A, S2, HCOR, VCOR, S2, DL4B];
LLONG2     =[DL1A,BPM,DL1B, QL1, DL2A, S1, HCOR, VCOR, S1, DL2B, QL2, DL3A1, BPM,DL3B1,QL3, DL4A, S2, HCOR, VCOR, S2, DL4B];
RLONG     =[DS1A,BPM,DS1B, QS1, DS2A, S3, HCOR, VCOR, S3, DS2B, QS2, DS3AA,BPM,DS3AB,S4, HCOR, VCOR, S4, DS3B, QS3,DS4];
RLONG1    =[DS1A1,BPM,DS1B1, QS1, DS2A, S3, HCOR, VCOR, S3, DS2B, QS2, DS3AA1,BPM,DS3AB1,S4, HCOR, VCOR, S4, DS3B, QS3,DS4];
HLACH     =[DC5, QS4,DC6AA,BPM, DC6AB, SD, HCOR, VCOR, SD, DC6B, QS5, DC7, SF, HCOR, VCOR, SF,DC7A,BPM];
HLACH2    =[DC5, QS4,DC6AA,BPM, DC6AB, SD, HCOR, VCOR, SD, DC6B, QS5, DC7B,BPM,DC7A, SF, HCOR, VCOR, SF];
SHORT     =[DS1A1,BPM,DS1B1, QS1, DS2A, S5, HCOR, VCOR, S5, DS2B, QS2, DS3AA1,BPM,DS3AB1,S6, HCOR, VCOR, S6, DS3B, QS3, DS4];
SHORT1     =[DS1A1,BPM,DS1B1, QS1, DS2A, S5, HCOR, VCOR, S5, DS2B, QS2, DS3AA,BPM,DS3AB,S6, HCOR, VCOR, S6, DS3B, QS3, DS4];
HSACH     =[DC5, QS4,DC6AA,BPM, DC6AB, SD, HCOR, VCOR, SD, DC6B, QS5, DC7, SF, HCOR, VCOR, SF,DC7A,BPM];
HSACH1    =[DC5, QS4,DC6AA,BPM, DC6AB, SD, HCOR, VCOR, SD, DC6B, QS5, DC7B];
HSACH2    =[DC5, QS4,DC6AA,BPM, DC6AB, SD, HCOR, VCOR, SD, DC6B, QS5, DC7];
SCELL     =[SHORT, BEND, HSACH, reverse(HSACH1), BEND, reverse(SHORT1)];
LCELL     =[LLONG, BEND, HLACH, reverse(HSACH1), BEND, reverse(RLONG)];
ILCELL    =[RLONG1, BEND, HSACH2,reverse(HLACH2), BEND, reverse(LLONG2)];
SUPERa    =[LCELL, SCELL, SCELL, ILCELL];

RING=[SUPERa,SUPERa,SUPERa,CAV,SUPERa,SUPERa,SUPERa];

buildlat(RING);


% Newer AT versions requires 'Energy' to be an AT field
THERING = setcellstruct(THERING, 'Energy', 1:length(THERING), Energy);

clear global FAMLIST 

% LOSSFLAG is not global in AT1.3
% evalin('base','clear LOSSFLAG');   % Unfortunately it will come back
evalin('caller','global THERING FAMLIST GLOBVAL');
disp('** Done **');