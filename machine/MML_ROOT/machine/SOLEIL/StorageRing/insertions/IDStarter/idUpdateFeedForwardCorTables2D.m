function res = idUpdateFeedForwardCorTables2D(idName, tabNameDataCHE, tabNameDataCVE, tabNameDataCHS, tabNameDataCVS, vArgVert, vArgHor, updateMode)
%tabNameDataCHE = {'parallelModeCHE', mCHE}
%tabNameDataCVE = {'parallelModeCVE', mCVE}
%vArgVert = [15.5,16,18,...] - gap values
%vArgHor = [-40,-35,-30,...] - phase values
%updateMode: 
%   0- set zero in all tables; 1- overwrite values in all tables; 2- add
%   new tables to existing tables

res = 0;

if((length(vArgVert) > 1) && (length(vArgVert) > 1)) %assume tabNameDataCHE{2} etc. is without arguments
    mCHE_with_arg = idAuxMergeCorTableWithArg2D(vArgVert, vArgHor, tabNameDataCHE{2});
    mCVE_with_arg = idAuxMergeCorTableWithArg2D(vArgVert, vArgHor, tabNameDataCVE{2});
    mCHS_with_arg = idAuxMergeCorTableWithArg2D(vArgVert, vArgHor, tabNameDataCHS{2});
    mCVS_with_arg = idAuxMergeCorTableWithArg2D(vArgVert, vArgHor, tabNameDataCVS{2});
else %assume tabNameDataCHE{2} etc. is with arguments
    mCHE_with_arg = tabNameDataCHE{2};
    mCVE_with_arg = tabNameDataCVE{2};
    mCHS_with_arg = tabNameDataCHS{2};
    mCVS_with_arg = tabNameDataCVS{2};
end

[DServName, StandByStr] = idGetUndDServer(idName);

%Reading previous cor. tables
rep = tango_read_attribute2(DServName, tabNameDataCHE{1});
stOldTablesFF.mCHE_with_arg = rep.value;
rep = tango_read_attribute2(DServName, tabNameDataCVE{1});
stOldTablesFF.mCVE_with_arg = rep.value;
rep = tango_read_attribute2(DServName, tabNameDataCHS{1});
stOldTablesFF.mCHS_with_arg = rep.value;
rep = tango_read_attribute2(DServName, tabNameDataCVS{1});
stOldTablesFF.mCVS_with_arg = rep.value;

numArgVert = length(vArgVert);
numArgHor = length(vArgHor);
numArgVert_p_1 = numArgVert;
numArgHor_p_1 = numArgHor;
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

if(updateMode == 2)
    strIncompatSizes = 'Incompatible dimensions od mesh of existing and new tables. Incremental update can not be performed.';
    if((size(stOldTablesFF.mCHE_with_arg, 1) ~= numArgVert_p_1) || (size(stOldTablesFF.mCVE_with_arg, 1) ~= numArgVert_p_1) || (size(stOldTablesFF.mCHS_with_arg, 1) ~= numArgVert_p_1) || (size(stOldTablesFF.mCVS_with_arg, 1) ~= numArgVert_p_1))
    	fprintf(strIncompatSizes);
        return;
    end
    if((size(stOldTablesFF.mCHE_with_arg, 2) ~= numArgHor_p_1) || (size(stOldTablesFF.mCVE_with_arg, 2) ~= numArgHor_p_1) || (size(stOldTablesFF.mCHS_with_arg, 2) ~= numArgHor_p_1) || (size(stOldTablesFF.mCVS_with_arg, 2) ~= numArgHor_p_1))
    	fprintf(strIncompatSizes);
        return;
    end
    
	for i = 2:numArgVert_p_1
        if((mCHE_with_arg(i,1) ~= stOldTablesFF.mCHE_with_arg(i,1)) || (mCVE_with_arg(i,1) ~= stOldTablesFF.mCVE_with_arg(i,1)) || (mCHS_with_arg(i,1) ~= stOldTablesFF.mCHS_with_arg(i,1)) || (mCVS_with_arg(i,1) ~= stOldTablesFF.mCVS_with_arg(i,1)))
            fprintf(strIncompatSizes);
            return;
        end
    end
	for j = 2:numArgHor_p_1
        if((mCHE_with_arg(1,j) ~= stOldTablesFF.mCHE_with_arg(1,j)) || (mCVE_with_arg(1,j) ~= stOldTablesFF.mCVE_with_arg(1,j)) || (mCHS_with_arg(1,j) ~= stOldTablesFF.mCHS_with_arg(1,j)) || (mCVS_with_arg(1,j) ~= stOldTablesFF.mCVS_with_arg(1,j)))
            fprintf(strIncompatSizes);
            return;
        end
	end
    for i = 2:numArgVert_p_1
        for j = 2:numArgHor_p_1
            mCHE_with_arg(i,j) = mCHE_with_arg(i,j) + stOldTablesFF.mCHE_with_arg(i,j);
            mCVE_with_arg(i,j) = mCVE_with_arg(i,j) + stOldTablesFF.mCVE_with_arg(i,j);
            mCHS_with_arg(i,j) = mCHS_with_arg(i,j) + stOldTablesFF.mCHS_with_arg(i,j);
            mCVS_with_arg(i,j) = mCVS_with_arg(i,j) + stOldTablesFF.mCVS_with_arg(i,j);
        end
    end
end

%saving previous ff tables
fileNameCoreOldFF = 'old_ff_tab';
idSaveStruct(fileNameCoreOldFF, stOldTablesFF, idName, 0);

tango_write_attribute2(DServName, tabNameDataCHE{1}, mCHE_with_arg);
tango_write_attribute2(DServName, tabNameDataCVE{1}, mCVE_with_arg);
tango_write_attribute2(DServName, tabNameDataCHS{1}, mCHS_with_arg);
tango_write_attribute2(DServName, tabNameDataCVS{1}, mCVS_with_arg);
