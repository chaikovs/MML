 
flag_save = 0;
KQP41 = 8.6225;
KQP1 = 4.5281;
KQP4 = 15.1832;
KQP3 = 17.7426;

%% hor

%QMS = quadcenterinit('QP1',[1 1],1);
%QMS = quadcenterinit('QP41',[1 4],1);
% QMS = quadcenterinit('QP4',[1 5],1);
QMS = quadcenterinit('QP3',[1 6],1);

%% vert

% QMS = quadcenterinit('QP1',[1 1],2);
% QMS = quadcenterinit('QP41',[1 4],2);
% QMS = quadcenterinit('QP4',[1 5],2);
QMS = quadcenterinit('QP3',[1 6],2);
 
 %%
 
 deltaK = 0.1:0.3:3.3;
 CorrDeltaH = 5e-6:5e-6:1e-4;
 %CorrDeltaV = 1e-6:1e-6:1e-5;
 %% Check kick value
 
TDR_good_017_064_r56_02_sx_Dff_BPM
for ih = 1:10
    setsp('VCOR', CorrDeltaV(ih), [2 6]);
    get_orbit
    legendInfo{ih} = ['K = ' num2str(1e6*CorrDeltaV(ih)) ' urad'];    
    u=legend(legendInfo)
    set(u,'Location','SouthEast')
    setsp('VCOR', 0, [2 6]);
end

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/orbit_change_by_VCOR26.pdf')
end 
 %% Check kick value
 
TDR_good_017_064_r56_02_sx_Dff_BPM
for ih = 1:10
    setsp('VCOR', CorrDeltaV(ih), [2 1]);
    get_orbit
    legendInfo{ih} = ['K = ' num2str(1e6*CorrDeltaV(ih)) ' urad'];    
    u=legend(legendInfo)
    set(u,'Location','SouthEast')
    setsp('VCOR', 0, [2 1]);
end

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/orbit_change_by_VCOR21.pdf')
end 

%%
TDR_good_017_064_r56_02_sx_Dff_BPM
for ih = 1:1:10
    setsp('HCOR', CorrDeltaH(ih), [2 3]);
    get_orbit
    legendInfo{ih} = ['K = ' num2str(1e6*CorrDeltaH(ih)) ' \murad'];    
    u=legend(legendInfo)
    set(u,'Location','SouthEast')
    setsp('HCOR', 0, [2 3]);
end

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/orbit_change_by_HCOR23.pdf')
end
 
 %%
 
 for i = 1:length(deltaK)
     QMS.QuadDelta = deltaK(i);
     for j = 1:length(CorrDeltaH)
     QMS.CorrDelta = CorrDeltaH(j);
     
    QMSt = quadcenter(QMS);
    center(i,j) = QMSt.Center;
    centerstd(i,j) = QMSt.CenterSTD;
     
     end
 end
 
 
 %%
 
% save('horscan_QP3_BPMx13', 'center', 'centerstd','deltaK', 'CorrDeltaH');
 
save('verscan_QP3_BPMZ13', 'center', 'centerstd','deltaK', 'CorrDeltaH');


%%

a_mx  =max(1e3*CorrDeltaH);
a_mn  = min(1e3*CorrDeltaH);

b_mx  = max(100*deltaK(1:end)/KQP1);
b_mn  = min(100*deltaK(1:end)/KQP1);


XI = linspace(a_mn,a_mx,50);
YI = linspace(b_mn,b_mx,50);


[XI_l,YI_l] = meshgrid(XI,YI);

ZI_l = griddata(1e3*CorrDeltaH,100*deltaK(1:end)/KQP1,center(1:end,:),XI_l,YI_l);
ZI_l2 = griddata(1e3*CorrDeltaH,100*deltaK(1:end)/KQP1,centerstd(1:end,:),XI_l,YI_l);
ZI_l3 = griddata(1e3*CorrDeltaH,100*deltaK(1:end)/KQP1,100* centerstd(1:end,:)./center,XI_l,YI_l);


figure(19)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 1] QP1 [1 1] Center parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/center_scan_BPMz11.pdf')
end

figure(20)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l2)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 1] QP1 [1 1] Center std parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstd_scan_BPMz11.pdf')
end

figure(21)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l3)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 1] QP1 [1 1] Center std [%] parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstdrel_scan_BPMz11.pdf')
end

 
 %% QP1 BPM [1 1]

KQP1 = 4.5281;
figure
set(gca,'FontSize',16)
pcolor(1e3*CorrDeltaH, 100*deltaK(1:end)/KQP1, center(1:end,:))
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 1] QP1 [1 1] Center parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/center_scan_BPMz11.pdf')
end


figure
set(gca,'FontSize',16)
pcolor( 1e3*CorrDeltaH, 100*deltaK(1:end)/KQP1,centerstd(1:end,:))
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 1] QP1 [1 1] Center std parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstd_scan_BPMz11.pdf')
end

figure
set(gca,'FontSize',16)
pcolor(1e3*CorrDeltaH, 100*deltaK(1:end)/KQP1,centerstd(1:end,:)./center(1:end,:))
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 1] QP1 [1 1] Center std [%] parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstdrel_scan_BPMz11.pdf')
end

%%  QP41 BPM [1 2]


figure
set(gca,'FontSize',16)
pcolor(1e3*CorrDeltaH, 100*deltaK/KQP41, center)
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMx [1 2] QP41 [1 4] Center parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/center_scan_BPMx12.pdf')
end


figure
set(gca,'FontSize',16)
pcolor( 1e3*CorrDeltaH, 100*deltaK/KQP41,centerstd)
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMx [1 2] QP41 [1 4] Center std parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstd_scan_BPMx12.pdf')
end

figure
set(gca,'FontSize',16)
pcolor(1e3*CorrDeltaH, 100*deltaK/KQP41,centerstd./center)
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMx [1 2] QP41 [1 4] Center std [%] parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstdrel_scan_BPMx12.pdf')
end

%% QP41 BPM [1 2]

a_mx  =max(1e3*CorrDeltaH);
a_mn  = min(1e3*CorrDeltaH);

b_mx  = max(100*deltaK(1:end-2)/KQP41);
b_mn  = min(100*deltaK(1:end-2)/KQP41);


XI = linspace(a_mn,a_mx,50);
YI = linspace(b_mn,b_mx,50);


[XI_l,YI_l] = meshgrid(XI,YI);

ZI_l = griddata(1e3*CorrDeltaH,100*deltaK(1:end-2)/KQP41,center(1:end-2,:),XI_l,YI_l);
ZI_l2 = griddata(1e3*CorrDeltaH,100*deltaK(1:end-2)/KQP41,centerstd(1:end-2,:),XI_l,YI_l);
ZI_l3 = griddata(1e3*CorrDeltaH,100*deltaK(1:end-2)/KQP41,100*centerstd(1:end-2,:)./center(1:end-2,:),XI_l,YI_l);


figure(19)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMx [1 2] QP41 [1 4] Center parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/center_scan_BPMx12_wo2.pdf')
end


figure(20)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l2)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMx [1 2] QP41 [1 4] Center std parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstd_scan_BPMx12_wo2.pdf')
end

figure(21)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l3)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMx [1 2] QP41 [1 4] Center std [%] parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstdrel_scan_BPMx12_wo2.pdf')
end

%% QP4 BPM [1 2]

a_mx  =max(1e3*CorrDeltaH);
a_mn  = min(1e3*CorrDeltaH);

b_mx  = max(100*deltaK(1:end)/KQP4);
b_mn  = min(100*deltaK(1:end)/KQP4);


XI = linspace(a_mn,a_mx,50);
YI = linspace(b_mn,b_mx,50);


[XI_l,YI_l] = meshgrid(XI,YI);

ZI_l = griddata(1e3*CorrDeltaH,100*deltaK(1:end)/KQP4,center(1:end,:),XI_l,YI_l);
ZI_l2 = griddata(1e3*CorrDeltaH,100*deltaK(1:end)/KQP4,centerstd(1:end,:),XI_l,YI_l);
ZI_l3 = griddata(1e3*CorrDeltaH,100*deltaK(1:end)/KQP4,100*centerstd(1:end,:)./center(1:end,:),XI_l,YI_l);


figure(19)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 2] QP4 [1 5] Center parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/center_scan_BPMz12_QP4.pdf')
end


figure(20)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l2)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 2] QP4 [1 5] Center std parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstd_scan_BPMz12_QP4.pdf')
end

figure(21)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l3)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 2] QP4 [1 5] Center std [%] parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstdrel_scan_BPMz12_QP4.pdf')
end


%% QP3 BPM [1 3]

a_mx  =max(1e3*CorrDeltaH);
a_mn  = min(1e3*CorrDeltaH);

b_mx  = max(100*deltaK(1:end)/KQP3);
b_mn  = min(100*deltaK(1:end)/KQP3);


XI = linspace(a_mn,a_mx,50);
YI = linspace(b_mn,b_mx,50);


[XI_l,YI_l] = meshgrid(XI,YI);

ZI_l = griddata(1e3*CorrDeltaH,100*deltaK(1:end)/KQP3,center(1:end,:),XI_l,YI_l);
ZI_l2 = griddata(1e3*CorrDeltaH,100*deltaK(1:end)/KQP3,centerstd(1:end,:),XI_l,YI_l);
ZI_l3 = griddata(1e3*CorrDeltaH,100*deltaK(1:end)/KQP3,100*centerstd(1:end,:)./center(1:end,:),XI_l,YI_l);


figure(19)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 3] QP3 [1 6] Center parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/center_scan_BPMz13.pdf')
end


figure(20)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l2)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 3] QP3 [1 6] Center std parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstd_scan_BPMz13.pdf')
end

figure(21)
set(gca,'FontSize',16)
pcolor(XI_l,YI_l,ZI_l3)
shading interp
colorbar
xlabel('CorrDelta [mrad]')
ylabel('deltaK [%]')
title('BPMz [1 3] QP3 [1 6] Center std [%] parameter scan for BBA')

if (flag_save == 1)
set(gcf, 'color', 'w');
export_fig('Figs/centerstdrel_scan_BPMz13.pdf')
end


