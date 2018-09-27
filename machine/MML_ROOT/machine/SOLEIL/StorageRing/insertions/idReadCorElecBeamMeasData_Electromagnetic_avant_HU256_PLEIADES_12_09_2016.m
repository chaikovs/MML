function [fnMeasMain, fnMeasBkgr, vCurVals] = idReadCorElecBeamMeasData_Electromagnetic(idName, gap, corName)

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
%   - APPLE 2 undulators:
%         - HU80 PLEIADES
%         - HU80 TEMPO
%         - HU80 SEXTANTS (Ex- MICROFOCUS)
%         - HU60 CASSIOPEE
%         - HU60 ANTARES
%         - HU52 DEIMOS
%         - HU52 LUCIA
%         - HU44 TEMPO
%         - HU44 SEXTANTS (Ex- MICROFOCUS)
%         - HU36 SIRIUS
%         - HU42 HERMES
%         - HU64 HERMES
%   - Electomagnetic undulators:
%         - HU256 CASSIOPEE
%         - HU256 PLEIADES
%         - HU256 ANTARES
%         - HU640 DESIRS
%% Press CTRL-UP or CTRL-DOWN to sweep undulators


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ELECTRO-MAGNETIC UNDULATORS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strncmp(idName, 'HU256', 5)
%% HU256 CASSIOPEE
    if strcmp(idName, 'HU256_CASSIOPEE')
        %vCurVals = [-10, -5, 0, 5, 10];
        
        if strcmp(corName, 'CHE')
            vCurVals = [-2 -1, 0, 1, 2];

            fnMeasMain = cellstr(['HU256_CASSIOPEE_Bzc1_m2A_2006-10-13_14-33-23            '; 
                                  'HU256_CASSIOPEE_Bzc1_m1A_2006-10-13_14-32-47            '; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Bzc1_1A_2006-10-13_14-32-06             '; 
                                  'HU256_CASSIOPEE_Bzc1_2A_2006-10-13_14-31-44             ']);                                  
            fnMeasBkgr = cellstr(['HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06']);
        elseif strcmp(corName, 'CVE')
            vCurVals = [-6, -3, 0, 3, 6];

            fnMeasMain = cellstr(['HU256_CASSIOPEE_Bxc1_m6A_2006-10-13_14-38-58            '; 
                                  'HU256_CASSIOPEE_Bxc1_m3A_2006-10-13_14-38-37            '; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Bxc1_3A_2006-10-13_14-37-06             '; 
                                  'HU256_CASSIOPEE_Bxc1_6A_2006-10-13_14-37-49             ']);
            fnMeasBkgr = cellstr(['HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06']);
        elseif strcmp(corName, 'CHS')
            vCurVals = [-2, -1, 0, 1, 2];

            fnMeasMain = cellstr(['HU256_CASSIOPEE_Bzc27_m2A_2006-10-13_14-36-00           '; 
                                  'HU256_CASSIOPEE_Bzc27_m1A_2006-10-13_14-35-00           '; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Bzc27_1A_2006-10-13_14-34-11            '; 
                                  'HU256_CASSIOPEE_Bzc27_2A_2006-10-13_14-34-33            ']);
            fnMeasBkgr = cellstr(['HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06']);
        elseif strcmp(corName, 'CVS')
            vCurVals = [-6, -3, 0, 3, 6];

            fnMeasMain = cellstr(['HU256_CASSIOPEE_Bxc28_m6A_2006-10-13_14-40-51           '; 
                                  'HU256_CASSIOPEE_Bxc28_m3A_2006-10-13_14-40-30           '; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Bxc28_3A_2006-10-13_14-39-46            '; 
                                  'HU256_CASSIOPEE_Bxc28_6A_2006-10-13_14-40-07            ']);
            fnMeasBkgr = cellstr(['HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06'; 
                                  'HU256_CASSIOPEE_Reference_correctors_2006-10-13_14-31-06']);
        end
%% HU256 PLEIADES
    elseif (strcmp(idName, 'HU256_PLEIADES'))

        if strcmp(corName, 'CHE')
			vCurVals = [-2, -1, 0, 1, 2];
			fnMeasMain = cellstr([	'HU256_PLEIADES_CHE_m2_2007-04-27_11-35-38   ';
									'HU256_PLEIADES_CHE_m1_2007-04-27_11-35-54   ';
									'HU256_PLEIADES_Reference_2007-04-27_11-35-23';
									'HU256_PLEIADES_CHE_1_2007-04-27_11-36-10    ';
									'HU256_PLEIADES_CHE_2_2007-04-27_11-36-26    ']);
			fnMeasBkgr = cellstr([	'HU256_PLEIADES_Reference_2007-04-27_11-35-23';
									'HU256_PLEIADES_Reference_2007-04-27_11-35-23';
									'HU256_PLEIADES_Reference_2007-04-27_11-35-23';
									'HU256_PLEIADES_Reference_2007-04-27_11-35-23';
									'HU256_PLEIADES_Reference_2007-04-27_11-35-23']);
		elseif strcmp(corName, 'CHS')
			vCurVals = [-2, -1, 0, 1, 2];
			fnMeasMain = cellstr([	'HU256_PLEIADES_CHS_m2_2007-04-27_11-36-58   ';
									'HU256_PLEIADES_CHS_m1_2007-04-27_11-37-14   ';
									'HU256_PLEIADES_Reference_2007-04-27_11-36-42';
									'HU256_PLEIADES_CHS_1_2007-04-27_11-37-30    ';
									'HU256_PLEIADES_CHS_2_2007-04-27_11-37-46    ']);
			fnMeasBkgr = cellstr([	'HU256_PLEIADES_Reference_2007-04-27_11-36-42';
									'HU256_PLEIADES_Reference_2007-04-27_11-36-42';
									'HU256_PLEIADES_Reference_2007-04-27_11-36-42';
									'HU256_PLEIADES_Reference_2007-04-27_11-36-42';
									'HU256_PLEIADES_Reference_2007-04-27_11-36-42']);
		elseif strcmp(corName, 'CVE')
			vCurVals = [-6, -3, 0, 3, 6];
			fnMeasMain = cellstr([	'HU256_PLEIADES_CVE_m6_2007-04-27_11-38-18   ';
									'HU256_PLEIADES_CVE_m3_2007-04-27_11-38-34   ';
									'HU256_PLEIADES_Reference_2007-04-27_11-38-02';
									'HU256_PLEIADES_CVE_3_2007-04-27_11-38-50    ';
									'HU256_PLEIADES_CVE_6_2007-04-27_11-39-06    ']);
			fnMeasBkgr = cellstr([	'HU256_PLEIADES_Reference_2007-04-27_11-38-02';
									'HU256_PLEIADES_Reference_2007-04-27_11-38-02';
									'HU256_PLEIADES_Reference_2007-04-27_11-38-02';
									'HU256_PLEIADES_Reference_2007-04-27_11-38-02';
									'HU256_PLEIADES_Reference_2007-04-27_11-38-02']);
		elseif strcmp(corName, 'CVS')
			vCurVals = [-6, -3, 0, 3, 6];
			fnMeasMain = cellstr([	'HU256_PLEIADES_CVS_m6_2007-04-27_11-39-37   ';
									'HU256_PLEIADES_CVS_m3_2007-04-27_11-39-53   ';
									'HU256_PLEIADES_Reference_2007-04-27_11-39-21';
									'HU256_PLEIADES_CVS_3_2007-04-27_11-40-08    ';
									'HU256_PLEIADES_CVS_6_2007-04-27_11-40-24    ']);
			fnMeasBkgr = cellstr([	'HU256_PLEIADES_Reference_2007-04-27_11-39-21';
									'HU256_PLEIADES_Reference_2007-04-27_11-39-21';
									'HU256_PLEIADES_Reference_2007-04-27_11-39-21';
									'HU256_PLEIADES_Reference_2007-04-27_11-39-21';
									'HU256_PLEIADES_Reference_2007-04-27_11-39-21']);
        end
        
        
       
        
        
    % end of HU256_PLEIADES
        
%% HU256 ANTARES
    elseif strcmp(idName, 'HU256_ANTARES')

        if strcmp(corName, 'CHE')
            vCurVals = [-2, -1, 0, 1, 2];
            fnMeasMain = cellstr(['HU256_ANTARES_Efficiency_he-2_ve0_hs0_vs0_2012-01-22_23-03-17.mat';
                                  'HU256_ANTARES_Efficiency_he-1_ve0_hs0_vs0_2012-01-22_23-03-29.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-03-40.mat ';
                                  'HU256_ANTARES_Efficiency_he1_ve0_hs0_vs0_2012-01-22_23-03-53.mat ';
                                  'HU256_ANTARES_Efficiency_he2_ve0_hs0_vs0_2012-01-22_23-04-04.mat ']);
            fnMeasBkgr = cellstr(['HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-03-04.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-03-04.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-03-40.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-03-40.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-03-40.mat']);
        elseif strcmp(corName, 'CVE')
            vCurVals = [-6, -3, 0, 3, 6];
            fnMeasMain = cellstr(['HU256_ANTARES_Efficiency_he0_ve-6_hs0_vs0_2012-01-22_23-04-33.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve-3_hs0_vs0_2012-01-22_23-04-46.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-05-00.mat ';
                                  'HU256_ANTARES_Efficiency_he0_ve3_hs0_vs0_2012-01-22_23-05-14.mat ';
                                  'HU256_ANTARES_Efficiency_he0_ve6_hs0_vs0_2012-01-22_23-05-29.mat ']);
            fnMeasBkgr = cellstr(['HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-04-16.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-04-16.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-05-00.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-05-00.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-05-00.mat']);
        elseif strcmp(corName, 'CHS')
            vCurVals = [-2, -1, 0, 1, 2];
            fnMeasMain = cellstr(['HU256_ANTARES_Efficiency_he0_ve0_hs-2_vs0_2012-01-22_23-05-56.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs-1_vs0_2012-01-22_23-06-08.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-06-18.mat ';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs1_vs0_2012-01-22_23-06-29.mat ';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs2_vs0_2012-01-22_23-06-41.mat ']);
            fnMeasBkgr = cellstr(['HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-05-44.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-05-44.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-06-18.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-06-18.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-06-18.mat']);
        elseif strcmp(corName, 'CVS')
            vCurVals = [-6, -3, 0, 3, 6];
            fnMeasMain = cellstr(['HU256_ANTARES_Efficiency_he0_ve0_hs0_vs-6_2012-01-22_23-07-10.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs-3_2012-01-22_23-07-23.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-07-37.mat ';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs3_2012-01-22_23-07-51.mat ';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs6_2012-01-22_23-08-06.mat ']);
            fnMeasBkgr = cellstr(['HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-06-54.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-06-54.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-07-37.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-07-37.mat';
                                  'HU256_ANTARES_Efficiency_he0_ve0_hs0_vs0_2012-01-22_23-07-37.mat']);
        end
        % end of HU256_ANTARES
    end % end HU256

elseif strncmp(idName, 'HU640', 5)
%% HU640 DESIRS
    if strcmp(idName, 'HU640_DESIRS')
        vCurVals = [-4,-2, 0, 2, 4];
        if strcmp(corName, 'CVE')

            fnMeasMain = cellstr(['HU640_Corr4_m4A';
                                  'HU640_Corr4_m2A'; 
                                  'HU640_Corr4_00A';
                                  'HU640_Corr4_p2A'
                                  'HU640_Corr4_p4A']);                                  
            fnMeasBkgr = cellstr(['HU640_Corr4_00A';
                                  'HU640_Corr4_00A';
                                  'HU640_Corr4_00A';
                                  'HU640_Corr4_00A';
                                  'HU640_Corr4_00A']);
        elseif strcmp(corName, 'CHE')

            fnMeasMain = cellstr(['HU640_Corr2_m4A';
                                  'HU640_Corr2_m2A'; 
                                  'HU640_Corr2_00A';
                                  'HU640_Corr2_p2A'
                                  'HU640_Corr2_p4A']);                                  
            fnMeasBkgr = cellstr(['HU640_Corr2_00A';
                                  'HU640_Corr2_00A';
                                  'HU640_Corr2_00A';
                                  'HU640_Corr2_00A';
                                  'HU640_Corr2_00A']);
        elseif strcmp(corName, 'CVS')

            fnMeasMain = cellstr(['HU640_Corr3_m4A';
                                  'HU640_Corr3_m2A'; 
                                  'HU640_Corr3_00A';
                                  'HU640_Corr3_p2A'
                                  'HU640_Corr3_p4A']);                                  
            fnMeasBkgr = cellstr(['HU640_Corr3_00A';
                                  'HU640_Corr3_00A';
                                  'HU640_Corr3_00A';
                                  'HU640_Corr3_00A';
                                  'HU640_Corr3_00A']);
        elseif strcmp(corName, 'CHS')

            fnMeasMain = cellstr(['HU640_Corr1_m4A';
                                  'HU640_Corr1_m2A'; 
                                  'HU640_Corr1_00A';
                                  'HU640_Corr1_p2A'
                                  'HU640_Corr1_p4A']);                                  
            fnMeasBkgr = cellstr(['HU640_Corr1_00A';
                                  'HU640_Corr1_00A';
                                  'HU640_Corr1_00A';
                                  'HU640_Corr1_00A';
                                  'HU640_Corr1_00A']);
        end
    end % HU640_DESIRS
end