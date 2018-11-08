
clc; close all; clear all;

%% Initial lattices

thomx_ring=ThomX_017_064_r56_02_chro00;


%%

Z0=[0.001 0.0 0.0001 0 0 0]';
Z1=[0.001 0 0.0001 0 0 0]';

[X1,lost_thomx]=ringpass(thomx_ring,Z0,1024); %(X, PX, Y, PY, DP, CT2 ) 
BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2 = linepass(thomx_ring, X1, BPMindex);
BPMx = reshape(X2(1,:), 1024, length(BPMindex));
BPMy = reshape(X2(3,:), 1024, length(BPMindex));

%  X = OUT_thomx(1,:);
%  PX= OUT_thomx(2,:);
%  Y= OUT_thomx(3,:);
%  PY= OUT_thomx(4,:);
%  DP= OUT_thomx(5,:);
%  CT= OUT_thomx(6,:);
 
% BPMindex = family2atindex('BPMx');
% spos = getspos('BPMx');

% OUT_thomx2 = linepass(thomx_ring, Z0, 1:length(thomx_ring)+1);
%   X1 = OUT_thomx2(1,BPMindex)*1e3;
%   Y1 = OUT_thomx2(3,BPMindex)*1e3;

%%
%buildatindex(Family, FamName)

% X1 = ringpass(thomx_ring, Z0, 1024);
% size(X1)
% %  Track coordinates for every turn along the ring (to all BPMs)
%     BPMindex = family2atindex('BPMx',getlist('BPMx'));
% 	BPM = findorbit4(thomx_ring, 0.0, BPMindex);
% 	X2 = linepass(thomx_ring, X1, BPMindex);
% 	size(X2)
% %  Recover matrix structure (turns x BPM#):
% 	BPMx = reshape(X2(1,:), 1024, length(BPMindex));
% 	size(BPMx)
% 	BPMy = reshape(X2(3,:), 1024, length(BPMindex));

%% BPM turn-by-turn and its FFT

figure
subplot 211
plot(BPMx(:,1),'b.')
hold on
plot(BPMx(:,2),'r.')
hold off
ylabel('COD [m]');
subplot 212
plot(BPMy(:,1),'b.')
hold on
plot(BPMy(:,2),'r.')
hold off
xlabel('Turn number');
ylabel('COD [m]');

% figure
% subplot 211
% plot(X1*1e3,'b.')
% subplot 212
% plot(Y1*1e3,'r.')
% xlabel('Turn number');
% ylabel('COD [m]');

%%

circumference = findspos(thomx_ring, length(thomx_ring)+1);
revTime = circumference / 2.99792458e8;
revFreq = 2.99792458e8 / circumference;
%[TD, tunes, chromaticity] = twissring(thomx_ring,0, length(thomx_ring)+1, 'chrom', 1e-8);
[lindata,tunes_fraq,chrom]=atlinopt(thomx_ring,0,1:length(thomx_ring)+1); 
tunes = lindata(end).mu/2/pi;
tunexfreq = tunes(1)/revTime;
tuneyfreq = tunes(2)/revTime;

tunexfreq_fraq = tunes_fraq(1)/revTime;
tuneyfreq_fraq = tunes_fraq(2)/revTime;


%%

fftx=abs(fft(BPMx(:,1)));
f = [1:length(fftx)]/length(fftx);

[tuneFFT_ampl tuneFFT_ind] = max(fftx);
tuneFFT  = f(tuneFFT_ind)

figure
plot(f, fftx);
xlabel('\nu_x');
ylabel('fft(x)');
title(['Tune \nu_x = ' num2str(tuneFFT) ' ( Model ' num2str(tunes_fraq(1)) ' ) \nu_x - \nu_{x0} = ' num2str((tuneFFT-tunes_fraq(1)))])
%xaxis([0 0.5]);


%%

lpad = 2*length(BPMx(:,1));
fftx_zpadding=abs(fft(BPMx(:,1), lpad));
f = [1:length(fftx_zpadding)]/length(fftx_zpadding);

[tuneFFT_zpadding_ampl tuneFFT_zpadding_ind] = max(fftx_zpadding);
tuneFFT_zpadding  = f(tuneFFT_zpadding_ind)

%%
% Fs = 1/revTime;                   
% N = length(BPMx(:,1));            
% dF = Fs/N;                
% 
% XX = fft(BPMx(:,1),N);
% XX = XX(1:N/2);
% mx = abs(XX);
% freq = (0:N/2-1)*Fs/N;
% 
% [BetaFreqFFT_ampl BetaFreqFFT_ind] = max(mx);
% BetaFreqFFT  = freq(BetaFreqFFT_ind);
% 
% figure;
% plot(freq, mx);
% xlabel('Frequency [Hz]');
% ylabel('fft(x)');
% title(['Betatron frequency f_x = ' num2str(1e-3*BetaFreqFFT) ' kHz ' '( Model ' num2str(1e-3*tunexfreq_fraq) ' kHz' ' ) f_x - f_{x0} = ' num2str(1e-3*(BetaFreqFFT-tunexfreq_fraq)) ' kHz'])

%% NAFF

[nux] = calcnaff(BPMx(:,1),zeros(length(BPMx),1));
[nuy] = calcnaff(BPMy(:,1),zeros(length(BPMy),1),1);

nux = abs(nux)/(2*pi)
nuy = abs(nuy)/(2*pi)

%% FFT using the FFT with sine window and interpolation

[nu2]=findfreq(BPMx(:,1),BPMx(:,1))
[nu2y]=findfreq(BPMy(:,1),BPMy(:,1))


%% add noise

X = BPMx(:,1) + 0.002*randn(size(BPMx(:,1)));
[nu1, amp1] = naff(X);

[nu2]=findfreq(X,X);

%[tmp, nu3]=ipfaw(x);

[nu1; nu2] - tunes_fraq(1)

%%
Nturns = 200:500:10000;%200:1000:21000;

for iturn = 1:length(Nturns)

Z0=[0.001 0.0 0.0001 0 0 0]';
[OUT_thomx,lost_thomx]=ringpass(thomx_ring,Z0,Nturns(iturn)); %(X, PX, Y, PY, DP, CT2 ) 

X = OUT_thomx(1,:);

Xnoise = X + 0.002*randn(size(X));

fftx=abs(fft(X));
f = [1:length(fftx)]/length(fftx);
[tuneFFT_ampl, tuneFFT_ind] = max(fftx);
nu_fft(iturn)  = f(tuneFFT_ind);

lpad = 2*length(X);
fftx_zpadding=abs(fft(X, lpad));
f_zpadding = [1:length(fftx_zpadding)]/length(fftx_zpadding);
[tuneFFT_zpadding_ampl, tuneFFT_zpadding_ind] = max(fftx_zpadding);
nu_zpadding(iturn)  = f_zpadding(tuneFFT_zpadding_ind);

[nu_naff(iturn), amp1] = naff(X');
nu_findfreq(iturn) = findfreq(X',X');

[nu_naff_noise(iturn), amp1] = naff(Xnoise');
nu_findfreq_noise(iturn) = findfreq(Xnoise',Xnoise');
    
end

%%

figure
plot(Nturns, abs(tunes_fraq(1) - nu_fft),'ko','DisplayName', 'fft')
hold on
%plot(Nturns, abs(tunes_fraq(1) - nu_zpadding),'mo','DisplayName', 'fft zero padding')
plot(Nturns, abs(tunes_fraq(1) - nu_naff),'ro','DisplayName', 'NAFF')
%plot(Nturns, abs(tunes_fraq(1) - nu_findfreq),'bo','DisplayName', 'findfreq')
plot(Nturns, abs(tunes_fraq(1) - nu_naff_noise),'r*','DisplayName', 'NAFF+noise')
%plot(Nturns, abs(tunes_fraq(1) - nu_findfreq_noise),'b*','DisplayName', 'findfreq+noise')
plot(Nturns, 1./Nturns,'k--','DisplayName', '1/N')
%plot(Nturns, 1./Nturns.^2,'r--','DisplayName', '1/N^2')
hold off
set(gca, 'YScale', 'log')
%set(gca, 'XScale', 'log')
u = legend('show','Location','NorthEast');
set(u,'FontSize',14)
xlabel('Turn number');
ylabel('Tune error');

%%




