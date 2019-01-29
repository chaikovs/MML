function res=HU256_Tab_OperationWith2Tables (Operation, FullNameOfScriptTable1_Or_Number, FullNameOfScriptTable2, FullNameOfSumScriptTable)
    res=-1;
    
    if (isa(FullNameOfScriptTable1_Or_Number, 'char')~=1)
        if (size(FullNameOfScriptTable1_Or_Number)==[1, 1])     % Table1 is a number
            Number1=FullNameOfScriptTable1_Or_Number;
            Matrix2=HU256_Tab_GetMatrixFromTable(FullNameOfScriptTable2, 0);
            if (Matrix2==-1)
                fprintf('Problem with HU256_Tab_OperationWith2Tables : table2 seems to be incorrect!\n')
                return
            end
            b=size(Matrix2);
            LittleMatrix2=Matrix2(:, 2:b(2));
            if (isa(Operation, 'char')~=1)
                fprintf('Problem with HU256_Tab_OperationWith2Tables : Operation must be a string\n')
                return
            else
                if (strcmp(Operation, '+'))
                    LittleMatrix=Number1+LittleMatrix2;
                elseif (strcmp(Operation, '-'))
                    LittleMatrix=Number1-LittleMatrix2;
                elseif (strcmp(Operation, '*'))
                    LittleMatrix=Number1.*LittleMatrix2;
                elseif (strcmp(Operation, '/'))
                    if (isempty(find(LittleMatrix2==0))==1)
                        LittleMatrix=Number1./LittleMatrix2;
                    else
                        fprintf('Problem with HU256_Tab_OperationWith2Tables : You can''t divide by Matrix2 because it contains at least one zero!\n')
                        return
                    end
                else
                    fprintf('Problem with HU256_Tab_OperationWith2Tables : Operation must be ''+'', ''-'', ''*'' or ''/''\n')
                    return
                end
            end
            Matrix=[Matrix2(:, 1), LittleMatrix(:, :)];
            res=HU256_Tab_SendMatrixToTable(Matrix, FullNameOfSumScriptTable, 1);
        else
            fprintf('Problem with HU256_Tab_OperationWith2Tables : FullNameOfScriptTable1_Or_Number should be a string or a scalar number!\n')
            return
        end
    else
        Matrix1=HU256_Tab_GetMatrixFromTable(FullNameOfScriptTable1_Or_Number, 0);
        Matrix2=HU256_Tab_GetMatrixFromTable(FullNameOfScriptTable2, 0);
        if (Matrix1==-1)
            fprintf('Problem with HU256_Tab_OperationWith2Tables : table1 seems to be incorrect!\n')
            return
        end
        if (Matrix2==-1)
            fprintf('Problem with HU256_Tab_OperationWith2Tables : table2 seems to be incorrect!\n')
            return
        end
        a=size(Matrix1);
        b=size(Matrix2);
        c=a~=b;
        if (c(1)~=0||c(2)~=0)
            fprintf('Problem with HU256_Tab_OperationWith2Tables : table1 and table2 don''t have the same size!\n')
            return
        end
        if (Matrix1(:, 1)~=Matrix2(:, 1))
            fprintf('Problem with HU256_Tab_OperationWith2Tables : table1 and table2 don''t have the same main currents!\n')
            return
        end
        LittleMatrix1=Matrix1(:, 2:a(2));
        LittleMatrix2=Matrix2(:, 2:b(2));
        if (isa(Operation, 'char')~=1)
            fprintf('Problem with HU256_Tab_OperationWith2Tables : Operation must be a string\n')
            return
        else
            if (strcmp(Operation, '+'))
                LittleMatrix=LittleMatrix1+LittleMatrix2;
            elseif (strcmp(Operation, '-'))
                LittleMatrix=LittleMatrix1-LittleMatrix2;
            elseif (strcmp(Operation, '*'))
                LittleMatrix=LittleMatrix1.*LittleMatrix2;
            elseif (strcmp(Operation, '/'))
                if (isempty(find(LittleMatrix2==0))==1)
                    LittleMatrix=LittleMatrix1./LittleMatrix2;
                else
                    fprintf('Problem with HU256_Tab_OperationWith2Tables : You can''t divide by Matrix2 because it contains at least one zero!\n')
                    return
                end
            else
                fprintf('Problem with HU256_Tab_OperationWith2Tables : Operation must be ''+'', ''-'', ''*'' or ''/''\n')
                return
            end
        end
        Matrix=[Matrix1(:, 1), LittleMatrix(:, :)];
        res=HU256_Tab_SendMatrixToTable(Matrix, FullNameOfSumScriptTable, 1);
    end
    
        