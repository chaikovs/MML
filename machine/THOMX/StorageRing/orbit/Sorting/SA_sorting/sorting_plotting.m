
%%
dir_to_saveFigs = '/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/machine/THOMX/StorageRing/orbit/Sorting/SA_TSP_Rev1/SA_sorting/Figs/'


%%

figure(32)
set(gcf, 'color', 'w');
export_fig([dir_to_saveFigs 'cost_function_8dip.pdf'])

%%

figure(5)
set(gca,'FontSize',14)
hist(dBB0,5)
xlabel('RMS error of the integrated dipole field')
set(gcf, 'color', 'w');
export_fig([dir_to_saveFigs 'dipole_field_dist_init.pdf'])

%%

figure(1)
set(gcf, 'color', 'w');
%export_fig([dir_to_save 'SA_CFW_8dip.jpeg'])
%fname = [dir_to_saveFigs 'SA_CSI_8dip.png'];
fname = [dir_to_saveFigs 'SA_COD_8dip.png'];
 print('-dpng',fname,'-r100');

%%
CSI = load('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/machine/THOMX/StorageRing/orbit/Sorting/SA_TSP_Rev1/SA_sorting/SORTING/2015-06-18/16-49-54/sort_CSI_2015-06-18_16-49-54.mat');
COD = load('/Users/ichaikov/Documents/MATLAB/SVN/mml_thomx/MML/machine/THOMX/StorageRing/orbit/Sorting/SA_TSP_Rev1/SA_sorting/SORTING/2015-06-18/18-26-20/sort_COD_2015-06-18_18-26-19.mat');


%%
method = 'COD';

figure(7)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(COD.Sorting.bestsposition, 1e3*COD.Sorting.bestorbit,'.-r', 'Markersize',10)
hold on
plot(COD.Sorting.worsesposition, 1e3*COD.Sorting.worseorbit,'.-b', 'Markersize',10)
hold off
xlim([0 COD.Sorting.bestsposition(end)]);
xlabel('Position [m]')
ylabel('X [mm]');

title(['SR Horizontal Orbit: ' ' X rms  = ' num2str(round2(1000*std(COD.Sorting.bestorbit),0.001)) ' / ' num2str(round2(1000*std(COD.Sorting.worseorbit),0.001)) ' mm ' ' X max = ' ...
    num2str(round2(1000*max(abs(COD.Sorting.bestorbit)),0.001)) ' / ' num2str(round2(1000*max(abs(COD.Sorting.worseorbit)),0.001)) ' mm'] );

text(0.1, 1.4 ,['Best: [ ' num2str(COD.Sorting.bestperm) ' ]'],'FontSize',12);
text(7., 1.4 ,['Worse: [ ' num2str(COD.Sorting.worseperm) ' ]'],'FontSize',12);
text(0.1, -1.4 ,['dBB0/1e4: ' num2str(round2(1e4*COD.Sorting.dBB0,0.01))],'FontSize',11);
u = legend({'Best','Worse'});
set(u,'Location','NorthEast')


h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
export_fig([dir_to_saveFigs 'resSA_' method '_8dip.pdf'])

%%
method = 'CSI';

figure(8)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(CSI.Sorting.bestsposition, 1e3*CSI.Sorting.bestorbit,'.-r', 'Markersize',10)
hold on
plot(CSI.Sorting.worsesposition, 1e3*CSI.Sorting.worseorbit,'.-b', 'Markersize',10)
hold off
xlim([0 CSI.Sorting.bestsposition(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
title(['SR Horizontal Orbit: ' ' X rms  = ' num2str(round2(1000*std(CSI.Sorting.bestorbit),0.001)) ' / ' num2str(round2(1000*std(CSI.Sorting.worseorbit),0.001)) ' mm ' ' X max = ' ...
    num2str(round2(1000*max(abs(CSI.Sorting.bestorbit)),0.001)) ' / ' num2str(round2(1000*max(abs(CSI.Sorting.worseorbit)),0.001)) ' mm'] );


text(0.1, 1.4 ,['Best: [ ' num2str(CSI.Sorting.bestperm) ' ]'],'FontSize',12);
text(7., 1.4 ,['Worse: [ ' num2str(CSI.Sorting.worseperm) ' ]'],'FontSize',12);
text(0.1, 1.2 ,['dBB0/1e4: ' num2str(round2(1e4*CSI.Sorting.dBB0,0.01))],'FontSize',11);
u = legend({'Best','Worse'});
set(u,'Location','SouthEast')


h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])
%set(h2,'XTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
export_fig([dir_to_saveFigs 'resSA_' method '_8dip.pdf'])


%% Check with AT

global THERING
BENDI = findcells(THERING,'FamName','BEND');

%%
dBB = COD.Sorting.worsedBB0;

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = dBB(i);
        
end

[spos, orbitww] = get_orbit;  

% std(orbit(1,:)*1e3)
%%
dBB = COD.Sorting.bestdBB0;

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = dBB(i);
        
end

[spos, orbitbb] = get_orbit;  

%% COD
figure
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(COD.Sorting.bestsposition, 1e3*COD.Sorting.bestorbit,'.-r', 'Markersize',10)
hold on
plot(COD.Sorting.worsesposition, 1e3*COD.Sorting.worseorbit,'.-b', 'Markersize',10)
plot(spos,orbitbb(1,:)*1e3,'-k', 'Markersize',11);
plot(spos,orbitww(1,:)*1e3,'-k', 'Markersize',11);
hold off
xlim([0 spos(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
u = legend({'Best','Worse','Best AT','Worse AT'});
set(u,'Location','SouthEast')
title('AT vs analytical formulae comparison')

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
export_fig([dir_to_saveFigs 'resSA_COD_AT_anal_8dip.pdf'])

%% CSI

figure
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(CSI.Sorting.bestsposition, 1e3*CSI.Sorting.bestorbit,'.-r', 'Markersize',10)
hold on
plot(CSI.Sorting.worsesposition, 1e3*CSI.Sorting.worseorbit,'.-b', 'Markersize',10)
plot(spos,orbitbb(1,:)*1e3,'-k', 'Markersize',10);
plot(spos,orbitww(1,:)*1e3,'-k', 'Markersize',10);
hold off
xlim([0 spos(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
u = legend({'Best','Worse','Best AT','Worse AT'});
set(u,'Location','NorthEast')
title('AT vs analytical formulae comparison')

h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
export_fig([dir_to_saveFigs 'resSA_CSI_AT_anal_8dip.pdf'])

