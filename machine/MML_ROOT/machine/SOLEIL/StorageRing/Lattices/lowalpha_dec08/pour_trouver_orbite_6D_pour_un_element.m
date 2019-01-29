%% dessin orbite
figure (1)
plotcod
hold on
drawlattice(0, 0.1)

%% Valeurs
global THERING; %les valeurs sont données en entrée des éléments

ATi= atindex
orbit = findorbit6(THERING,1:length(THERING)+1)
localspos = findspos(THERING,1:length(THERING)+1)

%% entree et sortie C12 dipole 2

ATi.BEND(47)
localspos(ATi.BEND(47))
orbit(:,ATi.BEND(47))
ATi.BEND(48)
localspos(ATi.BEND(48)+1)
orbit(:,ATi.BEND(48)+1)

%% Aimants chicane SDL13 entrée et sortie
ATi.NANO

ATi.NANO(1)
localspos(ATi.NANO(1))
orbit(:,ATi.NANO(1))
localspos(ATi.NANO(1)+1)
orbit(:,ATi.NANO(1)+1)

ATi.NANO(2)
localspos(ATi.NANO(2))
orbit(:,ATi.NANO(2))
localspos(ATi.NANO(2)+1)
orbit(:,ATi.NANO(2)+1)

ATi.NANO(3)
localspos(ATi.NANO(3))
orbit(:,ATi.NANO(3))
localspos(ATi.NANO(3)+1)
orbit(:,ATi.NANO(3)+1)

ATi.NANO(4)
localspos(ATi.NANO(4))
orbit(:,ATi.NANO(4))
localspos(ATi.NANO(4)+1)
orbit(:,ATi.NANO(4)+1)