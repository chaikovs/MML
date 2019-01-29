function res=HU256_TempMeasCorrEff(HU256Cell, MaxCV, MaxCH, Tolerance)
    % 18/01/2012 : written to update tables of ANTARES, taking into account
    %   NANOSCOPIUP lattice...
    % CorCurVector : list of values : -6, -3, 0, 3, 6
    % InputVector : vector of current setpoints : CHE, CVE, CHS, CVS
    % Data : {name, Shim, Current}
    % Corrector currents must be integer!!!

    % Suggested values : MaxCV=6, MaxCH=2
    
    res=-1;

    Data={'CHE', 1, 1; 'CVE', 2, 1; 'CHS', 1, 4; 'CVS', 2, 4};

    if HU256Cell==4
        HU256Name='HU256_PLEIADES';
    elseif HU256Cell==12
        HU256Name='HU256_ANTARES';
    elseif HU256Cell==15
        HU256Name='HU256_CASSIOPEE';
    else
        fprintf('Wrong cel!!!\n');
        return
    end
    CVCurVector=[0 -MaxCV:MaxCV/2:MaxCV];
    CHCurVector=[0 -MaxCH:MaxCH/2:MaxCH];
    
    CVCurString='                vCurVals = [';
    CHCurString='                vCurVals = [';
    for i=2:6
        CVCurString=strcat(CVCurString, num2str(CVCurVector(i)));
        if i~=6
            CVCurString=strcat(CVCurString, ', ');
        end
        CHCurString=strcat(CHCurString, num2str(CHCurVector(i)));
        if i~=6
            CHCurString=strcat(CHCurString, ', ');
        end
    end
    CVCurString=strcat(CVCurString, '];\n');
    CHCurString=strcat(CHCurString, '];\n');
    
    
    ListOfFileNames='';

    for InputVectorIndex=1:4
        
        CorName=Data{InputVectorIndex, 1};
        if strncmp(CorName, 'CV', 2)
            CorCurVector=CVCurVector;
        elseif strncmp(CorName, 'CH', 2);
            CorCurVector=CHCurVector;
        else
            fprintf ('Wrong Data!\n')
            return
        end
        NumberOfCurrentsInCorCurVector=length(CorCurVector);
        if NumberOfCurrentsInCorCurVector~=6
            fprintf ('NumberOfCurrentsInCorCurVector should be 6 (5 + zero value)!\n');
            return
        end
        for CorCurVectortIndex=1:NumberOfCurrentsInCorCurVector
            CorCurVectorValue=CorCurVector(CorCurVectortIndex);

            InputVector=zeros(1, 4);
            InputVector(InputVectorIndex)=CorCurVectorValue;  
            %% MODIFIED FOR TESTS
            %InputVector=InputVector./1000;
            %%

    %% Set currents        
            for AlimIndex=1:4
                AlimName=Data{AlimIndex, 1};
                AlimShimNumber=Data{AlimIndex, 2};
                AlimCurrentNumber=Data{AlimIndex, 3};
                AlimDeviceName=sprintf('ANS-C%g/EI/M-HU256.2_Shim.%g', HU256Cell, AlimShimNumber);
                AlimAttributeName=sprintf('current%g', AlimCurrentNumber);
                tango_write_attribute2(AlimDeviceName, AlimAttributeName, InputVector(AlimIndex))
                fprintf ('CHE: %g, CVE: %g, CHS: %g, CVS: %g. Corr n°%g\n', InputVector, AlimIndex);
                Reached=0;
                while(~Reached)
                    pause(1);
                    CurrentStructure=tango_read_attribute2(AlimDeviceName, AlimAttributeName);
                    Value=CurrentStructure.value;
                    Value=Value(1);
                    if abs(Value-InputVector(AlimIndex))<=Tolerance
                        Reached=1;
                    end
                end
            end
    %% End of Set currents
    
    %% MODIFIED FOR TESTS
            %InputVector=InputVector.*1000;
            %%
            
            OrbitCoreName=sprintf('%s_Efficiency_he%g_ve%g_hs%g_vs%g', HU256Name, InputVector);
            Orbit=idMeasElecBeamUnd(HU256Name, 0, OrbitCoreName, 1, 1);
            if(~isempty(ListOfFileNames))
                ListOfFileNames = strcat(ListOfFileNames, '\n');
            end
            ListOfFileNames = strcat(ListOfFileNames, Orbit.file);
            ListOfFileNames = sprintf(ListOfFileNames);
        end
    end
    
    %% Set all currents to zero
    for AlimIndex=1:4
        AlimName=Data{AlimIndex, 1};
        AlimShimNumber=Data{AlimIndex, 2};
        AlimCurrentNumber=Data{AlimIndex, 3};
        AlimDeviceName=sprintf('ANS-C%g/EI/M-HU256.2_Shim.%g', HU256Cell, AlimShimNumber);
        AlimAttributeName=sprintf('current%g', AlimCurrentNumber);
        tango_write_attribute2(AlimDeviceName, AlimAttributeName, 0)
        pause(1)
    end
    
    %% Get text to put in idReadCorElecBeamMeas and save structure
    OrbitListCoreName=sprintf('%s_Efficiency_List', HU256Name);
    OrbitList=struct;
    OrbitList.file=ListOfFileNames;
    idSaveStruct(OrbitList, OrbitListCoreName, HU256Name, 1, 1);
    
    ResultString=idAuxFormatPartCorElecBeamMeasData(ListOfFileNames);
    
    for i=1:4
        CorName=Data{i, 1};
        if strncmp(CorName, 'CV', 2)
            AddCorString=CVCurString;
        elseif strncmp(CorName, 'CH', 2)
            AddCorString=CHCurString;
        end
        OldCorString=strcat('if strcmp(corName, ''', CorName, ''')\n');
        NewCorString=strcat(OldCorString, AddCorString);
        ResultString=strrep(ResultString, OldCorString, NewCorString);
    end
    
    fprintf(ResultString);
    ResultString=sprintf(ResultString);
    clipboard('copy', ResultString);
    res=0;
end