%
devAILES = 'ans-c03/dg/calc-d1-position-angle';
devSMIS = 'ans-c02/dg/calc-d1-position-angle';



% bump AILES
%%[OCS, OCS0] = setorbitbump('BPMz',[3 3;3 4],[-0.1; -0.1],'VCOR',[-2 -1 1 2],'Display');


% bump SMIS
[OCS, OCS0] = setorbitbump('BPMz',[2 3;2 4],[0.1; 0.1],'VCOR',[-2 -1 1 2],'Display');


posZ_AILES = readattribute([devAILES '/positionZ'])
angZ_AILES = readattribute([devAILES '/angleZ'])
posZ_SMIS = readattribute([devSMIS '/positionZ'])
angZ_SMIS = readattribute([devSMIS '/angleZ'])