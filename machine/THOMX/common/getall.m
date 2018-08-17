function getall
%GETALL - Creates proxy for all magnet (typically used once at initialization)
%

% 
% Written by Laurent S. Nadolski, April 2004
%
% TODO
% Where are stored the Proxies ? see with handles (location for storing w/ EPICS)

%getam(cellstr(liste(1:end-4,:)))

liste = cellstr(getfamilylist);

%% BPM
figure
subplot(2,1,1)
plot(getam(liste{1}));
title('BPM')
subplot(2,1,2)
plot(getam(liste{2}));

pause(0.2)
%% CORRECTOR
figure
subplot(2,1,1)
bar(getam(liste{3}));
title('CORR')
subplot(2,1,2)
bar(getam(liste{4}));
pause(0.2)

%% QUAD ans SEXT

figure
for k = 6:11 
    subplot(3,2,k-5)
    bar(getam(liste{k}))
end
suptitle('QUAD')
pause(0.2)

figure
for k = 13:15 
    subplot(2,2,k-12)
    bar(getam(liste{k}))
end
suptitle('SEXT')
pause(0.2)
