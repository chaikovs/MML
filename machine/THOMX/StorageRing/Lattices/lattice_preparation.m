
clear all; close all; clc;

%% Bare lattice preparation

% ring_woErr = ThomX_017_064_r56_02_chro11();
% 
% bare_lattice = atsetfieldvalues(ring_woErr,findcells(ring_woErr,'FamName','SX1'), 'PolynomB',{1,3},0);
% bare_lattice = atsetfieldvalues(bare_lattice,findcells(bare_lattice,'FamName','SX2'), 'PolynomB',{1,3},0);
% bare_lattice = atsetfieldvalues(bare_lattice,findcells(bare_lattice,'FamName','SX3'), 'PolynomB',{1,3},0);
% 
% bare_lattice = atsetfieldvalues(bare_lattice,findcells(bare_lattice,'FamName','QP1'), 'PolynomB',{1,2},0);
% bare_lattice = atsetfieldvalues(bare_lattice,findcells(bare_lattice,'FamName','QP2'), 'PolynomB',{1,2},0);
% bare_lattice = atsetfieldvalues(bare_lattice,findcells(bare_lattice,'FamName','QP3'), 'PolynomB',{1,2},0);
% bare_lattice = atsetfieldvalues(bare_lattice,findcells(bare_lattice,'FamName','QP4'), 'PolynomB',{1,2},0);
% bare_lattice = atsetfieldvalues(bare_lattice,findcells(bare_lattice,'FamName','QP31'), 'PolynomB',{1,2},0);
% bare_lattice = atsetfieldvalues(bare_lattice,findcells(bare_lattice,'FamName','QP11'), 'PolynomB',{1,2},0);


%  save('ThomX_017_064_r56_02_chro11_bareSext','bare_lattice')
% save('ThomX_017_064_r56_02_chro11_bare','bare_lattice')



%% Initial lattices


% load lattice
ring_woErr = ThomX_017_064_r56_02_chro11();
ring = ThomX_017_064_r56_02_chro11_multip();


indHCor=find(atgetcells(ring,'FamName','HCOR'));
indVCor=find(atgetcells(ring,'FamName','VCOR'));
indQCor=find(atgetcells(ring,'FamName','Quadrupole'));
indm=find(atgetcells(ring,'FamName','BPMx'));

ring_woErr=atsetfieldvalues(ring_woErr,indHCor,'PassMethod','StrMPoleSymplectic4Pass');
ring_woErr=atsetfieldvalues(ring_woErr,indVCor,'PassMethod','StrMPoleSymplectic4Pass');

ring=atsetfieldvalues(ring,indHCor,'PassMethod','StrMPoleSymplectic4Pass');
ring=atsetfieldvalues(ring,indVCor,'PassMethod','StrMPoleSymplectic4Pass');

r0=ring;

thomx_ring = ring;

 
 %% define apertures
 
Xapert=0.04*ones(size(thomx_ring));
Yapert=0.028*ones(size(thomx_ring));
thomx_ring=SetPhysicalAperture(thomx_ring,Xapert/2,Yapert/2);

atplot(thomx_ring,@plotAperture); 
 

%% Error set

% dx_dipole = 30e-6; %100*1e-6;
% dy_dipole = 30e-6;%100*1e-6;
% ds_dipole = 30e-6;%100*1e-6;
% tilt_dipole = 200e-6;%500*1e-6;
% dkk_dipole = 1e-3;%5e-3;%1.2e-3;
% 
% dx_quad = 30e-6;%100*1e-6;
% dy_quad = 30e-6;%100*1e-6;
% ds_quad = 30e-6;%100*1e-6;
% tilt_quad = 200e-6;%500*1e-6;
% dkk_quad= 1e-3;%5e-3;
% 
% dx_sext = 30e-6;%100*1e-6;
% dy_sext = 30e-6;%100*1e-6;
% ds_sext = 30e-6;%100*1e-6;
% tilt_sext = 200e-6;%500*1e-6;
% dkk_sext= 1e-3;%5e-3;

dx_dipole = 100*1e-6;
dy_dipole = 100*1e-6;
ds_dipole = 100*1e-6;
tilt_dipole = 500*1e-6;
dkk_dipole = 5e-3;%1.2e-3;

dx_quad =  100*1e-6;%100*1e-6;
dy_quad =  100*1e-6;%100*1e-6;
ds_quad =  100*1e-6;%100*1e-6;
tilt_quad = 500*1e-6;%500*1e-6;
dkk_quad= 5e-3;

dx_sext = 100*1e-6;
dy_sext = 100*1e-6;
ds_sext = 100*1e-6;
tilt_sext = 500*1e-6;
dkk_sext= 5e-3;


ie=1;

%dipoles
inds=findcells(r0,'Class','bend');
errstruct(ie).indx=inds;
errstruct(ie).type='psi'; % roll
errstruct(ie).sigma=tilt_dipole;
ie=ie+1;
errstruct(ie).indx=inds;
errstruct(ie).type='x'; 
errstruct(ie).sigma=dx_dipole;
ie=ie+1;
errstruct(ie).indx=inds;
errstruct(ie).type='y'; 
errstruct(ie).sigma=dy_dipole;
ie=ie+1;
errstruct(ie).indx=inds;
errstruct(ie).type='s'; 
errstruct(ie).sigma=ds_dipole;
ie=ie+1;

errstruct(ie).indx=inds;
errstruct(ie).type='dpb1'; 
errstruct(ie).sigma=dkk_dipole;
ie=ie+1;

% Quadrupoles
indqm=[findcells(r0,'Class','Quadrupole')];
errstruct(ie).indx=indqm;
errstruct(ie).type='psi'; % roll
errstruct(ie).sigma=tilt_quad;
ie=ie+1;
errstruct(ie).indx=indqm;
errstruct(ie).type='x';
errstruct(ie).sigma=dx_quad;
ie=ie+1;
errstruct(ie).indx=indqm;
errstruct(ie).type='y';
errstruct(ie).sigma=dy_quad;
ie=ie+1;
errstruct(ie).indx=indqm;
errstruct(ie).type='s';
errstruct(ie).sigma=ds_quad;
ie=ie+1;

errstruct(ie).indx=indqm;
errstruct(ie).type='dpb2'; 
errstruct(ie).sigma=dkk_quad;
ie=ie+1;

% Sextupoles
%%indsext=[findcells(r0,'Class','Sextupoles')];
indsext=[find(atgetcells(r0,'FamName','SX1')); find(atgetcells(r0,'FamName','SX2')); find(atgetcells(r0,'FamName','SX3'))];
errstruct(ie).indx=indsext;
errstruct(ie).type='psi'; % roll
errstruct(ie).sigma=tilt_sext;
ie=ie+1;
errstruct(ie).indx=indsext;
errstruct(ie).type='x';
errstruct(ie).sigma=dx_sext;
ie=ie+1;
errstruct(ie).indx=indsext;
errstruct(ie).type='y';
errstruct(ie).sigma=dy_sext;
ie=ie+1;
errstruct(ie).indx=indsext;
errstruct(ie).type='s';
errstruct(ie).sigma=ds_sext;
ie=ie+1;

errstruct(ie).indx=indsext;
errstruct(ie).type='dpb3'; 
errstruct(ie).sigma=dkk_sext;
ie=ie+1;

indm=find(atgetcells(r0,'FamName','BPMx'));
sBPM=findspos(ring,indm);


%% set errors

magindex=arrayfun(@(a)a.indx,errstruct,'un',0);
type=arrayfun(@(a)a.type,errstruct,'un',0);
sigma=arrayfun(@(a)a.sigma,errstruct,'un',0);

%%

    rerr=atsetrandomerrors(...
    r0,...
    magindex,...
    indm,...
    randi([1 1000],1,1),...
    sigma,...
    2,...
    type);

% define bpm offset and rotation errors
nsigma = 2;
sigma_ox = 200e-6; % random offset errors of 200um
ox=TruncatedGaussian(sigma_ox,nsigma*sigma_ox,[length(indm) 1]);
sigma_oy = 200e-6;
oy=TruncatedGaussian(sigma_oy,nsigma*sigma_oy,[length(indm) 1]);
sigma_gx = 1e-2;% random gain errors of 1-2%
gx=TruncatedGaussian(sigma_gx,nsigma*sigma_gx,[length(indm) 1]);
sigma_gy = 1e-2;
gy=TruncatedGaussian(sigma_gy,nsigma*sigma_gy,[length(indm) 1]);
rx=100e-6; % reading error sigma of 100um (can also be a vector)
ry=100e-6; 
sigma_rot = 1e-5;  % random rotation errors of 10urad
rot=TruncatedGaussian(sigma_rot,nsigma*sigma_rot,[length(indm) 1]);

%dox=1e-5*randn(size(indm)); % random misalignment errors at BPM of 10um
%doy=1e-5*randn(size(indm)); % random misalignment errors at BPM of 10um
% ox=1e-5*randn(size(indm)); % random offset errors of 10um
% oy=1e-5*randn(size(indm)); 
% gx=1e-3*randn(size(indm)); % random gain errors of 0.1%
% gy=1e-3*randn(size(indm));  
% rx=100e-6; % reading error sigma of 100um (can also be a vector)
% ry=100e-6; 
% rot=1e-5*randn(size(indm)); % random rotation errors of 10urad

% set BPM errors
%rerr=atsetshift(rerr,indm,dox,doy);
rerr=atsetbpmerr(rerr,indm,ox,oy,gx,gy,rx,ry,rot);

%%

figure('units','normalized','position',[0.1 0.4 0.45 0.35])
atplot(rerr,'comment',[],@pltmisalignments);


figure('units','normalized','position',[0.3 0.3 0.45 0.35])
atplot(rerr,'comment',[],@plClosedOrbit)

figure('units','normalized','position',[0.1 0.4 0.65 0.35])
atplot(rerr,'comment',[],@plPolynomBComp);

%%
da_nturns = 50;
dpp = 0.0;
[xxda0,zzda0]=atdynap(ring_woErr,da_nturns,dpp,0.02);
[xx,zz]=atdynap(rerr,da_nturns,dpp,0.02);


figure(17);
plot(xxda0*1e3,zzda0*1e3,'b-','LineWidth',2);hold on,
plot(xx*1e3,zz*1e3,'r-','LineWidth',2);
hold off
legend('Initial: no errors','With errors')
xlim([-40 40])
ylim([0 15])
grid on
set(gcf,'color','w')
set(gca,'fontsize',16');
xlabel('x [mm]');                 % Add labels
ylabel('z [mm]');
title('DA (\deltap = 0)')



%%

%compute response matrix if it doesn't already exist

if ~exist('ModelRM')
ModelRM...
        =getresponsematrices(...
        ring,...
        indm,...
        indHCor,...
        indVCor,...
        [],...
        indQCor,...
        []',...
        [0 0 0 0 0 0]',...
        [1 2 3]);
end

%%

%now orbit correction
[rcor,inCOD,hs,vs]=atcorrectorbit(rerr,...
    indm,...
    indHCor',...
    indVCor',...
    [0 0 0 0 0 0]',...
    [10 10],...
    [false true],...
    1.0,...
    ModelRM,...
    zeros(2,length(indm)),...
    [],...
    true);

%%


o=findorbit6Err(rerr,indm,inCOD);
oxe=o(1,:);
oye=o(3,:);

o=findorbit6(rerr,indm,inCOD);
ox=o(1,:);
oy=o(3,:);

sBPM=findspos(rcor,indm);
figure;subplot(2,1,1);
plot(sBPM,oxe,'.-');hold on; plot(sBPM,ox,'.-');
legend('findorbit6Err','findorbit6');
xlabel('s [m]');
ylabel('hor. COD');
subplot(2,1,2);
plot(sBPM,oye,'.-');hold on; plot(sBPM,oy,'.-');
legend('findorbit6Err','findorbit6');
xlabel('s [m]');
ylabel('ver. COD');


%%

%find new closed orbit

o=findorbit6Err(rerr,indm,inCOD);
oxe=o(1,:);
oye=o(3,:);

o=findorbit6Err(rcor,indm,inCOD);
oxc=o(1,:);
oyc=o(3,:);

sBPM=findspos(rcor,indm);
figure;subplot(2,1,1);
plot(sBPM,oxe,'.-');hold on; plot(sBPM,oxc,'.-');
legend('before','after');
xlabel('s [m]');
ylabel('hor. COD');
subplot(2,1,2);
plot(sBPM,oye,'.-');hold on; plot(sBPM,oyc,'.-');
legend('before','after');
xlabel('s [m]');
ylabel('ver. COD');

%%

Lh=atgetfieldvalues(rcor,indHCor,'Length');
Lv=atgetfieldvalues(rcor,indVCor,'Length');

figure(14);
histogram(hs.*Lh(1)*1e3,10)
set(gcf,'color','w')
set(gca,'fontsize',16');
grid on
set(gcf,'color','w')
set(gca,'fontsize',16');
xlabel(' horizontal kick [mrad]');
ylabel('Entries');
addlabel(1, 0, datestr(clock,0))


figure(15);
histogram(vs.*Lh(1)*1e3,10)
set(gcf,'color','w')
set(gca,'fontsize',16');
grid on
set(gcf,'color','w')
set(gca,'fontsize',16');
xlabel(' vertical kick [mrad]');
ylabel('Entries');
addlabel(1, 0, datestr(clock,0))


%%

Z0=[0.001 0.0 0.0001 0 0 0]';

Nturns = 1000;

[X1_woErr,lost_thomx_woErr]=ringpass(ring_woErr,Z0,Nturns); %(X, PX, Y, PY, DP, CT2 ) 
BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2_woErr = linepass(ring_woErr, X1_woErr, BPMindex);

[X1,lost_thomx]=ringpass(rerr,Z0,Nturns); %(X, PX, Y, PY, DP, CT2 ) 
BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2 = linepass(rerr, X1, BPMindex);

BPMx_woErr = reshape(X2_woErr(1,:), Nturns, length(BPMindex));
BPMy_woErr = reshape(X2_woErr(3,:), Nturns, length(BPMindex));

BPMx = reshape(X2(1,:), Nturns, length(BPMindex));
BPMy = reshape(X2(3,:), Nturns, length(BPMindex));

% BPMindex = family2atindex('BPMx');
 spos = getspos('BPMx');

%%

figure
plot(spos,BPMx)
hold on
plot(spos,mean(BPMx,1),'k--','Linewidth',4)
hold off
xlabel('s-position');
ylabel('x-orbit');

BPMxAll = reshape(BPMx', 1,Nturns*length(BPMindex));
BPMxAll_woErr = reshape(BPMx_woErr', 1,Nturns*length(BPMindex));

figure
plot(BPMx(:,5),'r.-')
hold on
plot(BPMx_woErr(:,5))
hold off
xlabel('Turn number');
ylabel('x-orbit');

figure
plot(BPMxAll,'r.-')
hold on
plot(BPMxAll_woErr)
hold off
xlabel('Turn number');
ylabel('x-orbit');

%%
% thomx_lattice_error = rerr;
% save('ThomX_017_064_r56_02_chro11_errorMAX','thomx_lattice_error')







