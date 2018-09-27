function BzmCurrent=HU256_GetBzmCurrentForAperiodic(BZPCurrent, BzmNumber)
%Version Aperiodic

    BzmCurrent=-1;
    global SENSEOFCURRENT;
    
    
   %           BZP Bzm1 Bzm2 ..... Bzm8
    BzmMatrix=  [0	0	0	0	0	0	0	0	0;
                20	0.74	-0.41	-0.64	0.49	0.74	0.49	0.53	-0.6;
                40	1.46	-0.8	-1.26	0.95	1.46	0.95	1.04	-1.17;
                60	2.16	-1.19	-1.87	1.42	2.16	1.42	1.55	-1.75;
                80	2.87	-1.58	-2.49	1.88	2.87	1.88	2.05	-2.32;
                100	3.57	-1.96	-3.09	2.34	3.57	2.34	2.55	-2.88;
                120	4.26	-2.34	-3.69	2.79	4.26	2.79	3.04	-3.43;
                140	4.94	-2.71	-4.27	3.23	4.94	3.23	3.53	-3.98;
                160	5.61	-3.08	-4.85	3.68	5.61	3.68	4.01	-4.52;
                180	6.28	-3.45	-5.43	4.11	6.28	4.11	4.48	-5.06;
                200	6.93	-3.81	-6	4.54	6.93	4.54	4.95	-5.59];

            
 
    if (BZPCurrent<BzmMatrix(1, 1)||BZPCurrent>BzmMatrix(size(BzmMatrix, 1), 1))     %BX1Current is outside the limits
        fprintf('The BZP current is outside the limits!\n')
    else
        if (SENSEOFCURRENT==-1)
            [row, col]=find(BzmMatrix==BZPCurrent);
            
            if (size(row, 1)==1)&&(size(col, 1)==1)&&(col==1)     % Only one element of BXApMatrix corresponds
                %fprintf('option1')
                BzmCurrent=BzmMatrix(row, BzmNumber+1);
            elseif (size(find(col==1), 1)==1)  % Only one element of column1 of BzmMatrix corresponds
                %fprintf('option2')
                row=row(find(col==1));
                BzmCurrent=BzmMatrix(row, BzmNumber+1);
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
            BzmCurrent=0;
        else
            fprintf('SENSEOFCURRENT = %f but it should be -1 or 1', SENSEOFCURRENT)
            return
    end

end