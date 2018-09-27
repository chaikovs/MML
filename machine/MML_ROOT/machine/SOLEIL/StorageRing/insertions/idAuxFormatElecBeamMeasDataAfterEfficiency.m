function res=idAuxFormatElecBeamMeasDataAfterEfficiency(EfficiencyResutlStructure, displayOnScreen)
% F. Briquez 05/03/2011
    res=-1;
                
    %% LOADING INPUT EFFICIENCY RESULT STRUCTURE
    idName=EfficiencyResutlStructure.idName;
    cellGaps=EfficiencyResutlStructure.gaps;
    cellAllFileNames=EfficiencyResutlStructure.fileNames;
    vectorCorCurrents=EfficiencyResutlStructure.corCurrents;
    numberOfCorCurrents=length(vectorCorCurrents);
    OutputString='';
    
    %% WRITING PREFIX PART
    CorCurrentsString='[';
    for i=1:numberOfCorCurrents
        tempCorCurrent=vectorCorCurrents(i);
        tempString=num2str(tempCorCurrent);
        if (i~=numberOfCorCurrents)
            tempString=[tempString, ', '];
        end
        CorCurrentsString=[CorCurrentsString, tempString];
    end
    CorCurrentsString=[CorCurrentsString, ']'];
    OutputStringPrefix=sprintf('\n\n%%%%%%%% %s\n\tif strcmp(idName, ''%s'')\n\t\tvCurVals = %s;\n\n', idName, idName, CorCurrentsString);
    
    %% WRITING MAIN PART
    numberOfGaps=length(cellGaps);
    if (numberOfGaps~=length(cellAllFileNames))
        fprintf ('Bad input!\n');
        return
    end
    OutputStringMainPart='';
    for gapIndex=1:numberOfGaps
        gapValue=cellGaps{gapIndex};
        if (gapIndex~=numberOfGaps)
            nextGapValue=cellGaps{gapIndex+1};
        end
        stringOfFileNames=cellAllFileNames{gapIndex};
        sRes = idAuxFormatPartCorElecBeamMeasData(stringOfFileNames);
        if (gapIndex==1)
            if (gapIndex==numberOfGaps)
                tempMainString=sprintf('if(gap == %g)', gapValue);
            else
                tempMainString=sprintf('if(gap < 0.5*(%g+ %g))', gapValue, nextGapValue);
            end
        elseif (gapIndex~=numberOfGaps)
            tempMainString=sprintf('elseif(gap < 0.5*(%g+ %g))', gapValue, nextGapValue);
        else
            tempMainString=sprintf('else\t%%%% Gap > %g',cellGaps{numberOfGaps});
        end
        tempMainString=['\t\t', tempMainString, '\n\n', sRes];
        OutputStringMainPart=[OutputStringMainPart, tempMainString];
    end
        
    %% WRITING SUFFIX PART
    OutputStringSuffix=sprintf('\tend\t%%%% End of %s', idName); 
    
    %% WRITING AND WHOLE TEXT PRINTING IT ON SCREEN
    OutputString=[OutputStringPrefix, OutputStringMainPart, '\n', OutputStringSuffix, '\n\n'];    
    stringToCopy=sprintf(OutputString);
    clipboard('copy',stringToCopy);
    if (displayOnScreen)
        fprintf (OutputString);
    else
        fprintf('Text is copied in the clipboard => just past it in the ''idReadCorElecBeamMeasData'' file\n');
    end
    
    res=0;
    return
    

    
end    
    
    
function outputString=idAuxAddTabulationsInString(inputString, numberOfTabsToAdd, endingLineString)
    outputString='';
    % endingLineString=char(10) or '\n'
    % tabulationCharacter=char(9) (corresponds to '\t')
    n=length(inputString);
    nEndingLineString=length(endingLineString);
    outputString=inputString;
    tabulationString=zeros(1, numberOfTabsToAdd);
    tabulationString(:)=9;
    tabulationString=char(tabulationString);

    i=1;
    while(i<n)
        if (i~=1)
            lastLineLastCharacters=outputString(i-nEndingLineString:i-1);
            conditionOnBeginOfLine=strcmp(lastLineLastCharacters, endingLineString);
        else
            conditionOnBeginOfLine=1;
        end
        if (conditionOnBeginOfLine==1)
            outputString=[outputString(1:i-1), tabulationString, outputString(i:n)];
            n=length(outputString);
        end
        i=i+1;
    end
    return
end