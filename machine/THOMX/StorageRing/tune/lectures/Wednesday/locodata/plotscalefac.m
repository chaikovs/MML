
%***********************
load loco_test.mat

quadscales = FitParameters(1).Values(1:72)./FitParameters(end).Values(1:72);
figure
plot(quadscales)
title('Quadrupole scaling factors for correction')
grid on
