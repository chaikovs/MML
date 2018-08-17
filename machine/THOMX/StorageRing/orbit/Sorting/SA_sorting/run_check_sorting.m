
%%


% filename = '2017-04-25/11-02-04/sort_full_COD_2017-04-25_11-02-03.mat';
% filename = '2017-04-26/18-16-34/sort_full_COD_2017-04-26_18-16-33.mat';
%filename = '2017-04-27/19-08-23/sort_full_COD_2017-04-27_19-08-23.mat'; % 8DIP 5000 perm
filename = '2017-04-30/20-48-35/sort_full_COD_2017-04-30_20-48-35.mat'; % 8DIP wo the worse 5000 perm

% magn_field_err159A = 'dBB0.mat';
% magn_field_err256A = 'dBB256A.mat';
magn_field_err159A = 'dBB0_worseRemoved.mat';
magn_field_err256A = 'dBB256A_worseRemoved.mat';

%%

[spos159A, array_worse159A, array_best159A, max_worse159A, max_best159A] = check_sorting(filename, magn_field_err159A);

%%

[spos256A, array_worse256A, array_best256A, max_worse256A, max_best256A] = check_sorting(filename, magn_field_err256A);

%%

save('sorting_results_worseRemoved', 'spos159A', 'array_worse159A', 'array_best159A', 'max_worse159A', 'max_best159A','spos256A', 'array_worse256A', 'array_best256A', 'max_worse256A', 'max_best256A' )

%%

% [~, in] = find(max_best256A==0)
% max_best159A(in) = [];
% max_best256A(in) = [];


figure
set(gca,'FontSize',18)
plot(max_best159A,max_best256A,'.', 'Markersize',10)
%print('dipole_sort.png','-dpng','-r300')

 %min([max_best159A(:); max_best256A(:)])
 
 %find(max_best159A == min(max_best159A(:)))
 
 %find(max_best256A == min(max_best256A(:)))
 
 figure
set(gca,'FontSize',18)
plot(max_worse159A,max_worse256A,'.', 'Markersize',10)
 
 %%
% [~, ind] = find(max_best256A<=0.0024 & max_best159A<=0.0024);
% [~, ind] = find(max_best256A<=0.0018391469156 & max_best159A<=0.00080663 & max_best159A~=0 & max_best256A~=0)%0.0008064871675136  0.00183914691557
[~, ind_worse] = find(max_worse256A>=0.0109 & max_worse159A>=0.009277)

%[~, ind] = find(max_best256A<=0.0024966763 & max_best159A<=0.00202658495 & max_best159A~=0 & max_best256A~=0)
%[~, ind_worse] = find(max_worse256A>=0.013121210083639122 & max_worse159A>=0.012045546019674)
%%

% COD14 = load(['/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/' filename]);
% 
% bestind = COD14.bestperm;
% worseind = COD14.worseperm;
% % 
% bestind1= [bestind{:}];
% bestind2 = reshape(bestind1,[8 5000]);
% 
% A = bestind2(:,any(bestind2));
% 
% %bestind2(:, find(sum(abs(bestind2)) == 0)) = []
% 
% worseind1= [worseind{:}];
% worseind2 = reshape(worseind1,[8 5000]);
% 
% B = worseind2(:,any(worseind2));
% 
% q = any(worseind2);
% qq = any(bestind2);
% [~, indWORST_zero] = find(q==0);
% [~, indBEST_zero] = find(qq==0);
% 
% zeros_elem = sort([indWORST_zero indBEST_zero])



