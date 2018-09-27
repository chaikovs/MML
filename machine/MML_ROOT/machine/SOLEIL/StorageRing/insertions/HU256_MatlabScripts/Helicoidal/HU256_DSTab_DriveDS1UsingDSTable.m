function Result=HU256_DSTab_DriveDS1UsingDSTable(HU256Cell, DSTableFullPath, StepPauseInSeconds)
    Result=-1;
    
    Debug=0;
    
    ProfibusDSCoreName='ANS-C%02d/EI/DP.%1d';
    switch (HU256Cell)
        case {4, 12, 15}
            ProfibusDSName=sprintf(ProfibusDSCoreName, HU256Cell, 2);
        otherwise
             fprintf('HU256_DSTab_DriveDS1UsingDSTable : HU256Cell must be 4, 12 or 15\n');
        return
    end
            
    TableStructure = HU256_DSTab_ReadDSTable(DSTableFullPath);
    if (isempty(fieldnames(TableStructure))==1)
        fprintf('HU256_DSTab_DriveDS1UsingDSTable : wrong table file\n');
        return
    end
    
    CellOfCurrents=TableStructure.PowerSupplies;
    TableArray=TableStructure.Table;
    NumberOfCurrents=size(TableArray, 1);
    NumberOfPoints=size(TableArray, 2);
    
    NamesOfDS1=cell(NumberOfCurrents, 1);
    for CurrentIndex=1:NumberOfCurrents
        CurrentName=CellOfCurrents{CurrentIndex};
        NamesOfDS1{CurrentIndex}=HU256_DSTab_GetDS1Name(HU256Cell, CurrentName);
    end
    
    for Point=1:NumberOfPoints
        
%         for CurrentIndex=1:NumberOfCurrents
%             DS1Name=NamesOfDS1{CurrentIndex};
%             tango_command_inout(ProfibusDSName, 'Sync', DS1Name)
%         end
        
        for CurrentIndex=1:NumberOfCurrents
            DS1Name=NamesOfDS1{CurrentIndex};
            CurrentSetPoint=TableArray(CurrentIndex, Point);
            if (Debug==1)
                fprintf('Set current %3.3f on %s\n', CurrentSetPoint, DS1Name);
            else
                writeattribute(DS1Name, CurrentSetPoint);
            end
        end
        
        
%         for CurrentIndex=1:NumberOfCurrents
%             DS1Name=NamesOfDS1{CurrentIndex};
%             tango_command_inout(ProfibusDSName, 'UnSync', DS1Name)
%         end
            
        pause(StepPauseInSeconds);
        if (Debug==1)
            fprintf('\n\n');
        end
    end               
                