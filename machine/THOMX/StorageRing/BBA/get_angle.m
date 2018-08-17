function [spos, orbit] = get_angle(varargin)

if nargin == 0 | ~isstruct(varargin(1))
	global THERING;
	RING = THERING;
end
L = length(RING);
spos = findspos(RING,1:L+1);
%orbit4 = findorbit4(RING,0,1:length(RING)+1);

orbit = findorbit6(RING,1:length(RING)+1);
%orbit = findorbit4(RING,0,1:length(RING)+1);


figure(1)
h1 = subplot(5,1,[1 2]);
set(gca,'FontSize',14)
plot(spos,orbit(2,:)*1e3,'.-', 'Markersize',10);
xlim([0 spos(end)]);
hold all
xlabel('Position [m]')
ylabel('PX [mrad]');
title('AT Storage Ring Horizontal Angles ');

h2 = subplot(5,1,3);
drawlattice 
set(h2,'YTick',[])


h3 = subplot(5,1,[4 5]);
set(gca,'FontSize',14)
plot(spos,orbit(4,:)*1e3,'r.-', 'Markersize',10);
hold all
xlabel('Position [m]')
ylabel('PY [mrad]');
%title('AT Storage Ring Vertical Orbit ');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');

end