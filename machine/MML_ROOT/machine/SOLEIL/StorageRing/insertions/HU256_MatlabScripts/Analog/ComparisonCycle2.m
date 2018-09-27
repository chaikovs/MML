function res=ComparisonCycle2(HU256Cell, FileTimeRange, Unit)
    res=-1;
    i=1;
    j=0;
    MaxDeltaBX1=0.005; %0.002;   % A % Limit to considerer for power supply is moving or not
    MaxDeltaBZP=0.005; %002;   % A
    StepOfTime=0.5;     % s
    NumberOfPointsToWriteAtEachWriting=10;
    OriginalFileTimeRange=FileTimeRange;
    if strcmpi(Unit, 'd')
        FullUnit='day';
        FileTimeRange=FileTimeRange*24;
    elseif strcmpi(Unit, 'h')
        FullUnit='hour';
    elseif strcmpi(Unit, 'm')
        FullUnit='minute';
        FileTimeRange=FileTimeRange/60;
    elseif strcmpi(Unit, 's')
        FullUnit='second';
        FileTimeRange=FileTimeRange/3600;
    else
        fprintf('ComparisonCycle : Unit should be ''s'', ''m'' or ''h''\n')
        return
    end
    NumberOfPoints=FileTimeRange*3600/StepOfTime+1;
    Cell=cell(NumberOfPointsToWriteAtEachWriting, 16);
    Cell(:, :)={''};
    FinalDate=datestr(addtodate(datenum(clock), OriginalFileTimeRange, FullUnit));
    
    fprintf ('\nNumber of points in file : %d\n\n', NumberOfPoints)
    fprintf ('\n\t================================================================================\n')
    fprintf ('\t|\n')
    fprintf ('\t| Work in progress!\n')
    fprintf ('\t|\n')
    fprintf ('\t| Please do not close this Matlab session until : %s\n', FinalDate)
    fprintf ('\t|\n')
    fprintf ('\t| Thank you!\n')
    fprintf ('\t| F. Briquez\n')
    fprintf ('\t================================================================================\n')
      
    if HU256Cell==4
        Beamline='PLEIADES';
    elseif HU256Cell==12
        Beamline='ANTARES';
    elseif HU256Cell==15
        Beamline='CASSIOPEE';
    else
        fprintf ('ComparisonCycle : wrong cell number ''%g''\n', HU256Cell)
        return
    end
    Directory='/home/operateur/GrpGMI/Comparaison_courants_tables_HU256';
    FileName=sprintf('Comparaison_HU256_%s_%g%s', Beamline, OriginalFileTimeRange, Unit);
    FileName=appendtimestamp(FileName);
    FileFullName=[Directory filesep FileName];
       
    FileID=fopen(FileFullName, 'w');
    if FileID==-1
        fprintf('ComparisonCycle : could not create file ''%s''\n', FileFullName)
        return
    end
    fprintf(FileID, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'i', 'Mode', 'ModeStr', 'BX1', 'BX2', 'U/D', 'BZP', 'U/D', 'CVE', 'CHE', 'CVS', 'CHS', 'CVE_tab', 'CHE_tab', 'CVS_tab', 'CHS_tab');
    fclose(FileID);

    while(i<=NumberOfPoints)
        NoMeas=0;
        if i==1
            Structure=GetDeliveredCurrents(HU256Cell);
            Currents=Structure.Currents;
            Old1_BX1=Currents(1);
            Old1_BZP=Currents(3);
            NoMeas=1;
        elseif i==2
            Structure=GetDeliveredCurrents(HU256Cell);
            Currents=Structure.Currents;
            Old2_BX1=Currents(1);
            Old2_BZP=Currents(3);
            Old_Mode=Structure.Mode;
            if Old_Mode==0
                Old_ModeStr='LV';
            elseif Old_Mode==1
                Old_ModeStr='LH';
            elseif Old_Mode==2
                Old_ModeStr='AV';
            elseif Old_Mode==3
                Old_ModeStr='AH';
            elseif Old_Mode==4
                Old_ModeStr='CR';
            end
            NoMeas=1;
        else
            
            if i>3
                OldBZPUpOrDown=BZPUpOrDown;
                OldBX1UpOrDown=BX1UpOrDown;
            end
            DeltaBX1=Old2_BX1-Old1_BX1;
            DeltaBZP=Old2_BZP-Old1_BZP;
            if abs(DeltaBX1)>MaxDeltaBX1
                BX1UpOrDown=sign(DeltaBX1);
            else
                BX1UpOrDown=0;
            end
            if abs(DeltaBZP)>MaxDeltaBZP;
                BZPUpOrDown=sign(DeltaBZP);
            else
                BZPUpOrDown=0;
            end
            if BZPUpOrDown==0&&i>3
                BZPUpOrDown=OldBZPUpOrDown;
            end
            if BX1UpOrDown==0&&i>3
                BX1UpOrDown=OldBX1UpOrDown;
            end
            Structure=GetDeliveredCurrents(HU256Cell);
            Mode=Structure.Mode;
         
            if Mode==0
                ModeStr='LV';
            elseif Mode==1
                ModeStr='LH';
            elseif Mode==2
                ModeStr='AV';
            elseif Mode==3
                ModeStr='AH';
            elseif Mode==4
                ModeStr='CR';
            end          
            
%             ModeStr=Structure.ModeStr;
            if strcmp(ModeStr, 'LH')||strcmp(ModeStr, 'AH')
                UpOrDown=BZPUpOrDown;
            elseif strcmp(ModeStr, 'LV')||strcmp(ModeStr, 'AV')
                UpOrDown=BX1UpOrDown;
            elseif strcmp(ModeStr, 'CR')
                if BX1UpOrDown==0&&BZPUpOrDown~=0
                    ModeStr='Circ';
                    UpOrDown=BZPUpOrDown;
                elseif BX1UpOrDown~=0&&BZPUpOrDown==0
                    ModeStr='CircBX';
                    UpOrDown=BX1UpOrDown;
                else
    %                 Mode=nan;
    %                 UpOrDown=nan;
                    ModeStr=Old_ModeStr;
                    UpOrDown=Old_UpOrDown;
                end
            else
                NoMeas=1;
            end
        end
        
%              if Mode==1||Mode==3)    %strcmp(ModeStr, 'LH')||strcmp(ModeStr, 'AH')
%                 UpOrDown=BZPUpOrDown;
% 
%             elseif Mode==0||Mode==2)    %strcmp(ModeStr, 'LV')||strcmp(ModeStr, 'AV')
%                 UpOrDown=BX1UpOrDown;
%             elseif Mode==4  %strcmp(ModeStr, 'CR')
%                 if BX1UpOrDown==0&&BZPUpOrDown~=0
%                     ModeStr='Circ';
%                     UpOrDown=BZPUpOrDown;
%                 elseif BX1UpOrDown~=0&&BZPUpOrDown==0
%                     ModeStr='CircBX';
%                     UpOrDown=BX1UpOrDown;
%                 else
%     %                 Mode=nan;
%     %                 UpOrDown=nan;
%                     ModeStr=Old_ModeStr;
%                     UpOrDown=Old_UpOrDown;
%                 end
%             else
%                 NoMeas=1;
%             end
        
        if ~NoMeas
            [BX1, BX2, BZP, CVE, CHE, CVS, CHS, CVE_tab, CHE_tab, CVS_tab, CHS_tab]=CompareDeliveredCurrentsToTables(HU256Cell, ModeStr, UpOrDown, 0);
            Old1_BZP=Old2_BZP;
            Old2_BZP=BZP;
            OldModeStr=ModeStr;
            Old_UpOrDown=UpOrDown;
%                 if strcmp(ModeStr, 'LV')
%                     Mode=0;
%                 elseif strcmp(ModeStr, 'LH')
%                     Mode=1;
%                 elseif strcmp(ModeStr, 'AV')
%                     Mode=2;
%                 elseif strcmp(ModeStr, 'AH')
%                     Mode=3;
%                 elseif strcmp(ModeStr, 'CR')
%                     Mode=4;
%                 end
            j=j+1;  % index of measurement done
            k=mod(j-1, NumberOfPointsToWriteAtEachWriting)+1;
            Cell(k, :)={i, Mode, ModeStr, BX1, BX2, BX1UpOrDown, BZP, BZPUpOrDown, CVE, CHE, CVS, CHS, CVE_tab, CHE_tab, CVS_tab, CHS_tab};
        end
        if i>=3
            k=mod(j-1, NumberOfPointsToWriteAtEachWriting)+1;
            WritingCondition=0;
            if abs(i-NumberOfPoints)>=NumberOfPointsToWriteAtEachWriting
                if k==NumberOfPointsToWriteAtEachWriting
                    WritingCondition=1;
                    NumberOfLinesToWrite=NumberOfPointsToWriteAtEachWriting;
                end
            else
                if k==abs(i-NumberOfPoints)
                    WritingCondition=1;     
                end
            end    
            if WritingCondition
                FileID=fopen(FileFullName, 'a');
                for line=1:k
                    i=Cell{line, 1};
                    Mode=Cell{line, 2};
                    ModeStr=Cell{line, 3};
                    BX1=Cell{line, 4};
                    BX2=Cell{line, 5};
                    BX1UpOrDown=Cell{line, 6};
                    BZP=Cell{line, 7};
                    BZPUpOrDown=Cell{line, 8};
                    CVE=Cell{line, 9};
                    CHE=Cell{line, 10};
                    CVS=Cell{line, 11};
                    CHS=Cell{line, 12};
                    CVE_tab=Cell{line, 13};
                    CHE_tab=Cell{line, 14};
                    CVS_tab=Cell{line, 15};
                    CHS_tab=Cell{line, 16};
                    fprintf(FileID, '%d\t%g\t%s\t%7.3f\t%7.3f\t%d\t%7.3f\t%d\t%7.3f\t%7.3f\t%7.3f\t%7.3f\t%7.3f\t%7.3f\t%7.3f\t%7.3f\n', i, Mode, ModeStr, BX1, BX2, BX1UpOrDown, BZP, BZPUpOrDown, CVE, CHE, CVS, CHS, CVE_tab, CHE_tab, CVS_tab, CHS_tab);
                end
                fclose(FileID);
                Cell(:, :)={''};
            end
        end
    
    
%         if ~NoMeas
            i=i+1;
            pause(StepOfTime);
%         end
    end
    
    res=1;
    return
end

    %%
% cst=5;
% fprintf ('\n')
% for i=1:20
%     val1=floor((i-1)/cst);
%     val2=mod(i-1, cst)+1;
%     fprintf('%d\t%d\t%d\n', i, val1, val2);
% end