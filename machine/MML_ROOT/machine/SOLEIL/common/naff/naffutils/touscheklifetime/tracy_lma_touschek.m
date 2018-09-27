function [Tous,Tousp,Tousn] = tracy_lma_touschek(varargin)
%function [Tous,Tousp,Tousn]=tracy_lma_touschek(fileName,linlat,sigmas,couplage)
%tracy_lma_touschek - Plot local momentum acceptance from Tracy code and compute Touschek liftetime 
% based on the energy acceptance computed by Tracy code
%
%  INPUTS
%  1. fileName   - output format from tracy (soleil.out)
%  2. linlat - optics fileName (linlat.out)
%  3. H-emittance - Horizontal emittance
%  4. sigmas - bunch length (m)
%  5. bunch current (mA)
%  6. couplage - coupling value
%  7. energy - Energy value
%  Extra 'Full' -  1/0 Full machine instead of a quarter
%        'LMAonly' - 1/0 Just plot Local Momentum Aperture and losses
%        'PivinskiVersion' - use full Pivinski formula
%        'APD Version' - use APD simplication form of Pivisnki formula
%
%
%  OUTPUTS
%  1. T(h)  - Total Touschek lifetime
%  2. Tp(h) - Touschek lifetime delta >0
%  3. Tn(h) - Touschek lifetime delta <0
%
% NOTES
%  1. Integration method: Simpson (as in BETA code)
%  2. External function used: C(xi) standard function
%
%
%  Example
%  1. Computation for 1% coupling and 6 mm bunch length
%     [T, Tp, Tn] = tracy_lma_touschek('soleil.out','linlat.out', 6e-3, 1e-2)

%
%% Written by Laurent S. Nadolski, SOLEIL 2003

FullMachineFlag = 0;
DisplayFlag = 1;
Tous = -1;Tousp =-1; Tousn = -1;
LMAonlyFlag = 0; % Plot only data
LossFlag = 1;
ForceMAFlag = 0; % force MA value
ForceMA_ = 6.e-2;
PivinskiFlag = 1;

% Get input flags
for i = length(varargin):-1:1
    if ischar(varargin{i})
        if strcmpi(varargin{i},'FullMachine')
            FullMachineFlag = 1;
            varargin(i) = [];
        elseif strcmpi(varargin{i},'LMAonly')
            LMAonlyFlag = 1;
            varargin(i) = [];
        elseif strcmpi(varargin{i},'PivinskiVersion')
            PivinskiFlag = 1;
            varargin(i) = [];
        elseif strcmpi(varargin{i},'APDVersion')
            PivinskiFlag = 0;
            varargin(i) = [];
        end
    end
end

% Help part if not enough input arguments
if length(varargin) <1
    help(eval('mfilename'))
    return;
else
    fileName   = varargin{1}; % Energy acceptance
    linlat = varargin{2}; % Twiss parameters
end

% Reading Twiss function
% name     spos    alphax  betax   nux   etax   etapx  alphay  betay   nuy   etay   etapy
%         [m]            [m]           [m]                   [m]           [m]
try
    [dummy spos ax bx mux etax etaxp az bz muz etaz etazp] = ...
        textread(linlat,'%s %f %f %f %f %f %f %f %f %f %f %f','headerlines',4);
catch errorRecord
    if strfind(errorRecord.message, 'file not found.');
        fprintf('Input fileName %s not found \n Abort \n',linlat);
    else
        fprintf('Unknown error %s \n', errorRecord.message)
    end
% %     return;
end

% Emittance
if length(varargin) <3
    ex0 = 3.9E-9;  %Default emittance value
    fprintf('Default H-emittance value is: ex = %f nm.rad\n',ex)
else
    ex0 = varargin{3};
end

% bunch current
if length(varargin) <5
    Ibunch = 1.0E-3;  %Default emittance value
    fprintf('Default H-emittance value is: ex = %f nm.rad\n',ex)
else
    Ibunch = varargin{5}*1e-3; % convert milli Amps to Amps
end

% coupling value
if length(varargin) <6
    kappa = 1.0E-2;  %Default coupling value
    fprintf('Default coupling value is: kapa = %f\n',kappa)
else
    kappa = varargin{6};
end

ez = ex0*kappa/(1+kappa);  %Emittance V
ex = ex0/(1+kappa); % Emittance H
se = 1.013E-3; %Dispersion en energie
gx = (1+ax.^2)./bx; %Twiss parameter: Gammax

sx = sqrt(bx*ex+(se*etax).^2);  %Beam size  H
sxp= sqrt(gx*ex+(se*etaxp).^2); %Divergence H
sz = sqrt(bz*ez+(se*etaz).^2);  %Beam size V

% open fileName and get data
try
    if ~exist(fileName, 'file')
        error('fileName %s% does not exist. Aborting \n', fileName);
    end
    try % old format
        [dummy sd acen lost nom] = textread(fileName,'%d %f %f %f %s','headerlines',3);
        maStruct.elem.ma       = acen;
        maStruct.elem.position = sd;
        maStruct.loss.position = lost;
        maStruct.loss.name     = nom;
    catch errorRecord0 % new format
        
        DELIMITER = ' ';
        HEADERLINES = 3;
        
        % Import the fileName
        newData = importdata(fileName, DELIMITER, HEADERLINES);
        maStruct.header        = newData.textdata(1:HEADERLINES,1);
        maStruct.elem.index    = str2double(newData.textdata(HEADERLINES+1:end,1));
        maStruct.elem.position =  str2double(newData.textdata(HEADERLINES+1:end,2));
        maStruct.elem.name     =  newData.textdata(HEADERLINES+1:end,3);
        maStruct.elem.ma       =  str2double(newData.textdata(HEADERLINES+1:end,4));
        maStruct.loss.plane    =  str2double(newData.textdata(HEADERLINES+1:end,5));
        maStruct.loss.position =  str2double(newData.textdata(HEADERLINES+1:end,6));
        maStruct.loss.phase    =  newData.data;
    end
catch errorRecord
    getReport(errorRecord, 'basic')
    return;
    %
end
Nb_pts=length(maStruct.elem.position)/2;
spos=maStruct.elem.position(1:Nb_pts);
acen_p=maStruct.elem.ma(1:Nb_pts); acen_n=maStruct.elem.ma(Nb_pts+1:end);

% for debugging for MA value
if ForceMAFlag
    acen_p=ones(size(maStruct.elem.ma(1:Nb_pts)))*ForceMA_;
    acen_n=ones(size(maStruct.elem.ma(1:Nb_pts)))*-ForceMA_;
end

% bunch length value
if length(varargin) <4
    ss = 6E-3;  %sigma_s en mm
    fprintf('Default bunch length : sigma_s = %f m\n',ss)
else
    ss =varargin{4};
end

% bunch length value
if length(varargin) <7
    Energy     = 2.739;           % Energy
    fprintf('Default beam energy: E = %f GeV \n',Energy)
else
    Energy =varargin{7};
end

Vol     = 8*pi*sqrt(pi).*sx.*sz.*ss; %Volume du paquet
Gamma = Energy*1e3/PhysConstant.electron_mass_energy_equivalent_in_MeV.value;      % Facteur de Lorentz
cl    = PhysConstant.speed_of_light_in_vacuum.value;    % Vitesse de la lumiere
re    = PhysConstant.classical_electron_radius.value;  % Rayon classique de l'electron
I0    = Ibunch;          % Bunch current
Qe    = PhysConstant.electron_volt.value;      % Charge de l'electron
Circumference = 354.09702;       % Circonference de l'anneau
Ne     = I0/cl*Circumference/Qe;  % Nombre d'electrons par paquet


if PivinskiFlag
    if ~LMAonlyFlag
        % convert data format
        len = length(maStruct.elem.ma);
        dppP_T = maStruct.elem.ma(1:len/2);
        dppM_T = maStruct.elem.ma(len/2+1:end);
        
        % two sided momentum aperture: 1/Ttot=1/2(1/Tup+1/Tdown)
        %TL=TouschekPiwinskiLifeTime_tracy(RING,[dppM_T dppP_T],Ib)/3600;
        [Tousn, Tn, ~]=TouschekPiwinskiLifeTime_tracy(dppM_T,Energy*1e9, ex0, kappa, se, ss, Ibunch);
        Tousn = Tousn/3600; Tn = Tn/3600;
        [Tousp, Tp, idx_]=TouschekPiwinskiLifeTime_tracy(dppP_T,Energy*1e9, ex0, kappa, se, ss, Ibunch);
        Tousp = Tousp/3600; Tp = Tp/3600;
        
        Tous=2/(1/Tousp+1/Tousn);
        disp('Two sided momentum aperture: 1/Ttot = 1/2(1/Tup+1/Tdown) :')
        fprintf('Pivinski: T_tracy = %6.2f h\n',Tous)
        
        spos_reduced = spos(idx_);                
    end

else % old way till September 2015 to compute Lifetime at SOLEIL (APD like)
    % Inverse Touschek lifetime
    
    %Duree de vie locale positive et negative en heures
    %xi_p=(acen_p./Gamma./sxp)^2;
    %xi_n=(acen_n./Gamma./sxp)^2;
    FF = sqrt(pi)*re*re*cl*Ne*3600;
    Tinvp = zeros(1,Nb_pts);
    Tinvn = zeros(1,Nb_pts);
    if ~LMAonlyFlag
        h = waitbar(0,sprintf('Computing: %2d %%',0), 'Name', 'Touschek lifetime');
        for i=1:Nb_pts, % loop because of Cxi function
            Tinvp(i) = (FF*Cxi((acen_p(i)/Gamma/sxp(i))^2)/sxp(i) ...
                /Gamma^3/acen_p(i)^2/Vol(i));
            Tinvn(i) = (FF*Cxi((acen_n(i)/Gamma/sxp(i))^2)/sxp(i) ...
                /Gamma^3/acen_n(i)^2/Vol(i));
            waitbar(i/Nb_pts, h, sprintf('Computing progression: %3d %%', floor(i/Nb_pts*100)));
        end
        close(h);
    end
    
    % Local average lifetime
    Tinv = (Tinvp+Tinvn)/2;
    
    Tp=1./Tinvp;
    Tn=1./Tinvn;
    
    % Integration: Simpson method
    spos1=[0 ; spos]; spos2=[spos ; 0]; ds=spos2-spos1;
    Tousp=1/sum(1./Tp.*ds(1:end-1)')*spos(end);
    Tousn=1/sum(1./Tn.*ds(1:end-1)')*spos(end);
    
    Tous=2/(1/Tousp+1/Tousn);
end

%% plotsection
pwd0 = pwd;
[~, DirName] = fileparts (pwd0);

if ~exist('spos_reduced', 'var')
    spos_reduced = spos;
end

if DisplayFlag    
    if ~LMAonlyFlag
        figure
        subplot(2,1,1)
        plot(spos_reduced,Tp,'.-');
        grid on
        xlabel('spos (m)')
        ylabel('Tp (h)')
        
        subplot(2,1,2)
        plot(spos_reduced,Tn,'.-');
        grid on
        xlabel('spos (m)')
        ylabel('Tn (h)')
        
        addlabel(0,0, fullfile(DirName));
    end
    
    % Structure fileName
    if FullMachineFlag
        files = fullfile(fileparts(which('naffgui')),'structure_nanoscopium');
    else
        files = fullfile(fileparts(which('naffgui')),'structure');
    end
    struc=dlmread(files);
    
    % artificial symmetry
    maStruct.elem.ma=maStruct.elem.ma*100;
    
    figure
    clf
    plot([maStruct.elem.position(1:Nb_pts); 2*maStruct.elem.position(Nb_pts)-maStruct.elem.position(Nb_pts:-1:1)],[maStruct.elem.ma(1:Nb_pts) ; maStruct.elem.ma(Nb_pts:-1:1)],'b.-');
    hold on
    plot([maStruct.elem.position(Nb_pts+1:end); 2*maStruct.elem.position(end)-maStruct.elem.position(end:-1:1+Nb_pts)],[maStruct.elem.ma(Nb_pts+1:end) ; maStruct.elem.ma(end:-1:Nb_pts+1)],'b.-');
    plot(struc(:,1),struc(:,2)/2,'k-')
    
    if FullMachineFlag
        axis([0 getcircumference -9 5])
    else
        axis([0 getcircumference/4 -9 5])
    end
    grid on
    
    if ~LMAonlyFlag
        stitle = sprintf('Local momentum acceptance: Touschek lifetime %.2f h', Tous);
    else
        stitle = sprintf('Local momentum acceptance:');
    end

    title(stitle)
    xlabel('spos (m)')
    ylabel('Energy Acceptance \epsilon (%)')
    addlabel(0,0, fullfile(DirName));
    
    if LossFlag
       %% pie chart with loss distribution
       figure;
       
       iStable = maStruct.loss.plane == 0;
       iHplane = maStruct.loss.plane == 1;
       iVplane = maStruct.loss.plane == 2;
       iLplane = maStruct.loss.plane == 3;
       
       chart = [sum(iStable) sum(iHplane) sum(iVplane) sum(iLplane)]+1;
       
       explode = [1,1,1,1];
       
       pie(chart, explode);
       suptitle('Loss particle distribution')
       legend({'Stable', 'Horizontal', 'Vertical', 'Longitudinal'}, 'Location', 'NorthEastOutside')
       addlabel(0,0, fullfile(DirName, fileName));
       
       %%     
       %chamber = tracy_chamber('Nodisplay','tracy3');
       
       iHplane = find(maStruct.loss.plane == 1);
       iVplane = find(maStruct.loss.plane == 2);
       figure('Position', [1 1 560 660]); clf;
       h(1) = subplot(3,1,1);
       hist(maStruct.loss.position(iHplane), 0:getcircumference);hold on;
       hist(maStruct.loss.position(iVplane), 0:getcircumference); 
     
       hobj = findobj(gca,'Type','patch');
       display(hobj);
       
       set(hobj(2),'FaceColor',[0 1 1] ,'EdgeColor','k' );
       set(hobj(1),'FaceColor',[1 0.8 0.2],'EdgeColor','k' );
       title('Particle loss location')
       legend({'H-plane', 'V-plane'});
       ylabel('Lost particule (a.u.)');
       
       h(2) = subplot(3,1,2);
       %plot(chamber.slocation, chamber.hplane(:,1), 'k'); hold on;
       %plot(chamber.slocation, chamber.hplane(:,2), 'k');
       drawlattice(0,10)
       ylabel('H-vac. chamber (mm)');
       
       h(3) = subplot(3,1,3);
       %plot(chamber.slocation, chamber.vplane(:,1), 'k'); hold on;
       %plot(chamber.slocation, chamber.vplane(:,2), 'k');
       drawlattice(0,5)
       linkaxes(h,'x')
       xlim([0 getcircumference])
       xlabel('s-location (m)')
       ylabel('V-vac. chamber (mm)');
       
       linkaxes(h,'x')
       xlim([0 getcircumference])
       xlabel('s-location (m)')
       
       addlabel(0,0, fullfile(DirName, fileName));

    end
    
end
