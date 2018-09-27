function [CVE, CHE, CVS, CHS]=AnalogInterpolateCurrent(FFWDTable, PowerSupplies, MainPsCurrent, CycleType, UpOrDown)

%% Description
% FFWDTable : array containing Currents (such as tables)
% PowerSupplies : cell containing names of power supplies (in order or rows in table)
% Current : current to perform the interpolation
% CycleType : 'BX' for unipolar ps or 'BZ' for bipolar one
% UpOrDown : -1 or 1 (not zero!)
CVE=nan;
CHE=nan;
CVS=nan;
CHS=nan;

if strcmp(CycleType, 'BX')
     MainPs='BX1';
%% Constructing matrix with sorted BX currents
         for j=1:size(PowerSupplies, 1)  %CVE, CHE, etc...
            TempName=PowerSupplies{j};
            if (strncmp(TempName, MainPs, 3))
                BX1_Vect(1, :)=FFWDTable(j, :);
            end
        end
        
        imax=find(BX1_Vect==max(BX1_Vect));
        if UpOrDown==1
            TempFFWDTable(:, :)=FFWDTable(:, 1:imax);
        else
            TempFFWDTable(:, :)=FFWDTable(:, imax:size(FFWDTable, 2));
            TempFFWDTable=fliplr(TempFFWDTable);
        end
        
elseif strcmp(CycleType, 'BZ')
     MainPs='BZP';
     %% Constructing matrix with sorted BZP currents
        for j=1:size(PowerSupplies, 1)  %CVE, CHE, etc...
            TempName=PowerSupplies{j};
            if (strncmp(TempName, MainPs, 3))
                BZP_Vect(1, :)=FFWDTable(j, :);
            end
        end

        imin=find(BZP_Vect==min(BZP_Vect));
        imax=find(BZP_Vect==max(BZP_Vect));
        if UpOrDown==1
            TempFFWDTable(:, :)=FFWDTable(:, imin:imax);
        else
            TempFFWDTable1(:, :)=FFWDTable(:, 1:imin);
            TempFFWDTable2(:, :)=FFWDTable(:, imax:size(FFWDTable, 2));
            TempFFWDTable(:, :)=[TempFFWDTable2(:, :) TempFFWDTable1(:, :)];
            TempFFWDTable=fliplr(TempFFWDTable);
        end
end

 %% Interpoling obtained table between currents
        
    for j=1:size(PowerSupplies, 1)  %CVE, CHE, etc...
        TempName=PowerSupplies{j};
        if (strncmp(TempName, MainPs, 3))
            MainPsCurrents(1, :)=TempFFWDTable(j, :);
        end
    end

    FFWDVector=zeros(size(TempFFWDTable, 1), 1);
    if MainPsCurrent==max(MainPsCurrents)
        FFWDVector=TempFFWDTable(:, size(TempFFWDTable, 2));
    elseif MainPsCurrent==min(MainPsCurrents)
        FFWDVector=TempFFWDTable(:, 1);
    else
        i=1;
        Condition=0;
        while(~Condition)
            MainPsCurrent1=MainPsCurrents(i);
            MainPsCurrent2=MainPsCurrents(i+1);
            Condition=(MainPsCurrent1<=MainPsCurrent&&MainPsCurrent<MainPsCurrent2)||i>length(MainPsCurrents);
            if ~Condition
                i=i+1;
            end
        end
        FFWDVector1=TempFFWDTable(:, i);
        FFWDVector2=TempFFWDTable(:, i+1);

        for i=1:length(FFWDVector1)
            FFWDVector(i)=interp1([MainPsCurrent1 MainPsCurrent2], [FFWDVector1(i) FFWDVector2(i)], MainPsCurrent);
        end
    end

    for j=1:size(PowerSupplies, 1)  %CVE, CHE, etc...
        TempName=PowerSupplies{j};
        if (strncmp(TempName, MainPs, 3))
            MainPs=FFWDVector(j);
        elseif (strncmp(TempName, 'CVE', 3))
            CVE=FFWDVector(j);
        elseif (strncmp(TempName, 'CHE', 3))
            CHE=FFWDVector(j);
        elseif (strncmp(TempName, 'CVS', 3))
            CVS=FFWDVector(j);
        elseif (strncmp(TempName, 'CHS', 3))
            CHS=FFWDVector(j);
        end
    end