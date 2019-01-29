function tracy_plot_fmapdp(varargin)
% tracy_plot_fmapdp - Plot frequency map
% plot_fmapdp('fmapdp.out')
%
%  INPUTS
%  1. file - filename for plotting frequency maps (output file from Tracy
%  II)
%
%  See also naffgui, plot_fmap, resongui

%
% Written Laurent S. Nadolski, SOLEIL, 03/04
% Modifications for R14 compatibility, June'05

LossFlag = 1;


%% grille par defaut
set(0,'DefaultAxesXgrid','on');
set(0,'DefaultAxesYgrid','on');
pwd0 = pwd;

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
    fileName ='fmapdpp.out';
else
    fileName = varargin{1};
end

try
    [dp x fx fz dfx dfz] = textread(fileName,'%f %f %f %f %f %f','headerlines',3);
catch ErrRecord
    error('Error while opening filename %s',fileName);
end

lossFileName = [fileName,'.loss'];

if ~exist(lossFileName, 'file'),
    LossFlag = 0;
end

%% ajoute parties entieres
fx=18+abs(fx);
fz=10+abs(fz);
%% energie en %
dp = dp*1e2;
%% position en mm
x = x*1e3;
            
% select stable particles
indx=(fx~=18.0);

%% carte N&B
figure; clf;
subplot(2,1,1)
plot(fx,fz,'.','MarkerSize',0.5)
xlabel('Horizontal tune');  ylabel('Vertical tune');
%axis([18.15 18.27 10.265 10.32])

subplot(2,1,2)
plot(dp(indx),x(indx),'.','MarkerSize',0.5); hold on
%ind_amplitude
xlabel('Energy offset (%)'); ylabel('Horizontal amplitude (mm)')
[pathName DirName] = fileparts (pwd0);
addlabel(0,0, DirName);

%% Carte avec diffusion
figure; clf 
dpgrid = [];
xgrid = [];
dfxgrid = [];
dfzgrid = [];
fxgrid = [];
fzgrid = [];

%% Calcul automatique de la taille des donnees
nx = sum(dp==dp(1));
ndp = size(dp,1)/nx;

xgrid = reshape(x,nx,ndp);
dpgrid = reshape(dp,nx,ndp);
fxgrid = reshape(fx,nx,ndp);
fzgrid = reshape(fz,nx,ndp);
dfxgrid = reshape(dfx,nx,ndp);
dfzgrid = reshape(dfz,nx,ndp);

%% Diffusion
temp = sqrt(dfxgrid.*dfxgrid+dfzgrid.*dfzgrid);
nonzero = (temp ~= 0);
diffu = NaN*ones(size(temp));
diffu(nonzero) = log10(temp(nonzero));
clear nonzero temp;

% diffu = log10(sqrt(dfxgrid.*dfxgrid+dfzgrid.*dfzgrid));

%% saturation
% ind = isinf(diffu); 
% diffu(ind) = NaN;
diffumax = -2; diffumin = -10;
diffu(diffu< diffumin) = diffumin; % very stable
diffu(diffu> diffumax) = diffumax; %chaotic
diffu(end)    = diffumin;
diffu(end-1) = diffumax;

%% fmap
h1=subplot(2,1,1);

% Get Matlab version
v = ver('matlab');

if ispc
    markerSize = 1;
else
    markerSize = 5;
end

if strcmp(v.Release,'(R13SP1)')
    mesh(fxgrid,fzgrid,diffu,'LineStyle','.','MarkerSize',markerSize, ...
        'FaceColor','none');
else % For Release R14 and later
    mesh(fxgrid,fzgrid,diffu,'Marker','.','LineStyle','none', ...
        'MarkerSize',markerSize,'FaceColor','none');
end

caxis([-10 -2]); % Echelle absolue
%axis([18.15 18.27 10.26 10.32])
% axis([18.195 18.27 s10.26 10.32])
set(gca,'View',[0 90]);
hold on
shading flat
%hp=colorbar('horiz');
xlabel('Horizontal tune');  ylabel('Vertical tune');


%% DA
h2=subplot(2,1,2);
%% colorbar position
% p1 = get(h1,'position'); p2 = get(h2,'position'); p0 = get(hp,'position');
% set(hp,'position',[p0(1) p1(2) - 1.2*(p1(2)-p2(2)-p2(4))/2 p0(3:4)]);
% 
 pcolor(dpgrid,xgrid,diffu); hold on
 caxis([-10 -2]); % Echelle absolue
 shading flat
xlabel('Energy offset (%)')
ylabel('Horizontal amplitude (mm)')
%axis([-6 6 0 20])
%axis([-6 6 -20 0])
% ind_amplitude
[pathName DirName] = fileparts (pwd0);
addlabel(0,0, DirName);


if LossFlag
  tracy_showlosses(lossFileName);
end