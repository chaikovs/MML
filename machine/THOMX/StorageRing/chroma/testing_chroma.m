
clc; close all; clear all;

% findcells(THERING,'FamName','BEND')
%find(atgetcells(THERING,'Class','BEND'))

%% Initial lattices

thomx_ring=ThomX_017_064_r56_02_chro00RF;
%thomx_ring=ThomX_016_058_r56_02_chro22;

%%

% atgetfieldvalues(thomx_ring,findcells(thomx_ring,'FamName','QP1'), 'PolynomB',{1,2})
% atgetfieldvalues(thomx_ring,findcells(thomx_ring,'FamName','SX2'), 'PolynomB',{1,3})
% getatfield('SX2','PolynomB')

%%

% circumference = findspos(thomx_ring, length(thomx_ring)+1);
% revTime = circumference / 2.99792458e8;
% revFreq = 2.99792458e8 / circumference;
% %[TD, tunes, chromaticity] = twissring(thomx_ring,0, length(thomx_ring)+1, 'chrom', 1e-8);
% [lindata,tunes_fraq,chrom]=atlinopt(thomx_ring,0,1:length(thomx_ring)+1); 
% tunes = lindata(end).mu/2/pi
% chromx = chrom(1);
% chromy = chrom(2);

%%

tuneDPx = []; tuneDPz = [];

dp = -0.02:0.005:0.02;
for idp = dp
%[TD,t,c] = atlinopt(thomx_ring,idp,1);
[~, t] = twissring(thomx_ring, idp, 1:length(thomx_ring)+1);

tuneDPx = [tuneDPx t(1)];
tuneDPz = [tuneDPz t(2)];


end

% Get polynome
px = polyfit(dp,tuneDPx,4)
 
pz = polyfit(dp,tuneDPz,4)
 

%[TD,t0,c] = atlinopt(thomx_ring,0,1);

figure
subplot 211
set(gca,'FontSize',18)
plot(dp,(tuneDPx - tuneDPx(5)),'r.-','MarkerSize',9 )
ylabel('Horizontal tune ')
%title(['Tune shift with dp/p. ' ' Working Point: ' num2str(FractionalTune(1,1)])
legend(sprintf('Chro_x %f',px(4)));
legend('show','Location','NorthEast');
subplot 212
set(gca,'FontSize',18)
plot(dp,(tuneDPz - tuneDPz(5))  ,'b.-','MarkerSize',9 )
%ylim([0.1 1.1])
xlabel(' Momentum deviation dp/p')
ylabel('Vertical tune ')
legend(sprintf('Chro_z %f',pz(4)));
legend('show','Location','NorthEast');
%print('thomx_tune_dpp.png','-dpng','-r300')


%%


% tuneDPx = []; tuneDPz = [];tuneDPx2 = []; tuneDPz2 = [];
% deltaRF = -100000:10000:100000;%
%  
% dp = deltaRF/getrf('Physics') / getmcf;   
% 
% global THERING
% 
% %RING=fitchrom_alex(THERING,[2.0 -2.0],'SX2' ,'SX3' );
% 
% %THERING = RING;
% 
% RF0 = getrf('Physics');
% 
% for i = 1:length(deltaRF)
%     %setrf(RF0 + DeltaRF(i), UnitsFlag, ModeFlag)
%     
%     
%     setrf(RF0 + deltaRF(i),'Physics');
%     
%     %global THERING
%     
%     m66 = findm66(THERING);
%     
%     
%     % Johan's method to resolve above or below half integer
%     %FractionalTune = getnusympmat(m66);
%      [FractionalTune, IntegerTune] = modeltune
%     
%     tuneDPx = [tuneDPx FractionalTune(1)];
%     tuneDPz = [tuneDPz FractionalTune(2)];
%     
% [~, t] = twissring(THERING, dp(i), 1:length(THERING)+1);
% 
% tuneDPx2 = [tuneDPx2 t(1)];
% tuneDPz2 = [tuneDPz2 t(2)];
% 
%     
% end
% 
% % Get polynome
% px = polyfit(dp,tuneDPx2,4)
%  
% pz = polyfit(dp,tuneDPz2,4)
%  
% 
% %[TD,t0,c] = atlinopt(thomx_ring,0,1);
% 
% figure
% subplot 211
% set(gca,'FontSize',18)
% plot(dp,(tuneDPx2 - tuneDPx2(11)),'r.-','MarkerSize',9 )
% ylabel('Horizontal tune ')
% %title(['Tune shift with dp/p. ' ' Working Point: ' num2str(FractionalTune(1,1)])
% legend(sprintf('Chro_x %f',px(4)));
% legend('show','Location','NorthEast');
% subplot 212
% set(gca,'FontSize',18)
% plot(dp,(tuneDPz2 - tuneDPz2(11))  ,'b.-','MarkerSize',9 )
% %ylim([0.1 1.1])
% xlabel(' Momentum deviation dp/p')
% ylabel('Vertical tune ')
% legend(sprintf('Chro_z %f',pz(4)));
% legend('show','Location','NorthEast');
% %print('thomx_tune_dpp.png','-dpng','-r300')

%%

measchro

%%
measchroresp

%%
setchro([2,2])




%%

d=0.02;
[px ,pz] = get_nudp(d, thomx_ring)

fprintf('px =  %8.2f  %8.2f   %8.2f   %8.2f   %8.2f  \n',px)
fprintf('pz =  %8.2f  %8.2f   %8.2f   %8.2f   %8.2f  \n',pz)

%%









