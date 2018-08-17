function y = simple_sorting(dBB)
   
   
%%

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
theta_kick = -dBB * tan(theta/2);

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

for ipos = 1:Npos
    
X(ipos) = sqrt(beta(ipos,1))/(2*sin(pi*Qx)) * sum(sqrt(betakickx) .* Kickx .* cos(abs(phikickx - Phi(ipos,1)) - pi * Qx));

end

y = std(X)

figure(3)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(S,X(1,:)*1e3,'.-r', 'Markersize',10);
xlim([0 S(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
title('Storage Ring Horizontal Orbit ');

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');

