
clc; close all; clear all;

%% Initial lattices

thomx_ring=ThomX_017_064_r56_02_chro00;


%%

Z0=[0.001 0.0 0.0001 0 0 0]';
Z1=[0.001 0 0.0001 0 0 0]';

[OUT_thomx,lost_thomx]=ringpass(thomx_ring,Z0,1000); %(X, PX, Y, PY, DP, CT2 ) 
[OUT_thomxV,lost_thomxV]=ringpass(thomx_ring,Z1,1000); %(X, PX, Y, PY, DP, CT2 ) 


 X = OUT_thomx(1,:);
 PX= OUT_thomx(2,:);
 Y= OUT_thomx(3,:);
 PY= OUT_thomx(4,:);
 DP= OUT_thomx(5,:);
 CT= OUT_thomx(6,:);
 
%  X_V = OUT_thomxV(1,:);
%  PX_V= OUT_thomxV(2,:);
%  Y_V= OUT_thomxV(3,:);
%  PY_V= OUT_thomxV(4,:);
%  DP_V= OUT_thomxV(5,:);
%  CT_V= OUT_thomxV(6,:);
 
%% BPM turn-by-turn and its FFT

figure
subplot 211
plot(X,'b.')
subplot 212
plot(Y,'b.')
xlabel('Turn number');
ylabel('COD [m]');

% figure
% subplot 211
% plot(X_V,'b.')
% subplot 212
% plot(Y_V,'b.')

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

fftx=abs(fft(X));
f = [1:length(fftx)]/length(fftx);

[tuneFFT_ampl tuneFFT_ind] = max(fftx);
tuneFFT  = f(tuneFFT_ind);

figure
plot(f, fftx);
xlabel('\nu_x');
ylabel('fft(x)');
title(['Tune \nu_x = ' num2str(tuneFFT) ' ( Model ' num2str(tunes_fraq(1)) ' ) \nu_x - \nu_{x0} = ' num2str((tuneFFT-tunes_fraq(1)))])
%xaxis([0 0.5]);

%%
Fs = 1/revTime;                   
N = length(X);            
dF = Fs/N;                

XX = fft(X,N);
XX = XX(1:N/2);
mx = abs(XX);
freq = (0:N/2-1)*Fs/N;

[BetaFreqFFT_ampl BetaFreqFFT_ind] = max(mx);
BetaFreqFFT  = freq(BetaFreqFFT_ind);

figure;
plot(freq, mx);
xlabel('Frequency [Hz]');
ylabel('fft(x)');
title(['Betatron frequency f_x = ' num2str(1e-3*BetaFreqFFT) ' kHz ' '( Model ' num2str(1e-3*tunexfreq_fraq) ' kHz' ' ) f_x - f_{x0} = ' num2str(1e-3*(BetaFreqFFT-tunexfreq_fraq)) ' kHz'])

%% NAFF

[nux] = calcnaff(X,PX,1);
[nuy] = calcnaff(Y,zeros(length(Y),1)',1);

nux = abs(nux)/(2*pi)
nuy = abs(nuy)/(2*pi)

%% FFT using the FFT with sine window and interpolation

[nu2]=findfreq(X',X')
[nu2y]=findfreq(Y',Y')

%% precise tune determination
nu = pi-3;
nturn = 100;
x = sin(2*pi*nu*(1:nturn));

[nu1, amp1] = naff(x');
nu1 - nu

[nu2]=findfreq(x',x');

%[tmp, nu3]=ipfaw(x);

fprintf('Naff  findfreq ipfaw:  %d turns\n', nturn)
[nu1; nu2] - nu
%% add noise

X = X + 0.02*randn(size(X));
[nu1, amp1] = naff(X');

[nu2]=findfreq(X',X');

%[tmp, nu3]=ipfaw(x);

[nu1; nu2] - nu

%%
Nturns = 200:100:2100;

for iturn = 1:length(Nturns)

Z0=[0.001 0.0 0.0001 0 0 0]';
[OUT_thomx,lost_thomx]=ringpass(thomx_ring,Z0,Nturns(iturn)); %(X, PX, Y, PY, DP, CT2 ) 

X = OUT_thomx(1,:);

Xnoise = X + 0.002*randn(size(X));

fftx=abs(fft(X));
f = [1:length(fftx)]/length(fftx);

[tuneFFT_ampl tuneFFT_ind] = max(fftx);
nu_fft(iturn)  = f(tuneFFT_ind);

[nu_naff(iturn), amp1] = naff(X');
nu_findfreq(iturn) = findfreq(X',X');

[nu_naff_noise(iturn), amp1] = naff(Xnoise');
nu_findfreq_noise(iturn) = findfreq(Xnoise',Xnoise');
    
end

%%

figure
plot(Nturns, abs(tunes_fraq(1) - nu_fft),'ko')
hold on
plot(Nturns, abs(tunes_fraq(1) - nu_naff),'ro')
plot(Nturns, abs(tunes_fraq(1) - nu_findfreq),'go')
plot(Nturns, abs(tunes_fraq(1) - nu_naff_noise),'k*')
plot(Nturns, abs(tunes_fraq(1) - nu_findfreq_noise),'b*')
plot(Nturns, 1./Nturns,'k--')
hold off
set(gca, 'YScale', 'log')


%%

