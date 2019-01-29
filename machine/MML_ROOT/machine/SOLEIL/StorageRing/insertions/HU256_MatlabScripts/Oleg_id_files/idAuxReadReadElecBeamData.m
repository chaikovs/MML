function [fnMeasMain, fnMeasBkgr] = idAuxReadReadElecBeamData(corName)

if strcmp(corName, 'CHE')
fnMeasMain = cellstr(['C2G15_5_he-10_ve0_hs0_vs0_2006-10-01_13-23-59'; 
                      'C2G15_5_he-5_ve0_hs0_vs0_2006-10-01_13-25-02 '; 
                      'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-26-04  '; 
                      'C2G15_5_he5_ve0_hs0_vs0_2006-10-01_13-27-04  '; 
                      'C2G15_5_he10_ve0_hs0_vs0_2006-10-01_13-28-07 ']);
fnMeasBkgr = cellstr(['C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-22-52  '; 
                      'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-22-52  '; 
                      'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-26-04  '; 
                      'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-26-04  '; 
                      'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-26-04  ']);
end