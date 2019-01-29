function resStr = idAuxNum2FileNameStr(num)
%Encodes decimal number in string, which can then be used as a part of file name

strParamValue = sprintf('%f', num);
strParamValue = strrep(strParamValue, '.', '_');
lenOrigStrParamValue = length(strParamValue);
numTrailZeros = 0; %removing trailing zeros
for k = 1:lenOrigStrParamValue
	if(strcmp(strParamValue(lenOrigStrParamValue - k + 1), '0'))
    	numTrailZeros = numTrailZeros + 1;
    else
    	if(numTrailZeros > 0) && strcmp(strParamValue(lenOrigStrParamValue - k + 1), '_')
        	numTrailZeros = numTrailZeros + 1;
    	end
        break;
	end
end
if(numTrailZeros > 0)
	resStr = '';
	for k = 1:lenOrigStrParamValue - numTrailZeros
    	resStr = strcat(resStr, strParamValue(k));
	end
else
    resStr = strParamValue;
end
