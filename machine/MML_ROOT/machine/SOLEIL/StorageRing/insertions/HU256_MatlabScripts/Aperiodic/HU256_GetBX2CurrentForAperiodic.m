function BX2Current=HU256_GetBX2CurrentForAperiodic(BX1Current)
%Version Aperiodic


    BX2Current=-1;
    BXApMatrix= [0 0;
                25 20.403;
                50 40.34;
                75 60.79;
                100 81.34;
                125 101.85;
                150 122.34;
                175 142.84;
                200 163.34;
                225 1183.84;
                250 204.34;
                275 224.84];
    global SENSEOFCURRENT;
 
    if (BX1Current<BXApMatrix(1, 1)||BX1Current>BXApMatrix(size(BXApMatrix, 1), 1))     %BX1Current is outside the limits
        fprintf('The BX1 current is outside the limits!\n')
    else
        if (SENSEOFCURRENT==-1)
            [row, col]=find(BXApMatrix==BX1Current);
                        
            if (length(row)==0||length(col)==0)
                fprintf('The current %3.3f is not present in the BX2 Current table', BX1Current);
            elseif (size(row, 1)==1)&&(size(col, 1)==1)&&(col==1)     % Only one element of BXApMatrix corresponds
                %fprintf('option1')
                BX2Current=BXApMatrix(row, 2);
            elseif (size(find(col==1), 1)==1)  % Only one element of column1 of BXApMatrix corresponds
                %fprintf('option2')
                row=row(find(col==1));
                BX2Current=BXApMatrix(row, 2);
            else
                fprintf('Not only one current equal to %3.3fA in BX2 Current table!', BX1Current);
                return
            end
            %fprintf('%f\n', index)
            %fprintf('%f\n', index(1))
            %fprintf('%f\n', size(index, 1)~=1)
            %fprintf('%f\n', size(index, 1))
            %fprintf('%f\n', index(size(index, 1)))
            %fprintf('%f\n', size(BXApMatrix, 1))
            %fprintf('%f\n', index(size(index, 1))>size(BXApMatrix, 1))
            %fprintf('%f\n', (size(index, 1)~=1)&&(index(size(index, 1))>size(BXApMatrix, 1)))
            %if ((size(index, 1)~=1)
            %    if (index(1)~=1)
            %        fprintf('Can not extract index from BX2 Current table!');
            %        return
            %    else
            %        for (i=[2:size(index, 1)])
            %            if(index(i)<=size(BXApMatrix, 1))     % index is a vector & The last value of index is in the 2nd column of BXApMatrix
            %                index=index(1)
            %elseif (size(index, 1)==1)&&size(index, 2)==1   % index is a scalar => OK
            %else
            %    fprintf('Can not extract index from BX2 Current table!');
            %    return
            %end
            %Res=BXApMatrix(index, 2);
    
        elseif (SENSEOFCURRENT==1)
            BX2Current=BX1Current;
        else
            fprintf('SENSEOFCURRENT = %f but it should be -1 or 1', SENSEOFCURRENT)
            return
    end

end