%% Initial lattices

%thomx_ring=ThomX_017_064_r56_02_chro00;

global THERING
thomx_ring=THERING;
%%
Z0=[0.001 0.0 0.0001 0 0 0]';
Z1=[0.001 0 0.0001 0 0 0]';

Nturns = 10000;
[X1,lost_thomx]=ringpass(thomx_ring,Z0,Nturns); %(X, PX, Y, PY, DP, CT2 ) 
BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2 = linepass(thomx_ring, X1, BPMindex);
BPMx = reshape(X2(1,:), Nturns, length(BPMindex));
BPMy = reshape(X2(3,:), Nturns, length(BPMindex));

% BPMindex = family2atindex('BPMx');
 spos = getspos('BPMx');

%%

figure

plot(spos,BPMx)
xlabel('s-position');
ylabel('x-orbit');

figure
plot(BPMx(:,1))
xlabel('Turn number');
ylabel('x-orbit');