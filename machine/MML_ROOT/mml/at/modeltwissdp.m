function [TwissX, TwissY, Sx, Sy, Tune] = modeltwissdp(varargin)
%MODELTWISS - Returns a twiss function of the model for offmomentum energy
%  [TwissX, TwissY, Sx, Sy, Tune] = modeltwissdp(TwissData {opt.}, TwissString, Family1, DeviceList1, Family2, DeviceList2)
%  [TwissX, TwissY, Sx, Sy, Tune] = modeltwissdp(TwissData {opt.}, TwissString, Family1, Family2)
%  [TwissX, TwissY, Sx, Sy, Tune] = modeltwissdp(TwissData {opt.}, TwissString, Family1, DeviceList1)
%  [TwissX, TwissY, Sx, Sy, Tune] = modeltwissdp(TwissData {opt.}, TwissString)
%
%  INPUTS
%  1. TwissData - Structure with the twiss parameters {Default: get from THERING{1}.TwissData}
%  2. TwissString - 'beta'           for beta function [meters]
%                   'mu' or 'Phase'  for betatron phase advance (NOT 2*PI normalized)
%                   'alpha'          Derivative of the beta function
%                   'ClosedOrbit' or 'x'       ('y'  reverses output  [ y,  x, Sy, Sx, Tune] = modeltwissdp('y')) 
%                   'ClosedOrbitPrime' or 'Px' ('Py' reverses output  [Py, Px, Sy, Sx, Tune] = modeltwissdp('Py')) (momentum, NOT angle)
%                   'Eta' for dispersion
%                   'EtaPrime' for the derivative of dispersion
%  3. Family1 and Family2 are the family names for where to measure the horizontal/vertical twiss parameter.
%     A family name can be a middlelayer family or an AT family (FamName). 
%     'All' returns the value at every element in the model plus the end of the ring.
%     {Default or []: 'All'}
%  4. DeviceList1 and DeviceList2 are the device list corresponding to Family1 and Family2.
%     {Default or []: the entire list}
%
%  OUTPUTS
%  1. TwissX and TwissY - Horizontal and vertical twiss parameter
%  2. Sx and Sy are longitudinal locations in the ring [meters]
%  3. Tune - Fractional tune
%
%  NOTES
%  1. This function use twissline which uses the linear model.  See twissline 
%     for all the assumption that it uses.
%  2. This function uses the model coordinate system in physics units. 
%     Ie., no BPM or CM gain or rolls errors are applied.
%  3. Family1 and DeviceList1 can be any family.  For instance, if Family1='VCM'
%     and DeviceList1=[], then TwissX is the horizontal beta function at the 
%     vertical corrector magnets (similarly for Family2 and DeviceList2).
%  4. If no output exists, the function will be plotted to the screen.
%  5. Phase is in radians.
%
%  See also modelbeta modeltune modeldisp getpvmodel setpvmodel
%
%  Written by Greg Portmann


global THERING
if isempty(THERING)
    error('Simulator variable is not setup properly.');
end

% Default parameters if not overwritten
TwissString = 'beta';
Family1 = 'ALL';
Family2 = 'ALL';
%Family1 = 'BPMx';
%Family2 = 'BPMy';
DeviceList1 = [];   
DeviceList2 = [];   
DrawLatticeFlag = 0;


% Look for flags
for i = length(varargin):-1:1
    if ischar(varargin{i})
        if strcmpi(varargin{i}, 'DrawLattice')
            DrawLatticeFlag = 1;
            varargin(i) = [];
        end
    end
end


% Look for TwissString
if length(varargin) >= 1
    if ischar(varargin{1})
        TwissString = varargin{1};
        varargin(1) = [];
    end
end

% Look for BPMx family info
if length(varargin) >= 1
    if ischar(varargin{1})
        Family1 = varargin{1};
        varargin(1) = [];
        if length(varargin) >= 1
            if isnumeric(varargin{1})
                DeviceList1 = varargin{1};
                varargin(1) = [];
            end
        end
    else
        if isnumeric(varargin{1})
            DeviceList1 = varargin{1};
            varargin(1) = [];
        end
    end
end

% Look for BPMy family info
if length(varargin) >= 1
    if ischar(varargin{1})
        Family2 = varargin{1};
        varargin(1) = [];
        if length(varargin) >= 1
            if isnumeric(varargin{1})
                DeviceList2 = varargin{1};
                varargin(1) = [];
            end
        end
    else
        if isnumeric(varargin{1})
            DeviceList2 = varargin{1};
            varargin(1) = [];
        end
    end
else
    Family2 = Family1;
    DeviceList2 = DeviceList1;
end


% Horizontal plane
if strcmpi(Family1,'All') 
    Index1 = 1:length(THERING)+1;
elseif isfamily(Family1)
    Index1 = family2atindex(Family1, DeviceList1);
else
    Index1 = findcells(THERING, 'FamName', Family1);
end
if isempty(Index1)
    error('Family1 could not be found in the AO or AT deck');
else
    Index1 = Index1(:)';    % Row vector
end

% Vertical plane
if strcmpi(Family2,'All') 
    Index2 = 1:length(THERING)+1;
elseif isfamily(Family2)
    Index2 = family2atindex(Family2, DeviceList2);
else
    Index2 = findcells(THERING, 'FamName', Family2);
end
if isempty(Index2)
    error('Family2 could not be found in the AO or AT deck');
else
    Index2 = Index2(:)';    % Row vector
end

MachineType = getfamilydata('MachineType');
if any(strcmpi(MachineType, {'Transport','Transportline','Linac'}))
    % Transport line

    % Look for TWISSDATAIN
    TWISSDATAIN = [];
    if length(varargin) >= 1
        if isstruct(varargin{1})
            TWISSDATAIN = varargin{1};
            varargin(1) = [];
        end
    end
    if isempty(TWISSDATAIN)
        if isfield(THERING{1}, 'TwissData')
            TWISSDATAIN = THERING{1}.TwissData;
        else
            TWISSDATAIN = getfamilydata('TwissData');
            if isempty(TWISSDATAIN)
                error('TWISSDATAIN must be an input, located in THERING{1}.TwissData, or accessible to getfamilydata.');
            end
        end
    end

    if strcmpi(TwissString, 'Eta') || strcmpi(TwissString, 'Dispersion')  || strcmpi(TwissString, 'Disp')
        TD = twissline(THERING, 0, TWISSDATAIN, 1:(length(THERING)+1), 'Chrom');
    elseif strcmpi(TwissString, 'etaprime')
        TD = twissline(THERING, 0, TWISSDATAIN, 1:(length(THERING)+1), 'Chrom');
    else
        TD = twissline(THERING, 0, TWISSDATAIN, 1:(length(THERING)+1));
    end
    
    % Tune
    Tune = TD(end).mu/2/pi;
    Tune = Tune(:);

else
    % Storage ring
    if strcmpi(TwissString, 'Eta') || strcmpi(TwissString, 'Dispersion')
        % if nargout == 0
        %     % To get the default plot
        %     modeldisp(Family1, DeviceList1, Family2, DeviceList2, 'Physics');
        % else
        %     [TwissX, TwissY, Sx, Sy] = modeldisp(Family1, DeviceList1, Family2, DeviceList2, 'Physics');
        % end
        % if nargout >= 5
        %     Tune = modeltune;
        % end
        % return;
        [TD, Tune] = twissring(THERING, 0, 1:(length(THERING)+1), 'Chrom');
    elseif strcmpi(TwissString, 'etaprime')
        [TD, Tune] = twissring(THERING, 0, 1:(length(THERING)+1), 'Chrom');
    else
        [TD, Tune] = twissring(THERING, 0, 1:(length(THERING)+1));
    end
    Tune = Tune(:);
end


if strcmpi(TwissString, 'Phase')
    TwissString = 'mu';
end


if strcmpi(TwissString, 'beta')
    Twiss = cat(1,TD.beta);
    TwissXAll = Twiss(:,1);
    TwissYAll = Twiss(:,2);
    TwissX = Twiss(Index1,1);
    TwissY = Twiss(Index2,2);

    % Average of beginning and end of magnet
    %TwissXAll = [(Twiss(1:end-1,1)+Twiss(2:end,1))/2; Twiss(end,1)];
    %TwissYAll = [(Twiss(1:end-1,2)+Twiss(2:end,2))/2; Twiss(end,2)];
    %TwissX = (Twiss(Index1,1)+Twiss(Index1+1,1))/2;
    %TwissY = (Twiss(Index2,2)+Twiss(Index2+1,2))/2;

    YLabel1 = sprintf('\\beta_x [meters]');
    YLabel2 = sprintf('\\beta_y [meters]');
    Title1  = sprintf('\\beta-function (Tune = %.3f / %.3f)', Tune);
elseif strcmpi(TwissString, 'mu')
    Twiss = cat(1,TD.mu);
    TwissXAll = Twiss(:,1);
    TwissYAll = Twiss(:,2);
    TwissX = Twiss(Index1,1);
    TwissY = Twiss(Index2,2);

    %TwissXAll = [(Twiss(1:end-1,1)+Twiss(2:end,1))/2; Twiss(end,1)];
    %TwissYAll = [(Twiss(1:end-1,2)+Twiss(2:end,2))/2; Twiss(end,2)];
    %TwissX = (Twiss(Index1,1)+Twiss(Index1+1,1))/2;
    %TwissY = (Twiss(Index2,2)+Twiss(Index2+1,2))/2;

    YLabel1 = sprintf('\\%s_x [radians]', 'phi');
    YLabel2 = sprintf('\\%s_y [radians]', 'phi');
    Title1  = sprintf('Phase Advance (Tune = %.3f / %.3f)', Tune);
elseif strcmpi(TwissString, 'dispersion') || strcmpi(TwissString, 'disp') || strcmpi(TwissString, 'eta')
    %error('Use modeldisp');
    Twiss = cat(2,TD.Dispersion)';
    TwissXAll = Twiss(:,1);
    TwissYAll = Twiss(:,3);
    TwissX = Twiss(Index1,1);
    TwissY = Twiss(Index2,3);
    YLabel1 = sprintf('\\eta_x [m/(dp/p)]');
    YLabel2 = sprintf('\\eta_y [m/(dp/p)]');
    Title1  = sprintf('Dispersion');
elseif strcmpi(TwissString, 'etaprime')
    Twiss = cat(2,TD.Dispersion)';
    TwissXAll = Twiss(:,2);
    TwissYAll = Twiss(:,4);
    TwissX = Twiss(Index1,2);
    TwissY = Twiss(Index2,4);
    YLabel1 = '\partial\eta_x / \partial \its';
    YLabel2 = '\partial\eta_y / \partial \its';
    Title1  = sprintf('Derivative of the Dispersion');
elseif strcmpi(TwissString, 'ClosedOrbit') ||  strcmpi(TwissString, 'x')
    iCavity = findcells(THERING,'Frequency');
             
    if isempty(iCavity)  %no cavity in AT model
        Twiss = cat(2,TD.ClosedOrbit)';
        %Twiss = findsyncorbit(THERING, 0, ATIndexList);
    else
        % Cavity in AT model
        PassMethod = THERING{iCavity(1)}.PassMethod;
        for kk = 1:length(iCavity)
            THERING{iCavity(kk)}.PassMethod = 'IdentityPass';    % Off
        end               
        
        C = 2.99792458e8;
        CavityFrequency  = THERING{iCavity(1)}.Frequency;
        CavityHarmNumber = THERING{iCavity(1)}.HarmNumber;
        L = findspos(THERING,length(THERING)+1); 
        f0 = C * CavityHarmNumber / L;
        DeltaRF = CavityFrequency - f0;   % Hz
        Twiss = findsyncorbit(THERING, -C*DeltaRF*CavityHarmNumber/CavityFrequency^2, 1:length(THERING)+1);
                
        % Reset PassMethod
        for kk = 1:length(iCavity)
            %THERING{iCavity(kk)}.PassMethod = 'ThinCavityPass';  % On
            THERING{iCavity(kk)}.PassMethod = PassMethod;
        end

        Twiss = Twiss';
    end
    TwissXAll = Twiss(:,1);
    TwissYAll = Twiss(:,3);
    TwissX = Twiss(Index1, 1);
    TwissY = Twiss(Index2, 3);
    YLabel1 = sprintf('x [meter]');
    YLabel2 = sprintf('y [meter]');
    Title1  = sprintf('Closed Orbit');
elseif strcmpi(TwissString, 'y')
    iCavity = findcells(THERING,'Frequency');
    if isempty(iCavity)  %no cavity in AT model
        Twiss = cat(2,TD.ClosedOrbit)';
        %Twiss = findsyncorbit(THERING, 0, ATIndexList);
    else
        % Cavity in AT model
        PassMethod = THERING{iCavity}.PassMethod;
        THERING{iCavity}.PassMethod = 'IdentityPass';    % Off
        
        C = 2.99792458e8;
        CavityFrequency  = THERING{iCavity}.Frequency;
        CavityHarmNumber = THERING{iCavity}.HarmNumber;
        L = findspos(THERING,length(THERING)+1); 
        f0 = C * CavityHarmNumber / L;
        DeltaRF = CavityFrequency - f0;   % Hz
        Twiss = findsyncorbit(THERING, -C*DeltaRF*CavityHarmNumber/CavityFrequency^2, 1:length(THERING)+1);
        
        % Reset PassMethod
        %THERING{iCavity}.PassMethod = 'ThinCavityPass';  % On
        THERING{iCavity}.PassMethod = PassMethod;

        Twiss = Twiss';
    end 
    TwissXAll = Twiss(:,3);
    TwissYAll = Twiss(:,1);
    TwissX = Twiss(Index1, 3);
    TwissY = Twiss(Index2, 1);
    YLabel1 = sprintf('y [meter]');
    YLabel2 = sprintf('x [meter]');
    Title1  = sprintf('Closed Orbit');
elseif strcmpi(TwissString, 'ClosedOrbitPrime') || strcmpi(TwissString, 'Px')
    Twiss = cat(2,TD.ClosedOrbit)';
    TwissXAll = Twiss(:,2);
    TwissYAll = Twiss(:,4);
    TwissX = Twiss(Index1, 2);
    TwissY = Twiss(Index2, 4);
    YLabel1 = 'P_x';
    YLabel2 = 'P_y';
    Title1  = 'Derivative of the Closed Orbit';
elseif strcmpi(TwissString, 'Py')
    Twiss = cat(2,TD.ClosedOrbit)';
    TwissXAll = Twiss(:,4);
    TwissYAll = Twiss(:,2);
    TwissX = Twiss(Index1, 4);
    TwissY = Twiss(Index2, 2);
    YLabel1 = 'P_y';
    YLabel2 = 'P_x';
    Title1  = 'Derivative of the Closed Orbit';
else
    Twiss = cat(1,TD.(TwissString));
    TwissXAll = Twiss(:,1);
    TwissYAll = Twiss(:,2);
    TwissX = Twiss(Index1, 1);
    TwissY = Twiss(Index2, 2);
    YLabel1 = sprintf('\\%s_x', TwissString);
    YLabel2 = sprintf('\\%s_y', TwissString);
    Title1  = sprintf('\\%s-functions', TwissString);
end


% Longitudinal position
SAll = cat(1,TD.SPos);
Sx = SAll(Index1);
Sy = SAll(Index2);

Sx = Sx(:);
Sy = Sy(:);
SAll = SAll(:);

% Twiss = Twiss;
% TwissX = TwissX;
% TwissY = TwissY;
% TwissXAll = TwissXAll;
% TwissYAll = TwissYAll;


% Output
if nargout == 0
    % Plot
    if strcmpi(TwissString, 'mu')
        % Keep phase plot between -pi and pi
        xall = [];
        sxall= [];
        for i = 1:length(TwissXAll)
            if TwissXAll(i) > 2*pi
                TwissXAll(i:end) = TwissXAll(i:end) - 2*pi;
                xall = [xall; 2*pi; 0];    
                sxall = [sxall; mean(SAll(i-1:i)); mean(SAll(i-1:i))];
                xall = [xall; TwissXAll(i)];
                sxall = [sxall; SAll(i)];
            else
                xall = [xall; TwissXAll(i)];
                sxall = [sxall; SAll(i)];
            end
        end
        TwissX = rem(TwissX,2*pi);
        
        yall = [];
        syall= [];
        for i = 1:length(TwissYAll)
            if TwissYAll(i) > 2*pi
                TwissYAll(i:end) = TwissYAll(i:end) - 2*pi;
                yall = [yall; 2*pi; 0];    
                syall = [syall; mean(SAll(i-1:i)); mean(SAll(i-1:i))];
                yall = [yall; TwissYAll(i)];
                syall = [syall; SAll(i)];
            else
                yall = [yall; TwissYAll(i)];
                syall = [syall; SAll(i)];
            end
        end
        TwissY = rem(TwissY,2*pi);
        
        clf reset
        h1 = subplot(5,1,[1 2]);
        % plot Twiss paramaters
        plot(sxall, xall, '-b');
        if strcmpi(Family1,'All')
            xlabel('Position [meters]');
        else
            hold on;
            plot(Sx, TwissX, '.b');
            hold off;
            xlabel(sprintf('%s Position [meters]', Family1));
        end
        ylabel(YLabel1);
        title(Title1, 'Fontsize', 12);
        yaxis([0 2*pi]);
        xaxis([SAll(1) SAll(end)]);
        
        % plot lattice
        h2 = subplot(5,1,3);
        drawlattice;
        
        h3 = subplot(5,1,[4 5]);
        % plot Twiss paramaters
        plot(syall, yall, '-b');
        if strcmpi(Family2,'All')
            xlabel('Position [meters]');
        else
            hold on;
            plot(Sy, TwissY, '.b');
            hold off;
            xlabel(sprintf('%s Position [meters]', Family2));
        end
        ylabel(YLabel2);
        yaxis([0 2*pi]);
        xaxis([SAll(1) SAll(end)]);
        
        linkaxes([h1 h2 h3],'x')
        set([h1 h2 h3],'XGrid','On','YGrid','On');
    else
        clf reset
        h1 = subplot(5,1,[1 2]);
        % plot Twiss paramaters
        plot(SAll, TwissXAll, '-b');
        if strcmpi(Family1,'All')
            xlabel('Position [meters]');
        else
            hold on;
            plot(Sx, TwissX, '.b');
            hold off;
            xlabel(sprintf('%s Position [meters]', Family1));
        end
        ylabel(YLabel1);
        title(Title1, 'Fontsize', 12);
        xaxis([SAll(1) SAll(end)]);
        
        % plot lattice
        h2 = subplot(5,1,3);
        drawlattice;
        
        h3 = subplot(5,1,[4 5]);
        % plot Twiss parmaters
        plot(SAll, TwissYAll, '-b');
        if strcmpi(Family2,'All')
            xlabel('Position [meters]');
        else
            hold on;
            plot(Sy, TwissY, '.b');
            hold off;
            xlabel(sprintf('%s Position [meters]', Family2));
        end
        ylabel(YLabel2);
        xaxis([SAll(1) SAll(end)]);
        
        linkaxes([h1 h2 h3],'x')
        set([h1 h2 h3],'XGrid','On','YGrid','On');

        grid on;
    end

    if DrawLatticeFlag
        subplot(2,1,1);
        hold on
        a = axis;
        drawlattice(a(4)-.08*(a(4)-a(3)),.05*(a(4)-a(3)));
        %drawlattice(a(4)-.5*(a(4)-a(3)),.05*(a(4)-a(3)));
        hold off;
        %subplot(2,1,2);
        %hold on
        %a = axis;
        %drawlattice(a(4)-.08*(a(4)-a(3)),.05*(a(4)-a(3)));
        %hold off;

        % subplot(2,1,1);
        % xlabel('');
        %
        % h = subplot(17,1,9);
        % drawlattice(0, 1, h);
        % %set(h,'Visible','Off');
        % set(h,'Color','None');
        % set(h,'XMinorTick','Off');
        % set(h,'XMinorGrid','Off');
        % set(h,'YMinorTick','Off');
        % set(h,'YMinorGrid','Off');
        % set(h,'XTickLabel',[]);
        % set(h,'YTickLabel',[]);
        % set(h,'XLim', [0 Cir]);
        % set(h,'YLim', [-1.5 1.5]);
    end
end
