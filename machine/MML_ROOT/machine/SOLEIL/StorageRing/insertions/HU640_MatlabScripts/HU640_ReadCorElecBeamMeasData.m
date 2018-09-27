function [fnMeasMain, fnMeasBkgr, vCurVals] = idReadCorElecBeamMeasData(idName, gap, corName)

%vCurVals = [-4,-2, 0, 2, 4]; To be modified in the next sections
vCurVals = [-1,-0.5, 0, 0.5, 1];

        if strcmp(corName, 'CVE')

            fnMeasMain = cellstr(['HU640_Corr4_m10A';
                                  'HU640_Corr4_m05A'; 
                                  'HU640_Corr4_000A';
                                  'HU640_Corr4_p05A'
                                  'HU640_Corr4_p10A']);                                  
            fnMeasBkgr = cellstr(['HU640_Corr4_000A';
                                  'HU640_Corr4_000A';
                                  'HU640_Corr4_000A';
                                  'HU640_Corr4_000A';
                                  'HU640_Corr4_000A']);
        elseif strcmp(corName, 'CHE')

            fnMeasMain = cellstr(['HU640_Corr2_m10A';
                                  'HU640_Corr2_m05A'; 
                                  'HU640_Corr2_000A';
                                  'HU640_Corr2_p05A'
                                  'HU640_Corr2_p10A']);                                  
            fnMeasBkgr = cellstr(['HU640_Corr2_000A';
                                  'HU640_Corr2_000A';
                                  'HU640_Corr2_000A';
                                  'HU640_Corr2_000A';
                                  'HU640_Corr2_000A']);
        elseif strcmp(corName, 'CVS')

            fnMeasMain = cellstr(['HU640_Corr3_m10A';
                                  'HU640_Corr3_m05A'; 
                                  'HU640_Corr3_000A';
                                  'HU640_Corr3_p05A'
                                  'HU640_Corr3_p10A']);                                  
            fnMeasBkgr = cellstr(['HU640_Corr3_000A';
                                  'HU640_Corr3_000A';
                                  'HU640_Corr3_000A';
                                  'HU640_Corr3_000A';
                                  'HU640_Corr3_000A']);
        elseif strcmp(corName, 'CHS')

            fnMeasMain = cellstr(['HU640_Corr1_m10A';
                                  'HU640_Corr1_m05A'; 
                                  'HU640_Corr1_000A';
                                  'HU640_Corr1_p05A'
                                  'HU640_Corr1_p10A']);                                  
            fnMeasBkgr = cellstr(['HU640_Corr1_000A';
                                  'HU640_Corr1_000A';
                                  'HU640_Corr1_000A';
                                  'HU640_Corr1_000A';
                                  'HU640_Corr1_000A']);
        end
    end % HU640_DESIRS
