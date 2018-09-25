% Computerclass example for beam based diagnostics class at Annapolis,
% Maryland for Thursday, June 19, 2008
%
% Christoph Steier

% setup data structures, load lattice
setpaththomx%setpathals

% make global variable THERING available - it contains the lattice
% structure that is used by AT to simulate the machine and has been
% created by a subroutine of setpathals
global THERING

%% Starting condition for tracking (100 micron x, 100 micron y):
X0=[0.0001;0;0.0001;0;0;0];

% Track for 1024 turns:
X1=ringpass(THERING,X0,1024);

% Plot tracking results:
figure;subplot(2,1,1);plot(X1(1,:));subplot(2,1,2);plot(X1(3,:))

%% Calculate FFT:
fftx=abs(fft(X1(1,:)));
ffty=abs(fft(X1(3,:)));
% Frequency/Tune vector:
nu=[0:1023]/1023;
% Plot FFT (x/y) - tunes
ff=figure;subplot(2,1,1);plot(nu,fftx/max(fftx));hold on
subplot(2,1,2);plot(nu,ffty/max(ffty));hold on

%% Find tunes and print result to screen:
[maxx,kx]=max(fftx(2:512));
[maxy,ky]=max(ffty(513:end));
nux(1)=nu(kx+1);nuy(1)=nu(ky+512);
fprintf('nu_x = %g, nu_y = %g \n',nu(kx+1),nu(ky+512));

%% Plot in tunespace:
ff2 = figure;plot(nux,nuy,'o');axis([0 0.26 0 0.7]);hold on;

% Repeat with larger amplitude (1 mm x, 100 micron y):
X0=[0.001;0;0.0001;0;0;0];X1=ringpass(THERING,X0,1024);
fftx=abs(fft(X1(1,:)));ffty=abs(fft(X1(3,:)));
figure(ff);subplot(2,1,1);plot(nu,fftx/max(fftx),'r');
subplot(2,1,2);plot(nu,ffty/max(ffty),'r')
[maxx,kx]=max(fftx(2:512));[maxy,ky]=max(ffty(513:end));
nux(2)=nu(kx+1);nuy(2)=nu(ky+512);
fprintf('nu_x = %g, nu_y = %g \n',nu(kx+1),nu(ky+512));

figure(ff2);plot(nux,nuy,'ro');axis([0 0.26 0 0.7]);

%% Repeat again with larger amplitude (5 mm x, 100 micron y)
% tuneshift with amplitude in the simplest case scales like initial position^2:

X0=[0.005;0;0.0001;0;0;0];
X1=ringpass(THERING,X0,1024);
fftx=abs(fft(X1(1,:)));ffty=abs(fft(X1(3,:)));
figure(ff);subplot(2,1,1);plot(nu,fftx/max(fftx),'g');
subplot(2,1,2);plot(nu,ffty/max(ffty),'g');
[maxx,kx]=max(fftx(2:512));[maxy,ky]=max(ffty(513:end));
nux(3)=nu(kx+1);nuy(3)=nu(ky+512);
fprintf('nu_x = %g, nu_y = %g \n',nu(kx+1),nu(ky+512));
figure(ff2);plot(nux,nuy,'o');axis([0 0.26 0 0.21]);

%% Now with even larger horizontal amplitude (10 mm x, 100 mciron y):
X0=[0.01;0;0.0001;0;0;0];
X1=ringpass(THERING,X0,1024);
fftx=abs(fft(X1(1,:)));ffty=abs(fft(X1(3,:)));
figure(ff);subplot(2,1,1);plot(nu,fftx/max(fftx),'m');
subplot(2,1,2);plot(nu,ffty/max(ffty),'m');
[maxx,kx]=max(fftx(2:512));[maxy,ky]=max(ffty(513:end));
nux(4)=nu(kx+1);nuy(4)=nu(ky+512);
fprintf('nu_x = %g, nu_y = %g \n',nu(kx+1),nu(ky+512));
figure(ff2);plot(nux,nuy,'o');axis([0 0.26 0 0.21]);

%% To show how the tuneshift with amplitude together with the finite
% beamsize will create decoherence of the coherent bunch oscillations, 
% we track an ensemble of particles (100 particles for 100 turns):
%
% Initial conditions (100 random coordinates with 300 micron horizontal
% beamsize, 20 micron vertical beamsize and corresponding divergences
% ALS, 1.9 GeV, insertion device straights, plus 1 mm x-offset)
X0 = [300e-6*randn(1,100)+1.0e-3;300e-6/13.5*randn(1,100); ...
20e-6*randn(1,100)+1.0e-3;20e-6/3.65*randn(1,100); ...
zeros(1,100);zeros(1,100)];

%% Track for 100 turns, use 'reuse' flag to speed up tracking
% (can be used if lattice does not change, after every change of a
% lattice parameters, one has to track at least once without the 'reuse' flag):
X1=ringpass(THERING,X0,100,'reuse');
% Bring matrices into the right shape (we are only interested in x-x' phasespace):
x=reshape(X1(1,:),100,100);xp=reshape(X1(2,:),100,100);

%% Plot results (upper plot shows x-x' phasespace, lower plot beam center):
f1=figure;figure(f1);subplot(2,1,1);plot(X0(1,:),X0(2,:),'.');
axis([min(min(x)) max(max(x)) min(min(xp)) max(max(xp))]);

subplot(2,1,2);plot(0,mean(X0(1,:)),'.');
axis([0 length(x) min(min(x)) max(max(x))]);hold on;

%% Now plot information turn-by-turn (movie):
for loop=1:100
figure(f1);subplot(2,1,1);plot(x(:,loop),xp(:,loop),'.');
axis([min(min(x)) max(max(x)) min(min(xp)) max(max(xp))]);
subplot(2,1,2);plot(loop,mean(x(:,loop)),'.');
pause(0.5)
end

%% At this amplitude (1 mm) one hardly sees any decoherence

% Now we repeat this with another 100 random particles with
% the same beamsize, but a 5 mm x-offset:
X0 = [300e-6*randn(1,100)+5.0e-3;300e-6/13.5*randn(1,100); ...
20e-6*randn(1,100)+1.0e-3;20e-6/3.65*randn(1,100); ...
zeros(1,100);zeros(1,100)];
X1=ringpass(THERING,X0,100,'reuse');
x=reshape(X1(1,:),100,100);xp=reshape(X1(2,:),100,100);
f1=figure;figure(f1);subplot(2,1,1);plot(X0(1,:),X0(2,:),'.');
axis([min(min(x)) max(max(x)) min(min(xp)) max(max(xp))]);

subplot(2,1,2);plot(0,mean(X0(1,:)),'.');
axis([0 length(x) min(min(x)) max(max(x))]);hold on;
for loop=1:100
figure(f1);subplot(2,1,1);plot(x(:,loop),xp(:,loop),'.');
axis([min(min(x)) max(max(x)) min(min(xp)) max(max(xp))]);
subplot(2,1,2);plot(loop,mean(x(:,loop)),'.');
pause(0.5)
end

% The decoherence is visible, the particles with small amplitudes
% complete little over � additional rotation in phasespace, compared
% to the ones with large amplitude.

%% Now we repeat this with another 500 random particles with 
% the same beamsize, but an 11 mm x-offset:
X0 = [300e-6*randn(1,500)+11.0e-3;300e-6/13.5*randn(1,500); ...
20e-6*randn(1,500)+1.0e-3;20e-6/3.65*randn(1,500); ...
zeros(1,500);zeros(1,500)];
X1=ringpass(THERING,X0,100,'reuse');
x=reshape(X1(1,:),500,100);xp=reshape(X1(2,:),500,100);

f1=figure;figure(f1);subplot(2,1,1);plot(X0(1,:),X0(2,:),'.');
axis([min(min(x)) max(max(x)) min(min(xp)) max(max(xp))]);
subplot(2,1,2);plot(0,mean(X0(1,:)),'.');
axis([0 size(x,2) min(min(x)) max(max(x))]);hold on;
for loop=1:100
figure(f1);subplot(2,1,1);plot(x(:,loop),xp(:,loop),'.');
axis([min(min(x)) max(max(x)) min(min(xp)) max(max(xp))]);
subplot(2,1,2);plot(loop,mean(x(:,loop)),'.');
pause(0.5);
end

% The decoherence is fairly strong, the particles with small amplitudes
% complete more than one additional rotation in phasespace, compared to
% the ones with large amplitude, the oscillation amplitude of the beam 
% centroid got much smaller. Even though there is no damping in the simulation, 
% the particle seem to follow a spiral, which is created by the fact that 
% particles with smaller amplitudes (in the ALS) have a higher tune.

%% Now to illustrate, how a single machine error can significantly change 
% the nonlinear dynamica, we put one gradient and one skew gradient error 
% into our model machine:
qf=getsp('QP1',[1 1]);
setsp('QP1',qf*1.01,[1 1]);
sqsf=getsp('QP3',[1 6]);
setsp('QP3',sqsf+0.01,[1 6]);

%% And we track again with the same particle distribution and 11 mm x-offset:
X0 = [300e-6*randn(1,500)+11.0e-3;300e-6/13.5*randn(1,500); ...
20e-6*randn(1,500)+1.0e-3;20e-6/3.65*randn(1,500); ...
zeros(1,500);zeros(1,500)];
% Now one first has to track once (for one turn) without the 'reuse' 
% flag (we changed some magnet strengths:
X1=ringpass(THERING,X0,1);
X1=ringpass(THERING,X0,100,'reuse');
x=reshape(X1(1,:),500,100);xp=reshape(X1(2,:),500,100);
f1=figure;figure(f1);subplot(2,1,1);plot(X0(1,:),X0(2,:),'.');
axis([min(min(x)) max(max(x)) min(min(xp)) max(max(xp))]);
subplot(2,1,2);plot(0,mean(X0(1,:)),'.');
axis([0 size(x,2) -0.015 0.015]);hold on;
for loop=1:100
figure(f1);subplot(2,1,1);plot(x(:,loop),xp(:,loop),'.');
axis([-0.015 0.015 -0.001 0.001]);
ind = find(~isnan(x(:,loop)));
subplot(2,1,2);plot(loop,mean(x(ind,loop)),'.');
pause(0.5);
end

% The machine errors created a resonance which actually captures part
% of the particle distribution in a resonance island and therefore 
% causes some coherent signal to reappear, after it first washes out
% completely

% Just in case you want to continue doing something else, 
% remove the error from the lattice:
setpv('QP1',qf,[1 1]);
setpv('QP3',sqsf,[1 6]);




