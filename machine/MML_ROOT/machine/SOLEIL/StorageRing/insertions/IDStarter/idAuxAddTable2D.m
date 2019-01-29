function new_m_with_arg = idAuxAddTable2D(m_orig_with_arg, m_add_with_arg)
%Adds content of m_add_with_arg table to m_orig_with_arg, preserving format: 1s column and 1st row of
%each table keep argument values.
%Requires that mesh point of m_add_with_arg coinside with mesh point of m_orig_with_arg

numOrigArg1 = size(m_orig_with_arg, 1) - 1;
numOrigArg2 = size(m_orig_with_arg, 2) - 1;
vOrigArg1 = zeros(numOrigArg1, 1);
vOrigArg2 = zeros(numOrigArg2, 1);
for i = 1:numOrigArg1
	vOrigArg1(i) = m_orig_with_arg(i+1,1);
end
for j = 1:numOrigArg2
	vOrigArg2(j) = m_orig_with_arg(1,j+1);
end

numAddArg1 = size(m_add_with_arg, 1) - 1;
numAddArg2 = size(m_add_with_arg, 2) - 1;
vAddArg1 = zeros(numAddArg1, 1);
vAddArg2 = zeros(numAddArg2, 1);
for i = 1:numAddArg1
	vAddArg1(i) = m_add_with_arg(i+1,1);
end
for j = 1:numAddArg2
	vAddArg2(j) = m_add_with_arg(1,j+1);
end

new_m_with_arg = m_orig_with_arg;

for j = 1:numAddArg2
	valAddArg2 = vAddArg2(j);
    indOrigArg2_p_1 = idAuxFindClosestElemInd(valAddArg2, vOrigArg2) + 1;
    if(indOrigArg2_p_1 <= 1)
        continue;
    end
    for i = 1:numAddArg1
        valAddArg1 = vAddArg1(i);
        indOrigArg1_p_1 = idAuxFindClosestElemInd(valAddArg1, vOrigArg1) + 1;
        if(indOrigArg1_p_1 <= 1)
            continue;
        end
        new_m_with_arg(indOrigArg1_p_1, indOrigArg2_p_1) = new_m_with_arg(indOrigArg1_p_1, indOrigArg2_p_1) + m_add_with_arg(i+1,j+1);
    end
end
