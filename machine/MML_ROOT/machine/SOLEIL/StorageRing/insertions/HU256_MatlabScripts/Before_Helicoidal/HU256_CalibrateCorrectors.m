function res=HU256_CalibrateCorrectors(HU256Cell, AcquisitionsDirectory, OutTextFileName)
    %/home/operateur/GrpGMI/HU256_ANTARES/SESSION_2007_06_07/Calibration3(bonne)
    % HU256_CalibrateCorrectors(12, AcquisitionsDirectory, OutTextFileName)
    ListOfZCorCurrents=[-2 -1 0 1 2];
    ListOfXCorCurrents=[-6 -3 0 3 6];
    WaitingTimeBeforeAcquisition=15; % in seconds
    OrbitMeasurement=1; % If 0, no orbit acquisition made
    TabNumber=1;   % Number of tabulations before each line
    pause on;
    res=-1;
    % Check that '0' is in ListOfCorCurrents
    if (size(find(ListOfZCorCurrents==0), 2)~=1||size(find(ListOfXCorCurrents==0), 2)~=1);
        fprintf('Problem with HU256_CalibrateCorr : The specified ListOfCorCurrents is incorrect : 0 is missing\n')
        return
    end
    
    global HU256CELL % To simulate
    BackupHU256CELL=HU256CELL;
    
    HU256CELL=HU256Cell;
    
    
    if (HU256Cell==4)
        Beamline='PLEIADES';
    elseif (HU256Cell==12)
        Beamline='ANTARES';
    elseif (HU256Cell==15)
        Beamline='CASSIOPEE';
    else
        fprintf('Problem with HU256_CalibrateCorr : HU256Cell is %f and it should be either\n\t- 4 (PLEIADES)\n\t- 12 (ANTARES)\nor\t- 15 (CASSIOPEE)\n', HU256Cell)
        return
    end

    idCorrDevServ=['ANS-C' num2str(HU256Cell, '%02.0f') '/EI/M-HU256.2_SHIM.'];
	on_or_off_corr1=tango_command_inout2([idCorrDevServ '1'], 'State');
	on_or_off_corr2=tango_command_inout2([idCorrDevServ '2'], 'State');
	on_or_off_corr3=tango_command_inout2([idCorrDevServ '3'], 'State');
    if(strcmp(on_or_off_corr1, 'ON') == 0||strcmp(on_or_off_corr2, 'ON') == 0||strcmp(on_or_off_corr3, 'ON') == 0)
    	fprintf('\n---------------------------------------------------------------------------------\nProblem with HU256_CalibrateCorr : At least one of the Shim power supplies is OFF\n---------------------------------------------------------------------------------\n\n')
    end
    
    Sc='';
    if (TabNumber~=0)
        for i=1:TabNumber
            Sc=[Sc '\t'];
        end
    end
    for i=1:2; % n° de shim
        for j=1:3:4; % n° de current

            if (i==1)
                ListOfCorCurrents=ListOfZCorCurrents;
                if (j==1)
                    Corrector='CHE';
                elseif (j==4)
                    Corrector='CHS';
                else
                    fprintf('\n--------------------------------------------------------------------\nProblem with HU256_CalibrateCorr : The corrector is not well defined\n--------------------------------------------------------------------\n\n')
                end
            elseif (i==2)
                ListOfCorCurrents=ListOfXCorCurrents;
                if (j==1)
                    Corrector='CVE';
                elseif (j==4)
                    Corrector='CVS';
                else
                    fprintf('\n--------------------------------------------------------------------\nProblem with HU256_CalibrateCorr : The corrector is not well defined\n--------------------------------------------------------------------\n\n')
                end
            else
                fprintf('\n--------------------------------------------------------------------\nProblem with HU256_CalibrateCorr : The corrector is not well defined\n--------------------------------------------------------------------\n\n')
            end
            RefIndex=find(ListOfCorCurrents==0);
            N=size(ListOfCorCurrents, 2);
            NamesCell=cell(1, N);
            LengthVector=zeros(1, N);
            
            % All correction currents are put to 0A and Ref Measurement is done
            for ShimNumber=1:2
                for CurrentNumber=1:3:4
                    idDevServ=[idCorrDevServ num2str(ShimNumber) '/current' num2str(CurrentNumber)];
                    writeattribute(idDevServ, 0);
                    fprintf('On écrit %6.3f sur %s\n', 0, idDevServ)
                end
            end
            pause(WaitingTimeBeforeAcquisition);
        	FileNameCore=[AcquisitionsDirectory filesep 'HU256_' Beamline '_Reference'];
            if (OrbitMeasurement==1)
                Struct=HU256_MeasElecBeam(0, 1, FileNameCore);
            end
        	Name=Struct.name;
        	[pathstr, Name, ext, versn] = fileparts(Name);
        	NamesCell{RefIndex}=Name;
        	LengthVector(RefIndex)=length(Name);
    
            % The (i, j) correction current is put to values in ListOfCorCurrents and all measurements except Ref one are done
            idDevServ=[idCorrDevServ num2str(i, '%1.0f') '/current' num2str(j, '%1.0f')];
    
            for CurrentIndex=1:N
                if (CurrentIndex~=RefIndex)
                    CurrentToSet=ListOfCorCurrents(CurrentIndex);
                    EntCurr=fix(CurrentToSet);
                    if (EntCurr~=CurrentToSet)
                        fprintf('\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------\nProblem with HU256_CalibrateCorr - WARNING : You should choose integer values of currents for the correctors\nOtherwise, the Acquisitions File names will be incorrect!\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n')
                    end
                    writeattribute(idDevServ, CurrentToSet);
                    fprintf('On écrit %6.3f sur %s\n', CurrentToSet, idDevServ)
                    if (CurrentToSet<0)
                        CurrentText=['m' num2str(abs(CurrentToSet))];
                    else
                        CurrentText=num2str(CurrentToSet);
                    end
                    pause(WaitingTimeBeforeAcquisition);
                    FileNameCore=[AcquisitionsDirectory filesep 'HU256_' Beamline '_' Corrector '_' CurrentText];
                    if (OrbitMeasurement==1)
                        Struct=HU256_MeasElecBeam(0, 1, FileNameCore);
                    end
                    Name=Struct.name;
                    [pathstr, Name, ext, versn] = fileparts(Name);
                    NamesCell{CurrentIndex}=Name;
                    LengthVector(CurrentIndex)=length(Name);
                end
            end
            
            % Writing of the files names in the text file, for the specified corrector (corresponding to (i, j) )
            MaxLength=max(LengthVector);
            LengthVector=MaxLength-LengthVector;
            fid = fopen([AcquisitionsDirectory filesep OutTextFileName], 'a');
            if (i==1&&j==1)
                fprintf(fid, [Sc 'if strcmp(idName, ''HU256_%s'')\n\n'], Beamline);
                fprintf(fid, [Sc '\tif strcmp(corName, ''%s'')\n' Sc '\t\tvCurVals = %s;\n'], Corrector, HU256_Vector2string(ListOfCorCurrents));
            else
                fprintf(fid, [Sc '\telseif strcmp(corName, ''%s'')\n' Sc '\t\tvCurVals = %s;\n'], Corrector, HU256_Vector2string(ListOfCorCurrents));
            end
                fprintf(fid, [Sc '\t\tfnMeasMain = cellstr([\t']);
            for CurrentIndex=1:N
                ModifiedName=[NamesCell{CurrentIndex} blanks(LengthVector(CurrentIndex))];
                if (CurrentIndex==1)
                    fprintf(fid, '''%s'';\n', ModifiedName);
                elseif (CurrentIndex==N)
                    fprintf(fid, [Sc '\t\t\t\t\t\t\t\t''%s'']);\n'], ModifiedName);
                else
                    fprintf(fid, [Sc '\t\t\t\t\t\t\t\t''%s'';\n'], ModifiedName);
                end
            end
        
            fprintf(fid, [Sc '\t\tfnMeasBkgr = cellstr([\t']);
            for CurrentIndex=1:N
                ModifiedName=[NamesCell{RefIndex} blanks(LengthVector(RefIndex))];
                if (CurrentIndex==1)
                fprintf(fid, '''%s'';\n', ModifiedName);
                elseif (CurrentIndex==N)
                    fprintf(fid, [Sc '\t\t\t\t\t\t\t\t''%s'']);\n'], ModifiedName);
                else
                    fprintf(fid, [Sc '\t\t\t\t\t\t\t\t''%s'';\n'], ModifiedName);
                end
            end
        end
    end

    % Finishing the text file and closing it
    fprintf(fid, [Sc '\tend\n']);
    fprintf(fid, [Sc 'end\t%% end of HU256_%s\n\n'], Beamline);
    
	fclose(fid);
    for ShimNumber=1:2
        for CurrentNumber=1:3:4
            idDevServ=[idCorrDevServ num2str(ShimNumber) '/current' num2str(CurrentNumber)];
            writeattribute(idDevServ, 0);
            fprintf('On écrit %6.3f sur %s\n', 0, idDevServ)
        end
    end
    
    res=1;
	HU256CELL=BackupHU256CELL;

    
    
    