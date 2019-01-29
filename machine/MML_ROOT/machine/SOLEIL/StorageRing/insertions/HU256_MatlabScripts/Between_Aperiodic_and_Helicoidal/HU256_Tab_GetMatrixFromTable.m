function Result=HU256_Tab_GetMatrixFromTable(FullNameOfScriptTable, UpOrDown)
    
    Result=-1;
   
    LengthOfName=size(FullNameOfScriptTable, 2);
    if (LengthOfName>=4)
        if (strcmp(FullNameOfScriptTable(LengthOfName-3:LengthOfName), '.txt')==1)
            FullNameOfScriptTable=FullNameOfScriptTable(1:LengthOfName-4);
        end
    end
    
    %[Current, Bzc1D, Bzc1U, Bzc27D, Bzc27U, Bxc1D, Bxc1U, Bxc28D, Bxc28U] = textread(FullNameOfTable, '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1);
    %[Current, Bxc1D, Bxc1U, Bxc28D, Bxc28U, Bzc1D, Bzc1U, Bzc27D, Bzc27U] = textread('/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/TableZ', '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1)   %'delimiter', '\t', %'%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f'
    fid=fopen(FullNameOfScriptTable, 'r+');
    if (fid==-1)
        fprintf('Problem in HU256_Tab_GetMatrixFromTable : Impossible to open "%s"! The path may be wrong.\n', FullNameOfScriptTable)
        return
    end
    fclose(fid);
    % Before new order of correctors : [Current, Bzc1D, Bzc1U, Bzc27D, Bzc27U, Bxc1D, Bxc1U, Bxc28D, Bxc28U] = textread(FullNameOfScriptTable, '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1);
    [Current, Bxc1D, Bxc1U, Bzc1D, Bzc1U, Bxc28D, Bxc28U, Bzc27D, Bzc27U] = textread(FullNameOfScriptTable, '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1);
    if (UpOrDown==-1)
        % Before new order of correctors : Result=[Current, Bzc1D, Bzc27D, Bxc1D, Bxc28D];
        Result=[Current, Bxc1D, Bzc1D, Bxc28D, Bzc27D];
        if (size(Result, 2)~=5)
            fprintf('Problem in HU256_Tab_GetMatrixFromTable : The obtained matrix has %d columns but it should have 5 columns.\n', size(Result, 2))
            Result=-1;
            return
        end
    elseif (UpOrDown==1)
        % Before new order of correctors : Result=[Current, Bzc1U, Bzc27U, Bxc1U, Bxc28U];
        Result=[Current, Bxc1U, Bzc1U, Bxc28U, Bzc27U];
        if (size(Result, 2)~=5)
            fprintf('Problem in HU256_Tab_GetMatrixFromTable : The obtained matrix has %d columns but it should have 5 columns.\n', size(Result, 2))
            Result=-1;
            return
        end
    else
        % Before new order of correctors : Result=[Current, Bzc1D, Bzc1U, Bzc27D, Bzc27U, Bxc1D, Bxc1U, Bxc28D, Bxc28U];
        Result=[Current, Bxc1D, Bxc1U, Bzc1D, Bzc1U, Bxc28D, Bxc28U, Bzc27D, Bzc27U];
        if (size(Result, 2)~=9)
            fprintf('Problem in HU256_Tab_GetMatrixFromTable : The obtained matrix has %d columns but it should have 9 columns.\n', size(Result, 2))
            Result=-1;
            return
        end
    end
    