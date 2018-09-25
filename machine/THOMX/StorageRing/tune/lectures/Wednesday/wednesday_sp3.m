cd /Users/ichaikov/Documents/MATLAB/LOCO/Release/lectures/Wednesday/locodata

load BPMData_2007-04-04_04-46-03.mat
who
BPMxData
BPMxData.Data
std(BPMxData.Data)
std(BPMxData.Data')

%%
plot(BPMxData.Data)
figure
subplot(2,2,1)
[xn,xx] = hist(BPMxData.Data(1,:),10);
bar(xx, xn)
title('BPM 1')
xlabel('x (mm)'); ylabel('count')

subplot(2,2,2)
i1 = 15;
[xn,xx] = hist(BPMxData.Data(i1,:),10);
bar(xx, xn)
title(['BPM ' num2str(i1)])
xlabel('x (mm)'); ylabel('count')

subplot(2,2,3)
i1 = 15;
[xn,xx] = hist(BPMyData.Data(i1,:),10);
bar(xx, xn)
title(['BPM ' num2str(i1)])
xlabel('y (mm)'); ylabel('count')

subplot(2,2,4)
i1 = 1;
[xn,xx] = hist(BPMyData.Data(i1,:),10);
bar(xx, xn)
title(['BPM ' num2str(i1)])
xlabel('y (mm)'); ylabel('count')

%%
figure
subplot(2,1,1)
plot(std(BPMxData.Data'))
xlabel('BPM'); ylabel('\sigma_x (mm)');

subplot(2,1,2)
plot(std(BPMyData.Data'))
xlabel('BPM'); ylabel('\sigma_y (mm)');

%% examine the dispersion file
%clear
cd /Users/ichaikov/Documents/MATLAB/LOCO/Release/lectures/Wednesday/locodata

load Disp_2007-04-04_04-28-14.mat
who
BPMxDisp

%%
figure
plot(getspos('BPMx'),BPMxDisp.Data,'o-')
xlabel('spos (m)'); ylabel('Dx (mm/MHz)')

%% examine the BPM resp matrix file
%clear
load BPMRespMat_2007-04-04_04-28-37
who

Rmat(1,1)
figure
surf(Rmat(1,1).Data)
view(2)
%% now build the loco input file

buildlocoinput


%% now run LOCO

locogui
%open the loco input file just created


