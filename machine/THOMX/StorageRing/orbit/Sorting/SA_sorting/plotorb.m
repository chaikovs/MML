function f = plotorb(inputdip)


global THERING
[TD, tune] = twissring(THERING,0,1:(length(THERING)+1));
BETA = cat(1,TD.beta);
MU   = cat(1,TD.mu); % not normalized to 2pi
S  = cat(1,TD.SPos);

beta = BETA;
Phi = MU;

%%
BENDI = findcells(THERING,'FamName','BEND');

% sigmafielderor = 1e-4;
% dBB = sigmafielderor*randn(1,length(BENDI));

%dBB = 1e-4;
theta = 0.785398;
theta_kick = -inputdip * tan(theta/2);

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

end

y = std(X);

shg
figure(1)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
temp_1 = plot(S,X(1,:)*1e3,'.-r', 'Markersize',10);
set(temp_1,'erasemode','none');
xlim([0 S(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
title(['SR Horizontal Orbit: ' ' X rms  = ' num2str(round(1000*y,3)) ' mm ' ' X max = ' num2str(round(1000*max(abs(X)),3)) ' mm'] );

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');


drawnow;


