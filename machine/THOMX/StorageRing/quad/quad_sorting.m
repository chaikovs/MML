
clear all; close all; clc;

%% compare with SA


fprintf('Some results for the QUAD sorting \n')

num_quad = 34;
num_pos = 16;

dx_centr_magnet = dx_quads;

fprintf(' %g QUAD to be sorted at %g positions \n',num_quad, num_pos)


%%
fprintf('Some results for the QUAD sorting \n')

num_quad = 34;
num_pos = 16;
dx_pions_m = TruncatedGaussian(100e-6, [10e-6 150e-6], 1, num_pos); %100e-6*randn(1,num_ring);
dx_centr_magnet_m = TruncatedGaussian(100e-6, [-10e-6 -150e-6], 1, num_quad);%100e-6*randn(1,num_quad);

dx_pions = 1e6*dx_pions_m;
dx_centr_magnet = 1e6*dx_centr_magnet_m;

fprintf(' %g QUAD to be sorted at %g positions \n',num_quad, num_pos)

%%

n_quad_to_sort = num_quad;
dx_centr_magnet_sort = dx_centr_magnet;
quad_indx = 1:num_quad;
quad_indx_sort = quad_indx;
pos_indx = 1:num_pos;
pos_indx_sort = pos_indx;
irun = 0;

while irun < num_pos
    
     pos_indx_sort = circshift(pos_indx_sort, 1);
     dx_pions = circshift(dx_pions, 1);
    
for ipos = 1:num_pos
    
    for iquad = 1:n_quad_to_sort
        
        sum_sorting_temp(iquad) = dx_pions(ipos) + dx_centr_magnet_sort(iquad);
        
    end
    
        [sum_sorting_min_abs(ipos), sum_sorting_min_indx(ipos)] = min(abs(sum_sorting_temp));
        
        sum_sorting_min(ipos) = sum_sorting_temp(sum_sorting_min_indx(ipos));
        
        quad_indx_pos(ipos) = quad_indx_sort(sum_sorting_min_indx(ipos));
        
        sum_sorting{ipos} = sum_sorting_temp;
    
dx_centr_magnet_sort(sum_sorting_min_indx(ipos)) = [];
quad_indx_sort(sum_sorting_min_indx(ipos)) = [];

n_quad_to_sort = n_quad_to_sort - 1;
        
sum_sorting_temp = [];

end

run_res.quad_indx_init{irun+1} = quad_indx;
run_res.dx_centr_magnet_init{irun+1} = dx_centr_magnet;
run_res.dx_pions_init{irun+1} = dx_pions;
run_res.sum_minvalues{irun+1} = sum_sorting_min;  
run_res.sum_minindx{irun+1} = sum_sorting_min_indx;
run_res.sum_sorting_res{irun+1} = sum_sorting;
run_res.quad_indx{irun+1} = quad_indx_pos;
run_res.position_order{irun+1} = pos_indx_sort;

irun = irun + 1;

fprintf('Configuration %s is tested \n', num2str(pos_indx_sort))

%fprintf('Run %g is completed \n', irun)

n_quad_to_sort = num_quad;
dx_centr_magnet_sort = dx_centr_magnet;
quad_indx = 1:num_quad;
quad_indx_sort = quad_indx;

end

%%

for ipos = 1:num_pos
    
sum_minvalues_to_plot(ipos,:) = run_res.sum_minvalues{ipos};

total_sum_minvalues_to_plot(ipos) = sum(abs(sum_minvalues_to_plot(ipos,:)));

max_sum_minvalues_to_plot(ipos) = max(abs(sum_minvalues_to_plot(ipos,:)));

end

[best_config_max, best_config_max_indx] = min(max_sum_minvalues_to_plot);
[best_config_sum, best_config_sum_indx] = min(total_sum_minvalues_to_plot);

%%


fprintf('The best configuraion according max is %g and according to sum is %g \n',best_config_max_indx, best_config_sum_indx)


%%

figure('units','normalized','position',[0.3 0.3 0.45 0.35])
plot(sum_minvalues_to_plot(best_config_sum_indx,:),'k*-', 'MarkerSize',10, 'LineWidth', 3)
hold on
plot(sum_minvalues_to_plot','.-', 'MarkerSize',10)
xlabel('Position number')
ylabel('Horizontal sum min value [\mum]')
set(gcf,'color','w')
set(gca,'fontsize',18)
grid on
print('QUAD_sorting_res_SORT','-dpng','-r300')

figure('units','normalized','position',[0.3 0.3 0.45 0.35])
plot(dx_pions(run_res.position_order{best_config_sum_indx}) + dx_centr_magnet(run_res.quad_indx{best_config_sum_indx}),'ko-', 'MarkerSize',10, 'LineWidth', 3)
xlabel('Position number')
ylabel('Horizontal sum value [\mum]')
set(gcf,'color','w')
set(gca,'fontsize',18)
grid on
title(['Total abs sum ' num2str(total_sum_minvalues_to_plot(best_config_sum_indx)) ' \mum'])
text(0.3, 10, ['Positions: [' num2str(run_res.position_order{best_config_sum_indx}) ' ]'] ,'fontsize',18)
text(0.3, 7, ['QUAD config: [' num2str(run_res.quad_indx{best_config_sum_indx}) ' ]'] ,'fontsize',18)
print('QUAD_sorting_res1_SORT','-dpng','-r300')


figure('units','normalized','position',[0.3 0.3 0.45 0.35])
plot(total_sum_minvalues_to_plot,'.-', 'MarkerSize',10)
hold on
plot(max_sum_minvalues_to_plot,'r.-', 'MarkerSize',10)
xlabel('Run number')
ylabel('Total sum or Max [\mum]')
set(gcf,'color','w')
set(gca,'fontsize',18)
grid on
print('QUAD_sorting_total_summax_SORT','-dpng','-r300')





