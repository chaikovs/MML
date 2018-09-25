%% after exporting data in ICAGUI
%make sure the first two modes are horizontal, the next two are vertical

% !copy tempmodes.mat qerr_noise.mat
% load qerr_noise.mat
[ax,ay,px,py] = betaphase(data);

%choose subplot 2 of figure 2
figure(2)
subplot(2,1,1)
hold on
plot(MuX0, (-px+px(1)+MuX0(1)-MuX0)/2/pi,'r-.')

subplot(2,1,2)
hold on
plot(MuY0, (-py+py(1)+MuY0(1)-MuY0)/2/pi,'r-.')
