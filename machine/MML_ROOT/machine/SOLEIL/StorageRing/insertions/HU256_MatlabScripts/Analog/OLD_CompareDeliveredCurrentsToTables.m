function [BX1, BX2, BZP, CVE, CHE, CVS, CHS, CVE_tab, CHE_tab, CVS_tab, CHS_tab]=CompareDeliveredCurrentsToTables(HU256Cell, BZPUpOrDown, Display)

    [BX1, BX2, BZP, CVE, CHE, CVS, CHS]=GetDeliveredCurrents(HU256Cell);
    
    if BZPUpOrDown==1
        BZPUpOrDownString='U';
    elseif BZPUpOrDown==-1
        BZPUpOrDownString='D';
    else
        BZPUpOrDownString='?';
        BZPUpOrDown=-1;
    end
    
    [CVE_tab, CHE_tab, CVS_tab, CHS_tab]=AnalogGetCircCurrentsFromDevice(HU256Cell, BX1, BZP, BZPUpOrDown);
    Cell=cell(5, 5);
    Table=[CVE_tab, CHE_tab, CVS_tab, CHS_tab];
    Meas=[CVE, CHE, CVS, CHS];
    Delta=abs(Meas)-abs(Table);
    DeltaRel=Delta./abs(Table)*100;

    Cell={'Name:', 'CVE', 'CHE', 'CVS', 'CHS'; 'Table:', CVE_tab, CHE_tab, CVS_tab, CHS_tab; 'Meas:', CVE, CHE, CVS, CHS; 'Delta', 0, 0, 0, 0; 'DeltaRel', 0, 0, 0, 0};
    for i=1:4
        Cell{4, i+1}=Delta(i);
    end
    for i=1:4
        Cell{5, i+1}=DeltaRel(i);
    end
    DeltaRel(DeltaRel>100)=Inf;
    
if Display
    
    fprintf ('\n=====================================\n')
    fprintf ('BX1 : %3.3f\nBZP : %3.3f (%s)\n', BX1, BZP, BZPUpOrDownString)
    fprintf ('\t\t  CVE  \t  CHE  \t  CVS  \t  CHS  \n')
    fprintf ('Tables:\t\t%7.3f\t%7.3f\t%7.3f\t%7.3f\n', CVE_tab, CHE_tab, CVS_tab, CHS_tab)
    fprintf ('Mesures:\t%7.3f\t%7.3f\t%7.3f\t%7.3f\n', Meas(:))
    fprintf ('Deltas:\t\t%7.3f\t%7.3f\t%7.3f\t%7.3f\n', Delta(:))
    fprintf ('Err(%%):\t\t%7.1f\t%7.1f\t%7.1f\t%7.1f\n', DeltaRel(:))
end
%disp(Cell);
return