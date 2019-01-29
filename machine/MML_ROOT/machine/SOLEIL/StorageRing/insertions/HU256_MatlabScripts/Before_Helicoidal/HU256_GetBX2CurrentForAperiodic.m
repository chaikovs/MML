function BX2Current=HU256_GetBX2CurrentForAperiodic(BX1Current)
% Version Aperiodic and NewTables
% If BX1Current is scalar, returns the scalar value of BX2Current calculated with Cubic Splines
% If BX1Current is a vector (row or column), returns a vector containing each corresponding value of BX2Current calculated with Cubic Splines
    
    global HU256CELL;
    global SENSEOFCURRENT;
    
    BX2Current=-1;
    
    % WARNING : The BXApMatrices should be BX1 rising sorted!
    if (HU256CELL==4)
        BXApMatrix= [0	0.000;
                    25	20.103;
                    50	40.339;
                    75	60.791;
                    100	81.339;
                    125	101.852;
                    150	122.339;
                    175	142.836;
                    200	163.339;
                    225	183.840;
                    250	204.339;
                    275	224.839];
    elseif (HU256CELL==12)
        BXApMatrix= [0	0.000;
                    25	20.103;
                    50	40.339;
                    75	60.791;
                    100	81.339;
                    125	101.852;
                    150	122.339;
                    175	142.836;
                    200	163.339;
                    225	183.840;
                    250	204.339;
                    275	224.839];
    elseif (HU256CELL==15)
        BXApMatrix= [0	0.000;
                    25	20.103;
                    50	40.339;
                    75	60.791;
                    100	81.339;
                    125	101.852;
                    150	122.339;
                    175	142.836;
                    200	163.339;
                    225	183.840;
                    250	204.339;
                    275	224.839];
    else
        fprintf('Problem in HU256_GetBX2CurrentForAperiodic -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end

    if (size(BX1Current)==[1, 1])   % BX1Current is scalar
        %fprintf('scalaire\n')
    
        if (BX1Current<BXApMatrix(1, 1)||BX1Current>BXApMatrix(size(BXApMatrix, 1), 1))     % BX1Current is outside the limits
            fprintf('Problem in HU256_GetBX2CurrentForAperiodic -> The BX1 current is outside the limits!\n')
        else    % BX1Current is inside the limits
        

            if (SENSEOFCURRENT==-1)
                
                XVector=BXApMatrix(:, 1);
                YVector=BXApMatrix(:, 2);
                BX2Current = interp1(XVector, YVector, BX1Current, 'spline');
                %FitPoly=polyfit(, BXApMatrix(:, 2), 1);
                %BX2Current=polyval(FitPoly, BX1Current);
                
                %[row, col]=find(BXApMatrix==BX1Current);
                %if (length(row)==0||length(col)==0)
                %    fprintf('The current %3.3f is not present in the BX2 Current table\n', BX1Current);
                %elseif (size(row, 1)==1)&&(size(col, 1)==1)&&(col==1)     % Only one element of BXApMatrix corresponds
                %    %fprintf('option1')
                %    BX2Current=BXApMatrix(row, 2);
                %elseif (size(find(col==1), 1)==1)  % Only one element of column1 of BXApMatrix corresponds
                %    %fprintf('option2')
                %    row=row(find(col==1));
                %    BX2Current=BXApMatrix(row, 2);
                %else
                %    fprintf('Not only one current equal to %3.3fA in BX2 Current table!\n', BX1Current);
                %    return
                %end
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
                fprintf('HU256_GetBX2CurrentForAperiodic -> SENSEOFCURRENT = %f but it should be -1 or 1\n', SENSEOFCURRENT)
                return
            end
        end     % end inside/outside the limits for the scalar value
            
    else % vecteur
        %fprintf('vecteur\n')
        if (size(BX1Current, 1)~=1&&size(BX1Current, 2)~=1) % BX1Current is not a scalar neither a vector (but a matrix)
            fprintf('HU256_GetBX2CurrentForAperiodic -> BX1Current has not the rwight size! It should be a vector (1xN or Nx1) but it is %fx%f\n', size(BX1Current, 1), size(BX1Current, 2));
            return
        else
            if (max(BX1Current)>BXApMatrix(length(BXApMatrix))||min(BX1Current)<BXApMatrix(1)) % at least one element of BX1Current is not in BXApMatrix
                fprintf('HU256_GetBX2CurrentForAperiodic -> At least one element of BX1Current is outside the BXApMatrix. It should be between %f and %f.\n', BXApMatrix(1, 1), BXApMatrix(size(BXApMatrix, 1), 1));
                return
            else
                if (SENSEOFCURRENT==-1)
                    XVector=BXApMatrix(:, 1);
                    YVector=BXApMatrix(:, 2);
                    BX2Current = interp1(XVector, YVector, BX1Current, 'spline');
                elseif (SENSEOFCURRENT==1)
                    BX2Current=zeros(size(BX1Current, 1), size(BX1Current, 2));
                else
                    fprintf('HU256_GetBX2CurrentForAperiodic -> SENSEOFCURRENT = %f but it should be -1 or 1\n', SENSEOFCURRENT)
                    return
                end
            end
        end
	end
