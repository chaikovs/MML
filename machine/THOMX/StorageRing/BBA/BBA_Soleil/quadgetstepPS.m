function quadgetstepPS
% Computes  for 1 A shift a quadrupole offset by 100 µm

% load lattice
solamor2linb

getquadefficiency('Q1', [1 1]);
getquadefficiency('Q2', [1 1]);
getquadefficiency('Q3', [1 1]);
getquadefficiency('Q4', [1 1]);
getquadefficiency('Q4', [1 2]);
getquadefficiency('Q5', [1 1]);
getquadefficiency('Q5', [1 2]);
getquadefficiency('Q6', [1 1]);
getquadefficiency('Q6', [2 1]);
getquadefficiency('Q7', [1 1]);
getquadefficiency('Q7', [2 1]);
getquadefficiency('Q8', [1 1]);
getquadefficiency('Q8', [2 1]);
getquadefficiency('Q9', [2 1]);
getquadefficiency('Q10', [2 1]);

function [xmax zmax] = getquadefficiency(Family, DeviceList)

DIQ = 1; %A
xshift = 100e-6; % um
zshift = 100e-6; % um

% offset by 100µm in both planes
atIdx = family2atindex(Family, DeviceList);
setshift(atIdx, xshift,zshift)

fprintf('Offset dx = %.0f um dz = %.0f um\n', xshift*1e6, zshift*1e6);

% Orbit correction
for k =1:3,
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


