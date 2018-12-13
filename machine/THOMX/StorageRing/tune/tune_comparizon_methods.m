clc; close all; clear all;

%% Initial lattices

thomx_ring=ThomX_017_064_r56_02_chro00RF;


%%
Nturns = 66:300:12000; % 

for iturn = 1:length(Nturns)
    
   % for ibpm = 1:12

Z0=[0.001 0.0 0.0001 0 0 0]';
[OUT_thomx,lost_thomx]=ringpass(thomx_ring,Z0,Nturns(iturn)); %(X, PX, Y, PY, DP, CT2 ) 

BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2 = linepass(thomx_ring, OUT_thomx, BPMindex);
BPMx = reshape(X2(1,:), Nturns(iturn), length(BPMindex));
BPMy = reshape(X2(3,:), Nturns(iturn), length(BPMindex));

X = BPMx(:,1);

Xnoise = X + 0.002*randn(size(X));

fftx=abs(fft(X));
f = [1:length(fftx)]/length(fftx);
[tuneFFT_ampl, tuneFFT_ind] = max(fftx);
nu_fft(iturn)  = f(tuneFFT_ind);

lpad = 20*length(X);
fftx_zpadding=abs(fft(X, lpad));
f_zpadding = [1:length(fftx_zpadding)]/length(fftx_zpadding);
[tuneFFT_zpadding_ampl, tuneFFT_zpadding_ind] = max(fftx_zpadding);
nu_zpadding(iturn)  = f_zpadding(tuneFFT_zpadding_ind);

%[nu_naff(iturn), amp1] = naff(X);
[nux] = calcnaff(BPMx(:,1),zeros(length(BPMx(:,1)),1),1); 
tunes_naff = abs(nux)/(2*pi);
nu_naff(iturn) = tunes_naff(1,1);

nu_findfreq(iturn) = findfreq(X,X);

%[nu_naff_noise(iturn), amp1] = naff(Xnoise);
[nux] = calcnaff(Xnoise,zeros(length(Xnoise),1),1); 
tunes_naff_noise = abs(nux)/(2*pi);
nu_naff_noise(iturn) = tunes_naff_noise(1,1);



nu_findfreq_noise(iturn) = findfreq(Xnoise,Xnoise);

fftx=abs(fft(BPMx(:,1)));
f = [1:length(fftx)]/length(fftx);

% [tuneFFT_ampl tuneFFT_ind] = max(fftx);
% tuneFFT  = f(tuneFFT_ind);

% nu_fft_bpm(iturn,ibpm) = nu_fft(iturn);
% nu_zpadding_bpm(iturn,ibpm) = nu_zpadding(iturn);
% nu_naff_bpm(iturn,ibpm) = nu_naff(iturn);
% nu_findfreq_bpm(iturn,ibpm) = nu_findfreq(iturn);
% nu_naff_noise_bpm(iturn,ibpm) = nu_naff_noise(iturn);
% nu_findfreq_noise_bpm(iturn,ibpm) = nu_findfreq_noise(iturn);

   % end

    
end


%%

Z0=[0.001 0.0 0.0001 0 0 0]';
Z1=[0.001 0 0.0001 0 0 0]';

[X1,lost_thomx]=ringpass(thomx_ring,Z0,60000); %(X, PX, Y, PY, DP, CT2 ) 
BPMindex = family2atindex('BPMx',getlist('BPMx'));
X2 = linepass(thomx_ring, X1, BPMindex);
BPMx = reshape(X2(1,:), 60000, length(BPMindex));

[nux] = calcnaff(BPMx(:,1),zeros(length(BPMx(:,1)),1),1); 
tunes = abs(nux)/(2*pi);
tunes_fraq = tunes(1,1)
%nuy = 1-abs(nuy)/(2*pi);
%%

figure
%set(u,'FontSize',14)
plot(Nturns, abs(tunes_fraq(1) - nu_fft),'ko-','Markersize',4,'DisplayName', 'fft')
hold on
plot(Nturns, abs(tunes_fraq(1) - nu_zpadding),'mo-','Markersize',4,'DisplayName', 'fft zero padding')
plot(Nturns, abs(tunes_fraq(1) - nu_naff),'ro-','Markersize',4,'DisplayName', 'NAFF')
plot(Nturns, abs(tunes_fraq(1) - nu_findfreq),'bo-','Markersize',4,'DisplayName', 'findfreq')
plot(Nturns, abs(tunes_fraq(1) - nu_naff_noise),'r*-','Markersize',4,'DisplayName', 'NAFF+noise')
%plot(Nturns, abs(tunes_fraq(1) - nu_findfreq_noise),'b*','DisplayName', 'findfreq+noise')
plot(Nturns, 1./Nturns,'k--','DisplayName', '1/N')
plot(Nturns, 1./Nturns.^2,'k:','DisplayName', '1/N^2')
hold off
set(gca, 'YScale', 'log')
%set(gca, 'XScale', 'log')
u = legend('show','Location','NorthEast');
xlabel('Turn number');
ylabel('Tune error');
%print('error_tune_diffmethods.png','-dpng','-r300')




