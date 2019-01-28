    
%%
AO = getao;


%% CORT befor the DIP
% CORLISTbefore = [1 1; 1 3; 1 5; 1 7; 2 1; 2 3; 2 5; 2 7];
% CORLISTafter = [1 2; 1 4; 1 6; 1 8; 2 2; 2 4; 2 6; 2 8];

%Rmodel = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCORT',CORLISTafter ,'VCORT',CORLISTafter,'Model','Archive');
Rmodel = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCORT',AO.HCORT.DeviceList ,'VCORT',AO.VCORT.DeviceList,'Model','Archive');
%%

%copybpmrespfile('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2015-06-23_16-11-28.mat') %before

%copybpmrespfile('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2015-06-23_18-22-38.mat') %after

%copybpmrespfile('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2015-06-23_16-19-14.mat') %full

copybpmrespfile('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2015-06-25_18-55-18.mat') % in the center of the dipole
%%

Rmodel = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCORT',AO.HCORT.DeviceList ,'VCORT',AO.VCORT.DeviceList,'Model');

%%

R2T = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCORT',AO.HCORT.DeviceList ,'VCORT',AO.VCORT.DeviceList,'Archive');
%%

copybpmrespfile('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/measdata/THOMX/StorageRingdata/Response/BPM/BPMRespMat_2015-06-23_15-21-03.mat')
%%

Rget = getbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCORT',AO.HCORT.DeviceList ,'VCORT',AO.VCORT.DeviceList);

%% Corrector magnet response
Rxx = 1:8;
Ryy = 9:16;
range = Ryy;

figure(101)
set(gca,'FontSize',16)
for i = range
plot( Rmodel(:,i), 'o-')
hold all
xlabel('BPM #'); ylabel('ORM elements \Delta x / \Delta \theta [mm/amp]') % or [m/rad]
title('Model BPM Response')
end
hold off

figure(111)
set(gca,'FontSize',16)
for i = range
plot(Rget(:,i), 'o-')
hold all
xlabel('BPM #'); ylabel('ORM elements \Delta x / \Delta \theta [mm/amp]') % or [m/rad]
title('Default BPM Response')
end
hold off

figure(121)
set(gca,'FontSize',16)
for i = range
plot(Rget(:,i) - Rmodel(:,i), 'o-')
hold all
xlabel('BPM #'); ylabel('ORM elements \Delta x / \Delta \theta [mm/amp]') % or [m/rad]
title('Default - Model BPM Response')
end
hold off

%%
figure
subplot(2,1,1);
surf(R1T);  title('Default BPM Response'); ylabel('BPM #'); xlabel('CM #'); zlabel('[mm/amp]');
subplot(2,1,2);    
surf(R2T-R1T);  title('Default - Model BPM Response'); ylabel('BPM #'); xlabel('CM #'); zlabel('[mm/amp]');
%%

%% Vertical plane
 
Y0 = getam('BPMz'); 
BPMindex=getlist('BPMz');	
% Create an Orbit Error
% vcm = 7e-4 * randn(8,1);     
% setsp('VCORT', vcm);
setsp('HCOR', 5e-4, [1 3]);
setsp('VCOR', 6e-4, [2 4]);
quadalign(60e-6,100e-6)
% Get the vertical orbit
Y = getam('BPMz');	
Ytext = max(Y);

figure
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(BPMxspos,Y-Y0,'.-', 'Markersize',10);
hold on

xlim([0 BPMxspos(end)]);
xlabel('Position [m]')
ylabel('Vertical orbit Z [mm]');

title('Orbit correction by rotating the DIPOLES ');

%%

% Get the Vertical response matrix from the model
 Ry = getrespmat('BPMz', getlist('BPMz'), 'VCORT');       
%Rxy = getrespmat('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCORT',AO.HCORT.DeviceList ,'VCORT',AO.VCORT.DeviceList);

%%
% Computes the SVD of the response matrix
Ivec = 1:8;
[U, S, V] = svd(Ry, 0);	
% Find the corrector changes 
DeltaAmps = -V(:,Ivec) * S(Ivec,Ivec)^-1 * U(:,Ivec)' *  (Y-Y0);
% Changes the corrector strengths 
stepsp('VCORT', DeltaAmps);

% Get the vertical orbit
Y = getam('BPMz');	
plot(BPMxspos, Y-Y0,'r.-', 'Markersize',10);	


%%
stepsp('VCORT', -DeltaAmps);

%%
%kicks_vert = hw2physics('VCORT', 'setpoint', DeltaAmps, getlist('VCORT'),getenergy)
BENDI = findcells(THERING,'FamName','BEND');
kicks_vert = DeltaAmps/2;

theta = 0.785398;

rot_long_deg = rad2deg(kicks_vert/sin(theta/2))
rot_long_rad = 1*kicks_vert/sin(theta/2)

rot_long_rad2 = zeros(1, length(BENDI));
rot_long_rad2(1:2:end) = rot_long_rad;
rot_long_rad2(2:2:end) = rot_long_rad;

%%

%settilt(BENDI, rot_long_rad2)
addsrot(BENDI, rot_long_rad2)
% Get the vertical orbit
Y = getam('BPMz');	
plot(BPMxspos, Y-Y0,'g.-', 'Markersize',10);	
u = legend({'Initial','VCORT','DIP shift'});
set(u,'Location','NorthEast')
text(0.1, Ytext+0.2 ,['DIP tilts: [ ' num2str(1000*rot_long_rad','%1.1f ') ' mrad ]'],'FontSize',13);

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
% set(gcf, 'color', 'w');
% export_fig(['vert_orbit_correction_DIPtilt_8SV.pdf'])

%%
dia=diag(S);

figure
set(gca,'FontSize',16)
semilogy(dia./dia(1),'Linewidth',1.1)
xlabel('SV number'); ylabel('Log_{1o} SV_n/SV_1')



%% Horizontal plane

X0 = getam('BPMx'); 
BPMindex=getlist('BPMx');	
% Create an Orbit Error
%setshift(12,0.5e-3,0)
setsp('HCOR', 1.5e-4, [1 3]);
setsp('VCOR', 0.9e-4, [2 4]);
quadalign(100e-6,0)

X = getam('BPMx');	
Xtext = max(X);

% figure
% plot(X-X0);hold on;

BPMxspos = getspos('BPMx',family2dev('BPMx'));
BPMyspos = getspos('BPMz',family2dev('BPMz'));

figure
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(BPMyspos,X-X0,'.-', 'Markersize',10);
hold on

xlim([0 BPMyspos(end)]);
xlabel('Position [m]')
ylabel('Horizontal orbit X [mm]');

title('Orbit correction by shifting the DIPOLES ');


%%

% Get the Horizontal response matrix from the model
 Rx = getrespmat('BPMx', getlist('BPMx'), 'HCORT','Physics');  % [mm/A]     


%%
% Computes the SVD of the response matrix
Ivec = 1:7;
[U, S, V] = svd(Rx, 0);	
% Find the corrector changes use 48 singular values
DeltaAmpsx = -V(:,Ivec) * S(Ivec,Ivec)^-1 * U(:,Ivec)' *  (X-X0) * 1e-3; % X is in [mm]
% Changes the corrector strengths 
stepsp('HCORT', DeltaAmpsx,'Physics');%,CORLISTafter

% Get the vertical orbit
X = getam('BPMx');	
plot(BPMxspos, X-X0,'r.-', 'Markersize',10);	
%%

stepsp('HCORT', -DeltaAmpsx ,'Physics');

%%
BENDI = findcells(THERING,'FamName','BEND');
%kicks_hor = hw2physics('HCORT', 'setpoint', DeltaAmpsx, getlist('HCORT'),0.05)
L = 0.27646;
theta = 0.785398;
rho = L/theta;
alpha = 0;
kicks_hor = DeltaAmpsx/2 % [A]
deltax = 1*kicks_hor/(sin(theta/2) / rho)

deltax2 = zeros(1, length(BENDI));
deltax2(1:2:end) = deltax;
deltax2(2:2:end) = deltax;
%%

setshift(BENDI,deltax2,zeros(1,16))

X = getam('BPMx');	
plot(BPMxspos, X-X0,'g.-', 'Markersize',10);	
u = legend({'Initial','HCORT','DIP shift'});
set(u,'Location','NorthEast')
text(0.1, Xtext+0.3 ,['DIP shifts: [ ' num2str(1000*deltax','%1.1f ') ' mm ]'],'FontSize',13);

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
% set(gcf, 'color', 'w');
% export_fig(['hor_orbit_correction_DIPhshift.pdf'])

%%
dia=diag(S);

figure
set(gca,'FontSize',16)
semilogy(dia./dia(1),'Linewidth',1.1)
xlabel('SV number'); ylabel('Log_{1o} SV_n/SV_1')



