function comparaison_orbit
% comparaison orbite


% orbite en cours
orbit=load_orbit_corr;
Xm1=orbit.x;
Zm1=orbit.z;
corx1=orbit.corx;
corz1=orbit.corz;

% orbite sauvegarde
file ='boo_all_2007-05-28_22-59-29.mat'; % 
file1='boo-all-2007-05-28-22-59-29.mat'; % 
Directory =  [getfamilydata('Directory','DataRoot') 'Datatemp'];
pwdold = pwd;
cd(Directory);
load(file, 'boo' ,'timing' ,'orbit');
Xm2=orbit.x;
Zm2=orbit.z;
corx2=orbit.corx;
corz2=orbit.corz;
cd(pwdold);

% plot
figure(2)
subplot(2,1,1)
    plot(Xm1,'-ob');hold on
    plot(Xm2,'-ok');hold off
    legend('Current',file1)
    grid on; ylabel('X (mm)')
subplot(2,1,2)
    plot(Zm1,'-ob');hold on
    plot(Zm2,'-ok');hold off
    legend('Current',file1)
    grid on; ylabel('Z (mm)')


figure(3)
subplot(2,1,1)
    plot(corx1,'-ob');hold on
    plot(corx2,'-ok');hold off
    legend('Current',file1)
    grid on; ylabel('CORX (A)')
subplot(2,1,2)
    plot(corz1,'-ob');hold on
    plot(corz2,'-ok');hold off
    legend('Current',file1)
    grid on; ylabel('CORZ (A)')

