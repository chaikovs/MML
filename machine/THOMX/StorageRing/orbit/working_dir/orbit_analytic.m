
%%
findcells(THERING,'FamName','BEND')


%% Dipole Field error

dBB = 1e-4;
theta = 0.785398;
theta_kick = -dBB * tan(theta/2) 

%%
findcells(THERING,'FamName','BEND')

 THERING{11}.ByError = dBB

 %%
[spos, orbit] = get_orbit;

%%

THERING{11}.ByError = 0


%%
[spos, orbit] = get_orbit;

%%


[beta, Phi, S] = get_beta_phase;

%%


Npos = length(S);
Nkick = 2;
Kickx = zeros(Nkick,1);
Kicky = zeros(Nkick,1);
betakickx = zeros(Nkick,1);
phikickx = zeros(Nkick,1);
betakicky = zeros(Nkick,1);
phikicky = zeros(Nkick,1);

kick_pos = 11:12;%119:120;%10:11;%6:7;%79:80;%71:72;%69:70;%8:9;%144:145;%81:82;%40:41;%
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


%%
flag_save = 0;
orb2 = load('orbit2');

figure(4)
h1 = subplot(5,1,[1 2]);
set(gca,'FontSize',14)
plot(S,X(1,:)*1e3,'.-r', 'Markersize',10);


xlim([0 S(end)]);
hold on
plot(spos,orbit(1,:)*1e3,'.-k', 'Markersize',10);
plot(orb2(:,1),1000*orb2(:,7),'b-', 'Linewidth',2)
hold off

u = legend('Analytic','AT Orbit4', 'BETA');

set(u,'Location','NorthEast')
%xlabel('Position [m]')
ylabel('X [mm]');
title('Storage Ring Horizontal Orbit ');

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
    export_fig(['Orbit_DQUAD_hor_displacement_orb4_BETA_AT_ANALYTIC'  '.pdf'])
end

%%








