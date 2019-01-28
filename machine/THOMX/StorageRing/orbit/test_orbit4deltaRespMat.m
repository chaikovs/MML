

ring  = ThomX_017_064_r56_02_chro11;

%%
indBPM=find(atgetcells(ring,'FamName','BPMx'));
indHCorT=find(atgetcells(ring,'Class','Corrector'));
indHCor = indHCorT(1:2:end);
indVCorT=find(atgetcells(ring,'Class','Corrector'));
indVCor = indVCorT(1:2:end);
indRF=find(atgetcells(ring,'FamName','RF'));

sBPM=findspos(ring,indBPM);
sRING=findspos(ring,1:length(ring)+1);
%%

%ringCOR = atsetfieldvalues(ring, findcells(ring,'FamName','HCOR'), 'KickAngle',{1,1},0.1e-3);

ringCORkick = atsetfieldvalues(ring,68 , 'KickAngle',{1,1},0.1e-3);
ringRFkick = atsetfieldvalues(ring, findcells(ring,'FamName','RF') , 'Frequency',ring{80}.Frequency- 10e3);

%%

orbitCORkick = findorbit4(ringCORkick, 0,1:length(ringCORkick)+1); % 
xorbCORkick=orbitCORkick(1,:);
yorbCORkick=orbitCORkick(3,:);

orbitRFkick = findorbit6(ringRFkick,1:length(ringRFkick)+1); % 
xorbRFkick=orbitRFkick(1,:);
yorbRFkick=orbitRFkick(3,:);

%%


figure(1);
plot(sRING,1e3*xorbCORkick,'b.-','MarkerSize',8)
hold on; 
plot(sRING,1e3*yorbCORkick,'r.-');
set(gcf,'color','w')
set(gca,'fontsize',16');
 xlim([0 18])
% ylim([0 6])
grid on
set(gcf,'color','w')
set(gca,'fontsize',16');
xlabel('s-position [m]');
ylabel('y [mm]');

figure(2);
plot(sRING,1e3*xorbRFkick,'b.-','MarkerSize',8)
hold on; 
plot(sRING,1e3*yorbRFkick,'r.-');
set(gcf,'color','w')
set(gca,'fontsize',16');
 xlim([0 18])
% ylim([0 6])
grid on
set(gcf,'color','w')
set(gca,'fontsize',16');
xlabel('s-position [m]');
ylabel('y [mm]');

%%

figure('units','normalized','position',[0.3 0.3 0.45 0.35])
atplot(ringCORkick,'comment',[],@plClosedOrbit)

