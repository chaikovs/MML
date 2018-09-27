
%% List of beamlines
% Alex add divergence sept 2014 and skip ohmienvelope 

% Index showing the kind of beamlines/diag
% 1 : diagnostics
% 2 : scrapers
% 3 : bending magnet source
% 4 : undulator source
% 5 : wiggler source
% 6 : IR beamline

data = { 
'HSCRAP_int' 2
'HSCRAP_ext' 2
'VSCRAP' 2
'MRSV' 1
'ODE'  3
'SMIS' 6 
'PHC1' 1
'AILES' 6
'MARS' 3
'DISCO' 3
'PHC2' 1
'METRO' 3 
'SAMBA' 3 
'ROCK' 3
'DIFFABS'  3 
'INSTAB'  1 
'PSICHE'  5 
'PLEIADES_1' 4
'PLEIADES_2' 4 
'DESIRS' 4 
'PUMA' 5 
'CRISTAL' 4 
'DEIMOS_1' 4 
'DEIMOS_2' 4 
'GALAXIES' 4
'TEMPO_1' 4 
'TEMPO_2' 4 
'HERMES_1' 4 
'HERMES_2' 4 
'PX1' 4 
'PX2sp' 4 
'SWING' 4 
'ANTARES_1' 4 
'ANTARES_2' 4 
'ANATOMIX' 4 
'NANOSCOPIUM' 4 
'SEXTANTS_1' 4 
'SEXTANTS_2' 4
'SIXS' 4 
'CASSIOPEE_1' 4 
'CASSIOPEE_2' 4 
'SIRIUS' 4 
'LUCIA' 4 
};

REFPTS=cell(size(data,1),1);
Index = ones(size(data,1),1)*0;

for k = 1: length(data)
    REFPTS{k} = data{k,1};
    Index(k) = data{k,2};
end

%% get beamsizes and optical functions

global THERING
ATi=atindex;
[Tilt, Eta, Ratio, ENV, DP, DL, EPS] = calccoupling;
sigmas = cat(2, ENV.Sigma);
A=cat(3,ENV.R);  % add divergence from ENV.R
sigmaps=sqrt([A(2,2,:) ; A(4,4,:)]);
TD = twissring(THERING,0,1:(length(THERING)+1),'chrom');
beta = cat(1,TD.beta);
alpha = cat(1,TD.alpha);
gamma = (1+alpha.^2)./beta;% add gamma
Dispersion = cat(1,TD.Dispersion);

BeamLineStructure = struct([]);
    
for k=1:length(REFPTS) ; % each beamline
    BeamLineStructure(k).position   = findspos(THERING,ATi.(REFPTS{k}));   % s position of the beamline source point
    BeamLineStructure(k).name       = REFPTS{k};                            % name of the beam line
    % ohmienvelope seems to return complex when very close to zero, then use abs value
    BeamLineStructure(k).x          = 1e6*abs(sigmas(1,ATi.(REFPTS{k})));  % H beam size in �m
    BeamLineStructure(k).y          = 1e6*abs(sigmas(2,ATi.(REFPTS{k})));  % V beam size in �m
    BeamLineStructure(k).xp         = 1e6*abs(sigmaps(1,ATi.(REFPTS{k})));  % H beam divergence in �rad
    BeamLineStructure(k).yp         = 1e6*abs(sigmaps(2,ATi.(REFPTS{k})));  % V beam divergence in �rad
    BeamLineStructure(k).betax      = beta(ATi.(REFPTS{k}),1);  % 
    BeamLineStructure(k).betaz      = beta(ATi.(REFPTS{k}),2);   % 
    BeamLineStructure(k).etax       = Dispersion(4 * (ATi.(REFPTS{k}) - 1) + 1);  % 
    BeamLineStructure(k).etaxp      = Dispersion(4 * (ATi.(REFPTS{k}) - 1) + 2);   % 
    BeamLineStructure(k).etaz       = Dispersion(4 * (ATi.(REFPTS{k}) - 1) + 3); % 
    BeamLineStructure(k).etazp      = Dispersion(4 * (ATi.(REFPTS{k}) - 1) + 4);   % 
    BeamLineStructure(k).alphax     = alpha(ATi.(REFPTS{k}),1);  % 
    BeamLineStructure(k).alphaz     = alpha(ATi.(REFPTS{k}),2);   % 
    BeamLineStructure(k).gammax     = gamma(ATi.(REFPTS{k}),1);  % 
    BeamLineStructure(k).gammaz     = gamma(ATi.(REFPTS{k}),2);   %  
end

%% Open an output file for saving beamsizes and optical functions

DirStart = pwd;

filename = 'BeamSizeAtSourcePoint.txt'  ;       
fid = fopen(filename, 'w');
% fprintf(fid, ['BeamLineName     Long_Position(m)    RMS_H_Size(microm)    RMS_V_Size(microm) \n'],BeamLineStructure(j).position,BeamLineStructure(j).x,BeamLineStructure(j).y); 
fprintf(fid, ['BeamLineName     Long_Position(m)    RMS_H_Size(microm)    RMS_V_Size(microm)    RMS_H_div(microm)    RMS_V_div(microm)      betaX(m)   betaZ(m)   etax(m)   etaxp(-)   etaz(m)   etazp(m)   alphax(-)   alphaz(-) \n']); 

%% Plot beam sizes at source points and fill the file

for j= 1:length(REFPTS)
    pos(j) = BeamLineStructure(j).position;
    x(j) = BeamLineStructure(j).x;
    y(j) = BeamLineStructure(j).y;
    fprintf(fid, ['%15s     %10.4f      %6.1f      %6.1f       %6.1f      %6.1f    %10.4f      %10.4f     %10.4f  %10.4f      %10.4f     %10.4f  %10.4f      %10.4f  \n'],...
        BeamLineStructure(j).name, ...
        BeamLineStructure(j).position,BeamLineStructure(j).x,BeamLineStructure(j).y,...
        BeamLineStructure(j).xp,BeamLineStructure(j).yp,...
        BeamLineStructure(j).betax,BeamLineStructure(j).betaz,BeamLineStructure(j).etax,...
        BeamLineStructure(j).etaxp,BeamLineStructure(j).etaz,BeamLineStructure(j).etazp,...
        BeamLineStructure(j).alphax,BeamLineStructure(j).alphaz)        ; 
end

SourcePointkind = 1:max(Index);
ind=cell(size(data,1),length(SourcePointkind),length(SourcePointkind));
PlotMarker = { '+','*','d','o','s','h'};
PlotColor = {'w','b','k','m','r','g'};
PlotColor = {'w','b','w','c','y','m'};
% 1 : diagnostics
% 2 : scrapers
% 3 : bending magnet source
% 4 : undulator source
% 5 : wiggler source
% 6 : IR beamline


for ikind = 1:max(SourcePointkind)
   [i j] =  find(Index==ikind) ;
   ind{ikind,1} = i   ;
   ind{ikind,2} = PlotMarker{ikind}  ;
   ind{ikind,3} = PlotColor{ikind}  ;
end

xlab = 'Longitudinal position (m)';
L = getcircumference;

ylab = 'RMS H beam size (�m) ';
titre = 'Horizontal Beam size at Source Points ';
figure(40) ; 
h1 = subplot(4,1,1:3);
for ikind = 1:max(SourcePointkind)
    hold on
    plot(pos(ind{ikind,1}),x(ind{ikind,1}) , ind{ikind,2} ,'MarkerFaceColor',ind{ikind,3},'MarkerSize',12)
end
%hold on ; plot(pos, y , 'bo')
set(gca,'FontSize',14)
ylabel(ylab); title(titre)
xlim([0 L]);
h2 = subplot(4,1,4);drawlattice;ylim([-3 3]);
linkaxes([h1 h2],'x')
set(gca,'FontSize',14)

ylab = 'RMS V beam size (�m) ';
titre = 'Vertical Beam size at Source Points ';
figure(50) ; 
h1 = subplot(4,1,1:3);
for ikind = 1:max(SourcePointkind)
    hold on
    plot(pos(ind{ikind,1}),y(ind{ikind,1}) , ind{ikind,2} ,'MarkerFaceColor',ind{ikind,3},'MarkerSize',12)
end
%hold on ; plot(pos, y , 'bo')
set(gca,'FontSize',14)
ylabel(ylab); title(titre)
xlim([0 L]);
h2 = subplot(4,1,4);drawlattice;ylim([-3 3]);
linkaxes([h1 h2],'x')
set(gca,'FontSize',14)


%% Close the file

fclose(fid);
cd(DirStart)

