function [cod_max,cod_std] = orbit_anal_dip_apply_error(sigmafielderor,save_flag) %dBBin


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
BENDI = findcells(THERING,'FamName','BEND');

%sigmafielderor = 5e-4;
dBBin = sigmafielderor*randn(1,length(BENDI));

%dBB = 1e-4;
theta = 0.785398;
theta_kick = -dBBin * tan(theta/2);

%%

Npos = length(S);
Nkick = 2*length(BENDI);

Kickx = zeros(Nkick,1);

betakickx = zeros(Nkick,1);
phikickx = zeros(Nkick,1);

kick_pos = [11 12 39 40 42 43 70 71 88 89 116 117 120 121 148 149];

betakickx = beta(kick_pos,1);
phikickx = Phi(kick_pos,1);

Qx = 3.1699;
Qy = 1.6399;

Kickx(1:2:end) = 1*theta_kick;
Kickx(2:2:end) = 1*theta_kick;


%%

X = [];

for ipos = 1:Npos
    
X(ipos) = sqrt(beta(ipos,1))/(2*sin(pi*Qx)) * sum(sqrt(betakickx) .* Kickx .* cos(abs(phikickx - Phi(ipos,1)) - pi * Qx));

Xprime(ipos) = 1/(2*sqrt(beta(ipos,1))*sin(pi*Qx)) * sum(sqrt(betakickx) .* Kickx .* (-alpha(ipos,1) .* cos(abs(phikickx - Phi(ipos,1)) - pi * Qx ) + sin(abs(phikickx - Phi(ipos,1)) - pi * Qx)));

end

A = (alpha(:,1) .* X' + beta(:,1) .* Xprime')./sqrt(beta(:,1));
B = X' ./sqrt(beta(:,1));
W = sqrt(A.^2 + B.^2);

% d = std(W(kick_pos));
d = max(W);%std(W);
cod_std = std(X);
cod_max = max(X);

if save_flag == 1

figure
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(S,X(1,:)*1e3,'.-r', 'Markersize',10);
xlim([0 S(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
title(['SR Horizontal Orbit: ' ' X rms  = ' num2str(round2(1000*d,0.001)) ' mm ' ' X max = ' num2str(round2(1000*max(abs(X)),0.001)) ' mm'] );

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
print('COD_dipole_field error3e-3_anal.png','-dpng','-r300')

% figure
% h1 = subplot(3,1,[1 2]);
% set(gca,'FontSize',14)
% plot(S,W,'.-', 'Markersize',10);
% hold all
% xlim([0 S(end)]);
% xlabel('Position [m]')
% ylabel('Cost function');
% title('A cost function distribution (hor.) ');
% 
% h2 = subplot(3,1,3);
% drawlattice 
% set(h2,'YTick',[])
% 
% linkaxes([h1 h2],'x')
% set([h1 h2],'XGrid','On','YGrid','On');



%%

%% Check with AT

global THERING


for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = dBBin(i);
        
end

[spos, orbitww] = get_orbit;  

figure
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(S,X(1,:)*1e3,'.-r', 'Markersize',10);
hold on
plot(spos,orbitww(1,:)*1e3,'-k', 'Markersize',11);
hold off
xlim([0 spos(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
u = legend({'Analytic','Best AT'});
set(u,'Location','NorthEast')
title('AT vs analytical comparison')

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
print('COD_dipole_field error3e-3_anal_AT.png','-dpng','-r300')

end
