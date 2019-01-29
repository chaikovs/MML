function Result=HU256_ExtractCorrCurrentsFromTable(FullNameOfTable)
    %fid=fopen('/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/TableZ', 'r');
    %A = fscanf(fid, '%+08.3f')
    %fclose(fid);
    Result=-1;
    global PRESENTCURRENT
    global SENSEOFCURRENT
    
    %fprintf('PRESENTCURRENT : %f\n', PRESENTCURRENT)
    %fprintf('SENSEOFCURRENT : %f\n', SENSEOFCURRENT)
    [Current, Bzc1D, Bzc1U, Bzc27D, Bzc27U, Bxc1D, Bxc1U, Bxc28D, Bxc28U] = textread(FullNameOfTable, '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1);
    %[Current, Bxc1D, Bxc1U, Bxc28D, Bxc28U, Bzc1D, Bzc1U, Bzc27D, Bzc27U] = textread('/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/TableZ', '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1)   %'delimiter', '\t', %'%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f'
    index=find(Current==PRESENTCURRENT);
    %index=index(1);
    if (SENSEOFCURRENT==-1)
        Bzc1CurrentToSet=Bzc1D(index);
        Bzc27CurrentToSet=Bzc27D(index);
        Bxc1CurrentToSet=Bxc1D(index);
        Bxc28CurrentToSet=Bxc28D(index);
    elseif (SENSEOFCURRENT==1)
        Bzc1CurrentToSet=Bzc1U(index);
        Bzc27CurrentToSet=Bzc27U(index);
        Bxc1CurrentToSet=Bxc1U(index);
        Bxc28CurrentToSet=Bxc28U(index);
    else
        fprintf('SENSEOFCURRENT = %f but it should be -1 or 1', SENSEOFCURRENT)
        return
    end
    Result=[Bzc1CurrentToSet, Bzc27CurrentToSet, Bxc1CurrentToSet, Bxc28CurrentToSet];
    