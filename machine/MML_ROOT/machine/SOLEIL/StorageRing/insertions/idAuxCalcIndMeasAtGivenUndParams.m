function absIndFound = idAuxCalcIndMeasAtGivenUndParams(allUndParams, undParamsToFind)
%Calculates absolute flat index of element in multi-dim. array of undulator parameters
%list of all un. params to look through: allUndParams = {{'phase', [-40, -20, 0, 20, 40]}, {'gap', [15.5, 25]}}
%undulator parameters to find: undParamsToFind = {{'gap', 15.5}, {'phase', 40}}

numAllParams = length(allUndParams);
numParamsToFind = length(undParamsToFind);

%maxNumParams = 3;
if(numAllParams <= 0) %|| (numAllParams > maxNumParams))
    absIndFound = -1;
    return;
end
if(numParamsToFind <= 0) %|| (numParamsToFind > maxNumParams))
    absIndFound = -1;
    return;
end
if(numAllParams ~= numParamsToFind)
    absIndFound = -1;
    return;    
end

arPerInd = zeros(numAllParams, 1);
%fill-in array of periods
arPerInd(numAllParams) = 1;
prodSizes = 1;
for i = 1:(numAllParams - 1)
	curParamInf = allUndParams{numAllParams - i + 1};
    curParamValues = curParamInf{2};
    prodSizes = prodSizes*length(curParamValues);
    arPerInd(numAllParams - i) = prodSizes;
end

absIndFound = -1;
absIndCount = 0;
%prevRelInd = -1;
for i = 1:numAllParams
    curParamInf = allUndParams{i};
    curParamName = curParamInf{1};
    
    carParamValueToFind = 1e+23;
    for j = 1:numParamsToFind
        curParamToFindInf = undParamsToFind{j};
        curParamNameToFind = curParamToFindInf{1};
        if(strcmp(curParamName, curParamNameToFind))
            carParamValueToFind = curParamToFindInf{2};
            break;
        end
    end
    if(carParamValueToFind == 1e+23)
       return; 
    end
    curParamValues = curParamInf{2};
    numCurParamValues = length(curParamValues);
    absMinDif = 1e+23;
    indMinDif = -1;
    for k = 1:numCurParamValues
        curAbsDif = abs(curParamValues(k) - carParamValueToFind);
        if(absMinDif > curAbsDif)
            absMinDif = curAbsDif;
            indMinDif = k;
        end
    end
    %prevRelInd = indMinDif;
    absIndCount = absIndCount + (indMinDif - 1)*arPerInd(i);
end
absIndFound = absIndCount + 1;
