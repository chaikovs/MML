%% Tracé des fonctions beta
plotbeta

%% Valeurs
global THERING;%les valeurs sont données en entrée des éléments

localspos = findspos(THERING,1:length(THERING)+1)
[TD, tune] = twissring(THERING,0,1:(length(THERING)+1))
BETA = cat(1,TD.beta)
ATi= atindex
[Dx, Dy, Sx, Sy] = modeldisp

modeltune

%% SDC03 - milieu de WSV50

ATi.SDAC1

ATi.SDAC1(4)
localspos(ATi.SDAC1(4))
BETA(ATi.SDAC1(4),:)
Dx(ATi.SDAC1(4))

%% PHC1

ATi.BEND
ATi.BEND(8)
localspos(ATi.BEND(8))
BETA(ATi.BEND(8),:)
Dx(ATi.BEND(8))
