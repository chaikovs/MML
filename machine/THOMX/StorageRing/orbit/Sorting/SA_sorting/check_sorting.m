function [spos, array_worse, array_best, max_worse, max_best] = check_sorting(filename, magn_field_err)


%filename = '2017-04-25/11-02-04/sort_full_COD_2017-04-25_11-02-03.mat';

COD14 = load(['/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/SORTING/' filename]);

%magn_field_err = 'dBB200A.mat';

load(magn_field_err)

%%
Nperm = length(COD14.bestCOD);

bestCODt= cell2mat(COD14.bestCOD);
bestCODtt = mat2str(bestCODt);
bestCOD = str2num(bestCODtt);
%[bestCODmax, bestit] = min(bestCOD);

%bestit = bestit+5;

worseCODt= cell2mat(COD14.worseCOD); 
worseCODtt = mat2str(worseCODt); 
worseCOD = str2num(worseCODtt);
%[worseCODmax, worseit] = max(worseCOD);

%worseit = worseit + 5;

%%

% bestind = COD14.bestperm;
% worseind = COD14.worseperm;
% % 
% bestind1= [bestind{:}];
% bestind2 = reshape(bestind1,[8 5000]);
% 
% A = bestind2(:,any(bestind2));
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
% zeros_elem = sort([indWORST_zero indBEST_zero]);


%%

perm_loop = 1:Nperm;
%perm_loop(zeros_elem) = [];


for iperm = perm_loop %[1:239 241:1123 1125:1382 1384:Nperm]

    if rem(iperm,500) == 0
        fprintf('\t\tPermutation = %d\n', iperm);
    end
    
bestind200A = COD14.bestperm{iperm};
worseind200A = COD14.worseperm{iperm};


%% Check with AT @ 159 A


%global THERING
TDR_017_064_r56_02_sx_Dff412_DipMagnL_chro00

BENDI = findcells(THERING,'FamName','BEND');

%%
worsedBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), worseind200A ));
dBB = worsedBB0;

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = dBB(i);
        
end

[spos, orbitww] = get_orbit;  

% std(orbit(1,:)*1e3)
%%

bestdBB0 = dBB0(arrayfun(@(x) find(dipND == x,1,'first'), bestind200A ));
dBB = bestdBB0;

TDR_017_064_r56_02_sx_Dff412_DipMagnL_chro00

for i = 1:length(BENDI)
        
 THERING{BENDI(i)}.ByError = dBB(i);
        
end

[spos, orbitbb] = get_orbit; 
%clf

array_worse(:, iperm) = orbitww(1,:);
array_best(:, iperm) = orbitbb(1,:);

max_worse(:, iperm) = max(abs(orbitww(1,:)));
max_best(:, iperm) = max(abs(orbitbb(1,:)));

end


