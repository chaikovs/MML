function [Tilt, Eta, Ratio, ENV, DP, DL, EPS] = calccoupling(varargin)
%CALCCOUPLING - Calculates the coupling and tilt of the AT model
%  [Eta, Tilt, EmittanceRatio, ENV, DP, DL] = calccoupling
%
%  OUTPUTS
%  1. Tilt - Tilts of the emittance ellipse [radian]
%  2. Eta - Emittance
%  3. EmittanceRatio - median(EpsX) / median(EpsX)
%  4-6. ENV, DP, DL - Output of ohmienvelope
%  7. EPS - emmittance
%
%  NOTES
%  1. If there are no outputs, the coupling information will be plotted.
%  2. It can be helpful the draw the lattice on top of a graph (hold on; drawlattice(Offset, Height);)
%
%  See Also ohmienvelope

%
%  Written by James Safranek
%  Modified by Laurent S. Nadolski

DisplayFlag = 0;

% Flag factory
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    end
end

global THERING
    
L0 = findspos(THERING, length(THERING)+1);

[PassMethod, ATIndex, FamName, PassMethodOld, ATIndexOld, FamNameOld] = setradiation('On');

CavityState = getcavity;
setcavity('On');


%% Get all the AT elements that add radiation
% bending magnets
BendCell = findmemberof('BEND');
iBend = family2atindex(BendCell);
for ii = 1:length(iBend)
    if size(iBend{ii},2) > 1
        iBend{ii} = sort(iBend{ii}(:));
        nanindx = find(isnan(iBend{ii}));
        iBend{ii}(nanindx) = [];
    end
end
iBend = cell2mat(iBend(:));

% quadrupoles
QuadCell = findmemberof('QUAD');
iQuad = family2atindex(QuadCell);
for ii = 1:length(iQuad)
    if size(iQuad{ii},2) > 1
        iQuad{ii} = sort(iQuad{ii}(:));
        nanindx = find(isnan(iQuad{ii}));
        iQuad{ii}(nanindx) = [];
    end
end
iQuad = cell2mat(iQuad(:));

% sextupoles
SextCell = findmemberof('SEXT');
iSext = family2atindex(SextCell);
for ii = 1:length(iSext)
    if size(iSext{ii},2) > 1
        iSext{ii} = sort(iSext{ii}(:));
        nanindx = find(isnan(iSext{ii}));
        iSext{ii}(nanindx) = [];
    end
end
iSext = cell2mat(iSext(:));


RadiationElemIndex = sort([iBend(:); iQuad(:); iSext(:)]');
%RadiationElemIndex(find(isnan(RadiationElemIndex))) = [];

[ENV, DP, DL] = ohmienvelope(THERING, RadiationElemIndex, 1:length(THERING)+1);

sigmas = cat(2, ENV.Sigma);
Tilt = cat(2, ENV.Tilt);
spos = findspos(THERING, 1:length(THERING)+1);

[TwissData, tune, chrom]  = twissring(THERING, 0, 1:length(THERING)+1, 'chrom');


% Set the passmethods back
setpassmethod(ATIndexOld, PassMethodOld);
setcavity(CavityState);


% Calculate tilts
Beta = cat(1,TwissData.beta);
spos = cat(1,TwissData.SPos);

% Apparent emittances
Eta = cat(2,TwissData.Dispersion);
EpsX = (sigmas(1,:).^2-Eta(1,:).^2*DP^2)./Beta(:,1)';
EpsY = (sigmas(2,:).^2-Eta(3,:).^2*DP^2)./Beta(:,2)';

% RMS tilt
TiltRMS = norm(Tilt)/sqrt(length(Tilt));
EtaY = Eta(3,:);

EpsX0 = mean(EpsX);
EpsY0 = mean(EpsY);
EPS = [EpsX0, EpsY0];
Ratio = EpsY0 / EpsX0;


% Fix imaginary data
% ohmienvelope seems to return complex when very close to zero
if ~isreal(sigmas(1,:))
    % Sigma is positive so this should be ok
    sigmas(1,:) = abs(sigmas(1,:));
end
if ~isreal(sigmas(2,:))
    % Sigma is positive so this should be ok
    sigmas(2,:) = abs(sigmas(2,:));
end
        
if nargout == 0
    fprintf('   RMS Tilt = %f [degrees]\n', (180/pi) * TiltRMS);
    fprintf('   RMS Vertical Dispersion = %f [m]\n', norm(EtaY)/sqrt(length(EtaY)));
    fprintf('   Mean Horizontal Emittance = %f [nm rad]\n', 1e9*EpsX0);
    fprintf('   Mean Vertical   Emittance = %f [nm rad]\n', 1e9*EpsY0);
    fprintf('   Emittance Ratio = %f%% \n', 100*Ratio);
    fprintf('   RMS energy spread =%.4e \n', DP);
    fprintf('   RMS bunch length = %.2e [mm]\n', DL*1e3);
end


if DisplayFlag
    figure
    subplot(2,2,1);
    plot(spos, Tilt*180/pi, '-')
    set(gca,'XLim',[0 spos(end)])
    ylabel('Tilt [degrees]');
    title(sprintf('Rotation Angle of the Beam Ellipse  (RMS = %f)', (180/pi) * TiltRMS));
    xlabel('s - Position [m]');
    
    subplot(2,2,3);
    [AX, H1, H2] = plotyy(spos, 1e6*sigmas(1,:), spos, 1e6*sigmas(2,:));
    
    set(AX(1),'XLim',[0 spos(end)]);
    set(AX(2),'XLim',[0 spos(end)]);
    
    title('Principal Axis of the Beam Ellipse');
    set(get(AX(1),'Ylabel'), 'String', 'Horizontal [\mum]');
    set(get(AX(2),'Ylabel'), 'String', 'Vertical [\mum]');
    xlabel('s - Position [m]');
    
    FontSize = get(get(AX(1),'Ylabel'),'FontSize');
    set(get(AX(2),'Ylabel'), 'Color', 'r')
    set(H2,'Color', 'r');
    set(AX(2),'Ycolor', 'r')
    
    
    subplot(2,2,2);
    plot(spos, 1e9 * EpsX);
    title('Horizontal Emittance');
    ylabel(sprintf('\\fontsize{16}\\epsilon_x  \\fontsize{%d}[nm rad]', FontSize));
    xlabel('s - Position [m]');
    xaxis([0 L0]);
    
    subplot(2,2,4);
    plot(spos, 1e9 * EpsY);
    title('Vertical Emittance');
    ylabel(sprintf('\\fontsize{16}\\epsilon_y  \\fontsize{%d}[nm rad]', FontSize));
    xlabel('s - Position [m]');
    xaxis([0 L0]);
    
    h = addlabel(.75, 0, sprintf('     Emittance Ratio = %f%% ', 100*Ratio), 10);
    set(h,'HorizontalAlignment','Center');
    
    orient landscape;
    
    figure
    plot(spos,EpsY./EpsX*100)
    xlabel('s - Position [m]');
    ylabel('Coupling value (%) from projected emittance');
    title(sprintf('Mean Apparent emittance  H:%f nm.rad     V:%f pm.rad \n Mean coupling: %f %%', ...
        mean(EpsX)*1e9, mean(EpsY)*1e12, mean(EpsY./EpsX)*100))
    axis tight
    
end

