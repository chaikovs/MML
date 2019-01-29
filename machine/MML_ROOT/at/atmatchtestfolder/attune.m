function NU=attune(RING)

[LinData,NU] = linopt(RING,0);
NU = NU';