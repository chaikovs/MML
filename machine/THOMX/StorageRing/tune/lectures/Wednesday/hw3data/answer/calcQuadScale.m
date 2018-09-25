load locoin.mat  

quadscales = FitParameters(1).Values(1:end-14)./FitParameters(end).Values(1:end-14);
figure
plot(quadscales)
title('Quadrupole scaling factors for correction')

pause

QFscale(1:2) = quadscales(1:2);%FitParameters(1).Values(1:2)./FitParameters(le).Values(1:2);
QFscale(3:6) = quadscales(3);%FitParameters(1).Values(3)/FitParameters(le).Values(3);
QFscale(7:28) = quadscales(4:25);%FitParameters(1).Values(4:25)./FitParameters(le).Values(4:25);
QDscale(1:2) = quadscales(26:27);%FitParameters(1).Values(26:27)./FitParameters(le).Values(26:27);
QDscale(3:6) = quadscales(28);%FitParameters(1).Values(28)/FitParameters(le).Values(28);
QDscale(7:28) = quadscales(29:50);%FitParameters(1).Values(29:50)./FitParameters(le).Values(29:50);
QFCscale = quadscales(51);%FitParameters(1).Values(51)/FitParameters(le).Values(51);
QDXscale = quadscales([52 53 54 52]);%FitParameters(1).Values([52 53 54 52])'./FitParameters(le).Values([52 53 54 52])';
QFXscale = quadscales([55 56 57 55]);%FitParameters(1).Values([55 56 57 55])'./FitParameters(le).Values([55 56 57 55])';
QDYscale = quadscales([58 59 60 58]);%FitParameters(1).Values([58 59 60 58])'./FitParameters(le).Values([58 59 60 58])';
QFYscale = quadscales([61 62 63 61]);%FitParameters(1).Values([61 62 63 61])'./FitParameters(le).Values([61 62 63 61])';
QDZscale = quadscales([64 65 66 64]);%FitParameters(1).Values([64 65 66 64])'./FitParameters(le).Values([64 65 66 64])';
QFZscale = quadscales([67 68 69 67]);%FitParameters(1).Values([67 68 69 67])'./FitParameters(le).Values([67 68 69 67])';
Q9Sscale = quadscales(70:72);%FitParameters(1).Values(70:72)'./FitParameters(le).Values(70:72)';


%% skew quad
SkewK_LOCO = FitParameters(end).Values(73:end);

%you also need to correct coupling
sqdev = getlist('SkewQuad')

