function OLD_ComparisonCycle(HU256Cell, FileFullName)
i=1;
Vect=[];
FileID=fopen(FileFullName, 'w');
fprintf(FileID, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'i', 'BX1', 'BX2', 'BZP', 'U/D', 'CVE', 'CHE', 'CVS', 'CHS', 'CVE_tab', 'CHE_tab', 'CVS_tab', 'CHS_tab');
fclose(FileID);
while(1)
    if i==1
        [Old1_BX1, ~, Old1_BZP]=GetDeliveredCurrents(HU256Cell);
    elseif i==2
        [Old2_BX1, ~, Old2_BZP]=GetDeliveredCurrents(HU256Cell);
%     elseif i==3
%         BZPUpOrDown=sign(Old2_BZP-Old1_BZP);
%         [BX1, BX2, BZP, CVE, CHE, CVS, CHS, CVE_tab, CHE_tab, CVS_tab, CHS_tab]=CompareDeliveredCurrentsToTables(HU256Cell, BZPUpOrDown, 1);
%         Old1_BZP=Old2_BZP;
%         Old2_BZP=BZP;
%         Vect=[i, BX1, BX2, BZP, BZPUpOrDown, CVE, CHE, CVS, CHS, CVE_tab, CHE_tab, CVS_tab, CHS_tab];
    else
        if i>3
            OldBZPUpOrDown=BZPUpOrDown;
        end
        BZPUpOrDown=sign(Old2_BZP-Old1_BZP);
        
        if BZPUpOrDown==0&&i>3
            BZPUpOrDown=OldBZPUpOrDown;
        end
                
        [BX1, BX2, BZP, CVE, CHE, CVS, CHS, CVE_tab, CHE_tab, CVS_tab, CHS_tab]=CompareDeliveredCurrentsToTables(HU256Cell, BZPUpOrDown, 0);
        Old1_BZP=Old2_BZP;
        Old2_BZP=BZP;
        Vect(size(Vect, 1)+1, :)=[i, BX1, BX2, BZP, BZPUpOrDown, CVE, CHE, CVS, CHS, CVE_tab, CHE_tab, CVS_tab, CHS_tab];
        FileID=fopen(FileFullName, 'a');
        fprintf(FileID, '%d\t%7.3f\t%7.3f\t%7.3f\t%d\t%7.3f\t%7.3f\t%7.3f\t%7.3f\t%7.3f\t%7.3f\t%7.3f\t%7.3f\n', i, BX1, BX2, BZP, BZPUpOrDown, CVE, CHE, CVS, CHS, CVE_tab, CHE_tab, CVS_tab, CHS_tab);
        fclose(FileID);
    end
    
    i=i+1;
    pause(0.5);
end