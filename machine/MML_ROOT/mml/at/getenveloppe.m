%%
solamor2
BENDINDEX = findcells(THERING,'PassMethod','BndMPoleSymplectic4RadPass');
QUADSEXTINDEX = findcells(THERING,'PassMethod','StrMPoleSymplectic4RadPass');
RADELEMINDEX = sort([BENDINDEX QUADSEXTINDEX]);

%% Set tilt error
% Find  indexes of elements in different families 
Q1I = findcells(THERING,'FamName','Q1');
% Select some of them to randomly tilt
TILTI = Q1I;

% NOTE: How to introduce random coupling and misalignment errors:
% s-rotations(tilts) and transverse displacements (shifts)

% 1.generate random  rotations 
tilterr = 0.2*pi/180;			% RMS tilt error [radians]
qftilts = tilterr*randn(1,length(TILTI));

% 2. rotate elements
settilt(TILTI,qftilts);

%%
[ENV, DP, DL] = ohmienvelope(THERING,RADELEMINDEX, 1:length(THERING)+1)

%%
sigmas = cat(2,ENV.Sigma);
tilt = cat(2,ENV.Tilt);
spos = findspos(THERING,1:length(THERING)+1);

figure(1)
plot(spos,tilt*180/pi,'.-')
set(gca,'XLim',[0 spos(end)])
title('Rotation angle of the beam ellipse [degrees]');
xlabel('s - position [m]');
grid on

figure(2)
[A, H1, H2] = plotyy(spos,sigmas(1,:)*1e6,spos,sigmas(2,:)*1e6);

set([H1 H2],'Marker','.')
set(A,'XLim',[0 spos(end)])
title('Principal axis of the beam ellipse [m]');
xlabel('s - position [m]');
grid on
ylabel('Sigma (um)')
%%
[TD, tune] = twissring(THERING,0,1:length(THERING)+1,'chroma');
ETA        = cat(2,TD.Dispersion);
BETA       = cat(1,TD.beta)';

emittancex = (power(sigmas(1,:),2)-power(DP*ETA(1,:),2))./BETA(1,:);
emittancez = (power(sigmas(2,:),2)-power(DP*ETA(3,:),2))./BETA(2,:);
%%
figure
[A, H1, H2] = plotyy(spos,emittancex,spos,emittancez);
grid on
set(A,'XLim',[0 spos(end)])

%% couplying end emittance at lattice entrance
fprintf('Ex = %4.2g m.rad \n',emittancex(1));
fprintf('Ez = %4.2g m.rad \n',emittancez(2));
fprintf('Coupling = %4.2g %% \n',emittancez(1)/emittancex(2)*100)
