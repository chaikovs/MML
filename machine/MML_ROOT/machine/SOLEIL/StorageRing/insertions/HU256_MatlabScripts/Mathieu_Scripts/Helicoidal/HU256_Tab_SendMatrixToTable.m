function Result=HU256_Tab_SendMatrixToTable(InputMatrix, FullPathOfScriptTable, TitleLine)
    % The ScriptTable is used by the HU256 scripts for correction, but not
    % by the DeviceServers. The ScriptTable has a headerline with titles of
    % columns (names of power supplies)
    
    Result=-1;
    %fprintf ('HU256_Tab_SendMatrixToTable -> FullPathOfScriptTable : %s\n', FullPathOfScriptTable)
    fid=fopen(FullPathOfScriptTable, 'w+');
    if (fid==-1)
        fprintf('Problem in HU256_Tab_SendMatrixToTable : Impossible to open\n"%s"\nThe path may be wrong\n', FullPathOfScriptTable)
        return
    end
    if (size(InputMatrix, 2)==9)     % Classic mode Table or D helicoidal type Table 
        if (TitleLine==1)
            fprintf(fid, '%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\r\n', 'BZP', 'CVE D', 'CVE U', 'CHE D', 'CHE U', 'CVS D', 'CVS U', 'CHS D', 'CHS U');
            %fprintf(fid, '%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\r\n', 'Current', 'Bzc1 D', 'Bzc1 U', 'Bzc27 D', 'Bzc27 U', 'Bxc1 D', 'Bxc1 U', 'Bxc28 D', 'Bxc28 U');
        end
    elseif (size(InputMatrix, 2)==5)    % U helicoidal type Table
        if (TitleLine==1)
            fprintf(fid, '%8s\t%8s\t%8s\t%8s\t%8s\r\n', 'BX', 'CVE U', 'CHE U', 'CVS U', 'CHS U');
            %fprintf(fid, '%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\r\n', 'Current', 'Bzc1 D', 'Bzc1 U', 'Bzc27 D', 'Bzc27 U', 'Bxc1 D', 'Bxc1 U', 'Bxc28 D', 'Bxc28 U');
        end
    end
    for line=1:size(InputMatrix, 1)
        fprintf(fid, '%+08.3f\t', InputMatrix(line, :));
        fprintf(fid, '\r\n');
    end
    fclose(fid);
    Result=1;