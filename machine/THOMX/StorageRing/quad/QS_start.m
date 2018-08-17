
clear all; close all; clc;

%%

num_quad = 34;
num_pos = 16;
dx_pions_m = TruncatedGaussian(100e-6, [20e-6 110e-6], 1, num_pos); %100e-6*randn(1,num_ring);
dx_centr_magnet_m = TruncatedGaussian(100e-6, [-20e-6 -110e-6], 1, num_quad);%100e-6*randn(1,num_quad);

dx_pions = 1e6*dx_pions_m;
dx_centr_magnet = 1e6*dx_centr_magnet_m;


%%

% for iqring = 1:num_pos
%     
%    for iquad = 1:num_quad
%        
%     sum_hor(iqring,iquad) = dx_pions(iqring) + dx_centr_magnet(iquad);
%     
%    end
%     
% end

%%

% figure(1)
% set(gcf,'color','w')
% set(gca,'fontsize',18)
% imagesc(dx_centr_magnet, dx_pions,sum_hor);
% %imagesc(sum_hor);
% shading interp;
% grid on
% hold off
% colorbar
% %print('quad_imgsc','-dpng','-r300')

%%
% 
% figure('units','normalized','position',[0.3 0.3 0.45 0.35])
% % plot(sum_hor(1,:),'*-', 'MarkerSize',10)
% % hold on
% plot(sum_hor','.-', 'MarkerSize',10)
% xlabel('QUAD number')
% ylabel('Horizontal sum [\mum]')
% set(gcf,'color','w')
% set(gca,'fontsize',18)
% grid on



%%

% figure(3)
% set(gca,'FontSize',16)
% % pcolor(dx_centr_magnet, dx_pions,sum_hor)
% pcolor(sum_hor)
% shading flat
% colorbar
% xlabel('\Deltax magnetic center [\mum]')
% ylabel('\Deltax pions [\mum]')
% set(gcf,'color','w')
% set(gca,'fontsize',18)

%%

% figure(4)
% bar3(sum_hor)
% set(gcf,'color','w')
% set(gca,'fontsize',18)

%%

%[~, indx] = find(and(sum_hor(1,:)<5,sum_hor(1,:)>-5))

%%

% [~, imin] = min(abs(sum_hor(1,:)));
% sum_hor(1,imin)

%%

% [~, imin] = min(abs(sum_hor),[],2);
% 
% 
% for iqring = 1:num_ring
% 
%     sum_opt(iqring) = sum_hor(iqring,imin(iqring));
%     QUAD_opt(iqring) = imin(iqring);
%     
% end
% 
% figure
% plot(sum_opt,'.-')
% 
% figure
% histogram(sum_opt,16)

%% 

% [B_magnet, I_magnet] = sort(dx_centr_magnet,'descend')
% [B_pions, I_pions] = sort(dx_pions)
% 
% B_pions+B_magnet(1:16)

%%
% n = 10;
% x = rand(1,n);
% y = zeros(1,n);%rand(1,n);
% 
% % solution
% [A,B] = meshgrid(2:n,1:n-1);            %pairwise indices - all combinations
% D = (x(A)-x(B)).^2 + (y(A)-y(B)).^2;    %distance squared between each pair
% D(tril(ones(n-1),-1)==1) = inf;         %all values below diagonal => inf
% [row,col] = find(D==min(D(:)));         %locate smallest distance
% closest = [A(row,col) B(row,col)];      %indices of closest 2 points
% 
% % display results
% plot(x,y,'b.',x(closest),y(closest),'ro')
% axis equal

%%

n_quad_to_sort = num_quad;
dx_centr_magnet_sort = dx_centr_magnet;
quad_indx = 1:num_quad;
quad_indx_sort = quad_indx;

for ipos = 1:num_pos
    
    for iquad = 1:n_quad_to_sort
        
        sum_sorting_temp(iquad) = dx_pions(ipos) + dx_centr_magnet_sort(iquad);
        
    end
    
        [sum_sorting_min(ipos), sum_sorting_min_indx(ipos)] = min(sum_sorting_temp);
        
        quad_indx_pos(ipos) = quad_indx_sort(sum_sorting_min_indx(ipos));
        
        sum_sorting{ipos} = sum_sorting_temp;
    
dx_centr_magnet_sort(sum_sorting_min_indx(ipos)) = [];
quad_indx_sort(sum_sorting_min_indx(ipos)) = [];

n_quad_to_sort = n_quad_to_sort - 1;
        
sum_sorting_temp = [];

end

%%
% run_res.quad_indx_init = quad_indx;
% run_res.dx_centr_magnet_init = dx_centr_magnet;
% run_res.dx_pions_init = dx_pions;
% run_res.sum_minvalues = sum_sorting_min;  
% run_res.sum_minindx = sum_sorting_min_indx;
% run_res.sum_sorting_res = sum_sorting;
% run_res.quad_indx = quad_indx_pos;

%%


figure('units','normalized','position',[0.3 0.3 0.45 0.35])
plot(sum_sorting_min','*-', 'MarkerSize',10)
xlabel('Position number')
ylabel('Horizontal sum min value [\mum]')
set(gcf,'color','w')
set(gca,'fontsize',18)
grid on

