function res=IntegralsScanWithBeam(XMin, XMax, XStep)
        

    res=-1;
%     reply = input(sprintf('Problem in HU256_CheckIfScriptTableExistsAndIsNotFull : The table\n''%s''\nexists yet and is full. If you continue, you will overwrite some values. Are you sure? (y/n) [n]\n=>', FullPathOfScriptTable), 's');
%         
%     if (strcmp(reply, '')==1)
%         reply='n';
%     end
    reply='';
    while(strcmp(reply, 'o')==0&&strcmp(reply, 'c')==0);
        if (strcmp(reply, 'o')==0&&strcmp(reply, 'c')==0)
            reply=input('Please check that the FeedForward is OFF and that the Current is about 20mA distributed in 312 packs (Ok : o / Cancel : c) [c] \n=>', 's');
            if (strcmp(reply, '')==1)
                reply='c';
            end
        end
    end
    if (strcmp(reply, 'c')==1)
        return
    end
    for x=Xmin:XStep:XMax
        Setorbitbump('BPMx', [15 1; 15 2], [x x]