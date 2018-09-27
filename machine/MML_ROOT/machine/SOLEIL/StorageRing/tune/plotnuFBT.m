function plotnuFBT
%PLOTNUFBT - plot tune excited with FBT
%
%

%% Written by Laurent S. Nadolski

devName = 'ans/rf/bbfdataviewer.1-tunex';
rep = tango_read_attributes2(devName, {'FFTabs','FFTord'});
xvectZ = rep(1).value;
zvectZ = rep(2).value;

devName = 'ans/rf/bbfdataviewer.2-tunez';
rep = tango_read_attributes2(devName, {'FFTabs','FFTord'});
xvectX = rep(1).value;
zvectX = rep(2).value;

%% 

figure;
subplot(2,1,1)
semilogy(xvectX, zvectX); grid on
yaxis([1e-10 1])
xlabel('Qx')

subplot(2,1,2)
semilogy(xvectZ, zvectZ); grid on
yaxis([1e-10 1])
xlabel('Qz')

nu = gettuneFBT;
suptitle(sprintf('Betatron Tune from FTB: Qx= %5.4f, Qz = %5.4f', nu(1), nu(2)))