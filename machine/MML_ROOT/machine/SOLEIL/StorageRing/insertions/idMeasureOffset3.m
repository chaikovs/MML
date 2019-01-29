function res=idMeasureOffset3(idName, OffsetMin, OffsetStep)
%idMeasureOffset3('U20_GALAXIES', 1, 0.1)
%idMeasureOffset3('U18_TOMO', 0.5, 0.1)
%idMeasureOffset3('U20_SIXS', 0.5, 0.1)
%idMeasureOffset3('U20_NANO', 0.5, 0.1)
%% res=idMeasureOffset2(idName, OffsetMin, OffsetStep)
% Scan offset of an InVacuum undulator and find real offset value
% Written by F. Briquez 15/07/2013
%
% 1) measures decreasing slope of current for offset=0
% 2) performs scan of negative values of offset by decreasing values :
%       from -OffsetMin to -SecurityMaxOffset
%    or from -OffsetMin to value x such as :
%               -SecurityMaxOffset < x < -OffsetMin 
%            and slope for offset=x is 'SlopeDecreaseFactor' times bigger
%            than slope for offset=0
%    For each value of offset, measures decreasing slope of current
% 3) performs scan of positive values of offset (same as negative but
%       starting from OffsetMin and increasing values
% 4) stores data in one structure with fields 'Reference', 'Negative' and
% 'Positive', each one containing fields :
%       - 'Offsets' : vector of offsets used for scan
%       - 'Currents' : vector of averaged currents measured (1 value per
%       offset)
%       - 'Slopes' : vector of current decreasing slopes calculated (1 value per
%       offset)
%       - 'Tunes' : vector of measured vertical tune (1 value per offset)
% 5) data treatment : calls function 'idMeasureOffsets_PostTreatment'
%
% Inputs :  - idName : i.e. 'HU36_SIRIUS'
%           - OffsetMin : minimum value under which one knows nothing will
%           be seen (mm). (i.e. 1 mm)
%           - OffsetStep : step between 2 offset values during scan (mm)
%           (i.e. 0.1 mm)
%
% Modified by F. Briquez 02/12/2013 : SecurityMaxOffset set to 1.9 mm
% (instead of 1.8 mm). According to Christian Herbeaux, the max value is 2
% mm).
% Modified by F. Briquez 22/01/2014 (version 2 --> 3) :
%   - SecurityMaxOffset increased to 2 mm (N. Bechu says 2 mm is ok,
%   perhaps more)
%   - add of tunes measurement
%   - add of plot during measurement
%% Input parameters
    TimeOfEachPoint=        1;  % Step time between 2 current measurements (s) => should not be changed!!
    NumberOfPointsPerOffset=60; % Number of current measurements at each offset value ( >1 )
    TimeToWaitAtStepBegin=  1;  % : Time to wait for when offset is set before first current measurement (s)
    Debug=                  0;  % No offset movement is done & current measurement are simulated
    ToleranceOnOffset=   0.001; % For offset movement
    SecurityMaxOffset=2;      % To avoid breaking belows...
    SlopeDecreaseFactor=5;      % The scan in one half of offset range (positive values for instance) is stopped when the current slope 
    %                               is decreased by this value, relatively with slope value at offset=0.
    
%% Check ID name
    res=-1;
    idDirectory=getfamilydata('Directory', idName);
    if isempty(idDirectory)
        fprintf ('idMeasureOffset : idName ''%s'' is wrong!\n', idName)
        return
    end
    DeviceServer=idGetUndDServer(idName);
    Structure=tango_read_attribute(DeviceServer, 'offsetVelocity');
    if ~Debug
        OffsetSpeed=Structure.value(1);
    else
        OffsetSpeed=0.1;
    end
    Structure=tango_read_attribute(DeviceServer, 'offset');
    if ~Debug
        InitialOffset=Structure.value(1);
    else
        InitialOffset=0;
    end
    TimeForIntegration=TimeOfEachPoint*NumberOfPointsPerOffset;
    
    res=struct();
    
%% Perform scan of offset values
    
    for j=1:3   % reference (offset=0), negative and positive offset values
        
        MeasStructAtOneOffset=struct();
        if j==1 % reference (offset=0)
            VectorOfOffsetValues=0;
            Field='Reference';
        elseif j==2 % negative values
            VectorOfOffsetValues=-OffsetMin:-OffsetStep:-SecurityMaxOffset;
            Field='Negative';
        else % positive offset values
            VectorOfOffsetValues=OffsetMin:OffsetStep:SecurityMaxOffset;
            Field='Positive';
        end
        NumberOfOffsetValues=length(VectorOfOffsetValues);
        VectorOfCurrentSlopeValues=nan(1, NumberOfOffsetValues);
        VectorOfCurrentValues=nan(1, NumberOfOffsetValues);
        VectorOfTunesZ=nan(1, NumberOfOffsetValues);
        VectorOfTunesX=nan(1, NumberOfOffsetValues);
        
        iOffset=1;
        ContinueCondition=1;
        while (ContinueCondition)
            Offset=VectorOfOffsetValues(iOffset);
            if iOffset==1
                if j==1
                    OldOffset=InitialOffset;
                else
                    OldOffset=nan;
                end
            else
                OldOffset=VectorOfOffsetValues(iOffset-1);
            end
            
            % Set offset
            if ~Debug
                tango_command_inout(DeviceServer, 'GotoOffset', Offset);
                StopCondition=0;
                while(StopCondition==0)
                    TempStruct=tango_read_attribute(DeviceServer, 'offset');
                    ReadOffset=TempStruct.value;
                    StopCondition=abs(ReadOffset-Offset)<=ToleranceOnOffset;
                end
                SetOffsetRes=0;
               % SetOffsetRes=idSetUndParam(idName, 'Offset', Offset, ToleranceOnOffset);
                if SetOffsetRes==-1
                    fprintf ('idMeasureOffset : could not set offset to value ''%g''\n', Offset)
                    return
                end
                pause(TimeToWaitAtStepBegin)
                Message='';
            else
                Message='DEBUG : ';
            end
            if isnan(OldOffset)
                fprintf([Message 'Offset set to %g mm\n'], Offset)
            else
                fprintf([Message 'Offset set from %g mm to %g mm\n'], OldOffset, Offset)
            end
            
            % Prepare plot of slopes
            if j==2 || j==3
                figure(j-1)
                clf
                subplot(3, 1, 1)
                plot (VectorOfOffsetValues, VectorOfCurrentValues, '-ob');
                ylabel('I (A)')
                title(sprintf('DCCT Current (averaged over %1.0f s)', TimeForIntegration))
                subplot(3, 1, 2)
                plot (VectorOfOffsetValues, VectorOfCurrentSlopeValues, '-or');
                xlabel('Offset (mm)')
                ylabel('<dI/dt> (mA/s)')
                title(sprintf('DCCT Current slope (averaged over %1.0f s)', TimeForIntegration))
                subplot(3, 1, 3)
                plot (VectorOfOffsetValues, VectorOfTunesZ, '-ok');
                xlabel('Offset (mm)')
                ylabel('Nuz')
                title('Vertical tune')

            end
            
            % Measure currents
            VectorOfCurrentValuesDuringStep=nan(1, NumberOfPointsPerOffset);
            for iPoint=1:NumberOfPointsPerOffset
                Structure=tango_read_attribute('ans/dg/dcct-ctrl', 'current');
                Current=Structure.value;
                VectorOfCurrentValuesDuringStep(iPoint)=Current;
                fprintf ('Offset %g/%g (value=%g mm) : Measurement %g/%g\n', iOffset, NumberOfOffsetValues, Offset, iPoint, NumberOfPointsPerOffset)
                if ~Debug
                    pause(TimeOfEachPoint);
                end
            end
            
            % Compute slope and fill in vectors or result values
            if ~Debug
                PolyForLinearFit=polyfit(1:TimeOfEachPoint:NumberOfPointsPerOffset*TimeOfEachPoint, VectorOfCurrentValuesDuringStep, 1);
                Slope=PolyForLinearFit(1);
            else
                Slope=-1e-6*((Offset-0.25)^2+2);
            end
            VectorOfCurrentSlopeValues(iOffset)=Slope;
            VectorOfCurrentValues(iOffset)=mean(VectorOfCurrentValuesDuringStep);
            
            if j==1 % reference offset value (offset=0)
                ReferenceSlope=VectorOfCurrentSlopeValues(1);
                fprintf ('Reference slope measured : %g µA/s\n', ReferenceSlope*1e6)
            end
            
            % Measure Tune
            
            TempVect=gettuneFBT;
            % TempVect=gettune;
            
            %%Modif MV le 23/01/2016
            %VectorOfTunesZ(iOffset)=TempVect(1);
            %VectorOfTunesX(iOffset)=TempVect(2);
            VectorOfTunesZ(iOffset)=TempVect(2);
            VectorOfTunesX(iOffset)=TempVect(1);
            
%             Structure=tango_read_attribute('ans/dg/bpm-tunez', 'Nu');
%             ans/rf/bbfdataviewer.1-tunex
%             Tune=Structure.value;
%             VectorOfTunesZ(iOffset)=Tune;
%             
%             Structure=tango_read_attribute('ans/dg/bpm-tunex', 'Nu');
%             Tune=Structure.value;
%             VectorOfTunesX(iOffset)=Tune;
            
            iOffset=iOffset+1;
            
            OffsetLastCondition=iOffset>NumberOfOffsetValues;
            OffsetStopCondition=abs(Offset)>SecurityMaxOffset;
            if OffsetStopCondition
                fprintf ('%s scan stopped at Offset = %g because max value is reached\n', Field, Offset)
            end
            if j==1
                SlopeStopCondition=0;
            else
                SlopeFactor=abs(Slope)./abs(ReferenceSlope);
                SlopeStopCondition=SlopeFactor>=SlopeDecreaseFactor;
            end
            if SlopeStopCondition
                fprintf ('%s scan stopped at Offset = %g because the level slope factor is reached (Factor on slope : %g)\n', Field, Offset)
            end
            ContinueCondition= ~OffsetStopCondition && ~SlopeStopCondition && ~OffsetLastCondition;
        end
        if SlopeStopCondition
            VectorOfOffsetValues=VectorOfOffsetValues(1:iOffset-1);
            VectorOfCurrentValues=VectorOfCurrentValues(1:iOffset-1);
            VectorOfCurrentSlopeValues=VectorOfCurrentSlopeValues(1:iOffset-1);
            VectorOfTunesZ=VectorOfTunesZ(1:iOffset-1);
            VectorOfTunesX=VectorOfTunesX(1:iOffset-1);
        end
        MeasStructAtOneOffset.Offsets=VectorOfOffsetValues;
        MeasStructAtOneOffset.Currents=VectorOfCurrentValues;
        MeasStructAtOneOffset.Slopes=VectorOfCurrentSlopeValues;
        MeasStructAtOneOffset.TunesZ=VectorOfTunesZ;
        MeasStructAtOneOffset.TunesX=VectorOfTunesX;
        res=setfield(res, Field, MeasStructAtOneOffset);
    end
    
    fileName=idSaveStruct(res, [idDirectory 'StructureForOffsetSearch_' idName], idName, 1, 1);
    
    %% Post-treatment of data
    idMeasureOffsets_PostTreatment(fileName)
    
%     figure(1);
%     clf;
%     subplot(2, 1, 1)
%     plot (RealVectorOfOffsetValues, VectorOfCurrentValues, '-ob');
%     %xlabel('Offset (mm)')
%     ylabel('I (A)')
%     title(sprintf('DCCT Current (averaged over %1.0f s)', TimeForIntegration))
%     subplot(2, 1, 2)
%     plot (RealVectorOfOffsetValues, VectorOfCurrentSlopeValues, '-or');
%     xlabel('Offset (mm)')
%     ylabel('<dI/dt> (mA/s)')
%     title(sprintf('DCCT Current slope (averaged over %1.0f s)', TimeForIntegration))
%     if ~EnlargeMeasurementRange
%         PolyForOffset=polyfit(RealVectorOfOffsetValues, VectorOfCurrentSlopeValues, 2);
%     	MeasuredOffset=-PolyForOffset(2)/2/PolyForOffset(1);
%     else
%         MeasuredOffset=nan;
%         % To be written...
%     end
%     fprintf ('Orignial offset : %g\nCalculated offset : %g (to be set)\n', InitialOffset, MeasuredOffset);
    
    return
end
    