clc; close all; clear all;

% findcells(THERING,'FamName','BEND')
%find(atgetcells(THERING,'Class','BEND'))

%% Initial lattices

thomx_ring=ThomX_017_064_r56_02_chro00RF;
%thomx_ring=ThomX_016_058_r56_02_chro22;

%%

% atgetfieldvalues(thomx_ring,findcells(thomx_ring,'FamName','QP1'), 'PolynomB',{1,2})
% atgetfieldvalues(thomx_ring,findcells(thomx_ring,'FamName','SX2'), 'PolynomB',{1,3})
% getatfield('SX2','PolynomB')

BareRING = atsetfieldvalues(thomx_ring,findcells(thomx_ring,'FamName','SX1'), 'PolynomB',{1,3},0);
BareRING = atsetfieldvalues(BareRING,findcells(BareRING,'FamName','SX2'), 'PolynomB',{1,3},0);
BareRING = atsetfieldvalues(BareRING,findcells(BareRING,'FamName','SX3'), 'PolynomB',{1,3},0);

BareRING = atsetfieldvalues(BareRING,findcells(BareRING,'FamName','QP1'), 'PolynomB',{1,2},0);
BareRING = atsetfieldvalues(BareRING,findcells(BareRING,'FamName','QP2'), 'PolynomB',{1,2},0);
BareRING = atsetfieldvalues(BareRING,findcells(BareRING,'FamName','QP3'), 'PolynomB',{1,2},0);
BareRING = atsetfieldvalues(BareRING,findcells(BareRING,'FamName','QP4'), 'PolynomB',{1,2},0);
BareRING = atsetfieldvalues(BareRING,findcells(BareRING,'FamName','QP31'), 'PolynomB',{1,2},0);
BareRING = atsetfieldvalues(BareRING,findcells(BareRING,'FamName','QP11'), 'PolynomB',{1,2},0);

%%

figure('units','normalized','position',[0.3 0.3 0.45 0.35])
atplot(BareRING,'comment',[],@plClosedOrbit)
%saveas(gca,'OrbitWithErr.fig')
%export_fig('OrbitWithErr.jpg','-r300')


%%

indm=find(atgetcells(thomx_ring,'FamName','BPMx'));
sBPM=findspos(thomx_ring,indm);

 orbit4 = findorbit4(BareRING,0, indm);
 
xorbit=orbit4(1,:);
yorbit=orbit4(3,:);

figure
plot(sBPM,xorbit)

%%


Z0=[0.01 0.0 0.00 0 0 0]';
Z1=[0.0 0.001 0.00 0 0 0]';

[OUT_thomx,lost_thomx]=ringpass(thomx_ring,Z0,1000); %(X, PX, Y, PY, DP, CT2 ) 


 X = OUT_thomx(1,:);
 PX= OUT_thomx(2,:);
 Y= OUT_thomx(3,:);
 PY= OUT_thomx(4,:);
 DP= OUT_thomx(5,:);
 CT= OUT_thomx(6,:);
 
 figure
plot(X,PX,'b.','DisplayName', 'x-Px')

%%
Z0=[0.001 0.000 0.001 0 0 0]';
indm=find(atgetcells(thomx_ring,'FamName','BPMx'));
sBPM=findspos(thomx_ring,indm);


% linepass
outtr=linepass(thomx_ring,Z0,indm);
ox=outtr(1,:);
oy=outtr(3,:);

outtrBareRING=linepass(BareRING,Z0,indm);
oxBareRING=outtrBareRING(1,:);
oyBareRING=outtrBareRING(3,:);
 

% figure
% plot(sBPM,ox,'b-.')
% hold on
% plot(sBPM,oxBareRING,'r-.')
% hold off


figure
%set(gcf,'color','w')
h1 = subplot(5,1,[1 4]);
plot(sBPM,ox,'b-','LineWidth',2,'DisplayName', 'Horizontal orbit')
hold on
plot(sBPM,oxBareRING,'r-','LineWidth',2,'DisplayName', 'Horizontal orbit bare lattice')
hold off
grid on
set(gca,'fontsize',18);
xlim([0 max(sBPM)])
%set(gca,'xtick',[])
set(gca,'xticklabel',[])
%xlabel('s-position [m]');                 % Add labels
ylabel('Horizontal trajectory [m]');
u = legend('show','Location','NorthWest');
set(u,'FontSize',14)
h2 = subplot(5,1,5);
drawlattice
set(h2,'YTick',[])
set(gca,'FontSize',18)
xlabel('s - position [m]');
linkaxes([h1 h2],'x')
set([h1 h2],'XGrid','On','YGrid','On');
%print('thomx_betatron_phase_lat.png','-dpng','-r300')



    
    
    
    
    