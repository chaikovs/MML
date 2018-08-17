function [Tous,Tousp,Tousn]=Calc_Tous(varargin)
%function [Tous,Tousp,Tousn]=Calc_Tous(file,linlat,sigmas,couplage)
%Calc_Tous - Compute Touschek liftetime based on the energy acceptance
%computed by Tracy code
%
%  Integration method: Simpson (as in BETA code)
%
%  External function used: C(xi) standard function
%
%  INPUTS
%  1. file   - output format from tracy (soleil.out)
%  2. linlat - optics file (linlat.out)
%  3. hemittance - Horizontal emittance
%  4. sigmas - bunch length (m)
%  5. couplage - coupling value
%  6. energy - Energy value
%  Extra 'Full' -  Full machine instead of a quarter
%
%  OUTPUTS
%  1. T(h)  - Total Touschek lifetime
%  2. Tp(h) - Touschek lifetime delta >0
%  3. Tn(h) - Touschek lifetime delta <0
%
%  Example
%  1. Computation for 1% coupling and 6 mm bunch length
%     [T, Tp, Tn] = Calc_Tous('soleil.out','linlat.out', 6e-3, 1e-2)

%
%% Written by Laurent S. Nadolski, SOLEIL 2003

FullMachineFlag = 0;
DisplayFlag = 1;


% Get input flags
for i = length(varargin):-1:1
    if isstr(varargin{i})
        if strcmpi(varargin{i},'FullMachine')
            FullMachineFlag = 1;
            varargin(i) = [];
        end
    end
end

% Help part if not enough input arguments
if length(varargin) <1
    help(eval('mfilename'))
    return;
else
    file   = varargin{1}; % Energy acceptance
    linlat = varargin{2}; % Twiss parameters
end

% Reading Twiss function
% name     s    alphax  betax   nux   etax   etapx  alphay  betay   nuy   etay   etapy
%         [m]            [m]           [m]                   [m]           [m]
try
    [dummy s ax bx mux etax etaxp az bz muz etaz etazp] = ...
        textread(linlat,'%s %f %f %f %f %f %f %f %f %f %f %f','headerlines',4);
catch
    errmsg = lasterr;
    if strfind(errmsg, 'File not found.');
        error('Input file %s not found \n Abort \n',linlat);
    else
        error('Unknown error %s \n', errmsg)
    end
end

% Emittance
if length(varargin) <3
    ex = 3.7E-9;  %Default emittance value
    fprintf('Default coupling value is: ex = %f nm.rad\n',ex)
else
   ex = varargin{3};
end

% coupling value
if length(varargin) <5
    kapa = 1.0E-2;  %Default coupling value
    fprintf('Default coupling value is: kapa = %f\n',kapa)
else
    kapa = varargin{5};
end

ez = ex*kapa;  %Emittance V
se = 1.016E-3; %Dispersion en energie
gx = (1+ax.^2)./bx; %Gammax

sx = sqrt(bx*ex+(se*etax).^2);  %Taille  H
sxp= sqrt(gx*ex+(se*etaxp).^2); %Divergence H
sz = sqrt(bz*ez+(se*etaz).^2);  %Taille V

[dummy sd acen lost nom] = textread(file,'%d %f %f %f %s','headerlines',3);
Nb_pts=length(sd)/2;
s=sd(1:Nb_pts);
acen_p=acen(1:Nb_pts); acen_n=acen(Nb_pts+1:end);

% bunch length value
if length(varargin) <4
    ss = 6.0E-4;  %sigma_s en mm
    fprintf('Default bunch length : sigma_s= %f m\n',ss)
else
    ss =varargin{4};
end

% bunch length value
if length(varargin) <6
    E     = 2.739;           % Energy
    fprintf('Default beam energy: E= %f GeV \n',E)
else
    E =varargin{6};
end

V     = 8*pi*sqrt(pi).*sx.*sz.*ss; %Volume du paquet
Gamma = 5382.57324;      % Facteur de Lorentz
c     = 2.99792458E8;    % Vitesse de la lumiere
re    = 2.81794092E-15;  % Rayon classique de l'electron
I0    = 1.0E-3;          % Courant par paquet
Qe    = 1.6022E-19;      % Charge de l'electron
L     = 354.097;         % Circonference de l'anneau
N     = I0/c*L/Qe;       % Nombre d'electrons par paquet

% Inverse Touschek lifetime

%Duree de vie locale positive et negative en heures
%xi_p=(acen_p./Gamma./sxp)^2;
%xi_n=(acen_n./Gamma./sxp)^2;
FF = sqrt(pi)*re*re*c*N*3600;
Tinvp = zeros(1,Nb_pts);
Tinvn = zeros(1,Nb_pts);

h = waitbar(0,sprintf('Computing: %2d %%',0), 'Name', 'Touschek lifetime');
for i=1:Nb_pts, % loop because of Cxi function
    Tinvp(i) = (FF*Cxi((acen_p(i)/Gamma/sxp(i))^2)/sxp(i) ...
        /Gamma^3/acen_p(i)^2/V(i));
    Tinvn(i) = (FF*Cxi((acen_n(i)/Gamma/sxp(i))^2)/sxp(i) ...
        /Gamma^3/acen_n(i)^2/V(i));
    waitbar(i/Nb_pts, h, sprintf('Computing progression: %3d %%', floor(i/Nb_pts*100)));
end
close(h);
   
% Local average lifetime
Tinv = (Tinvp+Tinvn)/2;

Tp=1./Tinvp;
Tn=1./Tinvn;
T =1./Tinv;

% Integration: Simpson method
s1=[0 ; s]; s2=[s ; 0]; ds=s2-s1;
Tousp=1/sum(1./Tp.*ds(1:end-1)')*s(end);
Tousn=1/sum(1./Tn.*ds(1:end-1)')*s(end);

Tous=2/(1/Tousp+1/Tousn);

%% plotsection

if DisplayFlag
    figure
    subplot(2,1,1)
    plot(s,Tp,'.-');
    grid on
    xlabel('s (m)')
    ylabel('Tp (h)')
    
    subplot(2,1,2)
    plot(s,Tn,'.-');
    grid on
    xlabel('s (m)')
    ylabel('Tn (h)')
    
    % Structure file 
    if FullMachineFlag
        files = fullfile(fileparts(which('naffgui')),'structure_nanoscopium');
    else
        files = fullfile(fileparts(which('naffgui')),'structure');
    end
    struc=dlmread(files);
    
    % artificial symmetry
    acen=acen*100;
    
    figure
    clf
    plot([sd(1:Nb_pts); 2*sd(Nb_pts)-sd(Nb_pts:-1:1)],[acen(1:Nb_pts) ; acen(Nb_pts:-1:1)],'b.-');
    hold on
    plot([sd(Nb_pts+1:end); 2*sd(end)-sd(end:-1:1+Nb_pts)],[acen(Nb_pts+1:end) ; acen(end:-1:Nb_pts+1)],'b.-');
    plot(struc(:,1),struc(:,2)/2,'k-')
    
    if FullMachineFlag
        axis([0 getcircumference -9 5])
    else
        axis([0 getcircumference/4 -9 5])
    end
    grid on
    title('SOLEIL')
    xlabel('s (m)')
    ylabel('Energy Acceptance \epsilon (%)')
end
