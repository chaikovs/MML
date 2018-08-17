function [FitParamOut,fXgain,fYgain,fBroll,varargout] = fitRING(RING,data,FitParam)
%[FitParamOut,Xgain,Ygain,varargout] = fitRING(RING,data,FitParam)
% Fit quadrupole strength of RING from optics data: beta functions, phase
% advances between elements (BPMs), dispersion functions, tunes.
% Include BPM gains as fitting parameters. 
% Input:
%   RING, the lattice structure
%   data, the data structure
%        bpmindex, Mx1, BPM indices in the lattice structure
%         betx, bety,
%         dpsix, dpsiy, phase advances between adjacent elements specifies by bpmindex
%         Dx, Dy,
%         tunes = [nux, nuy];
%   FitParam, the fitting parameter structure as built by buildfitparameters.m
%
%Output:
%   FitParam, the updated parameter structure after fitting.
%
%created by X. Huang, 7/9/2014
%
bpmindex = data.bpmindex;
% betx = data.betx_amp;
% bety = data.bety_amp;
% dpsix = data.dpsix;
% dpsiy = data.dpsiy;
% Dx = data.Dx;
% Dy = data.Dy;
% tunes = data.tunes;

Xgain = ones(length(bpmindex),1);
Ygain = Xgain;
Broll = 0*Xgain;

% load(['sim_data' filesep '\data_track_case2'  '.mat'],  'gx','gy','br','FitParamRef');
% % load sim_data/bpmerr_case1.mat gx gy br
% Xgain = gx;
% Ygain = gy;
% Broll = br;
% FitParam = FitParamRef;

NElem = length(RING);

% for ii=1:length(FitParam.Params)
%     RING = setparamgroup(RING, FitParam.Params{ii}, FitParam.Values(ii)); %+FitParameters.Deltas(ii)
% end

p0 = [zeros(size(FitParam.Values)); Xgain(:); Ygain(:); Broll(:)];
% p0 = [zeros(size(FitParam.Values));];

df0 = Xdiff(RING,data,FitParam, p0);

fprintf('initial chi2/N: %f\n', df0'*df0/length(df0));
% return
%% 
LMoption.nomessage = 0;  %set to 0 if you want the message
LMoption.SVtol = 1.0e-3; %
LMoption.MaxIter = 2;
LMoption.FTOL = 1.e-8;
LMoption.Lambda0 = 0.01;  

deltap = ones(size(p0))*1e-4; 
tic
[p,chi2,histo,sigp,covmat,NDF] = findLSmin_lite(@(p)Xdiff(RING,data,FitParam, p), p0,deltap,LMoption);
toc
df = Xdiff(RING,data,FitParam, p);
fprintf('final chi2/N: %f\n', df'*df/length(df0));
% save tmp00

% Nturn = length(X2);
Nfitpara = length(FitParam.Values);
NBPM = length(bpmindex);

FitParamOut = FitParam;
FitParamOut.Values = FitParam.Values + p(1:Nfitpara);

fXgain = [p(Nfitpara+(1:NBPM));];
fYgain = [p(Nfitpara+NBPM+(1:NBPM));];
fBroll = [p(Nfitpara+(NBPM)*2+(1:NBPM));];

np = p;
np(1:Nfitpara) = p0(1:Nfitpara);
df1 = Xdiff(RING,data,FitParam, np);
chi2_quad = (df1'*df1-df'*df)/length(df);
fprintf('Quad chi2/N: %f\n', chi2_quad)

for ii=1:Nfitpara
    np = p;
    np(ii) = p0(ii);
    df1 = Xdiff(RING,data,FitParam, np);
    chi2_quadi(ii) = (df1'*df1-df'*df)/length(df);
    %fprintf('   %d chi2/N: %f\n',ii, chi2_quadi(ii))
end
figure(71);
plot(1:Nfitpara, chi2_quadi); ylabel('chi2 quad');

if 0
np = p;
np(Nfitpara+(1:NBPM)) = 1;
df2 = Xdiff(RING,data,FitParam, np);
chi2_bpmgx = (df2'*df2-df'*df)/length(df);
fprintf('BPMx chi2/N: %f\n', chi2_bpmgx)
for ii=1:NBPM
    np = p;
    np(Nfitpara+ii) = 1;
    df2 = Xdiff(RING,data,FitParam, np);
    chi2_bpmgix(ii) = (df2'*df2-df'*df)/length(df);
    %fprintf('   %d chi2/N: %f\n',ii, chi2_bpmgix(ii))
end

np = p;
np(Nfitpara+NBPM+(1:NBPM)) = 1;
df2 = Xdiff(RING,data,FitParam, np);
chi2_bpmgy = (df2'*df2-df'*df)/length(df);
fprintf('BPMy chi2/N: %f\n', chi2_bpmgy)
for ii=1:NBPM
    np = p;
    np(Nfitpara+NBPM+ii) = 1;
    df2 = Xdiff(RING,data,FitParam,np);
    chi2_bpmgiy(ii) = (df2'*df2-df'*df)/length(df);
    %fprintf('   %d chi2/N: %f\n',ii, chi2_bpmgiy(ii))
end
end

np = p;
np(Nfitpara+(NBPM)*2+(1:NBPM)) = 0;
df2 = Xdiff(RING,data,FitParam, np);
chi2_bpmroll = (df2'*df2-df'*df)/length(df);
fprintf('BPM roll chi2/N: %f\n', chi2_bpmroll)
for ii=1:NBPM
    np = p;
    np(Nfitpara+(NBPM)*2+ii) = 0;
    df2 = Xdiff(RING,data,FitParam, np);
    chi2_bpmgir(ii) = (df2'*df2-df'*df)/length(df);
    %fprintf('   %d chi2/N: %f\n',ii, chi2_bpmgiy(ii))
end

% figure(72);
% plot(1:NBPM, chi2_bpmgix, 1:NBPM, chi2_bpmgiy); ylabel('chi2 BPMg');

figure(73)
plot(1:NBPM,chi2_bpmgir); ylabel('chi2 roll');

cat(1,histo.chi2)/length(df0)
save tmpFitQuadXY

