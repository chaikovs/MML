

close all
clear all

load magn_meas_dipole.mat

I9 = [dipole_meas.dip09full(1:29,1); dipole_meas.dip09full(31:end,1)];
B9 = [dipole_meas.dip09full(1:29,2); dipole_meas.dip09full(31:end,2)];


%% Current range fitting around working point 

B9_reg1 = B9(1:15);
I9_reg1 = I9(1:15);

B9_reg2 = B9(15:end);
I9_reg2 = I9(15:end);

x1 = linspace(min(I9_reg1),max(I9_reg1),5*length(I9_reg1));
x2 = linspace(min(I9_reg2),max(I9_reg2),5*length(I9_reg2));

%%

p9 = polyfit(I9_reg2,B9_reg2,5)

f9 = polyval(p9,x2);

% Linear fit
pl9 = polyfit(I9_reg1,B9_reg1,1)

fl9 = polyval(pl9,x1);

T91 = table(I9_reg1,B9_reg1,polyval(pl9,I9_reg1),B9_reg1-polyval(pl9,I9_reg1),1*(B9_reg1 - polyval(pl9,I9_reg1))./B9_reg1,'VariableNames',{'I','B','Fit','FitError','RelFitError'})

T92 = table(I9_reg2,B9_reg2,polyval(p9,I9_reg2),B9_reg2-polyval(p9,I9_reg2),1*(B9_reg2 - polyval(p9,I9_reg2))./B9_reg2,'VariableNames',{'I','B','Fit','FitError','RelFitError'})


figure
subplot(2,1,1);
set(gca,'FontSize',18)
plot(I9, B9, 'ko', 'MarkerSize',5)
hold on
plot(x2, f9, 'r-', 'LineWidth',1.3)
plot(x1, fl9, 'b-', 'LineWidth',1.3)
hold off
title('DIPOLE #09 Polynomial fit')
xlabel(' Current [A]')
ylabel('Inegrated field [T m]')
u = legend('Data','Polynom fit','Linear fit');
set(u,'Location','NorthWest','FontSize',14)
subplot(2,1,2);
set(gca,'FontSize',16)
plot(I9_reg2,(polyval(p9,I9_reg2) - B9_reg2)./B9_reg2,'ro-',...
     I9_reg1,(polyval(pl9,I9_reg1) - B9_reg1)./B9_reg1,'bo-','MarkerSize',5);
 xlabel(' Current [A]')
ylabel('Magnetic Field difference')
u = legend('(Polynom fit - Data)/Data','(Linear fit - Data)/Data');
set(u,'Location','SouthEast','FontSize',14)
%print('dipole_all_fit09.png','-dpng','-r300')

figure
subplot(2,1,1);
set(gca,'FontSize',18)
plot(I9, B9, 'ko', 'MarkerSize',5)
hold on
plot(x2, f9, 'r-', 'LineWidth',1.3)
plot(x1, fl9, 'b-', 'LineWidth',1.3)
hold off
title('DIPOLE #09 Polynomial fit')
xlabel(' Current [A]')
ylabel('Inegrated field [T m]')
u = legend('Data','Polynom fit','Linear fit');
set(u,'Location','NorthWest','FontSize',14)
subplot(2,1,2);
set(gca,'FontSize',16)
plot(I9_reg2,(polyval(p9,I9_reg2) - B9_reg2),'ro-',...
     I9_reg1,(polyval(pl9,I9_reg1) - B9_reg1),'bo-','MarkerSize',5);
 xlabel(' Current [A]')
ylabel('Magnetic Field difference')
u = legend('Polynom fit - Data','Linear fit - Data');
set(u,'Location','SouthEast','FontSize',14)
%print('dipole_all_fit09_simpleDiff.png','-dpng','-r300')

%%

str= {'DIP#09 (all data)' 'DIP#01' 'DIP#02' 'DIP#03' 'DIP#04' 'DIP#05' 'DIP#06' 'DIP#07' 'DIP#08' 'DIP#09' 'DIP#10' 'DIP#11' 'DIP#12' 'DIP#13' 'DIP#14' 'DIP#15'};
figure(1)
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

str0= { 'DIP#01' 'DIP#02' 'DIP#03' 'DIP#04' 'DIP#05' 'DIP#06' 'DIP#07' 'DIP#08' 'DIP#09' 'DIP#10' 'DIP#11' 'DIP#12' 'DIP#13' 'DIP#14' 'DIP#15'};
figure(2)
set(gca,'FontSize',18)
plot(dipole_meas.current(1:3,:), (mean(dipole_meas.fieldIntegral(:,:),2) - dipole_meas.fieldIntegral(1:3,:))./mean(dipole_meas.fieldIntegral(:,:),2), 'o-', 'MarkerSize',6, 'LineWidth',1.2)
hold on
plot([159.2475 159.2475 ],[-5e-3 4e-3], 'k-')
hold off
xlabel(' Current [A]')
ylabel('(Mean B - B_i) / Mean B')
title('Spread of the measurements for 15 DIPOLES')
u = legend(str0);
set(u,'Location','NorthWest')
xlim([30 300])
%print('dipole_all_dBB_spread_ALL.png','-dpng','-r300')

%%
I_nominal = 159.2996; %gev2bend(0.05)
I_all = dipole_meas.current(1:3,:);
dBB_all = (mean(dipole_meas.fieldIntegral(:,:),2) - dipole_meas.fieldIntegral(1:3,:))./mean(dipole_meas.fieldIntegral(:,:),2);

% dBB_sort = [dBB_all(:,2) dBB_all(:,4:end)];
% I_sort = [I_all(:,2) I_all(:,4:end)];

inddip_decr = [2 7 8 10 13 14 15];%[1 3 4 5 6 9 11 12];%13:15;
inddip_incr = [1 3 4 5 6 9 11 12];%13:15;

figure(3)
set(gca,'FontSize',18)
plot(I_all(:,inddip_decr), dBB_all(:,inddip_decr), 'o-', 'MarkerSize',6, 'LineWidth',1.2)
hold on
plot([I_nominal I_nominal ],[-3e-3 4e-3], 'k-')
hold off
xlabel(' Current [A]')
ylabel('(Mean B - B_i) / Mean B')
title('Spread of the measurements for 7 DIPOLES')
u = legend(str0{inddip_decr});
set(u,'Location','NorthWest')
xlim([30 300])
print('dipole_all_measSpreadRelJOIN_sortDECR.png','-dpng','-r300')

figure(4)
set(gca,'FontSize',18)
plot(I_all(:,inddip_incr), dBB_all(:,inddip_incr), 'o-', 'MarkerSize',6, 'LineWidth',1.2)
hold on
plot([I_nominal I_nominal ],[-5e-3 4e-3], 'k-')
hold off
xlabel(' Current [A]')
ylabel('(Mean B - B_i) / Mean B')
title('Spread of the measurements for 8 DIPOLES')
u = legend(str0{inddip_incr});
set(u,'Location','NorthWest')
xlim([30 300])
print('dipole_all_measSpreadRelJOIN_sortINCR.png','-dpng','-r300')

inddip = [2 4 5 6 7 8 9 10 11 12 13 14 15];%13:15;
figure(5)
set(gca,'FontSize',18)
plot(I_all(:,inddip), dBB_all(:,inddip), 'o-', 'MarkerSize',6, 'LineWidth',1.2)
hold on
plot([I_nominal I_nominal ],[-3e-3 3e-3], 'k-')
hold off
xlabel(' Current [A]')
ylabel('(Mean B - B_i) / Mean B')
title('Spread of the measurements for 15 DIPOLES')
u = legend(str0{inddip});
set(u,'Location','NorthWest')
xlim([30 300])
print('dipole_all_measSpreadRelJOIN_sort.png','-dpng','-r300')

inddip_try = [1    4     5     6  8   9    11    12];
figure(55)
set(gca,'FontSize',18)
plot(I_all(:,inddip_try), dBB_all(:,inddip_try), 'o-', 'MarkerSize',6, 'LineWidth',1.2)
hold on
plot([I_nominal I_nominal ],[-3e-3 4e-3], 'k-')
hold off
xlabel(' Current [A]')
ylabel('(Mean B - B_i) / Mean B')
title('Spread of the measurements for 8 DIPOLES (the worse removed)')
u = legend(str0{inddip_try});
set(u,'Location','NorthWest')
xlim([30 300])
print('dipole_all_measSpreadRelJOIN_sortTOTRY.png','-dpng','-r300')


%% interp Inom

%inddip = inddip_incr;
inddip = inddip_try;
xq = 120:10:260;
for i=1:8
   
    vq1(:,i) = interp1(I_all(:,inddip(i)),dBB_all(:,inddip(i)),xq);
    dBB_nominal(i) = interp1(I_all(:,inddip(i)),dBB_all(:,inddip(i)),I_nominal);
    
end

%% interp Inom

I_70MeV = 255.7891; %gev2bend(0.07)
 %inddip = inddip_incr;
inddip = inddip_try;

xq = 120:10:260;
for i=1:8
   
    vq1(:,i) = interp1(I_all(:,inddip(i)),dBB_all(:,inddip(i)),xq);
    dBB_70MeV(i) = interp1(I_all(:,inddip(i)),dBB_all(:,inddip(i)),I_70MeV);
    
end
%% interp

% xq = 120:10:260;
% for i=1:13
%    
%     vq1(:,i) = interp1(I_all(:,inddip(i)),dBB_all(:,inddip(i)),xq);
%     dBB_nominal(i) = interp1(I_all(:,inddip(i)),dBB_all(:,inddip(i)),I_nominal);
%     
% end

%%

figure(55)
set(gca,'FontSize',18)
plot(I_all(:,inddip), dBB_all(:,inddip), 'o-', 'MarkerSize',6, 'LineWidth',1.2)
hold on
plot([I_nominal I_nominal ],[-5e-3 4e-3], 'k-')
plot(I_nominal, dBB_nominal, 'rx', 'MarkerSize',8)
 plot(xq,vq1,':.');
hold off
xlabel(' Current [A]')
ylabel('(Mean B - B_i) / Mean B')
title('Linear interpolation to find the dBB @ Inominal = 159.2996 A')
u = legend(str0{inddip});
set(u,'Location','NorthWest')
xlim([30 300])
print('dipole_8_interp1_sort50Mev_worseRemoved.png','-dpng','-r300')

figure(56)
set(gca,'FontSize',18)
plot(I_all(:,inddip), dBB_all(:,inddip), 'o-', 'MarkerSize',6, 'LineWidth',1.2)
hold on
plot([I_70MeV I_70MeV ],[-5e-3 4e-3], 'k-')
plot(I_70MeV, dBB_70MeV, 'rx', 'MarkerSize',8)
 plot(xq,vq1,':.');
hold off
xlabel(' Current [A]')
ylabel('(Mean B - B_i) / Mean B')
title('Linear interpolation to find the dBB @ 70MeV = 255.7891 A')
u = legend(str0{inddip});
set(u,'Location','NorthWest')
xlim([30 300])
print('dipole_8_interp1_sort70Mev_worseRemoved.png','-dpng','-r300')
%%

% xq = 100:10:280;
% figure
% vq1 = interp1(I_all(:,1),dBB_all(:,1),xq);
% plot(I_all(:,1),dBB_all(:,1),'o',xq,vq1,':.');
% title('(Default) Linear Interpolation');

% dBB0 = dBB_nominal;
% dipND = inddip;
% dBB_table = [dipND; dBB0];
% save('dBB0_worseRemoved.mat', 'dBB0','dipND');

% dBB0 = dBB_all(2,inddip);
% save('dBB200A_worseRemoved.mat', 'dBB0','dipND');

% dBB0 = dBB_70MeV;
% dipND = inddip;
% dBB_table = [dipND; dBB0];
% 
% save('dBB256A_worseRemoved.mat', 'dBB0','dipND');
%%

figure
set(gca,'FontSize',20)
histogram(dBB_all(2,inddip),10)
h1.FaceColor = 'b';
h1.EdgeColor = 'b';
xlabel('Dipole dBB')
ylabel('Entries');
title(['Dipole Field error dBB. Mean = ' num2str(round(mean(dBB_all(2,inddip)),5)) ' and Rms = ' num2str(round(std(dBB_all(2,inddip)),4)) ])
print('dBB_dipole_8incr_200A_worseRemoved.png','-dpng','-r300')

%%
figure
set(gca,'FontSize',20)
histogram(dBB_nominal,10)
h1.FaceColor = 'b';
h1.EdgeColor = 'b';
xlabel('Dipole dBB')
ylabel('Entries');
title(['Dipole Field error dBB. Mean = ' num2str(round(mean(dBB_nominal),5)) ' and Rms = ' num2str(round(std(dBB_nominal),4)) ])
print('dBB_dipole_8incr_nominal_worseRemoved.png','-dpng','-r300')

%%

figure
set(gca,'FontSize',20)
histogram(dBB_70MeV,10)
h1.FaceColor = 'b';
h1.EdgeColor = 'b';
xlabel('Dipole dBB')
ylabel('Entries');
title(['Dipole Field error @ 70MeV dBB. Mean = ' num2str(round(mean(dBB_70MeV),5)) ' and Rms = ' num2str(round(std(dBB_70MeV),4)) ])
print('dBB_dipole_8incr_70MeV_worseRemoved.png','-dpng','-r300')

 %% Try to fit with the data of DIP#09
 
figure(2)
set(gca,'FontSize',20)
plot(I9_reg2, B9_reg2, 'bo-', 'MarkerSize',6, 'LineWidth',1.2)
hold all
plot(dipole_meas.current(1:3,7), dipole_meas.fieldIntegral(:,7), 'r*', 'MarkerSize',9, 'LineWidth',1.2)
hold off
xlabel(' Current [A]')
ylabel('Inegrated field [T m]')

%% Weighted fit

B_19_temp = [B9_reg2; dipole_meas.fieldIntegral(2:end,7)];
[B_19 ind1] = sort(B_19_temp);

I_19temp = [I9_reg2; dipole_meas.current(2:end,7)];
I_19 = I_19temp(ind1);

p19 = polyfit(I_19,B_19,5);

f19 = polyval(p19,x2);

figure
set(gca,'FontSize',20)
plot(I_19,B_19,'ro',x2,f19,'k','MarkerSize',5);

%%
w=ones(size(B_19)); w(8)=0.5; w(17)=0.5;
[p1,S] = polyfit3(I_19,B_19,5) 
[p2,S] = polyfit3(I_19,B_19,5,[],w) 

figure; 
plot(I_19,B_19,'.k'); hold on; 
plot(x2,polyval(p1,x2),'b');
plot(x2,polyval(p2,x2),'r');
hold off

figure
subplot(2,1,1);
set(gca,'FontSize',16)
plot(I_19, B_19, 'ko', 'MarkerSize',5)
hold on
plot(x2, polyval(p1,x2), 'b-', 'LineWidth',1.3)
plot(x2, polyval(p2,x2), 'r-', 'LineWidth',1.3)
hold off
%title('DIPOLE #09 Polynomial fit')
xlabel(' Current [A]')
ylabel('Inegrated field [T m]')
u = legend('Data','Polynom fit','Polynom weighted fit');
set(u,'Location','NorthWest','FontSize',14)
subplot(2,1,2);
set(gca,'FontSize',16)
plot(I_19,(polyval(p1,I_19) - B_19)./B_19,'bo-',...
     I_19,(polyval(p2,I_19) - B_19)./B_19,'ro-','MarkerSize',5);
 xlabel(' Current [A]')
ylabel('Magnetic Field difference')
u = legend('Polynom fit ','Polynom weighted fit');
set(u,'Location','NorthWest','FontSize',14)

