function quadgetstepPS
% Computes  for 1 A shift a quadrupole offset by 100 ?m

% load lattice
TDR_good_017_064_r56_02_sx_Dff_BPM

 %getquadefficiency('QP1', [1 1]);
% getquadefficiency('QP1', [1 12]);
% getquadefficiency('QP1', [2 1]);
% getquadefficiency('QP1', [2 12]);
% 
% getquadefficiency('QP2', [1 2]);
% getquadefficiency('QP2', [1 11]);
% getquadefficiency('QP2', [2 2]);
% getquadefficiency('QP2', [2 11]);

 getquadefficiency('QP41', [1 4]);
% getquadefficiency('QP4', [1 5]);
% getquadefficiency('QP41', [1 9]);
% getquadefficiency('QP4', [1 8]);
% getquadefficiency('QP41', [2 4]);
% getquadefficiency('QP4', [2 5]);
% getquadefficiency('QP41', [2 9]);
% getquadefficiency('QP4', [2 8]);

% getquadefficiency('QP3', [1 6]);
% getquadefficiency('QP3', [1 7]);
% getquadefficiency('QP3', [2 6]);
% getquadefficiency('QP3', [2 7]);






function [xmax zmax] = getquadefficiency(Family, DeviceList)

DIQ = 0.5; %A
xshift = 500e-6; % um
zshift = 100e-6; % um

% offset by 100?m in both planes
atIdx = family2atindex(Family, DeviceList);
setshift(atIdx, xshift,zshift)

fprintf('Offset dx = %.0f um dz = %.0f um\n', xshift*1e6, zshift*1e6);

% Orbit correction
for k =1:2,
    setorbitH;
    setorbitV;
end

% get orbit before quadrupole step point
x0 = getx;
z0 = getz;

stepsp(Family, DIQ, DeviceList);

% get orbit after quadrupole step point
x1 = getx;
z1 = getz;

dx = x1-x0;
dz = z1-z0;

xmax = max(abs(dx));
zmax = max(abs(dz));
fprintf('quadrupole %s(%d, %d) (+%d A) xmax = %.4f mm zmax =%.4f mm\n', Family, DeviceList, DIQ, xmax, zmax)

%
stepsp(Family, -DIQ, DeviceList);

%reset align
setsp('HCOR',0);
setsp('VCOR',0);


