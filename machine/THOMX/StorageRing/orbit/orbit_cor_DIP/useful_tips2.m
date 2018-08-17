 %cd /exp/ThomX/Apps/MML_ThomX/
setpaththomx
thomxinit
clc
%%
CDR_017_072_r56_02_sx_Dff_corrSX_BPMIP

rf0=getrf


%% 

%  Plot lattice (AT): 
intlat

%%

%  Plot the orbit with plotfamily (Middle Layer): 
%plotfamily
plotorbit

%% correct the rf frequency
cspeed = 2.99792458e8;
harm = 30;
rf0 = getrf

rf = harm*cspeed/findspos(THERING,1+length(THERING))/1e6
steprf(rf-rf0);  %or setrf(rf)


%%
%  Change the first corrector magnet by 1 amp   (Middle Layer): 
	%setsp('HCOR', 1, [1 1]) ;
	setsp('VCOR', 1, [1 1]);
	% Update plotfamily
%% correct the orbit !!!!!!!!!!!!!!!Could not find the proper response matrix

setorbitdefault
	% Update plotfamily

%% clear the orbit
setsp('HCOR',0)
setsp('VCOR',0)

%% closed orbit bump  !!!!!!!!!Could not find the proper response matrix

DetlaX = -1;
[OCS] = setorbitbump('BPMx', [1  5; 1, 6 ], [1 1]*DetlaX , 'HCOR', [ -3 -2 -1 1 2 3], 1, [], 'NoSetSP');
stepsp( OCS.CM.FamilyName, OCS.CM.Delta, OCS.CM.DeviceList );


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
    
figure(1)
set(gca,'FontSize',16)
modelbeta
% modelbeta('BPMx','BPMz')
% modelbeta('QP1','QP2','QP3','QP4','QP31','QP41')

figure(2)
set(gca,'FontSize',16)
%modelbeta
modelbeta('BPMx','BPMz')
%modelbeta('QP1','QP2','QP3','QP4','QP31','QP41')

figure(3)
set(gca,'FontSize',16)
% modelbeta
% modelbeta('BPMx','BPMz')
modelbeta('QP1','QP2','QP3','QP4','QP31','QP41')

figure(4)
set(gca,'FontSize',16)
modeldisp
%modeldisp('BEND')

figure(5)
set(gca,'FontSize',16)
%modeldisp
modeldisp('BEND')

[FractionalTune, IntegerTune] = modeltune

%% 
%  Get closed orbit directly from AT: 
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

       figure
	subplot(2,1,1);
    set(gca,'FontSize',16)
	plot(s, x(2,:));
       ylabel('x [meters]');
	subplot(2,1,2);
    set(gca,'FontSize',16)
	plot(s, x(4,:));
       ylabel('x''');
       
       
%  Get closed orbit at BPMs (AT): 
	BPMindex = findcells(THERING, 'FamName', 'BPMx');
	BPM = findorbit4(THERING, 0.0, BPMindex);
    
   
    

%%   Put in a vertical orbit distortion 

setsp('VCOR',0)    

Y0 = getam('BPMz'); 
BPMindex=getlist('BPMz');	

% Create an Orbit Error
vcm = .00005 * randn(12,1);  % ?????? Why 5 and not 12
setsp('VCOR', vcm);
% Get the vertical orbit
Y = getam('BPMz');	
figure
plot(Y-Y0);hold on;

%%

% Get the Vertical response matrix from the model
%Ry = measrespmat('BPMz', getlist('BPMz'), 'VCOR');  %getrespmat     % 13x12 matrix
Ry = getrespmat('BPMz', getlist('BPMz'), 'VCOR');  %getrespmat     % 13x12 matrix
% Computes the SVD of the response matrix
%%
Ivec = 1:5;
[U, S, V] = svd(Ry, 0);	


%%
% Find the corrector changes use the singular values
DeltaAmps = -V(:,Ivec) * S(Ivec,Ivec)^-1 * U(:,Ivec)' *  (Y-Y0);
% Changes the corrector strengths 
stepsp('VCOR', DeltaAmps);
%%
% Get the vertical orbit
Y = getam('BPMz');	
plot(Y-Y0, 'r');	

%
Find responce bpm matrix
AO = getao;
R = measbpmresp('BPMx',AO.BPMx.DeviceList,'BPMz',AO.BPMz.DeviceList,'HCOR',AO.HCOR.DeviceList ,'VCOR',AO.VCOR.DeviceList ,'Model','Archive');

%%
AO = getao;
R = getrespmat('BPMx','HCOR');

%%
dia=diag(S);

figure(1)
set(gca,'FontSize',16)
semilogy(dia./dia(1),'Linewidth',1.1)
xlabel('SV number'); ylabel('Log_{1o} SV_n/SV_1')


%%

setsp('VCOR',0)    

Y0 = getam('BPMz'); 
BPMindex=getlist('BPMz');	

% Create an Orbit Error
vcm = .55 * randn(12,1);  % ?????? Why 5 and not 12
setsp('VCOR', vcm);
	

%%
vcm = zeros(12,1);
vcm(3) = 0.00005;
setsp('VCOR', vcm);
%setsp('VCM',1, [5 1]);

%%

% Get the vertical orbit
Y = getam('BPMz');	

Ry = getrespmat('BPMz', getlist('BPMz'), 'VCOR');  %getrespmat     % 13x12 matrix

[U, S, V] = svd(Ry, 0);	
k = 1;
numSVvector = 1:12;

for ival = 1:12
    Ivec = 1:ival;
    DeltaAmps = -V(:,Ivec) * S(Ivec,Ivec)^-1 * U(:,Ivec)' *  (Y-Y0);
    stepsp('VCOR', DeltaAmps);
    Y = getam('BPMz');
    
    orbiterrorRMS(k) = std(Y-Y0);
    orbiterrorMAX(k) = max(abs(Y-Y0));
    
    totalcorstrength(k) = sum(abs(DeltaAmps));
    totalcorstrengtherror(k) = sum(abs(DeltaAmps + vcm));
    
    stepsp('VCOR', -DeltaAmps);
    Y = getam('BPMz');
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

yy = gety('struct');
vcmm = getsp('VCOR','struct');
setorbit('Golden', yy, vcmm, 3, 10, 'Display');

%%

setsp('VCOR',0) 
setsp('HCOR',0)   

Y0 = getam('BPMz'); 
BPMindexz=getlist('BPMz');	

X0 = getam('BPMx'); 
BPMindexx=getlist('BPMx');

% Create an Orbit Error
% vcm = 1.25 * randn(12,1);  % ?????? Why 5 and not 12
% hcm = 2.35 * randn(12,1);  % ?????? Why 5 and not 12

vcm = zeros(12,1);  % ?????? Why 5 and not 12
hcm = zeros(12,1);  % ?????? Why 5 and not 12

setsp('VCOR', vcm);
setsp('HCOR', hcm);


 
%%

setphysdata('BPMx','Golden',getx('Struct'));
setphysdata('BPMz','Golden',getz('Struct'));

setfamilydata(getz, 'BPMz', 'Golden')
setfamilydata(getx, 'BPMx', 'Golden')

%%
T = ringpass(THERING, [0 0 0 0 0 0]', 2000);
plot(T(1,:),'.', 'Markersize',15)

