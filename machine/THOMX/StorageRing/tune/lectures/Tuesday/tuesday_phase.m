%% 
% addpath c:\USPAS\BBDiag\Release\mml
% setpathspear3

%% 
%  Plot the beta function and phase advance for the  
%  nominal model and a model with a gradient error
%addpath c:\USPAS\BBDiag\Release\mml
%  Get beta & phase at all elements in the AT model (Middle Layer):
	Tune0 = gettune;
	[BetaX0, BetaY0, s] = modeltwiss('Beta');
	[MuX0, MuY0] = modeltwiss('Phase');

%  Plot beta vs. position
	figure(1); clf;
	subplot(2,2,1); plot(MuX0, BetaX0, 'b'); ylabel('Beta X');
	subplot(2,2,3); plot(MuY0, BetaY0, 'b'); ylabel('Beta Y');
	subplot(2,2,2); plot(MuX0(1:end-1), diff(MuX0)/(2*pi) , 'b'); ylabel('\Delta Phase X');
	subplot(2,2,4); plot(MuY0(1:end-1), diff(MuY0)/(2*pi) , 'b'); ylabel('\Delta Phase Y');

%% 
%  Perturb the lattice at 1 quadrupole, QF(7,1)
	qf = getsp('QP1', [1 1]);
	setsp('QP1', 1.05*qf, [1 1]);

%  Get and plot beta for the perturbed lattice
	Tune1 = gettune;
	[x1, y1] = modeltwiss('ClosedOrbit');
	[BetaX1, BetaY1] = modeltwiss('Beta');
	[MuX1, MuY1] = modeltwiss('Phase');
    
%  Add the perturbed beta to figure(1)
	figure(1);
	a1=subplot(2,2,1); hold on;
	plot(MuX0, BetaX1, 'r');
    legend('no quad error','with quad error');
    xlabel('\mu_x [2\pi]');ylabel('\beta_x');
	a2=subplot(2,2,3); hold on; 
	plot(MuY0, BetaY1, 'r');
    xlabel('\mu_y [2\pi]');ylabel('\beta_y');
	a3=subplot(2,2,2); hold on; 
	plot(MuX0(1:end-1), diff(MuX1)/(2*pi) , 'r');
    xlabel('\mu_x [2\pi]');ylabel('\Delta \mu_x');
	a4=subplot(2,2,4); hold on; 
	plot(MuY0(1:end-1), diff(MuY1)/(2*pi) , 'r');
    xlabel('\mu_y [2\pi]');ylabel('\Delta \mu_y');    
    linkaxes([a1,a2,a3,a4]','x')
%  Plot beta beat
	figure(2);
	a1=subplot(2,2,1); 
	plot(s, BetaX1./BetaX0-1);
	xlabel('s [m]');ylabel('\Delta \beta_x/\beta_x')
	title('Beta Beat from the Nominal Model');
	a2=subplot(2,2,2); 
	plot(s, BetaY1./BetaY0-1);
	xlabel('s [m]');ylabel('\Delta \beta_y/\beta_y')
	a3=subplot(2,2,3); 
	plot(MuX0, BetaX1./BetaX0-1);
	xlabel('\mu_x [2\pi]');ylabel('\Delta \beta_x/\beta_x')
	a4=subplot(2,2,4); 
	plot(MuY0, BetaY1./BetaY0-1);clc
	xlabel('\mu_y [2\pi]');ylabel('\Delta \beta_y/\beta_y')
    linkaxes([a1,a2]','x')

%  Restore the lattice
	setsp('QP1', qf, [1 1]);

%%  Simulate a phase advance measurement

%  Get the orbit, beta, and phase at all elements in the AT model (Middle Layer):
	Tune0 = gettune;
	[BetaX0, BetaY0, s] = modeltwiss('Beta', 'BPMx');
	[MuX0, MuY0] = modeltwiss('Phase', 'BPMx');
%save optics_base MuX0 MuY0 BetaX0 BetaY0 s Tune0

%  Starting condition or tracking (0.1mm) 
	X0 = [0.0001; 0; 0.0001; 0; 0; 0];
%  Track for 1024 turns
	global THERING
    
	X1 = ringpass(THERING, X0, 1024);
	size(X1)
%  Track coordinates for every turn along the ring (to all BPMs)
	%BPMindex = findcells(THERING, 'FamName', 'BPM');
    BPMindex = family2atindex('BPMx',getlist('BPMx'));
	BPM = findorbit4(THERING, 0.0, BPMindex);
	X2 = linepass(THERING, X1, BPMindex);
	size(X2)
%  Recover matrix structure (turns x BPM#):
	BPMx = reshape(X2(1,:), 1024, length(BPMindex));
	size(BPMx)
	BPMy = reshape(X2(3,:), 1024, length(BPMindex));

%save data_noqerr_nonoise BPMx BPMy

%%  Plot some results:
	figure(1);subplot(2,1,1); plot(BPMy(1,:)); subplot(2,1,2); plot(BPMy(:,1));

    %  Calculate fractional tunes (interpolating FFT, sine window)
	[nux, nuy, ax, ay] = findfreq(BPMx, BPMy)

% Calculate phase at every BPM 
% (integral convolution with sine and cosine trajectories)
[MuX, MuY] = calcphase(nux, nuy, BPMx, BPMy);
%  Calcphase asks for a frequency, typically just accepting 
%   the precalculated result is fine.

%  Compare the 'measured' phase advance with the computed nominal one.
DeltaMuX = MuX(:)-MuX0/(2*pi);
DeltaMuY = MuY(:)-MuY0/(2*pi);

figure(102);clf
subplot(2,1,1);
plot(MuX0, DeltaMuX-DeltaMuX(1), '.-b') ;
subplot(2,1,2);
plot(MuY0, DeltaMuY-DeltaMuY(1), '.-b');

%% Add noise to the BPM data and recalculation the phase
	BPMxNoise = BPMx + 5e-6*randn(size(BPMx));
	BPMyNoise = BPMy + 5e-6*randn(size(BPMy));

%  Calculate fractional tunes (interpolating FFT, sine window)
	[nux, nuy, ax, ay] = findfreq(BPMxNoise , BPMyNoise)

% Calculate phase at every BPM 
% (integral convolution with sine and cosine trajectories)
[MuXnoise, MuYnoise] = calcphase(nux, nuy, BPMxNoise, BPMyNoise)
%  Calcphase asks for a frequency, typically just accepting 
%   the precalculated result is fine.

%  Compare the 'measured' phase advance with the computed nominal one.
DeltaMuX = MuXnoise(:)-MuX0/(2*pi);
DeltaMuY = MuYnoise(:)-MuY0/(2*pi);

figure(102);
subplot(2,1,1); hold on;
plot(MuX0, DeltaMuX-DeltaMuX(1), '.-r') ;
xlabel('Phase X'); ylabel('\Delta phase X');
subplot(2,1,2); hold on;
plot(MuY0, DeltaMuY-DeltaMuY(1), '.-r');
xlabel('Phase Y'); ylabel('\Delta phase Y');

%save data_noqerr_noise BPMx BPMy

%% Now put a quadrupole error in the lattice and repeat
steppv('QP1',1,[1 1]);
	Tuneq = gettune;
	[BetaXq, BetaYq, s] = modeltwiss('Beta', 'BPMx');
	[MuXq, MuYq] = modeltwiss('Phase', 'BPMx');
%save optics_qerr MuXq MuYq BetaXq BetaYq s Tuneq
figure(102);
subplot(2,1,1); hold on;
plot(MuX0, (MuXq-MuXq(1)-MuX0+MuX0(1))/2/pi,'k');
xlabel('Phase X'); ylabel('\Delta phase X');

subplot(2,1,2); hold on;
plot(MuY0, (MuYq-MuYq(1)-MuY0+MuY0(1))/2/pi,'k');
xlabel('Phase Y'); ylabel('\Delta phase Y');

%% 
%  Track for 1024 turns
	X1 = ringpass(THERING, X0, 1024);
%  Track coordinates for every turn along the ring (to all BPMs)
	X2 = linepass(THERING, X1, BPMindex);
%  Recover matrix structure (turns x BPM#):
	BPMx = reshape(X2(1,:), 1024, length(BPMindex));
	BPMy = reshape(X2(3,:), 1024, length(BPMindex));
%Add noise to the BPM data and recalculation the phase
	BPMxNoise = BPMx + 5e-6*randn(size(BPMx));
	BPMyNoise = BPMy + 5e-6*randn(size(BPMy));
%  Calculate fractional tunes (interpolating FFT, sine window)
	[nux, nuy, ax, ay] = findfreq(BPMxNoise , BPMyNoise)
% Calculate phase at every BPM 
% (integral convolution with sine and cosine trajectories)
[MuXnoise, MuYnoise] = calcphase(nux, nuy, BPMxNoise, BPMyNoise)
%  Calcphase asks for a frequency, typically just accepting 
%   the precalculated result is fine.
%  Compare the 'measured' phase advance with the previous results.
DeltaMuX = MuXnoise(:)-MuX0/(2*pi);
DeltaMuY = MuYnoise(:)-MuY0/(2*pi);
figure(102);
subplot(2,1,1); hold on;
plot(MuX0, DeltaMuX-DeltaMuX(1),'.-g');
xlabel('Phase X'); ylabel('\Delta phase X');
title('Phase: Measured - actual')
legend('noise free','with noise','quad err actual','noise+quad error')

subplot(2,1,2); hold on;
plot(MuY0, DeltaMuY-DeltaMuY(1),'.-g');
xlabel('Phase Y'); ylabel('\Delta phase Y');
steppv('QP1',-1,[1 1]);

%save data_quaderr_noise BPMx BPMy

   