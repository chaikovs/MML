function lambda = getbetaKL(Family, DeviceList)

% Integrated gradient
KL = getkleff(Family, DeviceList);

lambda = zeros(2,length(KL));

% betax at entrance of magnet
[bx bz] = modelbeta(Family, DeviceList);

lambda(1,:) = abs(KL).*bx; 
lambda(2,:) = abs(KL).*bz; 