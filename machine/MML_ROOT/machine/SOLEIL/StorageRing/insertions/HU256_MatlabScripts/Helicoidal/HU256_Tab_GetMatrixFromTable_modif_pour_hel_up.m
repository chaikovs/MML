function Result=HU256_Tab_GetMatrixFromTable(FullNameOfScriptTable, UpOrDown, DisplayErrors)
% Returns the matrix containing the correction currents written in the FullNameOfScriptTable
% If the Table doesn't exist, returns -1
% If there is a problem during the script, returns -2
% If FullNameOfScriptTable is a string (used for linear polarisations) :
%   - UpOrDown =-1 => Only Down values (5 columns matrix)
%   - UpOrDown =1 => Only Up values (5 columns matrix)
%   - UpOrDown =0 => both Up and Down values (9 columns matrix)
% If FullNameOfScriptTable is a structure containing 2 strings :    - FullNameOfScriptTable.U : Up values table name
%   (used for helicoidal polarisations) :                           - FullNameOfScriptTable.D Down values table name
%   - UpOrDown = -1 : Matrix is taken from the Up Bx table (5 columns)
%   - UpOrDown = 1 : Matrix is taken from the "Bz & Down Bx" table (9 columns)
% 

    Result=-2;
    
    if (isa(FullNameOfScriptTable, 'char')==1)    % classic mode
        %fprintf('string : %f\n', isa(FullNameOfScriptTable, 'char'))
        LengthOfName=size(FullNameOfScriptTable, 2);
        if (LengthOfName>=4)
            if (strcmp(FullNameOfScriptTable(LengthOfName-3:LengthOfName), '.txt')==1)
                FullNameOfScriptTable=FullNameOfScriptTable(1:LengthOfName-4);
            end
        end

        %[Current, Bxc1D, Bxc1U, Bxc28D, Bxc28U, Bzc1D, Bzc1U, Bzc27D, Bzc27U] = textread('/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/TableZ', '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1)   %'delimiter', '\t', %'%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f'
        fid=fopen(FullNameOfScriptTable, 'r+');
        if (fid==-1)
            if (DisplayErrors==1)
                fprintf('Problem in HU256_Tab_GetMatrixFromTable : Impossible to open "%s"! The path may be wrong.\n', FullNameOfScriptTable)
            end
            Result=-1;
            return
        end
        fclose(fid);
        [Current, CVEU, CHEU, CVSU, CHSU] = textread(FullNameOfScriptTable, '%f %f %f %f %f','delimiter', '\t', 'headerlines', 1);
        if (UpOrDown==-1)
            % Before new order of correctors : Result=[Current, Bzc1D, Bzc27D, Bxc1D, Bxc28D];
            Result=[Current, CVED, CHED, CVSD, CHSD];
            if (size(Result, 2)~=5)
                if (DisplayErrors==1)
                    fprintf('Problem in HU256_Tab_GetMatrixFromTable : The obtained matrix ''%s'' has %d columns but it should have 5 columns.\n', FullNameOfScriptTable, size(Result, 2))
                end
                Result=-2;
                return
            end
        elseif (UpOrDown==0)
            % Before new order of correctors : Result=[Current, Bzc1U, Bzc27U, Bxc1U, Bxc28U];
            Result=[Current, CVEU, CHEU, CVSU, CHSU];
            if (size(Result, 2)~=5)
                if (DisplayErrors==1)
                    fprintf('Problem in HU256_Tab_GetMatrixFromTable : The obtained matrix ''%s'' has %d columns but it should have 5 columns.\n', FullNameOfScriptTable, size(Result, 2))
                end
                Result=-2;
                return
            end
%         elseif (UpOrDown==0)
%             % Before new order of correctors : Result=[Current, Bzc1D, Bzc1U, Bzc27D, Bzc27U, Bxc1D, Bxc1U, Bxc28D, Bxc28U];
%             Result=[Current, CVED, CVEU, CHED, CHEU, CVSD, CVSU, CHSD, CHSU];
%             if (size(Result, 2)~=9)
%                 if (DisplayErrors==1)
%                     fprintf('Problem in HU256_Tab_GetMatrixFromTable : The obtained matrix ''%s'' has %d columns but it should have 9 columns.\n', FullNameOfScriptTable, size(Result, 2))
%                 end
%                 Result=-2;
%                 return
%             end
        else
            if (DisplayErrors)
                fprintf('Problem in HU256_Tab_GetMatrixFromTable : UpOrDown should be -1, 0 or 1 in classic mode, but it is %s.\n', UpOrDown)
            end
            Result=-2;
            return
        end
    elseif (isa(FullNameOfScriptTable, 'struct')==1)    % helicoidal mode ( <=> structure)
        %fprintf('structure\n')
        Names=fieldnames(FullNameOfScriptTable);
        Size=(size(Names));
%         Size(1)~=2
%         Size(2)~=1
%         isa(Names(1), 'char')==0
%         isa(Names(2), 'char')==0
%         size(Size, 1)
%         size(Size, 2)
%         strcmp(Names(1), 'U')==0
%         strcmp(Names(2), 'D')==0
%         if (size(Size, 2)~=2||strcmp(Names(1), 'U')==0||strcmp(Names(2), 'D')==0)
%             fprintf('Problem in HU256_Tab_GetMatrixFromTable : FullNameOfScriptTable, as a structure, should contain the ''U'' string and the ''D'' string.\n')
%             Result=-2;
%             return
%         end
        if (UpOrDown==-1)
            % Down Table
            FullNameOfScriptTableD=FullNameOfScriptTable.D;
            LengthOfName=size(FullNameOfScriptTableD, 2);
            if (LengthOfName>=4)
                if (strcmp(FullNameOfScriptTableD(LengthOfName-3:LengthOfName), '.txt')==1)
                    FullNameOfScriptTableD=FullNameOfScriptTableD(1:LengthOfName-4);
                end
            end
            %[Current, CVED, CVEU, CHED, CHEU, CVSD, CVSU, CHSD, CHSU]=HU256_Tab_GetMatrixFromTable(FullNameOfScriptTableD, 0, DisplayErrors);
            Result=HU256_Tab_GetMatrixFromTable(FullNameOfScriptTableD, 0, DisplayErrors);
            %Result=[Current, CVED, CVEU, CHED, CHEU, CVSD, CVSU, CHSD, CHSU];
        elseif (UpOrDown==1)
            % Up Table => There are only 5 columns!
            FullNameOfScriptTableU=FullNameOfScriptTable.U;
            LengthOfName=size(FullNameOfScriptTableU, 2);
            if (LengthOfName>=4)
                if (strcmp(FullNameOfScriptTableU(LengthOfName-3:LengthOfName), '.txt')==1)
                    FullNameOfScriptTableU=FullNameOfScriptTableU(1:LengthOfName-4);
                end
            end

            fid=fopen(FullNameOfScriptTableU, 'r+');
            if (fid==-1)
                if (DisplayErrors==1)
                    fprintf('Problem in HU256_Tab_GetMatrixFromTable : Impossible to open "%s"! The path may be wrong.\n', FullNameOfScriptTableU)
                end
                Result=-1;
                return
            end
            fclose(fid);
            [Current, CVEU, CHEU, CVSU, CHSU] = textread(FullNameOfScriptTableU, '%f %f %f %f %f','delimiter', '\t', 'headerlines', 1);
            Result=[Current, CVEU, CHEU, CVSU, CHSU];
            if (size(Result, 2)~=5)
                if (DisplayErrors==1)
                    fprintf('Problem in HU256_Tab_GetMatrixFromTable : The obtained matrix ''%s'' has %d columns but it should have 5 columns.\n', FullNameOfScriptTableU, size(Result, 2))
                end
                Result=-2;
                return
            end
        else
            fprintf('Problem in HU256_Tab_GetMatrixFromTable : UpOrDown must be -1 or 1 when FullNameOfScriptTable is a structure\n')
            Result=-2;
            return
        end
    else
        fprintf('Problem with HU256_Tab_GetMatrixFromTable : FullNameOfScriptTable should be a string or a structure containing 2 strings\n')
        Result=-1;
        return
    end