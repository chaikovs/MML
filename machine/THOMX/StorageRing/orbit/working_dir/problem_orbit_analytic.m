
global THERING;

%% Horizontal displacement
L = 0.27646;
deltax = 1e-3;
theta = 0.785398;
rho = L/theta;
alpha = 0;

theta_kick = (sin(theta/2 - alpha) / (rho * cos(alpha)) ) * deltax
%theta_kick_2 = (tan(theta/2) / (rho ) ) * deltax 

%%
findcells(THERING,'FamName','BEND')

%%
setshift(10, deltax, 0)

%%
[spos, orbit] = get_orbit;

%%
setshift(10, 0, 0)

%% Rotation

L = 0.27646;
phix = deg2rad(0.1);
phiy = deg2rad(0.1);
phis = deg2rad(0.1);
rho = L/theta;
alpha = 0;

theta_kick_rotx = (sin(theta/2)/(theta/2) - cos(theta/2 - alpha)/cos(alpha))  * phix
theta_kick_roty =  -((sin(theta/2) * sin(theta/2 - alpha)) / cos(alpha))  * phiy
% theta_kick_rots = sin(theta/2)  * phis
theta_kick_rots = (sin(theta)/2)  * phis

theta_kicky = theta_kick_rotx
theta_kick = theta_kick_roty
%%
%setyrot(10, phiy)
%setxrot(10, phix)
settilt(10, phis)
%addsrot(40, phis)

%%
[spos, orbit] = get_orbit;

%%
setyrot(10, 0)
%setxrot(10, 0)
%settilt(40, 0)
%addsrot(40, 0)

%% Dipole Field error

dBB = 1e-3;
theta = 0.785398;
theta_kick = -dBB * tan(theta/2) 

%%

 THERING{11}.ByError = dBB

 %%
[spos, orbit] = get_orbit;

%%

THERING{10}.ByError = 0

%%

%% Foc QUAD Horizontal displacement

%QP2
kquad = 0.9262547E+01;
%kquad = 0.1043595E+02;
Lquad = 0.15;
deltaxquad = 200e-6;

theta_kick = sqrt(kquad)*tan(sqrt(kquad) * Lquad/2) * deltaxquad

%%
findcells(THERING,'FamName','QP2')

%%

setshift(8, deltaxquad,0)

%%
[spos, orbit] = get_orbit;

%%

setshift(8,0,0)

%% Get beta and phase

[TD, tune] = twissring(THERING,0,1:(length(THERING)+1));
BETA = cat(1,TD.beta);
MU   = cat(1,TD.mu); % not normalized to 2pi
S  = cat(1,TD.SPos);

beta = BETA;
Phi = MU;
    
%%

Npos = length(S);
Nkick = 2;
Kickx = zeros(Nkick,1);
Kicky = zeros(Nkick,1);
betakickx = zeros(Nkick,1);
phikickx = zeros(Nkick,1);
betakicky = zeros(Nkick,1);
phikicky = zeros(Nkick,1);

kick_pos = 10:11;%119:120;%10:11;%6:7;%79:80;%71:72;%69:70;%8:9;%144:145;%81:82;%40:41;%
%kick_pos = kick_pos';

betakickx(1:2) = beta(kick_pos,1);
phikickx(1:2) = Phi(kick_pos,1);
betakicky(1:2) = beta(kick_pos,2);
phikicky(1:2) = Phi(kick_pos,2);
% Qx = 3.17494;
% Qy = 1.71988;
Qx = 3.1699;
Qy = 1.6399;

% Kickx(1:2) = 4*theta_kick; % facror of XXX is missing
Kicky(1:2) = 0;
Kickx(1,1) = 1*theta_kick;
Kickx(2,1) = 1*theta_kick;

% Kickx(1:2) = 0;
% Kicky(1,1) = 24*theta_kicky;
% Kicky(2,1) = -24*theta_kicky;


%%

X = [];
Y = [];

for ipos = 1:Npos
X(ipos) = sqrt(beta(ipos,1))/(2*sin(pi*Qx)) * sum(sqrt(betakickx) .* Kickx .* cos(abs(phikickx - Phi(ipos,1)) - pi * Qx));
Y(ipos) = sqrt(beta(ipos,2))/(2*sin(pi*Qy)) * sum(sqrt(betakicky) .* Kicky .* cos(abs(phikicky - Phi(ipos,2)) - pi * Qy));
end

%%
figure(2)
h1 = subplot(5,1,[1 2]);
set(gca,'FontSize',14)
plot(S,X(1,:)*1e3,'.-r', 'Markersize',10);
xlim([0 S(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
title('Storage Ring Horizontal Orbit ');

h2 = subplot(5,1,3);
drawlattice 
set(h2,'YTick',[])

h3 = subplot(5,1,[4 5]);
set(gca,'FontSize',14)
plot(S,Y(1,:)*1e3,'.-b', 'Markersize',10);
xlabel('Position [m]')
ylabel('Y [mm]');
title('Storage Ring Vertical Orbit ');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');

%%
flag_save = 0;

figure(3)
h1 = subplot(5,1,[1 2]);
set(gca,'FontSize',14)
plot(S,X(1,:)*1e3,'.-r', 'Markersize',10);

xlim([0 S(end)]);
hold on
plot(spos,orbit(1,:)*1e3,'.-k', 'Markersize',10);
hold off

%xlabel('Position [m]')
ylabel('X [mm]');
title('Storage Ring Horizontal Orbit ');
u = legend('Analytic','AT Orbit4');

set(u,'Location','NorthEast')

h2 = subplot(5,1,3);
drawlattice 
set(h2,'YTick',[])

h3 = subplot(5,1,[4 5]);
set(gca,'FontSize',14)
plot(S,Y(1,:)*1e3,'.-b', 'Markersize',10);
hold on
plot(spos,orbit(3,:)*1e3,'.-k', 'Markersize',10);
hold off
xlabel('Position [m]')
ylabel('Y [mm]');
title('Storage Ring Vertical Orbit ');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');


if (flag_save == 1)
    set(gcf, 'color', 'w');
    export_fig(['Orbit_dipole_vert_rotation_orb4_factor8'  '.pdf'])
end
%%
