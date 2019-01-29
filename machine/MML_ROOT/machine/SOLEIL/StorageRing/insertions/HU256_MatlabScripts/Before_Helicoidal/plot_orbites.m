% plot des orbites lorsque la bobine PS2 varie

BPMx.Position = getspos('BPMx');
xdata = BPMx.Position;

%%%%%%%%%%%%%%% acquisitions
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_OFF_2006-10-01_17-20-28.mat')
X_OFF = S.X;Z_OFF = S.Z;
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_PS2ON_2006-10-01_17-27-02.mat')
X_ON = S.X;Z_ON = S.Z;
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_PS2_100_2006-10-01_17-41-02.mat')
X_100 = S.X;Z_100 = S.Z;
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_PS2_200_2006-10-01_17-45-24.mat')
X_200 = S.X;Z_200 = S.Z;
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_PS2_300_2006-10-01_17-47-52.mat')
X_300 = S.X;Z_300 = S.Z;
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_PS2_400_2006-10-01_17-49-39.mat')
X_400 = S.X;Z_400 = S.Z;
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_PS2_440_2006-10-01_17-52-12.mat')
X_440 = S.X;Z_440 = S.Z;
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_PS2_m100_2006-10-01_17-58-15.mat')
X_m100 = S.X;Z_m100 = S.Z;
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_PS2_m200_2006-10-01_18-00-02.mat')
X_m200 = S.X;Z_m200 = S.Z;
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_PS2_m300_2006-10-01_18-04-16.mat')
X_m300 = S.X;Z_m300 = S.Z;
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_PS2_m400_2006-10-01_18-05-43.mat')
X_m400 = S.X;Z_m400 = S.Z;
S = load('-mat','/home/matlabML/measdata/Ringdata/insertions/HU640_DESIRS/HU640_PS2_m440_2006-10-01_18-07-53.mat')
X_m440 = S.X;Z_m440 = S.Z;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(5)
plot(xdata,X_OFF,'c-',xdata,X_ON,'b-')
title('déplacement d''orbite horizontale en fonction de PS2');legend('PS2 OFF','PS2 ON I=0');
xlabel('position des BPM (m)') ; ylabel('déplacement en mm') 
figure(6)
plot(xdata,Z_OFF,'c-',xdata,Z_ON,'b-')
title('déplacement d''orbite verticale en fonction de PS2');legend('PS2 OFF','PS2 ON I=0');
xlabel('position des BPM (m)') ; ylabel('déplacement en mm') 
figure(7)
plot(xdata,(X_m100-X_ON),'b.-',xdata,(X_m200-X_ON),'k.-',xdata,(X_m300-X_ON),'r.-',xdata,(X_m400-X_ON),'g.-',xdata,(X_m440-X_ON),'y.-')
hold on
plot(xdata,(X_100-X_ON),'b-',xdata,(X_200-X_ON),'k-',xdata,(X_300-X_ON),'r-',xdata,(X_400-X_ON),'g-',xdata,(X_440-X_ON),'y-')

title('déplacement relatif d''orbite horizontal par rapport à PS2 ON / I = 0')
legend('I=-100 A','I=-200 A','I=-300 A','I=-400 A','I=-440 A','I=100 A','I=200 A','I=300 A','I=400 A','I=440 A')
xlabel('position des BPM (m)') ; ylabel('déplacement en mm') 
figure(8)
plot(xdata,(Z_m100-Z_ON),'b.-',xdata,(Z_m200-Z_ON),'k.-',xdata,(Z_m300-Z_ON),'r.-',xdata,(Z_m400-Z_ON),'g.-',xdata,(Z_m440-Z_ON),'y.-')
hold on
plot(xdata,(Z_100-Z_ON),'b-',xdata,(Z_200-Z_ON),'k-',xdata,(Z_300-Z_ON),'r-',xdata,(Z_400-Z_ON),'g-',xdata,(Z_440-Z_ON),'y-')
title('déplacement relatif d''orbite vertical par rapport à PS2 ON / I = 0')
legend('I=-100 A','I=-200 A','I=-300 A','I=-400 A','I=-440 A','I=100 A','I=200 A','I=300 A','I=400 A','I=440 A')
xlabel('position des BPM (m)') ; ylabel('déplacement en mm') 