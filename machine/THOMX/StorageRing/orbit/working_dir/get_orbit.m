function [spos, orbit] = get_orbit(varargin)

if nargin == 0 | ~isstruct(varargin(1))
	global THERING;
	RING = THERING;
end
L = length(RING);
spos = findspos(RING,1:L+1);
%orbit4 = findorbit4(RING,0,1:length(RING)+1);

orbit = findorbit6(RING,1:length(RING)+1);
%orbit = findorbit4(RING,0,1:length(RING)+1);

% figure(21)
% plot(spos,orbit(1,:)*1e3,'.-r', 'Markersize',10);
% title('Closed Orbit Distortion')
% hold on
% plot(spos,orbit4(1,:)*1e3,'.-b', 'Markersize',10);
% hold off

figure
subplot 211
set(gca,'FontSize',16)
plot(spos,orbit(1,:)*1e3,'.-r', 'Markersize',13, 'Linewidth',1.6);
xlabel('Position [m]')
ylabel('X [mm]');
title('AT Storage Ring Horizontal Orbit ');
subplot 212
set(gca,'FontSize',16)
plot(spos,orbit(3,:)*1e3,'.-b', 'Markersize',13, 'Linewidth',1.6);
xlabel('Position [m]')
ylabel('Y [mm]');
title('AT Storage Ring Vertical Orbit ');


% set(gcf, 'color', 'w');
% export_fig('/Users/ichaikov/Work/ThomX/Figures/Figs_matlab/thomx_orbit_sextON_disp.pdf')
