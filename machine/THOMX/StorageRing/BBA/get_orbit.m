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

indx = findcells(THERING,'FamName','BPMx');
figure
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(spos(indx), orbit(1,indx),'.-', 'Markersize',13)
xlim([0 spos(end)]);
hold all
xlabel('Position [m]')
ylabel('X [mm]');
title('AT Storage Ring Horizontal Orbit ');

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])



figure
h1 = subplot(5,1,[1 2]);
set(gca,'FontSize',14)
plot(spos,orbit(1,:).*1e3,'.-', 'Markersize',10);
xlim([0 spos(end)]);
hold all
xlabel('Position [m]')
ylabel('X [mm]');
title('AT Storage Ring Horizontal Orbit ');

h2 = subplot(5,1,3);
drawlattice 
set(h2,'YTick',[])


h3 = subplot(5,1,[4 5]);
set(gca,'FontSize',14)
plot(spos,orbit(3,:).*1e3,'r.-', 'Markersize',10);
hold all
xlabel('Position [m]')
ylabel('Y [mm]');
%title('AT Storage Ring Vertical Orbit ');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');


end


