
close all;clear all

%%

load magn_meas_correct.mat % problem with corrector 8

current1_10 = correct_meas.current1_10;
vert_cor1_10 = correct_meas.vert_cor1_10;
hor_cor1_10 = correct_meas.hor_cor1_10;
cor11 = correct_meas.cor11vh;
cor12 = correct_meas.cor12vh;

figure
set(gca,'FontSize',16)
plot(current1_10(:,1:3), vert_cor1_10(:,1:3))
hold on
plot(current1_10(:,5:8), vert_cor1_10(:,5:8))
plot(current1_10(:,10), vert_cor1_10(:,10))
plot(cor11(:,1), cor11(:,2))
plot(cor12(:,1), cor12(:,2))
hold off
title('Vertical correctors')
xlabel(' Current [A]')
ylabel('Inegrated field B1 [T m]')

figure
set(gca,'FontSize',16)
plot(current1_10(:,1:3), hor_cor1_10(:,1:3))
hold on
plot(current1_10(:,5:8), hor_cor1_10(:,5:8))
plot(current1_10(:,10), hor_cor1_10(:,10))
plot(cor11(:,1), cor11(:,3))
plot(cor12(:,1), cor12(:,3))
hold off
title('Horizontal correctors')
xlabel(' Current [A]')
ylabel('Inegrated field B1 [T m]')

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



for icor = 1:10
    
    p3 = polyfit(current1_10(:, icor),hor_cor1_10(:, icor),1)
    
    FIT.p1(icor,1) = p3(1,1);
    FIT.p2(icor,1) = p3(1,2);
    
    f3all(:,icor) = polyval(p3,xx);
    f3allC(:,icor) = polyval(p3,current1_10(:, icor));
    
end

figure
subplot(2,1,1);
set(gca,'FontSize',20)
plot(current1_10(:,1:3), hor_cor1_10(:,1:3), 'ko', 'MarkerSize',6)
hold on
plot(xx, f3all(:,1:3), '-', 'LineWidth',1.3)
hold off
title('Hor Correctors Linear fit')
xlabel(' Current [A]')
ylabel('Inegrated field B1 [T m]')
u = legend('Data','Linear fit');
set(u,'Location','NorthEast')
subplot(2,1,2);
set(gca,'FontSize',20)
% plot(I8,(interp1(x,f8,I8) - B8)./B8,'ro-',...
%      I8,(interp1(x,f81,I8) - B8)./B8,'bo-');
plot(current1_10(:,1:3),(f3allC(:,1:3) - hor_cor1_10(:,1:3))./hor_cor1_10(:,1:3),'ro-');
 xlabel(' Current [A]')
ylabel('Magnetic Field difference')
u = legend('(Linear fit - Data)/Data');
set(u,'Location','NorthEast')

