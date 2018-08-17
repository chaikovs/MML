

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
Npermutations = 5000;


% sigmafielderor = 1e-2;
% fielderror = sigmafielderor*randn(1,14);
% dBB0 = fielderror;



for iperm = 1:Npermutations
    
    if rem(iperm,100) == 0
        fprintf('\tPermitation number = %d\n', iperm);
    end
    permIND = randperm(8,8);
%     permIND = randperm(13,8);
    s = dBB0(permIND);
    dipNDnew = dipND(permIND); % real numbering of the DIPOLES
    
    %[b, bb, bind, w, ww, wind] = simulatedannealing(s,dipNDnew,100, 0.9, 700, 6); %simulatedannealing(s,dipNDnew,100, 0.7, 600, 6)
   [b, bb, bind, w, ww, wind] = simulatedannealing(s,dipNDnew, 600, 0.71, 460, 4);  % 3converging 600
    
    bestperm{iperm} = bind;
    bestdBB0{iperm} = bb;
    bestCOD{iperm} = b;
    worseperm{iperm} = wind;
    worsedBB0{iperm} = ww;
    worseCOD{iperm} = w;
    %dBB0init{iperm} = s;
    
    
end

% Save
dipINDinit = dipND;
dBB0init = dBB0;
save(OutputFileName, 'dBB0init', 'bestperm', 'bestdBB0', 'bestCOD', 'worseperm', 'worsedBB0','worseCOD','dipINDinit');

fprintf('   File %s was created \n', OutputFileName);
toc

%%

