%% 13 dipoles

dir_to_saveFigs = '/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/Figs/';


% dBB0~1.2e-3 NOMINAL
% COD14 = load('/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/2017-02-09/14-40-28/sort_full_COD_2017-02-09_14-40-27.mat');
% 
% dBB0 8 dip incr nominal I
%COD14 = load('/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/2017-02-10/10-23-33/sort_full_COD_2017-02-10_10-23-33.mat');

% dBB0 8 dip incr @200A
%COD14 = load('/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/2017-02-10/12-27-36/sort_full_COD_2017-02-10_12-27-36.mat');

% dBB0 13 dip @200A
%COD14 = load('/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/2017-02-10/12-36-03/sort_full_COD_2017-02-10_12-36-03.mat');

% COD14 = load('/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/2017-03-14/13-31-10/sort_full_COD_2017-03-14_13-31-09.mat');
%COD14 = load('/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/2017-04-26/18-16-34/sort_full_COD_2017-04-26_18-16-33.mat');
%COD14 = load('/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/2017-04-30/20-48-35/sort_full_COD_2017-04-30_20-48-35.mat');
%COD14 = load('/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/2017-04-28/13-50-51/sort_full_COD_2017-04-28_13-50-50.mat');

COD14 = load('/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/2017-04-30/20-48-35/sort_full_COD_2017-04-30_20-48-35.mat'); % 8DIP wo the worse 5000 perm
method = 'COD'; 
%%
% 
bestCODt= cell2mat(COD14.bestCOD);
bestCODtt = mat2str(bestCODt);
bestCOD = str2num(bestCODtt);
[bestCODmax, bestit] = min(bestCOD);

bestit = 14;

worseCODt= cell2mat(COD14.worseCOD); 
worseCODtt = mat2str(worseCODt); 
worseCOD = str2num(worseCODtt);
[worseCODmax, worseit] = max(worseCOD);

worseit = 446;

Npermmax = length(COD14.bestCOD);
Nperm = 1:Npermmax;

figure(10)
set(gca,'FontSize',18)
plot(Nperm, 1e3.*bestCOD,'.-r', 'Markersize',10)
hold on
plot(Nperm,  1e3.*worseCOD,'.-b', 'Markersize',10)
hold off
xlabel('Permutations')
ylabel('X max [mm]');
%ylabel('Courant-Snyder invariant');
u = legend({'Best','Worse'});
set(u,'Location','NorthEast')
title('Dipole sorting for the ThomX SR')
title(['Dipole sorting: ' ' Best ' num2str(bestit) ' with Xmax ' num2str(round(1000*bestCODmax,3)) ' mm ' ' Worse ' ...
    num2str(worseit) ' with Xmax ' num2str(round(1000*worseCODmax,3)) ' mm'] );
% title(['Dipole sorting: ' ' Best ' num2str(bestit) ' with Wmax ' num2str(round2(1000*bestCODrms,0.001)) ' ' ' Worse ' ...
%     num2str(worseit) ' with Wmax ' num2str(round2(1000*worseCODrms,0.001)) ''] );
set(gcf, 'color', 'w');
%export_fig([dir_to_saveFigs 'resSA_permutations' method '_14dip.pdf'])
%print([dir_to_saveFigs 'resSA_permutations' method '_13dip.png'],'-dpng','-r300')
%%

flag_plot = 0;

bestdBB0 = COD14.bestdBB0{bestit};
worsedBB0 = COD14.worsedBB0{worseit};

% bestind200A = COD14.bestperm{bestit};
% worseind200A = COD14.worseperm{worseit};
% load dBB0_worseRemoved.mat
% TDR_017_064_r56_02_sx_Dff412_DipMagnL_chro00
% 
% worsedBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), worseind200A ));
% 
% bestdBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), bestind200A ));


[Xbest, Xprimebest, Wbest, Sbest] = plotsorting(bestdBB0, method, 'best', flag_plot);
[Xworse, Xprimeworse, Wworse, Sworse] = plotsorting(worsedBB0, method, 'worse', flag_plot);


%%

figure(11)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',18)
plot(Sbest, 1e3*Xbest,'.-r', 'Markersize',10)
hold on
plot(Sworse, 1e3*Xworse,'.-b', 'Markersize',10)
hold off
xlim([0 Sbest(end)]);
%ylim([-1.2 1.2]);
xlabel('Position [m]')
ylabel('X [mm]');

title(['SR Horizontal Orbit ' method ': X rms  = ' num2str(round(1000*std(Xbest),3)) ' / ' num2str(round(1000*std(Xworse),3)) ' mm ' ' X max = ' ...
    num2str(round(1000*max(abs(Xbest)),3)) ' / ' num2str(round(1000*max(abs(Xworse)),3)) ' mm']);

text(0.1, max(1e3*Xworse)-1 ,['Best: [ ' num2str(COD14.bestperm{bestit}) ' ]'],'FontSize',12);
text(0.1, max(1e3*Xworse)-4 ,['Worse: [ ' num2str(COD14.worseperm{worseit}) ' ]'],'FontSize',12);
text(0.1, -max(1e3*Xworse)+6 ,['dBB0/1e3: ' num2str(round(1000*COD14.dBB0init,3),'%1.1f ')],'FontSize',12);
text(0.1, -max(1e3*Xworse)+4 ,['DIP#: [ ' num2str(COD14.dipINDinit) ' ]'],'FontSize',12);


% text(0.1, 0.9 ,['Best: [ ' num2str(COD14.bestperm{bestit}) ' ]'],'FontSize',12);
% text(0.1, 0.78 ,['Worse: [ ' num2str(COD14.worseperm{worseit}) ' ]'],'FontSize',12);
% text(0.1, -0.9 ,['dBB0/1e4: ' num2str(round2(1e4*COD14.dBB0init,0.01),'%1.1f ')],'FontSize',12);
u = legend({'Best','Worse'});
set(u,'Location','NorthEast')
    

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
%export_fig([dir_to_saveFigs 'resSA_' method '_14dip.pdf'])
%print([dir_to_saveFigs 'resSA_' method '_8dip_anal_200A.png'],'-dpng','-r300')
%% test with dBB @ 159 A

bestind200A = COD14.bestperm{bestit};
worseind200A = COD14.worseperm{worseit};

%% Check with AT

global THERING
BENDI = findcells(THERING,'FamName','BEND');

%%
%worsedBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), worseind200A ));
dBB = worsedBB0;

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = dBB(i);
        
end

[spos, orbitww] = get_orbit;  

% std(orbit(1,:)*1e3)
%%

%bestdBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), bestind200A ));
dBB = bestdBB0;

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = dBB(i);
        
end

[spos, orbitbb] = get_orbit;  

%% COD
figure(12)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(Sbest, 1e3*Xbest,'.-r', 'Markersize',10)
hold on
plot(Sworse, 1e3*Xworse,'.-b', 'Markersize',10)
plot(spos,orbitbb(1,:)*1e3,'-k', 'Markersize',11);
plot(spos,orbitww(1,:)*1e3,'-k', 'Markersize',11);
hold off
xlim([0 spos(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
u = legend({'Best (anal)','Worse (anal)','Best AT','Worse AT'});
set(u,'Location','SouthEast')
title('AT vs analytical formulae comparison')

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
%export_fig([dir_to_saveFigs 'resSA_COD_AT_anal_14dip.pdf'])
%print([dir_to_saveFigs 'resSA_COD_AT_anal_8dip_200A.png'],'-dpng','-r300')

%% test with dBB @ 200 A

% figure(13)
% h1 = subplot(3,1,[1 2]);
% set(gca,'FontSize',14)
% plot(spos,orbitbb(1,:)*1e3,'.-r', 'Markersize',10)
% hold on
% plot(spos,orbitww(1,:)*1e3,'.-b', 'Markersize',11);
% hold off
% xlim([0 spos(end)]);
% xlabel('Position [m]')
% ylabel('X [mm]');
% u = legend({'Best','Worse'});
% set(u,'Location','SouthEast')
% title(['SR Horizontal Orbit ' method ': X rms  = ' num2str(round(1000*std(orbitbb(1,:)),3)) ' / ' num2str(round(1000*std(orbitww(1,:)),3)) ' mm ' ' X max = ' ...
%     num2str(round(1000*max(abs(orbitbb(1,:))),3)) ' / ' num2str(round(1000*max(abs(orbitww(1,:))),3)) ' mm']);
% text(0.1, max(1e3*Xworse)-5 ,['Best: [ ' num2str(COD14.bestperm{bestit}) ' ]'],'FontSize',12);
% text(0.1, max(1e3*Xworse)-8 ,['Worse: [ ' num2str(COD14.worseperm{worseit}) ' ]'],'FontSize',12);
% text(0.1, -max(1e3*Xworse)+6 ,['dBB0/1e3: ' num2str(round(1000*COD14.dBB0init,3),'%1.1f ')],'FontSize',12);
% text(0.1, -max(1e3*Xworse)+4 ,['DIP#: [ ' num2str(COD14.dipINDinit) ' ]'],'FontSize',12);
% 
% 
% h2 = subplot(3,1,3);
% drawlattice 
% set(h2,'YTick',[])
% 
% linkaxes([h1 h2],'x')
% set([h1 h2],'XGrid','On','YGrid','On');
% set(gcf, 'color', 'w');
% %export_fig([dir_to_saveFigs 'resSA_COD_AT_anal_14dip.pdf'])
% print([dir_to_saveFigs 'resSA_COD_AT_8dip200_to_nom.png'],'-dpng','-r300')



