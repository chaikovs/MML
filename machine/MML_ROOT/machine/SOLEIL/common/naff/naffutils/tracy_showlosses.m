function tracy_showlosses(lossFileName)
% tracy_showlosses  - give distribution of losses around the ring
% 
%  INPUTS
%  1. lossFileName - filename name generating by Tracy
%
%  See also 
%  tracy_plot_famp

%
%% Written by Laurent S. Nadolski

if exist(lossFileName, 'file'),
    try
        [header dataLoss] = hdrload(lossFileName);
    catch errReccord
        error('Error while opening filename %s ',lossFileName)
    end
end

chamber = tracy_chamber('Nodisplay','tracy3');

iHplane = find(dataLoss(:,4)==1);
iVplane = find(dataLoss(:,4)==2);
figure('Position', [1 1 560 660]); clf;
h(1) = subplot(3,1,1);
hist(dataLoss(iHplane,5),0:354); hold on;
hist(dataLoss(iVplane,5),0:354); 
 
hobj = findobj(gca,'Type','patch');
display(hobj);
 
set(hobj(1),'FaceColor',[255 200 0]/255,'EdgeColor','k');
set(hobj(2),'FaceColor','c','EdgeColor','k');
title('Particle loss location')
legend({'Horizontal plane', 'Vertical plane'});
ylabel('Lost particule (a.u.)');

h(2) = subplot(3,1,2);
plot(chamber.slocation, chamber.hplane(:,1), 'k'); hold on;
plot(chamber.slocation, chamber.hplane(:,2), 'k');
drawlattice(0,10)
ylabel('H-vac. chamber (mm)');

h(3) = subplot(3,1,3);
plot(chamber.slocation, chamber.vplane(:,1), 'k'); hold on;
plot(chamber.slocation, chamber.vplane(:,2), 'k');
drawlattice(0,5)
linkaxes(h,'x')
xlabel('s-location (m)')
ylabel('V-vac. chamber (mm)');

linkaxes(h,'x')
xlim([0 getcircumference])
xlabel('s-location (m)')
xlim([0 getcircumference])

pwd0 = pwd;
[~, DirName] = fileparts (pwd0);
addlabel(0,0, fullfile(DirName, lossFileName));

%% pie chart with loss distribution
figure;

iStable = dataLoss(:,4)==0;
iHplane = dataLoss(:,4)==1;
iVplane = dataLoss(:,4)==2;
iLplane = dataLoss(:,4)==3;

chart = [sum(iStable) sum(iHplane) sum(iVplane) sum(iLplane)]+1;

explode = [1,1,1,1];

pie(chart, explode);
suptitle('Loss particule distribution')
legend({'Stable', 'Horizontal', 'Vertical', 'Longitudinal'}, 'Location', 'NorthEastOutside')
addlabel(0,0, fullfile(DirName, lossFileName));


%% Plot losses on FMA, turn number
if strfind(header(4,:), 'dpi')
    FmapdpFlag = 1;
else
    FmapdpFlag = 0;
end

if FmapdpFlag
    x1 = dataLoss(:,1)*1e3;  % H-amplitude
    z1 = dataLoss(:,2)*1e2; % dp
    nz1 = sum(z1==z1(1));
    nx1 = size(z1,1)/nz1;
    
    % Make the grids
    xgrid1 = reshape(x1,nx1,nz1);
    zgrid1 = reshape(z1,nx1,nz1);
    LossGrid = reshape(dataLoss(:,4),nx1,nz1);
    LossTurnGrid = reshape(dataLoss(:,3),nx1,nz1);

else % Standard FMAP
    x1 = dataLoss(:,1)*1e3;
    z1 = dataLoss(:,2)*1e3;
    
    nz1 = sum(x1==x1(1));
    nx1 = size(x1,1)/nz1;    
    
    % Make the grids
    xgrid1 = reshape(x1,nz1,nx1);
    zgrid1 = reshape(z1,nz1,nx1);
    LossGrid = reshape(dataLoss(:,4),nz1,nx1);
    LossTurnGrid = reshape(dataLoss(:,3),nz1,nx1);
end


% Plot data
figure

if FmapdpFlag
    pcolor(xgrid1,zgrid1,LossGrid); hold on;
    xlabel('Energy offset (%)'); ylabel('Horizontal amplitude (mm)');    
else
    pcolor(xgrid1,zgrid1,LossGrid); hold on;
    xlabel('Horizontal amplitude (mm)'); ylabel('Vertical amplitude (mm)');    
end
shading flat
colorbar
caxis([0 3]); % Echelle absolue
shading flat;
title('Loss plane')
addlabel(0,0, fullfile(DirName, lossFileName));

figure
if FmapdpFlag
    pcolor(xgrid1,zgrid1,LossTurnGrid); hold on;
    xlabel('Energy offset (%)'); ylabel('Horizontal amplitude (mm)');    
else
    pcolor(xgrid1,zgrid1,LossTurnGrid); hold on;
    xlabel('Horizontal amplitude (mm)'); ylabel('Vertical amplitude (mm)');    
end
shading flat
colorbar
xlabel('Horizontal amplitude (mm)'); ylabel('Vertical amplitude (mm)');
title('Turn number when particle is lost') 
addlabel(0,0, fullfile(DirName, lossFileName));
