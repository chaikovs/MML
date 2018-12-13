
clc; close all; clear all;

%% Initial lattices

thomx_ring=ThomX_017_064_r56_02_chro00;
%%

Z0=[0.001 0.0 0.0001 0 0 0]';
Z1=[0.001 0 0.0001 0 0 0]';
Nturns = 1024;

[X1,lost_thomx]=ringpass(thomx_ring,Z0,Nturns); %(X, PX, Y, PY, DP, CT2 ) 
BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2 = linepass(thomx_ring, X1, BPMindex);
BPMx = reshape(X2(1,:), Nturns, length(BPMindex));
BPMy = reshape(X2(3,:), Nturns, length(BPMindex));

AM.Data.X = BPMx(:,1);
AM.Data.Y = BPMy(:,1);


%%

findtune(AM.Data.X)
intfft(AM.Data.X)

%%

[Tune, Tune_Vec] = libera_calctunesS(AM,1);

%%

libera_calctunes(5,1);

%%

[nux nuz Xcod Zcod] = fourturnalgorithm('Model')

%%
