
clc; close all; clear all;

%% Initial lattices

thomx_ring=ThomX_017_064_r56_02_chro00;



%Z0=[0.005 0 0.005 0 0 0]'*(1:15);
% Z0=[0.01 0 0.01 0 0 0]'*ones(1,15);
%Z0=[0.01 0 0.00 0 0 0]'*ones(1,15);

%%

Z0=[0.01 0.0 0.00 0 0 0]';
Z1=[0.0 0.001 0.00 0 0 0]';

[OUT_thomx,lost_thomx]=ringpass(thomx_ring,Z0,10000); %(X, PX, Y, PY, DP, CT2 ) 
[OUT_thomxV,lost_thomxV]=ringpass(thomx_ring,Z1,10000); %(X, PX, Y, PY, DP, CT2 ) 


 X = OUT_thomx(1,:);
 PX= OUT_thomx(2,:);
 Y= OUT_thomx(3,:);
 PY= OUT_thomx(4,:);
 DP= OUT_thomx(5,:);
 CT= OUT_thomx(6,:);
 
 X_V = OUT_thomxV(1,:);
 PX_V= OUT_thomxV(2,:);
 Y_V= OUT_thomxV(3,:);
 PY_V= OUT_thomxV(4,:);
 DP_V= OUT_thomxV(5,:);
 CT_V= OUT_thomxV(6,:);
 

figure
plot(X,PX,'b.','DisplayName', 'x-Px')
hold on
plot(Y,PY,'r.','DisplayName', 'y-Py')
hold off
legend('show','Location','NorthEast');
ylabel('P_x/P_y');
xlabel('x/y');
%print('tracking','-dpng','-r300')

figure
plot(X_V,PX_V,'b.','DisplayName', 'x-Px')
hold on
plot(Y_V,PY_V,'r.','DisplayName', 'y-Py')
hold off
legend('show','Location','NorthEast');
ylabel('P_x/P_y');
xlabel('x/y');

%% BPM turn-by-turn and its FFT

figure
subplot 211
plot(X,'b.')
subplot 212
plot(Y,'b.')

figure
subplot 211
plot(X_V,'b.')
subplot 212
plot(Y_V,'b.')

%%

figure
plot(abs(fft(X)))

figure
plot(abs(fft(X_V)))

fftx=abs(fft(X));
f = [1:length(fftx)]/length(fftx);

[tune_ampl tune_ind] = max(fftx);
tune = f(tune_ind);

figure
plot(f, fftx);
xlabel('\nu_x');
ylabel('fft(x)');
%xaxis([0 0.5]);

%%

BPMindex = family2atindex('BPMx');
spos = getspos('BPMx');

X00 = [1e-3 0 1e-3 0 0 0]';
X01 = linepass(THERING, X00(:,end), 1:length(THERING)+1);
X02 = linepass(THERING, X01(:,end), 1:length(THERING)+1);
X03 = linepass(THERING, X02(:,end), 1:length(THERING)+1);
X04 = linepass(THERING, X03(:,end), 1:length(THERING)+1);

    [X1 X2 X3 X4 ] = deal(X01(1,BPMindex)*1e3, X02(1,BPMindex)*1e3, X03(1,BPMindex)*1e3, X04(1,BPMindex)*1e3);
    [Z1 Z2 Z3 Z4 ] = deal(X01(3,BPMindex)*1e3, X02(3,BPMindex)*1e3, X03(3,BPMindex)*1e3, X04(3,BPMindex)*1e3);
    
figure
plot(X01(1,BPMindex)*1e3,'b.')
hold on
plot(X02(1,BPMindex)*1e3,'r.')
plot(X03(1,BPMindex)*1e3,'g.')
plot(X04(1,BPMindex)*1e3,'m.')
hold off
xlabel('BPM number')
ylabel('COD [mm]')

%%

Q01 = ringpass(THERING, X00(:,end),10);

%% 

% rin0=[0.005; 0.00; 0.005; 0; 0; 0];
% rin=[0.03; 0.00; 0.03; 0; 0; 0];
% rin2=[0.01; 0.00; 0.01; 0; 0; 0];
% rin3=[0.013; 0.00; 0.013; 0; 0; 0];
% 
% [X0,lost0]=ringpass(thomx_ring,rin0,1000);
% [X,lost]=ringpass(thomx_ring,rin,1000); 
% [X2,lost2]=ringpass(thomx_ring,rin2,1000);
% [X3,lost3]=ringpass(thomx_ring,rin3,1000);
% 
% figure(50)
% plot(X(1,:),X(2,:),'.b')
% 
% figure(51)
% plot(X2(1,:),X2(2,:),'.m')
% hold on
% plot(X0(1,:),X0(2,:),'.b')
% plot(X3(1,:),X3(2,:),'*k')


%%

circumference = findspos(thomx_ring, length(thomx_ring)+1);
revTime = circumference / 2.99792458e8;
revFreq = 2.99792458e8 / circumference;
%[TD, tunes, chromaticity] = twissring(thomx_ring,0, length(thomx_ring)+1, 'chrom', 1e-8);
[lindata,tunes_fraq,chrom]=atlinopt(thomx_ring,0,1:length(thomx_ring)+1); 
tunes = lindata(end).mu/2/pi;
tunexfreq = tunes(1)/revTime
tuneyfreq = tunes(2)/revTime

tunexfreq_fraq = tunes_fraq(1)/revTime
tuneyfreq_fraq = tunes_fraq(2)/revTime

%%

Fs = 1/revTime;                   % samples per second
N = length(X);            % samples
dF = Fs/N;                 % hertz per sample

X1_fft = fftshift(fft(X))/N;

f = -Fs/2:dF:Fs/2-dF + (dF/2)*mod(N,2);      % hertz

figure;
plot(f,abs(X1_fft));

figure;
plot(f./Fs,abs(X1_fft));


%%
Fs = 1/revTime;                   
N = length(X);            
dF = Fs/N;                

XX = fft(X,N);
XX = XX(1:N/2);
mx = abs(XX);
f = (0:N/2-1)*Fs/N;

figure;
plot(f, mx);

%%

