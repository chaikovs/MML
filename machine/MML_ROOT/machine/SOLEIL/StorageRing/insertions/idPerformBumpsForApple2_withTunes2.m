function res = idPerformBumpsForApple2_withTunes2(idName, xMin, xStep, xMax, MaxxStep, vGaps, GapBkg, Phase, Mode, UseFFWD, NumberOfCorrectorsToUseOnEachSide, FitRF, CorrectNu)


%idPerformBumpsForApple2_withTunes2('W164_PUMA_SLICING', 0, 1, 9, 2, [200 100 50 30 18 16.7 14.7], 235, 0, 'ii', 0, 8, 1, 1)
%09 mars 2014 W164 15h00-23h00
%idPerformBumpsForApple2_withTunes2('W164_PUMA_SLICING', -14, 1, 14, 1, [14.7 16.7 18 30 50 100 200], 235, 0, 'ii', 0, 8, 1, 1)
%idPerformBumpsForApple2_withTunes2('WSV50_PSICHE', 0, 2, 20, 2, [4.5 5.5], 70, 0, 'ii', 1, 8, 1, 1)

%% Performs bumps ans scan undulator gap (at one given phase and mode).
% Update by F. Briquez 22/01/2014
% Update by F. Briquez 17/02/2014 : vector of gaps is sorted at the
% begining (for Olivier and Hadil who put the gaps in the wrong order...)
% Inputs :  - idName
%           - xMin, xStep, and xMax : scalars : bump values
%           - MaxxStep : scalar : max bump step. Allows smaller bump steps than
%               xStep.
%           - vGaps : 1xN vector of gaps
%           - GapBkg : scalar : Background gap
%           - Phase : scalar : Phase value
%           - Mode : string : mode of undulator ('ii', 'x', 'i2' or 'x2')
%           - UseFFWD : logical : to use FFWD or not
%           - NumberOfCorrectorsToUseOnEachSide : scalar : number of correctors to use for bump.
%               2 means 2 correctors upstream AND 2 correctors downstream.
%           - FitRF: logical : to use RF adjustment or not during bumps
%           - CorrectNu : if 1 => tunes are measured at bump=[0 0] and
%           corrected for other bump values, after each bump.
%
% Outputs : 1) res = 0 if succeeded, -1 if failed.
%           2) a structure is saved in ID directory. Its name is printed on screen at
%               the end of the scan. It contains 4 fields :
%               - idName
%               - Phase : phase of undulator
%               - Mode : mode of undulator
%               - Names : 1x25 cell containing names of columns
%               - Cell : Nx25 cell containing names of acquisitions for each
%               {x, gap} pair, and also empty columns to be filled
%               with values such as integrals (to be done with function
%               'idAnalyseBumpsForApple2' or
%               'idAnalyseBumpsOfSeveralPhasesForApple2')

%% =================BEGIN OF MAIN FUNCTION============================
%% Parameters
   
    Debug=0;    % if 1 : - no bump is done but a message is printed instead
    %                    - no check of Storage Ring feed backs
   
    OrbitCoreName='%s_Orbit_Bump_Gap%s_Phase%s_Mode%s_X%s'; % idName, GapString, PhaseString, uppser(Mode), xString
    ResultCoreName='%s_Result_Bump_Phase%s_Mode%s';
    GapTolerance=0.01;  % Used to consider that gap is reached (mm)
    PhaseTolerance=0.01; % Used to consider that phase is reached (mm)
    MinGapToChangePhase=16.1; % Gap value above which it is always possible to change phase (mm)
    ToleranceOnBumpPosition=0.005; % Used to perform bump with feedback, only for bump to reach zero position (mm)
    PauseAfterBump=1; % Time to wait for after bump is completed (s)
    inclPerturbMeas=0; % To perform chromaticity measurements : Incompatible! Not to be changed.
    AddTime=1;  % Add time or not at the end of name of orbit acquisitions
    dispData=0; % Display text at each orbit acquisition
    
    % Tune correction parameters
    NuToleranceForTuneCorrection=5e-4;  % Tolerance on tune reading for tune correction
    MaxIterationForTuneCorrection=30;   % Max number of correction iterations to perform for tune correction (security)
    TimeToWaitForTuneCorrection=2;      % Time to wait after each iteration of tune correction (s)
    
%% Initialisation & check of idName

    res=-1;
    
    if MaxxStep>xStep
        fprintf ('idPerformBumpsForApple2 : MaxxStep should be smaller or equal to xStep\n')
        return
    end
%     if abs(xMin)<MaxxStep||xMax<MaxxStep
%         fprintf ('idPerformBumpsForApple2 : MaxxStep should be smaller or equal to |xMin| and xMax\n')
%         return
%     end
    idDirectory=getfamilydata('Directory', idName);
    if isempty(idDirectory)
        fprintf ('idPerformBumpsForApple2 : idName ''%s'' is wrong!\n', idName)
        return
    end
    if ~isempty(Mode)
        if ~strcmpi(Mode, 'ii')&&~strcmpi(Mode, 'x')&&~strcmpi(Mode, 'i2')&&~strcmpi(Mode, 'x2')
            fprintf ('idPerformBumpsForApple2 : Mode ''%s'' is wrong!\n', Mode)
            return
        end
    end
     
    if ~strcmp(idDirectory(length(idDirectory)), '/')
        idDirectory=[idDirectory '/'];
    end
   
    NuCorrectionParameters=struct();
    NuCorrectionParameters.Tolerance=NuToleranceForTuneCorrection;
    NuCorrectionParameters.MaxIteration=MaxIterationForTuneCorrection;
	NuCorrectionParameters.WaitingTime=TimeToWaitForTuneCorrection;
    
    PhaseString = idAuxNum2FileNameStr(Phase);
    ResultFileCoreName=sprintf(ResultCoreName, idName, PhaseString, upper(Mode));
    ResultName='';
    
   
%% Get BPMs of straight section
    TempStruct = idGetGeomParamForUndSOLEIL(idName);
    MatrixOfBPMsInStraightSection = TempStruct.indRelBPMs;
    UpstreamBPM = MatrixOfBPMsInStraightSection(1, :);
    DownstreamBPM = MatrixOfBPMsInStraightSection(2, :);
    UpstreamBPMTangoName=dev2tango('BPMx','Monitor', UpstreamBPM);
    DownstreamBPMTangoName=dev2tango('BPMx','Monitor', DownstreamBPM);

%% Set bump parametersidPerformBumpsForApple2.m
    Plane='H';
    Coordinate='x';
    
%% Check that corrections are inactive
    TempStruct=idGetCorrectionStatus(idName);
    StatusSofb = TempStruct.sofb;
    StatusFofb = TempStruct.fofb;
    StatusFfwd = TempStruct.ffwd;
    if ~Debug
        if StatusSofb==1
            fprintf ('idPerformBumpsForApple2 : SOFB is active! Desactive it\n')
            return
        end
        if StatusFofb==1
            fprintf ('idPerformBumpsForApple2 : FOFB is active! Desactive it\n')
            return
        end
        if UseFFWD==0
            UseFFWD=-1;
        else
            UseFFWD=1;
        end
        if StatusFfwd*UseFFWD==-1
            if StatusFfwd==1
                fprintf ('idPerformBumpsForApple2 : FFWD of ID ''%s'' is active! Turn it off\n', idName)
                return
            else
                fprintf ('idPerformBumpsForApple2 : FFWD of ID ''%s'' is inactive! Turn it on\n', idName)
                return
            end                       
        end
    end
    
%% Initialization bump : put orbit on 0-0
    fprintf ('\n===========================\n')
    fprintf ('SETTING BUMP TO ZERO...\n')
    
    if CorrectNu
        NuGoal=gettune;
        fprintf ('Tunes measured for correction : Nux=%g and Nuz=%g\r', NuGoal(1), NuGoal(2));
    else
        NuGoal=[nan nan];
    end
    
    TempRes=idOperateBumpByStepsWithTunes([0 0], [0 0], Plane, ToleranceOnBumpPosition, MaxxStep, MatrixOfBPMsInStraightSection, NumberOfCorrectorsToUseOnEachSide, FitRF, PauseAfterBump, NuGoal, NuCorrectionParameters, Debug);
    fprintf (' => OK\n===========================\n\n')
       
    
%% Initialization bump : put orbit on xMin-xMin
    fprintf ('\n===========================\n')
    fprintf ('SETTING BUMP TO MIN VALUE...\n')

    TempRes=idOperateBumpByStepsWithTunes([0 0], [xMin xMin], Plane, NaN, MaxxStep, MatrixOfBPMsInStraightSection, NumberOfCorrectorsToUseOnEachSide, FitRF, PauseAfterBump, NuGoal, NuCorrectionParameters, Debug);
    if TempRes==0
        return
    end
    fprintf (' => OK\n===========================\n\n')
    
%     if NuGoal(1)~=0 && NuGoal(2)~=0
%         fprintf ('Correction tunes\n')
%         settune(NuGoal);
%     end
    
%% Creation of result structure
    NumberOfxValues=(xMax-xMin)/xStep+1;
    NumberOfGaps=length(vGaps);
    NumberOfMeasPoints=NumberOfxValues*NumberOfGaps;
    
    ResultStruct=struct;    %'Names', cell(NumberOfxValues, 16), 'Cell', cell(NumberOfxValues, 16), 'I1x', zeros(NumberOfxValues), 'I1z', zeros(NumberOfxValues), 'Nuz');
    ResultStruct.LatticeName=getlatticename;
    ResultStruct.IdName=idName;
    ResultStruct.Phase=Phase;
    ResultStruct.Mode=Mode;
    ResultStruct.Gaps=vGaps;
    ResultStruct.xPos=xMin:xStep:xMax;
    
    ResultStruct.Names=cell(1, 25);
    ResultStruct.Names{1, 1}='xPos';
    ResultStruct.Names{1, 2}='Gap';
    ResultStruct.Names{1, 3}='MeasName';
    ResultStruct.Names{1, 4}='BkgName';
    ResultStruct.Names{1, 5}='EpsilonxMeas';
    ResultStruct.Names{1, 6}='EpsilonxBkg';
    ResultStruct.Names{1, 7}='EpsilonzMeas';
    ResultStruct.Names{1, 8}='EpsilonzBkg';
    ResultStruct.Names{1, 9}='CouplingMeas';
    ResultStruct.Names{1, 10}='CouplingBkg';
    ResultStruct.Names{1, 11}='DeltaCoupling';
    ResultStruct.Names{1, 12}='NuxMeas';
    ResultStruct.Names{1, 13}='NuxBkg';
    ResultStruct.Names{1, 14}='DeltaNux';
    ResultStruct.Names{1, 15}='NuzMeas';
    ResultStruct.Names{1, 16}='NuzBkg';
    ResultStruct.Names{1, 17}='DeltaNuz';
    ResultStruct.Names{1, 18}='K1x';
    ResultStruct.Names{1, 19}='K2x';
    ResultStruct.Names{1, 20}='K1z';
    ResultStruct.Names{1, 21}='K2z';
    ResultStruct.Names{1, 22}='I1x';
    ResultStruct.Names{1, 23}='I2x';
    ResultStruct.Names{1, 24}='I1z';
    ResultStruct.Names{1, 25}='I2z';
    
    ResultStruct.Cell=cell(NumberOfMeasPoints, 25);
    
%% Set mode
        
    ActualMode=idGetUndParam(idName, 'mode');
    Condition=strcmpi(ActualMode, Mode);
    if ~Condition
        fprintf ('\n===========================\n')
        fprintf ('SETTING UNDULATOR MODE...\n')
        ActualGap=idGetUndParam(idName, 'gap');
        if ActualGap<MinGapToChangePhase
            fprintf ('Going to gap value %g\n', MinGapToChangePhase)
            idSetUndParam(idName, 'gap', MinGapToChangePhase, GapTolerance);
            fprintf (' => ok\n')
        end
        ActualPhase=idGetUndParam(idName, 'Phase');
        Condition=strcmpi(ActualPhase, 0);
        if ~Condition
            fprintf ('Going to phase zero\n')
            idSetUndParam(idName, 'phase', 0, PhaseTolerance);   % phase to zero in order to allow changing mode
            fprintf (' => ok\n')
        end
        
        fprintf ('Changing mode\n')
        Condition=1;
        while (~Condition)
            if ~Condition
                TempRes = idSetUndParamSync(idName, 'mode', Mode, 0);
                if TempRes==-1
                    fprintf ('idPerformBumpsForApple2 : Could not reach mode value ''%s''. You can do it ''by hand''. Trying again...\n', Mode);
                    return
                end
                ActualMode=idGetUndParam(idName, 'mode');
                Condition=strcmpi(ActualMode, Mode);
            end
        end
        fprintf (' => OK\n===========================\n\n')
    else
        fprintf ('\n===========================\n')
        fprintf ('UNDULATOR MODE => Ok\n===========================\n\n')
    end
    
    
%% Set phase

    ActualPhase=idGetUndParam(idName, 'Phase');
    Condition=abs(ActualPhase-Phase)<=PhaseTolerance; 
    if ~Condition
        fprintf ('\n===========================\n')
        fprintf ('SETTING UNDULATOR PHASE...\n')
        idSetUndParam(idName, 'phase', Phase, PhaseTolerance);
        fprintf (' => OK\n===========================\n\n')
    else
        fprintf ('\n===========================\n')
        fprintf ('UNDULATOR PHASE => Ok\n===========================\n\n')
    end
    
%% Begin of scan in x positions
    vGaps=sort(vGaps);
    if vGaps(length(vGaps))~=GapBkg
        vGapsForScan=[vGaps, GapBkg];
    else
        vGapsForScan=vGaps;
    end
    NumberOfGapsForScan=length(vGapsForScan);
    
    for xIndex=1:NumberOfxValues
        xPos=xMin+(xIndex-1)*xStep;
        
        
        if mod(xIndex, 2)~=0    % odd number
            GapIncreasing=1;
        else
            GapIncreasing=0;
        end
        fprintf ('\n===========================\n')
        fprintf ('SCANNING GAPS FOR BUMP POSITION %g...\n', xPos)
        
        
        for iGap=1:NumberOfGapsForScan
            
            if GapIncreasing
                GapIndex=iGap;
            else
                GapIndex=NumberOfGapsForScan-iGap+1;
            end
            Gap=vGapsForScan(GapIndex);
            if (Gap~=GapBkg)
                Row=(xIndex-1)*NumberOfGaps+GapIndex;
            else
                Row=0;
            end
            fprintf ('Going to gap %g\n', Gap)
            idSetUndParam(idName, 'gap', Gap, GapTolerance);
            fprintf (' =>ok\n')

%% Construct orbit acquisition filename
            GapString = idAuxNum2FileNameStr(Gap);
            PhaseString = idAuxNum2FileNameStr(Phase);
            xString = idAuxNum2FileNameStr(xPos);
            FileNameCore=sprintf(OrbitCoreName, idName, GapString, PhaseString, upper(Mode), xString);

%% Make orbit acquisition and get file name
            OrbitStruct = idMeasElecBeamUnd(idName, inclPerturbMeas, FileNameCore, AddTime, dispData);
            FileName=OrbitStruct.file;
            fprintf (' Orbit saved for %s = %g mm and gap = %g mm : ''%s''\n', Coordinate, xPos, Gap, FileName);

%% Fill in measurement values in cell            
            if Row~=0   % not bkg meas
                ResultStruct=SetValueInCell(ResultStruct, Row, 'xPos', xPos);
                ResultStruct=SetValueInCell(ResultStruct, Row, 'Gap', Gap);
                ResultStruct=SetValueInCell(ResultStruct, Row, 'MeasName', FileName);
            else    % bkg meas
                for i=1:NumberOfGaps
                    SubRow=(xIndex-1)*NumberOfGaps+i;
                    ResultStruct=SetValueInCell(ResultStruct, SubRow, 'BkgName', FileName);
                end
            end
        end
        fprintf (' => OK\n===========================\n\n') % Scan of gaps finished at x position xPos
        
 %% Save result
        if isempty(ResultName)
            ResultName=idSaveStruct(ResultStruct, ResultFileCoreName, idName, 1, dispData);
        else
            idSaveStruct(ResultStruct, ResultName, idName, 0, dispData);
        end
    
%% make bump to next x position
        if xIndex~=NumberOfxValues
            NextxPos=xMin+(xIndex)*xStep;
            TempRes=idOperateBumpByStepsWithTunes([xPos xPos], [NextxPos NextxPos], Plane, NaN, MaxxStep, MatrixOfBPMsInStraightSection, NumberOfCorrectorsToUseOnEachSide, FitRF, PauseAfterBump, NuGoal, NuCorrectionParameters, Debug);
            if TempRes==0
                return
            end
        end
    end
            
%% Finalizing bumps : put orbit on 0-0
    fprintf ('\n===========================\n')
    fprintf ('SETTING BUMP TO ZERO...\n')
    
    TempRes=idOperateBumpByStepsWithTunes([0 0], [0 0], Plane, ToleranceOnBumpPosition, MaxxStep, MatrixOfBPMsInStraightSection, NumberOfCorrectorsToUseOnEachSide, FitRF, PauseAfterBump, NuGoal, NuCorrectionParameters, Debug);
    if TempRes==0
        return
    end
    fprintf (' => OK\n===========================\n\n')
    
    fprintf ('Result stored in %s\n', fullfile(idDirectory, ResultName));
    tango_command_inout('ans/ca/texttalker.2', 'DevTalk', '""')     % bell to tell end of scan    
    res=0;
    msg = 'mesure H U 36s terminai';
    tango_giveInformationMessage(msg)
    return
end
%% =================END OF MAIN FUNCTION============================

       
%% Set a value in cell of structure using names
    function OutputStructure=SetValueInCell(Structure, Row, QuantityName, Value)
    % Structure 'Structure' contains 2 fields :
    % - Names : 1xn cell containing Names
    % - Cell : mxn cell containing values
        OutputStructure=[];
        if ~isfield(Structure, 'Names')||~isfield(Structure, 'Cell')
            fprintf ('SetValueInCell : wrong structure\n')
            return
        end
        Names=Structure.Names;
        Cell=Structure.Cell;
        OutputStructure=Structure;
        for i=1:size(Names, 2)
            if strcmpi(Names{1, i}, QuantityName)
                Cell{Row, i}=Value;
                OutputStructure.Cell=Cell;
                return
            end
        end
        fprintf ('SetValueInCell : could not find Quantity name ''%s'' in structure\n', QuantityName)
    end

%% Get a value in cell of structure using names
    function Res=GetValueInCell(Structure, Row, QuantityName)
    % Structure 'Structure' contains 2 fields :
    % - Names : 1xn cell containing Names
    % - Cell : mxn cell containing values
        Res=[];
        if ~isfield(Structure, 'Names')||~isfield(Structure, 'Cell')
            fprintf ('SetValueInCell : wrong structure\n')
            return
        end
        Names=Structure.Names;
        Cell=Structure.Cell;
        for i=1:size(Names, 2)
            if strcmpi(Names{1, i}, QuantityName)
                Res=Cell{Row, i};
                return
            end
        end
        fprintf ('GetValueInCell : could not find Quantity name ''%s'' in structure\n', QuantityName)
        return
    end


%% Script écrit à l'arrache pour tester les orbites enregistrées et voir si
%% les bumps correspondent aux noms

% Orb_xm1_G12=load(C.Cell{1, 3});
% Orb_xm1_G13=load(C.Cell{2, 3});
% Orb_xm1_G14=load(C.Cell{1, 4});
% 
% Orb_x0_G12=load(C.Cell{3, 3});
% Orb_x0_G13=load(C.Cell{4, 3});
% Orb_x0_G14=load(C.Cell{3, 4});
% 
% Orb_x1_G12=load(C.Cell{5, 3});
% Orb_x1_G13=load(C.Cell{6, 3});
% Orb_x1_G14=load(C.Cell{5, 4});
% 
% DeltaX_xm1_x0_G12=Orb_xm1_G12.X-Orb_x0_G12.X;
% DeltaX_xm1_x0_G13=Orb_xm1_G13.X-Orb_x0_G13.X;
% DeltaX_xm1_x0_G14=Orb_xm1_G14.X-Orb_x0_G14.X;
% 
% DeltaX_x1_x0_G12=Orb_x1_G12.X-Orb_x0_G12.X;
% DeltaX_x1_x0_G13=Orb_x1_G13.X-Orb_x0_G13.X;
% DeltaX_x1_x0_G14=Orb_x1_G14.X-Orb_x0_G14.X;
% 
% figure(1)
% clf(1)
% hold on
% plot(DeltaX_xm1_x0_G14, 'r')
% plot(DeltaX_x1_x0_G14, 'b')