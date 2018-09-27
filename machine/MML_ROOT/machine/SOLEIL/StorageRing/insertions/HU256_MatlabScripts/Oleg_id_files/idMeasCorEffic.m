function res = idMeasCorEffic(idName, tableCorCur, inclPerturbMeas, fileNameCore, dispData)
res = -1;

numMeas = length(tableCorCur);
curAbsTol = 0.001;
curToSetCHE = 0;
curToSetCVE = 0; 
curToSetCHS = 0;
curToSetCVS = 0;
fileNameCoreWithCor = fileNameCore;
strCor = '';

for i = 1:numMeas
    curToSetCHE = tableCorCur(i, 1);
    curToSetCVE = tableCorCur(i, 2);
	curToSetCHS = tableCorCur(i, 3);
    curToSetCVS = tableCorCur(i, 4);
    
	if dispData ~= 0
        fprintf('\nCurrents: CHE = %f, CVE = %f, CHS = %f, CVS = %f\n', curToSetCHE, curToSetCVE, curToSetCHS, curToSetCVS);
    end

    res = idSetCorCurSync(idName, curToSetCHE, curToSetCVE, curToSetCHS, curToSetCVS, curAbsTol);
    if (res ~= 0)
        fprintf('Failed to set the current values:  %f  %f  %f  %f\nLoop on the current values has stopped abnormally\n', curToSetCHE, curToSetCVE, curToSetCHS, curToSetCVS);
        return;
    end
    
    strCor = sprintf('_he%i_ve%i_hs%i_vs%i', curToSetCHE, curToSetCVE, curToSetCHS, curToSetCVS);
    fileNameCoreWithCor = strcat(fileNameCore, strCor);
    
	EIaux = idMeasElecBeamUnd(idName, inclPerturbMeas, fileNameCoreWithCor, dispData);
end

res = idSetCorCurSync(idName, 0, 0, 0, 0, curAbsTol);
if (res ~= 0)
	fprintf('Failed to set the current values:  0  0  0  0\n');
end

