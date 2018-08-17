clear all
close all

% load lattice
% load lattice
ring = thomx_at2_GirderMarkerBPM();

% get indexes
%indm=find(atgetcells(ring,'FamName','BPMx'));

% get indexes
indq=find(atgetcells(ring,'Class','Quadrupole'));

% get indexes
indm=find(atgetcells(ring,'Class','Monitor'));
indg=find(atgetcells(ring,'FamName','GS')); % girders are defined by GS and GE markers (start and end of girder)

rerr=atsetrandomerrors(...
    ring,...
    indg,...
    indm,...
    1,...
    1e-5,...
    2.5,...
    'gpsi');

figure('units','normalized','position',[0.1 0.4 0.65 0.35])
atplot(rerr,[0,100],'comment',[],@pltmisalignments);
saveas(gca,'GirderErrorsRoll.fig')
export_fig('GirderErrorsRoll.jpg','-r300')



rerr=atsetrandomerrors(...
    ring,...
    indg,...
    indm,...
    1,...
    1e-5,...
    2.5,...
    'gx.gy');

figure('units','normalized','position',[0.1 0.4 0.65 0.35])
atplot(rerr,[0,100],'comment',[],@pltmisalignments);
saveas(gca,'GirderErrorsXY.fig')
export_fig('GirderErrorsXY.jpg','-r300')



rerr=atsetrandomerrors(...
    ring,...
    indg,...
    indm,...
    1,...
    1e-5,...
    2.5,...
    'gx.gy.gpsi');

figure('units','normalized','position',[0.1 0.4 0.65 0.35])
atplot(rerr,[0,100],'comment',[],@pltmisalignments);
saveas(gca,'GirderErrorsXYRoll.fig')
export_fig('GirderErrorsXYRoll.jpg','-r300')

%%
rerr=atsetrandomerrors(...
    ring,...
    indg,...
    indm,...
    1,...
    1e-5,...
    2.5,...
    'gtheta');

figure('units','normalized','position',[0.1 0.4 0.65 0.35])
atplot(rerr,[0,100],'comment',[],@pltmisalignments);
saveas(gca,'GirderErrorsYaw.fig')
export_fig('GirderErrorsYaw.jpg','-r300')


rerr=atsetrandomerrors(...
    ring,...
    indg,...
    indm,...
    1,...
    1e-5,...
    2.5,...
    'gphi');

figure('units','normalized','position',[0.1 0.4 0.65 0.35])
atplot(rerr,[0,100],'comment',[],@pltmisalignments);
saveas(gca,'GirderErrorsPitch.fig')
export_fig('GirderErrorsPitch.jpg','-r300')


