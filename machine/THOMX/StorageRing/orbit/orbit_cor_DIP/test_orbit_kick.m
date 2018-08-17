
testline dipole;

figure;
td = linepass(THERING,[0 0 0 0 0 0]',[1:length(THERING)]);
plot(td(3,:))
%addsrot(2,pi/4);
td = linepass(THERING,[0 0 0 0 0 0]',[1:length(THERING)]);
hold on;
plot(td(3,:))


 %%
 DEBUT = THERING{1};
 FIN = THERING{end};
 DIP = THERING{10}
 %%
 %cell={DEBUT DIP FIN}
 %EMPTHERING = [cell]
 
 THERING = [{DIP}]
 %%
 
findm44(THERING,0)
 
 R = [0.002 0 0.01 0 0 0]'

BndMPoleSymplecticNew4Pass(THERING,R)

setshift(1, 1e-3, 0)

setshift(1, 0, 0)

[m44,T]=findm44(THERING,0,1:length(THERING)+1)

%%
 R = [0.001 0 0.001 0 0 0]'
 RR = [0 0 0 0 0 0]'

ringpass(THERING,RR,[1:length(THERING)+1])