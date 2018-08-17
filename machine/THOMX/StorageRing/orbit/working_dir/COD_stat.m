
trials = 1000;
sigmafielderor = 3e-3;

cod_max_stat = [];
cod_std_stat = [];

for i=1:trials
    
    [cod_max,cod_std] = orbit_anal_dip_apply_error(sigmafielderor,0);
    
    cod_max_stat = [cod_max_stat cod_max];
    cod_std_stat = [cod_std_stat cod_std];
    
end


%%
figure
set(gca,'FontSize',18)
h1=histogram(1e3*cod_max_stat);
h1.FaceColor = 'r';
h1.EdgeColor = 'r';
xlabel('Closed Orbit Distortion max [mm]')
ylabel('Entries');
title(['Closed Orbit Distortion (max) for the dBB ' num2str(sigmafielderor) ' and ' num2str(trials) ' seeds'])
%print('CODmax_dipole_field error3e-3_seeds.png','-dpng','-r300')

figure
set(gca,'FontSize',18)
h2=histogram(1e3*cod_std_stat);
% h2.FaceColor = 'r';
% h2.EdgeColor = 'r';
xlabel('Closed Orbit Distortion rms [mm]')
ylabel('Entries');
title(['Closed Orbit Distortion (rms) for the dBB ' num2str(sigmafielderor) ' and ' num2str(trials) ' seeds'])
%print('CODrms_dipole_field error3e-3_seeds.png','-dpng','-r300')
