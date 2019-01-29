function Result=HU256_Tab_AddLineToFileFromScriptMatrixColumn(FileFullName, Matrix, Columns, EraseContent, TitleLine)
%% Opens (or creates if not created yet) the file and adds one line in it. The line can be :
%   - A title line if TitleLine is not '' (Matrix and Column argins not taken in care in this case).
%   - A line containing the currents in Column, reordered following the cycle order, if Column is a 1x1 vector.
%   - A line containing the currents in Column(1) when main current is down and Column(2) when main current is up, if
%   Column is a 1x2 vector.
    Result=-1;
    NumberOfLines=size(Matrix, 1);
    TotalNumberOfColumns=size(Matrix, 2);
    UsedNumberOfColumns=size(Columns, 2);
    if (size(Columns ,1)~=1)
        fprintf('HU256_Tab_AddLineToFileFromScriptMatrixColumn : Columns should be a 1xN vector\n')
    end
    for i=1:UsedNumberOfColumns
        if (Columns(1, i)<0||Columns(1, i)>TotalNumberOfColumns)
            fprintf('HU256_Tab_AddLineToFileFromScriptMatrixColumn : wrong number of columns\n')
            return
        end
    end
    if (EraseContent==1)
        Fid=fopen(FileFullName, 'w+');
    else
        Fid=fopen(FileFullName, 'a+');
    end
    if (Fid==-1)
        fprintf('HU256_Tab_AddLineToFileFromScriptMatrixColumn : failed to open the file \n''%s''\n', FileFullName)
        return
    end
    if (strcmp(TitleLine, '')==0)
       fprintf(Fid, '%s', TitleLine);
    else
        MainCurrents=Matrix(:, 1);
        MainCurrents=MainCurrents';
        OrderedLines=HU256_OrderingCurrentsAlongCycle(MainCurrents, 1, 'Lines');
        OrderedCurrents=HU256_OrderingCurrentsAlongCycle(MainCurrents, 1, 'Currents');
        if (UsedNumberOfColumns==1)
            for Line=OrderedLines
                fprintf(Fid, '%+08.3f\t', Matrix(Line, Columns(1)));
%                 fprintf(DownFid, '%+08.3f\t', Matrix(line+1, Columns(1)));
            end
        elseif (UsedNumberOfColumns==2)
%             Senses=OrderedLines;
            for i=[1:size(OrderedLines, 2)-1 1]
                Line=OrderedLines(i); %(1:size(OrderedLines, 2)-1)
                if (Line==1||Line==NumberOfLines)   % Min or Max current => Sense=-1
                    ColumnIndex=1;
                else
                    if (OrderedCurrents(i+1)>OrderedCurrents(i)) %Sense=1
    %                 if (OrderedLines(Line+1)>=OrderedLines(Line)) %Sense=1
    %                     Senses(i)=1;
                        ColumnIndex=2;
                    else %Sense=-1
    %                     Senses(i)=-1;
                        ColumnIndex=1;
                    end
                end
                fprintf(Fid, '%+08.3f\t', Matrix(Line, Columns(ColumnIndex)));
%                 fprintf('Line:%1.0f\tCurrent:%+08.3f\tColumnIndex:%1.0f\n', Line, MainCurrents(Line), ColumnIndex);
            end
%             Senses(size(Senses, 2))=Senses(size(Senses, 2)-1);
%             Senses
        else
            fprintf('HU256_Tab_AddLineToFileFromScriptMatrixColumn : Columns should be a 1x1 or 1x2 vector\n')
            return
        end
    end
    fprintf(Fid, '\r\n');
    ClosingResult=fclose(Fid);
    if (ClosingResult==0)
        Result=1;
    end
end
        
    