
close all;clear all

%%

load magn_meas_sext.mat

current = sext_meas.current;
B3 = sext_meas.b3;

str0= { 'SEXT#01' 'SEXT#02' 'SEXT#03' 'SEXT#04' 'SEXT#05' 'SEXT#06' 'SEXT#07' 'SEXT#08' 'SEXT#09' 'SEXT#10' 'SEXT#11' 'SEXT#12'};
figure
set(gca,'FontSize',16)
plot(current, (B3),'o-','MarkerSize',6)
set(gca,'FontSize',16)
title('Sextupole calibration curves')
xlabel(' Current [A]')
ylabel('Inegrated field B3 [T m]')
u = legend(str0);
set(u,'Location','NorthWest','FontSize',12)
print('sext_all_calib.png','-dpng','-r300')
%%

B_mean = mean(B3,2);
B_std = std(B3,0,2);

table(current, B_mean, B_std ,B_std./B_mean, 'VariableNames' ,{'I','Bmean','Bstd','RelError'})


%%

%Linear fit

xx = linspace(min(current),max(current),5*length(current));
B3_sext = B3(:,1);

p3 = polyfit(current,B3_sext,1)

f3 = polyval(p3,xx);

T3 = table(current,B3_sext,polyval(p3,current),B3_sext-polyval(p3,current),100*(polyval(p3,current) - B3_sext)./B3_sext,'VariableNames',{'I','B','Fit','FitError','RelFitErrorPercent'})


figure
subplot(2,1,1);
set(gca,'FontSize',16)
plot(current, B3_sext, 'o', 'MarkerSize',6)
hold on
plot(xx, f3, 'r-', 'LineWidth',1.3)

hold off
title('SEXT 1 Linear fit')
xlabel(' Current [A]')
ylabel('Inegrated gradient [T]')
u = legend('Data','Linear fit');
set(u,'Location','NorthWest')
subplot(2,1,2);
set(gca,'FontSize',20)
% plot(I8,(interp1(x,f8,I8) - B8)./B8,'ro-',...
%      I8,(interp1(x,f81,I8) - B8)./B8,'bo-');
plot(current,(polyval(p3,current) - B3_sext)./B3_sext,'ro-');
 xlabel(' Current [A]')
ylabel('Magnetic Field difference')
u = legend('(Linear fit - Data)/Data');
set(u,'Location','NorthEast')
print('sext_numb1_calibfit.png','-dpng','-r300')



%%
C = [ current ones(size(current))];
d = B3_sext;
A = [];     % No inequality constraint
b = []; 
Aeq = [  0  1 ];  
beq = [0 ];                  

x_lsqlin1 = lsqlin(C,d,A,b,Aeq,beq)

plot(current, B3_sext,'o',current,C*x_lsqlin1)
legend('data','lsqlin')
grid on


%%

xx = linspace(min(current),max(current),5*length(current));



for isext = 1:12
    
    p3 = polyfit(current,B3(:,isext),1)
    
    FIT.p1(isext,1) = p3(1,1);
    FIT.p2(isext,1) = p3(1,2);
    
    f3all(:,isext) = polyval(p3,xx);
    f3allC(:,isext) = polyval(p3,current);
    
end



figure
subplot(2,1,1);
set(gca,'FontSize',20)
plot(current, B3, 'ko', 'MarkerSize',6)
hold on
plot(xx, f3all, '-', 'LineWidth',1.3)

hold off
title('SEXT 1 Linear fit')
xlabel(' Current [A]')
ylabel('Inegrated gradient [T]')
u = legend('Data','Linear fit');
set(u,'Location','NorthWest')
subplot(2,1,2);
set(gca,'FontSize',20)
% plot(I8,(interp1(x,f8,I8) - B8)./B8,'ro-',...
%      I8,(interp1(x,f81,I8) - B8)./B8,'bo-');
plot(current,(f3allC - B3)./B3,'ro-');
 xlabel(' Current [A]')
ylabel('Magnetic Field difference')
u = legend('(Linear fit - Data)/Data');
set(u,'Location','NorthEast')



