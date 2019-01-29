% Directory de sauvegarde des spectres :/home/production/matlab/matlabML/measdata/SOLEIL/LT1data/fae

S_avant = load('-mat','2008-02-27_14-50-00_1_reglage_avant_Golden.mat')
S_apres = load('-mat','2005-02-22_16-42-08_4_reglage_Golden.mat')
figure(10);plot(S_avant.xdata2,S_avant.ydata2,'b');
figure(10);hold on ; plot(S_apres.xdata2,S_apres.ydata2,'r');
legend('S_avant','S_apres');xlabel('MeV');ylabel('charge normalisée');