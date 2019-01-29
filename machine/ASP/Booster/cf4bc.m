function cf4bc(varargin)
% Lattice definition file - generated by dimad2at v1.400000 

global FAMLIST THERING GLOBVAL

GLOBVAL.E0 = 3e9;
GLOBVAL.LatticeFile = 'cf4bc';
FAMLIST = cell(0);

disp(' ');
disp('*** Loading lattice from cf4bc.m ***');

d0	=	drift('d0'	,1.250000e-001,'DriftPass');
d1c	=	drift('d1c'	,2.179000e+000,'DriftPass');
bpm	=	monitor('bpm'	,'IdentityPass');
d1cc	=	drift('d1cc'	,4.600000e-002,'DriftPass');
hcor	=	corrector('hcor'	,2.000000e-001,[0.0 0.0],'CorrectorPass');
dqxd	=	drift('dqxd'	,7.500000e-002,'DriftPass');
halfqf	=	quadrupole('halfqf'	,1.250000e-001,2.350742e+000,'QuadLinearPass');
d2	=	drift('d2'	,2.000000e-001,'DriftPass');
dd	=	drift('dd'	,1.000000e-001,'DriftPass');
bd	=	rbend('bd'	,1.150000e+000,1.439900e-001,7.199000e-002,7.199000e-002,-6.697690e-001,'BndMPoleSymplectic4Pass');
FAMLIST{bd}.ElemData.PolynomB(3) = -4.924769e+000;
halfqd	=	quadrupole('halfqd'	,7.500000e-002,-4.000000e-001,'QuadLinearPass');
d2c	=	drift('d2c'	,1.010000e-001,'DriftPass');
d2cc	=	drift('d2cc'	,9.900000e-002,'DriftPass');
bf	=	rbend('bf'	,1.350000e+000,5.983900e-002,2.992000e-002,2.992000e-002,8.259520e-001,'BndMPoleSymplectic4Pass');
FAMLIST{bf}.ElemData.PolynomB(3) = 3.540622e+000;
dqxd1	=	drift('dqxd1'	,6.400000e-002,'DriftPass');
sexh	=	sextupole('sexh'	,1.800000e-001,-3.130000e+001,'StrMPoleSymplectic4Pass');
FAMLIST{sexh}.ElemData.PolynomB(3) = -3.130000e+001;
dqxd2	=	drift('dqxd2'	,1.060000e-001,'DriftPass');
dd1	=	drift('dd1'	,1.250000e-001,'DriftPass');
d21	=	drift('d21'	,1.750000e-001,'DriftPass');
d22	=	drift('d22'	,1.200000e-001,'DriftPass');
vcor	=	corrector('vcor'	,2.000000e-001,[0.0 0.0],'CorrectorPass');
dd2c	=	drift('dd2c'	,8.100000e-002,'DriftPass');
d23	=	drift('d23'	,1.500000e-001,'DriftPass');
d23c	=	drift('d23c'	,5.100000e-002,'DriftPass');
dqxd3	=	drift('dqxd3'	,6.000000e-002,'DriftPass');
sexv	=	sextupole('sexv'	,2.000000e-001,4.810000e+001,'StrMPoleSymplectic4Pass');
FAMLIST{sexv}.ElemData.PolynomB(3) = 4.810000e+001;
dqxd4	=	drift('dqxd4'	,9.000000e-002,'DriftPass');
dqxd4c	=	drift('dqxd4c'	,4.050000e-002,'DriftPass');
dd2	=	drift('dd2'	,1.800000e-001,'DriftPass');
ddc	=	drift('ddc'	,1.000000e-003,'DriftPass');
dqxd5	=	drift('dqxd5'	,1.200000e-001,'DriftPass');
dqxd6	=	drift('dqxd6'	,5.000000e-002,'DriftPass');
d27	=	drift('d27'	,5.000000e-002,'DriftPass');
d11	=	drift('d11'	,1.975000e+000,'DriftPass');

% Begin declaration of element groups and lattice.
cf4bc = [ d0 d1c bpm d1cc hcor dqxd halfqf halfqf dqxd d2 d2 dd bd d2 halfqd halfqd dd d2c bpm d2cc bf dqxd1 sexh dqxd2 bd dd1 hcor d21 bf d22 vcor dd2c bpm d2cc bd dd d2 d2 bf d23 hcor d23c bpm d2cc bd dqxd3 dqxd3 sexv dqxd4 dqxd4 bf dqxd3 dqxd3 sexv dqxd4c dqxd4c bpm d2cc bd d23 hcor d23 bf d22 vcor dd2 bd d23 hcor d23c bpm d2cc bf d2 d2 ddc bpm d2cc bd dqxd5 sexh dqxd6 bf d2 dd halfqd halfqd dd ddc bpm d2cc bd dd d2 d2 dqxd halfqf halfqf dqxd hcor d27 vcor d11 d0 d0 d1c bpm d1cc hcor dqxd halfqf halfqf dqxd d2 d2 dd bd d2 halfqd halfqd dd d2c bpm d2cc bf dqxd1 sexh dqxd2 bd dd1 hcor d21 bf d22 vcor dd2c bpm d2cc bd dd d2 d2 bf d23 hcor d23c bpm d2cc bd dqxd3 dqxd3 sexv dqxd4 dqxd4 bf dqxd3 dqxd3 sexv dqxd4c dqxd4c bpm d2cc bd d23 hcor d23 bf d22 vcor dd2 bd d23 hcor d23c bpm d2cc bf d2 d2 ddc bpm d2cc bd dqxd5 sexh dqxd6 bf d2 dd halfqd halfqd dd ddc bpm d2cc bd dd d2 d2 dqxd halfqf halfqf dqxd hcor d27 vcor d11 d0 d0 d1c bpm d1cc hcor dqxd halfqf halfqf dqxd d2 d2 dd bd d2 halfqd halfqd dd d2c bpm d2cc bf dqxd1 sexh dqxd2 bd dd1 hcor d21 bf d22 vcor dd2c bpm d2cc bd dd d2 d2 bf d23 hcor d23c bpm d2cc bd dqxd3 dqxd3 sexv dqxd4 dqxd4 bf dqxd3 dqxd3 sexv dqxd4c dqxd4c bpm d2cc bd d23 hcor d23 bf d22 vcor dd2 bd d23 hcor d23c bpm d2cc bf d2 d2 ddc bpm d2cc bd dqxd5 sexh dqxd6 bf d2 dd halfqd halfqd dd ddc bpm d2cc bd dd d2 d2 dqxd halfqf halfqf dqxd hcor d27 vcor d11 d0 d0 d1c bpm d1cc hcor dqxd halfqf halfqf dqxd d2 d2 dd bd d2 halfqd halfqd dd d2c bpm d2cc bf dqxd1 sexh dqxd2 bd dd1 hcor d21 bf d22 vcor dd2c bpm d2cc bd dd d2 d2 bf d23 hcor d23c bpm d2cc bd dqxd3 dqxd3 sexv dqxd4 dqxd4 bf dqxd3 dqxd3 sexv dqxd4c dqxd4c bpm d2cc bd d23 hcor d23 bf d22 vcor dd2 bd d23 hcor d23c bpm d2cc bf d2 d2 ddc bpm d2cc bd dqxd5 sexh dqxd6 bf d2 dd halfqd halfqd dd ddc bpm d2cc bd dd d2 d2 dqxd halfqf halfqf dqxd hcor d27 vcor d11 d0 ];


if nargin > 0
    fprintf('Using lattice : %s \n', varargin{1});
    eval(['buildlat(' varargin{1} ');']);
else
    % Default lattice to load
    fprintf('Using default lattice : cf4bc\n');
    buildlat(cf4bc);
end
evalin('caller','global THERING FAMLIST GLOBVAL');
disp('** Done **');