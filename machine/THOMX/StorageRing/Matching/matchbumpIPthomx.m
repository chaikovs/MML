r= ring;%THERING;

figure;atplot(r);

hcor = findcells(r,'FamName','HCOR');
bpm  = findcells(r,'FamName','BPMx');       
ip   = findcells(r,'FamName','IP');       
    
ExtCor1 = atVariableBuilder(r,hcor(2),{'KickAngle',{1,1}});
IntCor1 = atVariableBuilder(r,hcor(3),{'KickAngle',{1,1}});
ExtCor2 = atVariableBuilder(r,hcor(5),{'KickAngle',{1,1}});
IntCor2 = atVariableBuilder(r,hcor(4),{'KickAngle',{1,1}});

c1=atlinconstraint(...
    ip,...
    {{'ClosedOrbit',{1}}},...
    [1e-3],...
    [1e-3],...
    [1]);

c2=atlinconstraint(...
    ip,...
    {{'ClosedOrbit',{2}}},...
    [0],...
    [0],...
    [1]);

c3=atlinconstraint(...
    bpm(1),...
    {{'ClosedOrbit',{1}}},...
    [0],...
    [0],...
    [1]);

c4=atlinconstraint(...
    bpm(6),...
    {{'ClosedOrbit',{1}}},...
    [0],...
    [0],...
    [1]);

v=[ExtCor1,IntCor1,ExtCor2,IntCor2];
c=[c1,c2,c3,c4];

r_bump=atmatch(r,v,c,10^-10,1000,3,@fminsearch);%'fminsearch' default

% plot 
figure; atplot(r,@plClosedOrbit);

figure; atplot(r_bump,@plClosedOrbit);

[l,t,c]=atlinopt(r_bump,0,bpm);
ox=arrayfun(@(a)a.ClosedOrbit(1),l);

hold on;
plot(findspos(r,bpm),ox,'x');

return
