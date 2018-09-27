function res=HU256_GlobalCheckOfHelTables(Directory, Suffix)
    global APERIODIC;
    global POWERSUPPLYNAME;
    global PRESENTCURRENT;
    global SENSEOFCURRENT;
    global BXPRESENTCURRENTFORHEL;
    global BXSENSEOFCURRENTFORHEL;
    %global LISTOFCURRENTS;
    global BXLISTOFCURRENTSFORHEL;
    
    res=-1;
    BackupAPERIODIC=APERIODIC;
    BackupPOWERSUPPLYNAME=POWERSUPPLYNAME;
    BackupPRESENTCURRENT=PRESENTCURRENT;
    BackupSENSEOFCURRENT=SENSEOFCURRENT;
    BackupBXPRESENTCURRENTFORHEL=BXPRESENTCURRENTFORHEL;
    BackupBXSENSEOFCURRENTFORHEL=BXSENSEOFCURRENTFORHEL;
    BackupBXLISTOFCURRENTSFORHEL=BXLISTOFCURRENTSFORHEL;
    
    fprintf('Checking of the Helicoil Tables with suffix ''%s'' in the directory ''%s'' :\n', Suffix, Directory)
    APERIODIC='hel';
    if (length(BXLISTOFCURRENTSFORHEL)<=2)
        fprintf('Problem in HU256_AreHelTablesFull : BXLISTOFCURRENTSFORHEL should contain at least 3 numbers!\n')
        return
    end
    BXPRESENTCURRENTFORHEL=BXLISTOFCURRENTSFORHEL(2);
    BXSENSEOFCURRENTFORHEL=1;
    UName=HU256_GetTableFileNameForHel(Suffix, 0);
    UName=UName.U;
    UFullName=[Directory filesep UName];
    URes=HU256_CheckIfScriptTableExistsAndIsNotFull(UFullName, 0, -1, 0);
    if (URes==-1)
        fprintf(' -  The Up Table is missing.\n')
    elseif (URes==1)
        fprintf(' -  The Up Table is not full.\n')
    elseif (URes==0)
        fprintf(' -  The Up Table is full.\n')
    elseif (DRes==-2)
        fprintf('Problem in HU256_GlobalCheckOfHelTables : HU256_CheckIfScriptTableExistsAndIsNotFull was not executed correctly.\n')
    end
    BXSENSEOFCURRENTFORHEL=-1;
%     DFullName=zeros(1, length(BXLISTOFCURRENTSFORHEL))
    DSumRes=0;
    for i=1:length(BXLISTOFCURRENTSFORHEL);
        BXPRESENTCURRENTFORHEL=BXLISTOFCURRENTSFORHEL(i);
        DName=HU256_GetTableFileNameForHel(Suffix, 0);
        DName=DName.D;
        DFullName=[Directory filesep DName];
        DRes=HU256_CheckIfScriptTableExistsAndIsNotFull(DFullName, 0, -1, 0);

        if (DRes==-1)
            fprintf(' -  The Down Table for BX=%3.3fA is missing\n', BXLISTOFCURRENTSFORHEL(i))
        elseif (DRes==1)
            fprintf(' -  The Down Table for BX=%3.3fA is not full.\n', BXLISTOFCURRENTSFORHEL(i))
            DSumRes=DSumRes+1;
        elseif (DRes==0)
            fprintf(' -  The Down Table for BX=%3.3fA is full.\n', BXLISTOFCURRENTSFORHEL(i))
            DSumRes=DSumRes+1;
        elseif (DRes==-2)
            fprintf('Problem in HU256_GlobalCheckOfHelTables : HU256_CheckIfScriptTableExistsAndIsNotFull was not executed correctly.\n')
        end
    end
    if (DSumRes==length(BXLISTOFCURRENTSFORHEL))
        if (URes==1||URes==0)
            fprintf(' => All Tables are in the datafolder.\n')
        else
            fprintf(' => Only the Up Table is missing in the datafolder.\n')
        end
    else
        if (URes==1||URes==0)
            fprintf(' => %d Down Tables are missing in the datafolder.\n', length(BXLISTOFCURRENTSFORHEL)-DSumRes)
        else
            fprintf(' => The Up Table and %d Down are missing in the datafolder.\n', length(BXLISTOFCURRENTSFORHEL)-DSumRes)
        end
    end

    APERIODIC=BackupAPERIODIC;
    POWERSUPPLYNAME=BackupPOWERSUPPLYNAME;
    PRESENTCURRENT=BackupPRESENTCURRENT;
    SENSEOFCURRENT=BackupSENSEOFCURRENT;
    BXPRESENTCURRENTFORHEL=BackupBXPRESENTCURRENTFORHEL;
    BXSENSEOFCURRENTFORHEL=BackupBXSENSEOFCURRENTFORHEL;
    BXLISTOFCURRENTSFORHEL=BackupBXLISTOFCURRENTSFORHEL;
    res=1;
    