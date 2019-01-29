function get_alpha12
% calcul a1 a2
% on fit :
% a1^2 - 4a2*df/f=(2*pi*E0/h/V/cc)^2/F0^4 * f^4
% sur mesure de f : fr�quence synchrotron


V=2.8; % tension RF
E0=2750;
U0=0.944;
cc=1; %U0/V; % synchronous phase
h=416;
frf=getrf*1e6;
F0=frf/416;
A=(2*pi*E0/h/V/cc)^2/F0^4;


% regression lineaire
load scan_freq.mat df fs
% df : scan en frequence RF en Hz
% fs ; mesure du frequence sybchrotron en Hz

x =df/frf;
y =A*fs.^4;
p = polyfit(x,y,2);
x1 =(min(x):(max(x)-min(x))/100  :max(x));
yval = polyval(p,x1)
a2=p(2)/4;
a1=sqrt(p(3));

figure(2)
%plot(df,fs,'-ob'); hold on
plot(x,y,'ob'); hold on
plot(x1,yval,'-r'); hold off
grid on
title(sprintf('alpha1 = %1.2e alpha2=%1.2e', a1,a2));


fprintf('Alpha fit : \n')
fprintf('   Alpha1 = %d \n',a1)
fprintf('   Alpha2 = %d \n',a2)


