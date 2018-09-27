function Result=IDParameters(Input)
% Result or Input = [B(T) Lambda_und(cm) K RadiationEnergy(KeV)]
% K is efficient K, i.e. Kx + Kz
    Result=-1;
    TempSize=size(Input);
    if (TempSize(1)~=1||TempSize(2)~=4)
        fprintf('%s\n', 'Input incorrect')
        return
    end
    TempNan=isnan(Input);
    if (sum(TempNan)~=2)
        fprintf('%s\n', 'Input incorrect : not only 2 values')
        return
    end
    if (TempNan(2)==1) % Lambda_und is not in Input
        if (TempNan(1)==1) % K & E
            Result=Input;
            TempLambda=Lambda_u(Input(4), Input(3), 2);
            TempB=B(Input(3), TempLambda);
            Result(1)=TempB;
            Result(2)=TempLambda;
            return
        elseif (TempNan(3)==1) % B & E
            Result=Input;
            TempLambda=Lambda_u(Input(1), Input(4), 3);
            TempK=K(Input(1), TempLambda, 1);
            Result(2)=TempLambda;
            Result(3)=TempK;
            return 
        elseif (TempNan(4)==1) % B & K
            Result=Input;
            TempLambda=Lambda_u(Input(1), Input(3), 1);
            Tempe=RadiationEnergy(Input(3), TempLambda, 1);
            Result(2)=TempLambda;
            Result(4)=Tempe;
            return
        end
    else % Lambda_und is in Input
        if (TempNan(1)==0) % B & Lambda_und
            Result=Input;
            TempK=K(Input(1), Input(2), 1);
            Tempe=RadiationEnergy(Input(1), Input(2), 2);
            Result(3)=TempK;
            Result(4)=Tempe;
            return
        elseif (TempNan(3)==0) % Lambda_und & K
            Result=Input;
            TempB=B(Input(3), Input(2));
            Tempe=RadiationEnergy(Input(3), Input(2), 1);
            Result(1)=TempB;
            Result(4)=Tempe;
            return
        elseif (TempNan(4)==0) % Lambda_und & e
            Result=Input;
            TempK=K(Input(4), Input(2), 2);
            if (TempK==-1)
                Result=-1;
                return
            end
            TempB=B(TempK, Input(2));
            Result(1)=TempB;
            Result(3)=TempK;
            return
        end
    end
    disp(TempNan)
end
% function Result=IDParameters(Value1, Value2, Value1Type, Value2Type)
%     Result=-1;
%     if (ischar(ValueType)~=1||ischar(Value2Type~=1))
%         return
%     end
%     if (strmatch(Value1Type, 'B')==0&&strmatch(Value1Type, 'Period')==0&&strmatch(Value1Type, 'K')==0&&strmatch(Value1Type, 'e')==0)
%         fprintf ('%s\n', 'Value1Type must be ''B'', ''Period'', ''K'' or ''e''')
%         return
%     end
%     if (strmatch(Value2Type, 'B')==0&&strmatch(Value2Type, 'Period')==0&&strmatch(Value2Type, 'K')==0&&strmatch(Value2Type, 'e')==0)
%         fprintf ('%s\n', 'Value2Type must be ''B'', ''Period'', ''K'' or ''e''')
%         return
%     end
%     if (strmatch(Value1Type, 'Period')||strmatch(Value2Type, 'Period'))
%         
%     else
%     end

function Result=B(K, Lambda_u)
    Result=K/0.934/Lambda_u;
    return
end

function Result=K(Val1, Val2, Method)
% Method = 1 => Val1=B & Val2=Lambda_u
% Method = 2 => Val1=RadiationEnergy & Val2=Lambda_u
    if (Method==1)
        Result=0.934*Val1*Val2;
        return
    elseif (Method==2)
        Result=sqrt(2*((2.75^2*0.95)/(Val1*Val2)-1));
        if (imag(Result)~=0)
            Result=-1;
        end
        return
    end
end

function Result=Lambda_u(Val1, Val2, Method)
% Method=1 => Val1=B & Val2=K
% Method=2 => Val1=e & Val2=K
% Method=3 => Val1=B & Val2=e
    if (Method==1)
        Result=Val2/0.934/Val1;
        return
    elseif (Method==2)
        Result=0.95*2.75^2/Val1/(1+Val2^2/2);
        return
    elseif (Method==3)
        TempPoly=[0.934^2*Val1^2/2 0 1 -0.95*2.75^2/Val2];
        TempRoots=roots(TempPoly);
        TempPosition=find(imag(TempRoots)==0);
        if (size(TempPosition, 1)~=1&&size(TempPosition, 2)~=1)
            Result=-1;
        end
        Result=TempRoots(TempPosition);
        return
    end
end

function Result=RadiationEnergy(Val1, Val2, Method)
%  Method=1 => Val1=K & Val2=Lambda_u
%  Method=2 => Val1=B & Val2=Lambda_u
    if (Method==1)
        Result=0.95*2.75^2/Val2/(1+Val1^2/2);
        return
    elseif (Method==2)
        TempK=K(Val1, Val2, 1);
        Result=RadiationEnergy(TempK, Val2, 1);
        return
    end
end

