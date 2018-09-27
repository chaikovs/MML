function res=HU256_CheckIfTableExistsAndValueIsFull(DirectoryOfTable, SuffixForNameOfTable, UpOrDown, ForceToStop_Ask_ForceToWrite, DisplayMessages)
% Takes the full name of a table (or a structure containing the 2 names) and check if it exists and/or the target values is full (no
% NaN still in it)
% ForceToStop_Ask_ForceToWrite =    -1 => If the table exists and is full, data are not rewrote
%                                   0 => If the table exists and is full, the user is asked what to do
%                                   1 => If the table exists and is full, data are rewrote
% Returns :     -1 if the table was not found (it doesn't exist)
%               1 if it exists and is not full (everything OK)
%               0 if it exists, is full and isn't forced by the user (we don't rewrite some data)
%               NaN if it exists, is full and is forced by the user (we rewrite some data)
%               -2 if there is a problem with the script 

global DEBUG;
global PRESENTCURRENT;
global SENSEOFCURRENT;
global BXPRESENTCURRENTFORHEL;
global BXSENSEOFCURRENTFORHEL;

    res=-2;

    NameOfTable=HU256_GetTableFileNameForHel(SuffixForNameOfTable, 0);
%     if (DEBUG==1)
%         if (fprintf('Check values : Suffix %s, Name %s\n', SuffixForNameOfTable, NameOfTable)
%     end
    if (isa(NameOfTable, 'char')==1)
        FullPathOfScriptTable=[DirectoryOfTable filesep NameOfTable];
        CorrCurrTable=HU256_Tab_GetMatrixFromTable(FullPathOfScriptTable, 0, DisplayMessages);
    elseif (isa(NameOfTable, 'struct')==1)
        FullPathOfScriptTable.U=[DirectoryOfTable filesep NameOfTable.U];
        FullPathOfScriptTable.D=[DirectoryOfTable filesep NameOfTable.D];
        CorrCurrTable=HU256_Tab_GetMatrixFromTable(FullPathOfScriptTable, UpOrDown, DisplayMessages);
    else
        fprintf('Problem in HU256_CheckIfTableExistsAndValueIsFull : NameOfTable must be a string or a structure of strings\n')
        res=-2;
        return
    end
    if (CorrCurrTable==-2)
        fprintf('Problem with HU256_CheckIfTableExistsAndValueIsFull : bad execution of HU256_Tab_GetMatrixFromTable\n')
        res=-2;
        return
    elseif (CorrCurrTable~=-1)  %  The table was found (it exists)
        CorrCurrentsVector=HU256_ExtractCorrCurrentsFromTable(DirectoryOfTable, SuffixForNameOfTable);
%         sum(sum(isnan(CorrCurrentsVector)))
        if (sum(sum(isnan(CorrCurrentsVector)))==0)  % no more 'Nan' remaining in the target values <=> they are full yet
            if (ForceToStop_Ask_ForceToWrite==0)  % The user is asked
                if (SENSEOFCURRENT==-1)
                    SENSEOFCURRENT_str='D';
                else
                    SENSEOFCURRENT_str='U';
                end
                if (BXSENSEOFCURRENTFORHEL==-1)
                    BXSENSEOFCURRENTFORHEL_str='D';
                else
                    BXSENSEOFCURRENTFORHEL_str='U';
                end
                if (isa(FullPathOfScriptTable, 'struct')==1)
                    if (UpOrDown==1)
                        FullPathOfScriptTableStructElement=FullPathOfScriptTable.U;
                    else
                        FullPathOfScriptTableStructElement=FullPathOfScriptTable.D;
                    end
                    %fprintf('Problem in HU256_CheckIfTableExistsAndValueIsFull : The table ''%s'' was not found\n', FullPathOfScriptTableStructElement);
                    
                    reply = input(sprintf('Problem in HU256_CheckIfTableExistsAndValueIsFull : The table\n''%s''\nexists yet and Target value is full ( BZ=%1.3fA(%s) , BX=%1.3fA(%s) ) . If you continue, you will overwrite the values. Are you sure? (y/n) [n]\n=>', FullPathOfScriptTableStructElement, PRESENTCURRENT, SENSEOFCURRENT_str, BXPRESENTCURRENTFORHEL, BXSENSEOFCURRENTFORHEL_str), 's');
                else
                    reply = input(sprintf('Problem in HU256_CheckIfTableExistsAndValueIsFull : The table\n''%s''\nexists yet and Target value is full ( BZ=%1.3fA(%s) , BX=%1.3fA(%s) ) . If you continue, you will overwrite the values. Are you sure? (y/n) [n]\n=>', FullPathOfScriptTable, PRESENTCURRENT, SENSEOFCURRENT_str, BXPRESENTCURRENTFORHEL, BXSENSEOFCURRENTFORHEL_str), 's');
                end
                if (strcmp(reply, '')==1)
                    reply='n';
                end
                while(strcmp(reply, 'y')==0&&strcmp(reply, 'n')==0);
                    if (strcmp(reply, 'y')==0&&strcmp(reply, 'n')==0)
                        reply=input('\nProblem in HU256_CheckIfTableExistsAndValueIsFull : You should answer by ''y'', ''n'' or by pressing ''Enter''\n=>', 's');
                        if (strcmp(reply, '')==1)
                            reply='n';
                        end
                    end
                end
            elseif (ForceToStop_Ask_ForceToWrite==-1)    % The table is full => we stop (<=> we don't rewrite values, without asking)
                reply='n';
            elseif (ForceToStop_Ask_ForceToWrite==1)    % The table is full => we skip (<=> we rewrite values, without asking)
                reply='y';
            else
                fprintf('Problem in HU256_CheckIfTableExistsAndValueIsFull : ForceToStop_Ask_ForceToWrite must be -1, 0 or 1\n')
                res=-2;
                return
            end
            if (strcmp(reply, 'y')==1)  % The table is full but values are rewrote
%                 if (DisplayMessages==1)
%                     if (isa(FullPathOfScriptTable, 'char')==1)
%                         fprintf('In HU256_CheckIfTableExistsAndValueIsFull : The table\n\t''%s''\nis full but values are rewrote anyway!\n', FullPathOfScriptTable)
%                     else
%                         if (UpOrDown==1)
%                             FullPathOfScriptTableStructElement=FullPathOfScriptTable.U;
%                         else
%                             FullPathOfScriptTableStructElement=FullPathOfScriptTable.D;
%                         end
%                         fprintf('In HU256_CheckIfTableExistsAndValueIsFull : The table\n\t''%s''\nis full but values are rewrote anyway!\n', FullPathOfScriptTableStructElement)
%                     end
%                 end
                res= nan;
            else
%                 if (DisplayMessages==1)
%                     if (isa(FullPathOfScriptTable, 'char')==1)
%                         fprintf('In HU256_CheckIfTableExistsAndValueIsFull : The table\n\t''%s''\nis full. Values are not rewrote.\n', FullPathOfScriptTable)
%                     else
%                         if (UpOrDown==1)
%                             FullPathOfScriptTableStructElement=FullPathOfScriptTable.U;
%                         else
%                             FullPathOfScriptTableStructElement=FullPathOfScriptTable.D;
%                         end
%                         fprintf('In HU256_CheckIfTableExistsAndValueIsFull : The table\n\t''%s''\nis full. Values are not rewrote.\n', FullPathOfScriptTableStructElement)
%                     end
%                 end
                res= 0;   % The table is full and values are not rewrote
            end
        else
            res=1; % The table exists and is not full
        end
    else    % The table was not found
        if (DisplayMessages==1)
%             if (isa(FullPathOfScriptTable, 'struct')==1)
%                 if (UpOrDown==1)
%                     FullPathOfScriptTableStructElement=FullPathOfScriptTable.U;
%                 else
%                     FullPathOfScriptTableStructElement=FullPathOfScriptTable.D;
%                 end
%                 fprintf('Problem in HU256_CheckIfTableExistsAndValueIsFull : The table\n\t''%s''\n was not found\n', FullPathOfScriptTableStructElement);
%             else
%                 fprintf('Problem in HU256_CheckIfTableExistsAndValueIsFull : The table \n\t''%s''\n was not found\n', FullPathOfScriptTable);
%             end
        end
        res=-1; % The table doesn't exist!
    end
    if (DisplayMessages==1)
        if (isa(FullPathOfScriptTable, 'struct')==1)
            if (UpOrDown==1)
                FullPathOfScriptTableString=FullPathOfScriptTable.U;
            else
                FullPathOfScriptTableString=FullPathOfScriptTable.D;
            end
        else
            FullPathOfScriptTableString=FullPathOfScriptTable;
        end
        if (res==-1)
            fprintf('In HU256_CheckIfTableExistsAndValueIsFull : The table ''%s'' was not found.\n', FullPathOfScriptTableString);
        elseif (isnan(res)==1)
            fprintf('In HU256_CheckIfTableExistsAndValueIsFull : The table ''%s'' is full but was rewrote anyway.\n', FullPathOfScriptTableString);
        elseif (res==0)
            fprintf('In HU256_CheckIfTableExistsAndValueIsFull : The table ''%s'' is full and was not rewrote.\n', FullPathOfScriptTableString);
        elseif (res==1)
            fprintf('In HU256_CheckIfTableExistsAndValueIsFull : The table ''%s'' is not full.\n', FullPathOfScriptTableString);
        else
            fprintf ('!!!!!Problem in HU256_CheckIfTableExistsAndValueIsFull : res should be -1, 0, 1 or NaN. Check the script!!!!!\n')
        end
    end