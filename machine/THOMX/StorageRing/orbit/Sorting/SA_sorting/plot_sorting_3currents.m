
%%

dir_to_saveFigs = '/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/Figs/';

COD14 = load('/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/2017-04-30/20-48-35/sort_full_COD_2017-04-30_20-48-35.mat'); % 8DIP wo the worse 5000 perm
%COD14 = load('/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/2017-04-27/19-08-23/sort_full_COD_2017-04-27_19-08-23.mat'); % 8DIP 5000 perm

method = 'COD';

%%

% 8DIP wo the worse: 31(93)/90
% 8DIP :  2994(3127)/4942(40,295,3120 )
% 8DIP wo the worse 5000 : 14(126 1888) / 446 (2064  4823)

bestit = 14; %

worseit = 446;

%%

bestind200A = COD14.bestperm{bestit};
worseind200A = COD14.worseperm{worseit};


%% Check with AT @ 159 A

load dBB0_worseRemoved.mat
TDR_017_064_r56_02_sx_Dff412_DipMagnL_chro00
%global THERING
BENDI = findcells(THERING,'FamName','BEND');

%%
worsedBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), worseind200A ));
dBB = worsedBB0;

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = dBB(i);
        
end

[spos, orbitww] = get_orbit;  

% std(orbit(1,:)*1e3)
%%

bestdBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), bestind200A ));
dBB = bestdBB0;

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = dBB(i);
        
end

[spos, orbitbb] = get_orbit;  

%% Plot for proceeding

figure(13)
%h1 = subplot(3,1,[1 2]);
plot(spos,orbitbb(1,:)*1e3,'.-r', 'Markersize',10)
hold on
plot(spos,orbitww(1,:)*1e3,'d-b', 'Markersize',5);
hold off
xlim([0 spos(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
u = legend({'Best','Worse'});
set(u,'Location','NorthEast')
title(['Horizontal Orbit: X_{rms}  = ' num2str(round(1000*std(orbitbb(1,:)),3)) '/' num2str(round(1000*std(orbitww(1,:)),3)) ' mm ' ' X_{max} = ' ...
    num2str(round(1000*max(abs(orbitbb(1,:))),3)) '/' num2str(round(1000*max(abs(orbitww(1,:))),3)) ' mm']);
text(0.1, max(1e3*orbitbb(1,:))-5 ,['Best: [ ' num2str(COD14.bestperm{bestit}) ' ]'],'FontSize',12);
text(0.1, max(1e3*orbitbb(1,:))-8 ,['Worse: [ ' num2str(COD14.worseperm{worseit}) ' ]'],'FontSize',12);
text(0.1, -max(1e3*orbitbb(1,:))+9 ,['dBB0/1e3: ' num2str(round(1000*dBB0,3),'%1.1f ')],'FontSize',12);
text(0.1, -max(1e3*orbitbb(1,:))+5 ,['DIP#: [ ' num2str(dipND) ' ]'],'FontSize',12);


%h2 = subplot(3,1,3);
% drawlattice 
% set(h2,'YTick',[])
% 
% linkaxes([h1 h2],'x')
% set([h1 h2],'XGrid','On','YGrid','On');
set(gca,'FontSize',16)
set(gcf, 'color', 'w');
%export_fig([dir_to_saveFigs 'resSA_COD_AT_anal_14dip.pdf'])
print([dir_to_saveFigs 'resSA_COD_AT_8dipwoWorse5000_at159A_proceeding.png'],'-dpng','-r300')

%% 

figure(13)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(spos,orbitbb(1,:)*1e3,'.-r', 'Markersize',10)
hold on
plot(spos,orbitww(1,:)*1e3,'.-b', 'Markersize',11);
hold off
xlim([0 spos(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
u = legend({'Best','Worse'});
set(u,'Location','SouthEast')
title(['SR Horizontal Orbit ' method ': X rms  = ' num2str(round(1000*std(orbitbb(1,:)),3)) ' / ' num2str(round(1000*std(orbitww(1,:)),3)) ' mm ' ' X max = ' ...
    num2str(round(1000*max(abs(orbitbb(1,:))),3)) ' / ' num2str(round(1000*max(abs(orbitww(1,:))),3)) ' mm']);
text(0.1, max(1e3*orbitbb(1,:))-5 ,['Best: [ ' num2str(COD14.bestperm{bestit}) ' ]'],'FontSize',12);
text(0.1, max(1e3*orbitbb(1,:))-8 ,['Worse: [ ' num2str(COD14.worseperm{worseit}) ' ]'],'FontSize',12);
text(0.1, -max(1e3*orbitbb(1,:))+9 ,['dBB0/1e3: ' num2str(round(1000*dBB0,3),'%1.1f ')],'FontSize',12);
text(0.1, -max(1e3*orbitbb(1,:))+5 ,['DIP#: [ ' num2str(dipND) ' ]'],'FontSize',12);


h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
%export_fig([dir_to_saveFigs 'resSA_COD_AT_anal_14dip.pdf'])
%print([dir_to_saveFigs 'resSA_COD_AT_8dipwoWorse5000_at159A.png'],'-dpng','-r300')


%% Check with AT @ 256 A

load dBB256A_worseRemoved.mat

TDR_017_064_r56_02_sx_Dff412_DipMagnL_chro00
%global THERING
BENDI = findcells(THERING,'FamName','BEND');

%%
worsedBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), worseind200A ));
dBB = worsedBB0;

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = dBB(i);
        
end

[spos, orbitww] = get_orbit;  

% std(orbit(1,:)*1e3)
%%

bestdBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), bestind200A ));
dBB = bestdBB0;

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = dBB(i);
        
end

[spos, orbitbb] = get_orbit;  



%% 

figure(13)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(spos,orbitbb(1,:)*1e3,'.-r', 'Markersize',10)
hold on
plot(spos,orbitww(1,:)*1e3,'.-b', 'Markersize',11);
hold off
xlim([0 spos(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
u = legend({'Best','Worse'});
set(u,'Location','SouthEast')
title(['SR Horizontal Orbit ' method ': X rms  = ' num2str(round(1000*std(orbitbb(1,:)),3)) ' / ' num2str(round(1000*std(orbitww(1,:)),3)) ' mm ' ' X max = ' ...
    num2str(round(1000*max(abs(orbitbb(1,:))),3)) ' / ' num2str(round(1000*max(abs(orbitww(1,:))),3)) ' mm']);
text(0.1, max(1e3*orbitbb(1,:))-5 ,['Best: [ ' num2str(COD14.bestperm{bestit}) ' ]'],'FontSize',12);
text(0.1, max(1e3*orbitbb(1,:))-10 ,['Worse: [ ' num2str(COD14.worseperm{worseit}) ' ]'],'FontSize',12);
text(0.1, -max(1e3*orbitbb(1,:))+14 ,['dBB0/1e3: ' num2str(round(1000*dBB0,3),'%1.1f ')],'FontSize',12);
text(0.1, -max(1e3*orbitbb(1,:))+8 ,['DIP#: [ ' num2str(dipND) ' ]'],'FontSize',12);


h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
%export_fig([dir_to_saveFigs 'resSA_COD_AT_anal_14dip.pdf'])
%print([dir_to_saveFigs 'resSA_COD_AT_8dipwoWorse5000_at256A.png'],'-dpng','-r300')


%% Check with AT @ 200 A

%load dBB200A.mat

TDR_017_064_r56_02_sx_Dff412_DipMagnL_chro00
%global THERING
BENDI = findcells(THERING,'FamName','BEND');

%%
% worsedBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), worseind200A ));
% dBB = worsedBB0;

bestdBB0 = COD14.bestdBB0{bestit};
worsedBB0 = COD14.worsedBB0{worseit};

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = worsedBB0(i);
        
end

[spos, orbitww] = get_orbit;  

% std(orbit(1,:)*1e3)
%%

% bestdBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), bestind200A ));
% dBB = bestdBB0;

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = bestdBB0(i);
        
end

[spos, orbitbb] = get_orbit;  



%% 

figure(13)
h1 = subplot(3,1,[1 2]);
set(gca,'FontSize',14)
plot(spos,orbitbb(1,:)*1e3,'.-r', 'Markersize',10)
hold on
plot(spos,orbitww(1,:)*1e3,'.-b', 'Markersize',11);
hold off
xlim([0 spos(end)]);
xlabel('Position [m]')
ylabel('X [mm]');
u = legend({'Best','Worse'});
set(u,'Location','SouthEast')
title(['SR Horizontal Orbit ' method ': X rms  = ' num2str(round(1000*std(orbitbb(1,:)),3)) ' / ' num2str(round(1000*std(orbitww(1,:)),3)) ' mm ' ' X max = ' ...
    num2str(round(1000*max(abs(orbitbb(1,:))),3)) ' / ' num2str(round(1000*max(abs(orbitww(1,:))),3)) ' mm']);
text(0.1, max(1e3*orbitbb(1,:))-5 ,['Best: [ ' num2str(COD14.bestperm{bestit}) ' ]'],'FontSize',12);
text(0.1, max(1e3*orbitbb(1,:))-8 ,['Worse: [ ' num2str(COD14.worseperm{worseit}) ' ]'],'FontSize',12);
text(0.1, -max(1e3*orbitbb(1,:))+9 ,['dBB0/1e3: ' num2str(round(1000*dBB0,3),'%1.1f ')],'FontSize',12);
text(0.1, -max(1e3*orbitbb(1,:))+5 ,['DIP#: [ ' num2str(dipND) ' ]'],'FontSize',12);


h2 = subplot(3,1,3);
drawlattice 
set(h2,'YTick',[])

linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
set(gcf, 'color', 'w');
%export_fig([dir_to_saveFigs 'resSA_COD_AT_anal_14dip.pdf'])
%print([dir_to_saveFigs 'resSA_COD_AT_8dipwoWorse5000_at200A.png'],'-dpng','-r300')




