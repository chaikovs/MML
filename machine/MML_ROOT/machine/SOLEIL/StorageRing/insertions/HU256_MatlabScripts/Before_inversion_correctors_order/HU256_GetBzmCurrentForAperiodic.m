function BzmCurrent=HU256_GetBzmCurrentForAperiodic(BZPCurrent, BzmNumber)
%Version Aperiodic


    global SENSEOFCURRENT;
    global HU256CELL;
    
    BzmCurrent=0;
    
    if (HU256CELL==4)
    %           BZP Bzm1 Bzm2 ..... Bzm8
    BzmMatrix=  [0	0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.000;
                20	0.726	-0.399	-0.628	0.476	0.726	0.476	0.519	-0.586;
                40	1.448	-0.796	-1.253	0.949	1.448	0.949	1.034	-1.168;
                60	2.161	-1.188	-1.870	1.416	2.161	1.416	1.543	-1.743;
                80	2.867	-1.576	-2.481	1.879	2.867	1.879	2.048	-2.313;
                100	3.563	-1.958	-3.084	2.335	3.563	2.335	2.545	-2.874;
                120	4.247	-2.334	-3.676	2.783	4.247	2.783	3.033	-3.426;
                140	4.928	-2.708	-4.265	3.230	4.928	3.230	3.520	-3.976;
                160	5.609	-3.083	-4.855	3.677	5.609	3.677	4.006	-4.525;
                180	6.272	-3.447	-5.429	4.111	6.272	4.111	4.480	-5.060;
                200	6.928	-3.807	-5.996	4.541	6.928	4.541	4.948	-5.589];
            
    elseif (HU256CELL==12)
    %           BZP Bzm1 Bzm2 ..... Bzm8
    BzmMatrix=  [0	0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.000;
                20	0.727	-0.399	-0.629	0.476	0.727	0.476	0.519	-0.586;
                40	1.449	-0.796	-1.254	0.950	1.449	0.950	1.035	-1.169;
                60	2.161	-1.188	-1.871	1.417	2.161	1.417	1.544	-1.744;
                80	2.867	-1.576	-2.482	1.879	2.867	1.879	2.048	-2.313;
                100	3.564	-1.958	-3.084	2.336	3.564	2.336	2.545	-2.875;
                120	4.248	-2.335	-3.677	2.785	4.248	2.785	3.035	-3.427;
                140	4.930	-2.709	-4.267	3.231	4.930	3.231	3.521	-3.977;
                160	5.609	-3.082	-4.855	3.676	5.609	3.676	4.006	-4.525;
                180	6.271	-3.446	-5.428	4.110	6.271	4.110	4.479	-5.059;
                200	6.929	-3.808	-5.998	4.542	6.929	4.542	4.949	-5.590];
        
    elseif (HU256CELL==15)
    %           BZP Bzm1 Bzm2 ..... Bzm8
    BzmMatrix=  [0	0.000	0.000	0.000	0.000	0.000	0.000	0.000	0.000;
                20	0.745	-0.409	-0.644	0.488	0.745	0.488	0.532	-0.601;
                40	1.458	-0.801	-1.262	0.955	1.458	0.955	1.041	-1.176;
                60	2.163	-1.189	-1.872	1.418	2.163	1.418	1.545	-1.745;
                80	2.872	-1.578	-2.485	1.882	2.872	1.882	2.051	-2.317;
                100	3.571	-1.963	-3.091	2.341	3.571	2.341	2.551	-2.881;
                120	4.256	-2.339	-3.684	2.790	4.256	2.790	3.040	-3.434;
                140	4.937	-2.713	-4.273	3.236	4.937	3.236	3.526	-3.982;
                160	5.615	-3.086	-4.860	3.681	5.615	3.681	4.011	-4.530;
                180	6.276	-3.449	-5.432	4.114	6.276	4.114	4.483	-5.063;
                200	6.932	-3.810	-6.000	4.543	6.932	4.543	4.951	-5.592];        

    else
        fprintf('Problem in HU256_GetBzmCurrentForAperiodic -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end
    
    A= BZPCurrent>=BzmMatrix(1, 1)&&BZPCurrent<=BzmMatrix(size(BzmMatrix, 1), 1);   % BZP Current is inside the limits
    B= BZPCurrent<BzmMatrix(1, 1)||BZPCurrent>BzmMatrix(size(BzmMatrix, 1), 1);     % BZP Current is outside the limits
    C= BZPCurrent==BzmMatrix(size(BzmMatrix, 1), 1);     % BZP Current is max current
    D= SENSEOFCURRENT==-1;
    E= SENSEOFCURRENT==1;

    if (D==0&&E==0);
        fprintf('Error with "HU256_GetBzmCurrentForAperiodic" : SENSEOFCURRENT = %f but it should be -1 or 1 => Bzm%1.0f will be put to 0A\n', SENSEOFCURRENT, BzmNumber);
        BzmCurrent=0;
        fprintf('Bzm%1.0f Current : %3.3fA\n', BzmNumber, BzmCurrent);
        return
    end
        
    if ((A==1&&D==1)||(C==1))     % (BZP Current is inside the limits and Current is down) or (Current is max current)
        [row, col]=find(BzmMatrix==BZPCurrent);
            
        if (size(row, 1)==1)&&(size(col, 1)==1)&&(col==1)     % Only one element of BZApMatrix corresponds
            %fprintf('option1')
            BzmCurrent=BzmMatrix(row, BzmNumber+1);
        elseif (size(find(col==1), 1)==1)  % Only one element of column1 of BzmMatrix corresponds
            %fprintf('option2')
            row=row(find(col==1));
            BzmCurrent=BzmMatrix(row, BzmNumber+1);
        else
            fprintf('Error with "HU256_GetBzmCurrentForAperiodic" : Not only one current equal to %3.3fA in BZP Current table! => Bzm%1.0f will be put to 0A\n', BZPCurrent, BzmNumber);
            
        end
        fprintf('Bzm%1.0f Current : %3.3fA\n', BzmNumber, BzmCurrent);
        return
        
    elseif (B==1)
        fprintf('Error with "HU256_GetBzmCurrentForAperiodic" : The BZP current (%3.3fA) is outside the limits! => Bzm%f.0f will be put to 0A\n', BZPCurrent, BzmNumber)
        BzmCurrent=0;
    else
        BzmCurrent=0;
    end
    fprintf('Bzm%1.0f Current : %3.3fA\n', BzmNumber, BzmCurrent);
    