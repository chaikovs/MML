function gotolaurent
% GOTOLAURENT - Short cut to PA's Working directory

%
%% Written by Laurent S. Nadolski


if ismac
    cd(fullfile(getenv('HOME'), 'Documents', 'Matlab'));
else
    cd(fullfile(getenv('HOME'), '..', 'data', 'PA'));
end