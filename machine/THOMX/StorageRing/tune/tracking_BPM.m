
clc; close all; clear all;

%% Initial lattices

thomx_ring=ThomX_017_064_r56_02_chro00;



%Z0=[0.005 0 0.005 0 0 0]'*(1:15);
% Z0=[0.01 0 0.01 0 0 0]'*ones(1,15);
%Z0=[0.01 0 0.00 0 0 0]'*ones(1,15);

%%

Z0=[0.01 0 0.00 0 0 0]';

[OUT_thomx,lost_thomx]=ringpass(thomx_ring,Z0,1000); %(X, PX, Y, PY, DP, CT2 ) 


 X = OUT_thomx(1,:);
 PX= OUT_thomx(2,:);
 Y= OUT_thomx(3,:);
 PY= OUT_thomx(4,:);
 DP= OUT_thomx(5,:);
 CT= OUT_thomx(6,:);
 

figure
plot(X,PX,'b.','DisplayName', 'x-Px')
hold on
plot(Y,PY,'r.','DisplayName', 'y-Py')
hold off
legend('show','Location','NorthEast');
%print('tracking','-dpng','-r300')

%% BPM turn-by-turn and its FFT

figure
plot(X,'b.')

figure
plot(abs(fft(X)))

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


