function Result=HU256_Tab_SendMatrixToTable(InputMatrix, FullPathOfScriptTable, TitleLine)
    % The ScriptTable is used by the HU256 scripts for correction, but not
    % by the DeviceServers. The ScriptTable has a headerline with titles of
    % columns (names of power supplies)
    % Version Helicoidal : makes a 9 columns table (Bz moving or Down Bx moving)
    %                              5 columns table (Up Bx moving)
    
    global APERIODIC;
    global BXSENSEOFCURRENTSFORHEL;
    global DEBUG;


    Result=-1;
    %fprintf ('HU256_Tab_SendMatrixToTable -> FullPathOfScriptTable : %s\n', FullPathOfScriptTable)
    fid=fopen(FullPathOfScriptTable, 'w+');
    if (fid==-1)
        fprintf('Problem in HU256_Tab_SendMatrixToTable : Impossible to open\n"%s"\nThe path may be wrong\n', FullPathOfScriptTable)
        return
    end
    if (size(InputMatrix, 2)==9)     % Classic mode Table or D helicoidal type Table

        if (isa(APERIODIC, 'numerice')==1)  % linear mode
            if (DEBUG==1)
                fprintf('Building 9 columns table in Linear mode\n')
            end
        elseif (isa (APERIODIC, 'char')==1&&BXSENSEOFCURRENTSFORHEL<0) % helicoidal mode
            if (DEBUG==1)
                fprintf('Building 9 columns table in ''Bz of Down Bx'' helicoidal mode\n')
            end
        else
            fprintf ('Problem in HU256_Tab_SendMatrixToTable : The input matrix has 9 columns but the mode seems to be neither linear not helicoidal with Down Bx\n')
            return
        end
        if (TitleLine==1)
            fprintf(fid, '%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\r\n', 'BZP', 'CVE D', 'CVE U', 'CHE D', 'CHE U', 'CVS D', 'CVS U', 'CHS D', 'CHS U');
            %fprintf(fid, '%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\r\n', 'Current', 'Bzc1 D', 'Bzc1 U', 'Bzc27 D', 'Bzc27 U', 'Bxc1 D', 'Bxc1 U', 'Bxc28 D', 'Bxc28 U');
        end
    elseif (size(InputMatrix, 2)==5)    % U helicoidal type Table
        if (isa (APERIODIC, 'char')==0)
            fprintf ('Problem in HU256_Tab_SendMatrixToTable : The input matrix has 5 columns but the mode seems to be Linear (not helicoidal)\n')
            return
        end
        if (DEBUG==1)
            fprintf('Buidling 5 columns table in ''Down Bx'' helicoidal mode\n')
        end
        if (TitleLine==1)
            fprintf(fid, '%8s\t%8s\t%8s\t%8s\t%8s\r\n', 'BX', 'CVE U', 'CHE U', 'CVS U', 'CHS U');
            %fprintf(fid, '%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\r\n', 'Current', 'Bzc1 D', 'Bzc1 U', 'Bzc27 D', 'Bzc27 U', 'Bxc1 D', 'Bxc1 U', 'Bxc28 D', 'Bxc28 U');
        end
    else
        fprintf ('Problem in HU256_Tab_SendMatrixToTable : The input matrix has %f columns but it should have 5 or 9.\n', size(InputiMatrix, 2))
        return
    end
    for line=1:size(InputMatrix, 1)
        fprintf(fid, '%+08.3f\t', InputMatrix(line, :));
        fprintf(fid, '\r\n');
    end
    fclose(fid);
    Result=1;
        