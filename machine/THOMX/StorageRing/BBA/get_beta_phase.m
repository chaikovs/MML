function [BETA, MU, S] = get_beta_phase(varargin)
% UNCOUPLED! beta-phase functions
%

if nargin == 0 | ~isstruct(varargin(1))
	global THERING
	RING = THERING;
end
L = length(RING);
spos = findspos(RING,1:L+1);

%[TD, tune] = twissring(THERING,0,1:(length(THERING)));
[TD, tune] = twissring(THERING,0,1:(length(THERING)+1));
BETA = cat(1,TD.beta);
MU   = cat(1,TD.mu); % not normalized to 2pi
S  = cat(1,TD.SPos);
%disp(tune)

% Figure to check
% plot betax and betay in two subplots
figure(31)
h1 = subplot(5,1,[1 2]);
plot(S,BETA(:,1),'.-b', 'Markersize',10);
xlim([0 S(end)]);
ylabel('\beta_x [m]');
title('\beta-functions');

h2 = subplot(5,1,3);
drawlattice 
set(h2,'YTick',[])

h3 = subplot(5,1,[4 5]);
plot(S,BETA(:,2),'.-r', 'Markersize',10);
xlabel('s - position [m]');
ylabel('\beta_z [m]');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');

% plot mux and muy in two subplots
figure(32)
h1 = subplot(5,1,[1 2]);
plot(S,rad2deg(MU(:,1)/(2*pi)),'.-b', 'Markersize',10);
xlim([0 S(end)]);
ylabel('\mu_x [deg]');
title('\mu-functions');

h2 = subplot(5,1,3);
drawlattice 
set(h2,'YTick',[])

h3 = subplot(5,1,[4 5]);
plot(S,rad2deg(MU(:,2)/(2*pi)),'.-r', 'Markersize',10);
xlabel('s - position [m]');
ylabel('\mu_z [deg]');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');

% plot diff mux and muy in two subplots

figure(33)
h1 = subplot(5,1,[1 2]);
plot(S(1:end-1),rad2deg(diff(MU(:,1)/(2*pi))),'.-b', 'Markersize',10);
xlim([0 S(end)]);
ylabel('Hor. phase advance diff [deg]');
title('\mu-functions');

h2 = subplot(5,1,3);
drawlattice 
set(h2,'YTick',[])

h3 = subplot(5,1,[4 5]);
plot(S(1:end-1),rad2deg(diff(MU(:,2)/(2*pi))),'.-r', 'Markersize',10);

xlabel('s - position [m]');
ylabel('Ver. phase advance diff [deg]');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');

figure(38)
h1 = subplot(5,1,[1 2]);
plot(S,(MU(:,1)/(2*pi)),'.-b', 'Markersize',10);
xlim([0 S(end)]);
ylabel('\mu_x [deg]');
title('\mu-functions');

h2 = subplot(5,1,3);
drawlattice 
set(h2,'YTick',[])

h3 = subplot(5,1,[4 5]);
plot(S,(MU(:,2)/(2*pi)),'.-r', 'Markersize',10);
xlabel('s - position [m]');
ylabel('\mu_z [deg]');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');


