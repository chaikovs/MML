
function OutputMatrix=HU256_UpdateCorrMatrixFromCorrCurrents(InputMatrix, CorrCurrentsVector, PowerSupplyName)
%   Complete one row (or half of one row) of InputMatrix by the correction currents values
%   Knows which type of table to complete using the number of columns in InputMatrix
%   Knows which column (of a 9 columns table) to complete using the global variable SENSEOFCURRENT
%   Knows which row to complete using the global variables Sense/Present currents for Bz or Bx currents.
%   Returns -1 if not finished correctly

    global APERIODIC
    global LISTOFCURRENTS
    global PRESENTCURRENT
    global SENSEOFCURRENT
    global BXLISTOFCURRENTSFORHEL
    global BXPRESENTCURRENTFORHEL
%     global PowerSupplyName
%     global BXSENSEOFCURRENTFORHEL;
    
%     disp InputMatrix

    OutputMatrix=-1;
    TempMatrix=InputMatrix;
%     if (isa (APERIODIC, 'numeric')==1)
%         ListOfCurrents=LISTOFCURRENTS
%         PresentCurrent=PRESENTCURRENT
%     else
    if (strcmp(PowerSupplyName, 'bz')==1||isa(APERIODIC, 'numeric')==1)
        ListOfCurrents=LISTOFCURRENTS;
        PresentCurrent=PRESENTCURRENT;
    elseif (strcmp(PowerSupplyName, 'bx')==1)
        ListOfCurrents=BXLISTOFCURRENTSFORHEL;
        PresentCurrent=BXPRESENTCURRENTFORHEL;
    else
        fprintf('Problem in HU256_UpdateCorrMatrixFromCorrCurrents : PowerSupplyName must be ''bz'' or ''bx''\n')
        return
    end

    i=find(ListOfCurrents==PresentCurrent); % i = n° de ligne de la table
    if (isempty(i)==1)
        fprintf('Problem in HU256_UpdateCorrMatrixFromCorrCurrents : The PresentCurrent was not found in the ListOfCurrents!\n')
        return
    end
    if (size(InputMatrix, 2)==9)
        % j= j1+j2  % j = n° de colonne de la table
        if (SENSEOFCURRENT==1)
            j2=1;
            j3=0;
        else
            j2=0;
            j3=1;
        end
        for j1=1:1:4
            j=2*j1+j2;
            jElse=2*j1+j3;
            TempMatrix (i, j)=CorrCurrentsVector(j1);
            if (i==1||i==length(LISTOFCURRENTS))
                TempMatrix(i, jElse)=CorrCurrentsVector(j1);
            end
        end
    elseif (size(InputMatrix, 2)==5)
        for j=1:1:4     % j = n° de colonne de la table
            TempMatrix(i, j+1)=CorrCurrentsVector(j);
        end
    else
        fprintf('Problem in HU256_UpdateCorrMatrixFromCorrCurrents : The InputMatrix has %f columns but it should have 5 or 9 columns\n', size(InputMatrix, 2))
        return
    end
    OutputMatrix=TempMatrix;
%     disp OutputMatrix

