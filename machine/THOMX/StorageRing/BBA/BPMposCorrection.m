%Illustration of the problem

setsp('HCOR', 0.1e-4, [2 3])
get_orbit

%%
setpaththomx
global THERING

%%
setshift(17, 1.e-3, 0.5e-3)

%%

L = length(THERING);
spos = findspos(THERING,1:L+1);
orbit = findorbit6(THERING,1:length(THERING)+1);

% xbpm3 = orbit(1,36);%getsp('BPMx', [1 3])
% ybpm3 = orbit(3,36);%getsp('BPMz', [1 3])
% 
% xpbpm3 = orbit(2,36);
% ypbpm3 = orbit(4,36);
% 
% xq3 = orbit(1,34)
% yq3 = orbit(3,34)
% 
% xpq3 = orbit(2,34);
% ypq3 = orbit(4,34);
% 
% vecquad = [0; 0; 0; 0];
% 
% %vecquad = Msimple * [xbpm3; xpbpm3; ybpm3; ypbpm3]
% vxecquad = Mxanal * [xbpm3; xpbpm3];
% vyecquad = Myanal * [ybpm3; ypbpm3];
% 
% vxecquad = Mxanal * [xq3; xpq3]
% vyecquad = Myanal * [yq3; ypq3]


%%
REFPTS = 1:length(THERING)+1;
[M44,T] = findm44(THERING,0,REFPTS);

%%

DR1.FamName = 'DR1';
DR1.Length  = 0.4000000E-01;
DR1.PassMethod = 'DriftPass';


 LQD3 = 0.15; % quadrupole length
 KQD3 =  -0.1774489E+02;
% QPassMethod = 'StrMPoleSymplectic4Pass'; % tracking method
% QD3 = quadrupole('QD3', LQP, -.1774489E+02, QPassMethod);

QD3.FamName = 'QD3';
QD3.Length = 0.150;
QD3.K = KQD3;%0.1774489E+02;
QD3.MaxOrder = 3;
QD3.NumIntSteps = 10;
QD3.PolynomA= [0 0 0];
QD3.PolynomB= [0 KQD3 0 0];
QD3.R1= eye(6);
QD3.R2= eye(6);
QD3.T1= [0 0 0 0 0 0];
QD3.T2= [0 0 0 0 0 0];
QD3.PassMethod= 'QuadLinearPass';

whos DR1 QD3                   
disp(DR1)

       

quadmatx = [ cosh(LQD3* sqrt(abs(KQD3))) 1/sqrt(abs(KQD3)) * sinh(LQD3* sqrt(abs(KQD3))); sqrt(abs(KQD3)) * sinh(LQD3* sqrt(abs(KQD3))) cosh(LQD3* sqrt(abs(KQD3)))];
quadmaty = [ cos(LQD3* sqrt(abs(KQD3))) 1/sqrt(abs(KQD3)) * sin(LQD3* sqrt(abs(KQD3))); -sqrt(abs(KQD3)) * sin(LQD3* sqrt(abs(KQD3))) cos(LQD3* sqrt(abs(KQD3)))];

driftmat = [1 DR1.Length; 0 1];

% Mxanal = quadmatx * driftmat;
% Myanal = quadmaty * driftmat;

Mxanal =  driftmat * quadmatx ;
Myanal =  driftmat * quadmaty ;
%%

CELL = {QD3 DR1};
% CELL = {DR1 QD3};

%whos CELL
% xq3 = orbit(1,34);
% yq3 = orbit(3,34);
% 
% xpq3 = orbit(2,34);
% ypq3 = orbit(4,34);
xbpm3 = orbit(1,36);
ybpm3 = orbit(3,36);

xpbpm3 = orbit(2,36);
ypbpm3 = orbit(4,36);

R = [xbpm3 xpbpm3 ybpm3 ypbpm3 0 0]';
% R = [xq3 xpq3 yq3 ypq3 0 0]';
RR = [0.01 0 0.01 0 0 0]';
 
 
Rout = linepass(CELL,R)

%THERING = [CELL]; 

%Msimple = findm44(THERING,0)
%%

DRLength  = 0.6000000E-01;
LQD3 = 0.15; % quadrupole length
KQD3 =  8.6225;

quadmatx = [ cosh(LQD3* sqrt(abs(KQD3))) 1/sqrt(abs(KQD3)) * sinh(LQD3* sqrt(abs(KQD3))); sqrt(abs(KQD3)) * sinh(LQD3* sqrt(abs(KQD3))) cosh(LQD3* sqrt(abs(KQD3)))];
quadmaty = [ cos(LQD3* sqrt(abs(KQD3))) 1/sqrt(abs(KQD3)) * sin(LQD3* sqrt(abs(KQD3))); -sqrt(abs(KQD3)) * sin(LQD3* sqrt(abs(KQD3))) cos(LQD3* sqrt(abs(KQD3)))];

driftmat = [1 DRLength; 0 1];

% Mxanal = quadmatx * driftmat;
% Myanal = quadmaty * driftmat;

Mxanal =  driftmat * quadmaty ;
Myanal =  driftmat * quadmatx ;


[orbit(1,23) orbit(2,23) orbit(3,23) orbit(4,23)]
[orbit(1,24) orbit(2,24) orbit(3,24) orbit(4,24)]

% vxecquad = Mxanal * [0.01; 0]
% vyecquad = Myanal * [0.01; 0]

% vxecquad = Mxanal * [xq3; xpq3]
% vyecquad = Myanal * [yq3; ypq3]

xbpm3 = orbit(1,25);
ybpm3 = orbit(3,25);

xpbpm3 = orbit(2,25);
ypbpm3 = orbit(4,25);

vxecquad = Mxanal^-1 * [xbpm3; xpbpm3];
vyecquad = Myanal^-1 * [ybpm3; ypbpm3];

vxDRIFT = driftmat^-1 * [xbpm3; xpbpm3];
vyDRIFT = driftmat^-1 * [ybpm3; ypbpm3];

[vxDRIFT; vyDRIFT]
[vxecquad; vyecquad]


%%

	[x, y, BPMs] = modeltwiss('ClosedOrbit');

%  Plot the orbit vs. s-position:
	figure;
	a1 = subplot(2,1,1);
    set(gca,'FontSize',16)
	plot(BPMs, x*1000,'d-', 'Markersize',6.8);
    xlabel('s (m)'); ylabel('x (mm)')
	a2 = subplot(2,1,2);
    set(gca,'FontSize',16)
	plot(BPMs, y*1000,'dr-', 'Markersize',6.8);
    xlabel('s (m)'); ylabel('y (mm)')
    linkaxes([a1,a2],'x')

%%

DriftafterQUAD3 = THERING{35};
QUAD3 = THERING{34};
THERING = [{QUAD3 DriftafterQUAD3}];
MsimpleFromTHERING = findm44(THERING,0)


%%

QUAD3 = THERING{34};
THERING = [{QUAD3}];
findm44(THERING,0)
M11 = cosh(LQD3* sqrt(abs(KQD3)));
 %%

 
