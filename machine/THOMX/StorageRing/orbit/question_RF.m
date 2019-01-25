
%%
% load lattice
thomx_ring = ThomX_017_064_r56_02_chro11();


% Xapert=0.04*ones(size(thomx_ring));
% Yapert=0.028*ones(size(thomx_ring));
% thomx_ring=SetPhysicalAperture(thomx_ring,Xapert/2,Yapert/2);
% 
% atplot(thomx_ring,@plotAperture);
%%

% global THERING
% thomx_ring=THERING;

%thomx_ring = atcavityon(thomx_ring);
%thomx_ring=atsetcavity(thomx_ring,300e3,0,30); % beta =1 ;
thomx_ring = atradon(thomx_ring);
thomx_ring{80}.Frequency = thomx_ring{80}.Frequency - 10e3 ;

Z0=[0.000 0 0.0000 0 0 0]';
Z1=[0.005 0.0 0.0001 0 0 0]';

Nturns = 10;
[X1,lost_thomx]=ringpass(thomx_ring,Z0,Nturns); %(X, PX, Y, PY, DP, CT2 ) 
BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2 = linepass(thomx_ring, X1, BPMindex);
BPMx = reshape(X2(1,:), Nturns, length(BPMindex));
BPMy = reshape(X2(3,:), Nturns, length(BPMindex));

% BPMindex = family2atindex('BPMx');
 sposBPM = getspos('BPMx');

figure
plot(sposBPM,BPMx)
hold on
plot(sposBPM,mean(BPMx,1),'r--','Linewidth',3)
hold off
xlabel('s-position');
ylabel('x-orbit');

figure
plot(BPMx(:,1))
xlabel('Turn number');
ylabel('x-orbit');

%% with findorbit6

L = length(thomx_ring);
spos = findspos(thomx_ring,1:L+1);

orbit = findorbit6(thomx_ring,1:length(thomx_ring)+1);
%orbit = findorbit4(RING,0,1:length(RING)+1);



figure
subplot 211
set(gca,'FontSize',16)
plot(spos,orbit(1,:)*1e3,'.-r', 'Markersize',13, 'Linewidth',1.6);
xlabel('Position [m]')
ylabel('X [mm]');
title('AT Storage Ring Horizontal Orbit ');
subplot 212
set(gca,'FontSize',16)
plot(spos,orbit(3,:)*1e3,'.-b', 'Markersize',13, 'Linewidth',1.6);
xlabel('Position [m]')
ylabel('Y [mm]');
title('AT Storage Ring Vertical Orbit ');






