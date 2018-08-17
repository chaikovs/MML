
close all; clear all; clc

%%
tic
flag_plot = 0;
Npermutations = 20000;

for iperm = 1:Npermutations
    
    if rem(iperm,500) == 0
        fprintf('\tPermitation number = %d\n', iperm);
    end
    permIND = randperm(34,16);

   [b, bb] = simulatedannealing(permIND, 1000, 0.92, 650, 6); % 
    
    best_config{iperm} = bb;
    best_sum{iperm} = b;
    
end


% Save
dx_pions = [84.7764   45.7139  120.8345   63.9237  131.3659   95.1043  123.7000  129.3086  110.2734   61.3599   83.2120   90.9556   56.6501   29.0558   42.5475   79.6442];
dx_quads =  [-17.2938  -81.6613 -109.2960  -70.5810 -104.1821  -91.4106  -10.5543  -41.6296 -112.5468  -51.8421 ...
    -49.0235 -123.7255  -63.8511  -65.9240 -135.5756  -72.3196  -17.4613  -44.8338  -40.1657 -129.1990...
    -71.6363  -59.9986  -15.7693  -51.8125 -144.0951 -124.5435  -52.8554  -93.1982 -125.2211 -109.7143  -53.6465  -11.3039 -106.9006  -74.3405];

save('results_SA', 'dx_pions', 'dx_quads', 'best_config', 'best_sum');

toc


%%


for itrial = 1:Npermutations
sum_test(itrial,:) = dx_pions+dx_quads(best_config{itrial});
total_sum_test(itrial) = sum(abs(sum_test(itrial,:)));
end

[best_sum_best, best_sum_indx] = min(total_sum_test);

fprintf('The best configuraion according to sum is %g \n',best_sum_indx)

%%

figure('units','normalized','position',[0.3 0.3 0.45 0.35])
plot(total_sum_test,'.-', 'MarkerSize',10)
% hold on
% plot(max_sum_minvalues_to_plot,'r.-', 'MarkerSize',10)
xlabel('Run number')
ylabel('Total sum [\mum]')
set(gcf,'color','w')
set(gca,'fontsize',18)
grid on
print('QUAD_sorting_SA_totalSUM','-dpng','-r300')

figure('units','normalized','position',[0.3 0.3 0.45 0.35])
plot(sum_test','.-', 'MarkerSize',10)
hold on
plot(sum_test(best_sum_indx,:),'k*-', 'MarkerSize',10, 'LineWidth', 3)
xlabel('Position number')
ylabel('Horizontal sum value [\mum]')
set(gcf,'color','w')
set(gca,'fontsize',18)
grid on
print('QUAD_sorting_res_SA','-dpng','-r300')

figure('units','normalized','position',[0.3 0.3 0.45 0.35])
plot(sum_test(best_sum_indx,:),'k*-', 'MarkerSize',10, 'LineWidth', 3)
xlabel('Position number')
ylabel('Horizontal sum value [\mum]')
set(gcf,'color','w')
set(gca,'fontsize',18)
text(0.5, 10, ['QUAD config: [' num2str(best_config{best_sum_indx}) ' ]'] ,'fontsize',18)
title(['Total abs sum ' num2str(total_sum_test(best_sum_indx)) ' \mum'])
grid on
print('QUAD_sorting_res1_SA','-dpng','-r300')


%% Check

figure('units','normalized','position',[0.3 0.3 0.45 0.35])
plot(dx_pions + dx_centr_magnet(best_config{best_sum_indx}),'ko-', 'MarkerSize',10, 'LineWidth', 3)
hold on
plot(sum_test(best_sum_indx,:),'r*-', 'MarkerSize',10, 'LineWidth', 3)
hold off
xlabel('Position number')
ylabel('Horizontal sum value [\mum]')
set(gcf,'color','w')
set(gca,'fontsize',18)
grid on



