function [fnMeasMain, fnMeasBkgr, vCurVals] = idReadCorElecBeamMeasData_InVacuumAndWigglers(idName, gap, corName)

%% Order of contents:
%   - In Vacuum insertion device:
%         - U20 PROXIMA1
%         - U20 SWING
%         - U20 CRISTAL
%         - U20 SIXS
%         - U20 GALAXIES
%         - U20 NANO
%         - U24 PROXIMA2A
%         - WSV50 PSICHE
%         - U18 TOMO
%   - Out Vacuum wiggler:
%         - W164
%% Press CTRL-UP or CTRL-DOWN to sweep undulators

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IN VACUUM INSERTION DEVICES %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(idName, 'U20_PROXIMA1')
     vCurVals = [-6, -4, -2, 0, 2, 4, 6];
    if strcmp(corName, 'CHE')
        fnMeasMain = cellstr(['U20_PROXIMA1_CHE_-6';
                              'U20_PROXIMA1_CHE_-4';
                              'U20_PROXIMA1_CHE_-2';
                              'U20_PROXIMA1_CHE_0 ';
                              'U20_PROXIMA1_CHE_2 ';
                              'U20_PROXIMA1_CHE_4 ';
                              'U20_PROXIMA1_CHE_6 ']);
        fnMeasBkgr = cellstr(['U20_PROXIMA1_CHE_0 ';
                              'U20_PROXIMA1_CHE_0 ';
                              'U20_PROXIMA1_CHE_0 ';
                              'U20_PROXIMA1_CHE_0 ';
                              'U20_PROXIMA1_CHE_0 ';
                              'U20_PROXIMA1_CHE_0 ';
                              'U20_PROXIMA1_CHE_0 ']);
    elseif strcmp(corName, 'CVE')                           
        fnMeasMain = cellstr(['U20_PROXIMA1_CVE_-6';
                              'U20_PROXIMA1_CVE_-4';
                              'U20_PROXIMA1_CVE_-2';
                              'U20_PROXIMA1_CVE_0 ';
                              'U20_PROXIMA1_CVE_2 ';
                              'U20_PROXIMA1_CVE_4 ';
                              'U20_PROXIMA1_CVE_6 ']);
        fnMeasBkgr = cellstr(['U20_PROXIMA1_CVE_0 ';
                              'U20_PROXIMA1_CVE_0 ';
                              'U20_PROXIMA1_CVE_0 ';
                              'U20_PROXIMA1_CVE_0 ';
                              'U20_PROXIMA1_CVE_0 ';
                              'U20_PROXIMA1_CVE_0 ';
                              'U20_PROXIMA1_CVE_0 ']);
    elseif strcmp(corName, 'CHS')
        fnMeasMain = cellstr(['U20_PROXIMA1_CHS_-6';
                              'U20_PROXIMA1_CHS_-4';
                              'U20_PROXIMA1_CHS_-2';
                              'U20_PROXIMA1_CHS_0 ';
                              'U20_PROXIMA1_CHS_2 ';
                              'U20_PROXIMA1_CHS_4 ';
                              'U20_PROXIMA1_CHS_6 ']);
        fnMeasBkgr = cellstr(['U20_PROXIMA1_CHS_0 ';
                              'U20_PROXIMA1_CHS_0 ';
                              'U20_PROXIMA1_CHS_0 ';
                              'U20_PROXIMA1_CHS_0 ';
                              'U20_PROXIMA1_CHS_0 ';
                              'U20_PROXIMA1_CHS_0 ';
                              'U20_PROXIMA1_CHS_0 ']);
    elseif strcmp(corName, 'CVS')
        fnMeasMain = cellstr(['U20_PROXIMA1_CVS_-6';
                              'U20_PROXIMA1_CVS_-4';
                              'U20_PROXIMA1_CVS_-2';
                              'U20_PROXIMA1_CVS_0 ';
                              'U20_PROXIMA1_CVS_2 ';
                              'U20_PROXIMA1_CVS_4 ';
                              'U20_PROXIMA1_CVS_6 ']);
        fnMeasBkgr = cellstr(['U20_PROXIMA1_CVS_0 ';
                              'U20_PROXIMA1_CVS_0 ';
                              'U20_PROXIMA1_CVS_0 ';
                              'U20_PROXIMA1_CVS_0 ';
                              'U20_PROXIMA1_CVS_0 ';
                              'U20_PROXIMA1_CVS_0 ';
                              'U20_PROXIMA1_CVS_0 ']);

    end        

%% U20 SWING
elseif strcmp(idName, 'U20_SWING')
    vCurVals = [-6, -4, -2, 0, 2, 4, 6];
    if strcmp(corName, 'CHE')
        fnMeasMain = cellstr(['U20_SWING_CHE_-6';
                              'U20_SWING_CHE_-4';
                              'U20_SWING_CHE_-2';
                              'U20_SWING_CHE_0 ';
                              'U20_SWING_CHE_2 ';
                              'U20_SWING_CHE_4 ';
                              'U20_SWING_CHE_6 ']);
        fnMeasBkgr = cellstr(['U20_SWING_CHE_0 ';
                              'U20_SWING_CHE_0 ';
                              'U20_SWING_CHE_0 ';
                              'U20_SWING_CHE_0 ';
                              'U20_SWING_CHE_0 ';
                              'U20_SWING_CHE_0 ';
                              'U20_SWING_CHE_0 ']);
    elseif strcmp(corName, 'CVE')                           
        fnMeasMain = cellstr(['U20_SWING_CVE_-6';
                              'U20_SWING_CVE_-4';
                              'U20_SWING_CVE_-2';
                              'U20_SWING_CVE_0 ';
                              'U20_SWING_CVE_2 ';
                              'U20_SWING_CVE_4 ';
                              'U20_SWING_CVE_6 ']);
        fnMeasBkgr = cellstr(['U20_SWING_CVE_0 ';
                              'U20_SWING_CVE_0 ';
                              'U20_SWING_CVE_0 ';
                              'U20_SWING_CVE_0 ';
                              'U20_SWING_CVE_0 ';
                              'U20_SWING_CVE_0 ';
                              'U20_SWING_CVE_0 ']);
    elseif strcmp(corName, 'CHS')
        fnMeasMain = cellstr(['U20_SWING_CHS_-6';
                              'U20_SWING_CHS_-4';
                              'U20_SWING_CHS_-2';
                              'U20_SWING_CHS_0 ';
                              'U20_SWING_CHS_2 ';
                              'U20_SWING_CHS_4 ';
                              'U20_SWING_CHS_6 ']);
        fnMeasBkgr = cellstr(['U20_SWING_CHS_0 ';
                              'U20_SWING_CHS_0 ';
                              'U20_SWING_CHS_0 ';
                              'U20_SWING_CHS_0 ';
                              'U20_SWING_CHS_0 ';
                              'U20_SWING_CHS_0 ';
                              'U20_SWING_CHS_0 ']);
    elseif strcmp(corName, 'CVS')
        fnMeasMain = cellstr(['U20_SWING_CVS_-6';
                              'U20_SWING_CVS_-4';
                              'U20_SWING_CVS_-2';
                              'U20_SWING_CVS_0 ';
                              'U20_SWING_CVS_2 ';
                              'U20_SWING_CVS_4 ';
                              'U20_SWING_CVS_6 ']);
        fnMeasBkgr = cellstr(['U20_SWING_CVS_0 ';
                              'U20_SWING_CVS_0 ';
                              'U20_SWING_CVS_0 ';
                              'U20_SWING_CVS_0 ';
                              'U20_SWING_CVS_0 ';
                              'U20_SWING_CVS_0 ';
                              'U20_SWING_CVS_0 ']); 

    end
%% U20 CRISTAL
elseif strcmp(idName, 'U20_CRISTAL')
    vCurVals = [-6, -4, -2, 0, 2, 4, 6];
    if strcmp(corName, 'CHE')
        fnMeasMain = cellstr(['U20_CRISTAL_CHE_-6';
                              'U20_CRISTAL_CHE_-4';
                              'U20_CRISTAL_CHE_-2';
                              'U20_CRISTAL_CHE_0 ';
                              'U20_CRISTAL_CHE_2 ';
                              'U20_CRISTAL_CHE_4 ';
                              'U20_CRISTAL_CHE_6 ']);
        fnMeasBkgr = cellstr(['U20_CRISTAL_CHE_0 ';
                              'U20_CRISTAL_CHE_0 ';
                              'U20_CRISTAL_CHE_0 ';
                              'U20_CRISTAL_CHE_0 ';
                              'U20_CRISTAL_CHE_0 ';
                              'U20_CRISTAL_CHE_0 ';
                              'U20_CRISTAL_CHE_0 ']);
    elseif strcmp(corName, 'CVE')                           
        fnMeasMain = cellstr(['U20_CRISTAL_CVE_-6';
                              'U20_CRISTAL_CVE_-4';
                              'U20_CRISTAL_CVE_-2';
                              'U20_CRISTAL_CVE_0 ';
                              'U20_CRISTAL_CVE_2 ';
                              'U20_CRISTAL_CVE_4 ';
                              'U20_CRISTAL_CVE_6 ']);
        fnMeasBkgr = cellstr(['U20_CRISTAL_CVE_0 ';
                              'U20_CRISTAL_CVE_0 ';
                              'U20_CRISTAL_CVE_0 ';
                              'U20_CRISTAL_CVE_0 ';
                              'U20_CRISTAL_CVE_0 ';
                              'U20_CRISTAL_CVE_0 ';
                              'U20_CRISTAL_CVE_0 ']);
    elseif strcmp(corName, 'CHS')
        fnMeasMain = cellstr(['U20_CRISTAL_CHS_-6';
                              'U20_CRISTAL_CHS_-4';
                              'U20_CRISTAL_CHS_-2';
                              'U20_CRISTAL_CHS_0 ';
                              'U20_CRISTAL_CHS_2 ';
                              'U20_CRISTAL_CHS_4 ';
                              'U20_CRISTAL_CHS_6 ']);
        fnMeasBkgr = cellstr(['U20_CRISTAL_CHS_0 ';
                              'U20_CRISTAL_CHS_0 ';
                              'U20_CRISTAL_CHS_0 ';
                              'U20_CRISTAL_CHS_0 ';
                              'U20_CRISTAL_CHS_0 ';
                              'U20_CRISTAL_CHS_0 ';
                              'U20_CRISTAL_CHS_0 ']);
    elseif strcmp(corName, 'CVS')
        fnMeasMain = cellstr(['U20_CRISTAL_CVS_-6';
                              'U20_CRISTAL_CVS_-4';
                              'U20_CRISTAL_CVS_-2';
                              'U20_CRISTAL_CVS_0 ';
                              'U20_CRISTAL_CVS_2 ';
                              'U20_CRISTAL_CVS_4 ';
                              'U20_CRISTAL_CVS_6 ']);
        fnMeasBkgr = cellstr(['U20_CRISTAL_CVS_0 ';
                              'U20_CRISTAL_CVS_0 ';
                              'U20_CRISTAL_CVS_0 ';
                              'U20_CRISTAL_CVS_0 ';
                              'U20_CRISTAL_CVS_0 ';
                              'U20_CRISTAL_CVS_0 ';
                              'U20_CRISTAL_CVS_0 ']);

    end

%% U20 SIXS    
elseif strcmp(idName, 'U20_SIXS')
     vCurVals = [-6, -4, -2, 0, 2, 4, 6];
    if strcmp(corName, 'CHE')
        fnMeasMain = cellstr(['U20_SIXS_CHE_-6';
                              'U20_SIXS_CHE_-4';
                              'U20_SIXS_CHE_-2';
                              'U20_SIXS_CHE_0 ';
                              'U20_SIXS_CHE_2 ';
                              'U20_SIXS_CHE_4 ';
                              'U20_SIXS_CHE_6 ']);
        fnMeasBkgr = cellstr(['U20_SIXS_CHE_0 ';
                              'U20_SIXS_CHE_0 ';
                              'U20_SIXS_CHE_0 ';
                              'U20_SIXS_CHE_0 ';
                              'U20_SIXS_CHE_0 ';
                              'U20_SIXS_CHE_0 ';
                              'U20_SIXS_CHE_0 ']);
    elseif strcmp(corName, 'CVE')                           
        fnMeasMain = cellstr(['U20_SIXS_CVE_-6';
                              'U20_SIXS_CVE_-4';
                              'U20_SIXS_CVE_-2';
                              'U20_SIXS_CVE_0 ';
                              'U20_SIXS_CVE_2 ';
                              'U20_SIXS_CVE_4 ';
                              'U20_SIXS_CVE_6 ']);
        fnMeasBkgr = cellstr(['U20_SIXS_CVE_0 ';
                              'U20_SIXS_CVE_0 ';
                              'U20_SIXS_CHE_0 ';
                              'U20_SIXS_CHE_0 ';
                              'U20_SIXS_CHE_0 ';
                              'U20_SIXS_CHE_0 ';
                              'U20_SIXS_CHE_0 ']);
    elseif strcmp(corName, 'CHS')
        fnMeasMain = cellstr(['U20_SIXS_CHS_-6';
                              'U20_SIXS_CHS_-4';
                              'U20_SIXS_CHS_-2';
                              'U20_SIXS_CHS_0 ';
                              'U20_SIXS_CHS_2 ';
                              'U20_SIXS_CHS_4 ';
                              'U20_SIXS_CHS_6 ']);
        fnMeasBkgr = cellstr(['U20_SIXS_CHS_0 ';
                              'U20_SIXS_CHS_0 ';
                              'U20_SIXS_CHS_0 ';
                              'U20_SIXS_CHS_0 ';
                              'U20_SIXS_CHS_0 ';
                              'U20_SIXS_CHS_0 ';
                              'U20_SIXS_CHS_0 ']);
    elseif strcmp(corName, 'CVS')
        fnMeasMain = cellstr(['U20_SIXS_CVS_-6';
                              'U20_SIXS_CVS_-4';
                              'U20_SIXS_CVS_-2';
                              'U20_SIXS_CVS_0 ';
                              'U20_SIXS_CVS_2 ';
                              'U20_SIXS_CVS_4 ';
                              'U20_SIXS_CVS_6 ']);
        fnMeasBkgr = cellstr(['U20_SIXS_CVS_0 ';
                              'U20_SIXS_CVS_0 ';
                              'U20_SIXS_CVS_0 ';
                              'U20_SIXS_CVS_0 ';
                              'U20_SIXS_CVS_0 ';
                              'U20_SIXS_CVS_0 ';
                              'U20_SIXS_CVS_0 ']);

    end        
%  CORRECTOR FILENAMES TO BE CHECKED !!!!       
%% U20 NANO       
elseif strcmp(idName, 'U20_NANO')
    vCurVals = [-6, -4, -2, 0, 2, 4, 6];
    if strcmp(corName, 'CHE')
        fnMeasMain = cellstr(['U20_NANO_CHE_-6';
                              'U20_NANO_CHE_-4';
                              'U20_NANO_CHE_-2';
                              'U20_NANO_CHE_0 ';
                              'U20_NANO_CHE_2 ';
                              'U20_NANO_CHE_4 ';
                              'U20_NANO_CHE_6 ']);
        fnMeasBkgr = cellstr(['U20_NANO_CHE_0 ';
                              'U20_NANO_CHE_0 ';
                              'U20_NANO_CHE_0 ';
                              'U20_NANO_CHE_0 ';
                              'U20_NANO_CHE_0 ';
                              'U20_NANO_CHE_0 ';
                              'U20_NANO_CHE_0 ']);
    elseif strcmp(corName, 'CVE')                           
        fnMeasMain = cellstr(['U20_NANO_CVE_-6';
                              'U20_NANO_CVE_-4';
                              'U20_NANO_CVE_-2';
                              'U20_NANO_CVE_0 ';
                              'U20_NANO_CVE_2 ';
                              'U20_NANO_CVE_4 ';
                              'U20_NANO_CVE_6 ']);
        fnMeasBkgr = cellstr(['U20_NANO_CVE_0 ';
                              'U20_NANO_CVE_0 ';
                              'U20_NANO_CHE_0 ';
                              'U20_NANO_CHE_0 ';
                              'U20_NANO_CHE_0 ';
                              'U20_NANO_CHE_0 ';
                              'U20_NANO_CHE_0 ']);
    elseif strcmp(corName, 'CHS')
        fnMeasMain = cellstr(['U20_NANO_CHS_-6';
                              'U20_NANO_CHS_-4';
                              'U20_NANO_CHS_-2';
                              'U20_NANO_CHS_0 ';
                              'U20_NANO_CHS_2 ';
                              'U20_NANO_CHS_4 ';
                              'U20_NANO_CHS_6 ']);
        fnMeasBkgr = cellstr(['U20_NANO_CHS_0 ';
                              'U20_NANO_CHS_0 ';
                              'U20_NANO_CHS_0 ';
                              'U20_NANO_CHS_0 ';
                              'U20_NANO_CHS_0 ';
                              'U20_NANO_CHS_0 ';
                              'U20_NANO_CHS_0 ']);
    elseif strcmp(corName, 'CVS')
        fnMeasMain = cellstr(['U20_NANO_CVS_-6';
                              'U20_NANO_CVS_-4';
                              'U20_NANO_CVS_-2';
                              'U20_NANO_CVS_0 ';
                              'U20_NANO_CVS_2 ';
                              'U20_NANO_CVS_4 ';
                              'U20_NANO_CVS_6 ']);
        fnMeasBkgr = cellstr(['U20_NANO_CVS_0 ';
                              'U20_NANO_CVS_0 ';
                              'U20_NANO_CVS_0 ';
                              'U20_NANO_CVS_0 ';
                              'U20_NANO_CVS_0 ';
                              'U20_NANO_CVS_0 ';
                              'U20_NANO_CVS_0 ']);

    end
%% U20 GALAXIES       
elseif strcmp(idName, 'U20_GALAXIES')
    vCurVals = [-6, -4, -2, 0, 2, 4, 6];
    if strcmp(corName, 'CHE')
        fnMeasMain = cellstr(['U20_GALAXIES_CHE_-6';
                              'U20_GALAXIES_CHE_-4';
                              'U20_GALAXIES_CHE_-2';
                              'U20_GALAXIES_CHE_0 ';
                              'U20_GALAXIES_CHE_2 ';
                              'U20_GALAXIES_CHE_4 ';
                              'U20_GALAXIES_CHE_6 ']);
        fnMeasBkgr = cellstr(['U20_GALAXIES_CHE_0 ';
                              'U20_GALAXIES_CHE_0 ';
                              'U20_GALAXIES_CHE_0 ';
                              'U20_GALAXIES_CHE_0 ';
                              'U20_GALAXIES_CHE_0 ';
                              'U20_GALAXIES_CHE_0 ';
                              'U20_GALAXIES_CHE_0 ']);
    elseif strcmp(corName, 'CVE')                           
        fnMeasMain = cellstr(['U20_GALAXIES_CVE_-6';
                              'U20_GALAXIES_CVE_-4';
                              'U20_GALAXIES_CVE_-2';
                              'U20_GALAXIES_CVE_0 ';
                              'U20_GALAXIES_CVE_2 ';
                              'U20_GALAXIES_CVE_4 ';
                              'U20_GALAXIES_CVE_6 ']);
        fnMeasBkgr = cellstr(['U20_GALAXIES_CVE_0 ';
                              'U20_GALAXIES_CVE_0 ';
                              'U20_GALAXIES_CHE_0 ';
                              'U20_GALAXIES_CHE_0 ';
                              'U20_GALAXIES_CHE_0 ';
                              'U20_GALAXIES_CHE_0 ';
                              'U20_GALAXIES_CHE_0 ']);
    elseif strcmp(corName, 'CHS')
        fnMeasMain = cellstr(['U20_GALAXIES_CHS_-6';
                              'U20_GALAXIES_CHS_-4';
                              'U20_GALAXIES_CHS_-2';
                              'U20_GALAXIES_CHS_0 ';
                              'U20_GALAXIES_CHS_2 ';
                              'U20_GALAXIES_CHS_4 ';
                              'U20_GALAXIES_CHS_6 ']);
        fnMeasBkgr = cellstr(['U20_GALAXIES_CHS_0 ';
                              'U20_GALAXIES_CHS_0 ';
                              'U20_GALAXIES_CHS_0 ';
                              'U20_GALAXIES_CHS_0 ';
                              'U20_GALAXIES_CHS_0 ';
                              'U20_GALAXIES_CHS_0 ';
                              'U20_GALAXIES_CHS_0 ']);
    elseif strcmp(corName, 'CVS')
        fnMeasMain = cellstr(['U20_GALAXIES_CVS_-6';
                              'U20_GALAXIES_CVS_-4';
                              'U20_GALAXIES_CVS_-2';
                              'U20_GALAXIES_CVS_0 ';
                              'U20_GALAXIES_CVS_2 ';
                              'U20_GALAXIES_CVS_4 ';
                              'U20_GALAXIES_CVS_6 ']);
        fnMeasBkgr = cellstr(['U20_GALAXIES_CVS_0 ';
                              'U20_GALAXIES_CVS_0 ';
                              'U20_GALAXIES_CVS_0 ';
                              'U20_GALAXIES_CVS_0 ';
                              'U20_GALAXIES_CVS_0 ';
                              'U20_GALAXIES_CVS_0 ';
                              'U20_GALAXIES_CVS_0 ']);

    end        
%% U24 PROXIMA2A
elseif strcmp(idName, 'U24_PROXIMA2')
    vCurVals = [-6, -4, -2, 0, 2, 4, 6];
    if strcmp(corName, 'CHE')
        fnMeasMain = cellstr(['U24_PROXIMA2_CHE_-6';
                              'U24_PROXIMA2_CHE_-4';
                              'U24_PROXIMA2_CHE_-2';
                              'U24_PROXIMA2_CHE_0 ';
                              'U24_PROXIMA2_CHE_2 ';
                              'U24_PROXIMA2_CHE_4 ';
                              'U24_PROXIMA2_CHE_6 ']);
        fnMeasBkgr = cellstr(['U24_PROXIMA2_CHE_0 ';
                              'U24_PROXIMA2_CHE_0 ';
                              'U24_PROXIMA2_CHE_0 ';
                              'U24_PROXIMA2_CHE_0 ';
                              'U24_PROXIMA2_CHE_0 ';
                              'U24_PROXIMA2_CHE_0 ';
                              'U24_PROXIMA2_CHE_0 ']);
    elseif strcmp(corName, 'CVE')                           
        fnMeasMain = cellstr(['U24_PROXIMA2_CVE_-6';
                              'U24_PROXIMA2_CVE_-4';
                              'U24_PROXIMA2_CVE_-2';
                              'U24_PROXIMA2_CVE_0 ';
                              'U24_PROXIMA2_CVE_2 ';
                              'U24_PROXIMA2_CVE_4 ';
                              'U24_PROXIMA2_CVE_6 ']);
        fnMeasBkgr = cellstr(['U24_PROXIMA2_CVE_0 ';
                              'U24_PROXIMA2_CVE_0 ';
                              'U24_PROXIMA2_CVE_0 ';
                              'U24_PROXIMA2_CVE_0 ';
                              'U24_PROXIMA2_CVE_0 ';
                              'U24_PROXIMA2_CVE_0 ';
                              'U24_PROXIMA2_CVE_0 ']);
    elseif strcmp(corName, 'CHS')
        fnMeasMain = cellstr(['U24_PROXIMA2_CHS_-6';
                              'U24_PROXIMA2_CHS_-4';
                              'U24_PROXIMA2_CHS_-2';
                              'U24_PROXIMA2_CHS_0 ';
                              'U24_PROXIMA2_CHS_2 ';
                              'U24_PROXIMA2_CHS_4 ';
                              'U24_PROXIMA2_CHS_6 ']);
        fnMeasBkgr = cellstr(['U24_PROXIMA2_CHS_0 ';
                              'U24_PROXIMA2_CHS_0 ';
                              'U24_PROXIMA2_CHS_0 ';
                              'U24_PROXIMA2_CHS_0 ';
                              'U24_PROXIMA2_CHS_0 ';
                              'U24_PROXIMA2_CHS_0 ';
                              'U24_PROXIMA2_CHS_0 ']);
    elseif strcmp(corName, 'CVS')
        fnMeasMain = cellstr(['U24_PROXIMA2_CVS_-6';
                              'U24_PROXIMA2_CVS_-4';
                              'U24_PROXIMA2_CVS_-2';
                              'U24_PROXIMA2_CVS_0 ';
                              'U24_PROXIMA2_CVS_2 ';
                              'U24_PROXIMA2_CVS_4 ';
                              'U24_PROXIMA2_CVS_6 ']);
        fnMeasBkgr = cellstr(['U24_PROXIMA2_CVS_0 ';
                              'U24_PROXIMA2_CVS_0 ';
                              'U24_PROXIMA2_CVS_0 ';
                              'U24_PROXIMA2_CVS_0 ';
                              'U24_PROXIMA2_CVS_0 ';
                              'U24_PROXIMA2_CVS_0 ';
                              'U24_PROXIMA2_CVS_0 ']);
    end

%% WSV50 PSICHE   
elseif strcmp(idName, 'WSV50_PSICHE')
    vCurVals = [-6, -4, -2, 0, 2, 4, 6];
    if strcmp(corName, 'CVE')
        fnMeasMain = cellstr(['WSV50_PSICHE_CVE_-6';
                              'WSV50_PSICHE_CVE_-4';
                              'WSV50_PSICHE_CVE_-2';
                              'WSV50_PSICHE_CVE_0 ';
                              'WSV50_PSICHE_CVE_2 ';
                              'WSV50_PSICHE_CVE_4 ';
                              'WSV50_PSICHE_CVE_6 ']);
        fnMeasBkgr = cellstr(['WSV50_PSICHE_CVE_0 ';
                              'WSV50_PSICHE_CVE_0 ';
                              'WSV50_PSICHE_CVE_0 ';
                              'WSV50_PSICHE_CVE_0 ';
                              'WSV50_PSICHE_CVE_0 ';
                              'WSV50_PSICHE_CVE_0 ';
                              'WSV50_PSICHE_CVE_0 ']);
    elseif strcmp(corName, 'CHE')                           
        fnMeasMain = cellstr(['WSV50_PSICHE_CHE_-6';
                              'WSV50_PSICHE_CHE_-4';
                              'WSV50_PSICHE_CHE_-2';
                              'WSV50_PSICHE_CHE_0 ';
                              'WSV50_PSICHE_CHE_2 ';
                              'WSV50_PSICHE_CHE_4 ';
                              'WSV50_PSICHE_CHE_6 ']);
        fnMeasBkgr = cellstr(['WSV50_PSICHE_CHE_0 ';
                              'WSV50_PSICHE_CHE_0 ';
                              'WSV50_PSICHE_CHE_0 ';
                              'WSV50_PSICHE_CHE_0 ';
                              'WSV50_PSICHE_CHE_0 ';
                              'WSV50_PSICHE_CHE_0 ';
                              'WSV50_PSICHE_CHE_0 ']);
    elseif strcmp(corName, 'CVS')
        fnMeasMain = cellstr(['WSV50_PSICHE_CVS_-6';
                              'WSV50_PSICHE_CVS_-4';
                              'WSV50_PSICHE_CVS_-2';
                              'WSV50_PSICHE_CVS_0 ';
                              'WSV50_PSICHE_CVS_2 ';
                              'WSV50_PSICHE_CVS_4 ';
                              'WSV50_PSICHE_CVS_6 ']);
        fnMeasBkgr = cellstr(['WSV50_PSICHE_CVS_0 ';
                              'WSV50_PSICHE_CVS_0 ';
                              'WSV50_PSICHE_CVS_0 ';
                              'WSV50_PSICHE_CVS_0 ';
                              'WSV50_PSICHE_CVS_0 ';
                              'WSV50_PSICHE_CVS_0 ';
                              'WSV50_PSICHE_CVS_0 ']);
    elseif strcmp(corName, 'CHS')
        fnMeasMain = cellstr(['WSV50_PSICHE_CHS_-6';
                              'WSV50_PSICHE_CHS_-4';
                              'WSV50_PSICHE_CHS_-2';
                              'WSV50_PSICHE_CHS_0 ';
                              'WSV50_PSICHE_CHS_2 ';
                              'WSV50_PSICHE_CHS_4 ';
                              'WSV50_PSICHE_CHS_6 ']);
        fnMeasBkgr = cellstr(['WSV50_PSICHE_CHS_0 ';
                              'WSV50_PSICHE_CHS_0 ';
                              'WSV50_PSICHE_CHS_0 ';
                              'WSV50_PSICHE_CHS_0 ';
                              'WSV50_PSICHE_CHS_0 ';
                              'WSV50_PSICHE_CHS_0 ';
                              'WSV50_PSICHE_CHS_0 ']);

    end     

    %% U18 TOMO
elseif strcmp(idName, 'U18_TOMO')
    vCurVals = [-6, -4, -2, 0, 2, 4, 6];
    if strcmp(corName, 'CHE')
        fnMeasMain = cellstr(['U18_TOMO_CHE_-6';
                              'U18_TOMO_CHE_-4';
                              'U18_TOMO_CHE_-2';
                              'U18_TOMO_CHE_0 ';
                              'U18_TOMO_CHE_2 ';
                              'U18_TOMO_CHE_4 ';
                              'U18_TOMO_CHE_6 ']);
        fnMeasBkgr = cellstr(['U18_TOMO_CHE_0 ';
                              'U18_TOMO_CHE_0 ';
                              'U18_TOMO_CHE_0 ';
                              'U18_TOMO_CHE_0 ';
                              'U18_TOMO_CHE_0 ';
                              'U18_TOMO_CHE_0 ';
                              'U18_TOMO_CHE_0 ']);
    elseif strcmp(corName, 'CVE')                           
        fnMeasMain = cellstr(['U18_TOMO_CVE_-6';
                              'U18_TOMO_CVE_-4';
                              'U18_TOMO_CVE_-2';
                              'U18_TOMO_CVE_0 ';
                              'U18_TOMO_CVE_2 ';
                              'U18_TOMO_CVE_4 ';
                              'U18_TOMO_CVE_6 ']);
        fnMeasBkgr = cellstr(['U18_TOMO_CVE_0 ';
                              'U18_TOMO_CVE_0 ';
                              'U18_TOMO_CVE_0 ';
                              'U18_TOMO_CVE_0 ';
                              'U18_TOMO_CVE_0 ';
                              'U18_TOMO_CVE_0 ';
                              'U18_TOMO_CVE_0 ']);
    elseif strcmp(corName, 'CHS')
        fnMeasMain = cellstr(['U18_TOMO_CHS_-6';
                              'U18_TOMO_CHS_-4';
                              'U18_TOMO_CHS_-2';
                              'U18_TOMO_CHS_0 ';
                              'U18_TOMO_CHS_2 ';
                              'U18_TOMO_CHS_4 ';
                              'U18_TOMO_CHS_6 ']);
        fnMeasBkgr = cellstr(['U18_TOMO_CHS_0 ';
                              'U18_TOMO_CHS_0 ';
                              'U18_TOMO_CHS_0 ';
                              'U18_TOMO_CHS_0 ';
                              'U18_TOMO_CHS_0 ';
                              'U18_TOMO_CHS_0 ';
                              'U18_TOMO_CHS_0 ']);
    elseif strcmp(corName, 'CVS')
        fnMeasMain = cellstr(['U18_TOMO_CVS_-6';
                              'U18_TOMO_CVS_-4';
                              'U18_TOMO_CVS_-2';
                              'U18_TOMO_CVS_0 ';
                              'U18_TOMO_CVS_2 ';
                              'U18_TOMO_CVS_4 ';
                              'U18_TOMO_CVS_6 ']);
        fnMeasBkgr = cellstr(['U18_TOMO_CVS_0 ';
                              'U18_TOMO_CVS_0 ';
                              'U18_TOMO_CVS_0 ';
                              'U18_TOMO_CVS_0 ';
                              'U18_TOMO_CVS_0 ';
                              'U18_TOMO_CVS_0 ';
                              'U18_TOMO_CVS_0 ']);

    end

elseif strcmp(idName, 'W164_PUMA_SLICING')
     vCurVals = [-6, -4, -2, 0, 2, 4, 6];
    if strcmp(corName, 'CHE')
        fnMeasMain = cellstr(['W164_PUMA_SLICING_CHE_-6';
                              'W164_PUMA_SLICING_CHE_-4';
                              'W164_PUMA_SLICING_CHE_-2';
                              'W164_PUMA_SLICING_CHE_0 ';
                              'W164_PUMA_SLICING_CHE_2 ';
                              'W164_PUMA_SLICING_CHE_4 ';
                              'W164_PUMA_SLICING_CHE_6 ']);
        fnMeasBkgr = cellstr(['W164_PUMA_SLICING_CHE_0 ';
                              'W164_PUMA_SLICING_CHE_0 ';
                              'W164_PUMA_SLICING_CHE_0 ';
                              'W164_PUMA_SLICING_CHE_0 ';
                              'W164_PUMA_SLICING_CHE_0 ';
                              'W164_PUMA_SLICING_CHE_0 ';
                              'W164_PUMA_SLICING_CHE_0 ']);
    elseif strcmp(corName, 'CVE')                           
        fnMeasMain = cellstr(['W164_PUMA_SLICING_CVE_-6';
                              'W164_PUMA_SLICING_CVE_-4';
                              'W164_PUMA_SLICING_CVE_-2';
                              'W164_PUMA_SLICING_CVE_0 ';
                              'W164_PUMA_SLICING_CVE_2 ';
                              'W164_PUMA_SLICING_CVE_4 ';
                              'W164_PUMA_SLICING_CVE_6 ']);
        fnMeasBkgr = cellstr(['W164_PUMA_SLICING_CVE_0 ';
                              'W164_PUMA_SLICING_CVE_0 ';
                              'W164_PUMA_SLICING_CVE_0 ';
                              'W164_PUMA_SLICING_CVE_0 ';
                              'W164_PUMA_SLICING_CVE_0 ';
                              'W164_PUMA_SLICING_CVE_0 ';
                              'W164_PUMA_SLICING_CVE_0 ']);
    elseif strcmp(corName, 'CHS')
        fnMeasMain = cellstr(['W164_PUMA_SLICING_CHS_-6';
                              'W164_PUMA_SLICING_CHS_-4';
                              'W164_PUMA_SLICING_CHS_-2';
                              'W164_PUMA_SLICING_CHS_0 ';
                              'W164_PUMA_SLICING_CHS_2 ';
                              'W164_PUMA_SLICING_CHS_4 ';
                              'W164_PUMA_SLICING_CHS_6 ']);
        fnMeasBkgr = cellstr(['W164_PUMA_SLICING_CHS_0 ';
                              'W164_PUMA_SLICING_CHS_0 ';
                              'W164_PUMA_SLICING_CHS_0 ';
                              'W164_PUMA_SLICING_CHS_0 ';
                              'W164_PUMA_SLICING_CHS_0 ';
                              'W164_PUMA_SLICING_CHS_0 ';
                              'W164_PUMA_SLICING_CHS_0 ']);
    elseif strcmp(corName, 'CVS')
        fnMeasMain = cellstr(['W164_PUMA_SLICING_CVS_-6';
                              'W164_PUMA_SLICING_CVS_-4';
                              'W164_PUMA_SLICING_CVS_-2';
                              'W164_PUMA_SLICING_CVS_0 ';
                              'W164_PUMA_SLICING_CVS_2 ';
                              'W164_PUMA_SLICING_CVS_4 ';
                              'W164_PUMA_SLICING_CVS_6 ']);
        fnMeasBkgr = cellstr(['W164_PUMA_SLICING_CVS_0 ';
                              'W164_PUMA_SLICING_CVS_0 ';
                              'W164_PUMA_SLICING_CVS_0 ';
                              'W164_PUMA_SLICING_CVS_0 ';
                              'W164_PUMA_SLICING_CVS_0 ';
                              'W164_PUMA_SLICING_CVS_0 ';
                              'W164_PUMA_SLICING_CVS_0 ']);

    end        

end