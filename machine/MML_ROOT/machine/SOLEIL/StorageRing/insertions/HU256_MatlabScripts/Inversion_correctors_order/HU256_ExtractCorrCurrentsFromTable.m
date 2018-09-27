function Result=HU256_ExtractCorrCurrentsFromTable(FullNameOfTable)
    %fid=fopen('/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/TableZ', 'r');
    %A = fscanf(fid, '%+08.3f')
    %fclose(fid);
    Result=-1;
    global PRESENTCURRENT
    global SENSEOFCURRENT

    %fprintf('PRESENTCURRENT : %f\n', PRESENTCURRENT)
    %fprintf('SENSEOFCURRENT : %f\n', SENSEOFCURRENT)
    [Current, Bxc1D, Bxc1U, Bzc1D, Bzc1U, Bxc28D, Bxc28U, Bzc27D, Bzc27U] = textread(FullNameOfTable, '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1);
    %Avant modif : [Current, Bxc1D, Bxc1U, Bxc28D, Bxc28U, Bzc1D, Bzc1U, Bzc27D, Bzc27U] = textread('/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/TableZ', '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1)   %'delimiter', '\t', %'%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f'
    index=find(Current==PRESENTCURRENT);
    %index=index(1);
    if (SENSEOFCURRENT==-1)
        CHECurrentToSet=Bzc1D(index);
        CHSCurrentToSet=Bzc27D(index);
        CVECurrentToSet=Bxc1D(index);
        CVSCurrentToSet=Bxc28D(index);
    elseif (SENSEOFCURRENT==1)
        CHECurrentToSet=Bzc1U(index);
        CHSCurrentToSet=Bzc27U(index);
        CVECurrentToSet=Bxc1U(index);
        CVSCurrentToSet=Bxc28U(index);
    else
        fprintf('SENSEOFCURRENT = %f but it should be -1 or 1', SENSEOFCURRENT)
        return
    end
    Result=[CVECurrentToSet, CHECurrentToSet, CVSCurrentToSet, CHSCurrentToSet];
    