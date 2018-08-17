
dir_to_save = '/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/machine/THOMX/StorageRing/orbit/Sorting/SA_TSP_Rev1/SA_sorting/Figs/'

%%

global THERING

[TD, tune] = twissring(THERING,0,1:(length(THERING)+1));
BETA = cat(1,TD.beta);
ALPHA = cat(1,TD.alpha);
MU   = cat(1,TD.mu); % not normalized to 2pi
S  = cat(1,TD.SPos);

alpha = ALPHA;
beta = BETA;
Phi = MU;

%%
BENDI = findcells(THERING,'FamName','BEND')

sigmafielderor = 1e-4;
dBB = ww%sigmafielderor*randn(1,length(BENDI));

%dBB = 1e-4;
theta = 0.785398;
theta_kick = -dBB * tan(theta/2) 

%%

Npos = length(S);
Nkick = 2*length(BENDI);

Kickx = zeros(Nkick,1);

betakickx = zeros(Nkick,1);
phikickx = zeros(Nkick,1);

kick_pos = [10 11 37 38 40 41 67 68 83 84 110 111 113 114 140 141];

betakickx = beta(kick_pos,1);
phikickx = Phi(kick_pos,1);

Qx = 3.1699;
Qy = 1.6399;

Kickx(1:2:end) = 1*theta_kick;
Kickx(2:2:end) = 1*theta_kick;


%%

X = [];
Xprime = [];

for ipos = 1:Npos
X(ipos) = sqrt(beta(ipos,1))/(2*sin(pi*Qx)) * sum(sqrt(betakickx) .* Kickx .* cos(abs(phikickx - Phi(ipos,1)) - pi * Qx));
%Y(ipos) = sqrt(beta(ipos,2))/(2*sin(pi*Qy)) * sum(sqrt(betakicky) .* Kicky .* cos(abs(phikicky - Phi(ipos,2)) - pi * Qy));

Xprime(ipos) = 1/(2*sqrt(beta(ipos,1))*sin(pi*Qx)) * sum(sqrt(betakickx) .* Kickx .* (-alpha(ipos,1) .* cos(abs(phikickx - Phi(ipos,1)) - pi * Qx ) + sin(abs(phikickx - Phi(ipos,1)) - pi * Qx)));

%Xprime2(ipos) = 1/(2*sqrt(beta(ipos,1))*sin(pi*Qx)) * sum(sqrt(betakickx) .* Kickx .* (-alpha(ipos,1) .* cos(abs(phikickx - Phi(ipos,1)) - pi * Qx ))) + 1/(2*sqrt(beta(ipos,1))*sin(pi*Qx)) * sum(sqrt(betakickx) .* Kickx .*sin(abs(phikickx - Phi(ipos,1)) - pi * Qx));


end

A = (alpha(:,1) .* X' + beta(:,1) .* Xprime')./sqrt(beta(:,1));
B = X' ./sqrt(beta(:,1));
%W = A.^2 + B.^2;
W = sqrt(A.^2 + B.^2);

%%

figure(111)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(S,1000*A,'.-', 'Markersize',10);
hold on
plot(S,1000*B,'r.-', 'Markersize',10);
plot(S,1000*W,'k.-', 'Markersize',10);
hold off
hold all
xlim([0 S(end)]);
xlabel('Position [m]')
ylabel('Cost function x1000');
title(['Cost function distribution (hor.): ' ' W rms  = ' num2str(round2(1000*std(W),0.001)) '  ' ' W max = ' num2str(round2(1000*max(abs(W)),0.001)) ' '] );
%title('A cost function distribution (hor.) ');
u = legend({'B','A','W'});
set(u,'Location','NorthEast')

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
%export_fig([dir_to_save 'resSA_CSI_CostF_ABW_8dip_best.pdf'])
%export_fig([dir_to_save 'resSA_CSI_CostF_ABW_8dip_worse.pdf'])

%%

figure(122)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(S,X(1,:)*1e3,'.-r', 'Markersize',10);
xlim([0 S(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
title(['SR Horizontal Orbit: ' ' X rms  = ' num2str(round2(1000*std(X),0.001)) ' mm ' ' X max = ' num2str(round2(1000*max(abs(X)),0.001)) ' mm'] );


h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
%export_fig([dir_to_save 'resSA_CSI_COD_orbit_8dip_best.pdf'])
export_fig([dir_to_save 'resSA_CSI_COD_orbit_8dip_worse.pdf'])

%%

figure(2)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(S,Xprime(1,:)*1e3,'.-r', 'Markersize',10);
% hold on
% plot(S+1,Xprime2(1,:)*1e3,'.-b', 'Markersize',10);
% hold off
xlim([0 S(end)]);
xlabel('Position [m]')
ylabel('dX/ds [mrad]');
title(['SR Horizontal Slope: '  'dX/ds rms  = ' num2str(round2(1000*std(Xprime),0.001)) ' mrad ' ' dX/ds max = ' num2str(round2(1000*max(abs(Xprime)),0.001)) ' mrad'] );

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
%export_fig([dir_to_save 'resSA_CSI_Slope_orbit_8dip_best.pdf'])
export_fig([dir_to_save 'resSA_CSI_Slope_orbit_8dip_worse.pdf'])

%%

figure(3)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(S,W,'.-', 'Markersize',10);
hold all
xlim([0 S(end)]);
xlabel('Position [m]')
ylabel('Cost function');
title('A cost function distribution (hor.) ');

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
export_fig([dir_to_save 'cost_function1_8dip.pdf'])

%%


sigmafielderor = 1e-4;
fielderror = sigmafielderor*randn(1,length(BENDI));
dBB0 = fielderror; 
% = simple_sorting(fielderror)


