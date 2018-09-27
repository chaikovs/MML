function curve = atplot(varargin)
%ATPLOT Plots optical functions
%
%ATPLOT             Plots THERING in the current axes
%
%ATPLOT(RING)       Plots the lattice specified by RING
%
%ATPLOT(AX,RING)    Plots in the axes specified by AX
%
%ATPLOT(...,[SMIN SMAX])  Zoom on the specified range
%
%CURVE=ATPLOT(...) Returns handles to some objects:
%   CURVE.BETAX    Hor. beta function line
%   CURVE.BETAZ    Vert. beta function line
%   CURVE.ETAX     Hor. dispersion line
%   CURVE.LATTICE  Element patches
%   CURVE.COMMENT  Comment text

global THERING GLOBVAL

narg=1;
% Select axes for the plot
if narg<=length(varargin) && isscalar(varargin{narg}) && ishandle(varargin{narg});
    ax=varargin{narg};
    narg=narg+1;
else
    figure;
    ax=gca;
end
% Select the lattice
if narg<=length(varargin) && iscell(varargin{narg});
    ring0=varargin{narg};
    narg=narg+1;
else
    ring0=THERING;
end
ring0 = ring0'; % LSN
[elt0,nperiods]=size(ring0);
s0=findspos(ring0,1:elt0+1);
srange=s0([1 end]);     %default plot range
el1=1;
el2=elt0+1;
for iarg=narg:nargin
    % explicit plot range
    if isnumeric(varargin{iarg}) && (numel(varargin{iarg})==2)
        srange=varargin{iarg};
        els=find(srange(1)>s0,1,'last');
        if ~isempty(els), el1=els; end
        els=find(s0>srange(2),1,'first');
        if ~isempty(els), el2=els; end
    end
end
%ring=[ring0((1:el1-1)');atslice(ring0(el1:el2-1),250);ring0((el2:elt0)')];
totlength=findspos(ring0(el1:el2-1),length(ring0(el1:el2-1))+1);
ring=[ring0(1:el1-1,1);atslice(ring0(el1:el2-1),totlength*10);ring0(el2:elt0,1)];
elt=length(ring);
plrange=el1:el2+elt-elt0;
[lindata,tunes,chrom]=atlinopt(ring,0,1:elt+1); %#ok<NASGU,ASGLU>
beta=cat(1,lindata.beta);
disp=cat(2,lindata.Dispersion)';
s=cat(1,lindata.SPos);
set(ax,'Position',[.13 .11 .775 .775]);
[ax2,h1,h2]=plotyy(ax,s(plrange),beta(plrange,:),s(plrange),disp(plrange,1));
set([h1;h2],'LineWidth',1);
set(h1(1), 'Color', [0 0 1]);
set(h1(2), 'Color', [1 0 0]);
set(h2(1), 'Color', 'k');
set(ax2(2),'XTick',[]);
curve.betax=h1(1);
curve.betaz=h1(2);
curve.etax=h2(1);
set(ax2,'XLim',srange);
set(ax2(2),'Ycolor', 'k')
curve.lattice = atplotsyn(ax2(1),ring0);  % Plot lattice elements
lts=get(ax2(1),'Children');             % Put them in the background
set(ax2(1),'Children',[lts(4:end);lts(1:3)]);
xlabel(ax2(1),'s [m]');                 % Add labels
ylabel(ax2(1),'\beta [m]');
ylabel(ax2(2),'\eta [m]');
legend([h1;h2],'\beta_x','\beta_z','\eta_x');
grid on
% axes(ax);
tuneper=lindata(end).mu/2/pi;
tunes=nperiods*tuneper;
if nperiods > 1, plural='s'; else plural=''; end
par_ = atsummary('NoDisplay');
line1=sprintf(['\\nu_x=%8.3f     \\xi_x=%8.3f    %i %s                        ' ...
    'Emittance Ex=%2.3f nm.rad     Energy=%8.3f GeV'], ...
    tunes(1),par_.chromaticity(1), nperiods,['period' plural], ...
    par_.naturalEmittance*1e9, par_.e0);
line2=sprintf(['\\nu_z=%8.3f     \\xi_z=%8.3f    C=%10.3f m' ...
    '           Bunch length=%2.3f mm'...
    '       \t    Energy spread Dp/p=%1.3e'],  ...
    tunes(2),par_.chromaticity(2), nperiods*s0(end), par_.bunchlength*1e3, ...
    par_.naturalEnergySpread);
curve.comment=text(-0.14,1.12,{line1;line2},'Units','normalized',...
    'VerticalAlignment','top', 'Interpreter', 'tex');
strVal = sprintf('Lattice: %s', GLOBVAL.LatticeFile);
%addlabel(1,0, datestr(now), 9);
addlabel(0,0, strVal, 9);
end

