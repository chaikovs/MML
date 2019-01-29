function [demix_data]=demix_DD_data(bpm,buffer)

filter_filename='/home/operateur/GrpPhysiqueMachine/commun/2011-11-21/demix_filter_2011-11-21_09-03-33.mat';
load(filter_filename)

demix_data=conv(buffer,demix_filter(bpm,:),'same');

figure
plot(buffer,'o-')
hold on
plot(demix_data,'x-r')
grid on

