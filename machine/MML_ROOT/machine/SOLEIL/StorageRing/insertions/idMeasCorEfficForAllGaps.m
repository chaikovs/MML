function [structureAllFileNames, res] = idMeasCorEfficForAllGaps(idName, fileNameCore, maxAbsCorCurrent, vectorOfGaps, dispData)
% F. Briquez 09/11/2010. Finished 07/03/2011. Tested & works.

inclPerturbMeas=0;
gapAbsoluteTolerance=0.01; %mm
phaseAbsoluteTolerance=0.01; %mm
constantePhaseValue=0;  %mm

if (strcmp(fileNameCore, '')==0)
    if (strcmp(fileNameCore(length(fileNameCore)), '_')==0)
        fileNameCore=[fileNameCore, '_'];
    end
end
fileNameCore=['Efficiency_', fileNameCore, idName];
res=-1;

%% CHECK FFWD, SOFB AND FOFB STATE
    dServName = idGetUndDServer(idName);
    if dServName ==-1
        fprintf('IdName ''%s'' is incorrect\n', idName);
        return
    end
    tempStructure=idGetCorrectionStatus(idName);
    fFwdState=tempStructure.ffwd;
    if (fFwdState==1)
        fprintf ('FFWD is active! Desactive it to continue\n')
        return
    end
 
    sOfbIsActive=tempStructure.sofb;
    if (sOfbIsActive==1)
        fprintf ('SOFB is active! Desactive it to continue\n')
        return
    end
    
    fOfbIsActive=tempStructure.fofb;
    if (fOfbIsActive~=-1)
        fprintf ('FOFB is active! Desactive it to continue\n')
        return
    end

%% DEFINITION OF MATRIX OF CORRECTION CURRENTS TO TEST
elementaryCorCurVector=[0 -maxAbsCorCurrent:maxAbsCorCurrent/2:maxAbsCorCurrent];
numberOfCorCurrents=length(elementaryCorCurVector);
tableCorCur=zeros(4*numberOfCorCurrents, 4);
for corIndex=1:4
    tableCorCur((corIndex-1)*numberOfCorCurrents+1:corIndex*numberOfCorCurrents, corIndex)=elementaryCorCurVector;
end

numberOfGaps=length(vectorOfGaps);

%% PERFORM THE CALIBRATION
tempRes=idSetUndParamSync(idName, 'phase', constantePhaseValue, phaseAbsoluteTolerance);
if (tempRes==-1)
    return
end

cellAllFileNames=cell(numberOfGaps, 1);
cellGaps=cell(numberOfGaps, 1);
structureAllFileNames=struct();
resultFileNameCore=[fileNameCore '_FileNames'];
% cellResultFileNames=cell(numberOfGaps); % contains the names of all structures saved => in order to delete them (except the last one, which is complete)

for gapIndex=1:numberOfGaps
    gapValue=vectorOfGaps(gapIndex);
    
    tempRes=idSetUndParamSync(idName, 'gap', gapValue, gapAbsoluteTolerance);
    if (tempRes==-1)
        return
    end
    tempFileNameCore=[fileNameCore '_G' num2str(gapValue*10)];
    [strPartOfFileNames, tempRes] = idMeasCorEffic(idName, tableCorCur, inclPerturbMeas, tempFileNameCore, dispData);
    if (tempRes==-1)
        return
    end
    cellGaps{gapIndex}=gapValue;
    cellAllFileNames{gapIndex}=strPartOfFileNames;
    structureAllFileNames.idName=idName;
    structureAllFileNames.gaps=cellGaps;
    structureAllFileNames.fileNames=cellAllFileNames;
%     tempResultFileName=idSaveStruct(structureAllFileNames, resultFileNameCore, idName, dispData)
%     cellResultFileNames{gapIndex}=tempResultFileNames;
end

%% SAVE STRUCTURE
% structure fields:
% - idName : name of ID
% - gaps : cell of gap values
% - fileNames : cell of corresponding file names
% - corCurrents : vector of correction currents
structureAllFileNames.corCurrents=elementaryCorCurVector(2:length(elementaryCorCurVector));
strResultFileName=idSaveStruct(structureAllFileNames, resultFileNameCore, idName, 1, dispData);
if (strcmp(strResultFileName, ''))
    fprintf('Empty result!\n');
else
    fprintf('File ''%s'' created in directory of ''%s''\n', strResultFileName, idName);
end

%% COPY TEXT OF IdReadCorElecBeamMeasData IN CLIPBOARD
res=idAuxFormatElecBeamMeasDataAfterEfficiency(structureAllFileNames, 0);