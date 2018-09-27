function res=HU256_HelBx(HU256Cell, BxValue, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable)


%     global TESTWITHOUTPS;
%     global TESTWITHOUTBEAM;
    global HU256CELL;
    global BEAMLINENAME;
    global PRESENTCURRENT;
    global SENSEOFCURRENT;
    global BXPRESENTCURRENTFORHEL;
    global BXSENSEOFCURRENTFORHEL;
    global POWERSUPPLYNAME;
    global LISTOFCURRENTS;
    global BXLISTOFCURRENTSFORHEL;
    global REFORBIT;
%     global DEBUG;

    NumberOfBxCycles=2; % par défaut

    res=-1;
    
    TempValue=size(BXLISTOFCURRENTSFORHEL);
    if (NumberOfBxCycles<0||round(NumberOfBxCycles)~=NumberOfBxCycles)
        fprintf('Problem in HU256_HelBx -> NumberOfBxCycles must be a positive integer\n')
        return
    end
    if (TempValue(1)==0&&TempValue(2)==0) % BXLISTOFCURRENTSFORHEL is not a global variable yet
        fprintf ('***Problem in HU256_HelBx The helical cycle was not initialised. Please do it***\n')
        return
    end
    TempValue=size(find (BXLISTOFCURRENTSFORHEL==BxValue));
    if (TempValue(1)~=1||TempValue(2)~=1)
        fprintf('Problem in HU256_HelBx -> BxValue was not found correctly in BXLISTOFCURRENTSFORHEL\n')
        return
    end
    if (PRESENTCURRENT~=0&&SENSEOFCURRENT~=0&&BXPRESENTCURRENTFORHEL~=0)
        fprintf('Problem in HU256_HelBx -> Bz and Bx currents must be 0A. Bz=%3.3fA and Bx=%3.3fA\n', BXPRESENTCURRENTFORHEL, PRESENTCURRENT)
        return
    end
    
    res1=1;
    res2=1;
    for i=1:NumberOfBxCycles
        while (res1==1&&res2==1)
            res1=HU256_TotalCycling(HU256Cell, 'max', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, '', 0, DispCorrTable);
            if (res1==1)
                res2=HU256_TotalCycling(HU256Cell, 'off', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, '', 0, DispCorrTable);
            else
                return
            end
        end
    end
    % A 0A, on enregistre la ref
     if (SENSEOFCURRENT==1)
        StringSenseOfCurrent='U';
    else
        StringSenseOfCurrent='D';
    end
    fileNameCore=['HU256_' BEAMLINENAME '_' upper(POWERSUPPLYNAME) '_' num2str(PRESENTCURRENT) '_' StringSenseOfCurrent];
    ElecBeamStructure = HU256_MeasElecBeam(0, 1, [OrbitsAcquisitionDirectory filesep fileNameCore]);
    REFORBIT=ElecBeamStructure.name;
    res1=HU256_TotalCycling(HU256Cell, 'max', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, '', 0, DispCorrTable);
    if (res1==1)
        res2=1;
        while (BXPRESENTCURRENTFORHEL~=BxValue&&res2==1)
            res2=HU256_TotalCycling(HU256Cell, 'bx', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, '', 0, DispCorrTable);
        end
        res=HU256_TotalCycling(HU256Cell, 'bz', 'hel', '', 0, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable);
        return
        
    else
        return
    end
    
    res=HU256_TotalCycling(HU256Cell, 'off', 'hel', '', 0, OrbitsAcquisitionDirectory, 0, 0);