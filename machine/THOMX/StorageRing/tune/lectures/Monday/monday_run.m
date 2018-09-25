setpathspear3

% setpathasetorbitg ls
% setphysdata('BPMx','Offset',zeros(getFil  length(getx),1), getlist('BPMx'))
% setphysdata('BPMx','Golden',zeros(length(getx),1), getlist('BPMx'))
% setpathspear3
% % setpathals

%%
setsp('HCM',0)
rf0=getrf


%% 

%  Plot lattice (AT): 
intlat

%%

%  Plot the orbit with plotfamily (Middle Layer): 
plotfamily
%click the button "One Shot" to show the orbit, Use "Auto Scale" button to
%rescale the plots if necessary

%% correct the rf frequency
sp3v82
cspeed = 2.99792458e8;
harm = 372;
rf0 = getrf

rf = harm*cspeed/findspos(THERING,1+length(THERING))/1e6
steprf(rf-rf0);  %or setrf(rf)
% Update plotfamily

%%

%  Switch synchrotron radiation and RF cavity on & off (Middle Layer): 
	setcavity on;
	setradiation on;
% Update plotfamily

%%
    setcavity off;
	setradiation off;
	% Update plotfamily

%%
%  Change the first corrector magnet in sector 6 by 1 amp   (Middle Layer): 
	setsp('HCM', 1, [6 1]) ;
	setsp('VCM', 1, [6 1]);
	% Update plotfamily
%% correct the orbit
setorbitdefault
	% Update plotfamily

%% clear the orbit
setsp('HCM',0)

%% closed orbit bump
DetlaX = -1;
[OCS] = setorbitbump('BPMx', [3  6; 4, 1 ], [1 1]*DetlaX , 'HCM', [ -4 -3 -2 -1 1 2 3 4 ], 1, [], 'NoSetSP');
stepsp( OCS.CM.FamilyName, OCS.CM.Delta, OCS.CM.DeviceList );
	% Update plotfamily


%%    
% setsp('HCM',0)
%  Get the orbit, beta, and phase at all elements in the AT model (Middle Layer):
	[x, y, BPMs] = modeltwiss('ClosedOrbit');
	[BetaX, BetaY, BPMs] = modeltwiss('Beta');
	[MuX, MuY] = modeltwiss('Phase');

%  Plot the orbit vs. s-position:
	figure;
	a1 = subplot(2,1,1);
    set(gca,'FontSize',16)
	plot(BPMs, x*1000);
    xlabel('s (m)'); ylabel('x (mm)')
	a2 = subplot(2,1,2);
    set(gca,'FontSize',16)
	plot(BPMs, y*1000);
    xlabel('s (m)'); ylabel('y (mm)')
    linkaxes([a1,a2],'x')
    
%  Plot the orbit vs. phase
	figure;
	a1=subplot(2,1,1);
    set(gca,'FontSize',16)
	plot(MuX, x*1000);
     xlabel('\mu_x'); ylabel('x (mm)')
	a2=subplot(2,1,2);
    set(gca,'FontSize',16)
	plot(MuY, y);
     xlabel('\mu_y'); ylabel('y (mm)')

%  Plot nomalized orbit vs. phase
	figure;
	a1=subplot(2,1,1);
    set(gca,'FontSize',16)
	plot(MuX, x ./ sqrt(BetaX));
     xlabel('\mu_x'); ylabel('x/ \sqrt{\beta_x}')
	a2=subplot(2,1,2);
    set(gca,'FontSize',16)
	plot(MuY, y ./ sqrt(BetaY));
     xlabel('\mu_y'); ylabel('y/\sqrt{\beta_y} ')
     
%%  Plot the beta functions and dispersion functions  
    
figure
set(gca,'FontSize',16)
modelbeta
modelbeta('BPMx')
modelbeta('QF')

figure
set(gca,'FontSize',16)
modeldisp
modeldisp('BEND')

[FractionalTune, IntegerTune] = modeltune

%% 
%  Get closed orbit directly from AT: 
	help findorbit4
	global THERING
	x = findorbit4(THERING, 0.0, 1:length(THERING));
         s = findspos(THERING, 1:length(THERING));

%  Plot the orbit vs. s-position:
figure
	subplot(2,1,1);
    set(gca,'FontSize',16)
	plot(s, x(1,:));
       ylabel('x [meters]');
	subplot(2,1,2);
    set(gca,'FontSize',16)
	plot(s, x(2,:));
       ylabel('x''');

%  Get closed orbit at BPMs (AT): 
	BPMindex = findcells(THERING, 'FamName', 'BPM');
	BPM = findorbit4(THERING, 0.0, BPMindex);

%%   Put in a vertical orbit distortion 
setsp('VCM',0)    

% 
Y0 = getam('BPMy'); 
BPMindex=getlist('BPMy');	
% Create an Orbit Error
vcm = .5 * randn(56,1);     % 73 vertical correctors at the ALS
setsp('VCM', vcm);
% Get the vertical orbit
Y = getam('BPMy');	
plot(Y-Y0);hold on;

%%

% Get the Vertical response matrix from the model
Ry = getrespmat('BPMy', getlist('BPMy'), 'VCM');       % 57x56 matrix

%%
% Computes the SVD of the response matrix
Ivec = 1:48;
[U, S, V] = svd(Ry, 0);	
% Find the corrector changes use 48 singular values
DeltaAmps = -V(:,Ivec) * S(Ivec,Ivec)^-1 * U(:,Ivec)' *  (Y-Y0);
% Changes the corrector strengths 
stepsp('VCM', DeltaAmps);

% Get the vertical orbit
Y = getam('BPMy');	
plot(Y-Y0, 'r');	
%%
dia=diag(S);

figure
set(gca,'FontSize',16)
semilogy(dia./dia(1),'Linewidth',1.1)
xlabel('SV number'); ylabel('Log_{1o} SV_n/SV_1')

%%

setsp('VCM',0)    

Y0 = getam('BPMy'); 
BPMindex=getlist('BPMy');	

%%
vcm = zeros(56,1);
vcm(7) = 1;
setsp('VCM', vcm);
%setsp('VCM',1, [5 1]);

%%
% Create an Orbit Error
vcm = .5 * randn(56,1);  % ?????? Why 5 and not 12
setsp('VCM', vcm);

%%
% Get the vertical orbit	

Ry = getrespmat('BPMy', getlist('BPMy'), 'VCM');  %getrespmat     % 13x12 matrix

[U, S, V] = svd(Ry, 0);	
k = 1;
numSVvector = 1:2:56;

for ival = numSVvector
    Ivec = 1:ival;
    DeltaAmps = -V(:,Ivec) * S(Ivec,Ivec)^-1 * U(:,Ivec)' *  (Y-Y0);
    stepsp('VCM', DeltaAmps);
    Y = getam('BPMy');
    
    orbiterrorRMS(k) = std(Y-Y0);
    orbiterrorMAX(k) = max(abs(Y-Y0));
    
    totalcorstrength(k) = sum(abs(DeltaAmps));
    totalcorstrengtherror(k) = sum(abs(DeltaAmps + vcm));
    
    stepsp('VCM', -DeltaAmps);
    Y = getam('BPMy');
    k = k + 1;
    
end

%%
 figure(2)
 set(gca,'FontSize',16)
 plot(numSVvector, orbiterrorRMS,'Linewidth',1.2)
 ylabel('Orbit error RMS'); xlabel('Number of SV')

 figure(3)
 set(gca,'FontSize',16)
 plot(numSVvector, orbiterrorMAX,'Linewidth',1.1)
 ylabel('Orbit error MAX'); xlabel('Number of SV')

 figure(4)
 set(gca,'FontSize',16)
 plot(numSVvector, totalcorstrength,'Linewidth',1.1)
 ylabel('Total corrector strength'); xlabel('Number of SV')

 figure(5)
 set(gca,'FontSize',16)
 plot(numSVvector, totalcorstrengtherror,'Linewidth',1.1)
 ylabel('Total corrector strength + error'); xlabel('Number of SV')


%%

y = gety('struct');
vcm = getsp('VCM','struct');
setorbit('Golden', y, vcm, 10, 40, 'Display','Tolerance',1e-4);





