
close all;clear all

%%

load magn_meas_correct.mat % problem with corrector 8

current1_10 = correct_meas.current1_10;
vert_cor1_10 = correct_meas.vert_cor1_10;
hor_cor1_10 = correct_meas.hor_cor1_10;
cor11 = correct_meas.cor11vh;
cor12 = correct_meas.cor12vh;

str0= { 'VCOR#01' 'VCOR#02' 'VCOR#03' 'VCOR#05' 'VCOR#06' 'VCOR#07' 'VCOR#10' 'VCOR#11' 'VCOR#12'};
figure
set(gca,'FontSize',18)
plot(current1_10(:,:), vert_cor1_10(:,:),'o-','MarkerSize',6)
hold on
%plot(current1_10(:,5:8), vert_cor1_10(:,5:8))
%plot(current1_10(:,10), vert_cor1_10(:,10))
plot(cor11(:,1), cor11(:,2),'o-','MarkerSize',6)
plot(cor12(:,1), cor12(:,2),'o-','MarkerSize',6)
hold off
set(gca,'FontSize',16)
title('Vertical correctors')
xlabel(' Current [A]')
ylabel('Inegrated field B1 [T m]')
u = legend(str0);
set(u,'Location','SouthWest','FontSize',12)
%print('VCOR_all_calib.png','-dpng','-r300')

str0= { 'HCOR#01' 'HCOR#02' 'HCOR#03' 'HCOR#05' 'HCOR#06' 'HCOR#07' 'HCOR#10' 'HCOR#11' 'HCOR#12'};
figure
set(gca,'FontSize',18)
plot(current1_10(:,:), hor_cor1_10(:,:),'o-','MarkerSize',6)
hold on
%plot(current1_10(:,5:8), hor_cor1_10(:,5:8))
%plot(current1_10(:,10), hor_cor1_10(:,10))
plot(cor11(:,1), cor11(:,3),'o-','MarkerSize',6)
plot(cor12(:,1), cor12(:,3),'o-','MarkerSize',6)
hold off
set(gca,'FontSize',16)
title('Horizontal correctors')
xlabel(' Current [A]')
ylabel('Inegrated field B1 [T m]')
u = legend(str0);
set(u,'Location','SouthWest','FontSize',12)
%print('HCOR_all_calib.png','-dpng','-r300')
%%

Bv_mean = mean( [vert_cor1_10 cor12(:,2)],2);
Bv_std = std([vert_cor1_10 cor12(:,2)],0,2);

Bh_mean = mean([hor_cor1_10 cor12(:,3)],2);
Bh_std = std([hor_cor1_10 cor12(:,3)],0,2);

table(current1_10(:,1), Bv_mean, Bv_std ,Bv_std./Bv_mean, 'VariableNames' ,{'I','BVmean','BVstd','RelError'})

table(current1_10(:,1), Bh_mean, Bh_std ,Bh_std./Bh_mean, 'VariableNames' ,{'I','BHmean','BHstd','RelError'})


%%

%Linear fit


[B,I]=sort(cor11(:,1))
current = cor11(I,1);
B1_cor = cor11(I,3);

xx = linspace(min(current),max(current),5*length(current));


p3 = polyfit(current,B1_cor,1)

f3 = polyval(p3,xx);

T3 = table(current,B1_cor,polyval(p3,current),B1_cor-polyval(p3,current),100*(polyval(p3,current) - B1_cor)./B1_cor,'VariableNames',{'I','B','Fit','FitError','RelFitErrorPercent'})

figure
subplot(2,1,1);
set(gca,'FontSize',20)
plot(current, B1_cor, 'ko', 'MarkerSize',6)
hold on
plot(xx, f3, '-', 'LineWidth',1.3)
hold off
title('Hor Corrector Linear fit')
xlabel(' Current [A]')
ylabel('Inegrated field B1 [T m]')
u = legend('Data','Linear fit');
set(u,'Location','NorthEast')
subplot(2,1,2);
set(gca,'FontSize',20)
% plot(I8,(interp1(x,f8,I8) - B8)./B8,'ro-',...
%      I8,(interp1(x,f81,I8) - B8)./B8,'bo-');
plot(current,(polyval(p3,current) - B1_cor)./B1_cor,'ro-');
 xlabel(' Current [A]')
ylabel('Magnetic Field difference')
u = legend('(Linear fit - Data)/Data');
set(u,'Location','NorthEast')

%%


%%

xx = linspace(min(current),max(current),5*length(current));



for icor = 1:7
    
    p3 = polyfit(current1_10(:, icor),hor_cor1_10(:, icor),1)
    
    FIT.p1(icor,1) = p3(1,1);
    FIT.p2(icor,1) = p3(1,2);
    
    f3all(:,icor) = polyval(p3,xx);
    f3allC(:,icor) = polyval(p3,current1_10(:, icor));
    
    p3v = polyfit(current1_10(:, icor),vert_cor1_10(:, icor),1)
    
    FITv.p1(icor,1) = p3v(1,1);
    FITv.p2(icor,1) = p3v(1,2);
    
    f3allv(:,icor) = polyval(p3v,xx);
    f3allCv(:,icor) = polyval(p3v,current1_10(:, icor));
    
end

figure
subplot(2,1,1);
set(gca,'FontSize',20)
plot(current1_10(:,:), hor_cor1_10(:,:), 'ko', 'MarkerSize',6)
hold on
plot(xx, f3all(:,:), '-', 'LineWidth',1.3)
hold off
title('Hor Correctors Linear fit')
xlabel(' Current [A]')
ylabel('Inegrated field B1 [T m]')
%u = legend('Data','Linear fit');
%set(u,'Location','NorthEast')
subplot(2,1,2);
set(gca,'FontSize',20)
% plot(I8,(interp1(x,f8,I8) - B8)./B8,'ro-',...
%      I8,(interp1(x,f81,I8) - B8)./B8,'bo-');
plot(current1_10(:,:),(f3allC(:,:) - hor_cor1_10(:,:))./hor_cor1_10(:,:),'ro-');
 xlabel(' Current [A]')
ylabel('Magnetic Field difference')
u = legend('(Linear fit - Data)/Data');
set(u,'Location','NorthEast')
%print('HCOR_all_calibfit.png','-dpng','-r300')


figure
subplot(2,1,1);
set(gca,'FontSize',20)
plot(current1_10(:,:), vert_cor1_10(:,:), 'ko', 'MarkerSize',6)
hold on
plot(xx, f3allv(:,:), '-', 'LineWidth',1.3)
hold off
title('Vert Correctors Linear fit')
xlabel(' Current [A]')
ylabel('Inegrated field B1 [T m]')
%u = legend('Data','Linear fit');
%set(u,'Location','NorthEast')
subplot(2,1,2);
set(gca,'FontSize',20)
% plot(I8,(interp1(x,f8,I8) - B8)./B8,'ro-',...
%      I8,(interp1(x,f81,I8) - B8)./B8,'bo-');
plot(current1_10(:,:),(f3allCv(:,:) - vert_cor1_10(:,:))./vert_cor1_10(:,:),'ro-');
 xlabel(' Current [A]')
ylabel('Magnetic Field difference')
u = legend('(Linear fit - Data)/Data');
set(u,'Location','NorthEast')
%print('VCOR_all_calibfit.png','-dpng','-r300')

