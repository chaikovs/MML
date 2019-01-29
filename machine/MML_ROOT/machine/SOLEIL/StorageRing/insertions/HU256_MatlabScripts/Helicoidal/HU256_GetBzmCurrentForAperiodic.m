function BzmCurrent=HU256_GetBzmCurrentForAperiodic(BZPCurrent, BzmNumber)
%Version Aperiodic


    global SENSEOFCURRENT;
    global HU256CELL;
    
    BzmCurrent=NaN;
    BzmMatrix=HU256_GetBzmCurrentMatrixForAperiodic(HU256CELL);
    if (size(BzmMatrix, 1)==1&&size(BzmMatrix, 2)==1)
        if (BzmMatrix==-1)
            fprintf('Problem in HU256_GetBzmCurrentForAperiodic : HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
            return
        end
    end

    if (SENSEOFCURRENT~=-1&&SENSEOFCURRENT~=1)
        fprintf('Problem in HU256_GetBzmCurrentForAperiodic : SENSEOFCURRENT = %f but it should be -1 or 1 => Bzm%1.0f will be put to 0A\n', SENSEOFCURRENT, BzmNumber);
        %BzmCurrent=0;
    	%fprintf('Bzm%1.0f Current : %3.3fA\n', BzmNumber, BzmCurrent);
        return
    end
        
    if (size(BZPCurrent)==[1, 1])    % BZPCurrent is scalar
    	%fprintf('scalaire\n')        
    	A= BZPCurrent>=BzmMatrix(1, 1)&&BZPCurrent<=BzmMatrix(size(BzmMatrix, 1), 1);   % BZP Current is inside the limits
        B= BZPCurrent>BzmMatrix(size(BzmMatrix, 1), 1);     % BZP Current is outside the limits
    	C= BZPCurrent==BzmMatrix(size(BzmMatrix, 1), 1);     % BZP Current is max current
	
%         if ((A==1&&SENSEOFCURRENT==-1)||(C==1))     % (BZP Current is inside the limits and Current is down) or (Current is max current)
        if (A==1||C==1)     % (BZP Current is inside the limits) or (Current is max current) Modif 04/10/08
        	XVector=BzmMatrix(:, 1);
            YVector=BzmMatrix(:, BzmNumber+1);
            
            BzmCurrent=interp1(XVector, YVector, BZPCurrent,'cubic');
            
            %[row, col]=find(BzmMatrix==BZPCurrent);
            %if (size(row, 1)==1)&&(size(col, 1)==1)&&(col==1)     % Only one element of BZApMatrix corresponds
            %    %fprintf('option1')
            %    BzmCurrent=BzmMatrix(row, BzmNumber+1);
            %elseif (size(find(col==1), 1)==1)  % Only one element of column1 of BzmMatrix corresponds
            %    %fprintf('option2')
            %    row=row(find(col==1));
            %    BzmCurrent=BzmMatrix(row, BzmNumber+1);
            %else
            %    fprintf('Error with "HU256_GetBzmCurrentForAperiodic" : Not only one current equal to %3.3fA in BZP Current table! => Bzm%1.0f will be put to 0A\n', BZPCurrent, BzmNumber);
            %    
            %end
            %fprintf('Bzm%1.0f Current : %3.3fA\n', BzmNumber, BzmCurrent);
            %return
        
        elseif (B==1)   % BZP Current > max current of BzmMatrix
            fprintf('Problem in HU256_GetBzmCurrentForAperiodic :The BZP current (%3.3fA) is outside the limits! => Bzm%1.0f will be put to 0A\n', BZPCurrent, BzmNumber)
            return
        else
            BzmCurrent=0;   % BZP Current is negative or SENSEOFCURRENT = 1
            return
        end
        %fprintf('Bzm%1.0f Current : %3.3fA\n', BzmNumber, BzmCurrent);
    elseif (size(BZPCurrent, 1)==1||size(BZPCurrent, 2)==1) % Vector
        %fprintf('Vecteur\n')
        if (max(BZPCurrent)>BzmMatrix(size(BzmMatrix, 1), 1))  % At least one element of BZPCurrent is outside the BzmMatrix column
            fprintf('Problem in HU256_GetBzmCurrentForAperiodic : at least one element of BZPCurrent is outside the column n°%1.0f."\n', BzmNumber)
            return
        else
            XVector=BzmMatrix(:, 1);
            YVector=BzmMatrix(:, BzmNumber+1);

            for i=1:length(BZPCurrent)
                A= BZPCurrent(i)>=BzmMatrix(1, 1)&&BZPCurrent(i)<=BzmMatrix(size(BzmMatrix, 1), 1);   % The element n°i of BZP Current is inside the limits
                C= BZPCurrent(i)==BzmMatrix(size(BzmMatrix, 1), 1);     % BZP Current n°i is max current
	
                if ((A==1&&SENSEOFCURRENT==-1)||(C==1))     % (BZP Current is inside the limits and Current is down) or (Current is max current)
                    BzmCurrent(i)=interp1(XVector, YVector, BZPCurrent(i),'cubic');
                else    % BZP Current is negative or SENSEOFCURRENT = 1
                    BzmCurrent(i)=0;
                end
            end
        end
    else
        fprintf('Problem in HU256_GetBzmCurrentForAperiodic : BZPCurrent should be a vector (1xN or Nx1) but its dimensions are (%fx%f)\n', size(BZPCurrent, 1), size(BZPCurrent, 2));
    end

    