function [CVE, CHE, CVS, CHS]=AnalogGetCurrentsFromDevice(HU256Cell, BXCurrent, BZPCurrent, UpOrDown, Mode)
    %% Returns correction currents of tables
    % HU256Cell : 4, 12 or 15
    % BXCurrent : BX current (no impact in LH or AH modes
    % BZPCurrent: BZP current (no impact in LV or AV modes).
    %           : if Mode='Circ' and BZPCurrent='BX' 
    %               => Mode Circ Hel (BXmoving)
    % UpOrDown  : Main power supply moving sense : -1 or 1 (not zero!)
    % Mode      : 'LH', 'LV', 'AH', 'AV' or 'Circ'
    
    CVE=nan;
    CHE=nan;
    CVS=nan;
    CHS=nan;
        
    if strcmp(Mode, 'Circ')
    
        if ischar(BZPCurrent)&&strcmp(BZPCurrent, 'BX') % Circ Hel mode (BX1 and BX2 moving)
            [FFWDTable, PowerSupplies]=AnalogGetFFWDTableFromDevice(HU256Cell, 'BX');
            [CVE, CHE, CVS, CHS]=AnalogInterpolateCurrent(FFWDTable, PowerSupplies, BXCurrent, 'BX', UpOrDown);

        elseif isscalar(BZPCurrent) % Circ mode (BZP moving)

            %% Interpoling BX tables

            BXCurrents=Analog_GetBXCurrentsInCircTablesFromDevice(HU256Cell);
            if BXCurrent>max(BXCurrents)
                BXCurrent=max(BXCurrents);
                fprintf ('AnalogGetCircCurrentsFromDevice [WARNING] : BX current ''%g'' outside limits\n', BXCurrent);
            end
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
            
            %% Interpolating obtained interpolated BZ table
            [CVE, CHE, CVS, CHS]=AnalogInterpolateCurrent(FFWDTable, PowerSupplies, BZPCurrent, 'BZ', UpOrDown); 
        end
    elseif strcmp(Mode, 'LH')||strcmp(Mode, 'AH')
        [FFWDTable, PowerSupplies]=AnalogGetFFWDTableFromDevice(HU256Cell, Mode);
        [CVE, CHE, CVS, CHS]=AnalogInterpolateCurrent(FFWDTable, PowerSupplies, BZPCurrent, 'BZ', UpOrDown);
    elseif strcmp(Mode, 'LV')||strcmp(Mode, 'AV')
        [FFWDTable, PowerSupplies]=AnalogGetFFWDTableFromDevice(HU256Cell, Mode);
        [CVE, CHE, CVS, CHS]=AnalogInterpolateCurrent(FFWDTable, PowerSupplies, BXCurrent, 'BX', UpOrDown);
    end
    return
end