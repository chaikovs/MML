close all
deltaE=linspace(-0.02,0.02,20);
XBPM1 = 0*deltaE;
XBPM2 = 0.44*deltaE+12*deltaE.^2-5e2*deltaE.^3;
XBPM3 = -0.35*deltaE+8*deltaE.^2-1e2*deltaE.^3;
XBPM4 = -0.35*deltaE;
plot(deltaE, XBPM1,'b-o'); hold on, plot(deltaE, XBPM2,'r-o'), plot(deltaE, XBPM3,'g-o'), plot(deltaE, XBPM4,'k-o')
legend ('BPM1','BPM2','BPM3','BPM4')
xlabel('DP/P (%)','Fontsize',18),ylabel('X(mm)','Fontsize',18)
set(gca,'Fontsize',18)
set(gcf,'Color',[1,1,1])
ethax1=polyfit(deltaE,XBPM1,3)
ethax2=polyfit(deltaE,XBPM2,3)
ethax3=polyfit(deltaE,XBPM3,3)
ethax4=polyfit(deltaE,XBPM4,3)

ethax=[ethax1; ethax2;ethax3;ethax4]
figure,plot(ethax(:,3),'b-o'), hold on, plot(ethax(:,2),'r-o')/10, plot(ethax(:,1)/100,'g-o');
legend ('ordre 1','ordre 2/10','ordre3/100')
xlabel('BPMx','Fontsize',18),ylabel('fir order value','Fontsize',18)
set(gca,'Fontsize',18)
set(gcf,'Color',[1,1,1])


