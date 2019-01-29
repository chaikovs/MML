function res=HU256_Vector2string(InputVector)
    N=length(InputVector);
    res='[';
    for i=1:N
        if (i~=1)
            res=[res ', ' num2str(InputVector(i))];
        else
            res=[res num2str(InputVector(i))];
        end
    end
    res=[res ']'];