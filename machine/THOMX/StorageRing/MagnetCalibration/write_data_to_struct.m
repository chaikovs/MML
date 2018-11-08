
%% DIPOLES

data_dip = load('DIPOLE_BI_all.dat');
I = data_dip(:,1);

data_dip9 = load('Cynthia/calib_BI_DIP9.dat');
I9raw = data_dip9(:,1); %current
B9field = data_dip9(:,2); %central field
B9int = data_dip9(:,4); %field integral

data_dip_opera = load('DIPOLE_MagnL_opera.txt');

%%

dipole_meas.dip09full = [data_dip9(:,1) data_dip9(:,4) data_dip9(:,2)];
dipole_meas.dip1to15_100A = [data_dip(4,:)' data_dip(1,:)'];
dipole_meas.dip1to15_200A = [data_dip(5,:)' data_dip(2,:)'];
dipole_meas.dip1to15_275A = [data_dip(6,:)' data_dip(3,:)'];

dipole_meas.lmag_opera = [data_dip_opera(:,1) data_dip_opera(:,2)];

% 
% for idip = 1:15
% 
% dipole_meas.dip1to15{idip} = [data_dip(4:end,idip) data_dip(1:3,idip)];
% 
% end

dipole_meas.dip01 = [data_dip(4:end,1) data_dip(1:3,1)];
dipole_meas.dip02 = [data_dip(4:end,2) data_dip(1:3,2)];
dipole_meas.dip03 = [data_dip(4:end,3) data_dip(1:3,3)];
dipole_meas.dip04 = [data_dip(4:end,4) data_dip(1:3,4)];
dipole_meas.dip05 = [data_dip(4:end,5) data_dip(1:3,5)];
dipole_meas.dip06 = [data_dip(4:end,6) data_dip(1:3,6)];
dipole_meas.dip07 = [data_dip(4:end,7) data_dip(1:3,7)];
dipole_meas.dip08 = [data_dip(4:end,8) data_dip(1:3,8)];
dipole_meas.dip09 = [data_dip(4:end,9) data_dip(1:3,9)];
dipole_meas.dip10 = [data_dip(4:end,10) data_dip(1:3,10)];
dipole_meas.dip11 = [data_dip(4:end,11) data_dip(1:3,11)];
dipole_meas.dip12 = [data_dip(4:end,12) data_dip(1:3,12)];
dipole_meas.dip13 = [data_dip(4:end,13) data_dip(1:3,13)];
dipole_meas.dip14 = [data_dip(4:end,14) data_dip(1:3,14)];
dipole_meas.dip15 = [data_dip(4:end,15) data_dip(1:3,15)];

dipole_meas.fieldIntegral = [data_dip(1:3,1) data_dip(1:3,2) data_dip(1:3,3) data_dip(1:3,4) data_dip(1:3,5)  ...
    data_dip(1:3,6) data_dip(1:3,7) data_dip(1:3,8) data_dip(1:3,9) data_dip(1:3,10) data_dip(1:3,11) data_dip(1:3,12) data_dip(1:3,13) data_dip(1:3,14) data_dip(1:3,15)];

dipole_meas.current = [data_dip(4:end,1) data_dip(4:end,2) data_dip(4:end,3) data_dip(4:end,4) data_dip(4:end,5) ...
    data_dip(4:end,6) data_dip(4:end,7) data_dip(4:end,8) data_dip(4:end,9) data_dip(4:end,10) data_dip(4:end,11) data_dip(4:end,12) data_dip(4:end,13) data_dip(4:end,14) data_dip(4:end,15) ];


save('magn_meas_dipole.mat', 'dipole_meas');

%%


figure
set(gca,'FontSize',18)
plot(dipole_meas.current(1,:), (mean(dipole_meas.fieldIntegral(1,:)) - dipole_meas.fieldIntegral(1,:))./mean(dipole_meas.fieldIntegral(1,:)), 'o', 'MarkerSize',6, 'LineWidth',1.2)
xlabel(' Current [A]')
ylabel('(Mean B - B_i) / Mean B')
title('Spread of the measurements for 15 DIPOLES @100A')


str0= { 'DIP#01' 'DIP#02' 'DIP#03' 'DIP#04' 'DIP#05' 'DIP#06' 'DIP#07' 'DIP#08' 'DIP#09' 'DIP#10' 'DIP#11' 'DIP#12' 'DIP#13' 'DIP#14' 'DIP#15'};
figure
set(gca,'FontSize',18)
plot(dipole_meas.current(1:3,:), (mean(dipole_meas.fieldIntegral(:,:),2) - dipole_meas.fieldIntegral(1:3,:))./mean(dipole_meas.fieldIntegral(:,:),2), 'o-', 'MarkerSize',6, 'LineWidth',1.2)
xlabel(' Current [A]')
ylabel('(Mean B - B_i) / Mean B')
title('Spread of the measurements for 15 DIPOLES')
u = legend(str0);
set(u,'Location','NorthWest')
xlim([30 300])

str= {'DIP#09 (all data)' 'DIP#01' 'DIP#02' 'DIP#03' 'DIP#04' 'DIP#05' 'DIP#06' 'DIP#07' 'DIP#08' 'DIP#09' 'DIP#10' 'DIP#11' 'DIP#12' 'DIP#13' 'DIP#14' 'DIP#15'};
figure
set(gca,'FontSize',20)
plot(dipole_meas.dip09full(:,1), dipole_meas.dip09full(:,2), 'bo-', 'MarkerSize',6, 'LineWidth',1.2)
hold all
plot(dipole_meas.current(1:3,:), dipole_meas.fieldIntegral(:,:), '*', 'MarkerSize',9, 'LineWidth',1.2)
hold off
xlabel(' Current [A]')
ylabel('Inegrated field [T m]')
title('Magnetic calibration for 15 DIPOLES')
% u = legend('DIP-9', 'DIP-91','DIP-7','DIP-11', 'DIP-12');
% set(u,'Location','NorthWest')
u = legend(str);
set(u,'Location','NorthWest')

Lmagn = B9int./B9field;

figure
set(gca,'FontSize',20)
plot(data_dip9(2:end,1), Lmagn(2:end), 'ko-', 'MarkerSize',6, 'LineWidth',1.2)
xlabel(' Current [A]')
ylabel('Magnetic Length [m]')
title('Raw data for the DIPOLE #09')

%% QUADs

close all; clc;
data_quad = load('Qpoles_Int_B2_I.txt');
I = data_quad(:,1);


%%

quad_meas.IntGradient = data_quad(:,2:end);

quad_meas.current = data_quad(:,1);


save('magn_meas_quad.mat', 'quad_meas');


%%

figure(1)
set(gca,'FontSize',18)
plot(I, data_quad(:,2:end), 'o-', 'MarkerSize',8, 'LineWidth',1.2)
xlabel(' Current [A]')
ylabel('Inegrated gradient [T]')
title('Magnetic calibration for 34 QUADS')
% print('quad_all_raw.png','-dpng','-r300')

%% SEXT

 %[numbers, TEXT, everything]  = xlsread('/Users/ichaikov/Work/ThomX/Bfield_measurements/Nouvelles_fiches_CHCV/Fiche_SP1_new.xls','B3')
data_sext = load('sext_all_raw.txt');

inverse_flag = -1;

sext_meas.sext1 = [data_sext(1:7,1) inverse_flag.*data_sext(1:7,2)];
sext_meas.sext2 = [data_sext(8:14,1) data_sext(8:14,2)];
sext_meas.sext3 = [data_sext(15:21,1) inverse_flag.*data_sext(15:21,2)];
sext_meas.sext4 = [data_sext(22:28,1) data_sext(22:28,2)];
sext_meas.sext5 = [data_sext(29:35,1) data_sext(29:35,2)];
sext_meas.sext6 = [data_sext(36:42,1) data_sext(36:42,2)];
sext_meas.sext7 = [data_sext(43:49,1) data_sext(43:49,2)];
sext_meas.sext8 = [data_sext(50:56,1) inverse_flag.*data_sext(50:56,2)];
sext_meas.sext9 = [data_sext(57:63,1) inverse_flag.*data_sext(57:63,2)];
sext_meas.sext10 = [data_sext(64:70,1) inverse_flag.*data_sext(64:70,2)];
sext_meas.sext11 = [data_sext(71:77,1) data_sext(71:77,2)];
sext_meas.sext12 = [data_sext(78:84,1) inverse_flag.*data_sext(78:84,2)];

sext_meas.current = [data_sext(1:7,1)];
sext_meas.b3 = [inverse_flag.*data_sext(1:7,2) data_sext(8:14,2) inverse_flag.*data_sext(15:21,2) data_sext(22:28,2) data_sext(29:35,2) data_sext(36:42,2) data_sext(43:49,2) inverse_flag.*data_sext(50:56,2) ...
  inverse_flag.*data_sext(57:63,2) inverse_flag.*data_sext(64:70,2) data_sext(71:77,2) inverse_flag.*data_sext(78:84,2) ];


save('magn_meas_sext.mat', 'sext_meas');

%% CORRECTORS


data_correct = load('correct_all_raw.txt');

inverse_flag = -1;

correct_meas.cor1vh = [data_correct(1:4,1) data_correct(1:4,2) inverse_flag.*data_correct(1:4,3)];
correct_meas.cor2vh = [data_correct(5:8,1) inverse_flag.*data_correct(5:8,2) data_correct(5:8,3)];
correct_meas.cor3vh = [data_correct(9:12,1) data_correct(9:12,2) inverse_flag.*data_correct(9:12,3)];
correct_meas.cor4vh = [data_correct(13:16,1) data_correct(13:16,2) data_correct(13:16,3)]; % data needed
correct_meas.cor5vh = [data_correct(17:20,1) inverse_flag.*data_correct(17:20,2) data_correct(17:20,3)];
correct_meas.cor6vh = [data_correct(21:24,1) data_correct(21:24,2) inverse_flag.*data_correct(21:24,3)];
correct_meas.cor7vh = [data_correct(25:28,1) data_correct(25:28,2) data_correct(25:28,3)];
correct_meas.cor8vh = [data_correct(29:32,1) inverse_flag.*data_correct(29:32,2) data_correct(29:32,3)];
correct_meas.cor9vh = [data_correct(33:36,1) data_correct(33:36,2) data_correct(33:36,3)]; % data needed
correct_meas.cor10vh = [data_correct(37:40,1) inverse_flag.*data_correct(37:40,2) inverse_flag.*data_correct(37:40,3)];
correct_meas.cor11vh = [data_correct(41:51,1) data_correct(41:51,2) data_correct(41:51,3)]; % more data points are measured
correct_meas.cor12vh = [data_correct(52:55,1) data_correct(52:55,2) inverse_flag.*data_correct(52:55,3)];

correct_meas.current1_10 = [data_correct(1:4,1) data_correct(5:8,1) data_correct(9:12,1) data_correct(13:16,1) data_correct(17:20,1) data_correct(21:24,1) data_correct(25:28,1) ...
  data_correct(29:32,1) data_correct(33:36,1) data_correct(37:40,1)];

correct_meas.vert_cor1_10 = [data_correct(1:4,2) inverse_flag.*data_correct(5:8,2) data_correct(9:12,2) data_correct(13:16,2) inverse_flag.*data_correct(17:20,2) data_correct(21:24,2) data_correct(25:28,2) ...
  inverse_flag.*data_correct(29:32,2) data_correct(33:36,2) inverse_flag.*data_correct(37:40,2)];

correct_meas.hor_cor1_10 = [inverse_flag.*data_correct(1:4,3) data_correct(5:8,3) inverse_flag.*data_correct(9:12,3) data_correct(13:16,3) data_correct(17:20,3) inverse_flag.*data_correct(21:24,3) data_correct(25:28,3) ...
  data_correct(29:32,3) data_correct(33:36,3) inverse_flag.*data_correct(37:40,3)];


save('magn_meas_correct.mat', 'correct_meas');

%%











