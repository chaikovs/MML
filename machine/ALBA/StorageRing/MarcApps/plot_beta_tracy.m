function plottwissT(file,cell)
%function plottwissT(file,cell)
%
% plot Twiss function from TRacy output file
% cell = 1 show all the ring
% cell = 4 show one out of 4 periods
%
% Written by Laurent S. Nadolski, 03/04, SOLEIL
ex=4.5E-9;
ey=0.01*ex;
dE=1.05E-3;
if nargin == 0
  file = 'linlat.out';
end
files = 'alba_structure.dat';

try
    struc=dlmread(files);
catch
    try
        struc=dlmread('/home/munoz/Mounts/acc-s01/tracy/wrk/alba_structure.dat');
    catch
        error('Alba structure not found');
    end
end
if nargin < 2
    cell = 4;
end

[dummy s ax bx mux etax etaxp ay by muy etay etayp] = ...
 textread(file,'%s %f %f %f %f %f %f %f %f %f %f %f','headerlines',4);
[s2 idx] = unique(s);
ax2 = ax(idx); ay2 = ay(idx);
bx2 = bx(idx); by2 = by(idx);
etax2 = etax(idx); etay2 = etay(idx);

figure(21)
cla
%plotlattice(0,2)
hold on;
plot(s2,bx2,'r-',s2,by2,'b-');
plot(s2,10*etax2,'g-')
legend('\beta_x','\beta_y','10\times\eta_x',-1)
xaxis([0 s(end)/cell])
title('Optical functions')
xlabel('s [m]')
ylabel('[m]')
datalabel on
dl(-2,1.5)
yaxis([-4 25])
%print -deps2c beta.eps
figure (22)
for i=1:size(s2),
    sx(i)=1E3*sqrt(ex*bx2(i)+dE*dE*etax2(i)*etax2(i));
    sy(i)=1E3*sqrt(ey*by2(i));
end
plot(s2, sx,'r-',s2,sy*10,'b-')
%dl(-2,1.5)
xaxis([0 s(end)/(2*cell)])
ylabel('[mm]')
xlabel('s [m]')
hold on
dl(0.0,0.05)
legend('\sigma_x', '10\times\sigma_y',-1)
%print -deps2c sigma.eps
