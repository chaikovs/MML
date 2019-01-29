function Result=HU640_ExtractCorrCurrentsFromTable(FullNameOfTable)

    Result=-1;
    global PRESENTCURRENT
    global SENSEOFCURRENT
    
    %fprintf('PRESENTCURRENT : %f\n', PRESENTCURRENT)
    %fprintf('SENSEOFCURRENT : %f\n', SENSEOFCURRENT)
    [Current, CHED, CHEU, CHSD, CHSU, CVED, CVEU, CVSD, CVSU] = textread(FullNameOfTable, '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1);

    index=find(Current==PRESENTCURRENT);
    %index=index(1);
    if (SENSEOFCURRENT==-1)
        CHECurrentToSet=CHED(index);
        CHSCurrentToSet=CHSD(index);
        CVECurrentToSet=CVED(index);
        CVSCurrentToSet=CVSD(index);
    elseif (SENSEOFCURRENT==1)
        CHECurrentToSet=CHEU(index);
        CHSCurrentToSet=CHSU(index);
        CVECurrentToSet=CVEU(index);
        CVSCurrentToSet=CVSU(index);
    else
        fprintf('SENSEOFCURRENT = %f but it should be -1 or 1', SENSEOFCURRENT)
        return
    end
    Result=[CHECurrentToSet, CHSCurrentToSet, CVECurrentToSet, CVSCurrentToSet];
    