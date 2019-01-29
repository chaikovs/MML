function Result=HU256_ExtractCorrCurrentsFromTable(DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection)
    % Extract the correction currents contained in the table selected by its directory and its suffix.
    % Returns a vector containing the 4 corrector values (CVE, CHE, CVS, CHS)
    % Returns -1 if failed.
    % If the currents are written in both tables (Bx=0, Bz=0, Bz moving down), the currents from both tables are
    % compared. If they are not equal, returns -1.

    %fid=fopen('/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/TableZ', 'r');
    %A = fscanf(fid, '%+08.3f')
    %fclose(fid);
    Result=-1;
    global PRESENTCURRENT;
    global SENSEOFCURRENT;
    global BXSENSEOFCURRENTFORHEL;
    global BXPRESENTCURRENTFORHEL;
    global APERIODIC;
    global DEBUG;
    global BXLISTOFCURRENTSFORHEL;
    global LISTOFCURRENTS;
    
    if (isa(APERIODIC, 'numeric')==1)   % Linear modes
        NameOfTableToUseForCorrection=HU256_GetTableFileNameForHel(SuffixOfTableToUseForCorrection, 0);
        if (DEBUG==1)
            fprintf('Debug HU256_ExtractCorrCurrentsFromTable : NameOfTableToUseForCorrection=''%s''\n', NameOfTableToUseForCorrection)
        end
        if (isa (NameOfTableToUseForCorrection, 'char')==1)
            FullNameOfTableToUseForCorrection=[DirectoryOfTableToUseForCorrection filesep NameOfTableToUseForCorrection];
            Matrix=HU256_Tab_GetMatrixFromTable(FullNameOfTableToUseForCorrection, 0, DEBUG);
            if (Matrix==-2) % Pas sur que ça marche!!
                fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : The matrix couldn''t be extraced from the table\n')
                return
            end
            if (Matrix==-1) % Pas sur que ça marche!!
                fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : The table %s wasn''t found\n', NameOfTableToUseForCorrection)
                return
            end
            if (size(Matrix, 2)~=9)
                fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : The table should have 9 columns but it has %f columns\n', size(Matrix, 2))
                return
            end
            index=find(LISTOFCURRENTS==PRESENTCURRENT);
            if (index==-1)
                fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : the present current was not found in the list of currents!\n')
            end
            if (SENSEOFCURRENT==-1)
                i0=2;
            else
                i0=3;
            end
            for i=1:4
                j=2*(i-1)+i0;
                Result(i)=Matrix(index, j);
            end
            
%             [Current, Bxc1D, Bxc1U, Bzc1D, Bzc1U, Bxc28D, Bxc28U, Bzc27D, Bzc27U] = textread(NameOfTableToUseForCorrection, '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1);
%             %Avant modif : [Current, Bxc1D, Bxc1U, Bxc28D, Bxc28U, Bzc1D, Bzc1U, Bzc27D, Bzc27U] = textread('/home/operateur/GrpGMI/HU256_CASSIOPEE/Temp_Tests/TableZ', '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1)   %'delimiter', '\t', %'%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f\t%+08.3f'
%             index=find(Current==PRESENTCURRENT);
%             %index=index(1);
%             if (SENSEOFCURRENT==-1)
%                 CHECurrentToSet=Bzc1D(index);
%                 CHSCurrentToSet=Bzc27D(index);
%                 CVECurrentToSet=Bxc1D(index);
%                 CVSCurrentToSet=Bxc28D(index);
%             elseif (SENSEOFCURRENT==1)
%                 CHECurrentToSet=Bzc1U(index);
%                 CHSCurrentToSet=Bzc27U(index);
%                 CVECurrentToSet=Bxc1U(index);
%                 CVSCurrentToSet=Bxc28U(index);
%             else
%                 fprintf('SENSEOFCURRENT = %f but it should be -1 or 1', SENSEOFCURRENT)
%                 return
%             end
%             Result=[CVECurrentToSet, CHECurrentToSet, CVSCurrentToSet, CHSCurrentToSet];
%             for i=1:4
%                 if (Result(i)<-10||Result(i)>10)
%                     fprintf ('Problem with HU256_ExtractCorrCurrentsFromTable : At least one of the correction currents extracted from the table is out of range!\n')
%                     Result=-1;
%                     return
%                 end
%             end
        else
            fprintf('Big Problem with HU256_ExtractCorrCurrentsFromTable : Linear mode is asked for but NameOfTableToUseForCorrection is not a string!\n')
            return
        end
    else    % helicoidal mode (APERIODIC = struct)
        NamesOfTableToUseForCorrection=HU256_GetTableFileNameForHel(SuffixOfTableToUseForCorrection, 0);
        
        if (isa (NamesOfTableToUseForCorrection, 'struct')==1)
%             NameOfTableToUseForCorrection=HU256_GetTableFileNameForHel(NameOfTableToUseForCorrection, 0);
            NameOfDTable=NamesOfTableToUseForCorrection.D;
            NameOfUTable=NamesOfTableToUseForCorrection.U;
            if (DEBUG==1)
                fprintf('Debug HU256_ExtractCorrCurrentsFromTable : NameOfTableToUseForCorrection.U=''%s''\n', NameOfDTable)
                fprintf('Debug HU256_ExtractCorrCurrentsFromTable : NameOfTableToUseForCorrection=.D''%s''\n', NameOfUTable)
            end
            FullNamesOfTableToUseForCorrection.D=[DirectoryOfTableToUseForCorrection filesep NameOfDTable];
            FullNamesOfTableToUseForCorrection.U=[DirectoryOfTableToUseForCorrection filesep NameOfUTable];
            i=find(BXLISTOFCURRENTSFORHEL==BXPRESENTCURRENTFORHEL);     % i = n°ligne de la tableU
            if (i==-1)
                fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : the present Bx current was not found in the list of Bx currents!\n')
            end
            ConditionOfBothTables=((i==1||i==length(BXLISTOFCURRENTSFORHEL))&&(PRESENTCURRENT==0&&SENSEOFCURRENT==-1));
            if (DEBUG)
                fprintf('i : %f, length(BXLISTOFCURRENTSFORHEL) : %f, PRESENTCURRENT : %f, SENSEOFCURRENT : %f\n', i, length(BXLISTOFCURRENTSFORHEL), PRESENTCURRENT, SENSEOFCURRENT);
            end

%             if (i==1||i==length(BXLISTOFCURRENTSFORHEL)) % extremity Bx current => The currents are extracted from UpTable (or also DownTable if BZ=0 AND BZ moving down)
%                 if (PRESENTCURRENT==0&&SENSEOFCURRENT==-1)
%                     UMatrix=HU256_Tab_GetMatrixFromTable(FullNamesOfTableToUseForCorrection, 1, DEBUG);
%                     DMatrix=HU256_Tab_GetMatrixFromTable(FullNamesOfTableToUseForCorrection, -1, DEBUG);
%                     if (UMatrix==-2||UMatrix==-1||DMatrix==-2||DMatrix==-1) % Pas sur que ça marche!!
%                         fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : At least one of the matrix was not extraced correctly from the table\n')
%                         return
%                     end
%                     if (size(UMatrix, 2)~=5)
%                         fprintf('Problem with HU256_ExtractCorrCurrentsFromTable : The Up matrix should have 5 columns but it has %f columns\n', size(Matrix, 2))
%                         return
%                     end
%                     if (size(DMatrix, 2)~=9)
%                         fprintf('Problem with HU256_ExtractCorrCurrentsFromTable : The Down matrix should have 9 columns but it has %f columns\n', size(Matrix, 2))
%                         return
%                     end
%                     index=find(LISTOFCURRENTS==PRESENTCURRENT);
%                     if (index==-1)
%                         fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : the present current was not found in the list of currents!\n')
%                     end
%                     for j=1:4
%                         UCurrents(j)=UMatrix(i, j+1);
%                         
%                     end
                    
%             if (BXSENSEOFCURRENTFORHEL==1||ConditionOfBothTables==1)  % Extract only from Up Table
                if (strcmp(NameOfUTable, '')==0)
                    Matrix=HU256_Tab_GetMatrixFromTable(FullNamesOfTableToUseForCorrection, 1, DEBUG);
                    if (size(Matrix, 2)~=5)
                        fprintf('Problem with HU256_ExtractCorrCurrentsFromTable : The matrix should have 5 columns but it has %d columns\n', size(Matrix, 2))
                        return
                    end
                    if (Matrix==-2) % Pas sur que ça marche!!
                        fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : The matrix couldn''t be extraced from the table\n')
                        return
                    end
                    if (Matrix==-1) % Pas sur que ça marche!!
                        fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : The table wasn''t found\n')
                        return
                    end
                    UResult=zeros(1, 4);
                    for j=1:4
                        UResult(j)=Matrix(i, j+1);
                    end
                    Result=UResult;
%                 else
%                     fprintf ('Problem in HU256_ExtractCorrCurrentsFromTable : NameOfUTable should not be empty\n')
%                     return
                end
%                 if (strcmp(NameOfDTable, '')==0)
%                     fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : NameOfDTable is not empty but it should !\n')
%                     Result=-1;
%                     return
%                 end
%             end
%             if (BXSENSEOFCURRENTFORHEL==-1||ConditionOfBothTables==1)  % Extract from Down tables
                if (strcmp(NameOfDTable, '')==0)
                    Matrix=HU256_Tab_GetMatrixFromTable(FullNamesOfTableToUseForCorrection, -1, DEBUG);
                    if (size(Matrix, 2)~=9)
                        fprintf('Problem with HU256_ExtractCorrCurrentsFromTable : The matrix should have 9 columns but it has %d columns\n', size(Matrix, 2))
                        return
                    end
                    if (Matrix==-2) % Pas sur que ça marche!!
                        fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : The matrix couldn''t be extraced from the table\n')
                        return
                    end
                    if (Matrix==-1) % Pas sur que ça marche!!
                        fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : The table wasn''t found\n')
                        return
                    end
                    index=find(LISTOFCURRENTS==PRESENTCURRENT);     % index = n°ligne de la tableD
                    if (index==-1)
                        fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : the present current was not found in the list of currents!\n')
                    end
                    if (SENSEOFCURRENT==-1)
                        i0=2;
                    else
                        i0=3;
                    end
                    DResult=zeros(1, 4);
                    for i=1:4
                        j=2*(i-1)+i0;
                        DResult(i)=Matrix(index, j);
                    end
                    Result=DResult;
%                 else
%                     fprintf('Problem with HU256_ExtractCorrCurrentsFromTable : NameOfDTable should not be empty\n')
%                     Result=-1;
%                     return
                end
%                 if (strcmp(NameOfUTable, '')==0)
%                     fprintf('Problem in HU256_ExtractCorrCurrentsFromTable : NameOfUTable is not empty but it should !\n')
%                     Result=-1;
%                     return
%                 end    
%             end
            if (ConditionOfBothTables==1)
                %fprintf('UResult : %f, DResult : %f\n', UResult, DResult)
%                 UResult
%                 DResult
%                 a=size(UResult, 2)
%                 b=size(DResult, 2)
%                 c=size(UResult, 2)==size(DResult, 2)
%                 d=sum(UResult==DResult)
%                 e=sum(UResult==DResult)==size(UResult, 2)
                if (sum(sum(isnan(UResult)))~=0||sum(sum(isnan(DResult)))~=0) % At least one of the 2 tables contains at least one NaN
                    EqualityBetweenUpAndDownTables=(sum(isnan(UResult)==isnan(DResult))==size(UResult, 2)&&size(UResult, 2)==size(DResult, 2)) % All values of the correctors vector are NaN, and same size of tables => same tables with only NaN values!
                else % The 2 tables contain only numbers
                    EqualityBetweenUpAndDownTables=sum(UResult==DResult)==size(UResult, 2)&&size(UResult, 2)==size(DResult, 2)
                end
                if (EqualityBetweenUpAndDownTables==0)
                    fprintf('Problem with HU256_ExtractCorrCurrentsFromTable : BX=%3.3f, BZ=%3.3f, SenseOfBZ=%i\n', BXPRESENTCURRENTFORHEL, PRESENTCURRENT, SENSEOFCURRENT)
                    fprintf('=> Correction currents can be extracted in both tables, but They are not equal :\n')
                    fprintf('Currents from Up Table :\tCVE=%3.3f\tCHE=%3.3f\tCVS=%3.3f\tCHS=%3.3f\n', UResult(1), UResult(2), UResult(3), UResult(4)')
                    fprintf('Currents from Down Table :\tCVE=%3.3f\tCHE=%3.3f\tCVS=%3.3f\tCHS=%3.3f\n', DResult(1), DResult(2), DResult(3), DResult(4)')
                    Result=-1;
                    return
                end
            end
        else
            fprintf('Big problem  with HU256_ExtractCorrCurrentsFromTable : Helicoidal mode is asked for but NameOfTableToUseForCorrection is not a structure!\n')
            return
        end
    end