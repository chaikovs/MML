function indClosestElem = idAuxFindClosestElemInd(valElem, vToCheck)

numElem = length(vToCheck);
minAbsDif = 1e+23;
indClosestElem = -1;
for i = 1:numElem
    curAbsDif = abs(vToCheck(i) - valElem);
    if(minAbsDif > curAbsDif)
        minAbsDif = curAbsDif;
        indClosestElem = i;
    end
end
