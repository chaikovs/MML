clear
E = 3.0; %GeV
Brho = E/0.299792458;
xkick = xlsread('BL11xkick')/Brho^2;
ykick = xlsread('BL11ykick')/Brho^2;
x = -.049:.001:.050;
y = .007:-.001:-.007;
save BL11table;