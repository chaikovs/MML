function chamber = tracy_chamber(varargin)
% Plot vaccum chamber produced by Tracy code
%
%  INPUTS:
%  Optionnal
%  TracyVersion : tracy2 or tracy3 format
%  Display/noDisplay
%
%  OUTPUTS:
%  1. chamber - Tracy chamber information



DisplayFlag = 1;
TracyVersion = 'tracy2';
xmax = getcircumference/4;
% lecture du fichier de structure
fileName = fullfile(getmmlroot, 'machine/SOLEIL/common/naff/naffutils/structure');

for k = length(varargin):-1:1,
    if strcmpi(varargin{k}, 'tracy3')
        TracyVersion = 'tracy3';
        varargin(k) = [];
    elseif strcmpi(varargin{k}, 'tracy2')
        TracyVersion = 'tracy2';
        varargin(k) = [];
    elseif strcmpi(varargin{k}, 'NoDisplay')
        DisplayFlag = 0;
        varargin(k) = [];
    elseif strcmpi(varargin{k}, 'Display')
        DisplayFlag = 1;
        varargin(k) = [];
    elseif strcmpi(varargin{k}, 'full')
        xmax = getcircumference;
        % lecture du fichier de structure
        fileName = fullfile(getmmlroot, 'machine/SOLEIL/common/naff/naffutils/structure_nanoscopium');
    else
        warning('Unknown option');
    end
end

try
    struc=dlmread(fileName);
catch errRecord
    error('Error while opening file %s',fileName)
end

%% Lecture du fichier de la chambre
file0 = 'chambre.out';

try
    if strcmpi(TracyVersion, 'tracy2')
        % Tracy 2
        [num dummy s mhch phch pvch] = textread(file0,'%d %s %f %f %f %f','headerlines',3);
        chamber.slocation = s;
        chamber.hplane = [mhch, phch];
        chamber.vplane = [-pvch, pvch];

    else
        % Tracy 3
        [num dummy s mhch phch mvch pvch] = textread(file0,'%d %s %f %f %f %f %f','headerlines',3);
        chamber.slocation = s;
        chamber.hplane = [mhch, phch];
        chamber.vplane = [mvch, pvch];
    end
catch
    error('Error while opening file %s',file0)
end

if (DisplayFlag)
    figure(42)
    clf
    h(1) = subplot(2,1,1);
    plot(s,phch,'k-');
    hold on
    plot(s,mhch,'k-');
    plot(struc(:,1),struc(:,2)/2*0.3*max(phch),'k-');
    axis([0 xmax 1.1*min(mhch) 1.1*max(phch)]);
    grid on
    xlabel('s (m)')
    ylabel('x (mm)')
    title('Vacuum pipe dimensions')
    
    h(2) = subplot(2,1,2);
    plot(s,pvch,'k-');
    hold on
    plot(struc(:,1),struc(:,2)/2*0.3*max(pvch),'k-')
    plot(s,mvch,'k-');
    axis([0 xmax -1.1*max(pvch) 1.1*max(pvch)]);
    grid on
    xlabel('s (m)')
    ylabel('z (mm)')
    
    linkaxes(h, 'x');
    addlabel(0,0,datestr(now));    
end

