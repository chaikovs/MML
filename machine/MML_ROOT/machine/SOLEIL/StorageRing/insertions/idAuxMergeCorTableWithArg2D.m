function mRes = idAuxMergeCorTableWithArg2D(vArg1, vArg2, mCor)
mRes=[];

sizeArg1 = size(mCor, 1);
sizeArg2 = size(mCor, 2);

lenArg1 = length(vArg1);
lenArg2 = length(vArg2);


if sizeArg2 ~= lenArg2
    fprintf('Inconsistent lengths of the matrix and the argument vectors\n');
    return
end

if ~isempty(vArg1)  % 2D table for APPLE-II (1st column for phase values, 1st row for gap values)

    if sizeArg1 ~= lenArg1
        fprintf('Inconsistent lengths of the matrix and the argument vectors\n');
        return
    end

    mRes = zeros(sizeArg1 + 1, sizeArg2 + 1);
    mRes(1, 1) = 0;
    for i = 1:lenArg1
        mRes(i + 1, 1) = vArg1(i);
    end

    for j = 1:lenArg2
        mRes(1, j + 1) = vArg2(j);
        for i = 1:lenArg1
            mRes(i + 1, j + 1) = mCor(i, j);
        end
    end
    
else    % 1D table for in-vacuum (only top row is added)
    mRes = zeros(sizeArg1 + 1, sizeArg2);
    for j = 1:sizeArg2
        mRes(1, j) = vArg2(j);
        for i = 1:sizeArg1
            mRes(i + 1, j) = mCor(i, j);
        end
    end
end