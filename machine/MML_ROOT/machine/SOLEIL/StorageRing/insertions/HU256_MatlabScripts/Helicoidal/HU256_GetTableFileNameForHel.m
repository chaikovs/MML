function NameOfTableToBuild=HU256_GetTableFileNameForHel(SuffixForNameOfTable, AllNames)
% If linear mode, returns the name of the table (to build or to correct with), based on the suffix asked and the global variables)
% If helicoidal mode, returns a structure containing (in 2 strings) the names of the tables to build :
% one table containing BX Up values and one table containing BZP Down values. These strings are stored in 'U' and 'D'
% fields.
% If helicoidal, AllNames=1 => every names of tables are returned
% Else, only the right name(s)
% All the names are without Path!!

    global APERIODIC;
    global POWERSUPPLYNAME;
    global PRESENTCURRENT;
    global SENSEOFCURRENT;
    global BXPRESENTCURRENTFORHEL;
    global BXSENSEOFCURRENTFORHEL;
    %global LISTOFCURRENTS;
    global BXLISTOFCURRENTSFORHEL;
    
    if (isa(SuffixForNameOfTable, 'char')==1&&strcmp(SuffixForNameOfTable, '')==0)
        LinkingText='_';
    else
        LinkingText='';
    end
    
    if (isa(APERIODIC, 'numeric')==1)   % classic mode
        if (strcmp(POWERSUPPLYNAME, 'bz')==1)
            if (APERIODIC==0)
                NameOfTableToBuild=['TableLH' LinkingText SuffixForNameOfTable];
            else
                NameOfTableToBuild=['TableAH' LinkingText SuffixForNameOfTable];
            end
        else
            if (APERIODIC==0)
                NameOfTableToBuild=['TableLV' LinkingText SuffixForNameOfTable];
            else
                NameOfTableToBuild=['TableAV' LinkingText SuffixForNameOfTable];
            end
        end
    else    % helicoidal mode
        i=find(BXLISTOFCURRENTSFORHEL==BXPRESENTCURRENTFORHEL);
        NameOfTableToBuild.U=['TableHelBXU' LinkingText SuffixForNameOfTable];
        NameOfTableToBuild.D=['TableHelBXD' num2str(BXPRESENTCURRENTFORHEL) LinkingText SuffixForNameOfTable];
        if (AllNames==0)
            if (i==1||i==length(BXLISTOFCURRENTSFORHEL))  % BX=0 ou 275A
                if (PRESENTCURRENT~=0||SENSEOFCURRENT==1)
                    % Que TableHelBXD
                    NameOfTableToBuild.U='';
                end
            elseif (BXSENSEOFCURRENTFORHEL==1)
                % Que TableHelBXU
                NameOfTableToBuild.D='';
            elseif (BXSENSEOFCURRENTFORHEL==-1)
                % Que TableBXD___
                NameOfTableToBuild.U='';
            end
        end
    end