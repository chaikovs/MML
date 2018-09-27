function HU256_OperationWith2TablesOnMultipleTables(Directory1, Directory2, Suffix1, Suffix2, Directory3, Suffix3)

    CourantBx=0:25:275;
    
    for i=1:length(CourantBx)
        Name1=[Directory1 filesep 'TableHelBXD' num2str(CourantBx(i)) '_' Suffix1];
        Name2=[Directory2 filesep 'TableHelBXD' num2str(CourantBx(i)) '_' Suffix2];
        Name3=[Directory2 filesep 'TableHelBXD' num2str(CourantBx(i)) '_' Suffix3];
        HU256_Tab_OperationWith2Tables ('+', Name1, Name2, Name3);
    end
    Name1=[Directory1 filesep 'TableHelBXU_' Suffix1];
    Name2=[Directory2 filesep 'TableHelBXU_' Suffix2];
    Name3=[Directory2 filesep 'TableHelBXU_' Suffix3];
    HU256_Tab_OperationWith2Tables ('+', Name1, Name2, Name3);