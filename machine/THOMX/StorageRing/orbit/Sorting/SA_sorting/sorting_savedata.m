
dir_to_save = '/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting';

%%
method = 'COD';
c = clock;
DirectoryName = [dir_to_save, 'SORTING', filesep];
DirectoryName = sprintf('%s%s', DirectoryName, datestr(c,29));  % Year-Month-Day
DirectoryName = [DirectoryName, filesep, sprintf('%02d-%02d-%02.0f', c(4), c(5), c(6)) '/'];  % Hour-Minute-Second
FileName = appendtimestamp(['sort_' method]);
OutputFileName = [DirectoryName FileName '.mat'];

% Create the directory
DirStart = pwd;
[DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
cd(DirStart);

%%

[b, bb, bind, w, ww, wind] = simulatedannealing(dBB0,dipIND,100,0.9,700,6);

%%
flag_plot = 1;
[Xbest, Xprimebest, Wbest, Sbest] = plotsorting(bb, method, 'best', flag_plot);
[Xworse, Xprimeworse, Wworse, Sworse] = plotsorting(ww, method, 'worse', flag_plot);

%%

Sorting.dBB0 = dBB0;
Sorting.bestperm = bind;
Sorting.bestdBB0 = bb;
Sorting.bestsposition = Sbest;  
Sorting.worsesposition = Sworse;  
Sorting.worseperm = wind;
Sorting.worsedBB0 = ww;
Sorting.bestorbit = Xbest;
Sorting.worseorbit = Xworse;
Sorting.bestslope = Xprimebest;
Sorting.worseslope = Xprimeworse;
Sorting.bestcsi = Wbest;
Sorting.worsecsi = Wworse;
Sorting.PassMethod = method;

% Save
save(OutputFileName, 'Sorting');

%%

clear all; close all; clc;
cd /Users/ichaikov/Documents/MATLAB/thomx-mml
startup
setpaththomx
cd /Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting

%% 13 dipoles

dir_to_save = '/Users/ichaikov/Documents/MATLAB/thomx-mml/machine/THOMX/StorageRing/orbit/Sorting/SA_sorting/';
method = 'COD';
c = clock;
DirectoryName = [dir_to_save, 'SORTING', filesep];
DirectoryName = sprintf('%s%s', DirectoryName, datestr(c,29));  % Year-Month-Day
DirectoryName = [DirectoryName, filesep, sprintf('%02d-%02d-%02.0f', c(4), c(5), c(6)) '/'];  % Hour-Minute-Second
FileName = appendtimestamp(['sort_full_' method]);
OutputFileName = [DirectoryName FileName '.mat'];

% Create the directory
DirStart = pwd;
[DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
cd(DirStart);


%%
tic
flag_plot = 0;
Npermutations = 100;


% sigmafielderor = 1e-2;
% fielderror = sigmafielderor*randn(1,14);
% dBB0 = fielderror;



for iperm = 1:Npermutations
    
    if rem(iperm,10) == 0
        fprintf('\tPermitation number = %d\n', iperm);
    end
    %permIND = randperm(8,8);
    permIND = randperm(13,8);
    s = dBB0(permIND);
    dipNDnew = dipND(permIND); % real numbering of the DIPOLES
    
    %[b, bb, bind, w, ww, wind] = simulatedannealing(s,dipNDnew,100, 0.9, 700, 6); %simulatedannealing(s,dipNDnew,100, 0.7, 600, 6)
   [b, bb, bind, w, ww, wind] = simulatedannealing(s,dipNDnew, 600, 0.71, 460, 4);  % 3converging 
    
    bestperm{iperm} = bind;
    bestdBB0{iperm} = bb;
    bestCOD{iperm} = b;
    worseperm{iperm} = wind;
    worsedBB0{iperm} = ww;
    worseCOD{iperm} = w;
    
    
end

% Save
dipINDinit = dipND;
dBB0init = dBB0;
save(OutputFileName, 'dBB0init', 'bestperm', 'bestdBB0', 'bestCOD', 'worseperm', 'worsedBB0','worseCOD','dipINDinit');

fprintf('   File %s was created \n', OutputFileName);
toc
%%

