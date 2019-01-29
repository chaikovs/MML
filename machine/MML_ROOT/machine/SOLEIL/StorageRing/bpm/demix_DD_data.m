function [demix_data]=demix_DD_data(bpm,buffer)
%
% buffer : data one among (X, Z, Va, etc )
DisplayFlag = 0;

FilterFlag=0;%% choose filter to apply: 1 for experimental filter, 0 for theoretical one


filter_filename='/home/operateur/GrpPhysiqueMachine/commun/2011-11-21/demix_filter_2011-11-21_09-03-33.mat';
load(filter_filename)

filter_simu_filename='/home/operateur/GrpDiagnostics/matlab/DserverBPM/TT_Reconstruction/reconstruction/demix_filter_simu.mat';
load(filter_simu_filename)

if FilterFlag
    demix_data=conv(buffer,demix_filter(bpm,:),'same');
else
    demix_data=conv(buffer,filter_coeff,'same');
end

if DisplayFlag
    figure
    plot(buffer,'o-')
    hold on
    plot(demix_data,'x-r')
    grid on
end

