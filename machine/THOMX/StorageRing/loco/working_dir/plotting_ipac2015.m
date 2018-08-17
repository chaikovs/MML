%%

[Dx, Dy, Sx, Sy] = modeldisp



[TD, tune] = twissring(THERING,0,1:(length(THERING)+1));
BETA = cat(1,TD.beta);
MU   = cat(1,TD.mu); % not normalized to 2pi
S  = cat(1,TD.SPos);
%disp(tune)

% Figure to check
% plot betax and betay in two subplots
figure(1)
h1 = subplot(5,1,[1 4]);
set(gca,'FontSize',16)
plot(S,BETA(:,1),'.-b', 'Markersize',10, 'Linewidth', 1.6);
hold on
plot(S,BETA(:,2),'.-r', 'Markersize',10, 'Linewidth', 1.6);
plot(Sx, 10*Dx,'.-g', 'Markersize',10, 'Linewidth', 1.6)
hold off
xlim([0 S(end)]);
ylabel('\beta_x,\beta_z,\eta_x [m]');
%title('Optical-functions');
u = legend({'\beta_x','\beta_z','10*\eta_x'});
set(u,'Location','NorthEast')
h2 = subplot(5,1,5);
set(gca,'FontSize',16)
drawlattice 
set(h2,'YTick',[])
xlabel('s - position [m]');

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');



%% poster


figure(1)
set(gcf, 'color', 'w');
export_fig('/Users/ichaikov/Work/Schools_Confs/IPAC2015/poster/images/thomx_optics.pdf')

%%
figure(1)
set(gcf, 'color', 'w');
export_fig('/Users/ichaikov/Work/Schools_Confs/IPAC2015/paper/thomx_optics.pdf')
%%


data22 = load('results_Ring1');

%figure(22)
set(gca,'FontSize',14)
%h1=plot(data22(:,1), 1.5*data22(:,2), 'k-');
xlim([0 4.5])

%%

%% Plot BPM scale-factors


figure
set(gca,'FontSize',16)
plot(VBPMgain,'bo-', 'MarkerSize', 10)
hold on
plot(HBPMgain,'ro-', 'MarkerSize', 10)
plot(wrong_bpm_gain(1:12),'rd', 'MarkerSize', 10)
plot(wrong_bpm_gain(13:24),'bd', 'MarkerSize', 10)
u = legend({'BPMz gain (fit)','BPMx gain (fit)','BPMx gain (sim)','BPMz gain (sim)'});
set(u,'Location','SouthWest')
hold off
grid on
xlabel('BPM number');
ylabel('BPM gain');

%%
set(gcf, 'color', 'w');
export_fig('/Users/ichaikov/Work/Schools_Confs/IPAC2015/paper/BPMgain.pdf')
%%


%% Plot CORR scale-factors


figure
set(gca,'FontSize',16)
plot(VCMkick/0.1,'bo-', 'MarkerSize', 10)
hold on
plot(HCMkick/0.1,'ro-', 'MarkerSize', 10)
plot(wrong_corr_gain(1:12),'rd', 'MarkerSize', 10)
plot(wrong_corr_gain(13:24),'bd', 'MarkerSize', 10)
u = legend({'VCOR gain (fit)','HCOR gain (fit)','HCOR gain (sim)','VCOR gain (sim)'});
set(u,'Location','NorthEast')
hold off
grid on
xlabel('Corrector number');
ylabel('Corrector gain');

set(gcf, 'color', 'w');
export_fig('/Users/ichaikov/Work/Schools_Confs/IPAC2015/paper/CORRgain.pdf')
%%

%% Plot QUAD scale-factors

load loco_ipac2015_QUAD.mat

quadscales = FitParameters(1).Values(1:24)./FitParameters(end).Values(1:24);

figure
set(gca,'FontSize',16)
plot(quadscales,'bo-', 'MarkerSize', 10)
hold on
plot(1+deltaK,'rd-', 'MarkerSize', 10)
hold off
%title('Quadrupole scaling factors for correction')
grid on
u = legend({'scaling factors (fit)','scaling factors (sim)'});
set(u,'Location','SouthEast')
hold off
grid on
xlabel('Quadrupole number');
ylabel('Quadrupole scaling factors');

%%
set(gcf, 'color', 'w');
export_fig('/Users/ichaikov/Work/Schools_Confs/IPAC2015/paper/quadcorr.pdf')

%%

[Dx, Dy] = measdisp('BPMx', [], 'BPMz','Physics')

[Dxmod, Dymod, Sx, Sy] = modeldisp('BPMx',[],'BPMz',[],'Physics')

figure
set(gca,'FontSize',16)
plot(Sx, Dy,'b.-','Linewidth',1.6, 'MarkerSize', 13)
hold on
xlabel('s-position [m]'); ylabel('\eta_z [m]')
xlim([0 18])

%%
[Dxafter, Dyafter] = measdisp('BPMx', [], 'BPMz','Physics')
plot(Sx, Dyafter,'r.-','Linewidth',1.6, 'MarkerSize', 13)
hold off
u = legend({'Before correction','After correction'});
set(u,'Location','NorthEast')
%%
set(gcf, 'color', 'w');
export_fig('/Users/ichaikov/Work/Schools_Confs/IPAC2015/paper/vertDisp.pdf')



