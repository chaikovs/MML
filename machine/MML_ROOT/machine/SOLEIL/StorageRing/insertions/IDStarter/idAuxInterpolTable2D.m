function new_m_with_arg = idAuxInterpolTable2D(m_with_arg, vNewArg1, vNewArg2, interpMeth)
%Interpolates 2D table (matrix), preserving format: 1s column and 1st row of
%the matrix m_with_arg keep the argument values
%vNewArg1, vNewArg2 are the new arguments, in the format, e.g.:
%   vNewArg1 = [15.5,16,17,18,19,20,22.5, ...]; 
%   vNewArg2 = [-40,-37.5,-35,-32.5,-30, ...]

numOldArg1 = size(m_with_arg, 1) - 1;
numOldArg2 = size(m_with_arg, 2) - 1;

vOldArg1 = zeros(numOldArg1, 1);
vOldArg2 = zeros(numOldArg2, 1);
mOld = zeros(numOldArg1, numOldArg2);
for i = 1:numOldArg1
	vOldArg1(i) = m_with_arg(i+1,1);
end
for j = 1:numOldArg2
	vOldArg2(j) = m_with_arg(1,j+1);
    for i = 1:numOldArg1
        mOld(i,j) = m_with_arg(i+1,j+1);
    end
end
%mNew = interp2(vOldArg1, vOldArg2, mOld, vNewArg1', vNewArg2', interpMeth);
%mNew = interp2(vOldArg1, vOldArg2', mOld, vNewArg1', vNewArg2, interpMeth);
if((size(vNewArg2, 1) > 1) && (size(vNewArg2, 2) == 1))
	vNewArg2 = vNewArg2';
end
if((size(vNewArg1, 1) > 1) && (size(vNewArg1, 2) == 1))
	vNewArg1 = vNewArg1';
end
mNew = interp2(vOldArg2', vOldArg1, mOld, vNewArg2, vNewArg1', interpMeth);

numNewArg1 = length(vNewArg1);
numNewArg2 = length(vNewArg2);
new_m_with_arg = zeros(numNewArg1 + 1, numNewArg2 + 1);
new_m_with_arg(1,1) = 0;
for i = 1:numNewArg1
    new_m_with_arg(i+1,1) = vNewArg1(i);
end
for j = 1:numNewArg2
    new_m_with_arg(1,j+1) = vNewArg2(j);
    for i = 1:numNewArg1
        new_m_with_arg(i+1,j+1) = mNew(i,j);
    end
end

