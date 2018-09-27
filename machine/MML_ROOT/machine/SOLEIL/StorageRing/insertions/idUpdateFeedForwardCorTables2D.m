function [new_tot_mCHE_with_arg, new_tot_mCVE_with_arg, new_tot_mCHS_with_arg, new_tot_mCVS_with_arg] = idUpdateFeedForwardCorTables2D(idName, tabNameDataCHE, tabNameDataCVE, tabNameDataCHS, tabNameDataCVS, vArgVert, vArgHor, updateMode, interpMeth)
%Update FF Correction Tables, with interpolation, if necessary
%tabNameDataCHE = {'parallelModeCHE', mCHE}
%tabNameDataCVE = {'parallelModeCVE', mCVE}
%vArgVert = [15.5,16,18,...] - gap values
%vArgHor = [-40,-35,-30,...] - phase values
%updateMode: 
%   0- set zero in all tables; 1- overwrite values in all tables; 2- add values of new tables to existing tables, keeping the mesh
%   of the existing tables

%res = 0;

numArgVert = length(vArgVert);
numArgHor = length(vArgHor);

testVar = 0;
if(updateMode == 1)
    if((vArgVert ~= -1) && (vArgHor ~= -1))
        testVar = 1;
    end
else
    if((isempty(vArgVert) == 0) && (isempty(vArgHor) == 0))
        testVar = 1;
    end
end

%if((numArgVert > 1) && (numArgHor > 1)) %assume tabNameDataCHE{2} etc. is without arguments
%TO CORRECT!!!: make general§
%if((isempty(vArgVert) == 0) && (isempty(vArgHor) == 0)) %OC,FM1205008      
%if((vArgVert ~= -1) && (vArgHor ~= -1)) %OC,FM1205008
if(testVar ~= 0)
    mCHE_with_arg = idAuxMergeCorTableWithArg2D(vArgVert, vArgHor, tabNameDataCHE{2});
    mCVE_with_arg = idAuxMergeCorTableWithArg2D(vArgVert, vArgHor, tabNameDataCVE{2});
    mCHS_with_arg = idAuxMergeCorTableWithArg2D(vArgVert, vArgHor, tabNameDataCHS{2});
    mCVS_with_arg = idAuxMergeCorTableWithArg2D(vArgVert, vArgHor, tabNameDataCVS{2});
else %assume tabNameDataCHE{2} etc. is with arguments
    mCHE_with_arg = tabNameDataCHE{2};
    mCVE_with_arg = tabNameDataCVE{2};
    mCHS_with_arg = tabNameDataCHS{2};
    mCVS_with_arg = tabNameDataCVS{2};
    
    numArgVert = size(mCHE_with_arg, 1) - 1;
    for i = 1:numArgVert
        vArgVert(i) = mCHE_with_arg(i+1,1);
	end
    numArgHor = size(mCHE_with_arg, 2) - 1;
    for i = 1:numArgHor
        vArgHor(i) = mCHE_with_arg(1,i+1);
	end
end

minValArgVert = vArgVert(1);
maxValArgVert = vArgVert(1);
for i = 1:numArgVert
    curValArg = vArgVert(i);
    if(minValArgVert > curValArg)
        minValArgVert = curValArg;
    end
    if(maxValArgVert < curValArg)
        maxValArgVert = curValArg;
    end
end
minValArgHor = vArgHor(1);
maxValArgHor = vArgHor(1);
for i = 1:numArgHor
    curValArg = vArgHor(i);
    if(minValArgHor > curValArg)
        minValArgHor = curValArg;
    end
    if(maxValArgHor < curValArg)
        maxValArgHor = curValArg;
    end
end

[DServName] = idGetUndDServer(idName);

%Reading previous cor. tables
rep = tango_read_attribute2(DServName, tabNameDataCHE{1});
stOldTablesFF.mCHE_with_arg = rep.value;
rep = tango_read_attribute2(DServName, tabNameDataCVE{1});
stOldTablesFF.mCVE_with_arg = rep.value;
rep = tango_read_attribute2(DServName, tabNameDataCHS{1});
stOldTablesFF.mCHS_with_arg = rep.value;
rep = tango_read_attribute2(DServName, tabNameDataCVS{1});
stOldTablesFF.mCVS_with_arg = rep.value;

new_tot_mCHE_with_arg = stOldTablesFF.mCHE_with_arg;
new_tot_mCVE_with_arg = stOldTablesFF.mCVE_with_arg;
new_tot_mCHS_with_arg = stOldTablesFF.mCHS_with_arg;
new_tot_mCVS_with_arg = stOldTablesFF.mCVS_with_arg;

numArgVert_p_1 = numArgVert + 1;
numArgHor_p_1 = numArgHor + 1;
if(updateMode == 0)
    for i = 2:numArgVert_p_1
        for j = 2:numArgHor_p_1
            mCHE_with_arg(i,j) = 0;
            mCVE_with_arg(i,j) = 0;
            mCHS_with_arg(i,j) = 0;
            mCVS_with_arg(i,j) = 0;
        end
    end
end

if((updateMode == 0) || (updateMode == 1))
    new_tot_mCHE_with_arg = mCHE_with_arg;
    new_tot_mCVE_with_arg = mCVE_with_arg;
    new_tot_mCHS_with_arg = mCHS_with_arg;
    new_tot_mCVS_with_arg = mCVS_with_arg;
end

if(updateMode == 2)
    %strIncompatSizes = 'Incompatible dimensions od mesh of existing and new tables. Incremental update can not be performed.';
    %if((size(stOldTablesFF.mCHE_with_arg, 1) ~= numArgVert_p_1) || (size(stOldTablesFF.mCVE_with_arg, 1) ~= numArgVert_p_1) || (size(stOldTablesFF.mCHS_with_arg, 1) ~= numArgVert_p_1) || (size(stOldTablesFF.mCVS_with_arg, 1) ~= numArgVert_p_1))
    %	fprintf(strIncompatSizes);
    %    return;
    %end
    %if((size(stOldTablesFF.mCHE_with_arg, 2) ~= numArgHor_p_1) || (size(stOldTablesFF.mCVE_with_arg, 2) ~= numArgHor_p_1) || (size(stOldTablesFF.mCHS_with_arg, 2) ~= numArgHor_p_1) || (size(stOldTablesFF.mCVS_with_arg, 2) ~= numArgHor_p_1))
    %	fprintf(strIncompatSizes);
    %    return;
    %end
    
	%for i = 2:numArgVert_p_1
    %    if((mCHE_with_arg(i,1) ~= stOldTablesFF.mCHE_with_arg(i,1)) || (mCVE_with_arg(i,1) ~= stOldTablesFF.mCVE_with_arg(i,1)) || (mCHS_with_arg(i,1) ~= stOldTablesFF.mCHS_with_arg(i,1)) || (mCVS_with_arg(i,1) ~= stOldTablesFF.mCVS_with_arg(i,1)))
    %        fprintf(strIncompatSizes);
    %        return;
    %    end
    %end
	%for j = 2:numArgHor_p_1
    %    if((mCHE_with_arg(1,j) ~= stOldTablesFF.mCHE_with_arg(1,j)) || (mCVE_with_arg(1,j) ~= stOldTablesFF.mCVE_with_arg(1,j)) || (mCHS_with_arg(1,j) ~= stOldTablesFF.mCHS_with_arg(1,j)) || (mCVS_with_arg(1,j) ~= stOldTablesFF.mCVS_with_arg(1,j)))
    %        fprintf(strIncompatSizes);
    %        return;
    %    end
	%end
   
    %Interpolation of New Tables to the Mesh of Existing Tables
    numArgVertExist = size(stOldTablesFF.mCHE_with_arg, 1) - 1;
    argCountVert = 1;
    iVertStart = 1;
    for i = 1:numArgVertExist
        testArg = stOldTablesFF.mCHE_with_arg(i+1,1);
        if((testArg >= minValArgVert) && (testArg <= maxValArgVert))
            vArgVertExist(argCountVert) = testArg;
            if(argCountVert == 1)
                iVertStart = i;
            end
            argCountVert = argCountVert + 1;
        end
    end
    iVertEnd = iVertStart + (argCountVert - 2);
    numArgVert_p_1 = argCountVert;
    
    numArgHorExist = size(stOldTablesFF.mCHE_with_arg, 2) - 1;
    argCountHor = 1;
    iHorStart = 1;
    for i = 1:numArgHorExist
        testArg = stOldTablesFF.mCHE_with_arg(1,i+1);
        if((testArg >= minValArgHor) && (testArg <= maxValArgHor))
            vArgHorExist(argCountHor) = testArg;
            if(argCountHor == 1)
                iHorStart = i;
            end
            argCountHor = argCountHor + 1;
        end
    end
    iHorEnd = iHorStart + (argCountHor - 2);
    numArgHor_p_1 = argCountHor;

    [new_mCHE_with_arg, new_mCVE_with_arg, new_mCHS_with_arg, new_mCVS_with_arg] = idInterpolFeedForwardCorTables2D(mCHE_with_arg, mCVE_with_arg, mCHS_with_arg, mCVS_with_arg, vArgVertExist, vArgHorExist, interpMeth);
    
	%for i = 2:numArgVert_p_1
    %    for j = 2:numArgHor_p_1
    %        new_tot_mCHE_with_arg(i,j) = new_tot_mCHE_with_arg(i,j) + new_mCHE_with_arg(i,j);
    %        new_tot_mCVE_with_arg(i,j) = new_tot_mCVE_with_arg(i,j) + new_mCVE_with_arg(i,j);
    %        new_tot_mCHS_with_arg(i,j) = new_tot_mCHS_with_arg(i,j) + new_mCHS_with_arg(i,j);
    %        new_tot_mCVS_with_arg(i,j) = new_tot_mCVS_with_arg(i,j) + new_mCVS_with_arg(i,j);
    %    end
    %end
	for i = (iVertStart + 1):(iVertEnd + 1)
        iRel = i - iVertStart + 1;
        for j = (iHorStart + 1):(iHorEnd + 1)
            jRel = j - iHorStart + 1;
            new_tot_mCHE_with_arg(i,j) = new_tot_mCHE_with_arg(i,j) + new_mCHE_with_arg(iRel,jRel);
            new_tot_mCVE_with_arg(i,j) = new_tot_mCVE_with_arg(i,j) + new_mCVE_with_arg(iRel,jRel);
            new_tot_mCHS_with_arg(i,j) = new_tot_mCHS_with_arg(i,j) + new_mCHS_with_arg(iRel,jRel);
            new_tot_mCVS_with_arg(i,j) = new_tot_mCVS_with_arg(i,j) + new_mCVS_with_arg(iRel,jRel);
        end
	end

end

%Saving previous FF Tables
fileNameCoreOldFF = 'old_ff_tab';
idSaveStruct(stOldTablesFF, fileNameCoreOldFF, idName, 1, 0);

    %return;

%Updating FF Tables
tango_write_attribute2(DServName, tabNameDataCHE{1}, new_tot_mCHE_with_arg);
tango_write_attribute2(DServName, tabNameDataCVE{1}, new_tot_mCVE_with_arg);
tango_write_attribute2(DServName, tabNameDataCHS{1}, new_tot_mCHS_with_arg);
tango_write_attribute2(DServName, tabNameDataCVS{1}, new_tot_mCVS_with_arg);
