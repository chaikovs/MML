function Result=RadiativeEnergy2Params(e, Polarisation, Undulator)
    Result=-1;
    if (strncmp(Undulator, 'HU256', 3))
        Parameters=cell(3, 5); % {Name Coeffs Min Max Component} One line per parameter
        Parameters{1, 1}='BZP';
        Parameters{2, 1}='BX1';
        Parameters{3, 1}='BX2';
        Parameters{1, 3}=-200;
        Parameters{1, 4}=200;
        Parameters{2, 3}=0;
        Parameters{2, 4}=275;
        Parameters{3, 3}=0;
        Parameters{3, 4}=275;
        Parameters{1, 5}='Bz';
        Parameters{2, 5}='Bx';
        Parameters{3, 5}='Bx';
        if (strcmp(Undulator, 'HU256_CASSIOPEE'))
            Parameters{1, 2}=[1/0.0018 -1]; % TO BE CHECKED!
            Parameters{2, 2}=[1/0.0014 -0.0010/0.0014]; % TO BE CHECKED!
            Parameters{3, 2}=[1/0.0014 -0.0010/0.0014]; % TO BE CHECKED!
        elseif (strcmp(Undulator, 'HU256_PLEIADES'))
            Parameters{1, 2}=[1/0.0018 -1]; % TO BE CHECKED!
            Parameters{2, 2}=[1/0.0014 -0.0010/0.0014]; % TO BE CHECKED!
            Parameters{3, 2}=[1/0.0014 -0.0010/0.0014]; % TO BE CHECKED!
        elseif (strcmp(Undulator, 'HU256_ANTARES'))
            Parameters{1, 2}=[1/0.0018 -1]; % TO BE CHECKED!
            Parameters{2, 2}=[1/0.0014 -0.0010/0.0014]; % TO BE CHECKED!
            Parameters{3, 2}=[1/0.0014 -0.0010/0.0014]; % TO BE CHECKED!
        end
    elseif (strncmp(Undulator, 'HU640', 3))
        if (strcmp(Undulator, 'HU640_DESIRS'))
        end
    end
    
    if (strncmp(Undulator, 'HU256', 3))
    elseif (strncmp(Undulator, 'HU640', 3))
    end
    
    if (strncmp(Polarisation, 'L', 1))
        if (strcmp(Polarisation, 'LH'))
            PolarisationNumber=1;
        elseif (strcmp(Polarisation, 'LV'))
            PolarisationNumber=2;
        end
            
    elseif (strncmp(Polarisation, 'C', 1))
        PolarisationNumber=3;
        if (strcmp(Polarisation, 'CR'))
        elseif (strcmp(Polarisation, 'CL'))
        end
    end
    
    if (strncmp(Undulator, 'HU', 2))
        UnderscorePosition=findstr('_', Undulator);
%         fprintf('UnderscorePosition : %1.0f', UnderscorePosition)
        if (isempty(UnderscorePosition)==1||UnderscorePosition<3||size(UnderscorePosition, 1)~=1||size(UnderscorePosition, 2)>1)
           fprintf('%s\n', 'Bad name of undulator')
           return
        end     
        Period=str2double(Undulator(3:UnderscorePosition-1));
        Period=Period/10; % mm -> cm
    else
        fprintf('%s\n', 'Bad name of undulator')
        return
    end
    Output=IDParameters([nan Period nan e]);
    if (Output==-1)
        return
    end
    K=Output(3);
    Output=EfficientK([nan nan K PolarisationNumber]);
    Kx=Output(1);
    Kz=Output(2);
    Bx=K2B(Kx, Period);
    Bz=K2B(Kz, Period);
    N=size(Parameters, 1);
    Result=nan(1, N);
    for i=1:N
        TempName=Parameters{i, 1};
        TempCoefs=Parameters{i, 2};
        TempMin=Parameters{i, 3};
        TempMax=Parameters{i, 4};
        TempComponent=Parameters{i, 5};
        if (strmatch(TempComponent, 'Bx'))
            TempB=Bx;
        elseif (strmatch(TempComponent, 'Bz'))
            TempB=Bz;
        end
        if (TempB==0)
            TempValue=0;
        else
            TempValue=polyval(TempCoefs, TempB);
        end
        if (TempValue<TempMin||TempValue>TempMax)
            fprintf('The required value for %s is %1.3f but it is over range\n', TempName, TempValue);
            Result=-1;
            return
        end
        Result(i)=TempValue;
    end
	return
end

function Result=K2B(K, Lambda_u)
    Result=K/0.934/Lambda_u;
    return
end

function Result=EfficientK(Input)
% Result or Input = [Kx Kz K Polarisation]
% Polarisation is 1 (LH) 2 (LV) or 3 (Circular)
    Result=-1;
    if (size(Input, 1)~=1&&size(Input, 2)~=4)
        fprintf('%s\n', 'Incorrect input')
        return
    end
    TempNans=isnan(Input);
    if (sum(TempNans)~=2)
        fprintf('%s\n', 'Incorrect input')
        return
    end
    if (TempNans(1)~=TempNans(2)||TempNans(3)~=TempNans(4))
        fprintf('%s\n', 'Incorrect input')
        return
    end 
    if (TempNans(1)==TempNans(3))
        fprintf('%s\n', 'Incorrect input')
        return
    end 
    if (TempNans(1)==0) % Kx & Kz -> K & Polarisation
        Kx=Input(1);
        Kz=Input(2);
        if (Kx==0)
            Polarisation=1; % LH
        elseif (Kz==0)
            Polarisation=2; % LV
        elseif (Kx==Kz)
            Polarisation=3; % Circular
        else
            Polarisation=-1; % Undefined
        end
        K=Kx+Kz;
        Result=Input;
        Result(3)=K;
        Result(4)=Polarisation;
        return
    else % K & Polarisation -> Kx & Kz
        if (Input(4)==1) % LH
            Kz=Input(3);
            Kx=0;
        elseif (Input(4)==2) % LV
            Kz=0;
            Kx=Input(3);
        elseif (Input(4)==3) % Circular
            Kz=Input(3)/2;
            Kx=Kz;
        else
            fprintf('%s\n', 'Polarisation must be 1, 2, 3 or 4')
            return
        end
        Result=Input;
        Result(1)=Kx;
        Result(2)=Kz;
        return
    end
end