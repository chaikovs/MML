function res=CompareValues(HU256Cell, BZP)
    res=-1;
    NbBX=12;
    Dev=sprintf('ANS-C%02.0f/EI/M-HU256.2', HU256Cell);
    FileName=sprintf('/home/operateur/GrpGMI/Comparaison_courants_tables_HU256/HU256_C%01.0f_DeltaCorr_BZP_%g', HU256Cell, BZP);
    tango_write_attribute(Dev, 'Mode', 4);  % Circulaire
    tango_write_attribute(Dev, 'currentBZP', BZP);
    Condition=1;
    while (Condition)
       State=tango_read_attribute(Dev, 'State');
       State=State.value; % 0 for stand by, 6 for running
       BZP_read=tango_read_attribute(Dev, 'currentBZP');
       BZP_read=BZP_read.value;
       BZP_read=BZP_read(1);
       Condition=(State~=0&&abs(BZP-BZP_read)<=0.50);
       if ~Condition
           pause(0.5);
       end
    end
    pause(10);
    ResultArray=zeros(NbBX, 5);
    ResultArray(:,:)=nan;
    tango_write_attribute(Dev, 'currentBX1', 0)
    Condition=1;
    while (Condition)
       State=tango_read_attribute(Dev, 'State');
       State=State.value;
       BX1_read=tango_read_attribute(Dev, 'currentBX1');
       BX1_read=BX1_read.value;
       BX1_read=BX1_read(1);
       Condition=(State~=0&&abs(BX1_read)<=2);
       if ~Condition
           pause(0.5);
       end
    end
    pause(10);
    for iBX=NbBX:-1:1
       BX=(iBX-1)*25;
       tango_write_attribute(Dev, 'currentBX1', BX)
       Condition=1;
       while (Condition)
           State=tango_read_attribute(Dev, 'State');
           State=State.value;
           BX1_read=tango_read_attribute(Dev, 'currentBX1');
           BX1_read=BX1_read.value;
           BX1_read=BX1_read(1);
           Condition=(State~=0&&abs(BX-BX1_read)<=2);
           if ~Condition
               pause(0.5);
           end
       end
       pause(10);
       [BX1_read, ~, ~, CVE, CHE, CVS, CHS, CVE_tab, CHE_tab, CVS_tab, CHS_tab]=CompareDeliveredCurrentsToTables(HU256Cell, 'Circ', -1, 0);
       CVE_Delta=CVE-CVE_tab;
       CHE_Delta=CHE-CHE_tab;
       CVS_Delta=CVS-CVS_tab;
       CHS_Delta=CHS-CHS_tab;
       ResultArray(iBX, 1)=BX1_read;
       ResultArray(iBX, 2)=CVE_Delta;
       ResultArray(iBX, 3)=CHE_Delta;
       ResultArray(iBX, 4)=CVS_Delta;
       ResultArray(iBX, 5)=CHS_Delta;
    end
    FileName=appendtimestamp(FileName);
    FileName=[FileName '.txt'];
    ID=fopen(FileName, 'w');
    fprintf(ID, '%s\t%s\t%s\t%s\t%s\n', 'BX1', 'CVE', 'CHE', 'CVS', 'CHS');
    fclose(ID);
    ID=fopen(FileName, 'a');
    for i=1:size(ResultArray, 1)
        fprintf(ID, '%g\t%g\t%g\t%g\t%g\n', ResultArray(i, :)); %'BX1', 'CVE', 'CHE', 'CVS', 'CHS');
       % fwrite(ID, ResultArray);
    end
    res=1;
end
       
       