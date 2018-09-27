function Output=HU256_Tab_InterpolScriptMatrix(Matrix, NewMainCurrents)
    Output=-1;
    OldMainCurrents=Matrix(:, 1);
    if (min(OldMainCurrents)~=min(NewMainCurrents)||max(OldMainCurrents)~=max(NewMainCurrents))
        fprintf('HU256_Tab_InterpolScriptMatrix : wrong input\n')
        return
    end
    NumberOfColumns=size(Matrix, 2);
    Output=zeros(size(NewMainCurrents, 1), NumberOfColumns);
    Output(:, 1)=NewMainCurrents;
    for i=2:NumberOfColumns
        OldVector=Matrix(:, i);
        NewVector=Interp1(OldMainCurrents, OldVector, NewMainCurrents);
        Output(:, i)=NewVector;
    end
    return
        
        