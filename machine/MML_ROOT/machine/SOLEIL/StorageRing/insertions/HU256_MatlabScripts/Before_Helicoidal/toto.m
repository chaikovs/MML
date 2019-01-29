function Result=HU256_ExtractCorrCurrentsFromTable(FullNameOfTable)
    %fid=fopen('/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/TableZ', 'r');
    %A = fscanf(fid, '%+08.3f')
    %fclose(fid);
    Result=-1
    global PRESENTCURRENT;
    global SENSEOFCURRENT;
    [Current, Bxc1D, Bxc1U, Bxc28D, Bxc28U, Bzc1D, Bzc1U, Bzc27D, Bzc27U] = textread('/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/TableZ', '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1);
    %[Current, Bxc1D, Bxc1U, Bxc28D, Bxc28U, Bzc1D, Bzc1U, Bzc27D, Bzc27U] = textread('/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/TableZ', '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1)   %'delimiter', '\t', %'%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f'
    index=find(Current==PRESENTCURRENT);
    if (SENSEOFCURRENT==1)
        Bzc1CurrentToSet=Bzc1D;
        Bzc27CurrentToSetBzc27D;
        Bxc1CurrentToSet=Bxc1D;
        Bxc28CurrentToSet=Bxc28D;
    elseif (SENSEOFCURRENT==-1)
        Bzc1CurrentToSet=Bzc1U;
        Bzc27CurrentToSetBzc27U;
        Bxc1CurrentToSet=Bxc1U;
        Bxc28CurrentToSet=Bxc28U;
    else
        fprintf('SENSEOFCURRENT = %f but it should be -1 or 1', SENSEOFCURRENT)
        return
    end
    Result=[Bzc1, Bzc27, Bxc1, Bxc28];