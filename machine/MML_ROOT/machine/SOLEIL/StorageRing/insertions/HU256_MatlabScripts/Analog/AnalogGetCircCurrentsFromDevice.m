function [CVE, CHE, CVS, CHS]=AnalogGetCircCurrentsFromDevice(HU256Cell, BXCurrent, BZPCurrent, UpOrDown)
    
    CVE=nan;
    CHE=nan;
    CVS=nan;
    CHS=nan;
    
    %% Interpoling BX tables
    
    BXCurrents=Analog_GetBXCurrentsInCircTablesFromDevice(HU256Cell);
    if BXCurrent==max(BXCurrents)
        [FFWDTable, PowerSupplies]=AnalogGetFFWDTableFromDevice(HU256Cell, num2str(BXCurrent));
        NumberOfCurrents=size(FFWDTable, 2);
    else
    
        i=1;
        Condition=0;
        while(~Condition)
            BXCurrent1=BXCurrents(i);
            BXCurrent2=BXCurrents(i+1);
            Condition=(BXCurrent1<=BXCurrent&&BXCurrent<BXCurrent2)||i>=length(BXCurrents);
            if ~Condition
                i=i+1;
            end
        end
        [FFWDTable1, PowerSupplies]=AnalogGetFFWDTableFromDevice(HU256Cell, num2str(BXCurrent1));
        [FFWDTable2, ~]=AnalogGetFFWDTableFromDevice(HU256Cell, num2str(BXCurrent2));
        FFWDTable=zeros(size(FFWDTable1));
        
        NumberOfCurrents=size(FFWDTable1, 2);
        if NumberOfCurrents~=size(FFWDTable2, 2)
            fprintf ('Problem with tables\n')
            return
        end
        
        for i=1:size(FFWDTable, 1)
            for j=1:NumberOfCurrents
                FFWDTable(i, j)=interp1([BXCurrent1 BXCurrent2], [FFWDTable1(i, j) FFWDTable2(i, j)], BXCurrent);
            end
        end
    end
    
    %% Constructing matrix with BZP currents sorted
    for j=1:size(PowerSupplies, 1)  %CVE, CHE, etc...
        TempName=PowerSupplies{j};
        if (strncmp(TempName, 'BZP', 3))
            BZP_Vect(1, :)=FFWDTable(j, :);
        end
    end

    imin=find(BZP_Vect==min(BZP_Vect));
    imax=find(BZP_Vect==max(BZP_Vect));
    if UpOrDown==1
        TempFFWDTable(:, :)=FFWDTable(:, imin:imax);
    else
        TempFFWDTable1(:, :)=FFWDTable(:, 1:imin);
        TempFFWDTable2(:, :)=FFWDTable(:, imax:NumberOfCurrents);
        TempFFWDTable(:, :)=[TempFFWDTable2(:, :) TempFFWDTable1(:, :)];
        TempFFWDTable=fliplr(TempFFWDTable);
    end
    
    %% Interpoling obtained table between BZP currents
    for j=1:size(PowerSupplies, 1)  %CVE, CHE, etc...
        TempName=PowerSupplies{j};
        if (strncmp(TempName, 'BZP', 3))
            BZPCurrents(1, :)=TempFFWDTable(j, :);
        end
    end
    
    FFWDVector=zeros(size(TempFFWDTable, 1), 1);
    if BZPCurrent==max(BZPCurrents)
        FFWDVector=TempFFWDTable(:, size(TempFFWDTable, 2));

    else
    
        i=1;
        Condition=0;
        while(~Condition)
            BZPCurrent1=BZPCurrents(i);
            BZPCurrent2=BZPCurrents(i+1);
            Condition=(BZPCurrent1<=BZPCurrent&&BZPCurrent<BZPCurrent2)||i>length(BZPCurrents);
            if ~Condition
                i=i+1;
            end
        end
        FFWDVector1=TempFFWDTable(:, i);
        FFWDVector2=TempFFWDTable(:, i+1);
                
        for i=1:length(FFWDVector1)
            FFWDVector(i)=interp1([BZPCurrent1 BZPCurrent2], [FFWDVector1(i) FFWDVector2(i)], BZPCurrent);
        end
    end
                 
    for j=1:size(PowerSupplies, 1)  %CVE, CHE, etc...
        TempName=PowerSupplies{j};
        if (strncmp(TempName, 'BZP', 3))
            BZP=FFWDVector(j);
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
end