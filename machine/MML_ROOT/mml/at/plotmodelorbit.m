function varargout = plotcod
%PLOTMODELORBIT - Plot closed orbit distortion
%
%  ALGORITHM
%  See modeltwiss and getpvmodel

%
%  Written by Gregory J. Portmann
%  Modified by Laurent S. Nadolski

[x, y, sx, sy] = modeltwiss('x','All','All');
[BPMx, BPMy, sBPMx, sBPMy] = modeltwiss('x','BPMx','BPMz');


h1 = subplot(5,1,[1 2]);

plot(sx, 1000*x,'b');
title('Closed Orbit');
ylabel('Horizontal [mm]');
xlim([0 sx(end)]);


h2 = subplot(5,1,3)
drawlattice
set(h2,'YTick',[])

h3 = subplot(5,1,[4 5]);
plot(sx, 1000*y,'b');

ylabel('Vertical [mm]');
xlabel('Position [m]');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');