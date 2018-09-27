function OutputFFWDTableStructure=idSumOf2FFWDTableStructures(FFWDTableStructure1, FFWDTableStructure2, PhaseRange, GapRange)
% Written by F. Briquez. NOT FINISHED!!!!
OutputFFWDTableStructure=struct([]);
CheckResult1=idCheckFFWDTableStructure(FFWDTableStructure1);
CheckResult2=idCheckFFWDTableStructure(FFWDTableStructure2);
if (CheckResult1==-1)
    fprintf ('Error in ''idSumOf2FFWDTableStructures'' : FFWDTableStructure1 is incorrect\n');
end
if (CheckResult2==-1)
    fprintf ('Error in ''idSumOf2FFWDTableStructures'' : FFWDTableStructure2 is incorrect\n');
end

FFWDTableStructure=struct;

vPhases1=FFWDTableStructure1.vPhases;
vGaps1=FFWDTableStructure1.vGaps;
FFWDTable1=FFWDTableStructure1.Table;
FFWDTableWithArgs1=FFWDTableStructure1.TableWithArgs;
idName1=FFWDTableStructure1.idName;
CorrectorName1=FFWDTableStructure1.CorrectorName;
idMode1=FFWDTableStructure1.idMode;

vPhases2=FFWDTableStructure2.vPhases;
vGaps2=FFWDTableStructure2.vGaps;
FFWDTable2=FFWDTableStructure2.Table;
FFWDTableWithArgs2=FFWDTableStructure2.TableWithArgs;
idName2=FFWDTableStructure2.idName;
CorrectorName2=FFWDTableStructure2.CorrectorName;
idMode2=FFWDTableStructure2.idMode;

if (strcmpi(idName1, idName2)==0)
    fprintf ('WARNING in idSumOf2FFWDTableStructures: not coherent ID names\n=> ''%s'' will be used\n', idName1)
end
if (strcmpi(CorrectorName1, CorrectorName2)==0)
    fprintf ('WARNING in idSumOf2FFWDTableStructures: not coherent corrector names\n=> ''%s'' will be used\n', CorrectorName1)
end
if (strcmpi(idMode1, idMode2)==0)
    fprintf ('WARNING in idSumOf2FFWDTableStructures: not coherent ID modes\n=> ''%s'' will be used\n', idMode1)
end

if (size(PhaseRange, 1)==1&&size(PhaseRange, 2)==2)
    PhaseStart=PhaseRange(1);
    PhaseEnd=PhaseRange(2);
elseif (size(PhaseRange, 1)==0&&size(PhaseRange, 2)==0)
    LargestIntersectionVector=idAuxLargestIntersectionOfVectors(vPhases1, vPhases2);
    PhaseStart=LargestIntersectionVector(1);
    PhaseEnd=LargestIntersectionVector(2);
else
    fprintf ('Error in ''idSumOf2FFWDTableStructures'' : Range of phase is incorrect\n');
end
if (PhaseStart<vPhases1(1)||PhaseStart<vPhases2(1))
    fprintf ('Error in ''idSumOf2FFWDTableStructures'' : Lower limit of phase range outside of table limits\n');
    return
end
if (PhaseEnd>vPhases1(length(vPhases1))||PhaseEnd>vPhases2(length(vPhases2)))
    fprintf ('Error in ''idSumOf2FFWDTableStructures'' : Upper limit of phase range outside of table limits\n');
    return
end

if (size(GapRange, 1)==1&&size(GapRange, 2)==2)
    GapStart=GapRange(1);
    GapEnd=GapRange(2);
elseif (size(GapRange, 1)==0&&size(GapRange, 1)==0)
    LargestIntersectionVector=idAuxLargestIntersectionOfVectors(vGaps1, vGaps2);
    GapStart=LargestIntersectionVector(1);
    GapEnd=LargestIntersectionVector(2);
else
    fprintf ('Error in ''idSumOf2FFWDTableStructures'' : Range of gap is incorrect\n');
    return
end
if (GapStart<vGaps1(1)||GapStart<vGaps2(1))
    fprintf ('Error in ''idSumOf2FFWDTableStructures'' : Lower limit of Gap range outside of table limits\n');
    return
end
if (GapEnd>vGaps1(length(vGaps1))||GapEnd>vGaps2(length(vGaps2)))
    fprintf ('Error in ''idSumOf2FFWDTableStructures'' : Upper limit of Gap range outside of table limits\n');
    return
end

if (length(vPhases1)==length(vPhases2)&&length(vGaps1)==length(vGaps2))
%     size(vPhases1, 1)
%     size(vPhases1, 2)
%     size(vPhases2, 1)
%     size(vPhases2, 2)
    sum(vPhases1==vPhases2)
    length(vPhases1)
    
   	sum(vGaps1==vGaps2)
    length(vGaps1)
    
    if (sum(vPhases1==vPhases2)==length(vPhases1)&&sum(vGaps1==vGaps2)==length(vGaps1))
        OutputTable=FFWDTable1+FFWDTable2;
        OutputFFWDTableStructure=idGetFFWDTableStructureFromTable(idName1, OutputTable, vPhases1, vGaps1, idMode1, CorrectorName1);
        
%         OutputFFWDTableStructure.vPhases=vPhases1;
%         OutputFFWDTableStructure.vGaps=vGaps1;
%         OutputFFWDTableStructure.Table=OutputTable;
%         OutputFFWDTableStructure.TableWithArgs=OutuputTableWithArgs;
%         OutputFFWDTableStructure.idName=idName1;
%         OutputFFWDTableStructure.CorrectorName=CorrectorName1;
%         OutputFFWDTableStructure.idMode=idMode1;
    else
        fprintf ('not written yet\n')
    end
else
    fprintf ('not written yet\n')
end
