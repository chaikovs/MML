function tracy_plot_fmap(varargin)
%  PLOT_FMAP - Plots frequency map
%  plot_fmap('fmap.out')
%
%  INPUTS
%  1. file - filename for plotting frequency maps (output file from Tracy
%  II)
%
%  See also naffgui, plot_fmapdp

% Written by Laurent S. Nadolski, SOLEIL, 03/04
% Modifications for R14 compatibility, June'05

%% grille par defaut
set(0,'DefaultAxesXgrid','on');
set(0,'DefaultAxesZgrid','on');

FullMapFlag = 0;
LossFlag = 0;

% Get input flags
for i = length(varargin):-1:1
    if ischar(varargin{i})
        if strcmpi(varargin{i},'FullMap')
            FullMapFlag = 1;
            varargin(i) = [];
        elseif strcmpi(varargin{i},'Loss')
            LossFlag = 1;
            varargin(i) = [];
        end
    end
end

if  isempty(varargin),    
    help (mfilename)
    fileName ='fmapn.out';
else
    fileName = varargin{1};
end



try
    [header1 data1] = hdrload(fileName);
catch errReccord
    error('Error while opening filename %s ',fileName)
end

lossFileName = [fileName,'.loss'];

if ~exist(lossFileName, 'file'),
    LossFlag = 0;
end

%% look for other file
if FullMapFlag & exist([fileName(1:end-5), 'n.out'], 'file') & ...
        exist([fileName(1:end-5), 'p.out'], 'file')
    if strcmpi(fileName, [fileName(1:end-5), 'n.out']),
        fileName = [fileName(1:end-5), 'p.out'];
    else
        fileName = [fileName(1:end-5), 'n.out'];
    end
    
    try
        [header2 data2] = hdrload(fileName);
    catch errReccord
        error('Error while opening filename %s ',fileName)
    end
    
    lossFileName = [fileName,'.loss'];
    
    if ~exist(lossFileName, 'file'),
        LossFlag = 0;
    end    
else
   FullMapFlag = 0;
end

%% dimensions en mm
x1 = data1(:,1)*1e3;
z1 = data1(:,2)*1e3;

%% Add integer part
nuxInteger = 18;
nuzInteger = 10;

fx1 = nuxInteger + abs(data1(:,3));
fz1 = nuzInteger + abs(data1(:,4));

%% diffusion factor
if size(data1,2) == 6
    diffusion = 1;
    dfx1 = data1(:,5);
    dfz1 = data1(:,6);
else
    clear data1
    diffusion = 0;
end

% select stable particles
indx1=(fx1~=nuxInteger);

if FullMapFlag
    x2 = data2(:,1)*1e3;
    z2 = data2(:,2)*1e3;
    fx2 = nuxInteger + abs(data2(:,3));
    fz2 = nuzInteger + abs(data2(:,4));
    
    if size(data2,2) == 6
        diffusion = 1;
        dfx2 = data2(:,5);
        dfz2 = data2(:,6);
    else
        clear data2
        diffusion = 0;
    end
    indx2=(fx2~=nuxInteger);
end

%%%Black and white map
figure; 
subplot(2,1,1)
plot(fx1,fz1,'k.','MarkerSize',0.5); hold on;
% if FullMapFlag
%     plot(fx2,fz2,'k.','MarkerSize',0.5); hold on;
% end
xlabel('Horizontal tune');  ylabel('Vertical tune');
%axis([18.10 18.30 10.60 10.80])

subplot(2,1,2)
plot(x1(indx1),z1(indx1),'k.','MarkerSize',0.5); hold on
if FullMapFlag
    plot(x2(indx2),z2(indx2),'k.','MarkerSize',0.5); hold on;
end
    xlabel('Horizontal amplitude (mm)'); ylabel('Vertical amplitude (mm)');    

pwd0 = pwd;
[pathName DirName] = fileparts (pwd0);
addlabel(0,0, DirName);

% Get Matlab version
v = ver('matlab');

%% cas diffusion
if diffusion    
    figure;  clf
    xgrid1 = [];  dfxgrid1 = []; fxgrid1 = []; 
    zgrid1 = [];  dfzgrid = []; fzgrid1 = [];
    
    %% calcul automatique la taille des donnees
    nz1 = sum(x1==x1(1));
    nx1 = size(x1,1)/nz1;
    
    xgrid1 = reshape(x1,nz1,nx1);
    zgrid1 = reshape(z1,nz1,nx1);
    fxgrid1 = reshape(fx1,nz1,nx1);
    fzgrid1 = reshape(fz1,nz1,nx1);
    dfxgrid1 = reshape(dfx1,nz1,nx1);
    dfzgrid1 = reshape(dfz1,nz1,nx1);
    
    %% Diffusion computation and get rid of log of zero
    temp = sqrt(dfxgrid1.*dfxgrid1+dfzgrid1.*dfzgrid1);
    nonzero = (temp ~= 0);
    diffu1 = NaN*ones(size(temp));
    diffu1(nonzero) = log10(temp(nonzero));
    clear nonzero temp;
    diffumax = -2; diffumin = -10;
    diffu1(diffu1< diffumin) = diffumin; %very stable
    diffu1(diffu1> diffumax) = diffumax; %chaotic
    
    if FullMapFlag
        nz2 = sum(x2==x2(1));
        nx2 = size(x2,1)/nz2;
        
        xgrid2 = reshape(x2,nz2,nx2);
        zgrid2 = reshape(z2,nz2,nx2);
        fxgrid2 = reshape(fx2,nz2,nx2);
        fzgrid2 = reshape(fz2,nz2,nx2);
        dfxgrid2 = reshape(dfx2,nz2,nx2);
        dfzgrid2 = reshape(dfz2,nz2,nx2);
        
        %% Diffusion computation and get rid of log of zero
        temp = sqrt(dfxgrid2.*dfxgrid2+dfzgrid2.*dfzgrid2);
        nonzero = (temp ~= 0);
        diffu2 = NaN*ones(size(temp));
        diffu2(nonzero) = log10(temp(nonzero));
        clear nonzero temp;
        diffumax = -2; diffumin = -10;
        diffu2(diffu2< diffumin) = diffumin; %very stable
        diffu2(diffu2> diffumax) = diffumax; %chaotic
    end
    
    h1=subplot(2,1,1);
    
    if ispc
        markerSize = 1;
    else
        markerSize = 5;
    end

    %% frequency map   
    if strcmp(v.Release,'(R13SP1)')  
        h=mesh(fxgrid1,fzgrid1,diffu1,'LineStyle','.', ...
            'MarkerSize',markerSize,'FaceColor','none');
    else % For Release R14 and later
        h=mesh(fxgrid1,fzgrid1,diffu1,'Marker','.','MarkerSize',markerSize, ...
            'FaceColor','none','LineStyle','none');
        hold on;
%         if FullMapFlag
%             mesh(fxgrid2,fzgrid2,diffu1,'Marker','.','MarkerSize',markerSize, ...
%                 'FaceColor','none','LineStyle','none');
%         end
      
    end
    
    caxis([-10 -2]); % Echelle absolue
    view(2); hold on;
    %axis([18.195 18.27 10.26 10.32])
    %axis([18.195 18.22 10.28 10.32]) % modif mat oct 09 0.2 0.3
    %axis([18.15 18.22 10.28 10.36]) % modif mat oct 09 0.202 0.317
    shading flat
    xlabel('Horizontal tune');  ylabel('Vertical tune');
    %% colorbar position
    
    h2=subplot(2,1,2);
    %% dynamic aperture
    pcolor(xgrid1,zgrid1,diffu1); hold on;
    if FullMapFlag
        pcolor(xgrid2,zgrid2,diffu2);
    end
    if FullMapFlag
        xlim([-20 20])
    else
        if xgrid1(end) > 0
            xlim([0 20])
        elseif xgrid1(end) < 0
            xlim([-20 0])
        end 
    end
    
    caxis([-10 -2]); % Echelle absolue
    shading flat; 
    xlabel('Horizontal amplitude (mm)'); ylabel('Vertical amplitude (mm)');    
    
    
    %% colorbar position
    hp = colorbar('location', 'EastOutside');
    p1 = get(h1,'position'); p2 = get(h2,'position'); p0 = get(hp,'position');
    set(hp,'position',[p1(1) + 1.03*p1(3) p0(2)  0.03 p1(4)*2.4]);
    pwd0 = pwd;
    [~, DirName] = fileparts (pwd0); 
    addlabel(0,0, DirName);
end

if LossFlag
  tracy_showlosses(lossFileName);
end