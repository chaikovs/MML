function [resFileNamesStruct, resErrorFlag] = idMeasElecBeamVsUndParam(idName, undParams, undParamsBkg,UpdateOfCOD, fileNameCore, dispData)
%% Measure e-beam COD at different undulator parameters (gap, phase or currents in main coils)
% if(freqBkgMeas == 1) - measure bakground once each time after passing the in-most loop
% if(freqBkgMeas == n) - measure bakground once after passing n nested loops
% Written by Oleg.
% Modified by F. Briquez :  1) check of SOFB, FOFB and FFWD states.
%                           2) 06/11/2012 : freqBkgMeas is not an attribute any more (to
%                           limit mistakes). It is set to 1.
%                           3) 06/11/2012 : UpdateOfCOD is an attribute.
freqBkgMeas=1;  
inclPerturbMeas=0;

%==========================================================================
% UpdateOfCOD
% if 0 => no FFWD, no {SOFB + FOFB} : in case of first iteration of tables
% if 1 => FFWD but no {SOFB + FOFB} : in case of higher iteration
%==========================================================================
Debug=0;    % if 1 => no check of SOFB and FOFB

resFileNamesStruct=struct;
resFileNames = {};
resErrorFlag = 0;
numUndParams = length(undParams);
resUnd = 0;
absCurrentThreshold=0.01;   % To check if cor currents are zero

%% CHECK FFWD, SOFB AND FOFB STATE
    dServName = idGetUndDServer(idName);
    if dServName ==-1
        fprintf('IdName ''%s'' is incorrect\n', idName);
        return
    end
    tempStructure=idGetCorrectionStatus(idName);
    fFwdState=tempStructure.ffwd;
    if (fFwdState==1)
        if ~UpdateOfCOD
            fprintf ('FFWD is active! Desactive it to continue\n')
            return
        end
    end
 
    sOfbIsActive=tempStructure.sofb;
    if (sOfbIsActive==1)
        if ~Debug
            fprintf ('SOFB is active! Desactive it to continue\n')
            return
        end
    end
    
    fOfbIsActive=tempStructure.fofb;
    if (fOfbIsActive==1)
        if ~Debug
            fprintf ('FOFB is active! Desactive it to continue\n')
            return
        end
    end

%% CHECK FFWD CORRECTION CURRENTS

    CurrentCVE=tango_read_attribute(dServName, 'currentCVE');
    CurrentCVE=CurrentCVE.value(1);
    CurrentCHE=tango_read_attribute(dServName, 'currentCHE');
    CurrentCHE=CurrentCHE.value(1);
    CurrentCVS=tango_read_attribute(dServName, 'currentCVS');
    CurrentCVS=CurrentCVS.value(1);
    CurrentCHS=tango_read_attribute(dServName, 'currentCHS');
    CurrentCHS=CurrentCHS.value(1);
    if (abs(CurrentCVE)>absCurrentThreshold||abs(CurrentCHE)>absCurrentThreshold||abs(CurrentCVS)>absCurrentThreshold||abs(CurrentCHS)>absCurrentThreshold)
        if ~UpdateOfCOD
            fprintf('Set correction currents to zero to continue\n');
            return
        end
    end

%% Script from Oleg
%"Nested For" algorithm
curParamName = undParams{1}{1}; % Parameter name ('gap')
curParamValues = undParams{1}{2}; % Parameter value [5.5 6 10]
curParamAbsTol = undParams{1}{3}; % Parameter absolute tolerance {0.01}
numCurParamValues = length(curParamValues);

% generates filename for saving data
nextFileNameCoreBase = strcat(fileNameCore, '_');
nextFileNameCoreBase = strcat(nextFileNameCoreBase, curParamName);

for j = 1:numCurParamValues
    
	curParamValue = curParamValues(j);
    
    strParamValue = sprintf('%f', curParamValue);
    strParamValue = strrep(strParamValue, '.', '_');
    lenOrigStrParamValue = length(strParamValue);
    numTrailZeros = 0; %removing trailing zeros
    for k = 1:lenOrigStrParamValue
        if strcmp(strParamValue(lenOrigStrParamValue - k + 1), '0')
            numTrailZeros = numTrailZeros + 1;
        else
            if (numTrailZeros > 0) && strcmp(strParamValue(lenOrigStrParamValue - k + 1), '_')
                numTrailZeros = numTrailZeros + 1;
            end
            break;
        end
    end
    if(numTrailZeros > 0)
        strParamValueFin = '';
        for k = 1:lenOrigStrParamValue - numTrailZeros
            strParamValueFin = strcat(strParamValueFin, strParamValue(k));
        end
    else
        strParamValueFin = strParamValue; %OC fix(?)
    end
    nextFileNameCore = strcat(nextFileNameCoreBase, strParamValueFin);
    
    %%%%%%%%%%%Change Undulator parameter (gap, phase or current)
	%resUnd = idSetUndParamSync(idName, curParamName, curParamValue, curParamAbsTol);
    resUnd = idSetUndParam(idName, curParamName, curParamValue, curParamAbsTol);
    if(resUnd ~= 0)
        fprintf('Execution terminated since Undulator Parameter can not be set\n');
        resErrorFlag = -1; return;
    end
    
	if(numUndParams > 1)
        %Preparing arguments for nested call
        nextUndParams = {};
        for k = 1:(numUndParams - 1)
            for i = 1:3
                nextUndParams{k}{i} = undParams{k + 1}{i};
            end
            nextUndParams{k}{4} = 'nested'; %marking the set of params as for the nested call
        end
        
        %%%%%%%%%%%Do nested call
        [resNextFileNamesStruct, resNextErrorFlag] = idMeasElecBeamVsUndParam(idName, nextUndParams, undParamsBkg, UpdateOfCOD, nextFileNameCore, dispData);
        %[resNextFileNamesStruct, resNextErrorFlag] = idMeasElecBeamVsUndParam(idName, nextUndParams, undParamsBkg, freqBkgMeas, inclPerturbMeas, nextFileNameCore, dispData);  
                                                    %idMeasElecBeamVsUndParam(idName, undParams, undParamsBkg,UpdateOfCOD, fileNameCore, dispData)                            
        resNextFileNames = resNextFileNamesStruct.filelist;
        numNextFileNames = length(resNextFileNames);
        
        if(resNextErrorFlag ~= 0)
            fprintf('Execution terminated because of error in the inner loop\n');
            resErrorFlag = resNextErrorFlag; return;
        end

        numCurFileNames = length(resFileNames);
        for k = 1:numNextFileNames
        	resFileNames{numCurFileNames + k} = resNextFileNames{k};
        end

    else
        %%%%%%%%%%%Measure e-beam COD
        getx();getz();
        outStruct = idMeasElecBeamUnd(idName, inclPerturbMeas, nextFileNameCore, 1, dispData);
        numCurFileNames = length(resFileNames);
        resFileNames{numCurFileNames + 1} = outStruct.file;
	end
end
resFileNamesStruct.filelist = resFileNames;

numUndParamsBkg = length(undParamsBkg);
if((numUndParams == freqBkgMeas) && (numUndParamsBkg > 0)) %Measure Background if necessary
    %numUndParamsBkg = length(undParamsBkg);

    if(numUndParamsBkg > 0)
    	nextFileNameCore = strcat(fileNameCore, '_bkg');
    	undParamsBeforeBkgMeas = {};
        for k = 1:numUndParamsBkg
            curParamName = undParamsBkg{k}{1};
            curParamValue = undParamsBkg{k}{2};
            curParamAbsTol = undParamsBkg{k}{3};
            undParamsBeforeBkgMeas{k} = idGetUndParam(idName, curParamName);
            
            %%%%%%%%%%%Change Undulator parameter (gap, phase or current) to prepare for background measurement
         %   resUnd = idSetUndParamSync(idName, curParamName, curParamValue, curParamAbsTol);
          %  if(resUnd ~= 0)
          %     fprintf('Execution terminated since Undulator Parameter can not be set\n');
          %      resErrorFlag = -1; return;
          %  end
        end

        %%%%%%%%%%%Measure e-beam COD background
        getx();getz();
        outStruct = idMeasElecBeamUnd(idName, inclPerturbMeas, nextFileNameCore, 1, dispData);
        numCurFileNames = length(resFileNames);
        resFileNames{numCurFileNames + 1} = outStruct.file;
        resFileNamesStruct.filelist = resFileNames;

        %Returning to the state before background measurement, only in the case of nested call
        if(length(undParams{1}) > 3)
            if strcmp(undParams{1}{4}, 'nested')
                for k = 1:numUndParamsBkg
                    curParamName = undParamsBkg{k}{1};
                    curParamAbsTol = undParamsBkg{k}{3};
                    curParamValue = undParamsBeforeBkgMeas{k};
            
                    %%%%%%%%%%%Change Undulator parameter (gap, phase or current) - return to the last state before background measurement
                %    resUnd = idSetUndParamSync(idName, curParamName, curParamValue, curParamAbsTol);
                %    if(resUnd ~= 0)
                %        fprintf('Execution terminated since Undulator Parameter can not be set\n');
                %        resErrorFlag = -1; return;
                %   end
                end
            end
        end
    end
end

if((length(undParams{1}) <= 3) || (strcmp(undParams{1}{4}, 'nested') == 0)) %i.e. this is not a nested call
%iall job is done, writing and saving the summary structure

	lastParamAr = undParams{numUndParams}{2};
	perMeasBkg = length(lastParamAr);
	if(freqBkgMeas > 1)
        for k = 1:(numUndParams - 1)
            perMeasBkg = perMeasBkg*length(undParams{numUndParams - k}{2});
        end
	end

    resFileNamesStruct.filelist = resFileNames;
	resFileNamesStruct.params = undParams;
	resFileNamesStruct.filenames_meas_bkg = idAuxPrepFileNameListMeasAndBkg(resFileNames, perMeasBkg);
    
	fileNameCoreSummary = strcat(fileNameCore, '_summary');
	idSaveStruct(resFileNamesStruct, fileNameCoreSummary, idName, 1, 0);
end