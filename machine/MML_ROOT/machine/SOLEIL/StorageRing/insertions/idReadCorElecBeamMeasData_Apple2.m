function [fnMeasMain, fnMeasBkgr, vCurVals] = idReadCorElecBeamMeasData_Apple2(idName, gap, corName)

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

   
%%%%%%%%%%%%%%%%%%%%%%%%
%% APPLE 2 UNDULATORS %%
%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU80_PLEIADES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(idName, 'HU80_PLEIADES')
    vCurVals = [-10, -5, 0, 5, 10];

    if(gap < 0.5*(15.5+ 16))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G155_he-10_ve0_hs0_vs0_2013-01-25_08-00-47.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he-5_ve0_hs0_vs0_2013-01-25_08-01-03.mat ';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-01-19.mat  ';
                                  'Efficiency_HU80_PLEIADES_G155_he5_ve0_hs0_vs0_2013-01-25_08-01-35.mat  ';
                                  'Efficiency_HU80_PLEIADES_G155_he10_ve0_hs0_vs0_2013-01-25_08-01-51.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-00-30.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-00-30.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-01-19.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-01-19.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-01-19.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G155_he0_ve-10_hs0_vs0_2013-01-25_08-02-24.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve-5_hs0_vs0_2013-01-25_08-02-40.mat ';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-02-56.mat  ';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve5_hs0_vs0_2013-01-25_08-03-12.mat  ';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve10_hs0_vs0_2013-01-25_08-03-28.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-02-08.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-02-08.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-02-56.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-02-56.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-02-56.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G155_he0_ve0_hs-10_vs0_2013-01-25_08-04-01.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs-5_vs0_2013-01-25_08-04-17.mat ';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-04-33.mat  ';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs5_vs0_2013-01-25_08-04-50.mat  ';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs10_vs0_2013-01-25_08-05-06.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-03-45.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-03-45.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-04-33.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-04-33.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-04-33.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs-10_2013-01-25_08-05-38.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs-5_2013-01-25_08-05-54.mat ';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-06-11.mat  ';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs5_2013-01-25_08-06-27.mat  ';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs10_2013-01-25_08-06-43.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-05-22.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-05-22.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-06-11.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-06-11.mat';
                                  'Efficiency_HU80_PLEIADES_G155_he0_ve0_hs0_vs0_2013-01-25_08-06-11.mat']);
        end
    elseif(gap < 0.5*(16+ 18))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G160_he-10_ve0_hs0_vs0_2013-01-25_08-07-28.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he-5_ve0_hs0_vs0_2013-01-25_08-07-44.mat ';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-08-01.mat  ';
                                  'Efficiency_HU80_PLEIADES_G160_he5_ve0_hs0_vs0_2013-01-25_08-08-17.mat  ';
                                  'Efficiency_HU80_PLEIADES_G160_he10_ve0_hs0_vs0_2013-01-25_08-08-33.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-07-12.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-07-12.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-08-01.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-08-01.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-08-01.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G160_he0_ve-10_hs0_vs0_2013-01-25_08-09-05.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve-5_hs0_vs0_2013-01-25_08-09-21.mat ';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-09-38.mat  ';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve5_hs0_vs0_2013-01-25_08-09-54.mat  ';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve10_hs0_vs0_2013-01-25_08-10-10.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-08-49.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-08-49.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-09-38.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-09-38.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-09-38.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G160_he0_ve0_hs-10_vs0_2013-01-25_08-10-42.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs-5_vs0_2013-01-25_08-10-59.mat ';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-11-15.mat  ';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs5_vs0_2013-01-25_08-11-31.mat  ';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs10_vs0_2013-01-25_08-11-47.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-10-26.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-10-26.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-11-15.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-11-15.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-11-15.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs-10_2013-01-25_08-12-20.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs-5_2013-01-25_08-12-36.mat ';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-12-52.mat  ';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs5_2013-01-25_08-13-09.mat  ';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs10_2013-01-25_08-13-25.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-12-04.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-12-04.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-12-52.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-12-52.mat';
                                  'Efficiency_HU80_PLEIADES_G160_he0_ve0_hs0_vs0_2013-01-25_08-12-52.mat']);
        end
    elseif(gap < 0.5*(18+ 20))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G180_he-10_ve0_hs0_vs0_2013-01-25_08-14-09.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he-5_ve0_hs0_vs0_2013-01-25_08-14-25.mat ';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-14-42.mat  ';
                                  'Efficiency_HU80_PLEIADES_G180_he5_ve0_hs0_vs0_2013-01-25_08-14-58.mat  ';
                                  'Efficiency_HU80_PLEIADES_G180_he10_ve0_hs0_vs0_2013-01-25_08-15-14.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-13-53.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-13-53.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-14-42.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-14-42.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-14-42.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G180_he0_ve-10_hs0_vs0_2013-01-25_08-15-47.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve-5_hs0_vs0_2013-01-25_08-16-03.mat ';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-16-19.mat  ';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve5_hs0_vs0_2013-01-25_08-16-36.mat  ';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve10_hs0_vs0_2013-01-25_08-16-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-15-30.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-15-30.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-16-19.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-16-19.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-16-19.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G180_he0_ve0_hs-10_vs0_2013-01-25_08-17-25.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs-5_vs0_2013-01-25_08-17-41.mat ';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-17-57.mat  ';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs5_vs0_2013-01-25_08-18-14.mat  ';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs10_vs0_2013-01-25_08-18-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-17-08.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-17-08.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-17-57.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-17-57.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-17-57.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs-10_2013-01-25_08-19-03.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs-5_2013-01-25_08-19-19.mat ';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-19-35.mat  ';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs5_2013-01-25_08-19-51.mat  ';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs10_2013-01-25_08-20-07.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-18-47.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-18-47.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-19-35.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-19-35.mat';
                                  'Efficiency_HU80_PLEIADES_G180_he0_ve0_hs0_vs0_2013-01-25_08-19-35.mat']);
        end
    elseif(gap < 0.5*(20+ 22))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G200_he-10_ve0_hs0_vs0_2013-01-25_08-20-55.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he-5_ve0_hs0_vs0_2013-01-25_08-21-11.mat ';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-21-28.mat  ';
                                  'Efficiency_HU80_PLEIADES_G200_he5_ve0_hs0_vs0_2013-01-25_08-21-44.mat  ';
                                  'Efficiency_HU80_PLEIADES_G200_he10_ve0_hs0_vs0_2013-01-25_08-22-00.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-20-39.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-20-39.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-21-28.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-21-28.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-21-28.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G200_he0_ve-10_hs0_vs0_2013-01-25_08-22-32.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve-5_hs0_vs0_2013-01-25_08-22-48.mat ';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-23-05.mat  ';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve5_hs0_vs0_2013-01-25_08-23-21.mat  ';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve10_hs0_vs0_2013-01-25_08-23-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-22-16.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-22-16.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-23-05.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-23-05.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-23-05.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G200_he0_ve0_hs-10_vs0_2013-01-25_08-24-09.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs-5_vs0_2013-01-25_08-24-25.mat ';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-24-41.mat  ';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs5_vs0_2013-01-25_08-24-58.mat  ';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs10_vs0_2013-01-25_08-25-14.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-23-53.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-23-53.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-24-41.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-24-41.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-24-41.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs-10_2013-01-25_08-25-46.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs-5_2013-01-25_08-26-02.mat ';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-26-19.mat  ';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs5_2013-01-25_08-26-35.mat  ';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs10_2013-01-25_08-26-51.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-25-30.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-25-30.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-26-19.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-26-19.mat';
                                  'Efficiency_HU80_PLEIADES_G200_he0_ve0_hs0_vs0_2013-01-25_08-26-19.mat']);
        end
    elseif(gap < 0.5*(22+ 24))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G220_he-10_ve0_hs0_vs0_2013-01-25_08-27-35.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he-5_ve0_hs0_vs0_2013-01-25_08-27-52.mat ';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-28-08.mat  ';
                                  'Efficiency_HU80_PLEIADES_G220_he5_ve0_hs0_vs0_2013-01-25_08-28-24.mat  ';
                                  'Efficiency_HU80_PLEIADES_G220_he10_ve0_hs0_vs0_2013-01-25_08-28-40.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-27-19.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-27-19.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-28-08.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-28-08.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-28-08.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G220_he0_ve-10_hs0_vs0_2013-01-25_08-29-12.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve-5_hs0_vs0_2013-01-25_08-29-29.mat ';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-29-45.mat  ';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve5_hs0_vs0_2013-01-25_08-30-01.mat  ';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve10_hs0_vs0_2013-01-25_08-30-17.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-28-56.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-28-56.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-29-45.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-29-45.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-29-45.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G220_he0_ve0_hs-10_vs0_2013-01-25_08-30-49.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs-5_vs0_2013-01-25_08-31-05.mat ';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-31-22.mat  ';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs5_vs0_2013-01-25_08-31-38.mat  ';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs10_vs0_2013-01-25_08-31-54.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-30-33.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-30-33.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-31-22.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-31-22.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-31-22.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs-10_2013-01-25_08-32-26.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs-5_2013-01-25_08-32-42.mat ';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-32-59.mat  ';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs5_2013-01-25_08-33-15.mat  ';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs10_2013-01-25_08-33-31.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-32-10.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-32-10.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-32-59.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-32-59.mat';
                                  'Efficiency_HU80_PLEIADES_G220_he0_ve0_hs0_vs0_2013-01-25_08-32-59.mat']);
        end
    elseif(gap < 0.5*(24+ 26))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G240_he-10_ve0_hs0_vs0_2013-01-25_08-34-16.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he-5_ve0_hs0_vs0_2013-01-25_08-34-32.mat ';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-34-48.mat  ';
                                  'Efficiency_HU80_PLEIADES_G240_he5_ve0_hs0_vs0_2013-01-25_08-35-04.mat  ';
                                  'Efficiency_HU80_PLEIADES_G240_he10_ve0_hs0_vs0_2013-01-25_08-35-21.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-34-00.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-34-00.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-34-48.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-34-48.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-34-48.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G240_he0_ve-10_hs0_vs0_2013-01-25_08-35-53.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve-5_hs0_vs0_2013-01-25_08-36-09.mat ';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-36-25.mat  ';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve5_hs0_vs0_2013-01-25_08-36-41.mat  ';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve10_hs0_vs0_2013-01-25_08-36-58.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-35-37.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-35-37.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-36-25.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-36-25.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-36-25.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G240_he0_ve0_hs-10_vs0_2013-01-25_08-37-30.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs-5_vs0_2013-01-25_08-37-46.mat ';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-38-02.mat  ';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs5_vs0_2013-01-25_08-38-19.mat  ';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs10_vs0_2013-01-25_08-38-35.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-37-14.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-37-14.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-38-02.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-38-02.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-38-02.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs-10_2013-01-25_08-39-07.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs-5_2013-01-25_08-39-23.mat ';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-39-39.mat  ';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs5_2013-01-25_08-39-55.mat  ';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs10_2013-01-25_08-40-12.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-38-51.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-38-51.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-39-39.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-39-39.mat';
                                  'Efficiency_HU80_PLEIADES_G240_he0_ve0_hs0_vs0_2013-01-25_08-39-39.mat']);
        end
    elseif(gap < 0.5*(26+ 30))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G260_he-10_ve0_hs0_vs0_2013-01-25_08-40-56.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he-5_ve0_hs0_vs0_2013-01-25_08-41-12.mat ';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-41-29.mat  ';
                                  'Efficiency_HU80_PLEIADES_G260_he5_ve0_hs0_vs0_2013-01-25_08-41-45.mat  ';
                                  'Efficiency_HU80_PLEIADES_G260_he10_ve0_hs0_vs0_2013-01-25_08-42-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-40-40.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-40-40.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-41-29.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-41-29.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-41-29.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G260_he0_ve-10_hs0_vs0_2013-01-25_08-42-33.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve-5_hs0_vs0_2013-01-25_08-42-49.mat ';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-43-06.mat  ';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve5_hs0_vs0_2013-01-25_08-43-22.mat  ';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve10_hs0_vs0_2013-01-25_08-43-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-42-17.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-42-17.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-43-06.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-43-06.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-43-06.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G260_he0_ve0_hs-10_vs0_2013-01-25_08-44-10.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs-5_vs0_2013-01-25_08-44-27.mat ';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-44-43.mat  ';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs5_vs0_2013-01-25_08-44-59.mat  ';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs10_vs0_2013-01-25_08-45-15.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-43-54.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-43-54.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-44-43.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-44-43.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-44-43.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs-10_2013-01-25_08-45-47.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs-5_2013-01-25_08-46-03.mat ';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-46-20.mat  ';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs5_2013-01-25_08-46-36.mat  ';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs10_2013-01-25_08-46-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-45-31.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-45-31.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-46-20.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-46-20.mat';
                                  'Efficiency_HU80_PLEIADES_G260_he0_ve0_hs0_vs0_2013-01-25_08-46-20.mat']);
        end
    elseif(gap < 0.5*(30+ 35))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G300_he-10_ve0_hs0_vs0_2013-01-25_08-47-39.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he-5_ve0_hs0_vs0_2013-01-25_08-47-56.mat ';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-48-12.mat  ';
                                  'Efficiency_HU80_PLEIADES_G300_he5_ve0_hs0_vs0_2013-01-25_08-48-28.mat  ';
                                  'Efficiency_HU80_PLEIADES_G300_he10_ve0_hs0_vs0_2013-01-25_08-48-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-47-23.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-47-23.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-48-12.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-48-12.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-48-12.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G300_he0_ve-10_hs0_vs0_2013-01-25_08-49-16.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve-5_hs0_vs0_2013-01-25_08-49-33.mat ';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-49-49.mat  ';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve5_hs0_vs0_2013-01-25_08-50-05.mat  ';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve10_hs0_vs0_2013-01-25_08-50-21.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-49-00.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-49-00.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-49-49.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-49-49.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-49-49.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G300_he0_ve0_hs-10_vs0_2013-01-25_08-50-53.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs-5_vs0_2013-01-25_08-51-10.mat ';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-51-26.mat  ';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs5_vs0_2013-01-25_08-51-42.mat  ';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs10_vs0_2013-01-25_08-51-58.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-50-37.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-50-37.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-51-26.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-51-26.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-51-26.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs-10_2013-01-25_08-52-31.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs-5_2013-01-25_08-52-47.mat ';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-53-03.mat  ';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs5_2013-01-25_08-53-19.mat  ';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs10_2013-01-25_08-53-36.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-52-15.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-52-15.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-53-03.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-53-03.mat';
                                  'Efficiency_HU80_PLEIADES_G300_he0_ve0_hs0_vs0_2013-01-25_08-53-03.mat']);
        end
    elseif(gap < 0.5*(35+ 40))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G350_he-10_ve0_hs0_vs0_2013-01-25_08-54-20.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he-5_ve0_hs0_vs0_2013-01-25_08-54-36.mat ';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-54-52.mat  ';
                                  'Efficiency_HU80_PLEIADES_G350_he5_ve0_hs0_vs0_2013-01-25_08-55-09.mat  ';
                                  'Efficiency_HU80_PLEIADES_G350_he10_ve0_hs0_vs0_2013-01-25_08-55-25.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-54-04.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-54-04.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-54-52.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-54-52.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-54-52.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G350_he0_ve-10_hs0_vs0_2013-01-25_08-55-57.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve-5_hs0_vs0_2013-01-25_08-56-14.mat ';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-56-30.mat  ';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve5_hs0_vs0_2013-01-25_08-56-46.mat  ';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve10_hs0_vs0_2013-01-25_08-57-02.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-55-41.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-55-41.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-56-30.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-56-30.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-56-30.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G350_he0_ve0_hs-10_vs0_2013-01-25_08-57-34.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs-5_vs0_2013-01-25_08-57-51.mat ';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-58-07.mat  ';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs5_vs0_2013-01-25_08-58-23.mat  ';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs10_vs0_2013-01-25_08-58-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-57-18.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-57-18.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-58-07.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-58-07.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-58-07.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs-10_2013-01-25_08-59-12.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs-5_2013-01-25_08-59-28.mat ';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-59-44.mat  ';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs5_2013-01-25_09-00-00.mat  ';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs10_2013-01-25_09-00-16.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-58-55.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-58-55.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-59-44.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-59-44.mat';
                                  'Efficiency_HU80_PLEIADES_G350_he0_ve0_hs0_vs0_2013-01-25_08-59-44.mat']);
        end
    elseif(gap < 0.5*(40+ 50))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G400_he-10_ve0_hs0_vs0_2013-01-25_09-01-01.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he-5_ve0_hs0_vs0_2013-01-25_09-01-17.mat ';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-01-34.mat  ';
                                  'Efficiency_HU80_PLEIADES_G400_he5_ve0_hs0_vs0_2013-01-25_09-01-50.mat  ';
                                  'Efficiency_HU80_PLEIADES_G400_he10_ve0_hs0_vs0_2013-01-25_09-02-06.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-00-45.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-00-45.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-01-34.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-01-34.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-01-34.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G400_he0_ve-10_hs0_vs0_2013-01-25_09-02-39.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve-5_hs0_vs0_2013-01-25_09-02-55.mat ';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-03-11.mat  ';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve5_hs0_vs0_2013-01-25_09-03-27.mat  ';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve10_hs0_vs0_2013-01-25_09-03-43.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-02-22.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-02-22.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-03-11.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-03-11.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-03-11.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G400_he0_ve0_hs-10_vs0_2013-01-25_09-04-16.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs-5_vs0_2013-01-25_09-04-32.mat ';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-04-48.mat  ';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs5_vs0_2013-01-25_09-05-04.mat  ';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs10_vs0_2013-01-25_09-05-21.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-04-00.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-04-00.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-04-48.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-04-48.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-04-48.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs-10_2013-01-25_09-05-53.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs-5_2013-01-25_09-06-09.mat ';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-06-25.mat  ';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs5_2013-01-25_09-06-41.mat  ';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs10_2013-01-25_09-06-58.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-05-37.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-05-37.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-06-25.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-06-25.mat';
                                  'Efficiency_HU80_PLEIADES_G400_he0_ve0_hs0_vs0_2013-01-25_09-06-25.mat']);
        end
    elseif(gap < 0.5*(50+ 60))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G500_he-10_ve0_hs0_vs0_2013-01-25_09-07-45.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he-5_ve0_hs0_vs0_2013-01-25_09-08-02.mat ';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-08-18.mat  ';
                                  'Efficiency_HU80_PLEIADES_G500_he5_ve0_hs0_vs0_2013-01-25_09-08-34.mat  ';
                                  'Efficiency_HU80_PLEIADES_G500_he10_ve0_hs0_vs0_2013-01-25_09-08-50.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-07-29.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-07-29.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-08-18.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-08-18.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-08-18.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G500_he0_ve-10_hs0_vs0_2013-01-25_09-09-22.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve-5_hs0_vs0_2013-01-25_09-09-39.mat ';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-09-55.mat  ';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve5_hs0_vs0_2013-01-25_09-10-11.mat  ';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve10_hs0_vs0_2013-01-25_09-10-27.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-09-06.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-09-06.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-09-55.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-09-55.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-09-55.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G500_he0_ve0_hs-10_vs0_2013-01-25_09-11-00.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs-5_vs0_2013-01-25_09-11-16.mat ';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-11-32.mat  ';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs5_vs0_2013-01-25_09-11-48.mat  ';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs10_vs0_2013-01-25_09-12-04.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-10-44.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-10-44.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-11-32.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-11-32.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-11-32.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs-10_2013-01-25_09-12-37.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs-5_2013-01-25_09-12-53.mat ';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-13-09.mat  ';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs5_2013-01-25_09-13-25.mat  ';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs10_2013-01-25_09-13-41.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-12-20.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-12-20.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-13-09.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-13-09.mat';
                                  'Efficiency_HU80_PLEIADES_G500_he0_ve0_hs0_vs0_2013-01-25_09-13-09.mat']);
        end
    elseif(gap < 0.5*(60+ 70))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G600_he-10_ve0_hs0_vs0_2013-01-25_09-14-29.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he-5_ve0_hs0_vs0_2013-01-25_09-14-45.mat ';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-15-01.mat  ';
                                  'Efficiency_HU80_PLEIADES_G600_he5_ve0_hs0_vs0_2013-01-25_09-15-18.mat  ';
                                  'Efficiency_HU80_PLEIADES_G600_he10_ve0_hs0_vs0_2013-01-25_09-15-34.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-14-13.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-14-13.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-15-01.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-15-01.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-15-01.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G600_he0_ve-10_hs0_vs0_2013-01-25_09-16-06.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve-5_hs0_vs0_2013-01-25_09-16-23.mat ';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-16-39.mat  ';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve5_hs0_vs0_2013-01-25_09-16-55.mat  ';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve10_hs0_vs0_2013-01-25_09-17-12.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-15-50.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-15-50.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-16-39.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-16-39.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-16-39.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G600_he0_ve0_hs-10_vs0_2013-01-25_09-17-44.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs-5_vs0_2013-01-25_09-18-00.mat ';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-18-16.mat  ';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs5_vs0_2013-01-25_09-18-32.mat  ';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs10_vs0_2013-01-25_09-18-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-17-28.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-17-28.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-18-16.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-18-16.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-18-16.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs-10_2013-01-25_09-19-21.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs-5_2013-01-25_09-19-37.mat ';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-19-53.mat  ';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs5_2013-01-25_09-20-09.mat  ';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs10_2013-01-25_09-20-25.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-19-05.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-19-05.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-19-53.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-19-53.mat';
                                  'Efficiency_HU80_PLEIADES_G600_he0_ve0_hs0_vs0_2013-01-25_09-19-53.mat']);
        end
    elseif(gap < 0.5*(70+ 80))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G700_he-10_ve0_hs0_vs0_2013-01-25_09-21-13.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he-5_ve0_hs0_vs0_2013-01-25_09-21-29.mat ';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-21-45.mat  ';
                                  'Efficiency_HU80_PLEIADES_G700_he5_ve0_hs0_vs0_2013-01-25_09-22-02.mat  ';
                                  'Efficiency_HU80_PLEIADES_G700_he10_ve0_hs0_vs0_2013-01-25_09-22-18.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-20-57.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-20-57.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-21-45.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-21-45.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-21-45.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G700_he0_ve-10_hs0_vs0_2013-01-25_09-22-50.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve-5_hs0_vs0_2013-01-25_09-23-06.mat ';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-23-23.mat  ';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve5_hs0_vs0_2013-01-25_09-23-39.mat  ';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve10_hs0_vs0_2013-01-25_09-23-55.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-22-34.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-22-34.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-23-23.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-23-23.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-23-23.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G700_he0_ve0_hs-10_vs0_2013-01-25_09-24-27.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs-5_vs0_2013-01-25_09-24-43.mat ';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-25-00.mat  ';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs5_vs0_2013-01-25_09-25-16.mat  ';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs10_vs0_2013-01-25_09-25-32.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-24-11.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-24-11.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-25-00.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-25-00.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-25-00.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs-10_2013-01-25_09-26-04.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs-5_2013-01-25_09-26-21.mat ';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-26-37.mat  ';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs5_2013-01-25_09-26-53.mat  ';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs10_2013-01-25_09-27-09.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-25-48.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-25-48.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-26-37.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-26-37.mat';
                                  'Efficiency_HU80_PLEIADES_G700_he0_ve0_hs0_vs0_2013-01-25_09-26-37.mat']);
        end
    elseif(gap < 0.5*(80+ 90))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G800_he-10_ve0_hs0_vs0_2013-01-25_09-27-57.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he-5_ve0_hs0_vs0_2013-01-25_09-28-13.mat ';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-28-29.mat  ';
                                  'Efficiency_HU80_PLEIADES_G800_he5_ve0_hs0_vs0_2013-01-25_09-28-46.mat  ';
                                  'Efficiency_HU80_PLEIADES_G800_he10_ve0_hs0_vs0_2013-01-25_09-29-02.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-27-41.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-27-41.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-28-29.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-28-29.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-28-29.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G800_he0_ve-10_hs0_vs0_2013-01-25_09-29-34.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve-5_hs0_vs0_2013-01-25_09-29-50.mat ';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-30-07.mat  ';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve5_hs0_vs0_2013-01-25_09-30-23.mat  ';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve10_hs0_vs0_2013-01-25_09-30-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-29-18.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-29-18.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-30-07.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-30-07.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-30-07.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G800_he0_ve0_hs-10_vs0_2013-01-25_09-31-12.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs-5_vs0_2013-01-25_09-31-28.mat ';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-31-44.mat  ';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs5_vs0_2013-01-25_09-32-01.mat  ';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs10_vs0_2013-01-25_09-32-17.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-30-56.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-30-56.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-31-44.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-31-44.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-31-44.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs-10_2013-01-25_09-32-49.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs-5_2013-01-25_09-33-05.mat ';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-33-21.mat  ';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs5_2013-01-25_09-33-38.mat  ';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs10_2013-01-25_09-33-54.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-32-33.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-32-33.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-33-21.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-33-21.mat';
                                  'Efficiency_HU80_PLEIADES_G800_he0_ve0_hs0_vs0_2013-01-25_09-33-21.mat']);
        end
    elseif(gap < 0.5*(90+ 100))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G900_he-10_ve0_hs0_vs0_2013-01-25_09-34-42.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he-5_ve0_hs0_vs0_2013-01-25_09-34-58.mat ';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-35-14.mat  ';
                                  'Efficiency_HU80_PLEIADES_G900_he5_ve0_hs0_vs0_2013-01-25_09-35-31.mat  ';
                                  'Efficiency_HU80_PLEIADES_G900_he10_ve0_hs0_vs0_2013-01-25_09-35-47.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-34-25.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-34-25.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-35-14.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-35-14.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-35-14.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G900_he0_ve-10_hs0_vs0_2013-01-25_09-36-19.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve-5_hs0_vs0_2013-01-25_09-36-35.mat ';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-36-52.mat  ';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve5_hs0_vs0_2013-01-25_09-37-08.mat  ';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve10_hs0_vs0_2013-01-25_09-37-24.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-36-03.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-36-03.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-36-52.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-36-52.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-36-52.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G900_he0_ve0_hs-10_vs0_2013-01-25_09-37-56.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs-5_vs0_2013-01-25_09-38-12.mat ';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-38-28.mat  ';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs5_vs0_2013-01-25_09-38-45.mat  ';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs10_vs0_2013-01-25_09-39-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-37-40.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-37-40.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-38-28.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-38-28.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-38-28.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs-10_2013-01-25_09-39-33.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs-5_2013-01-25_09-39-49.mat ';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-40-05.mat  ';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs5_2013-01-25_09-40-21.mat  ';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs10_2013-01-25_09-40-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-39-17.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-39-17.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-40-05.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-40-05.mat';
                                  'Efficiency_HU80_PLEIADES_G900_he0_ve0_hs0_vs0_2013-01-25_09-40-05.mat']);
        end
    elseif(gap < 0.5*(100+ 120))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1000_he-10_ve0_hs0_vs0_2013-01-25_09-41-25.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he-5_ve0_hs0_vs0_2013-01-25_09-41-41.mat ';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-41-57.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1000_he5_ve0_hs0_vs0_2013-01-25_09-42-14.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1000_he10_ve0_hs0_vs0_2013-01-25_09-42-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-41-09.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-41-09.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-41-57.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-41-57.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-41-57.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1000_he0_ve-10_hs0_vs0_2013-01-25_09-43-02.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve-5_hs0_vs0_2013-01-25_09-43-18.mat ';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-43-34.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve5_hs0_vs0_2013-01-25_09-43-51.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve10_hs0_vs0_2013-01-25_09-44-07.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-42-46.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-42-46.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-43-34.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-43-34.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-43-34.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs-10_vs0_2013-01-25_09-44-39.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs-5_vs0_2013-01-25_09-44-55.mat ';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-45-11.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs5_vs0_2013-01-25_09-45-28.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs10_vs0_2013-01-25_09-45-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-44-23.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-44-23.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-45-11.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-45-11.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-45-11.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs-10_2013-01-25_09-46-16.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs-5_2013-01-25_09-46-33.mat ';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-46-49.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs5_2013-01-25_09-47-05.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs10_2013-01-25_09-47-21.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-46-00.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-46-00.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-46-49.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-46-49.mat';
                                  'Efficiency_HU80_PLEIADES_G1000_he0_ve0_hs0_vs0_2013-01-25_09-46-49.mat']);
        end
    elseif(gap < 0.5*(120+ 150))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1200_he-10_ve0_hs0_vs0_2013-01-25_09-48-11.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he-5_ve0_hs0_vs0_2013-01-25_09-48-28.mat ';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-48-44.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1200_he5_ve0_hs0_vs0_2013-01-25_09-49-00.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1200_he10_ve0_hs0_vs0_2013-01-25_09-49-16.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-47-55.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-47-55.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-48-44.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-48-44.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-48-44.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1200_he0_ve-10_hs0_vs0_2013-01-25_09-49-48.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve-5_hs0_vs0_2013-01-25_09-50-04.mat ';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-50-21.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve5_hs0_vs0_2013-01-25_09-50-37.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve10_hs0_vs0_2013-01-25_09-50-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-49-32.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-49-32.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-50-21.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-50-21.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-50-21.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs-10_vs0_2013-01-25_09-51-25.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs-5_vs0_2013-01-25_09-51-41.mat ';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-51-57.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs5_vs0_2013-01-25_09-52-14.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs10_vs0_2013-01-25_09-52-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-51-09.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-51-09.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-51-57.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-51-57.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-51-57.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs-10_2013-01-25_09-53-02.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs-5_2013-01-25_09-53-18.mat ';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-53-34.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs5_2013-01-25_09-53-51.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs10_2013-01-25_09-54-07.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-52-46.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-52-46.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-53-34.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-53-34.mat';
                                  'Efficiency_HU80_PLEIADES_G1200_he0_ve0_hs0_vs0_2013-01-25_09-53-34.mat']);
        end
    else	% Gap > 150

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1500_he-10_ve0_hs0_vs0_2013-01-25_09-54-57.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he-5_ve0_hs0_vs0_2013-01-25_09-55-13.mat ';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-55-30.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1500_he5_ve0_hs0_vs0_2013-01-25_09-55-46.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1500_he10_ve0_hs0_vs0_2013-01-25_09-56-02.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-54-41.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-54-41.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-55-30.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-55-30.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-55-30.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1500_he0_ve-10_hs0_vs0_2013-01-25_09-56-34.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve-5_hs0_vs0_2013-01-25_09-56-50.mat ';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-57-07.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve5_hs0_vs0_2013-01-25_09-57-23.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve10_hs0_vs0_2013-01-25_09-57-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-56-18.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-56-18.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-57-07.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-57-07.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-57-07.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs-10_vs0_2013-01-25_09-58-11.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs-5_vs0_2013-01-25_09-58-27.mat ';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-58-43.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs5_vs0_2013-01-25_09-58-59.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs10_vs0_2013-01-25_09-59-16.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-57-55.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-57-55.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-58-43.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-58-43.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-58-43.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs-10_2013-01-25_09-59-48.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs-5_2013-01-25_10-00-04.mat ';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_10-00-20.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs5_2013-01-25_10-00-36.mat  ';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs10_2013-01-25_10-00-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-59-32.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_09-59-32.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_10-00-20.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_10-00-20.mat';
                                  'Efficiency_HU80_PLEIADES_G1500_he0_ve0_hs0_vs0_2013-01-25_10-00-20.mat']);
        end

    end	% End of HU80_PLEIADES
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU80 TEMPO  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elseif strcmp(idName, 'HU80_TEMPO')
    vCurVals = [-10, -5, 0, 5, 10];
    %if (gap == 15.5)
    if (gap < 0.5*(15.5 + 20))
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
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C2G15_5_he0_ve-10_hs0_vs0_2006-10-01_13-30-20'; 
                                  'C2G15_5_he0_ve-5_hs0_vs0_2006-10-01_13-31-23 '; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-32-25  '; 
                                  'C2G15_5_he0_ve5_hs0_vs0_2006-10-01_13-33-29  '; 
                                  'C2G15_5_he0_ve10_hs0_vs0_2006-10-01_13-34-31 ']);
            fnMeasBkgr = cellstr(['C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-32-25'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-32-25'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-32-25'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-32-25'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-32-25']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C2G15_5_he0_ve0_hs-10_vs0_2006-10-01_13-36-42'; 
                                  'C2G15_5_he0_ve0_hs-5_vs0_2006-10-01_13-37-37 '; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-38-33  '; 
                                  'C2G15_5_he0_ve0_hs5_vs0_2006-10-01_13-39-27  '; 
                                  'C2G15_5_he0_ve0_hs10_vs0_2006-10-01_13-40-23 ']);
            fnMeasBkgr = cellstr(['C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-38-33'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-38-33'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-38-33'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-38-33'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-38-33']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C2G15_5_he0_ve0_hs0_vs-10_2006-10-01_13-42-36'; 
                                  'C2G15_5_he0_ve0_hs0_vs-5_2006-10-01_13-43-30 '; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-44-25  '; 
                                  'C2G15_5_he0_ve0_hs0_vs5_2006-10-01_13-45-23  '; 
                                  'C2G15_5_he0_ve0_hs0_vs10_2006-10-01_13-46-18 ']);
            fnMeasBkgr = cellstr(['C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-44-25'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-44-25'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-44-25'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-44-25'; 
                                  'C2G15_5_he0_ve0_hs0_vs0_2006-10-01_13-44-25']);
        end
    %elseif (gap == 20)
    elseif (gap < 0.5*(20 + 25))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C2G20_he-10_ve0_hs0_vs0_2006-10-01_13-58-32'; 
                                  'C2G20_he-5_ve0_hs0_vs0_2006-10-01_13-59-36 '; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-00-40  '; 
                                  'C2G20_he5_ve0_hs0_vs0_2006-10-01_14-01-42  '; 
                                  'C2G20_he10_ve0_hs0_vs0_2006-10-01_14-02-45 ']);
            fnMeasBkgr = cellstr(['C2G20_he0_ve0_hs0_vs0_2006-10-01_14-00-40'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-00-40'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-00-40'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-00-40'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-00-40']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C2G20_he0_ve-10_hs0_vs0_2006-10-01_14-04-58'; 
                                  'C2G20_he0_ve-5_hs0_vs0_2006-10-01_14-06-01 '; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-07-02  '; 
                                  'C2G20_he0_ve5_hs0_vs0_2006-10-01_14-08-06  '; 
                                  'C2G20_he0_ve10_hs0_vs0_2006-10-01_14-09-11 ']);
            fnMeasBkgr = cellstr(['C2G20_he0_ve0_hs0_vs0_2006-10-01_14-07-02'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-07-02'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-07-02'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-07-02'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-07-02']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C2G20_he0_ve0_hs-10_vs0_2006-10-01_14-11-25'; 
                                  'C2G20_he0_ve0_hs-5_vs0_2006-10-01_14-12-18 '; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-13-12  '; 
                                  'C2G20_he0_ve0_hs5_vs0_2006-10-01_14-14-10  '; 
                                  'C2G20_he0_ve0_hs10_vs0_2006-10-01_14-15-03 ']);
            fnMeasBkgr = cellstr(['C2G20_he0_ve0_hs0_vs0_2006-10-01_14-13-12'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-13-12'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-13-12'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-13-12'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-13-12']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C2G20_he0_ve0_hs0_vs-10_2006-10-01_14-17-13'; 
                                  'C2G20_he0_ve0_hs0_vs-5_2006-10-01_14-18-06 '; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-19-00  '; 
                                  'C2G20_he0_ve0_hs0_vs5_2006-10-01_14-19-55  '; 
                                  'C2G20_he0_ve0_hs0_vs10_2006-10-01_14-20-50 ']);
            fnMeasBkgr = cellstr(['C2G20_he0_ve0_hs0_vs0_2006-10-01_14-19-00'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-19-00'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-19-00'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-19-00'; 
                                  'C2G20_he0_ve0_hs0_vs0_2006-10-01_14-19-00']);
        end
    %elseif (gap == 25)
    elseif (gap < 0.5*(25 + 30))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C2G25_he-10_ve0_hs0_vs0_2006-10-01_14-24-13'; 
                                  'C2G25_he-5_ve0_hs0_vs0_2006-10-01_14-25-16 '; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-26-19  '; 
                                  'C2G25_he5_ve0_hs0_vs0_2006-10-01_14-27-21  '; 
                                  'C2G25_he10_ve0_hs0_vs0_2006-10-01_14-28-22 ']);
            fnMeasBkgr = cellstr(['C2G25_he0_ve0_hs0_vs0_2006-10-01_14-26-19'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-26-19'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-26-19'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-26-19'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-26-19']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C2G25_he0_ve-10_hs0_vs0_2006-10-01_14-30-36'; 
                                  'C2G25_he0_ve-5_hs0_vs0_2006-10-01_14-31-39 '; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-32-42  '; 
                                  'C2G25_he0_ve5_hs0_vs0_2006-10-01_14-33-45  '; 
                                  'C2G25_he0_ve10_hs0_vs0_2006-10-01_14-34-47 ']);
            fnMeasBkgr = cellstr(['C2G25_he0_ve0_hs0_vs0_2006-10-01_14-32-42'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-32-42'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-32-42'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-32-42'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-32-42']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C2G25_he0_ve0_hs-10_vs0_2006-10-01_14-36-56'; 
                                  'C2G25_he0_ve0_hs-5_vs0_2006-10-01_14-37-52 '; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-38-46  '; 
                                  'C2G25_he0_ve0_hs5_vs0_2006-10-01_14-39-43  '; 
                                  'C2G25_he0_ve0_hs10_vs0_2006-10-01_14-40-39 ']);
            fnMeasBkgr = cellstr(['C2G25_he0_ve0_hs0_vs0_2006-10-01_14-38-46'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-38-46'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-38-46'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-38-46'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-38-46']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C2G25_he0_ve0_hs0_vs-10_2006-10-01_14-42-52'; 
                                  'C2G25_he0_ve0_hs0_vs-5_2006-10-01_14-43-47 '; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-44-41  '; 
                                  'C2G25_he0_ve0_hs0_vs5_2006-10-01_14-45-33  '; 
                                  'C2G25_he0_ve0_hs0_vs10_2006-10-01_14-46-27 ']);
            fnMeasBkgr = cellstr(['C2G25_he0_ve0_hs0_vs0_2006-10-01_14-44-41'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-44-41'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-44-41'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-44-41'; 
                                  'C2G25_he0_ve0_hs0_vs0_2006-10-01_14-44-41']);
        end
    %elseif (gap == 30)
    elseif (gap < 0.5*(30 + 40))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C2G30_he-10_ve0_hs0_vs0_2006-10-01_14-49-26'; 
                                  'C2G30_he-5_ve0_hs0_vs0_2006-10-01_14-50-29 '; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_14-51-32  '; 
                                  'C2G30_he5_ve0_hs0_vs0_2006-10-01_14-52-36  '; 
                                  'C2G30_he10_ve0_hs0_vs0_2006-10-01_14-53-40 ']);
            fnMeasBkgr = cellstr(['C2G30_he0_ve0_hs0_vs0_2006-10-01_14-51-32'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_14-51-32'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_14-51-32'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_14-51-32'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_14-51-32']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C2G30_he0_ve-10_hs0_vs0_2006-10-01_14-55-58'; 
                                  'C2G30_he0_ve-5_hs0_vs0_2006-10-01_14-57-02 '; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_14-58-04  '; 
                                  'C2G30_he0_ve5_hs0_vs0_2006-10-01_14-59-08  '; 
                                  'C2G30_he0_ve10_hs0_vs0_2006-10-01_15-00-11 ']);
            fnMeasBkgr = cellstr(['C2G30_he0_ve0_hs0_vs0_2006-10-01_14-58-04'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_14-58-04'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_14-58-04'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_14-58-04'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_15-01-17']); %'C2G30_he0_ve0_hs0_vs0_2006-10-01_14-58-04']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C2G30_he0_ve0_hs-10_vs0_2006-10-01_15-02-20'; 
                                  'C2G30_he0_ve0_hs-5_vs0_2006-10-01_15-03-13 '; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_15-04-09  '; 
                                  'C2G30_he0_ve0_hs5_vs0_2006-10-01_15-05-07  '; 
                                  'C2G30_he0_ve0_hs10_vs0_2006-10-01_15-06-02 ']);
            fnMeasBkgr = cellstr(['C2G30_he0_ve0_hs0_vs0_2006-10-01_15-04-09'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_15-04-09'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_15-04-09'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_15-04-09'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_15-04-09']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C2G30_he0_ve0_hs0_vs-10_2006-10-01_15-08-12'; 
                                  'C2G30_he0_ve0_hs0_vs-5_2006-10-01_15-09-08 '; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_15-10-02  '; 
                                  'C2G30_he0_ve0_hs0_vs5_2006-10-01_15-10-55  '; 
                                  'C2G30_he0_ve0_hs0_vs10_2006-10-01_15-11-48 ']);
            fnMeasBkgr = cellstr(['C2G30_he0_ve0_hs0_vs0_2006-10-01_15-10-02'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_15-10-02'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_15-10-02'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_15-10-02'; 
                                  'C2G30_he0_ve0_hs0_vs0_2006-10-01_15-10-02']);
        end
    %elseif (gap == 40)
    elseif (gap < 0.5*(40 + 50))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C3G40_he-10_ve0_hs0_vs0_2006-10-06_07-54-22'; 
                                  'C3G40_he-5_ve0_hs0_vs0_2006-10-06_07-55-51 ';
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_07-57-24  ';
                                  'C3G40_he5_ve0_hs0_vs0_2006-10-06_07-58-26  ';
                                  'C3G40_he10_ve0_hs0_vs0_2006-10-06_07-59-30 ']);
            fnMeasBkgr = cellstr(['C3G40_he0_ve0_hs0_vs0_2006-10-06_07-52-40'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_07-52-40'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_07-57-24'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_07-57-24'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_07-57-24']);
        elseif strcmp(corName, 'CVE')
                            fnMeasMain = cellstr(['C3G40_he0_ve-10_hs0_vs0_2006-10-06_08-01-47';
                                  'C3G40_he0_ve-5_hs0_vs0_2006-10-06_08-02-49 ';
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-03-54  ';
                                  'C3G40_he0_ve5_hs0_vs0_2006-10-06_08-04-57  ';
                                  'C3G40_he0_ve10_hs0_vs0_2006-10-06_08-05-58 ']);
            fnMeasBkgr = cellstr(['C3G40_he0_ve0_hs0_vs0_2006-10-06_08-00-37'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-00-37'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-03-54'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-03-54'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-03-54']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C3G40_he0_ve0_hs-10_vs0_2006-10-06_08-08-07';
                                  'C3G40_he0_ve0_hs-5_vs0_2006-10-06_08-09-02 ';
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-09-58  ';
                                  'C3G40_he0_ve0_hs5_vs0_2006-10-06_08-10-57  ';
                                  'C3G40_he0_ve0_hs10_vs0_2006-10-06_08-11-51 ']);
             fnMeasBkgr = cellstr(['C3G40_he0_ve0_hs0_vs0_2006-10-06_08-07-03'; 
                                   'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-07-03'; 
                                   'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-09-58'; 
                                   'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-09-58'; 
                                   'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-09-58']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C3G40_he0_ve0_hs0_vs-10_2006-10-06_08-14-08';
                                  'C3G40_he0_ve0_hs0_vs-5_2006-10-06_08-15-02 ';
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-16-00  ';
                                  'C3G40_he0_ve0_hs0_vs5_2006-10-06_08-16-58  ';
                                  'C3G40_he0_ve0_hs0_vs10_2006-10-06_08-17-52 ']);
            fnMeasBkgr = cellstr(['C3G40_he0_ve0_hs0_vs0_2006-10-06_08-12-59'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-12-59'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-16-00'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-16-00'; 
                                  'C3G40_he0_ve0_hs0_vs0_2006-10-06_08-16-00']);
        end
    %elseif (gap == 50)
    elseif (gap < 0.5*(50 + 60))
         if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C3G50_he-10_ve0_hs0_vs0_2006-10-06_08-24-59';
                                  'C3G50_he-5_ve0_hs0_vs0_2006-10-06_08-25-29 ';
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-25-58  ';
                                  'C3G50_he5_ve0_hs0_vs0_2006-10-06_08-26-28  ';
                                  'C3G50_he10_ve0_hs0_vs0_2006-10-06_08-26-59 ']);
            fnMeasBkgr = cellstr(['C3G50_he0_ve0_hs0_vs0_2006-10-06_08-24-24'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-24-24'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-25-58'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-25-58'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-25-58']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C3G50_he0_ve-10_hs0_vs0_2006-10-06_08-28-09';
                                  'C3G50_he0_ve-5_hs0_vs0_2006-10-06_08-28-39 ';
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-29-08  ';
                                  'C3G50_he0_ve5_hs0_vs0_2006-10-06_08-29-38  ';
                                  'C3G50_he0_ve10_hs0_vs0_2006-10-06_08-30-09 ']);
            fnMeasBkgr = cellstr(['C3G50_he0_ve0_hs0_vs0_2006-10-06_08-27-33'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-27-33'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-29-08'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-29-08'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-29-08']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C3G50_he0_ve0_hs-10_vs0_2006-10-06_08-31-16';
                                  'C3G50_he0_ve0_hs-5_vs0_2006-10-06_08-31-37 ';
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-31-59  ';
                                  'C3G50_he0_ve0_hs5_vs0_2006-10-06_08-32-24  ';
                                  'C3G50_he0_ve0_hs10_vs0_2006-10-06_08-32-45 ']);
             fnMeasBkgr = cellstr(['C3G50_he0_ve0_hs0_vs0_2006-10-06_08-30-45'; 
                                   'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-30-45'; 
                                   'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-31-59'; 
                                   'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-31-59'; 
                                   'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-31-59']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C3G50_he0_ve0_hs0_vs-10_2006-10-06_08-33-53';
                                  'C3G50_he0_ve0_hs0_vs-5_2006-10-06_08-34-14 ';
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-34-35  ';
                                  'C3G50_he0_ve0_hs0_vs5_2006-10-06_08-35-00  ';
                                  'C3G50_he0_ve0_hs0_vs10_2006-10-06_08-35-22 ']);
            fnMeasBkgr = cellstr(['C3G50_he0_ve0_hs0_vs0_2006-10-06_08-33-19'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-33-19'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-34-35'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-34-35'; 
                                  'C3G50_he0_ve0_hs0_vs0_2006-10-06_08-34-35']);
        end
    %elseif (gap == 60)
    elseif (gap < 0.5*(60 + 80))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C3G60_he-10_ve0_hs0_vs0_2006-10-06_08-38-12';
                                  'C3G60_he-5_ve0_hs0_vs0_2006-10-06_08-38-42 ';
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-39-12  ';
                                  'C3G60_he5_ve0_hs0_vs0_2006-10-06_08-39-43  ';
                                  'C3G60_he10_ve0_hs0_vs0_2006-10-06_08-40-13 ']);
            fnMeasBkgr = cellstr(['C3G60_he0_ve0_hs0_vs0_2006-10-06_08-37-38'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-37-38'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-39-12'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-39-12'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-39-12']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C3G60_he0_ve-10_hs0_vs0_2006-10-06_08-41-23';
                                  'C3G60_he0_ve-5_hs0_vs0_2006-10-06_08-41-53 ';
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-42-21  ';
                                  'C3G60_he0_ve5_hs0_vs0_2006-10-06_08-42-51  ';
                                  'C3G60_he0_ve10_hs0_vs0_2006-10-06_08-43-21 ']);
            fnMeasBkgr = cellstr(['C3G60_he0_ve0_hs0_vs0_2006-10-06_08-40-48'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-40-48'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-42-21'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-42-21'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-42-21']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C3G60_he0_ve0_hs-10_vs0_2006-10-06_08-44-26';
                                  'C3G60_he0_ve0_hs-5_vs0_2006-10-06_08-44-47 ';
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-45-08  ';
                                  'C3G60_he0_ve0_hs5_vs0_2006-10-06_08-45-36  ';
                                  'C3G60_he0_ve0_hs10_vs0_2006-10-06_08-45-57 ']);
             fnMeasBkgr = cellstr(['C3G60_he0_ve0_hs0_vs0_2006-10-06_08-43-57'; 
                                   'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-43-57'; 
                                   'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-45-08'; 
                                   'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-45-08'; 
                                   'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-45-08']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C3G60_he0_ve0_hs0_vs-10_2006-10-06_08-47-00';
                                  'C3G60_he0_ve0_hs0_vs-5_2006-10-06_08-47-22 ';
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-47-42  ';
                                  'C3G60_he0_ve0_hs0_vs5_2006-10-06_08-48-08  ';
                                  'C3G60_he0_ve0_hs0_vs10_2006-10-06_08-48-30 ']);
            fnMeasBkgr = cellstr(['C3G60_he0_ve0_hs0_vs0_2006-10-06_08-46-26'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-46-26'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-47-42'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-47-42'; 
                                  'C3G60_he0_ve0_hs0_vs0_2006-10-06_08-47-42']);
        end
    %elseif (gap == 80)
    elseif (gap < 0.5*(80 + 110))
         if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C3G80_he-10_ve0_hs0_vs0_2006-10-06_09-07-47';
                                  'C3G80_he-5_ve0_hs0_vs0_2006-10-06_09-08-17 ';
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-08-47  ';
                                  'C3G80_he5_ve0_hs0_vs0_2006-10-06_09-09-17  ';
                                  'C3G80_he10_ve0_hs0_vs0_2006-10-06_09-09-47 ']);
            fnMeasBkgr = cellstr(['C3G80_he0_ve0_hs0_vs0_2006-10-06_09-07-09'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-07-09'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-08-47'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-08-47'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-08-47']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C3G80_he0_ve-10_hs0_vs0_2006-10-06_09-10-55';
                                  'C3G80_he0_ve-5_hs0_vs0_2006-10-06_09-11-25 ';
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-11-56  ';
                                  'C3G80_he0_ve5_hs0_vs0_2006-10-06_09-12-26  ';
                                  'C3G80_he0_ve10_hs0_vs0_2006-10-06_09-12-56 ']);
            fnMeasBkgr = cellstr(['C3G80_he0_ve0_hs0_vs0_2006-10-06_09-10-22'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-10-22'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-11-56'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-11-56'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-11-56']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C3G80_he0_ve0_hs-10_vs0_2006-10-06_09-14-03';
                                  'C3G80_he0_ve0_hs-5_vs0_2006-10-06_09-14-24 ';
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-14-45  ';
                                  'C3G80_he0_ve0_hs5_vs0_2006-10-06_09-15-09  ';
                                  'C3G80_he0_ve0_hs10_vs0_2006-10-06_09-15-32 ']);
             fnMeasBkgr = cellstr(['C3G80_he0_ve0_hs0_vs0_2006-10-06_09-13-32'; 
                                   'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-13-32'; 
                                   'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-14-45'; 
                                   'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-14-45'; 
                                   'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-14-45']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C3G80_he0_ve0_hs0_vs-10_2006-10-06_09-16-42';
                                  'C3G80_he0_ve0_hs0_vs-5_2006-10-06_09-17-04 ';
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-17-24  ';
                                  'C3G80_he0_ve0_hs0_vs5_2006-10-06_09-17-48  ';
                                  'C3G80_he0_ve0_hs0_vs10_2006-10-06_09-18-10 ']);
            fnMeasBkgr = cellstr(['C3G80_he0_ve0_hs0_vs0_2006-10-06_09-16-08'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-16-08'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-17-24'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-17-24'; 
                                  'C3G80_he0_ve0_hs0_vs0_2006-10-06_09-17-24']);
        end
    %elseif (gap == 110)
    elseif (gap >= 0.5*(80 + 110))
         if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C3G110_he-10_ve0_hs0_vs0_2006-10-06_09-42-19';
                                  'C3G110_he-5_ve0_hs0_vs0_2006-10-06_09-42-50 ';
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-43-18  ';
                                  'C3G110_he5_ve0_hs0_vs0_2006-10-06_09-43-46  ';
                                  'C3G110_he10_ve0_hs0_vs0_2006-10-06_09-44-16 ']);
            fnMeasBkgr = cellstr(['C3G110_he0_ve0_hs0_vs0_2006-10-06_09-41-45'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-41-45'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-43-18'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-43-18'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-43-18']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C3G110_he0_ve-10_hs0_vs0_2006-10-06_09-45-26';
                                  'C3G110_he0_ve-5_hs0_vs0_2006-10-06_09-45-57 ';
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-46-26  ';
                                  'C3G110_he0_ve5_hs0_vs0_2006-10-06_09-46-57  ';
                                  'C3G110_he0_ve10_hs0_vs0_2006-10-06_09-47-26 ']);
            fnMeasBkgr = cellstr(['C3G110_he0_ve0_hs0_vs0_2006-10-06_09-44-52'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-44-52'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-46-26'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-46-26'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-46-26']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C3G110_he0_ve0_hs-10_vs0_2006-10-06_09-48-34';
                                  'C3G110_he0_ve0_hs-5_vs0_2006-10-06_09-48-55 ';
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-49-17  ';
                                  'C3G110_he0_ve0_hs5_vs0_2006-10-06_09-49-42  ';
                                  'C3G110_he0_ve0_hs10_vs0_2006-10-06_09-50-04 ']);
             fnMeasBkgr = cellstr(['C3G110_he0_ve0_hs0_vs0_2006-10-06_09-48-02'; 
                                   'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-48-02'; 
                                   'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-49-17'; 
                                   'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-49-17'; 
                                   'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-49-17']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C3G110_he0_ve0_hs0_vs-10_2006-10-06_09-51-12';
                                  'C3G110_he0_ve0_hs0_vs-5_2006-10-06_09-51-33 ';
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-51-55  ';
                                  'C3G110_he0_ve0_hs0_vs5_2006-10-06_09-52-19  ';
                                  'C3G110_he0_ve0_hs0_vs10_2006-10-06_09-52-41 ']);
            fnMeasBkgr = cellstr(['C3G110_he0_ve0_hs0_vs0_2006-10-06_09-50-37'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-50-37'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-51-55'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-51-55'; 
                                  'C3G110_he0_ve0_hs0_vs0_2006-10-06_09-51-55']);
        end
    end     %End of HU80_Tempo
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU80_SEXTANTS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elseif strcmp(idName, 'HU80_SEXTANTS')
    vCurVals = [-10, -5, 0, 5, 10];

    if(gap < 0.5*(15.5+ 16))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G155_he-10_ve0_hs0_vs0_2012-11-02_17-17-35.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he-5_ve0_hs0_vs0_2012-11-02_17-17-52.mat ';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-08.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G155_he5_ve0_hs0_vs0_2012-11-02_17-18-24.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G155_he10_ve0_hs0_vs0_2012-11-02_17-18-40.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-17-19.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-17-19.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-08.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-08.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-08.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve-10_hs0_vs0_2012-11-02_17-19-12.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve-5_hs0_vs0_2012-11-02_17-19-28.mat ';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-19-45.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve5_hs0_vs0_2012-11-02_17-20-01.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve10_hs0_vs0_2012-11-02_17-20-17.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-56.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-56.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-19-45.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-19-45.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-19-45.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs-10_vs0_2012-11-02_17-20-49.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs-5_vs0_2012-11-02_17-21-05.mat ';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-21-21.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs5_vs0_2012-11-02_17-21-37.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs10_vs0_2012-11-02_17-21-54.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-20-33.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-20-33.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-21-21.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-21-21.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-21-21.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs-10_2012-11-02_17-22-26.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs-5_2012-11-02_17-22-42.mat ';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-58.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs5_2012-11-02_17-23-14.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs10_2012-11-02_17-23-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-10.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-10.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-58.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-58.mat';
                                  'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-58.mat']);
        end
    elseif(gap < 0.5*(16+ 18))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G160_he-10_ve0_hs0_vs0_2012-11-02_17-24-15.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he-5_ve0_hs0_vs0_2012-11-02_17-24-31.mat ';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-24-47.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G160_he5_ve0_hs0_vs0_2012-11-02_17-25-04.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G160_he10_ve0_hs0_vs0_2012-11-02_17-25-20.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-23-59.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-23-59.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-24-47.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-24-47.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-24-47.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve-10_hs0_vs0_2012-11-02_17-25-52.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve-5_hs0_vs0_2012-11-02_17-26-08.mat ';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-26-25.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve5_hs0_vs0_2012-11-02_17-26-41.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve10_hs0_vs0_2012-11-02_17-26-57.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-25-36.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-25-36.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-26-25.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-26-25.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-26-25.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs-10_vs0_2012-11-02_17-27-30.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs-5_vs0_2012-11-02_17-27-46.mat ';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-02.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs5_vs0_2012-11-02_17-28-18.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs10_vs0_2012-11-02_17-28-34.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-27-13.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-27-13.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-02.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-02.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-02.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs-10_2012-11-02_17-29-07.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs-5_2012-11-02_17-29-23.mat ';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-29-39.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs5_2012-11-02_17-29-55.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs10_2012-11-02_17-30-11.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-50.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-50.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-29-39.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-29-39.mat';
                                  'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-29-39.mat']);
        end
    elseif(gap < 0.5*(18+ 20))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G180_he-10_ve0_hs0_vs0_2012-11-02_17-30-56.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he-5_ve0_hs0_vs0_2012-11-02_17-31-12.mat ';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-31-28.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G180_he5_ve0_hs0_vs0_2012-11-02_17-31-44.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G180_he10_ve0_hs0_vs0_2012-11-02_17-32-00.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-30-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-30-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-31-28.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-31-28.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-31-28.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve-10_hs0_vs0_2012-11-02_17-32-33.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve-5_hs0_vs0_2012-11-02_17-32-49.mat ';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-06.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve5_hs0_vs0_2012-11-02_17-33-22.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve10_hs0_vs0_2012-11-02_17-33-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-32-16.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-32-16.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-06.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs-10_vs0_2012-11-02_17-34-10.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs-5_vs0_2012-11-02_17-34-26.mat ';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-34-42.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs5_vs0_2012-11-02_17-34-59.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs10_vs0_2012-11-02_17-35-15.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-54.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-54.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-34-42.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-34-42.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-34-42.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs-10_2012-11-02_17-35-47.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs-5_2012-11-02_17-36-03.mat ';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-36-19.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs5_2012-11-02_17-36-36.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs10_2012-11-02_17-36-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-35-31.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-35-31.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-36-19.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-36-19.mat';
                                  'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-36-19.mat']);
        end
    elseif(gap < 0.5*(20+ 22.5))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G200_he-10_ve0_hs0_vs0_2012-11-02_17-37-36.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he-5_ve0_hs0_vs0_2012-11-02_17-37-52.mat ';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-08.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G200_he5_ve0_hs0_vs0_2012-11-02_17-38-25.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G200_he10_ve0_hs0_vs0_2012-11-02_17-38-41.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-37-20.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-37-20.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-08.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-08.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-08.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve-10_hs0_vs0_2012-11-02_17-39-13.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve-5_hs0_vs0_2012-11-02_17-39-29.mat ';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-39-45.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve5_hs0_vs0_2012-11-02_17-40-02.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve10_hs0_vs0_2012-11-02_17-40-18.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-57.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-57.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-39-45.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-39-45.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-39-45.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs-10_vs0_2012-11-02_17-40-50.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs-5_vs0_2012-11-02_17-41-06.mat ';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-41-23.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs5_vs0_2012-11-02_17-41-39.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs10_vs0_2012-11-02_17-41-55.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-40-34.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-40-34.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-41-23.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-41-23.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-41-23.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs-10_2012-11-02_17-42-27.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs-5_2012-11-02_17-42-43.mat ';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-59.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs5_2012-11-02_17-43-16.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs10_2012-11-02_17-43-32.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-11.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-11.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-59.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-59.mat';
                                  'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-59.mat']);
        end
    elseif(gap < 0.5*(22.5+ 25))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G225_he-10_ve0_hs0_vs0_2012-11-02_17-44-16.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he-5_ve0_hs0_vs0_2012-11-02_17-44-32.mat ';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-48.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G225_he5_ve0_hs0_vs0_2012-11-02_17-45-05.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G225_he10_ve0_hs0_vs0_2012-11-02_17-45-21.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-00.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-00.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-48.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-48.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-48.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve-10_hs0_vs0_2012-11-02_17-45-53.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve-5_hs0_vs0_2012-11-02_17-46-09.mat ';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-46-25.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve5_hs0_vs0_2012-11-02_17-46-42.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve10_hs0_vs0_2012-11-02_17-46-58.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-45-37.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-45-37.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-46-25.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-46-25.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-46-25.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs-10_vs0_2012-11-02_17-47-30.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs-5_vs0_2012-11-02_17-47-46.mat ';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-03.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs5_vs0_2012-11-02_17-48-19.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs10_vs0_2012-11-02_17-48-35.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-47-14.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-47-14.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-03.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-03.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-03.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs-10_2012-11-02_17-49-08.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs-5_2012-11-02_17-49-24.mat ';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-49-40.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs5_2012-11-02_17-49-56.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs10_2012-11-02_17-50-12.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-52.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-52.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-49-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-49-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-49-40.mat']);
        end
    elseif(gap < 0.5*(25+ 27.5))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G250_he-10_ve0_hs0_vs0_2012-11-02_17-50-57.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he-5_ve0_hs0_vs0_2012-11-02_17-51-13.mat ';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-51-29.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G250_he5_ve0_hs0_vs0_2012-11-02_17-51-45.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G250_he10_ve0_hs0_vs0_2012-11-02_17-52-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-50-41.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-50-41.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-51-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-51-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-51-29.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve-10_hs0_vs0_2012-11-02_17-52-34.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve-5_hs0_vs0_2012-11-02_17-52-50.mat ';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-06.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve5_hs0_vs0_2012-11-02_17-53-22.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve10_hs0_vs0_2012-11-02_17-53-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-52-18.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-52-18.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-06.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs-10_vs0_2012-11-02_17-54-11.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs-5_vs0_2012-11-02_17-54-27.mat ';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-54-43.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs5_vs0_2012-11-02_17-54-59.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs10_vs0_2012-11-02_17-55-16.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-55.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-55.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-54-43.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-54-43.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-54-43.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs-10_2012-11-02_17-55-48.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs-5_2012-11-02_17-56-04.mat ';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-56-20.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs5_2012-11-02_17-56-36.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs10_2012-11-02_17-56-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-55-32.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-55-32.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-56-20.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-56-20.mat';
                                  'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-56-20.mat']);
        end
    elseif(gap < 0.5*(27.5+ 30))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G275_he-10_ve0_hs0_vs0_2012-11-02_17-57-37.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he-5_ve0_hs0_vs0_2012-11-02_17-57-53.mat ';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-09.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G275_he5_ve0_hs0_vs0_2012-11-02_17-58-26.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G275_he10_ve0_hs0_vs0_2012-11-02_17-58-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-57-21.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-57-21.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-09.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve-10_hs0_vs0_2012-11-02_17-59-14.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve-5_hs0_vs0_2012-11-02_17-59-30.mat ';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-59-47.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve5_hs0_vs0_2012-11-02_18-00-03.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve10_hs0_vs0_2012-11-02_18-00-19.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-58.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-58.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-59-47.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-59-47.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-59-47.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs-10_vs0_2012-11-02_18-00-51.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs-5_vs0_2012-11-02_18-01-07.mat ';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-01-24.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs5_vs0_2012-11-02_18-01-40.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs10_vs0_2012-11-02_18-01-56.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-00-35.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-00-35.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-01-24.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-01-24.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-01-24.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs-10_2012-11-02_18-02-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs-5_2012-11-02_18-02-45.mat ';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-03-01.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs5_2012-11-02_18-03-17.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs10_2012-11-02_18-03-34.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-02-13.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-02-13.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-03-01.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-03-01.mat';
                                  'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-03-01.mat']);
        end
    elseif(gap < 0.5*(30+ 35))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G300_he-10_ve0_hs0_vs0_2012-11-02_18-04-20.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he-5_ve0_hs0_vs0_2012-11-02_18-04-36.mat ';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-52.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G300_he5_ve0_hs0_vs0_2012-11-02_18-05-08.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G300_he10_ve0_hs0_vs0_2012-11-02_18-05-24.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-03.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-03.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-52.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-52.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-52.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve-10_hs0_vs0_2012-11-02_18-05-56.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve-5_hs0_vs0_2012-11-02_18-06-12.mat ';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-06-29.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve5_hs0_vs0_2012-11-02_18-06-45.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve10_hs0_vs0_2012-11-02_18-07-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-05-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-05-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-06-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-06-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-06-29.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs-10_vs0_2012-11-02_18-07-33.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs-5_vs0_2012-11-02_18-07-49.mat ';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-06.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs5_vs0_2012-11-02_18-08-22.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs10_vs0_2012-11-02_18-08-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-07-17.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-07-17.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-06.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs-10_2012-11-02_18-09-10.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs-5_2012-11-02_18-09-27.mat ';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-09-43.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs5_2012-11-02_18-09-59.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs10_2012-11-02_18-10-16.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-54.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-54.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-09-43.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-09-43.mat';
                                  'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-09-43.mat']);
        end
    elseif(gap < 0.5*(35+ 40))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G350_he-10_ve0_hs0_vs0_2012-11-02_18-11-00.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he-5_ve0_hs0_vs0_2012-11-02_18-11-16.mat ';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-11-32.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G350_he5_ve0_hs0_vs0_2012-11-02_18-11-49.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G350_he10_ve0_hs0_vs0_2012-11-02_18-12-05.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-10-44.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-10-44.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-11-32.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-11-32.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-11-32.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve-10_hs0_vs0_2012-11-02_18-12-37.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve-5_hs0_vs0_2012-11-02_18-12-53.mat ';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-09.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve5_hs0_vs0_2012-11-02_18-13-25.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve10_hs0_vs0_2012-11-02_18-13-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-12-21.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-12-21.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-09.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs-10_vs0_2012-11-02_18-14-14.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs-5_vs0_2012-11-02_18-14-30.mat ';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-14-46.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs5_vs0_2012-11-02_18-15-03.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs10_vs0_2012-11-02_18-15-19.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-58.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-58.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-14-46.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-14-46.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-14-46.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs-10_2012-11-02_18-15-51.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs-5_2012-11-02_18-16-07.mat ';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-16-23.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs5_2012-11-02_18-16-40.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs10_2012-11-02_18-16-56.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-15-35.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-15-35.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-16-23.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-16-23.mat';
                                  'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-16-23.mat']);
        end
    elseif(gap < 0.5*(40+ 50))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G400_he-10_ve0_hs0_vs0_2012-11-02_18-17-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he-5_ve0_hs0_vs0_2012-11-02_18-17-57.mat ';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-18-13.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G400_he5_ve0_hs0_vs0_2012-11-02_18-18-29.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G400_he10_ve0_hs0_vs0_2012-11-02_18-18-45.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-17-24.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-17-24.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-18-13.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-18-13.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-18-13.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve-10_hs0_vs0_2012-11-02_18-19-18.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve-5_hs0_vs0_2012-11-02_18-19-34.mat ';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-50.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve5_hs0_vs0_2012-11-02_18-20-06.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve10_hs0_vs0_2012-11-02_18-20-22.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-01.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-01.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-50.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-50.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-50.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs-10_vs0_2012-11-02_18-20-54.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs-5_vs0_2012-11-02_18-21-11.mat ';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-21-27.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs5_vs0_2012-11-02_18-21-43.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs10_vs0_2012-11-02_18-21-59.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-20-38.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-20-38.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-21-27.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-21-27.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-21-27.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs-10_2012-11-02_18-22-33.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs-5_2012-11-02_18-22-49.mat ';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-23-05.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs5_2012-11-02_18-23-21.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs10_2012-11-02_18-23-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-22-15.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-22-15.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-23-05.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-23-05.mat';
                                  'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-23-05.mat']);
        end
    elseif(gap < 0.5*(50+ 60))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G500_he-10_ve0_hs0_vs0_2012-11-02_18-24-25.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he-5_ve0_hs0_vs0_2012-11-02_18-24-41.mat ';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-57.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G500_he5_ve0_hs0_vs0_2012-11-02_18-25-14.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G500_he10_ve0_hs0_vs0_2012-11-02_18-25-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-57.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-57.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-57.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve-10_hs0_vs0_2012-11-02_18-26-02.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve-5_hs0_vs0_2012-11-02_18-26-18.mat ';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-26-34.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve5_hs0_vs0_2012-11-02_18-26-50.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve10_hs0_vs0_2012-11-02_18-27-07.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-25-46.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-25-46.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-26-34.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-26-34.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-26-34.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs-10_vs0_2012-11-02_18-27-39.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs-5_vs0_2012-11-02_18-27-55.mat ';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-28-11.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs5_vs0_2012-11-02_18-28-27.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs10_vs0_2012-11-02_18-28-43.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-27-23.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-27-23.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-28-11.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-28-11.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-28-11.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs-10_2012-11-02_18-29-16.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs-5_2012-11-02_18-29-32.mat ';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-48.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs5_2012-11-02_18-30-04.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs10_2012-11-02_18-30-20.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-00.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-00.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-48.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-48.mat';
                                  'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-48.mat']);
        end
    elseif(gap < 0.5*(60+ 70))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G600_he-10_ve0_hs0_vs0_2012-11-02_18-31-08.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he-5_ve0_hs0_vs0_2012-11-02_18-31-24.mat ';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-31-40.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G600_he5_ve0_hs0_vs0_2012-11-02_18-31-56.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G600_he10_ve0_hs0_vs0_2012-11-02_18-32-12.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-30-52.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-30-52.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-31-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-31-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-31-40.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve-10_hs0_vs0_2012-11-02_18-32-45.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve-5_hs0_vs0_2012-11-02_18-33-01.mat ';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-33-17.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve5_hs0_vs0_2012-11-02_18-33-33.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve10_hs0_vs0_2012-11-02_18-33-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-32-28.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-32-28.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-33-17.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-33-17.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-33-17.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs-10_vs0_2012-11-02_18-34-21.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs-5_vs0_2012-11-02_18-34-38.mat ';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-54.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs5_vs0_2012-11-02_18-35-10.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs10_vs0_2012-11-02_18-35-26.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-05.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-05.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-54.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-54.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-54.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs-10_2012-11-02_18-35-58.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs-5_2012-11-02_18-36-15.mat ';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-36-31.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs5_2012-11-02_18-36-47.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs10_2012-11-02_18-37-03.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-35-42.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-35-42.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-36-31.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-36-31.mat';
                                  'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-36-31.mat']);
        end
    elseif(gap < 0.5*(70+ 80))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G700_he-10_ve0_hs0_vs0_2012-11-02_18-37-50.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he-5_ve0_hs0_vs0_2012-11-02_18-38-07.mat ';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-38-23.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G700_he5_ve0_hs0_vs0_2012-11-02_18-38-39.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G700_he10_ve0_hs0_vs0_2012-11-02_18-38-55.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-37-34.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-37-34.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-38-23.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-38-23.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-38-23.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve-10_hs0_vs0_2012-11-02_18-39-27.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve-5_hs0_vs0_2012-11-02_18-39-44.mat ';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-00.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve5_hs0_vs0_2012-11-02_18-40-16.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve10_hs0_vs0_2012-11-02_18-40-32.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-39-11.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-39-11.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-00.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-00.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-00.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs-10_vs0_2012-11-02_18-41-04.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs-5_vs0_2012-11-02_18-41-21.mat ';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-41-37.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs5_vs0_2012-11-02_18-41-53.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs10_vs0_2012-11-02_18-42-09.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-48.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-48.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-41-37.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-41-37.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-41-37.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs-10_2012-11-02_18-42-42.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs-5_2012-11-02_18-42-58.mat ';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-43-14.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs5_2012-11-02_18-43-30.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs10_2012-11-02_18-43-46.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-42-25.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-42-25.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-43-14.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-43-14.mat';
                                  'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-43-14.mat']);
        end
    elseif(gap < 0.5*(80+ 90))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G800_he-10_ve0_hs0_vs0_2012-11-02_18-44-34.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he-5_ve0_hs0_vs0_2012-11-02_18-44-50.mat ';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-06.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G800_he5_ve0_hs0_vs0_2012-11-02_18-45-22.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G800_he10_ve0_hs0_vs0_2012-11-02_18-45-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-44-18.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-44-18.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-06.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve-10_hs0_vs0_2012-11-02_18-46-11.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve-5_hs0_vs0_2012-11-02_18-46-27.mat ';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-46-43.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve5_hs0_vs0_2012-11-02_18-47-00.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve10_hs0_vs0_2012-11-02_18-47-16.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-55.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-55.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-46-43.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-46-43.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-46-43.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs-10_vs0_2012-11-02_18-47-48.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs-5_vs0_2012-11-02_18-48-04.mat ';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-48-20.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs5_vs0_2012-11-02_18-48-36.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs10_vs0_2012-11-02_18-48-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-47-32.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-47-32.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-48-20.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-48-20.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-48-20.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs-10_2012-11-02_18-49-25.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs-5_2012-11-02_18-49-41.mat ';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-57.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs5_2012-11-02_18-50-13.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs10_2012-11-02_18-50-29.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-57.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-57.mat';
                                  'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-57.mat']);
        end
    elseif(gap < 0.5*(90+ 100))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G900_he-10_ve0_hs0_vs0_2012-11-02_18-51-17.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he-5_ve0_hs0_vs0_2012-11-02_18-51-33.mat ';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-49.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G900_he5_ve0_hs0_vs0_2012-11-02_18-52-06.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G900_he10_ve0_hs0_vs0_2012-11-02_18-52-22.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-01.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-01.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-49.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-49.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-49.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve-10_hs0_vs0_2012-11-02_18-52-54.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve-5_hs0_vs0_2012-11-02_18-53-10.mat ';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-53-26.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve5_hs0_vs0_2012-11-02_18-53-42.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve10_hs0_vs0_2012-11-02_18-53-58.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-52-38.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-52-38.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-53-26.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-53-26.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-53-26.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs-10_vs0_2012-11-02_18-54-31.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs-5_vs0_2012-11-02_18-54-47.mat ';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-03.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs5_vs0_2012-11-02_18-55-19.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs10_vs0_2012-11-02_18-55-35.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-54-15.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-54-15.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-03.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-03.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-03.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs-10_2012-11-02_18-56-08.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs-5_2012-11-02_18-56-24.mat ';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-56-40.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs5_2012-11-02_18-56-56.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs10_2012-11-02_18-57-12.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-51.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-51.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-56-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-56-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-56-40.mat']);
        end
    elseif(gap < 0.5*(100+ 125))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he-10_ve0_hs0_vs0_2012-11-02_18-58-00.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he-5_ve0_hs0_vs0_2012-11-02_18-58-16.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-58-32.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he5_ve0_hs0_vs0_2012-11-02_18-58-48.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he10_ve0_hs0_vs0_2012-11-02_18-59-05.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-57-44.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-57-44.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-58-32.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-58-32.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-58-32.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve-10_hs0_vs0_2012-11-02_18-59-37.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve-5_hs0_vs0_2012-11-02_18-59-53.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-09.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve5_hs0_vs0_2012-11-02_19-00-25.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve10_hs0_vs0_2012-11-02_19-00-41.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-59-21.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-59-21.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-09.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs-10_vs0_2012-11-02_19-01-14.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs-5_vs0_2012-11-02_19-01-30.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-01-46.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs5_vs0_2012-11-02_19-02-02.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs10_vs0_2012-11-02_19-02-18.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-58.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-58.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-01-46.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-01-46.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-01-46.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs-10_2012-11-02_19-02-51.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs-5_2012-11-02_19-03-07.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-03-23.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs5_2012-11-02_19-03-39.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs10_2012-11-02_19-03-55.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-02-34.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-02-34.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-03-23.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-03-23.mat';
                                  'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-03-23.mat']);
        end
    elseif(gap < 0.5*(125+ 150))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he-10_ve0_hs0_vs0_2012-11-02_19-04-46.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he-5_ve0_hs0_vs0_2012-11-02_19-05-02.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-05-18.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he5_ve0_hs0_vs0_2012-11-02_19-05-34.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he10_ve0_hs0_vs0_2012-11-02_19-05-50.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-04-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-04-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-05-18.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-05-18.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-05-18.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve-10_hs0_vs0_2012-11-02_19-06-23.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve-5_hs0_vs0_2012-11-02_19-06-39.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-55.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve5_hs0_vs0_2012-11-02_19-07-11.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve10_hs0_vs0_2012-11-02_19-07-27.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-55.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-55.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-55.mat']);
        elseif strcmp(corName, 'CHS')%% HU80_PLEIADES
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs-10_vs0_2012-11-02_19-08-00.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs-5_vs0_2012-11-02_19-08-16.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-08-32.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs5_vs0_2012-11-02_19-08-48.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs10_vs0_2012-11-02_19-09-04.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-07-43.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-07-43.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-08-32.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-08-32.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-08-32.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs-10_2012-11-02_19-09-37.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs-5_2012-11-02_19-09-53.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-10-09.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs5_2012-11-02_19-10-25.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs10_2012-11-02_19-10-41.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-09-20.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-09-20.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-10-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-10-09.mat';
                                  'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-10-09.mat']);
        end
    elseif(gap < 0.5*(150+ 175))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he-10_ve0_hs0_vs0_2012-11-02_19-11-32.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he-5_ve0_hs0_vs0_2012-11-02_19-11-49.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-05.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he5_ve0_hs0_vs0_2012-11-02_19-12-21.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he10_ve0_hs0_vs0_2012-11-02_19-12-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-11-15.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-11-15.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-05.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-05.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-05.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve-10_hs0_vs0_2012-11-02_19-13-10.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve-5_hs0_vs0_2012-11-02_19-13-26.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-13-42.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve5_hs0_vs0_2012-11-02_19-13-58.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve10_hs0_vs0_2012-11-02_19-14-14.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-53.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-53.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-13-42.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-13-42.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-13-42.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs-10_vs0_2012-11-02_19-14-47.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs-5_vs0_2012-11-02_19-15-03.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-15-19.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs5_vs0_2012-11-02_19-15-35.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs10_vs0_2012-11-02_19-15-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-14-31.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-14-31.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-15-19.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-15-19.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-15-19.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs-10_2012-11-02_19-16-24.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs-5_2012-11-02_19-16-40.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-56.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs5_2012-11-02_19-17-12.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs10_2012-11-02_19-17-29.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-08.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-08.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-56.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-56.mat';
                                  'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-56.mat']);
        end
    elseif(gap < 0.5*(175+ 200))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he-10_ve0_hs0_vs0_2012-11-02_19-18-19.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he-5_ve0_hs0_vs0_2012-11-02_19-18-35.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-51.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he5_ve0_hs0_vs0_2012-11-02_19-19-08.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he10_ve0_hs0_vs0_2012-11-02_19-19-24.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-03.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-03.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-51.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-51.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-51.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve-10_hs0_vs0_2012-11-02_19-19-56.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve-5_hs0_vs0_2012-11-02_19-20-12.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-20-29.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve5_hs0_vs0_2012-11-02_19-20-45.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve10_hs0_vs0_2012-11-02_19-21-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-19-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-19-40.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-20-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-20-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-20-29.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs-10_vs0_2012-11-02_19-21-34.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs-5_vs0_2012-11-02_19-21-50.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-06.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs5_vs0_2012-11-02_19-22-23.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs10_vs0_2012-11-02_19-22-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-21-17.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-21-17.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-06.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-06.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs-10_2012-11-02_19-23-11.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs-5_2012-11-02_19-23-27.mat ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-23-43.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs5_2012-11-02_19-24-00.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs10_2012-11-02_19-24-16.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-55.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-55.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-23-43.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-23-43.mat';
                                  'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-23-43.mat']);
        end
    elseif(gap < 0.5*(200+ 225))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he-10_ve0_hs0_vs0_2012-11-02_19-25-07.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he-5_ve0_hs0_vs0_2012-11-02_19-25-23.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-25-39.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he5_ve0_hs0_vs0_2012-11-02_19-25-55.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he10_ve0_hs0_vs0_2012-11-02_19-26-11.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-24-50.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-24-50.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-25-39.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-25-39.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-25-39.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve-10_hs0_vs0_2012-11-02_19-26-44.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve-5_hs0_vs0_2012-11-02_19-27-00.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-27-16.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve5_hs0_vs0_2012-11-02_19-27-33.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve10_hs0_vs0_2012-11-02_19-27-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-26-27.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-26-27.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-27-16.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-27-16.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-27-16.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs-10_vs0_2012-11-02_19-28-21.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs-5_vs0_2012-11-02_19-28-38.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-54.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs5_vs0_2012-11-02_19-29-10.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs10_vs0_2012-11-02_19-29-26.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-05.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-05.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-54.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-54.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-54.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs-10_2012-11-02_19-29-58.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs-5_2012-11-02_19-30-15.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-30-31.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs5_2012-11-02_19-30-47.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs10_2012-11-02_19-31-03.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-29-42.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-29-42.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-30-31.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-30-31.mat';
                                  'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-30-31.mat']);
        end
    elseif(gap < 0.5*(225+ 239))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he-10_ve0_hs0_vs0_2012-11-02_19-31-54.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he-5_ve0_hs0_vs0_2012-11-02_19-32-10.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-32-26.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he5_ve0_hs0_vs0_2012-11-02_19-32-42.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he10_ve0_hs0_vs0_2012-11-02_19-32-58.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-31-38.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-31-38.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-32-26.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-32-26.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-32-26.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve-10_hs0_vs0_2012-11-02_19-33-31.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve-5_hs0_vs0_2012-11-02_19-33-47.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-03.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve5_hs0_vs0_2012-11-02_19-34-20.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve10_hs0_vs0_2012-11-02_19-34-36.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-33-15.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-33-15.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-03.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-03.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-03.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs-10_vs0_2012-11-02_19-35-08.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs-5_vs0_2012-11-02_19-35-25.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-35-41.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs5_vs0_2012-11-02_19-35-57.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs10_vs0_2012-11-02_19-36-13.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-52.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-52.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-35-41.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-35-41.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-35-41.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs-10_2012-11-02_19-36-46.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs-5_2012-11-02_19-37-02.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-37-18.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs5_2012-11-02_19-37-34.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs10_2012-11-02_19-37-50.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-36-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-36-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-37-18.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-37-18.mat';
                                  'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-37-18.mat']);
        end
    else	% Gap > 239

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he-10_ve0_hs0_vs0_2012-11-02_19-38-38.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he-5_ve0_hs0_vs0_2012-11-02_19-38-54.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-10.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he5_ve0_hs0_vs0_2012-11-02_19-39-26.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he10_ve0_hs0_vs0_2012-11-02_19-39-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-38-22.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-38-22.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-10.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-10.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-10.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve-10_hs0_vs0_2012-11-02_19-40-15.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve-5_hs0_vs0_2012-11-02_19-40-31.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-40-47.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve5_hs0_vs0_2012-11-02_19-41-03.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve10_hs0_vs0_2012-11-02_19-41-19.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-59.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-59.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-40-47.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-40-47.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-40-47.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs-10_vs0_2012-11-02_19-41-52.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs-5_vs0_2012-11-02_19-42-08.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-42-24.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs5_vs0_2012-11-02_19-42-40.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs10_vs0_2012-11-02_19-42-56.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-41-36.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-41-36.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-42-24.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-42-24.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-42-24.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs-10_2012-11-02_19-43-29.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs-5_2012-11-02_19-43-45.mat ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-44-01.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs5_2012-11-02_19-44-17.mat  ';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs10_2012-11-02_19-44-33.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-43-13.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-43-13.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-44-01.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-44-01.mat';
                                  'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-44-01.mat']);
        end

    end % End of HU80_SEXTANTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU60 CASSIOPEE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(idName, 'HU60_CASSIOPEE')
    vCurVals = [-10, -5, 0, 5, 10];
    if (gap < 0.5*(15.5 + 18))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G15_5_he-10_ve0_hs0_vs0_2008-09-15_02-18-23';
                                  'C1G15_5_he-5_ve0_hs0_vs0_2008-09-15_02-18-34 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-18-45  ';
                                  'C1G15_5_he5_ve0_hs0_vs0_2008-09-15_02-18-57  ';
                                  'C1G15_5_he10_ve0_hs0_vs0_2008-09-15_02-19-10 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-18-10';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-18-10';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-18-45';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-18-45';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-18-45']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G15_5_he0_ve-10_hs0_vs0_2008-09-15_02-19-34';
                                  'C1G15_5_he0_ve-5_hs0_vs0_2008-09-15_02-19-45 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-19-57  ';
                                  'C1G15_5_he0_ve5_hs0_vs0_2008-09-15_02-20-09  ';
                                  'C1G15_5_he0_ve10_hs0_vs0_2008-09-15_02-20-20 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-19-22';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-19-22';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-19-57';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-19-57';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-19-57']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G15_5_he0_ve0_hs-10_vs0_2008-09-15_02-20-44';
                                  'C1G15_5_he0_ve0_hs-5_vs0_2008-09-15_02-20-56 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-21-07  ';
                                  'C1G15_5_he0_ve0_hs5_vs0_2008-09-15_02-21-18  ';
                                  'C1G15_5_he0_ve0_hs10_vs0_2008-09-15_02-21-29 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-20-32';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-20-32';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-21-07';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-21-07';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-21-07']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G15_5_he0_ve0_hs0_vs-10_2008-09-15_02-21-54';
                                  'C1G15_5_he0_ve0_hs0_vs-5_2008-09-15_02-22-05 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-22-17  ';
                                  'C1G15_5_he0_ve0_hs0_vs5_2008-09-15_02-22-28  ';
                                  'C1G15_5_he0_ve0_hs0_vs10_2008-09-15_02-22-39 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-21-41';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-21-41';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-22-17';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-22-17';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-09-15_02-22-17']);
        end
    elseif (gap < 0.5*(18 + 20))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G18_he-10_ve0_hs0_vs0_2008-09-15_02-10-56';
                                  'C1G18_he-5_ve0_hs0_vs0_2008-09-15_02-11-07 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-11-19  ';
                                  'C1G18_he5_ve0_hs0_vs0_2008-09-15_02-11-31  ';
                                  'C1G18_he10_ve0_hs0_vs0_2008-09-15_02-11-43 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-09-15_02-10-44';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-10-44';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-11-19';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-11-19';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-11-19']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G18_he0_ve-10_hs0_vs0_2008-09-15_02-12-07';
                                  'C1G18_he0_ve-5_hs0_vs0_2008-09-15_02-12-19 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-12-30  ';
                                  'C1G18_he0_ve5_hs0_vs0_2008-09-15_02-12-42  ';
                                  'C1G18_he0_ve10_hs0_vs0_2008-09-15_02-12-54 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-09-15_02-11-55';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-11-55';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-12-30';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-12-30';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-12-30']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G18_he0_ve0_hs-10_vs0_2008-09-15_02-13-19';
                                  'C1G18_he0_ve0_hs-5_vs0_2008-09-15_02-13-30 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-13-41  ';
                                  'C1G18_he0_ve0_hs5_vs0_2008-09-15_02-13-52  ';
                                  'C1G18_he0_ve0_hs10_vs0_2008-09-15_02-14-04 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-09-15_02-13-07';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-13-07';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-13-41';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-13-41';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-13-41']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G18_he0_ve0_hs0_vs-10_2008-09-15_02-14-28';
                                  'C1G18_he0_ve0_hs0_vs-5_2008-09-15_02-14-39 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-14-50  ';
                                  'C1G18_he0_ve0_hs0_vs5_2008-09-15_02-15-02  ';
                                  'C1G18_he0_ve0_hs0_vs10_2008-09-15_02-15-14 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-09-15_02-14-16';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-14-16';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-14-50';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-14-50';
                                  'C1G18_he0_ve0_hs0_vs0_2008-09-15_02-14-50']);
        end
    elseif (gap < 0.5*(20 + 22.5))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G20_he-10_ve0_hs0_vs0_2008-09-15_04-13-31';
                                  'C1G20_he-5_ve0_hs0_vs0_2008-09-15_04-13-42 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-13-53  ';
                                  'C1G20_he5_ve0_hs0_vs0_2008-09-15_04-14-04  ';
                                  'C1G20_he10_ve0_hs0_vs0_2008-09-15_04-14-16 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-09-15_04-13-18';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-13-18';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-13-53';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-13-53';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-13-53']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G20_he0_ve-10_hs0_vs0_2008-09-15_04-14-40';
                                  'C1G20_he0_ve-5_hs0_vs0_2008-09-15_04-14-52 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-15-03  ';
                                  'C1G20_he0_ve5_hs0_vs0_2008-09-15_04-15-14  ';
                                  'C1G20_he0_ve10_hs0_vs0_2008-09-15_04-15-25 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-09-15_04-14-28';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-14-28';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-15-03';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-15-03';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-15-03']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G20_he0_ve0_hs-10_vs0_2008-09-15_04-15-50';
                                  'C1G20_he0_ve0_hs-5_vs0_2008-09-15_04-16-01 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-16-12  ';
                                  'C1G20_he0_ve0_hs5_vs0_2008-09-15_04-16-24  ';
                                  'C1G20_he0_ve0_hs10_vs0_2008-09-15_04-16-35 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-09-15_04-15-38';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-15-38';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-16-12';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-16-12';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-16-12']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G20_he0_ve0_hs0_vs-10_2008-09-15_04-17-00';
                                  'C1G20_he0_ve0_hs0_vs-5_2008-09-15_04-17-11 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-17-22  ';
                                  'C1G20_he0_ve0_hs0_vs5_2008-09-15_04-17-33  ';
                                  'C1G20_he0_ve0_hs0_vs10_2008-09-15_04-17-45 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-09-15_04-16-47';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-16-47';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-17-22';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-17-22';
                                  'C1G20_he0_ve0_hs0_vs0_2008-09-15_04-17-22']);
        end
    elseif (gap < 0.5*(22.5 + 25))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G22_5_he-10_ve0_hs0_vs0_2008-09-15_01-57-05';
                                  'C1G22_5_he-5_ve0_hs0_vs0_2008-09-15_01-57-16 ';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-57-29  ';
                                  'C1G22_5_he5_ve0_hs0_vs0_2008-09-15_01-57-40  ';
                                  'C1G22_5_he10_ve0_hs0_vs0_2008-09-15_01-57-51 ']);
            fnMeasBkgr = cellstr(['C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-56-53';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-56-53';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-57-29';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-57-29';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-57-29']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G22_5_he0_ve-10_hs0_vs0_2008-09-15_01-58-16';
                                  'C1G22_5_he0_ve-5_hs0_vs0_2008-09-15_01-58-27 ';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-58-38  ';
                                  'C1G22_5_he0_ve5_hs0_vs0_2008-09-15_01-58-49  ';
                                  'C1G22_5_he0_ve10_hs0_vs0_2008-09-15_01-59-00 ']);
            fnMeasBkgr = cellstr(['C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-58-03';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-58-03';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-58-38';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-58-38';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-58-38']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G22_5_he0_ve0_hs-10_vs0_2008-09-15_01-59-25';
                                  'C1G22_5_he0_ve0_hs-5_vs0_2008-09-15_01-59-36 ';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-59-47  ';
                                  'C1G22_5_he0_ve0_hs5_vs0_2008-09-15_01-59-58  ';
                                  'C1G22_5_he0_ve0_hs10_vs0_2008-09-15_02-00-10 ']);
            fnMeasBkgr = cellstr(['C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-59-13';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-59-13';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-59-47';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-59-47';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_01-59-47']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G22_5_he0_ve0_hs0_vs-10_2008-09-15_02-00-34';
                                  'C1G22_5_he0_ve0_hs0_vs-5_2008-09-15_02-00-45 ';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_02-00-57  ';
                                  'C1G22_5_he0_ve0_hs0_vs5_2008-09-15_02-01-08  ';
                                  'C1G22_5_he0_ve0_hs0_vs10_2008-09-15_02-01-19 ']);
            fnMeasBkgr = cellstr(['C1G22_5_he0_ve0_hs0_vs0_2008-09-15_02-00-22';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_02-00-22';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_02-00-57';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_02-00-57';
                                  'C1G22_5_he0_ve0_hs0_vs0_2008-09-15_02-00-57']);
        end
    elseif (gap < 0.5*(25 + 27.5))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G25_he-10_ve0_hs0_vs0_2008-09-15_01-51-55';
                                  'C1G25_he-5_ve0_hs0_vs0_2008-09-15_01-52-07 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-52-18  ';
                                  'C1G25_he5_ve0_hs0_vs0_2008-09-15_01-52-31  ';
                                  'C1G25_he10_ve0_hs0_vs0_2008-09-15_01-52-42 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-09-15_01-51-43';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-51-43';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-52-18';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-52-18';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-52-18']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G25_he0_ve-10_hs0_vs0_2008-09-15_01-53-06';
                                  'C1G25_he0_ve-5_hs0_vs0_2008-09-15_01-53-17 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-53-28  ';
                                  'C1G25_he0_ve5_hs0_vs0_2008-09-15_01-53-40  ';
                                  'C1G25_he0_ve10_hs0_vs0_2008-09-15_01-53-51 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-09-15_01-52-54';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-52-54';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-53-28';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-53-28';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-53-28']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G25_he0_ve0_hs-10_vs0_2008-09-15_01-54-15';
                                  'C1G25_he0_ve0_hs-5_vs0_2008-09-15_01-54-27 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-54-38  ';
                                  'C1G25_he0_ve0_hs5_vs0_2008-09-15_01-54-49  ';
                                  'C1G25_he0_ve0_hs10_vs0_2008-09-15_01-55-00 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-09-15_01-54-03';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-54-03';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-54-38';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-54-38';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-54-38']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G25_he0_ve0_hs0_vs-10_2008-09-15_01-55-25';
                                  'C1G25_he0_ve0_hs0_vs-5_2008-09-15_01-55-36 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-55-47  ';
                                  'C1G25_he0_ve0_hs0_vs5_2008-09-15_01-55-58  ';
                                  'C1G25_he0_ve0_hs0_vs10_2008-09-15_01-56-09 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-09-15_01-55-12';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-55-12';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-55-47';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-55-47';
                                  'C1G25_he0_ve0_hs0_vs0_2008-09-15_01-55-47']);
        end
    elseif (gap < 0.5*(27.5 + 30))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G27_5_he-10_ve0_hs0_vs0_2008-09-15_01-46-57';
                                  'C1G27_5_he-5_ve0_hs0_vs0_2008-09-15_01-47-09 ';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-47-20  ';
                                  'C1G27_5_he5_ve0_hs0_vs0_2008-09-15_01-47-31  ';
                                  'C1G27_5_he10_ve0_hs0_vs0_2008-09-15_01-47-42 ']);
            fnMeasBkgr = cellstr(['C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-46-45';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-46-45';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-47-20';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-47-20';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-47-20']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G27_5_he0_ve-10_hs0_vs0_2008-09-15_01-48-07';
                                  'C1G27_5_he0_ve-5_hs0_vs0_2008-09-15_01-48-18 ';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-48-29  ';
                                  'C1G27_5_he0_ve5_hs0_vs0_2008-09-15_01-48-40  ';
                                  'C1G27_5_he0_ve10_hs0_vs0_2008-09-15_01-48-51 ']);
            fnMeasBkgr = cellstr(['C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-47-54';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-47-54';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-48-29';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-48-29';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-48-29']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G27_5_he0_ve0_hs-10_vs0_2008-09-15_01-49-16';
                                  'C1G27_5_he0_ve0_hs-5_vs0_2008-09-15_01-49-27 ';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-49-38  ';
                                  'C1G27_5_he0_ve0_hs5_vs0_2008-09-15_01-49-49  ';
                                  'C1G27_5_he0_ve0_hs10_vs0_2008-09-15_01-50-01 ']);
            fnMeasBkgr = cellstr(['C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-49-04';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-49-04';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-49-38';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-49-38';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-49-38']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G27_5_he0_ve0_hs0_vs-10_2008-09-15_01-50-25';
                                  'C1G27_5_he0_ve0_hs0_vs-5_2008-09-15_01-50-36 ';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-50-47  ';
                                  'C1G27_5_he0_ve0_hs0_vs5_2008-09-15_01-50-59  ';
                                  'C1G27_5_he0_ve0_hs0_vs10_2008-09-15_01-51-10 ']);
            fnMeasBkgr = cellstr(['C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-50-13';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-50-13';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-50-47';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-50-47';
                                  'C1G27_5_he0_ve0_hs0_vs0_2008-09-15_01-50-47']);
        end
    elseif (gap < 0.5*(30 + 35))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G30_he-10_ve0_hs0_vs0_2008-09-15_01-39-57';
                                  'C1G30_he-5_ve0_hs0_vs0_2008-09-15_01-40-08 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-40-19  ';
                                  'C1G30_he5_ve0_hs0_vs0_2008-09-15_01-40-31  ';
                                  'C1G30_he10_ve0_hs0_vs0_2008-09-15_01-40-42 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-09-15_01-39-44';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-39-44';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-40-19';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-40-19';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-40-19']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G30_he0_ve-10_hs0_vs0_2008-09-15_01-41-07';
                                  'C1G30_he0_ve-5_hs0_vs0_2008-09-15_01-41-18 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-41-29  ';
                                  'C1G30_he0_ve5_hs0_vs0_2008-09-15_01-41-40  ';
                                  'C1G30_he0_ve10_hs0_vs0_2008-09-15_01-41-52 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-09-15_01-40-55';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-40-55';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-41-29';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-41-29';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-41-29']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G30_he0_ve0_hs-10_vs0_2008-09-15_01-42-16';
                                  'C1G30_he0_ve0_hs-5_vs0_2008-09-15_01-42-27 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-42-38  ';
                                  'C1G30_he0_ve0_hs5_vs0_2008-09-15_01-42-50  ';
                                  'C1G30_he0_ve0_hs10_vs0_2008-09-15_01-43-01 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-09-15_01-42-04';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-42-04';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-42-38';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-42-38';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-42-38']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G30_he0_ve0_hs0_vs-10_2008-09-15_01-43-25';
                                  'C1G30_he0_ve0_hs0_vs-5_2008-09-15_01-43-36 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-43-48  ';
                                  'C1G30_he0_ve0_hs0_vs5_2008-09-15_01-43-59  ';
                                  'C1G30_he0_ve0_hs0_vs10_2008-09-15_01-44-10 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-09-15_01-43-13';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-43-13';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-43-48';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-43-48';
                                  'C1G30_he0_ve0_hs0_vs0_2008-09-15_01-43-48']);
        end
    elseif (gap < 0.5*(35 + 40))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G35_he-10_ve0_hs0_vs0_2008-09-15_01-32-57';
                                  'C1G35_he-5_ve0_hs0_vs0_2008-09-15_01-33-08 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-33-19  ';
                                  'C1G35_he5_ve0_hs0_vs0_2008-09-15_01-33-31  ';
                                  'C1G35_he10_ve0_hs0_vs0_2008-09-15_01-33-42 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-09-15_01-32-45';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-32-45';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-33-19';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-33-19';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-33-19']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G35_he0_ve-10_hs0_vs0_2008-09-15_01-34-06';
                                  'C1G35_he0_ve-5_hs0_vs0_2008-09-15_01-34-19 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-34-30  ';
                                  'C1G35_he0_ve5_hs0_vs0_2008-09-15_01-34-41  ';
                                  'C1G35_he0_ve10_hs0_vs0_2008-09-15_01-34-52 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-09-15_01-33-54';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-33-54';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-34-30';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-34-30';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-34-30']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G35_he0_ve0_hs-10_vs0_2008-09-15_01-35-17';
                                  'C1G35_he0_ve0_hs-5_vs0_2008-09-15_01-35-28 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-35-39  ';
                                  'C1G35_he0_ve0_hs5_vs0_2008-09-15_01-35-50  ';
                                  'C1G35_he0_ve0_hs10_vs0_2008-09-15_01-36-03 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-09-15_01-35-04';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-35-04';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-35-39';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-35-39';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-35-39']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G35_he0_ve0_hs0_vs-10_2008-09-15_01-36-27';
                                  'C1G35_he0_ve0_hs0_vs-5_2008-09-15_01-36-38 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-36-49  ';
                                  'C1G35_he0_ve0_hs0_vs5_2008-09-15_01-37-00  ';
                                  'C1G35_he0_ve0_hs0_vs10_2008-09-15_01-37-12 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-09-15_01-36-15';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-36-15';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-36-49';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-36-49';
                                  'C1G35_he0_ve0_hs0_vs0_2008-09-15_01-36-49']);
        end
    elseif (gap < 0.5*(40 + 50))
         if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G40_he-10_ve0_hs0_vs0_2008-09-15_01-26-44';
                                  'C1G40_he-5_ve0_hs0_vs0_2008-09-15_01-26-55 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-27-07  ';
                                  'C1G40_he5_ve0_hs0_vs0_2008-09-15_01-27-18  ';
                                  'C1G40_he10_ve0_hs0_vs0_2008-09-15_01-27-29 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-09-15_01-26-32';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-26-32';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-27-07';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-27-07';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-27-07']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G40_he0_ve-10_hs0_vs0_2008-09-15_01-27-53';
                                  'C1G40_he0_ve-5_hs0_vs0_2008-09-15_01-28-06 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-28-18  ';
                                  'C1G40_he0_ve5_hs0_vs0_2008-09-15_01-28-29  ';
                                  'C1G40_he0_ve10_hs0_vs0_2008-09-15_01-28-41 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-09-15_01-27-41';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-27-41';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-28-18';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-28-18';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-28-18']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G40_he0_ve0_hs-10_vs0_2008-09-15_01-29-06';
                                  'C1G40_he0_ve0_hs-5_vs0_2008-09-15_01-29-17 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-29-28  ';
                                  'C1G40_he0_ve0_hs5_vs0_2008-09-15_01-29-39  ';
                                  'C1G40_he0_ve0_hs10_vs0_2008-09-15_01-29-51 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-09-15_01-28-53';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-28-53';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-29-28';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-29-28';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-29-28']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G40_he0_ve0_hs0_vs-10_2008-09-15_01-30-15';
                                  'C1G40_he0_ve0_hs0_vs-5_2008-09-15_01-30-26 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-30-37  ';
                                  'C1G40_he0_ve0_hs0_vs5_2008-09-15_01-30-49  ';
                                  'C1G40_he0_ve0_hs0_vs10_2008-09-15_01-31-00 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-09-15_01-30-03';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-30-03';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-30-37';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-30-37';
                                  'C1G40_he0_ve0_hs0_vs0_2008-09-15_01-30-37']);
        end
    elseif (gap < 0.5*(50 + 60))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G50_he-10_ve0_hs0_vs0_2008-09-15_01-21-35';
                                  'C1G50_he-5_ve0_hs0_vs0_2008-09-15_01-21-46 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-21-57  ';
                                  'C1G50_he5_ve0_hs0_vs0_2008-09-15_01-22-09  ';
                                  'C1G50_he10_ve0_hs0_vs0_2008-09-15_01-22-20 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-09-15_01-21-23';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-21-23';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-21-57';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-21-57';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-21-57']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G50_he0_ve-10_hs0_vs0_2008-09-15_01-22-44';
                                  'C1G50_he0_ve-5_hs0_vs0_2008-09-15_01-22-55 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-23-07  ';
                                  'C1G50_he0_ve5_hs0_vs0_2008-09-15_01-23-18  ';
                                  'C1G50_he0_ve10_hs0_vs0_2008-09-15_01-23-29 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-09-15_01-22-32';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-22-32';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-23-07';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-23-07';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-23-07']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G50_he0_ve0_hs-10_vs0_2008-09-15_01-23-54';
                                  'C1G50_he0_ve0_hs-5_vs0_2008-09-15_01-24-05 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-24-16  ';
                                  'C1G50_he0_ve0_hs5_vs0_2008-09-15_01-24-27  ';
                                  'C1G50_he0_ve0_hs10_vs0_2008-09-15_01-24-38 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-09-15_01-23-41';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-23-41';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-24-16';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-24-16';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-24-16']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G50_he0_ve0_hs0_vs-10_2008-09-15_01-25-03';
                                  'C1G50_he0_ve0_hs0_vs-5_2008-09-15_01-25-14 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-25-25  ';
                                  'C1G50_he0_ve0_hs0_vs5_2008-09-15_01-25-36  ';
                                  'C1G50_he0_ve0_hs0_vs10_2008-09-15_01-25-47 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-09-15_01-24-51';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-24-51';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-25-25';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-25-25';
                                  'C1G50_he0_ve0_hs0_vs0_2008-09-15_01-25-25']);
        end
    elseif (gap < 0.5*(60 + 70))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G60_he-10_ve0_hs0_vs0_2008-09-15_01-16-11';
                                  'C1G60_he-5_ve0_hs0_vs0_2008-09-15_01-16-22 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-16-34  ';
                                  'C1G60_he5_ve0_hs0_vs0_2008-09-15_01-16-46  ';
                                  'C1G60_he10_ve0_hs0_vs0_2008-09-15_01-16-57 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-09-15_01-15-59';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-15-59';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-16-34';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-16-34';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-16-34']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G60_he0_ve-10_hs0_vs0_2008-09-15_01-17-21';
                                  'C1G60_he0_ve-5_hs0_vs0_2008-09-15_01-17-34 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-17-45  ';
                                  'C1G60_he0_ve5_hs0_vs0_2008-09-15_01-17-56  ';
                                  'C1G60_he0_ve10_hs0_vs0_2008-09-15_01-18-07 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-09-15_01-17-09';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-17-09';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-17-45';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-17-45';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-17-45']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G60_he0_ve0_hs-10_vs0_2008-09-15_01-18-32';
                                  'C1G60_he0_ve0_hs-5_vs0_2008-09-15_01-18-43 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-18-54  ';
                                  'C1G60_he0_ve0_hs5_vs0_2008-09-15_01-19-06  ';
                                  'C1G60_he0_ve0_hs10_vs0_2008-09-15_01-19-17 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-09-15_01-18-19';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-18-19';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-18-54';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-18-54';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-18-54']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G60_he0_ve0_hs0_vs-10_2008-09-15_01-19-41';
                                  'C1G60_he0_ve0_hs0_vs-5_2008-09-15_01-19-52 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-20-04  ';
                                  'C1G60_he0_ve0_hs0_vs5_2008-09-15_01-20-15  ';
                                  'C1G60_he0_ve0_hs0_vs10_2008-09-15_01-20-26 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-09-15_01-19-29';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-19-29';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-20-04';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-20-04';
                                  'C1G60_he0_ve0_hs0_vs0_2008-09-15_01-20-04']);
        end
    elseif (gap < 0.5*(70 + 80))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G70_he-10_ve0_hs0_vs0_2008-09-15_01-10-45';
                                  'C1G70_he-5_ve0_hs0_vs0_2008-09-15_01-10-57 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-11-09  ';
                                  'C1G70_he5_ve0_hs0_vs0_2008-09-15_01-11-20  ';
                                  'C1G70_he10_ve0_hs0_vs0_2008-09-15_01-11-31 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-09-15_01-10-33';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-10-33';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-11-09';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-11-09';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-11-09']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G70_he0_ve-10_hs0_vs0_2008-09-15_01-11-55';
                                  'C1G70_he0_ve-5_hs0_vs0_2008-09-15_01-12-07 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-12-18  ';
                                  'C1G70_he0_ve5_hs0_vs0_2008-09-15_01-12-30  ';
                                  'C1G70_he0_ve10_hs0_vs0_2008-09-15_01-12-41 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-09-15_01-11-43';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-11-43';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-12-18';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-12-18';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-12-18']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G70_he0_ve0_hs-10_vs0_2008-09-15_01-13-06';
                                  'C1G70_he0_ve0_hs-5_vs0_2008-09-15_01-13-17 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-13-28  ';
                                  'C1G70_he0_ve0_hs5_vs0_2008-09-15_01-13-39  ';
                                  'C1G70_he0_ve0_hs10_vs0_2008-09-15_01-13-50 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-09-15_01-12-53';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-12-53';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-13-28';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-13-28';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-13-28']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G70_he0_ve0_hs0_vs-10_2008-09-15_01-14-15';
                                  'C1G70_he0_ve0_hs0_vs-5_2008-09-15_01-14-27 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-14-38  ';
                                  'C1G70_he0_ve0_hs0_vs5_2008-09-15_01-14-49  ';
                                  'C1G70_he0_ve0_hs0_vs10_2008-09-15_01-15-01 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-09-15_01-14-03';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-14-03';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-14-38';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-14-38';
                                  'C1G70_he0_ve0_hs0_vs0_2008-09-15_01-14-38']);
        end
    elseif (gap < 0.5*(80 + 90))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G80_he-10_ve0_hs0_vs0_2008-09-15_01-04-33';
                                  'C1G80_he-5_ve0_hs0_vs0_2008-09-15_01-04-44 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-04-55  ';
                                  'C1G80_he5_ve0_hs0_vs0_2008-09-15_01-05-06  ';
                                  'C1G80_he10_ve0_hs0_vs0_2008-09-15_01-05-18 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-09-15_01-04-20';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-04-20';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-04-55';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-04-55';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-04-55']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G80_he0_ve-10_hs0_vs0_2008-09-15_01-05-42';
                                  'C1G80_he0_ve-5_hs0_vs0_2008-09-15_01-05-53 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-06-04  ';
                                  'C1G80_he0_ve5_hs0_vs0_2008-09-15_01-06-16  ';
                                  'C1G80_he0_ve10_hs0_vs0_2008-09-15_01-06-27 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-09-15_01-05-30';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-05-30';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-06-04';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-06-04';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-06-04']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G80_he0_ve0_hs-10_vs0_2008-09-15_01-06-51';
                                  'C1G80_he0_ve0_hs-5_vs0_2008-09-15_01-07-02 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-07-15  ';
                                  'C1G80_he0_ve0_hs5_vs0_2008-09-15_01-07-26  ';
                                  'C1G80_he0_ve0_hs10_vs0_2008-09-15_01-07-37 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-09-15_01-06-39';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-06-39';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-07-15';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-07-15';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-07-15']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G80_he0_ve0_hs0_vs-10_2008-09-15_01-08-01';
                                  'C1G80_he0_ve0_hs0_vs-5_2008-09-15_01-08-13 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-08-24  ';
                                  'C1G80_he0_ve0_hs0_vs5_2008-09-15_01-08-35  ';
                                  'C1G80_he0_ve0_hs0_vs10_2008-09-15_01-08-46 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-09-15_01-07-49';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-07-49';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-08-24';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-08-24';
                                  'C1G80_he0_ve0_hs0_vs0_2008-09-15_01-08-24']);
        end
    elseif (gap < 0.5*(90 + 100))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G90_he-10_ve0_hs0_vs0_2008-09-15_00-59-14';
                                  'C1G90_he-5_ve0_hs0_vs0_2008-09-15_00-59-25 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_00-59-37  ';
                                  'C1G90_he5_ve0_hs0_vs0_2008-09-15_00-59-48  ';
                                  'C1G90_he10_ve0_hs0_vs0_2008-09-15_01-00-00 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-09-15_00-59-02';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_00-59-02';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_00-59-37';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_00-59-37';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_00-59-37']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G90_he0_ve-10_hs0_vs0_2008-09-15_01-00-24';
                                  'C1G90_he0_ve-5_hs0_vs0_2008-09-15_01-00-36 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-00-47  ';
                                  'C1G90_he0_ve5_hs0_vs0_2008-09-15_01-00-58  ';
                                  'C1G90_he0_ve10_hs0_vs0_2008-09-15_01-01-09 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-09-15_01-00-12';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-00-12';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-00-47';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-00-47';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-00-47']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G90_he0_ve0_hs-10_vs0_2008-09-15_01-01-34';
                                  'C1G90_he0_ve0_hs-5_vs0_2008-09-15_01-01-45 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-01-56  ';
                                  'C1G90_he0_ve0_hs5_vs0_2008-09-15_01-02-07  ';
                                  'C1G90_he0_ve0_hs10_vs0_2008-09-15_01-02-19 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-09-15_01-01-22';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-01-22';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-01-56';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-01-56';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-01-56']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G90_he0_ve0_hs0_vs-10_2008-09-15_01-02-43';
                                  'C1G90_he0_ve0_hs0_vs-5_2008-09-15_01-02-54 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-03-05  ';
                                  'C1G90_he0_ve0_hs0_vs5_2008-09-15_01-03-17  ';
                                  'C1G90_he0_ve0_hs0_vs10_2008-09-15_01-03-28 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-09-15_01-02-31';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-02-31';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-03-05';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-03-05';
                                  'C1G90_he0_ve0_hs0_vs0_2008-09-15_01-03-05']);
        end
    elseif (gap < 0.5*(100 + 110))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G100_he-10_ve0_hs0_vs0_2008-09-15_00-53-22';
                                  'C1G100_he-5_ve0_hs0_vs0_2008-09-15_00-53-33 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-53-45  ';
                                  'C1G100_he5_ve0_hs0_vs0_2008-09-15_00-53-57  ';
                                  'C1G100_he10_ve0_hs0_vs0_2008-09-15_00-54-08 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-09-15_00-53-10';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-53-10';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-53-45';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-53-45';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-53-45']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G100_he0_ve-10_hs0_vs0_2008-09-15_00-54-32';
                                  'C1G100_he0_ve-5_hs0_vs0_2008-09-15_00-54-43 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-54-56  ';
                                  'C1G100_he0_ve5_hs0_vs0_2008-09-15_00-55-08  ';
                                  'C1G100_he0_ve10_hs0_vs0_2008-09-15_00-55-20 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-09-15_00-54-20';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-54-20';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-54-56';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-54-56';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-54-56']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G100_he0_ve0_hs-10_vs0_2008-09-15_00-55-45';
                                  'C1G100_he0_ve0_hs-5_vs0_2008-09-15_00-55-56 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-56-07  ';
                                  'C1G100_he0_ve0_hs5_vs0_2008-09-15_00-56-18  ';
                                  'C1G100_he0_ve0_hs10_vs0_2008-09-15_00-56-29 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-09-15_00-55-32';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-55-32';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-56-07';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-56-07';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-56-07']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G100_he0_ve0_hs0_vs-10_2008-09-15_00-56-54';
                                  'C1G100_he0_ve0_hs0_vs-5_2008-09-15_00-57-05 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-57-16  ';
                                  'C1G100_he0_ve0_hs0_vs5_2008-09-15_00-57-27  ';
                                  'C1G100_he0_ve0_hs0_vs10_2008-09-15_00-57-38 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-09-15_00-56-42';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-56-42';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-57-16';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-57-16';
                                  'C1G100_he0_ve0_hs0_vs0_2008-09-15_00-57-16']);
        end
    elseif (gap < 0.5*(110 + 130))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G110_he-10_ve0_hs0_vs0_2008-09-15_00-48-04';
                                  'C1G110_he-5_ve0_hs0_vs0_2008-09-15_00-48-15 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-48-27  ';
                                  'C1G110_he5_ve0_hs0_vs0_2008-09-15_00-48-38  ';
                                  'C1G110_he10_ve0_hs0_vs0_2008-09-15_00-48-49 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-09-15_00-47-52';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-47-52';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-48-27';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-48-27';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-48-27']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G110_he0_ve-10_hs0_vs0_2008-09-15_00-49-13';
                                  'C1G110_he0_ve-5_hs0_vs0_2008-09-15_00-49-26 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-49-37  ';
                                  'C1G110_he0_ve5_hs0_vs0_2008-09-15_00-49-48  ';
                                  'C1G110_he0_ve10_hs0_vs0_2008-09-15_00-49-59 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-09-15_00-49-01';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-49-01';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-49-37';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-49-37';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-49-37']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G110_he0_ve0_hs-10_vs0_2008-09-15_00-50-24';
                                  'C1G110_he0_ve0_hs-5_vs0_2008-09-15_00-50-35 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-50-46  ';
                                  'C1G110_he0_ve0_hs5_vs0_2008-09-15_00-50-57  ';
                                  'C1G110_he0_ve0_hs10_vs0_2008-09-15_00-51-09 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-09-15_00-50-11';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-50-11';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-50-46';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-50-46';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-50-46']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G110_he0_ve0_hs0_vs-10_2008-09-15_00-51-33';
                                  'C1G110_he0_ve0_hs0_vs-5_2008-09-15_00-51-44 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-51-55  ';
                                  'C1G110_he0_ve0_hs0_vs5_2008-09-15_00-52-07  ';
                                  'C1G110_he0_ve0_hs0_vs10_2008-09-15_00-52-18 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-09-15_00-51-21';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-51-21';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-51-55';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-51-55';
                                  'C1G110_he0_ve0_hs0_vs0_2008-09-15_00-51-55']);
        end
    elseif (gap < 0.5*(130 + 150))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G130_he-10_ve0_hs0_vs0_2008-09-15_00-42-27';
                                  'C1G130_he-5_ve0_hs0_vs0_2008-09-15_00-42-38 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-42-49  ';
                                  'C1G130_he5_ve0_hs0_vs0_2008-09-15_00-43-00  ';
                                  'C1G130_he10_ve0_hs0_vs0_2008-09-15_00-43-12 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-09-15_00-42-15';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-42-15';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-42-49';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-42-49';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-42-49']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G130_he0_ve-10_hs0_vs0_2008-09-15_00-43-36';
                                  'C1G130_he0_ve-5_hs0_vs0_2008-09-15_00-43-48 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-43-59  ';
                                  'C1G130_he0_ve5_hs0_vs0_2008-09-15_00-44-11  ';
                                  'C1G130_he0_ve10_hs0_vs0_2008-09-15_00-44-23 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-09-15_00-43-24';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-43-24';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-43-59';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-43-59';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-43-59']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G130_he0_ve0_hs-10_vs0_2008-09-15_00-44-47';
                                  'C1G130_he0_ve0_hs-5_vs0_2008-09-15_00-44-59 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-45-10  ';
                                  'C1G130_he0_ve0_hs5_vs0_2008-09-15_00-45-21  ';
                                  'C1G130_he0_ve0_hs10_vs0_2008-09-15_00-45-32 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-09-15_00-44-35';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-44-35';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-45-10';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-45-10';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-45-10']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G130_he0_ve0_hs0_vs-10_2008-09-15_00-45-57';
                                  'C1G130_he0_ve0_hs0_vs-5_2008-09-15_00-46-08 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-46-19  ';
                                  'C1G130_he0_ve0_hs0_vs5_2008-09-15_00-46-30  ';
                                  'C1G130_he0_ve0_hs0_vs10_2008-09-15_00-46-42 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-09-15_00-45-45';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-45-45';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-46-19';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-46-19';
                                  'C1G130_he0_ve0_hs0_vs0_2008-09-15_00-46-19']);
        end
    elseif (gap < 0.5*(150 + 175))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G150_he-10_ve0_hs0_vs0_2008-09-15_00-37-12';
                                  'C1G150_he-5_ve0_hs0_vs0_2008-09-15_00-37-23 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-37-34  ';
                                  'C1G150_he5_ve0_hs0_vs0_2008-09-15_00-37-47  ';
                                  'C1G150_he10_ve0_hs0_vs0_2008-09-15_00-37-59 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-09-15_00-37-00';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-37-00';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-37-34';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-37-34';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-37-34']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G150_he0_ve-10_hs0_vs0_2008-09-15_00-38-23';
                                  'C1G150_he0_ve-5_hs0_vs0_2008-09-15_00-38-34 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-38-46  ';
                                  'C1G150_he0_ve5_hs0_vs0_2008-09-15_00-38-58  ';
                                  'C1G150_he0_ve10_hs0_vs0_2008-09-15_00-39-09 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-09-15_00-38-11';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-38-11';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-38-46';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-38-46';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-38-46']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G150_he0_ve0_hs-10_vs0_2008-09-15_00-39-33';
                                  'C1G150_he0_ve0_hs-5_vs0_2008-09-15_00-39-44 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-39-56  ';
                                  'C1G150_he0_ve0_hs5_vs0_2008-09-15_00-40-07  ';
                                  'C1G150_he0_ve0_hs10_vs0_2008-09-15_00-40-18 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-09-15_00-39-21';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-39-21';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-39-56';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-39-56';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-39-56']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G150_he0_ve0_hs0_vs-10_2008-09-15_00-40-43';
                                  'C1G150_he0_ve0_hs0_vs-5_2008-09-15_00-40-54 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-41-05  ';
                                  'C1G150_he0_ve0_hs0_vs5_2008-09-15_00-41-16  ';
                                  'C1G150_he0_ve0_hs0_vs10_2008-09-15_00-41-27 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-09-15_00-40-30';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-40-30';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-41-05';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-41-05';
                                  'C1G150_he0_ve0_hs0_vs0_2008-09-15_00-41-05']);
        end
    elseif (gap < 0.5*(175 + 200))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G175_he-10_ve0_hs0_vs0_2008-09-15_00-32-09';
                                  'C1G175_he-5_ve0_hs0_vs0_2008-09-15_00-32-21 ';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-32-32  ';
                                  'C1G175_he5_ve0_hs0_vs0_2008-09-15_00-32-43  ';
                                  'C1G175_he10_ve0_hs0_vs0_2008-09-15_00-32-54 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2008-09-15_00-31-56';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-31-56';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-32-32';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-32-32';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-32-32']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G175_he0_ve-10_hs0_vs0_2008-09-15_00-33-19';
                                  'C1G175_he0_ve-5_hs0_vs0_2008-09-15_00-33-31 ';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-33-42  ';
                                  'C1G175_he0_ve5_hs0_vs0_2008-09-15_00-33-54  ';
                                  'C1G175_he0_ve10_hs0_vs0_2008-09-15_00-34-06 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2008-09-15_00-33-07';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-33-07';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-33-42';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-33-42';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-33-42']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G175_he0_ve0_hs-10_vs0_2008-09-15_00-34-30';
                                  'C1G175_he0_ve0_hs-5_vs0_2008-09-15_00-34-41 ';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-34-53  ';
                                  'C1G175_he0_ve0_hs5_vs0_2008-09-15_00-35-04  ';
                                  'C1G175_he0_ve0_hs10_vs0_2008-09-15_00-35-15 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2008-09-15_00-34-18';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-34-18';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-34-53';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-34-53';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-34-53']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G175_he0_ve0_hs0_vs-10_2008-09-15_00-35-39';
                                  'C1G175_he0_ve0_hs0_vs-5_2008-09-15_00-35-51 ';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-36-02  ';
                                  'C1G175_he0_ve0_hs0_vs5_2008-09-15_00-36-13  ';
                                  'C1G175_he0_ve0_hs0_vs10_2008-09-15_00-36-24 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2008-09-15_00-35-27';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-35-27';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-36-02';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-36-02';
                                  'C1G175_he0_ve0_hs0_vs0_2008-09-15_00-36-02']);
        end
    elseif (gap < 0.5*(200 + 225))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G200_he-10_ve0_hs0_vs0_2008-09-15_00-27-05';
                                  'C1G200_he-5_ve0_hs0_vs0_2008-09-15_00-27-16 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-27-27  ';
                                  'C1G200_he5_ve0_hs0_vs0_2008-09-15_00-27-38  ';
                                  'C1G200_he10_ve0_hs0_vs0_2008-09-15_00-27-50 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-09-15_00-26-52';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-26-52';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-27-27';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-27-27';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-27-27']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G200_he0_ve-10_hs0_vs0_2008-09-15_00-28-14';
                                  'C1G200_he0_ve-5_hs0_vs0_2008-09-15_00-28-25 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-28-36  ';
                                  'C1G200_he0_ve5_hs0_vs0_2008-09-15_00-28-48  ';
                                  'C1G200_he0_ve10_hs0_vs0_2008-09-15_00-28-59 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-09-15_00-28-02';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-28-02';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-28-36';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-28-36';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-28-36']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G200_he0_ve0_hs-10_vs0_2008-09-15_00-29-23';
                                  'C1G200_he0_ve0_hs-5_vs0_2008-09-15_00-29-35 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-29-47  ';
                                  'C1G200_he0_ve0_hs5_vs0_2008-09-15_00-29-58  ';
                                  'C1G200_he0_ve0_hs10_vs0_2008-09-15_00-30-09 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-09-15_00-29-11';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-29-11';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-29-47';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-29-47';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-29-47']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G200_he0_ve0_hs0_vs-10_2008-09-15_00-30-33';
                                  'C1G200_he0_ve0_hs0_vs-5_2008-09-15_00-30-45 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-30-56  ';
                                  'C1G200_he0_ve0_hs0_vs5_2008-09-15_00-31-07  ';
                                  'C1G200_he0_ve0_hs0_vs10_2008-09-15_00-31-18 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-09-15_00-30-21';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-30-21';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-30-56';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-30-56';
                                  'C1G200_he0_ve0_hs0_vs0_2008-09-15_00-30-56']);
        end
    elseif (gap < 0.5*(225 + 240))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G225_he-10_ve0_hs0_vs0_2008-09-15_00-19-54';
                                  'C1G225_he-5_ve0_hs0_vs0_2008-09-15_00-20-05 ';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-20-17  ';
                                  'C1G225_he5_ve0_hs0_vs0_2008-09-15_00-20-29  ';
                                  'C1G225_he10_ve0_hs0_vs0_2008-09-15_00-20-40 ']);
            fnMeasBkgr = cellstr(['C1G225_he0_ve0_hs0_vs0_2008-09-15_00-19-42';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-19-42';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-20-17';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-20-17';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-20-17']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G225_he0_ve-10_hs0_vs0_2008-09-15_00-21-04';
                                  'C1G225_he0_ve-5_hs0_vs0_2008-09-15_00-21-16 ';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-21-27  ';
                                  'C1G225_he0_ve5_hs0_vs0_2008-09-15_00-21-38  ';
                                  'C1G225_he0_ve10_hs0_vs0_2008-09-15_00-21-49 ']);
            fnMeasBkgr = cellstr(['C1G225_he0_ve0_hs0_vs0_2008-09-15_00-20-52';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-20-52';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-21-27';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-21-27';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-21-27']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G225_he0_ve0_hs-10_vs0_2008-09-15_00-22-14';
                                  'C1G225_he0_ve0_hs-5_vs0_2008-09-15_00-22-25 ';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-22-36  ';
                                  'C1G225_he0_ve0_hs5_vs0_2008-09-15_00-22-47  ';
                                  'C1G225_he0_ve0_hs10_vs0_2008-09-15_00-22-59 ']);
            fnMeasBkgr = cellstr(['C1G225_he0_ve0_hs0_vs0_2008-09-15_00-22-01';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-22-01';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-22-36';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-22-36';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-22-36']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G225_he0_ve0_hs0_vs-10_2008-09-15_00-23-23';
                                  'C1G225_he0_ve0_hs0_vs-5_2008-09-15_00-23-34 ';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-23-45  ';
                                  'C1G225_he0_ve0_hs0_vs5_2008-09-15_00-23-57  ';
                                  'C1G225_he0_ve0_hs0_vs10_2008-09-15_00-24-08 ']);
            fnMeasBkgr = cellstr(['C1G225_he0_ve0_hs0_vs0_2008-09-15_00-23-11';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-23-11';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-23-45';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-23-45';
                                  'C1G225_he0_ve0_hs0_vs0_2008-09-15_00-23-45']);
        end
    elseif (gap >= 0.5*(225 + 240))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G240_he-10_ve0_hs0_vs0_2008-09-14_23-52-55';
                                  'C1G240_he-5_ve0_hs0_vs0_2008-09-14_23-53-05 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-53-15  ';
                                  'C1G240_he5_ve0_hs0_vs0_2008-09-14_23-53-26  ';
                                  'C1G240_he10_ve0_hs0_vs0_2008-09-14_23-53-36 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-09-14_23-52-44';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-52-44';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-53-15';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-53-15';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-53-15']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G240_he0_ve-10_hs0_vs0_2008-09-14_23-53-58';
                                  'C1G240_he0_ve-5_hs0_vs0_2008-09-14_23-54-08 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-54-18  ';
                                  'C1G240_he0_ve5_hs0_vs0_2008-09-14_23-54-30  ';
                                  'C1G240_he0_ve10_hs0_vs0_2008-09-14_23-54-41 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-09-14_23-53-48';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-53-48';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-54-18';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-54-18';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-54-18']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G240_he0_ve0_hs-10_vs0_2008-09-14_23-55-03';
                                  'C1G240_he0_ve0_hs-5_vs0_2008-09-14_23-55-13 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-55-23  ';
                                  'C1G240_he0_ve0_hs5_vs0_2008-09-14_23-55-34  ';
                                  'C1G240_he0_ve0_hs10_vs0_2008-09-14_23-55-45 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-09-14_23-54-53';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-54-53';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-55-23';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-55-23';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-55-23']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G240_he0_ve0_hs0_vs-10_2008-09-14_23-56-06';
                                  'C1G240_he0_ve0_hs0_vs-5_2008-09-14_23-56-16 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-56-26  ';
                                  'C1G240_he0_ve0_hs0_vs5_2008-09-14_23-56-38  ';
                                  'C1G240_he0_ve0_hs0_vs10_2008-09-14_23-56-48 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-09-14_23-55-56';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-55-56';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-56-26';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-56-26';
                                  'C1G240_he0_ve0_hs0_vs0_2008-09-14_23-56-26']);
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU60 ANTARES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(idName, 'HU60_ANTARES')
    vCurVals = [-10, -5, 0, 5, 10];
    if (gap < 0.5*(15.5 + 18))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G15_5_he-10_ve0_hs0_vs0_2009-07-21_07-34-22';
                                  'C1G15_5_he-5_ve0_hs0_vs0_2009-07-21_07-34-34 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-34-45  ';
                                  'C1G15_5_he5_ve0_hs0_vs0_2009-07-21_07-34-56  ';
                                  'C1G15_5_he10_ve0_hs0_vs0_2009-07-21_07-35-08 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-34-09';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-34-09';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-34-45';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-34-45';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-34-45']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G15_5_he0_ve-10_hs0_vs0_2009-07-21_07-35-35';
                                  'C1G15_5_he0_ve-5_hs0_vs0_2009-07-21_07-35-46 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-35-57  ';
                                  'C1G15_5_he0_ve5_hs0_vs0_2009-07-21_07-36-09  ';
                                  'C1G15_5_he0_ve10_hs0_vs0_2009-07-21_07-36-22 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-35-21';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-35-21';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-35-57';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-35-57';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-35-57']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G15_5_he0_ve0_hs-10_vs0_2009-07-21_07-36-48';
                                  'C1G15_5_he0_ve0_hs-5_vs0_2009-07-21_07-37-00 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-37-12  ';
                                  'C1G15_5_he0_ve0_hs5_vs0_2009-07-21_07-37-23  ';
                                  'C1G15_5_he0_ve0_hs10_vs0_2009-07-21_07-37-34 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-36-35';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-36-35';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-37-12';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-37-12';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-37-12']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G15_5_he0_ve0_hs0_vs-10_2009-07-21_07-38-01';
                                  'C1G15_5_he0_ve0_hs0_vs-5_2009-07-21_07-38-12 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-38-23  ';
                                  'C1G15_5_he0_ve0_hs0_vs5_2009-07-21_07-38-35  ';
                                  'C1G15_5_he0_ve0_hs0_vs10_2009-07-21_07-38-47 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-37-47';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-37-47';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-38-23';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-38-23';
                                  'C1G15_5_he0_ve0_hs0_vs0_2009-07-21_07-38-23']);
        end
    elseif (gap < 0.5*(18 + 20))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G18_he-10_ve0_hs0_vs0_2009-07-21_07-39-28';
                                  'C1G18_he-5_ve0_hs0_vs0_2009-07-21_07-39-39 ';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-39-51  ';
                                  'C1G18_he5_ve0_hs0_vs0_2009-07-21_07-40-03  ';
                                  'C1G18_he10_ve0_hs0_vs0_2009-07-21_07-40-14 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2009-07-21_07-39-15';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-39-15';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-39-51';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-39-51';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-39-51']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G18_he0_ve-10_hs0_vs0_2009-07-21_07-40-40';
                                  'C1G18_he0_ve-5_hs0_vs0_2009-07-21_07-40-53 ';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-41-05  ';
                                  'C1G18_he0_ve5_hs0_vs0_2009-07-21_07-41-17  ';
                                  'C1G18_he0_ve10_hs0_vs0_2009-07-21_07-41-28 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2009-07-21_07-40-27';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-40-27';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-41-05';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-41-05';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-41-05']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G18_he0_ve0_hs-10_vs0_2009-07-21_07-41-54';
                                  'C1G18_he0_ve0_hs-5_vs0_2009-07-21_07-42-06 ';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-42-17  ';
                                  'C1G18_he0_ve0_hs5_vs0_2009-07-21_07-42-28  ';
                                  'C1G18_he0_ve0_hs10_vs0_2009-07-21_07-42-40 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2009-07-21_07-41-41';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-41-41';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-42-17';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-42-17';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-42-17']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G18_he0_ve0_hs0_vs-10_2009-07-21_07-43-05';
                                  'C1G18_he0_ve0_hs0_vs-5_2009-07-21_07-43-17 ';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-43-28  ';
                                  'C1G18_he0_ve0_hs0_vs5_2009-07-21_07-43-39  ';
                                  'C1G18_he0_ve0_hs0_vs10_2009-07-21_07-43-51 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2009-07-21_07-42-52';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-42-52';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-43-28';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-43-28';
                                  'C1G18_he0_ve0_hs0_vs0_2009-07-21_07-43-28']);
        end
    elseif (gap < 0.5*(20 + 22.5))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G20_he-10_ve0_hs0_vs0_2009-07-21_07-45-28';
                                  'C1G20_he-5_ve0_hs0_vs0_2009-07-21_07-45-39 ';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-45-51  ';
                                  'C1G20_he5_ve0_hs0_vs0_2009-07-21_07-46-02  ';
                                  'C1G20_he10_ve0_hs0_vs0_2009-07-21_07-46-14 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2009-07-21_07-45-14';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-45-14';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-45-51';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-45-51';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-45-51']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G20_he0_ve-10_hs0_vs0_2009-07-21_07-46-38';
                                  'C1G20_he0_ve-5_hs0_vs0_2009-07-21_07-46-50 ';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-47-01  ';
                                  'C1G20_he0_ve5_hs0_vs0_2009-07-21_07-47-12  ';
                                  'C1G20_he0_ve10_hs0_vs0_2009-07-21_07-47-24 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2009-07-21_07-46-26';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-46-26';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-47-01';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-47-01';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-47-01']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G20_he0_ve0_hs-10_vs0_2009-07-21_07-47-50';
                                  'C1G20_he0_ve0_hs-5_vs0_2009-07-21_07-48-02 ';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-48-13  ';
                                  'C1G20_he0_ve0_hs5_vs0_2009-07-21_07-48-25  ';
                                  'C1G20_he0_ve0_hs10_vs0_2009-07-21_07-48-36 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2009-07-21_07-47-37';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-47-37';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-48-13';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-48-13';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-48-13']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G20_he0_ve0_hs0_vs-10_2009-07-21_07-49-01';
                                  'C1G20_he0_ve0_hs0_vs-5_2009-07-21_07-49-13 ';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-49-24  ';
                                  'C1G20_he0_ve0_hs0_vs5_2009-07-21_07-49-36  ';
                                  'C1G20_he0_ve0_hs0_vs10_2009-07-21_07-49-48 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2009-07-21_07-48-48';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-48-48';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-49-24';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-49-24';
                                  'C1G20_he0_ve0_hs0_vs0_2009-07-21_07-49-24']);
        end
    elseif (gap < 0.5*(22.5 + 25))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G22_5_he-10_ve0_hs0_vs0_2009-07-21_07-50-46';
                                  'C1G22_5_he-5_ve0_hs0_vs0_2009-07-21_07-50-58 ';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-51-10  ';
                                  'C1G22_5_he5_ve0_hs0_vs0_2009-07-21_07-51-21  ';
                                  'C1G22_5_he10_ve0_hs0_vs0_2009-07-21_07-51-32 ']);
            fnMeasBkgr = cellstr(['C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-50-33';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-50-33';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-51-10';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-51-10';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-51-10']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G22_5_he0_ve-10_hs0_vs0_2009-07-21_07-51-58';
                                  'C1G22_5_he0_ve-5_hs0_vs0_2009-07-21_07-52-10 ';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-52-22  ';
                                  'C1G22_5_he0_ve5_hs0_vs0_2009-07-21_07-52-35  ';
                                  'C1G22_5_he0_ve10_hs0_vs0_2009-07-21_07-52-47 ']);
            fnMeasBkgr = cellstr(['C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-51-46';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-51-46';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-52-22';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-52-22';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-52-22']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G22_5_he0_ve0_hs-10_vs0_2009-07-21_07-53-12';
                                  'C1G22_5_he0_ve0_hs-5_vs0_2009-07-21_07-53-24 ';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-53-35  ';
                                  'C1G22_5_he0_ve0_hs5_vs0_2009-07-21_07-53-46  ';
                                  'C1G22_5_he0_ve0_hs10_vs0_2009-07-21_07-53-58 ']);
            fnMeasBkgr = cellstr(['C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-52-59';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-52-59';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-53-35';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-53-35';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-53-35']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G22_5_he0_ve0_hs0_vs-10_2009-07-21_07-54-24';
                                  'C1G22_5_he0_ve0_hs0_vs-5_2009-07-21_07-54-36 ';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-54-48  ';
                                  'C1G22_5_he0_ve0_hs0_vs5_2009-07-21_07-55-00  ';
                                  'C1G22_5_he0_ve0_hs0_vs10_2009-07-21_07-55-11 ']);
            fnMeasBkgr = cellstr(['C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-54-11';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-54-11';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-54-48';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-54-48';
                                  'C1G22_5_he0_ve0_hs0_vs0_2009-07-21_07-54-48']);
        end
    elseif (gap < 0.5*(25 + 27.5))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G25_he-10_ve0_hs0_vs0_2009-07-21_07-55-55';
                                  'C1G25_he-5_ve0_hs0_vs0_2009-07-21_07-56-06 ';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-56-17  ';
                                  'C1G25_he5_ve0_hs0_vs0_2009-07-21_07-56-29  ';
                                  'C1G25_he10_ve0_hs0_vs0_2009-07-21_07-56-41 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2009-07-21_07-55-42';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-55-42';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-56-17';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-56-17';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-56-17']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G25_he0_ve-10_hs0_vs0_2009-07-21_07-57-08';
                                  'C1G25_he0_ve-5_hs0_vs0_2009-07-21_07-57-19 ';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-57-30  ';
                                  'C1G25_he0_ve5_hs0_vs0_2009-07-21_07-57-42  ';
                                  'C1G25_he0_ve10_hs0_vs0_2009-07-21_07-57-54 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2009-07-21_07-56-55';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-56-55';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-57-30';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-57-30';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-57-30']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G25_he0_ve0_hs-10_vs0_2009-07-21_07-58-21';
                                  'C1G25_he0_ve0_hs-5_vs0_2009-07-21_07-58-33 ';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-58-44  ';
                                  'C1G25_he0_ve0_hs5_vs0_2009-07-21_07-58-55  ';
                                  'C1G25_he0_ve0_hs10_vs0_2009-07-21_07-59-07 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2009-07-21_07-58-08';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-58-08';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-58-44';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-58-44';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-58-44']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G25_he0_ve0_hs0_vs-10_2009-07-21_07-59-33';
                                  'C1G25_he0_ve0_hs0_vs-5_2009-07-21_07-59-44 ';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-59-55  ';
                                  'C1G25_he0_ve0_hs0_vs5_2009-07-21_08-00-07  ';
                                  'C1G25_he0_ve0_hs0_vs10_2009-07-21_08-00-18 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2009-07-21_07-59-20';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-59-20';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-59-55';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-59-55';
                                  'C1G25_he0_ve0_hs0_vs0_2009-07-21_07-59-55']);
        end
    elseif (gap < 0.5*(27.5 + 30))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G27_5_he-10_ve0_hs0_vs0_2009-07-21_08-01-28';
                                  'C1G27_5_he-5_ve0_hs0_vs0_2009-07-21_08-01-39 ';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-01-50  ';
                                  'C1G27_5_he5_ve0_hs0_vs0_2009-07-21_08-02-02  ';
                                  'C1G27_5_he10_ve0_hs0_vs0_2009-07-21_08-02-14 ']);
            fnMeasBkgr = cellstr(['C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-01-14';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-01-14';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-01-50';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-01-50';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-01-50']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G27_5_he0_ve-10_hs0_vs0_2009-07-21_08-02-40';
                                  'C1G27_5_he0_ve-5_hs0_vs0_2009-07-21_08-02-52 ';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-03-04  ';
                                  'C1G27_5_he0_ve5_hs0_vs0_2009-07-21_08-03-15  ';
                                  'C1G27_5_he0_ve10_hs0_vs0_2009-07-21_08-03-28 ']);
            fnMeasBkgr = cellstr(['C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-02-27';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-02-27';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-03-04';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-03-04';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-03-04']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G27_5_he0_ve0_hs-10_vs0_2009-07-21_08-03-53';
                                  'C1G27_5_he0_ve0_hs-5_vs0_2009-07-21_08-04-05 ';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-04-16  ';
                                  'C1G27_5_he0_ve0_hs5_vs0_2009-07-21_08-04-27  ';
                                  'C1G27_5_he0_ve0_hs10_vs0_2009-07-21_08-04-39 ']);
            fnMeasBkgr = cellstr(['C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-03-41';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-03-41';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-04-16';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-04-16';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-04-16']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G27_5_he0_ve0_hs0_vs-10_2009-07-21_08-05-06';
                                  'C1G27_5_he0_ve0_hs0_vs-5_2009-07-21_08-05-18 ';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-05-29  ';
                                  'C1G27_5_he0_ve0_hs0_vs5_2009-07-21_08-05-41  ';
                                  'C1G27_5_he0_ve0_hs0_vs10_2009-07-21_08-05-52 ']);
            fnMeasBkgr = cellstr(['C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-04-53';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-04-53';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-05-29';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-05-29';
                                  'C1G27_5_he0_ve0_hs0_vs0_2009-07-21_08-05-29']);
        end
    elseif (gap < 0.5*(30 + 35))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G30_he-10_ve0_hs0_vs0_2009-07-21_08-06-27';
                                  'C1G30_he-5_ve0_hs0_vs0_2009-07-21_08-06-38 ';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-06-50  ';
                                  'C1G30_he5_ve0_hs0_vs0_2009-07-21_08-07-01  ';
                                  'C1G30_he10_ve0_hs0_vs0_2009-07-21_08-07-13 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2009-07-21_08-06-15';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-06-15';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-06-50';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-06-50';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-06-50']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G30_he0_ve-10_hs0_vs0_2009-07-21_08-07-39';
                                  'C1G30_he0_ve-5_hs0_vs0_2009-07-21_08-07-51 ';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-08-03  ';
                                  'C1G30_he0_ve5_hs0_vs0_2009-07-21_08-08-15  ';
                                  'C1G30_he0_ve10_hs0_vs0_2009-07-21_08-08-26 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2009-07-21_08-07-26';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-07-26';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-08-03';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-08-03';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-08-03']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G30_he0_ve0_hs-10_vs0_2009-07-21_08-08-53';
                                  'C1G30_he0_ve0_hs-5_vs0_2009-07-21_08-09-05 ';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-09-17  ';
                                  'C1G30_he0_ve0_hs5_vs0_2009-07-21_08-09-29  ';
                                  'C1G30_he0_ve0_hs10_vs0_2009-07-21_08-09-40 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2009-07-21_08-08-40';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-08-40';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-09-17';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-09-17';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-09-17']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G30_he0_ve0_hs0_vs-10_2009-07-21_08-10-06';
                                  'C1G30_he0_ve0_hs0_vs-5_2009-07-21_08-10-19 ';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-10-31  ';
                                  'C1G30_he0_ve0_hs0_vs5_2009-07-21_08-10-42  ';
                                  'C1G30_he0_ve0_hs0_vs10_2009-07-21_08-10-54 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2009-07-21_08-09-53';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-09-53';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-10-31';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-10-31';
                                  'C1G30_he0_ve0_hs0_vs0_2009-07-21_08-10-31']);
        end
    elseif (gap < 0.5*(35 + 40))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G35_he-10_ve0_hs0_vs0_2009-07-21_08-11-28';
                                  'C1G35_he-5_ve0_hs0_vs0_2009-07-21_08-11-39 ';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-11-51  ';
                                  'C1G35_he5_ve0_hs0_vs0_2009-07-21_08-12-02  ';
                                  'C1G35_he10_ve0_hs0_vs0_2009-07-21_08-12-13 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2009-07-21_08-11-15';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-11-15';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-11-51';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-11-51';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-11-51']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G35_he0_ve-10_hs0_vs0_2009-07-21_08-12-39';
                                  'C1G35_he0_ve-5_hs0_vs0_2009-07-21_08-12-51 ';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-13-02  ';
                                  'C1G35_he0_ve5_hs0_vs0_2009-07-21_08-13-16  ';
                                  'C1G35_he0_ve10_hs0_vs0_2009-07-21_08-13-27 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2009-07-21_08-12-26';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-12-26';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-13-02';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-13-02';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-13-02']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G35_he0_ve0_hs-10_vs0_2009-07-21_08-13-52';
                                  'C1G35_he0_ve0_hs-5_vs0_2009-07-21_08-14-03 ';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-14-15  ';
                                  'C1G35_he0_ve0_hs5_vs0_2009-07-21_08-14-26  ';
                                  'C1G35_he0_ve0_hs10_vs0_2009-07-21_08-14-40 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2009-07-21_08-13-40';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-13-40';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-14-15';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-14-15';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-14-15']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G35_he0_ve0_hs0_vs-10_2009-07-21_08-15-06';
                                  'C1G35_he0_ve0_hs0_vs-5_2009-07-21_08-15-19 ';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-15-31  ';
                                  'C1G35_he0_ve0_hs0_vs5_2009-07-21_08-15-42  ';
                                  'C1G35_he0_ve0_hs0_vs10_2009-07-21_08-15-53 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2009-07-21_08-14-53';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-14-53';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-15-31';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-15-31';
                                  'C1G35_he0_ve0_hs0_vs0_2009-07-21_08-15-31']);
        end
    elseif (gap < 0.5*(40 + 50))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G40_he-10_ve0_hs0_vs0_2009-07-21_08-16-44';
                                  'C1G40_he-5_ve0_hs0_vs0_2009-07-21_08-16-56 ';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-17-08  ';
                                  'C1G40_he5_ve0_hs0_vs0_2009-07-21_08-17-19  ';
                                  'C1G40_he10_ve0_hs0_vs0_2009-07-21_08-17-31 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2009-07-21_08-16-31';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-16-31';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-17-08';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-17-08';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-17-08']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G40_he0_ve-10_hs0_vs0_2009-07-21_08-17-57';
                                  'C1G40_he0_ve-5_hs0_vs0_2009-07-21_08-18-09 ';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-18-20  ';
                                  'C1G40_he0_ve5_hs0_vs0_2009-07-21_08-18-32  ';
                                  'C1G40_he0_ve10_hs0_vs0_2009-07-21_08-18-44 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2009-07-21_08-17-44';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-17-44';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-18-20';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-18-20';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-18-20']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G40_he0_ve0_hs-10_vs0_2009-07-21_08-19-10';
                                  'C1G40_he0_ve0_hs-5_vs0_2009-07-21_08-19-21 ';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-19-32  ';
                                  'C1G40_he0_ve0_hs5_vs0_2009-07-21_08-19-44  ';
                                  'C1G40_he0_ve0_hs10_vs0_2009-07-21_08-19-56 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2009-07-21_08-18-57';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-18-57';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-19-32';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-19-32';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-19-32']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G40_he0_ve0_hs0_vs-10_2009-07-21_08-20-21';
                                  'C1G40_he0_ve0_hs0_vs-5_2009-07-21_08-20-32 ';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-20-43  ';
                                  'C1G40_he0_ve0_hs0_vs5_2009-07-21_08-20-55  ';
                                  'C1G40_he0_ve0_hs0_vs10_2009-07-21_08-21-07 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2009-07-21_08-20-08';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-20-08';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-20-43';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-20-43';
                                  'C1G40_he0_ve0_hs0_vs0_2009-07-21_08-20-43']);
        end
    elseif (gap < 0.5*(50 + 60))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G50_he-10_ve0_hs0_vs0_2009-07-21_08-21-45';
                                  'C1G50_he-5_ve0_hs0_vs0_2009-07-21_08-21-56 ';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-22-07  ';
                                  'C1G50_he5_ve0_hs0_vs0_2009-07-21_08-22-19  ';
                                  'C1G50_he10_ve0_hs0_vs0_2009-07-21_08-22-31 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2009-07-21_08-21-33';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-21-33';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-22-07';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-22-07';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-22-07']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G50_he0_ve-10_hs0_vs0_2009-07-21_08-22-57';
                                  'C1G50_he0_ve-5_hs0_vs0_2009-07-21_08-23-09 ';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-23-20  ';
                                  'C1G50_he0_ve5_hs0_vs0_2009-07-21_08-23-32  ';
                                  'C1G50_he0_ve10_hs0_vs0_2009-07-21_08-23-43 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2009-07-21_08-22-44';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-22-44';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-23-20';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-23-20';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-23-20']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G50_he0_ve0_hs-10_vs0_2009-07-21_08-24-09';
                                  'C1G50_he0_ve0_hs-5_vs0_2009-07-21_08-24-21 ';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-24-32  ';
                                  'C1G50_he0_ve0_hs5_vs0_2009-07-21_08-24-44  ';
                                  'C1G50_he0_ve0_hs10_vs0_2009-07-21_08-24-56 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2009-07-21_08-23-56';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-23-56';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-24-32';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-24-32';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-24-32']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G50_he0_ve0_hs0_vs-10_2009-07-21_08-25-23';
                                  'C1G50_he0_ve0_hs0_vs-5_2009-07-21_08-25-34 ';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-25-46  ';
                                  'C1G50_he0_ve0_hs0_vs5_2009-07-21_08-25-57  ';
                                  'C1G50_he0_ve0_hs0_vs10_2009-07-21_08-26-09 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2009-07-21_08-25-10';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-25-10';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-25-46';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-25-46';
                                  'C1G50_he0_ve0_hs0_vs0_2009-07-21_08-25-46']);
        end
    elseif (gap < 0.5*(60 + 70))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G60_he-10_ve0_hs0_vs0_2009-07-21_08-26-45';
                                  'C1G60_he-5_ve0_hs0_vs0_2009-07-21_08-26-56 ';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-27-07  ';
                                  'C1G60_he5_ve0_hs0_vs0_2009-07-21_08-27-19  ';
                                  'C1G60_he10_ve0_hs0_vs0_2009-07-21_08-27-30 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2009-07-21_08-26-31';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-26-31';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-27-07';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-27-07';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-27-07']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G60_he0_ve-10_hs0_vs0_2009-07-21_08-27-56';
                                  'C1G60_he0_ve-5_hs0_vs0_2009-07-21_08-28-08 ';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-28-19  ';
                                  'C1G60_he0_ve5_hs0_vs0_2009-07-21_08-28-30  ';
                                  'C1G60_he0_ve10_hs0_vs0_2009-07-21_08-28-42 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2009-07-21_08-27-43';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-27-43';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-28-19';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-28-19';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-28-19']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G60_he0_ve0_hs-10_vs0_2009-07-21_08-29-08';
                                  'C1G60_he0_ve0_hs-5_vs0_2009-07-21_08-29-19 ';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-29-30  ';
                                  'C1G60_he0_ve0_hs5_vs0_2009-07-21_08-29-41  ';
                                  'C1G60_he0_ve0_hs10_vs0_2009-07-21_08-29-53 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2009-07-21_08-28-55';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-28-55';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-29-30';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-29-30';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-29-30']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G60_he0_ve0_hs0_vs-10_2009-07-21_08-30-20';
                                  'C1G60_he0_ve0_hs0_vs-5_2009-07-21_08-30-31 ';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-30-43  ';
                                  'C1G60_he0_ve0_hs0_vs5_2009-07-21_08-30-54  ';
                                  'C1G60_he0_ve0_hs0_vs10_2009-07-21_08-31-05 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2009-07-21_08-30-06';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-30-06';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-30-43';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-30-43';
                                  'C1G60_he0_ve0_hs0_vs0_2009-07-21_08-30-43']);
        end
    elseif (gap < 0.5*(70 + 80))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G70_he-10_ve0_hs0_vs0_2009-07-21_08-31-39';
                                  'C1G70_he-5_ve0_hs0_vs0_2009-07-21_08-31-50 ';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-32-02  ';
                                  'C1G70_he5_ve0_hs0_vs0_2009-07-21_08-32-13  ';
                                  'C1G70_he10_ve0_hs0_vs0_2009-07-21_08-32-25 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2009-07-21_08-31-26';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-31-26';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-32-02';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-32-02';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-32-02']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G70_he0_ve-10_hs0_vs0_2009-07-21_08-32-51';
                                  'C1G70_he0_ve-5_hs0_vs0_2009-07-21_08-33-02 ';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-33-13  ';
                                  'C1G70_he0_ve5_hs0_vs0_2009-07-21_08-33-24  ';
                                  'C1G70_he0_ve10_hs0_vs0_2009-07-21_08-33-36 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2009-07-21_08-32-37';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-32-37';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-33-13';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-33-13';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-33-13']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G70_he0_ve0_hs-10_vs0_2009-07-21_08-34-02';
                                  'C1G70_he0_ve0_hs-5_vs0_2009-07-21_08-34-13 ';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-34-24  ';
                                  'C1G70_he0_ve0_hs5_vs0_2009-07-21_08-34-36  ';
                                  'C1G70_he0_ve0_hs10_vs0_2009-07-21_08-34-48 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2009-07-21_08-33-49';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-33-49';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-34-24';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-34-24';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-34-24']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G70_he0_ve0_hs0_vs-10_2009-07-21_08-35-13';
                                  'C1G70_he0_ve0_hs0_vs-5_2009-07-21_08-35-25 ';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-35-36  ';
                                  'C1G70_he0_ve0_hs0_vs5_2009-07-21_08-35-47  ';
                                  'C1G70_he0_ve0_hs0_vs10_2009-07-21_08-35-59 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2009-07-21_08-35-00';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-35-00';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-35-36';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-35-36';
                                  'C1G70_he0_ve0_hs0_vs0_2009-07-21_08-35-36']);
        end
    elseif (gap < 0.5*(80 + 90))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G80_he-10_ve0_hs0_vs0_2009-07-21_08-37-03';
                                  'C1G80_he-5_ve0_hs0_vs0_2009-07-21_08-37-15 ';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-37-27  ';
                                  'C1G80_he5_ve0_hs0_vs0_2009-07-21_08-37-38  ';
                                  'C1G80_he10_ve0_hs0_vs0_2009-07-21_08-37-50 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2009-07-21_08-36-50';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-36-50';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-37-27';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-37-27';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-37-27']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G80_he0_ve-10_hs0_vs0_2009-07-21_08-38-16';
                                  'C1G80_he0_ve-5_hs0_vs0_2009-07-21_08-38-28 ';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-38-40  ';
                                  'C1G80_he0_ve5_hs0_vs0_2009-07-21_08-38-51  ';
                                  'C1G80_he0_ve10_hs0_vs0_2009-07-21_08-39-03 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2009-07-21_08-38-03';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-38-03';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-38-40';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-38-40';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-38-40']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G80_he0_ve0_hs-10_vs0_2009-07-21_08-39-29';
                                  'C1G80_he0_ve0_hs-5_vs0_2009-07-21_08-39-40 ';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-39-52  ';
                                  'C1G80_he0_ve0_hs5_vs0_2009-07-21_08-40-03  ';
                                  'C1G80_he0_ve0_hs10_vs0_2009-07-21_08-40-15 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2009-07-21_08-39-16';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-39-16';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-39-52';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-39-52';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-39-52']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G80_he0_ve0_hs0_vs-10_2009-07-21_08-40-42';
                                  'C1G80_he0_ve0_hs0_vs-5_2009-07-21_08-40-53 ';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-41-05  ';
                                  'C1G80_he0_ve0_hs0_vs5_2009-07-21_08-41-16  ';
                                  'C1G80_he0_ve0_hs0_vs10_2009-07-21_08-41-29 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2009-07-21_08-40-28';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-40-28';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-41-05';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-41-05';
                                  'C1G80_he0_ve0_hs0_vs0_2009-07-21_08-41-05']);
        end
    elseif (gap < 0.5*(90 + 100))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G90_he-10_ve0_hs0_vs0_2009-07-21_08-42-04';
                                  'C1G90_he-5_ve0_hs0_vs0_2009-07-21_08-42-16 ';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-42-27  ';
                                  'C1G90_he5_ve0_hs0_vs0_2009-07-21_08-42-38  ';
                                  'C1G90_he10_ve0_hs0_vs0_2009-07-21_08-42-50 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2009-07-21_08-41-51';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-41-51';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-42-27';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-42-27';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-42-27']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G90_he0_ve-10_hs0_vs0_2009-07-21_08-43-17';
                                  'C1G90_he0_ve-5_hs0_vs0_2009-07-21_08-43-28 ';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-43-39  ';
                                  'C1G90_he0_ve5_hs0_vs0_2009-07-21_08-43-51  ';
                                  'C1G90_he0_ve10_hs0_vs0_2009-07-21_08-44-04 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2009-07-21_08-43-03';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-43-03';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-43-39';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-43-39';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-43-39']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G90_he0_ve0_hs-10_vs0_2009-07-21_08-44-30';
                                  'C1G90_he0_ve0_hs-5_vs0_2009-07-21_08-44-42 ';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-44-53  ';
                                  'C1G90_he0_ve0_hs5_vs0_2009-07-21_08-45-05  ';
                                  'C1G90_he0_ve0_hs10_vs0_2009-07-21_08-45-17 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2009-07-21_08-44-17';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-44-17';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-44-53';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-44-53';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-44-53']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G90_he0_ve0_hs0_vs-10_2009-07-21_08-45-43';
                                  'C1G90_he0_ve0_hs0_vs-5_2009-07-21_08-45-54 ';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-46-05  ';
                                  'C1G90_he0_ve0_hs0_vs5_2009-07-21_08-46-17  ';
                                  'C1G90_he0_ve0_hs0_vs10_2009-07-21_08-46-29 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2009-07-21_08-45-30';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-45-30';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-46-05';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-46-05';
                                  'C1G90_he0_ve0_hs0_vs0_2009-07-21_08-46-05']);
        end
    elseif (gap < 0.5*(100 + 110))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G100_he-10_ve0_hs0_vs0_2009-07-21_08-47-11';
                                  'C1G100_he-5_ve0_hs0_vs0_2009-07-21_08-47-23 ';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-47-35  ';
                                  'C1G100_he5_ve0_hs0_vs0_2009-07-21_08-47-47  ';
                                  'C1G100_he10_ve0_hs0_vs0_2009-07-21_08-47-58 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2009-07-21_08-46-59';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-46-59';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-47-35';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-47-35';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-47-35']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G100_he0_ve-10_hs0_vs0_2009-07-21_08-48-24';
                                  'C1G100_he0_ve-5_hs0_vs0_2009-07-21_08-48-36 ';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-48-47  ';
                                  'C1G100_he0_ve5_hs0_vs0_2009-07-21_08-48-59  ';
                                  'C1G100_he0_ve10_hs0_vs0_2009-07-21_08-49-10 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2009-07-21_08-48-11';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-48-11';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-48-47';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-48-47';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-48-47']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G100_he0_ve0_hs-10_vs0_2009-07-21_08-49-36';
                                  'C1G100_he0_ve0_hs-5_vs0_2009-07-21_08-49-47 ';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-49-58  ';
                                  'C1G100_he0_ve0_hs5_vs0_2009-07-21_08-50-11  ';
                                  'C1G100_he0_ve0_hs10_vs0_2009-07-21_08-50-22 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2009-07-21_08-49-23';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-49-23';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-49-58';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-49-58';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-49-58']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G100_he0_ve0_hs0_vs-10_2009-07-21_08-50-48';
                                  'C1G100_he0_ve0_hs0_vs-5_2009-07-21_08-51-00 ';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-51-11  ';
                                  'C1G100_he0_ve0_hs0_vs5_2009-07-21_08-51-22  ';
                                  'C1G100_he0_ve0_hs0_vs10_2009-07-21_08-51-34 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2009-07-21_08-50-35';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-50-35';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-51-11';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-51-11';
                                  'C1G100_he0_ve0_hs0_vs0_2009-07-21_08-51-11']);
        end
    elseif (gap < 0.5*(110 + 130))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G110_he-10_ve0_hs0_vs0_2009-07-21_08-52-10';
                                  'C1G110_he-5_ve0_hs0_vs0_2009-07-21_08-52-22 ';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-52-33  ';
                                  'C1G110_he5_ve0_hs0_vs0_2009-07-21_08-52-45  ';
                                  'C1G110_he10_ve0_hs0_vs0_2009-07-21_08-52-57 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2009-07-21_08-51-57';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-51-57';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-52-33';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-52-33';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-52-33']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G110_he0_ve-10_hs0_vs0_2009-07-21_08-53-23';
                                  'C1G110_he0_ve-5_hs0_vs0_2009-07-21_08-53-35 ';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-53-46  ';
                                  'C1G110_he0_ve5_hs0_vs0_2009-07-21_08-53-58  ';
                                  'C1G110_he0_ve10_hs0_vs0_2009-07-21_08-54-09 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2009-07-21_08-53-10';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-53-10';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-53-46';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-53-46';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-53-46']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G110_he0_ve0_hs-10_vs0_2009-07-21_08-54-36';
                                  'C1G110_he0_ve0_hs-5_vs0_2009-07-21_08-54-47 ';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-54-59  ';
                                  'C1G110_he0_ve0_hs5_vs0_2009-07-21_08-55-11  ';
                                  'C1G110_he0_ve0_hs10_vs0_2009-07-21_08-55-22 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2009-07-21_08-54-23';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-54-23';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-54-59';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-54-59';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-54-59']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G110_he0_ve0_hs0_vs-10_2009-07-21_08-55-48';
                                  'C1G110_he0_ve0_hs0_vs-5_2009-07-21_08-56-00 ';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-56-11  ';
                                  'C1G110_he0_ve0_hs0_vs5_2009-07-21_08-56-23  ';
                                  'C1G110_he0_ve0_hs0_vs10_2009-07-21_08-56-34 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2009-07-21_08-55-35';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-55-35';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-56-11';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-56-11';
                                  'C1G110_he0_ve0_hs0_vs0_2009-07-21_08-56-11']);
        end
    elseif (gap < 0.5*(130 + 150))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G130_he-10_ve0_hs0_vs0_2009-07-21_08-57-14';
                                  'C1G130_he-5_ve0_hs0_vs0_2009-07-21_08-57-25 ';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_08-57-36  ';
                                  'C1G130_he5_ve0_hs0_vs0_2009-07-21_08-57-48  ';
                                  'C1G130_he10_ve0_hs0_vs0_2009-07-21_08-57-59 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2009-07-21_08-57-01';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_08-57-01';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_08-57-36';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_08-57-36';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_08-57-36']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G130_he0_ve-10_hs0_vs0_2009-07-21_08-58-27';
                                  'C1G130_he0_ve-5_hs0_vs0_2009-07-21_08-58-38 ';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_08-58-50  ';
                                  'C1G130_he0_ve5_hs0_vs0_2009-07-21_08-59-03  ';
                                  'C1G130_he0_ve10_hs0_vs0_2009-07-21_08-59-14 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2009-07-21_08-58-12';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_08-58-12';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_08-58-50';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_08-58-50';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_08-58-50']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G130_he0_ve0_hs-10_vs0_2009-07-21_08-59-40';
                                  'C1G130_he0_ve0_hs-5_vs0_2009-07-21_08-59-52 ';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_09-00-04  ';
                                  'C1G130_he0_ve0_hs5_vs0_2009-07-21_09-00-15  ';
                                  'C1G130_he0_ve0_hs10_vs0_2009-07-21_09-00-29 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2009-07-21_08-59-27';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_08-59-27';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_09-00-04';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_09-00-04';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_09-00-04']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G130_he0_ve0_hs0_vs-10_2009-07-21_09-00-55';
                                  'C1G130_he0_ve0_hs0_vs-5_2009-07-21_09-01-07 ';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_09-01-19  ';
                                  'C1G130_he0_ve0_hs0_vs5_2009-07-21_09-01-31  ';
                                  'C1G130_he0_ve0_hs0_vs10_2009-07-21_09-01-43 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2009-07-21_09-00-42';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_09-00-42';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_09-01-19';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_09-01-19';
                                  'C1G130_he0_ve0_hs0_vs0_2009-07-21_09-01-19']);
        end
    elseif (gap < 0.5*(150 + 175))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G150_he-10_ve0_hs0_vs0_2009-07-21_09-02-21';
                                  'C1G150_he-5_ve0_hs0_vs0_2009-07-21_09-02-34 ';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-02-45  ';
                                  'C1G150_he5_ve0_hs0_vs0_2009-07-21_09-02-57  ';
                                  'C1G150_he10_ve0_hs0_vs0_2009-07-21_09-03-09 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2009-07-21_09-02-08';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-02-08';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-02-45';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-02-45';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-02-45']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G150_he0_ve-10_hs0_vs0_2009-07-21_09-03-35';
                                  'C1G150_he0_ve-5_hs0_vs0_2009-07-21_09-03-48 ';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-03-59  ';
                                  'C1G150_he0_ve5_hs0_vs0_2009-07-21_09-04-11  ';
                                  'C1G150_he0_ve10_hs0_vs0_2009-07-21_09-04-22 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2009-07-21_09-03-22';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-03-22';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-03-59';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-03-59';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-03-59']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G150_he0_ve0_hs-10_vs0_2009-07-21_09-04-49';
                                  'C1G150_he0_ve0_hs-5_vs0_2009-07-21_09-05-00 ';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-05-11  ';
                                  'C1G150_he0_ve0_hs5_vs0_2009-07-21_09-05-23  ';
                                  'C1G150_he0_ve0_hs10_vs0_2009-07-21_09-05-36 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2009-07-21_09-04-35';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-04-35';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-05-11';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-05-11';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-05-11']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G150_he0_ve0_hs0_vs-10_2009-07-21_09-06-03';
                                  'C1G150_he0_ve0_hs0_vs-5_2009-07-21_09-06-14 ';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-06-26  ';
                                  'C1G150_he0_ve0_hs0_vs5_2009-07-21_09-06-37  ';
                                  'C1G150_he0_ve0_hs0_vs10_2009-07-21_09-06-49 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2009-07-21_09-05-49';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-05-49';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-06-26';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-06-26';
                                  'C1G150_he0_ve0_hs0_vs0_2009-07-21_09-06-26']);
        end
    elseif (gap < 0.5*(175 + 200))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G175_he-10_ve0_hs0_vs0_2009-07-21_09-08-02';
                                  'C1G175_he-5_ve0_hs0_vs0_2009-07-21_09-08-14 ';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-08-26  ';
                                  'C1G175_he5_ve0_hs0_vs0_2009-07-21_09-08-37  ';
                                  'C1G175_he10_ve0_hs0_vs0_2009-07-21_09-08-48 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2009-07-21_09-07-47';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-07-47';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-08-26';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-08-26';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-08-26']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G175_he0_ve-10_hs0_vs0_2009-07-21_09-09-15';
                                  'C1G175_he0_ve-5_hs0_vs0_2009-07-21_09-09-26 ';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-09-38  ';
                                  'C1G175_he0_ve5_hs0_vs0_2009-07-21_09-09-49  ';
                                  'C1G175_he0_ve10_hs0_vs0_2009-07-21_09-10-01 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2009-07-21_09-09-01';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-09-01';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-09-38';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-09-38';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-09-38']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G175_he0_ve0_hs-10_vs0_2009-07-21_09-10-27';
                                  'C1G175_he0_ve0_hs-5_vs0_2009-07-21_09-10-38 ';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-10-50  ';
                                  'C1G175_he0_ve0_hs5_vs0_2009-07-21_09-11-01  ';
                                  'C1G175_he0_ve0_hs10_vs0_2009-07-21_09-11-13 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2009-07-21_09-10-14';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-10-14';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-10-50';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-10-50';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-10-50']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G175_he0_ve0_hs0_vs-10_2009-07-21_09-11-40';
                                  'C1G175_he0_ve0_hs0_vs-5_2009-07-21_09-11-51 ';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-12-02  ';
                                  'C1G175_he0_ve0_hs0_vs5_2009-07-21_09-12-13  ';
                                  'C1G175_he0_ve0_hs0_vs10_2009-07-21_09-12-25 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2009-07-21_09-11-27';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-11-27';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-12-02';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-12-02';
                                  'C1G175_he0_ve0_hs0_vs0_2009-07-21_09-12-02']);
        end
    elseif (gap < 0.5*(200 + 225))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G200_he-10_ve0_hs0_vs0_2009-07-21_09-13-08';
                                  'C1G200_he-5_ve0_hs0_vs0_2009-07-21_09-13-20 ';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-13-31  ';
                                  'C1G200_he5_ve0_hs0_vs0_2009-07-21_09-13-43  ';
                                  'C1G200_he10_ve0_hs0_vs0_2009-07-21_09-13-54 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2009-07-21_09-12-55';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-12-55';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-13-31';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-13-31';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-13-31']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G200_he0_ve-10_hs0_vs0_2009-07-21_09-14-19';
                                  'C1G200_he0_ve-5_hs0_vs0_2009-07-21_09-14-31 ';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-14-43  ';
                                  'C1G200_he0_ve5_hs0_vs0_2009-07-21_09-14-55  ';
                                  'C1G200_he0_ve10_hs0_vs0_2009-07-21_09-15-06 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2009-07-21_09-14-07';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-14-07';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-14-43';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-14-43';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-14-43']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G200_he0_ve0_hs-10_vs0_2009-07-21_09-15-32';
                                  'C1G200_he0_ve0_hs-5_vs0_2009-07-21_09-15-43 ';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-15-54  ';
                                  'C1G200_he0_ve0_hs5_vs0_2009-07-21_09-16-06  ';
                                  'C1G200_he0_ve0_hs10_vs0_2009-07-21_09-16-19 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2009-07-21_09-15-19';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-15-19';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-15-54';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-15-54';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-15-54']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G200_he0_ve0_hs0_vs-10_2009-07-21_09-16-46';
                                  'C1G200_he0_ve0_hs0_vs-5_2009-07-21_09-16-57 ';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-17-09  ';
                                  'C1G200_he0_ve0_hs0_vs5_2009-07-21_09-17-20  ';
                                  'C1G200_he0_ve0_hs0_vs10_2009-07-21_09-17-31 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2009-07-21_09-16-32';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-16-32';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-17-09';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-17-09';
                                  'C1G200_he0_ve0_hs0_vs0_2009-07-21_09-17-09']);
        end
    elseif (gap < 0.5*(225 + 240))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G225_he-10_ve0_hs0_vs0_2009-07-21_09-20-54';
                                  'C1G225_he-5_ve0_hs0_vs0_2009-07-21_09-21-05 ';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-21-17  ';
                                  'C1G225_he5_ve0_hs0_vs0_2009-07-21_09-21-29  ';
                                  'C1G225_he10_ve0_hs0_vs0_2009-07-21_09-21-40 ']);
            fnMeasBkgr = cellstr(['C1G225_he0_ve0_hs0_vs0_2009-07-21_09-20-40';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-20-40';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-21-17';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-21-17';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-21-17']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G225_he0_ve-10_hs0_vs0_2009-07-21_09-22-07';
                                  'C1G225_he0_ve-5_hs0_vs0_2009-07-21_09-22-20 ';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-22-32  ';
                                  'C1G225_he0_ve5_hs0_vs0_2009-07-21_09-22-43  ';
                                  'C1G225_he0_ve10_hs0_vs0_2009-07-21_09-22-55 ']);
            fnMeasBkgr = cellstr(['C1G225_he0_ve0_hs0_vs0_2009-07-21_09-21-54';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-21-54';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-22-32';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-22-32';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-22-32']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G225_he0_ve0_hs-10_vs0_2009-07-21_09-23-21';
                                  'C1G225_he0_ve0_hs-5_vs0_2009-07-21_09-23-32 ';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-23-44  ';
                                  'C1G225_he0_ve0_hs5_vs0_2009-07-21_09-23-55  ';
                                  'C1G225_he0_ve0_hs10_vs0_2009-07-21_09-24-07 ']);
            fnMeasBkgr = cellstr(['C1G225_he0_ve0_hs0_vs0_2009-07-21_09-23-08';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-23-08';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-23-44';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-23-44';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-23-44']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G225_he0_ve0_hs0_vs-10_2009-07-21_09-24-33';
                                  'C1G225_he0_ve0_hs0_vs-5_2009-07-21_09-24-44 ';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-24-56  ';
                                  'C1G225_he0_ve0_hs0_vs5_2009-07-21_09-25-07  ';
                                  'C1G225_he0_ve0_hs0_vs10_2009-07-21_09-25-18 ']);
            fnMeasBkgr = cellstr(['C1G225_he0_ve0_hs0_vs0_2009-07-21_09-24-19';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-24-19';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-24-56';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-24-56';
                                  'C1G225_he0_ve0_hs0_vs0_2009-07-21_09-24-56']);
        end
    elseif (gap >= 0.5*(225 + 240))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G240_he-10_ve0_hs0_vs0_2009-07-21_09-26-06';
                                  'C1G240_he-5_ve0_hs0_vs0_2009-07-21_09-26-17 ';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-26-29  ';
                                  'C1G240_he5_ve0_hs0_vs0_2009-07-21_09-26-40  ';
                                  'C1G240_he10_ve0_hs0_vs0_2009-07-21_09-26-52 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2009-07-21_09-25-53';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-25-53';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-26-29';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-26-29';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-26-29']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G240_he0_ve-10_hs0_vs0_2009-07-21_09-27-18';
                                  'C1G240_he0_ve-5_hs0_vs0_2009-07-21_09-27-29 ';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-27-41  ';
                                  'C1G240_he0_ve5_hs0_vs0_2009-07-21_09-27-52  ';
                                  'C1G240_he0_ve10_hs0_vs0_2009-07-21_09-28-04 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2009-07-21_09-27-05';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-27-05';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-27-41';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-27-41';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-27-41']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G240_he0_ve0_hs-10_vs0_2009-07-21_09-28-30';
                                  'C1G240_he0_ve0_hs-5_vs0_2009-07-21_09-28-41 ';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-28-53  ';
                                  'C1G240_he0_ve0_hs5_vs0_2009-07-21_09-29-06  ';
                                  'C1G240_he0_ve0_hs10_vs0_2009-07-21_09-29-17 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2009-07-21_09-28-17';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-28-17';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-28-53';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-28-53';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-28-53']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G240_he0_ve0_hs0_vs-10_2009-07-21_09-29-44';
                                  'C1G240_he0_ve0_hs0_vs-5_2009-07-21_09-29-55 ';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-30-07  ';
                                  'C1G240_he0_ve0_hs0_vs5_2009-07-21_09-30-18  ';
                                  'C1G240_he0_ve0_hs0_vs10_2009-07-21_09-30-32 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2009-07-21_09-29-30';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-29-30';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-30-07';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-30-07';
                                  'C1G240_he0_ve0_hs0_vs0_2009-07-21_09-30-07']);
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU52 DEIMOS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(idName, 'HU52_DEIMOS')
    vCurVals = [-10, -5, 0, 5, 10];
    if (gap < 0.5*(15.5 + 18))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G15_5_he-10_ve0_hs0_vs0_2008-04-13_11-40-06';
                                  'C1G15_5_he-5_ve0_hs0_vs0_2008-04-13_11-40-24 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-40-42  ';
                                  'C1G15_5_he5_ve0_hs0_vs0_2008-04-13_11-40-53  ';
                                  'C1G15_5_he10_ve0_hs0_vs0_2008-04-13_11-41-04 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-39-47';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-39-47';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-40-42';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-40-42';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-40-42']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G15_5_he0_ve-10_hs0_vs0_2008-04-13_11-41-29';
                                  'C1G15_5_he0_ve-5_hs0_vs0_2008-04-13_11-41-41 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-41-52  ';
                                  'C1G15_5_he0_ve5_hs0_vs0_2008-04-13_11-42-04  ';
                                  'C1G15_5_he0_ve10_hs0_vs0_2008-04-13_11-42-16 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-41-17';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-41-17';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-41-52';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-41-52';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-41-52']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G15_5_he0_ve0_hs-10_vs0_2008-04-13_11-42-40';
                                  'C1G15_5_he0_ve0_hs-5_vs0_2008-04-13_11-42-51 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-43-03  ';
                                  'C1G15_5_he0_ve0_hs5_vs0_2008-04-13_11-43-14  ';
                                  'C1G15_5_he0_ve0_hs10_vs0_2008-04-13_11-43-25 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-42-28';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-42-28';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-43-03';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-43-03';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-43-03']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G15_5_he0_ve0_hs0_vs-10_2008-04-13_11-43-50';
                                  'C1G15_5_he0_ve0_hs0_vs-5_2008-04-13_11-44-01 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-44-12  ';
                                  'C1G15_5_he0_ve0_hs0_vs5_2008-04-13_11-44-23  ';
                                  'C1G15_5_he0_ve0_hs0_vs10_2008-04-13_11-44-35 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-43-37';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-43-37';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-44-12';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-44-12';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-04-13_11-44-12']);
        end
    elseif (gap < 0.5*(18 + 20))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G18_he-10_ve0_hs0_vs0_2008-04-13_12-04-40';
                                  'C1G18_he-5_ve0_hs0_vs0_2008-04-13_12-04-51 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-05-02  ';
                                  'C1G18_he5_ve0_hs0_vs0_2008-04-13_12-05-15  ';
                                  'C1G18_he10_ve0_hs0_vs0_2008-04-13_12-05-26 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-04-13_12-04-27';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-04-27';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-05-02';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-05-02';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-05-02']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G18_he0_ve-10_hs0_vs0_2008-04-13_12-05-52';
                                  'C1G18_he0_ve-5_hs0_vs0_2008-04-13_12-06-04 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-06-16  ';
                                  'C1G18_he0_ve5_hs0_vs0_2008-04-13_12-06-29  ';
                                  'C1G18_he0_ve10_hs0_vs0_2008-04-13_12-06-40 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-04-13_12-05-39';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-05-39';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-06-16';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-06-16';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-06-16']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G18_he0_ve0_hs-10_vs0_2008-04-13_12-07-05';
                                  'C1G18_he0_ve0_hs-5_vs0_2008-04-13_12-07-17 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-07-28  ';
                                  'C1G18_he0_ve0_hs5_vs0_2008-04-13_12-07-39  ';
                                  'C1G18_he0_ve0_hs10_vs0_2008-04-13_12-07-51 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-04-13_12-06-53';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-06-53';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-07-28';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-07-28';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-07-28']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G18_he0_ve0_hs0_vs-10_2008-04-13_12-08-15';
                                  'C1G18_he0_ve0_hs0_vs-5_2008-04-13_12-08-27 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-08-38  ';
                                  'C1G18_he0_ve0_hs0_vs5_2008-04-13_12-08-50  ';
                                  'C1G18_he0_ve0_hs0_vs10_2008-04-13_12-09-01 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-04-13_12-08-03';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-08-03';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-08-38';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-08-38';
                                  'C1G18_he0_ve0_hs0_vs0_2008-04-13_12-08-38']);
        end
    elseif (gap < 0.5*(20 + 25))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G20_he-10_ve0_hs0_vs0_2008-04-13_12-10-35';
                                  'C1G20_he-5_ve0_hs0_vs0_2008-04-13_12-10-46 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-10-58  ';
                                  'C1G20_he5_ve0_hs0_vs0_2008-04-13_12-11-09  ';
                                  'C1G20_he10_ve0_hs0_vs0_2008-04-13_12-11-21 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-04-13_12-10-23';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-10-23';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-10-58';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-10-58';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-10-58']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G20_he0_ve-10_hs0_vs0_2008-04-13_12-11-46';
                                  'C1G20_he0_ve-5_hs0_vs0_2008-04-13_12-11-57 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-12-10  ';
                                  'C1G20_he0_ve5_hs0_vs0_2008-04-13_12-12-22  ';
                                  'C1G20_he0_ve10_hs0_vs0_2008-04-13_12-12-35 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-04-13_12-11-33';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-11-33';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-12-10';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-12-10';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-12-10']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G20_he0_ve0_hs-10_vs0_2008-04-13_12-12-59';
                                  'C1G20_he0_ve0_hs-5_vs0_2008-04-13_12-13-10 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-13-21  ';
                                  'C1G20_he0_ve0_hs5_vs0_2008-04-13_12-13-33  ';
                                  'C1G20_he0_ve0_hs10_vs0_2008-04-13_12-13-44 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-04-13_12-12-47';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-12-47';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-13-21';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-13-21';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-13-21']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G20_he0_ve0_hs0_vs-10_2008-04-13_12-14-09';
                                  'C1G20_he0_ve0_hs0_vs-5_2008-04-13_12-14-21 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-14-32  ';
                                  'C1G20_he0_ve0_hs0_vs5_2008-04-13_12-14-44  ';
                                  'C1G20_he0_ve0_hs0_vs10_2008-04-13_12-14-55 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-04-13_12-13-57';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-13-57';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-14-32';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-14-32';
                                  'C1G20_he0_ve0_hs0_vs0_2008-04-13_12-14-32']);
        end
    elseif (gap < 0.5*(25 + 30))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G25_he-10_ve0_hs0_vs0_2008-04-13_12-18-01';
                                  'C1G25_he-5_ve0_hs0_vs0_2008-04-13_12-18-12 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-18-24  ';
                                  'C1G25_he5_ve0_hs0_vs0_2008-04-13_12-18-35  ';
                                  'C1G25_he10_ve0_hs0_vs0_2008-04-13_12-18-47 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-04-13_12-17-48';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-17-48';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-18-24';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-18-24';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-18-24']);                  
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G25_he0_ve-10_hs0_vs0_2008-04-13_12-19-12';
                                  'C1G25_he0_ve-5_hs0_vs0_2008-04-13_12-19-23 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-19-34  ';
                                  'C1G25_he0_ve5_hs0_vs0_2008-04-13_12-19-46  ';
                                  'C1G25_he0_ve10_hs0_vs0_2008-04-13_12-19-57 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-04-13_12-19-34';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-19-34';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-20-10';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-20-10';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-20-10']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G25_he0_ve0_hs-10_vs0_2008-04-13_12-20-22';
                                  'C1G25_he0_ve0_hs-5_vs0_2008-04-13_12-20-34 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-20-45  ';
                                  'C1G25_he0_ve0_hs5_vs0_2008-04-13_12-20-56  ';
                                  'C1G25_he0_ve0_hs10_vs0_2008-04-13_12-21-08 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-04-13_12-20-10';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-20-10';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-20-45';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-20-45';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-20-45']);               
        elseif strcmp(corName, 'CVS')                
            fnMeasMain = cellstr(['C1G25_he0_ve0_hs0_vs-10_2008-04-13_12-21-32';
                                  'C1G25_he0_ve0_hs0_vs-5_2008-04-13_12-21-43 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-21-55  ';
                                  'C1G25_he0_ve0_hs0_vs5_2008-04-13_12-22-06  ';
                                  'C1G25_he0_ve0_hs0_vs10_2008-04-13_12-22-17 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-04-13_12-21-20';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-21-20';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-21-55';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-21-55';
                                  'C1G25_he0_ve0_hs0_vs0_2008-04-13_12-21-55']);
        end
    elseif (gap < 0.5*(30 + 35))
        if strcmp(corName, 'CHE')

            fnMeasMain = cellstr(['C1G30_he-10_ve0_hs0_vs0_2008-04-13_12-25-34';
                                  'C1G30_he-5_ve0_hs0_vs0_2008-04-13_12-25-45 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-25-58  ';
                                  'C1G30_he5_ve0_hs0_vs0_2008-04-13_12-26-09  ';
                                  'C1G30_he10_ve0_hs0_vs0_2008-04-13_12-26-22 ']);

            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-04-13_12-25-21';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-25-21';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-25-58';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-25-58';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-25-58']);

        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G30_he0_ve-10_hs0_vs0_2008-04-13_12-26-46';
                                  'C1G30_he0_ve-5_hs0_vs0_2008-04-13_12-26-58 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-27-09  ';
                                  'C1G30_he0_ve5_hs0_vs0_2008-04-13_12-27-21  ';
                                  'C1G30_he0_ve10_hs0_vs0_2008-04-13_12-27-32 ']);


            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-04-13_12-26-34';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-26-34';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-27-09';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-27-09';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-27-09']);

        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G30_he0_ve0_hs-10_vs0_2008-04-13_12-27-57';
                                  'C1G30_he0_ve0_hs-5_vs0_2008-04-13_12-28-08 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-28-19  ';
                                  'C1G30_he0_ve0_hs5_vs0_2008-04-13_12-28-31  ';
                                  'C1G30_he0_ve0_hs10_vs0_2008-04-13_12-28-42 ']);

            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-04-13_12-27-44';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-27-44';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-28-19';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-28-19';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-28-19']);

        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G30_he0_ve0_hs0_vs-10_2008-04-13_12-29-07';
                                  'C1G30_he0_ve0_hs0_vs-5_2008-04-13_12-29-19 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-29-31  ';
                                  'C1G30_he0_ve0_hs0_vs5_2008-04-13_12-29-43  ';
                                  'C1G30_he0_ve0_hs0_vs10_2008-04-13_12-29-54 ']);

            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-04-13_12-28-55';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-28-55';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-29-31';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-29-31';
                                  'C1G30_he0_ve0_hs0_vs0_2008-04-13_12-29-31']);

        end            
    elseif (gap < 0.5*(35 + 40))
        if strcmp(corName, 'CHE')

            fnMeasMain = cellstr(['C1G35_he-10_ve0_hs0_vs0_2008-04-13_12-42-37';
                                  'C1G35_he-5_ve0_hs0_vs0_2008-04-13_12-42-48 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-43-00  ';
                                  'C1G35_he5_ve0_hs0_vs0_2008-04-13_12-43-11  ';
                                  'C1G35_he10_ve0_hs0_vs0_2008-04-13_12-43-22 ']);

            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-04-13_12-42-24';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-42-24';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-43-00';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-43-00';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-43-00']);

        elseif strcmp(corName, 'CVE')

            fnMeasMain = cellstr(['C1G35_he0_ve-10_hs0_vs0_2008-04-13_12-43-47';
                                  'C1G35_he0_ve-5_hs0_vs0_2008-04-13_12-44-00 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-44-11  ';
                                  'C1G35_he0_ve5_hs0_vs0_2008-04-13_12-44-23  ';
                                  'C1G35_he0_ve10_hs0_vs0_2008-04-13_12-44-34 ']);

            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-04-13_12-43-35';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-43-35';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-44-11';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-44-11';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-44-11']);

        elseif strcmp(corName, 'CHS')

            fnMeasMain = cellstr(['C1G35_he0_ve0_hs-10_vs0_2008-04-13_12-44-59';
                                  'C1G35_he0_ve0_hs-5_vs0_2008-04-13_12-45-10 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-45-22  ';
                                  'C1G35_he0_ve0_hs5_vs0_2008-04-13_12-45-34  ';
                                  'C1G35_he0_ve0_hs10_vs0_2008-04-13_12-45-45 ']);

            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-04-13_12-44-47';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-44-47';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-45-22';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-45-22';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-45-22']);

        elseif strcmp(corName, 'CVS')

            fnMeasMain = cellstr(['C1G35_he0_ve0_hs0_vs-10_2008-04-13_12-46-10';
                                  'C1G35_he0_ve0_hs0_vs-5_2008-04-13_12-46-21 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-46-34  ';
                                  'C1G35_he0_ve0_hs0_vs5_2008-04-13_12-46-45  ';
                                  'C1G35_he0_ve0_hs0_vs10_2008-04-13_12-46-57 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-04-13_12-45-57';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-45-57';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-46-34';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-46-34';
                                  'C1G35_he0_ve0_hs0_vs0_2008-04-13_12-46-34']);

        end
    elseif (gap < 0.5*(40 + 45))
        if strcmp(corName, 'CHE')

            fnMeasMain = cellstr(['C1G40_he-10_ve0_hs0_vs0_2008-04-13_12-59-45';
                                  'C1G40_he-5_ve0_hs0_vs0_2008-04-13_12-59-57 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-00-08  ';
                                  'C1G40_he5_ve0_hs0_vs0_2008-04-13_13-00-19  ';
                                  'C1G40_he10_ve0_hs0_vs0_2008-04-13_13-00-31 ']);

            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-04-13_12-59-32';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_12-59-32';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-00-08';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-00-08';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-00-08']);

        elseif strcmp(corName, 'CVE')

            fnMeasMain = cellstr(['C1G40_he0_ve-10_hs0_vs0_2008-04-13_13-00-56';
                                  'C1G40_he0_ve-5_hs0_vs0_2008-04-13_13-01-08 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-01-19  ';
                                  'C1G40_he0_ve5_hs0_vs0_2008-04-13_13-01-30  ';
                                  'C1G40_he0_ve10_hs0_vs0_2008-04-13_13-01-42 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-04-13_13-00-43';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-00-43';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-01-19';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-01-19';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-01-19']);

        elseif strcmp(corName, 'CHS')

            fnMeasMain = cellstr(['C1G40_he0_ve0_hs-10_vs0_2008-04-13_13-02-07';
                                  'C1G40_he0_ve0_hs-5_vs0_2008-04-13_13-02-18 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-02-30  ';
                                  'C1G40_he0_ve0_hs5_vs0_2008-04-13_13-02-42  ';
                                  'C1G40_he0_ve0_hs10_vs0_2008-04-13_13-02-53 ']);

            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-04-13_13-01-55';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-01-55';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-02-30';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-02-30';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-02-30']);

        elseif strcmp(corName, 'CVS')

            fnMeasMain = cellstr(['C1G40_he0_ve0_hs0_vs-10_2008-04-13_13-03-17';
                                  'C1G40_he0_ve0_hs0_vs-5_2008-04-13_13-03-29 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-03-41  ';
                                  'C1G40_he0_ve0_hs0_vs5_2008-04-13_13-03-53  ';
                                  'C1G40_he0_ve0_hs0_vs10_2008-04-13_13-04-04 ']);

            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-04-13_13-03-05';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-03-05';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-03-41';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-03-41';
                                  'C1G40_he0_ve0_hs0_vs0_2008-04-13_13-03-41']);

        end
    elseif (gap < 0.5*(45 + 50))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G45_he-10_ve0_hs0_vs0_2008-04-13_13-08-34';
                                  'C1G45_he-5_ve0_hs0_vs0_2008-04-13_13-08-46 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-08-57  ';
                                  'C1G45_he5_ve0_hs0_vs0_2008-04-13_13-09-10  ';
                                  'C1G45_he10_ve0_hs0_vs0_2008-04-13_13-09-21 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-04-13_13-08-22';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-08-22';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-08-57';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-08-57';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-08-57']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G45_he0_ve-10_hs0_vs0_2008-04-13_13-09-46';
                                  'C1G45_he0_ve-5_hs0_vs0_2008-04-13_13-09-57 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-10-09  ';
                                  'C1G45_he0_ve5_hs0_vs0_2008-04-13_13-10-20  ';
                                  'C1G45_he0_ve10_hs0_vs0_2008-04-13_13-10-31 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-04-13_13-09-33';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-09-33';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-10-09';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-10-09';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-10-09']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G45_he0_ve0_hs-10_vs0_2008-04-13_13-10-56';
                                  'C1G45_he0_ve0_hs-5_vs0_2008-04-13_13-11-07 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-11-18  ';
                                  'C1G45_he0_ve0_hs5_vs0_2008-04-13_13-11-29  ';
                                  'C1G45_he0_ve0_hs10_vs0_2008-04-13_13-11-41 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-04-13_13-10-44';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-10-44';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-11-18';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-11-18';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-11-18']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G45_he0_ve0_hs0_vs-10_2008-04-13_13-12-06';
                                  'C1G45_he0_ve0_hs0_vs-5_2008-04-13_13-12-17 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-12-28  ';
                                  'C1G45_he0_ve0_hs0_vs5_2008-04-13_13-12-39  ';
                                  'C1G45_he0_ve0_hs0_vs10_2008-04-13_13-12-51 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-04-13_13-11-53';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-11-53';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-12-28';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-12-28';
                                  'C1G45_he0_ve0_hs0_vs0_2008-04-13_13-12-28']);
        end
    elseif (gap < 0.5*(50 + 60))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G50_he-10_ve0_hs0_vs0_2008-04-13_13-13-59';
                                  'C1G50_he-5_ve0_hs0_vs0_2008-04-13_13-14-12 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-14-23  ';
                                  'C1G50_he5_ve0_hs0_vs0_2008-04-13_13-14-35  ';
                                  'C1G50_he10_ve0_hs0_vs0_2008-04-13_13-14-46 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-04-13_13-13-47';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-13-47';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-14-23';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-14-23';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-14-23']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G50_he0_ve-10_hs0_vs0_2008-04-13_13-15-10';
                                  'C1G50_he0_ve-5_hs0_vs0_2008-04-13_13-15-22 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-15-34  ';
                                  'C1G50_he0_ve5_hs0_vs0_2008-04-13_13-15-45  ';
                                  'C1G50_he0_ve10_hs0_vs0_2008-04-13_13-15-57 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-04-13_13-14-58';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-14-58';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-15-34';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-15-34';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-15-34']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G50_he0_ve0_hs-10_vs0_2008-04-13_13-16-22';
                                  'C1G50_he0_ve0_hs-5_vs0_2008-04-13_13-16-34 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-16-46  ';
                                  'C1G50_he0_ve0_hs5_vs0_2008-04-13_13-16-57  ';
                                  'C1G50_he0_ve0_hs10_vs0_2008-04-13_13-17-09 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-04-13_13-16-10';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-16-10';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-16-46';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-16-46';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-16-46']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G50_he0_ve0_hs0_vs-10_2008-04-13_13-17-34';
                                  'C1G50_he0_ve0_hs0_vs-5_2008-04-13_13-17-45 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-17-56  ';
                                  'C1G50_he0_ve0_hs0_vs5_2008-04-13_13-18-08  ';
                                  'C1G50_he0_ve0_hs0_vs10_2008-04-13_13-18-19 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-04-13_13-17-21';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-17-21';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-17-56';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-17-56';
                                  'C1G50_he0_ve0_hs0_vs0_2008-04-13_13-17-56']);
        end
    elseif (gap < 0.5*(60 + 70))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G60_he-10_ve0_hs0_vs0_2008-04-13_13-21-28';
                                  'C1G60_he-5_ve0_hs0_vs0_2008-04-13_13-21-39 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-21-51  ';
                                  'C1G60_he5_ve0_hs0_vs0_2008-04-13_13-22-02  ';
                                  'C1G60_he10_ve0_hs0_vs0_2008-04-13_13-22-14 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-04-13_13-21-16';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-21-16';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-21-51';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-21-51';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-21-51']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G60_he0_ve-10_hs0_vs0_2008-04-13_13-22-38';
                                  'C1G60_he0_ve-5_hs0_vs0_2008-04-13_13-22-49 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-23-01  ';
                                  'C1G60_he0_ve5_hs0_vs0_2008-04-13_13-23-12  ';
                                  'C1G60_he0_ve10_hs0_vs0_2008-04-13_13-23-23 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-04-13_13-22-26';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-22-26';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-23-01';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-23-01';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-23-01']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G60_he0_ve0_hs-10_vs0_2008-04-13_13-23-48';
                                  'C1G60_he0_ve0_hs-5_vs0_2008-04-13_13-23-59 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-24-11  ';
                                  'C1G60_he0_ve0_hs5_vs0_2008-04-13_13-24-23  ';
                                  'C1G60_he0_ve0_hs10_vs0_2008-04-13_13-24-34 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-04-13_13-23-35';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-23-35';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-24-11';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-24-11';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-24-11']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G60_he0_ve0_hs0_vs-10_2008-04-13_13-24-58';
                                  'C1G60_he0_ve0_hs0_vs-5_2008-04-13_13-25-10 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-25-22  ';
                                  'C1G60_he0_ve0_hs0_vs5_2008-04-13_13-25-33  ';
                                  'C1G60_he0_ve0_hs0_vs10_2008-04-13_13-25-46 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-04-13_13-24-46';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-24-46';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-25-22';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-25-22';
                                  'C1G60_he0_ve0_hs0_vs0_2008-04-13_13-25-22']);
        end
    elseif (gap < 0.5*(70 + 80))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G70_he-10_ve0_hs0_vs0_2008-04-13_13-27-25';
                                  'C1G70_he-5_ve0_hs0_vs0_2008-04-13_13-27-37 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-27-48  ';
                                  'C1G70_he5_ve0_hs0_vs0_2008-04-13_13-28-00  ';
                                  'C1G70_he10_ve0_hs0_vs0_2008-04-13_13-28-12 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-04-13_13-27-13';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-27-13';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-27-48';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-27-48';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-27-48']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G70_he0_ve-10_hs0_vs0_2008-04-13_13-28-37';
                                  'C1G70_he0_ve-5_hs0_vs0_2008-04-13_13-28-49 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-29-01  ';
                                  'C1G70_he0_ve5_hs0_vs0_2008-04-13_13-29-13  ';
                                  'C1G70_he0_ve10_hs0_vs0_2008-04-13_13-29-24 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-04-13_13-28-24';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-28-24';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-29-01';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-29-01';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-29-01']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G70_he0_ve0_hs-10_vs0_2008-04-13_13-29-49';
                                  'C1G70_he0_ve0_hs-5_vs0_2008-04-13_13-30-00 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-30-11  ';
                                  'C1G70_he0_ve0_hs5_vs0_2008-04-13_13-30-22  ';
                                  'C1G70_he0_ve0_hs10_vs0_2008-04-13_13-30-34 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-04-13_13-29-36';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-29-36';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-30-11';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-30-11';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-30-11']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G70_he0_ve0_hs0_vs-10_2008-04-13_13-30-58';
                                  'C1G70_he0_ve0_hs0_vs-5_2008-04-13_13-31-10 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-31-21  ';
                                  'C1G70_he0_ve0_hs0_vs5_2008-04-13_13-31-32  ';
                                  'C1G70_he0_ve0_hs0_vs10_2008-04-13_13-31-43 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-04-13_13-30-46';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-30-46';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-31-21';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-31-21';
                                  'C1G70_he0_ve0_hs0_vs0_2008-04-13_13-31-21']);
        end
    elseif (gap < 0.5*(80 + 90))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G80_he-10_ve0_hs0_vs0_2008-04-13_13-40-29';
                                  'C1G80_he-5_ve0_hs0_vs0_2008-04-13_13-40-41 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-40-53  ';
                                  'C1G80_he5_ve0_hs0_vs0_2008-04-13_13-41-05  ';
                                  'C1G80_he10_ve0_hs0_vs0_2008-04-13_13-41-17 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-04-13_13-40-16';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-40-16';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-40-53';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-40-53';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-40-53']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G80_he0_ve-10_hs0_vs0_2008-04-13_13-41-42';
                                  'C1G80_he0_ve-5_hs0_vs0_2008-04-13_13-41-54 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-42-05  ';
                                  'C1G80_he0_ve5_hs0_vs0_2008-04-13_13-42-16  ';
                                  'C1G80_he0_ve10_hs0_vs0_2008-04-13_13-42-28 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-04-13_13-41-30';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-41-30';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-42-05';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-42-05';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-42-05']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G80_he0_ve0_hs-10_vs0_2008-04-13_13-42-52';
                                  'C1G80_he0_ve0_hs-5_vs0_2008-04-13_13-43-03 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-43-15  ';
                                  'C1G80_he0_ve0_hs5_vs0_2008-04-13_13-43-27  ';
                                  'C1G80_he0_ve0_hs10_vs0_2008-04-13_13-43-39 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-04-13_13-42-40';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-42-40';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-43-15';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-43-15';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-43-15']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G80_he0_ve0_hs0_vs-10_2008-04-13_13-44-03';
                                  'C1G80_he0_ve0_hs0_vs-5_2008-04-13_13-44-15 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-44-26  ';
                                  'C1G80_he0_ve0_hs0_vs5_2008-04-13_13-44-37  ';
                                  'C1G80_he0_ve0_hs0_vs10_2008-04-13_13-44-48 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-04-13_13-43-51';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-43-51';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-44-26';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-44-26';
                                  'C1G80_he0_ve0_hs0_vs0_2008-04-13_13-44-26']);
        end
    elseif (gap < 0.5*(90 + 100))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G90_he-10_ve0_hs0_vs0_2008-04-13_13-45-42';
                                  'C1G90_he-5_ve0_hs0_vs0_2008-04-13_13-45-55 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-46-06  ';
                                  'C1G90_he5_ve0_hs0_vs0_2008-04-13_13-46-17  ';
                                  'C1G90_he10_ve0_hs0_vs0_2008-04-13_13-46-28 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-04-13_13-45-30';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-45-30';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-46-06';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-46-06';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-46-06']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G90_he0_ve-10_hs0_vs0_2008-04-13_13-46-53';
                                  'C1G90_he0_ve-5_hs0_vs0_2008-04-13_13-47-04 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-47-15  ';
                                  'C1G90_he0_ve5_hs0_vs0_2008-04-13_13-47-27  ';
                                  'C1G90_he0_ve10_hs0_vs0_2008-04-13_13-47-38 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-04-13_13-46-41';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-46-41';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-47-15';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-47-15';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-47-15']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G90_he0_ve0_hs-10_vs0_2008-04-13_13-48-03';
                                  'C1G90_he0_ve0_hs-5_vs0_2008-04-13_13-48-14 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-48-25  ';
                                  'C1G90_he0_ve0_hs5_vs0_2008-04-13_13-48-37  ';
                                  'C1G90_he0_ve0_hs10_vs0_2008-04-13_13-48-48 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-04-13_13-47-50';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-47-50';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-48-25';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-48-25';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-48-25']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G90_he0_ve0_hs0_vs-10_2008-04-13_13-49-13';
                                  'C1G90_he0_ve0_hs0_vs-5_2008-04-13_13-49-25 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-49-36  ';
                                  'C1G90_he0_ve0_hs0_vs5_2008-04-13_13-49-48  ';
                                  'C1G90_he0_ve0_hs0_vs10_2008-04-13_13-49-59 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-04-13_13-49-01';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-49-01';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-49-36';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-49-36';
                                  'C1G90_he0_ve0_hs0_vs0_2008-04-13_13-49-36']);
        end
    elseif (gap < 0.5*(100 + 110))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G100_he-10_ve0_hs0_vs0_2008-04-13_13-51-03';
                                  'C1G100_he-5_ve0_hs0_vs0_2008-04-13_13-51-14 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-51-26  ';
                                  'C1G100_he5_ve0_hs0_vs0_2008-04-13_13-51-37  ';
                                  'C1G100_he10_ve0_hs0_vs0_2008-04-13_13-51-48 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-04-13_13-50-51';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-50-51';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-51-26';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-51-26';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-51-26']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G100_he0_ve-10_hs0_vs0_2008-04-13_13-52-13';
                                  'C1G100_he0_ve-5_hs0_vs0_2008-04-13_13-52-24 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-52-35  ';
                                  'C1G100_he0_ve5_hs0_vs0_2008-04-13_13-52-48  ';
                                  'C1G100_he0_ve10_hs0_vs0_2008-04-13_13-52-59 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-04-13_13-52-00';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-52-00';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-52-35';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-52-35';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-52-35']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G100_he0_ve0_hs-10_vs0_2008-04-13_13-53-24';
                                  'C1G100_he0_ve0_hs-5_vs0_2008-04-13_13-53-35 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-53-47  ';
                                  'C1G100_he0_ve0_hs5_vs0_2008-04-13_13-53-59  ';
                                  'C1G100_he0_ve0_hs10_vs0_2008-04-13_13-54-10 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-04-13_13-53-12';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-53-12';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-53-47';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-53-47';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-53-47']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G100_he0_ve0_hs0_vs-10_2008-04-13_13-54-34';
                                  'C1G100_he0_ve0_hs0_vs-5_2008-04-13_13-54-46 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-54-57  ';
                                  'C1G100_he0_ve0_hs0_vs5_2008-04-13_13-55-08  ';
                                  'C1G100_he0_ve0_hs0_vs10_2008-04-13_13-55-20 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-04-13_13-54-22';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-54-22';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-54-57';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-54-57';
                                  'C1G100_he0_ve0_hs0_vs0_2008-04-13_13-54-57']);
        end
    elseif (gap < 0.5*(110 + 120))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G110_he-10_ve0_hs0_vs0_2008-04-13_13-56-10';
                                  'C1G110_he-5_ve0_hs0_vs0_2008-04-13_13-56-21 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-56-32  ';
                                  'C1G110_he5_ve0_hs0_vs0_2008-04-13_13-56-44  ';
                                  'C1G110_he10_ve0_hs0_vs0_2008-04-13_13-56-55 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-04-13_13-55-58';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-55-58';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-56-32';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-56-32';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-56-32']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G110_he0_ve-10_hs0_vs0_2008-04-13_13-57-20';
                                  'C1G110_he0_ve-5_hs0_vs0_2008-04-13_13-57-31 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-57-43  ';
                                  'C1G110_he0_ve5_hs0_vs0_2008-04-13_13-57-54  ';
                                  'C1G110_he0_ve10_hs0_vs0_2008-04-13_13-58-05 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-04-13_13-57-08';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-57-08';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-57-43';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-57-43';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-57-43']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G110_he0_ve0_hs-10_vs0_2008-04-13_13-58-30';
                                  'C1G110_he0_ve0_hs-5_vs0_2008-04-13_13-58-42 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-58-53  ';
                                  'C1G110_he0_ve0_hs5_vs0_2008-04-13_13-59-04  ';
                                  'C1G110_he0_ve0_hs10_vs0_2008-04-13_13-59-15 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-04-13_13-58-17';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-58-17';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-58-53';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-58-53';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-58-53']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G110_he0_ve0_hs0_vs-10_2008-04-13_13-59-40';
                                  'C1G110_he0_ve0_hs0_vs-5_2008-04-13_13-59-51 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_14-00-02  ';
                                  'C1G110_he0_ve0_hs0_vs5_2008-04-13_14-00-14  ';
                                  'C1G110_he0_ve0_hs0_vs10_2008-04-13_14-00-25 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-04-13_13-59-28';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_13-59-28';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_14-00-02';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_14-00-02';
                                  'C1G110_he0_ve0_hs0_vs0_2008-04-13_14-00-02']);
        end
    elseif (gap < 0.5*(120 + 130))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G120_he-10_ve0_hs0_vs0_2008-04-13_14-23-23';
                                  'C1G120_he-5_ve0_hs0_vs0_2008-04-13_14-23-34 ';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-23-45  ';
                                  'C1G120_he5_ve0_hs0_vs0_2008-04-13_14-23-57  ';
                                  'C1G120_he10_ve0_hs0_vs0_2008-04-13_14-24-08 ']);
            fnMeasBkgr = cellstr(['C1G120_he0_ve0_hs0_vs0_2008-04-13_14-23-10';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-23-10';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-23-45';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-23-45';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-23-45']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G120_he0_ve-10_hs0_vs0_2008-04-13_14-24-33';
                                  'C1G120_he0_ve-5_hs0_vs0_2008-04-13_14-24-44 ';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-24-55  ';
                                  'C1G120_he0_ve5_hs0_vs0_2008-04-13_14-25-07  ';
                                  'C1G120_he0_ve10_hs0_vs0_2008-04-13_14-25-19 ']);
            fnMeasBkgr = cellstr(['C1G120_he0_ve0_hs0_vs0_2008-04-13_14-24-21';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-24-21';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-24-55';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-24-55';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-24-55']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G120_he0_ve0_hs-10_vs0_2008-04-13_14-25-44';
                                  'C1G120_he0_ve0_hs-5_vs0_2008-04-13_14-25-55 ';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-26-07  ';
                                  'C1G120_he0_ve0_hs5_vs0_2008-04-13_14-26-18  ';
                                  'C1G120_he0_ve0_hs10_vs0_2008-04-13_14-26-29 ']);
            fnMeasBkgr = cellstr(['C1G120_he0_ve0_hs0_vs0_2008-04-13_14-25-31';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-25-31';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-26-07';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-26-07';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-26-07']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G120_he0_ve0_hs0_vs-10_2008-04-13_14-26-54';
                                  'C1G120_he0_ve0_hs0_vs-5_2008-04-13_14-27-07 ';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-27-18  ';
                                  'C1G120_he0_ve0_hs0_vs5_2008-04-13_14-27-31  ';
                                  'C1G120_he0_ve0_hs0_vs10_2008-04-13_14-27-42 ']);
            fnMeasBkgr = cellstr(['C1G120_he0_ve0_hs0_vs0_2008-04-13_14-26-42';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-26-42';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-27-18';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-27-18';
                                  'C1G120_he0_ve0_hs0_vs0_2008-04-13_14-27-18']);
        end
    elseif (gap < 0.5*(130 + 140))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G130_he-10_ve0_hs0_vs0_2008-04-13_14-28-47';
                                  'C1G130_he-5_ve0_hs0_vs0_2008-04-13_14-28-59 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-29-10  ';
                                  'C1G130_he5_ve0_hs0_vs0_2008-04-13_14-29-23  ';
                                  'C1G130_he10_ve0_hs0_vs0_2008-04-13_14-29-35 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-04-13_14-28-35';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-28-35';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-29-10';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-29-10';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-29-10']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G130_he0_ve-10_hs0_vs0_2008-04-13_14-30-00';
                                  'C1G130_he0_ve-5_hs0_vs0_2008-04-13_14-30-12 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-30-23  ';
                                  'C1G130_he0_ve5_hs0_vs0_2008-04-13_14-30-35  ';
                                  'C1G130_he0_ve10_hs0_vs0_2008-04-13_14-30-48 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-04-13_14-29-47';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-29-47';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-30-23';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-30-23';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-30-23']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G130_he0_ve0_hs-10_vs0_2008-04-13_14-31-12';
                                  'C1G130_he0_ve0_hs-5_vs0_2008-04-13_14-31-25 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-31-36  ';
                                  'C1G130_he0_ve0_hs5_vs0_2008-04-13_14-31-47  ';
                                  'C1G130_he0_ve0_hs10_vs0_2008-04-13_14-31-59 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-04-13_14-31-00';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-31-00';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-31-36';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-31-36';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-31-36']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G130_he0_ve0_hs0_vs-10_2008-04-13_14-32-23';
                                  'C1G130_he0_ve0_hs0_vs-5_2008-04-13_14-32-34 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-32-46  ';
                                  'C1G130_he0_ve0_hs0_vs5_2008-04-13_14-32-58  ';
                                  'C1G130_he0_ve0_hs0_vs10_2008-04-13_14-33-10 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-04-13_14-32-11';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-32-11';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-32-46';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-32-46';
                                  'C1G130_he0_ve0_hs0_vs0_2008-04-13_14-32-46']);
        end
    elseif (gap < 0.5*(140 + 150))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G140_he-10_ve0_hs0_vs0_2008-04-13_14-34-31';
                                  'C1G140_he-5_ve0_hs0_vs0_2008-04-13_14-34-43 ';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-34-55  ';
                                  'C1G140_he5_ve0_hs0_vs0_2008-04-13_14-35-06  ';
                                  'C1G140_he10_ve0_hs0_vs0_2008-04-13_14-35-19 ']);
            fnMeasBkgr = cellstr(['C1G140_he0_ve0_hs0_vs0_2008-04-13_14-34-19';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-34-19';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-34-55';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-34-55';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-34-55']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G140_he0_ve-10_hs0_vs0_2008-04-13_14-35-43';
                                  'C1G140_he0_ve-5_hs0_vs0_2008-04-13_14-35-54 ';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-36-06  ';
                                  'C1G140_he0_ve5_hs0_vs0_2008-04-13_14-36-18  ';
                                  'C1G140_he0_ve10_hs0_vs0_2008-04-13_14-36-30 ']);
            fnMeasBkgr = cellstr(['C1G140_he0_ve0_hs0_vs0_2008-04-13_14-35-31';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-35-31';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-36-06';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-36-06';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-36-06']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G140_he0_ve0_hs-10_vs0_2008-04-13_14-36-54';
                                  'C1G140_he0_ve0_hs-5_vs0_2008-04-13_14-37-06 ';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-37-19  ';
                                  'C1G140_he0_ve0_hs5_vs0_2008-04-13_14-37-30  ';
                                  'C1G140_he0_ve0_hs10_vs0_2008-04-13_14-37-42 ']);
            fnMeasBkgr = cellstr(['C1G140_he0_ve0_hs0_vs0_2008-04-13_14-36-42';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-36-42';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-37-19';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-37-19';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-37-19']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G140_he0_ve0_hs0_vs-10_2008-04-13_14-38-06';
                                  'C1G140_he0_ve0_hs0_vs-5_2008-04-13_14-38-18 ';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-38-29  ';
                                  'C1G140_he0_ve0_hs0_vs5_2008-04-13_14-38-41  ';
                                  'C1G140_he0_ve0_hs0_vs10_2008-04-13_14-38-52 ']);
            fnMeasBkgr = cellstr(['C1G140_he0_ve0_hs0_vs0_2008-04-13_14-37-54';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-37-54';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-38-29';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-38-29';
                                  'C1G140_he0_ve0_hs0_vs0_2008-04-13_14-38-29']);
        end
    elseif (gap < 0.5*(150 + 170))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G150_he-10_ve0_hs0_vs0_2008-04-13_14-39-55';
                                  'C1G150_he-5_ve0_hs0_vs0_2008-04-13_14-40-06 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-40-18  ';
                                  'C1G150_he5_ve0_hs0_vs0_2008-04-13_14-40-29  ';
                                  'C1G150_he10_ve0_hs0_vs0_2008-04-13_14-40-42 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-04-13_14-39-42';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-39-42';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-40-18';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-40-18';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-40-18']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G150_he0_ve-10_hs0_vs0_2008-04-13_14-41-07';
                                  'C1G150_he0_ve-5_hs0_vs0_2008-04-13_14-41-18 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-41-30  ';
                                  'C1G150_he0_ve5_hs0_vs0_2008-04-13_14-41-42  ';
                                  'C1G150_he0_ve10_hs0_vs0_2008-04-13_14-41-54 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-04-13_14-40-55';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-40-55';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-41-30';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-41-30';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-41-30']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G150_he0_ve0_hs-10_vs0_2008-04-13_14-42-19';
                                  'C1G150_he0_ve0_hs-5_vs0_2008-04-13_14-42-31 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-42-43  ';
                                  'C1G150_he0_ve0_hs5_vs0_2008-04-13_14-42-54  ';
                                  'C1G150_he0_ve0_hs10_vs0_2008-04-13_14-43-05 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-04-13_14-42-07';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-42-07';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-42-43';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-42-43';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-42-43']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G150_he0_ve0_hs0_vs-10_2008-04-13_14-43-30';
                                  'C1G150_he0_ve0_hs0_vs-5_2008-04-13_14-43-41 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-43-52  ';
                                  'C1G150_he0_ve0_hs0_vs5_2008-04-13_14-44-04  ';
                                  'C1G150_he0_ve0_hs0_vs10_2008-04-13_14-44-15 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-04-13_14-43-18';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-43-18';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-43-52';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-43-52';
                                  'C1G150_he0_ve0_hs0_vs0_2008-04-13_14-43-52']);
        end
    elseif (gap < 0.5*(170 + 200))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G170_he-10_ve0_hs0_vs0_2008-04-13_14-45-17';
                                  'C1G170_he-5_ve0_hs0_vs0_2008-04-13_14-45-30 ';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-45-42  ';
                                  'C1G170_he5_ve0_hs0_vs0_2008-04-13_14-45-53  ';
                                  'C1G170_he10_ve0_hs0_vs0_2008-04-13_14-46-04 ']);
            fnMeasBkgr = cellstr(['C1G170_he0_ve0_hs0_vs0_2008-04-13_14-45-05';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-45-05';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-45-42';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-45-42';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-45-42']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G170_he0_ve-10_hs0_vs0_2008-04-13_14-46-29';
                                  'C1G170_he0_ve-5_hs0_vs0_2008-04-13_14-46-41 ';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-46-53  ';
                                  'C1G170_he0_ve5_hs0_vs0_2008-04-13_14-47-05  ';
                                  'C1G170_he0_ve10_hs0_vs0_2008-04-13_14-47-16 ']);
            fnMeasBkgr = cellstr(['C1G170_he0_ve0_hs0_vs0_2008-04-13_14-46-17';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-46-17';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-46-53';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-46-53';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-46-53']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G170_he0_ve0_hs-10_vs0_2008-04-13_14-47-41';
                                  'C1G170_he0_ve0_hs-5_vs0_2008-04-13_14-47-52 ';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-48-03  ';
                                  'C1G170_he0_ve0_hs5_vs0_2008-04-13_14-48-14  ';
                                  'C1G170_he0_ve0_hs10_vs0_2008-04-13_14-48-26 ']);
            fnMeasBkgr = cellstr(['C1G170_he0_ve0_hs0_vs0_2008-04-13_14-47-28';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-47-28';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-48-03';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-48-03';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-48-03']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G170_he0_ve0_hs0_vs-10_2008-04-13_14-48-50';
                                  'C1G170_he0_ve0_hs0_vs-5_2008-04-13_14-49-02 ';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-49-13  ';
                                  'C1G170_he0_ve0_hs0_vs5_2008-04-13_14-49-24  ';
                                  'C1G170_he0_ve0_hs0_vs10_2008-04-13_14-49-36 ']);
            fnMeasBkgr = cellstr(['C1G170_he0_ve0_hs0_vs0_2008-04-13_14-48-38';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-48-38';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-49-13';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-49-13';
                                  'C1G170_he0_ve0_hs0_vs0_2008-04-13_14-49-13']);
        end
    elseif (gap < 0.5*(200 + 240))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G200_he-10_ve0_hs0_vs0_2008-04-13_14-50-50';
                                  'C1G200_he-5_ve0_hs0_vs0_2008-04-13_14-51-02 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-51-13  ';
                                  'C1G200_he5_ve0_hs0_vs0_2008-04-13_14-51-25  ';
                                  'C1G200_he10_ve0_hs0_vs0_2008-04-13_14-51-36 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-04-13_14-50-37';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-50-37';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-51-13';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-51-13';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-51-13']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G200_he0_ve-10_hs0_vs0_2008-04-13_14-52-01';
                                  'C1G200_he0_ve-5_hs0_vs0_2008-04-13_14-52-12 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-52-23  ';
                                  'C1G200_he0_ve5_hs0_vs0_2008-04-13_14-52-34  ';
                                  'C1G200_he0_ve10_hs0_vs0_2008-04-13_14-52-45 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-04-13_14-51-48';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-51-48';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-52-23';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-52-23';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-52-23']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G200_he0_ve0_hs-10_vs0_2008-04-13_14-53-10';
                                  'C1G200_he0_ve0_hs-5_vs0_2008-04-13_14-53-22 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-53-34  ';
                                  'C1G200_he0_ve0_hs5_vs0_2008-04-13_14-53-46  ';
                                  'C1G200_he0_ve0_hs10_vs0_2008-04-13_14-53-57 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-04-13_14-52-58';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-52-58';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-53-34';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-53-34';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-53-34']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G200_he0_ve0_hs0_vs-10_2008-04-13_14-54-22';
                                  'C1G200_he0_ve0_hs0_vs-5_2008-04-13_14-54-34 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-54-45  ';
                                  'C1G200_he0_ve0_hs0_vs5_2008-04-13_14-54-56  ';
                                  'C1G200_he0_ve0_hs0_vs10_2008-04-13_14-55-07 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-04-13_14-54-10';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-54-10';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-54-45';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-54-45';
                                  'C1G200_he0_ve0_hs0_vs0_2008-04-13_14-54-45']);
        end
    elseif (gap >= 0.5*(200 + 240))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G240_he-10_ve0_hs0_vs0_2008-04-13_14-56-37';
                                  'C1G240_he-5_ve0_hs0_vs0_2008-04-13_14-56-48 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-57-00  ';
                                  'C1G240_he5_ve0_hs0_vs0_2008-04-13_14-57-12  ';
                                  'C1G240_he10_ve0_hs0_vs0_2008-04-13_14-57-23 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-04-13_14-56-24';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-56-24';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-57-00';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-57-00';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-57-00']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G240_he0_ve-10_hs0_vs0_2008-04-13_14-57-47';
                                  'C1G240_he0_ve-5_hs0_vs0_2008-04-13_14-57-59 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-58-10  ';
                                  'C1G240_he0_ve5_hs0_vs0_2008-04-13_14-58-22  ';
                                  'C1G240_he0_ve10_hs0_vs0_2008-04-13_14-58-33 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-04-13_14-57-35';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-57-35';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-58-10';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-58-10';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-58-10']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G240_he0_ve0_hs-10_vs0_2008-04-13_14-58-58';
                                  'C1G240_he0_ve0_hs-5_vs0_2008-04-13_14-59-09 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-59-21  ';
                                  'C1G240_he0_ve0_hs5_vs0_2008-04-13_14-59-32  ';
                                  'C1G240_he0_ve0_hs10_vs0_2008-04-13_14-59-44 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-04-13_14-58-46';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-58-46';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-59-21';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-59-21';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-59-21']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G240_he0_ve0_hs0_vs-10_2008-04-13_15-00-08';
                                  'C1G240_he0_ve0_hs0_vs-5_2008-04-13_15-00-20 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_15-00-31  ';
                                  'C1G240_he0_ve0_hs0_vs5_2008-04-13_15-00-42  ';
                                  'C1G240_he0_ve0_hs0_vs10_2008-04-13_15-00-54 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-04-13_14-59-56';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_14-59-56';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_15-00-31';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_15-00-31';
                                  'C1G240_he0_ve0_hs0_vs0_2008-04-13_15-00-31']);
        end
    end % End of HU52 DEIMOS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU52 LUCIA  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(idName, 'HU52_LUCIA')
    vCurVals = [-10, -5, 0, 5, 10];
    if (gap < 0.5*(15.5 + 18))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G15_5_he-10_ve0_hs0_vs0_2008-07-21_02-52-29';
                                  'C1G15_5_he-5_ve0_hs0_vs0_2008-07-21_02-52-42 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-52-53  ';
                                  'C1G15_5_he5_ve0_hs0_vs0_2008-07-21_02-53-06  ';
                                  'C1G15_5_he10_ve0_hs0_vs0_2008-07-21_02-53-17 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-52-17';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-52-17';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-52-53';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-52-53';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-52-53']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G15_5_he0_ve-10_hs0_vs0_2008-07-21_02-53-42';
                                  'C1G15_5_he0_ve-5_hs0_vs0_2008-07-21_02-53-53 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-54-05  ';
                                  'C1G15_5_he0_ve5_hs0_vs0_2008-07-21_02-54-16  ';
                                  'C1G15_5_he0_ve10_hs0_vs0_2008-07-21_02-54-27 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-53-29';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-53-29';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-54-05';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-54-05';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-54-05']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G15_5_he0_ve0_hs-10_vs0_2008-07-21_02-54-52';
                                  'C1G15_5_he0_ve0_hs-5_vs0_2008-07-21_02-55-03 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-55-15  ';
                                  'C1G15_5_he0_ve0_hs5_vs0_2008-07-21_02-55-26  ';
                                  'C1G15_5_he0_ve0_hs10_vs0_2008-07-21_02-55-37 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-54-40';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-54-40';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-55-15';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-55-15';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-55-15']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G15_5_he0_ve0_hs0_vs-10_2008-07-21_02-56-02';
                                  'C1G15_5_he0_ve0_hs0_vs-5_2008-07-21_02-56-14 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-56-25  ';
                                  'C1G15_5_he0_ve0_hs0_vs5_2008-07-21_02-56-37  ';
                                  'C1G15_5_he0_ve0_hs0_vs10_2008-07-21_02-56-48 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-55-50';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-55-50';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-56-25';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-56-25';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-21_02-56-25']);
        end
    elseif (gap < 0.5*(18 + 20))
         if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G18_he-10_ve0_hs0_vs0_2008-07-21_02-57-46';
                                  'C1G18_he-5_ve0_hs0_vs0_2008-07-21_02-57-58 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_02-58-09  ';
                                  'C1G18_he5_ve0_hs0_vs0_2008-07-21_02-58-21  ';
                                  'C1G18_he10_ve0_hs0_vs0_2008-07-21_02-58-32 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-07-21_02-57-34';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_02-57-34';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_02-58-09';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_02-58-09';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_02-58-09']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G18_he0_ve-10_hs0_vs0_2008-07-21_02-58-57';
                                  'C1G18_he0_ve-5_hs0_vs0_2008-07-21_02-59-08 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_02-59-20  ';
                                  'C1G18_he0_ve5_hs0_vs0_2008-07-21_02-59-31  ';
                                  'C1G18_he0_ve10_hs0_vs0_2008-07-21_02-59-43 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-07-21_02-58-44';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_02-58-44';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_02-59-20';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_02-59-20';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_02-59-20']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G18_he0_ve0_hs-10_vs0_2008-07-21_03-00-07';
                                  'C1G18_he0_ve0_hs-5_vs0_2008-07-21_03-00-19 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_03-00-30  ';
                                  'C1G18_he0_ve0_hs5_vs0_2008-07-21_03-00-42  ';
                                  'C1G18_he0_ve0_hs10_vs0_2008-07-21_03-00-53 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-07-21_02-59-55';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_02-59-55';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_03-00-30';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_03-00-30';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_03-00-30']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G18_he0_ve0_hs0_vs-10_2008-07-21_03-01-18';
                                  'C1G18_he0_ve0_hs0_vs-5_2008-07-21_03-01-29 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_03-01-41  ';
                                  'C1G18_he0_ve0_hs0_vs5_2008-07-21_03-01-52  ';
                                  'C1G18_he0_ve0_hs0_vs10_2008-07-21_03-02-03 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-07-21_03-01-05';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_03-01-05';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_03-01-41';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_03-01-41';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-21_03-01-41']);
         end
    elseif (gap < 0.5*(20 + 25))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G20_he-10_ve0_hs0_vs0_2008-07-21_03-02-55';
                                  'C1G20_he-5_ve0_hs0_vs0_2008-07-21_03-03-07 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-03-18  ';
                                  'C1G20_he5_ve0_hs0_vs0_2008-07-21_03-03-29  ';
                                  'C1G20_he10_ve0_hs0_vs0_2008-07-21_03-03-41 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-07-21_03-02-42';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-02-42';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-03-18';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-03-18';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-03-18']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G20_he0_ve-10_hs0_vs0_2008-07-21_03-04-06';
                                  'C1G20_he0_ve-5_hs0_vs0_2008-07-21_03-04-17 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-04-29  ';
                                  'C1G20_he0_ve5_hs0_vs0_2008-07-21_03-04-40  ';
                                  'C1G20_he0_ve10_hs0_vs0_2008-07-21_03-04-51 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-07-21_03-03-54';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-03-54';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-04-29';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-04-29';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-04-29']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G20_he0_ve0_hs-10_vs0_2008-07-21_03-05-16';
                                  'C1G20_he0_ve0_hs-5_vs0_2008-07-21_03-05-28 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-05-39  ';
                                  'C1G20_he0_ve0_hs5_vs0_2008-07-21_03-05-51  ';
                                  'C1G20_he0_ve0_hs10_vs0_2008-07-21_03-06-02 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-07-21_03-05-04';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-05-04';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-05-39';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-05-39';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-05-39']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G20_he0_ve0_hs0_vs-10_2008-07-21_03-06-27';
                                  'C1G20_he0_ve0_hs0_vs-5_2008-07-21_03-06-38 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-06-50  ';
                                  'C1G20_he0_ve0_hs0_vs5_2008-07-21_03-07-02  ';
                                  'C1G20_he0_ve0_hs0_vs10_2008-07-21_03-07-13 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-07-21_03-06-14';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-06-14';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-06-50';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-06-50';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-21_03-06-50']);
        end
    elseif (gap < 0.5*(25 + 30))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G25_he-10_ve0_hs0_vs0_2008-07-21_03-07-51';
                                  'C1G25_he-5_ve0_hs0_vs0_2008-07-21_03-08-03 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-08-15  ';
                                  'C1G25_he5_ve0_hs0_vs0_2008-07-21_03-08-26  ';
                                  'C1G25_he10_ve0_hs0_vs0_2008-07-21_03-08-39 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-07-21_03-07-39';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-07-39';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-08-15';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-08-15';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-08-15']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G25_he0_ve-10_hs0_vs0_2008-07-21_03-09-03';
                                  'C1G25_he0_ve-5_hs0_vs0_2008-07-21_03-09-15 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-09-26  ';
                                  'C1G25_he0_ve5_hs0_vs0_2008-07-21_03-09-38  ';
                                  'C1G25_he0_ve10_hs0_vs0_2008-07-21_03-09-50 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-07-21_03-08-51';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-08-51';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-09-26';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-09-26';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-09-26']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G25_he0_ve0_hs-10_vs0_2008-07-21_03-10-15';
                                  'C1G25_he0_ve0_hs-5_vs0_2008-07-21_03-10-26 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-10-38  ';
                                  'C1G25_he0_ve0_hs5_vs0_2008-07-21_03-10-49  ';
                                  'C1G25_he0_ve0_hs10_vs0_2008-07-21_03-11-01 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-07-21_03-10-02';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-10-02';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-10-38';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-10-38';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-10-38']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G25_he0_ve0_hs0_vs-10_2008-07-21_03-11-26';
                                  'C1G25_he0_ve0_hs0_vs-5_2008-07-21_03-11-37 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-11-49  ';
                                  'C1G25_he0_ve0_hs0_vs5_2008-07-21_03-12-00  ';
                                  'C1G25_he0_ve0_hs0_vs10_2008-07-21_03-12-12 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-07-21_03-11-14';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-11-14';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-11-49';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-11-49';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-21_03-11-49']);
        end
    elseif (gap < 0.5*(30 + 35))
         if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G30_he-10_ve0_hs0_vs0_2008-07-21_03-12-49';
                                  'C1G30_he-5_ve0_hs0_vs0_2008-07-21_03-13-01 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-13-12  ';
                                  'C1G30_he5_ve0_hs0_vs0_2008-07-21_03-13-24  ';
                                  'C1G30_he10_ve0_hs0_vs0_2008-07-21_03-13-36 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-07-21_03-12-37';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-12-37';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-13-12';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-13-12';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-13-12']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G30_he0_ve-10_hs0_vs0_2008-07-21_03-14-01';
                                  'C1G30_he0_ve-5_hs0_vs0_2008-07-21_03-14-14 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-14-25  ';
                                  'C1G30_he0_ve5_hs0_vs0_2008-07-21_03-14-37  ';
                                  'C1G30_he0_ve10_hs0_vs0_2008-07-21_03-14-49 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-07-21_03-13-49';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-13-49';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-14-25';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-14-25';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-14-25']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G30_he0_ve0_hs-10_vs0_2008-07-21_03-15-14';
                                  'C1G30_he0_ve0_hs-5_vs0_2008-07-21_03-15-25 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-15-37  ';
                                  'C1G30_he0_ve0_hs5_vs0_2008-07-21_03-15-48  ';
                                  'C1G30_he0_ve0_hs10_vs0_2008-07-21_03-16-01 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-07-21_03-15-01';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-15-01';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-15-37';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-15-37';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-15-37']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G30_he0_ve0_hs0_vs-10_2008-07-21_03-16-26';
                                  'C1G30_he0_ve0_hs0_vs-5_2008-07-21_03-16-37 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-16-49  ';
                                  'C1G30_he0_ve0_hs0_vs5_2008-07-21_03-17-00  ';
                                  'C1G30_he0_ve0_hs0_vs10_2008-07-21_03-17-12 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-07-21_03-16-13';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-16-13';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-16-49';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-16-49';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-21_03-16-49']);
        end            
    elseif (gap < 0.5*(35 + 40))
         if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G35_he-10_ve0_hs0_vs0_2008-07-21_03-17-49';
                                  'C1G35_he-5_ve0_hs0_vs0_2008-07-21_03-18-01 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-18-12  ';
                                  'C1G35_he5_ve0_hs0_vs0_2008-07-21_03-18-24  ';
                                  'C1G35_he10_ve0_hs0_vs0_2008-07-21_03-18-36 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-07-21_03-17-37';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-17-37';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-18-12';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-18-12';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-18-12']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G35_he0_ve-10_hs0_vs0_2008-07-21_03-19-01';
                                  'C1G35_he0_ve-5_hs0_vs0_2008-07-21_03-19-13 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-19-24  ';
                                  'C1G35_he0_ve5_hs0_vs0_2008-07-21_03-19-36  ';
                                  'C1G35_he0_ve10_hs0_vs0_2008-07-21_03-19-47 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-07-21_03-18-48';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-18-48';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-19-24';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-19-24';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-19-24']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G35_he0_ve0_hs-10_vs0_2008-07-21_03-20-12';
                                  'C1G35_he0_ve0_hs-5_vs0_2008-07-21_03-20-24 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-20-36  ';
                                  'C1G35_he0_ve0_hs5_vs0_2008-07-21_03-20-47  ';
                                  'C1G35_he0_ve0_hs10_vs0_2008-07-21_03-20-59 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-07-21_03-20-00';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-20-00';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-20-36';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-20-36';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-20-36']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G35_he0_ve0_hs0_vs-10_2008-07-21_03-21-23';
                                  'C1G35_he0_ve0_hs0_vs-5_2008-07-21_03-21-35 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-21-46  ';
                                  'C1G35_he0_ve0_hs0_vs5_2008-07-21_03-21-58  ';
                                  'C1G35_he0_ve0_hs0_vs10_2008-07-21_03-22-10 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-07-21_03-21-11';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-21-11';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-21-46';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-21-46';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-21_03-21-46']);
        end
    elseif (gap < 0.5*(40 + 45))
         if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G40_he-10_ve0_hs0_vs0_2008-07-21_03-23-02';
                                  'C1G40_he-5_ve0_hs0_vs0_2008-07-21_03-23-14 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-23-25  ';
                                  'C1G40_he5_ve0_hs0_vs0_2008-07-21_03-23-37  ';
                                  'C1G40_he10_ve0_hs0_vs0_2008-07-21_03-23-49 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-07-21_03-22-49';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-22-49';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-23-25';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-23-25';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-23-25']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G40_he0_ve-10_hs0_vs0_2008-07-21_03-24-14';
                                  'C1G40_he0_ve-5_hs0_vs0_2008-07-21_03-24-26 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-24-38  ';
                                  'C1G40_he0_ve5_hs0_vs0_2008-07-21_03-24-50  ';
                                  'C1G40_he0_ve10_hs0_vs0_2008-07-21_03-25-01 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-07-21_03-24-02';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-24-02';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-24-38';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-24-38';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-24-38']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G40_he0_ve0_hs-10_vs0_2008-07-21_03-25-26';
                                  'C1G40_he0_ve0_hs-5_vs0_2008-07-21_03-25-38 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-25-51  ';
                                  'C1G40_he0_ve0_hs5_vs0_2008-07-21_03-26-02  ';
                                  'C1G40_he0_ve0_hs10_vs0_2008-07-21_03-26-14 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-07-21_03-25-14';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-25-14';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-25-51';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-25-51';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-25-51']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G40_he0_ve0_hs0_vs-10_2008-07-21_03-26-39';
                                  'C1G40_he0_ve0_hs0_vs-5_2008-07-21_03-26-50 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-27-02  ';
                                  'C1G40_he0_ve0_hs0_vs5_2008-07-21_03-27-14  ';
                                  'C1G40_he0_ve0_hs0_vs10_2008-07-21_03-27-25 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-07-21_03-26-26';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-26-26';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-27-02';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-27-02';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-21_03-27-02']);
        end
    elseif (gap < 0.5*(45 + 50))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G45_he-10_ve0_hs0_vs0_2008-07-21_03-30-09';
                                  'C1G45_he-5_ve0_hs0_vs0_2008-07-21_03-30-21 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-30-33  ';
                                  'C1G45_he5_ve0_hs0_vs0_2008-07-21_03-30-44  ';
                                  'C1G45_he10_ve0_hs0_vs0_2008-07-21_03-30-56 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-07-21_03-29-56';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-29-56';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-30-33';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-30-33';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-30-33']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G45_he0_ve-10_hs0_vs0_2008-07-21_03-31-22';
                                  'C1G45_he0_ve-5_hs0_vs0_2008-07-21_03-31-33 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-31-45  ';
                                  'C1G45_he0_ve5_hs0_vs0_2008-07-21_03-31-57  ';
                                  'C1G45_he0_ve10_hs0_vs0_2008-07-21_03-32-08 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-07-21_03-31-09';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-31-09';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-31-45';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-31-45';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-31-45']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G45_he0_ve0_hs-10_vs0_2008-07-21_03-32-33';
                                  'C1G45_he0_ve0_hs-5_vs0_2008-07-21_03-32-45 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-32-56  ';
                                  'C1G45_he0_ve0_hs5_vs0_2008-07-21_03-33-08  ';
                                  'C1G45_he0_ve0_hs10_vs0_2008-07-21_03-33-19 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-07-21_03-32-21';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-32-21';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-32-56';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-32-56';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-32-56']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G45_he0_ve0_hs0_vs-10_2008-07-21_03-33-44';
                                  'C1G45_he0_ve0_hs0_vs-5_2008-07-21_03-33-56 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-34-07  ';
                                  'C1G45_he0_ve0_hs0_vs5_2008-07-21_03-34-19  ';
                                  'C1G45_he0_ve0_hs0_vs10_2008-07-21_03-34-30 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-07-21_03-33-32';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-33-32';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-34-07';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-34-07';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-21_03-34-07']);
        end
    elseif (gap < 0.5*(50 + 60))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G50_he-10_ve0_hs0_vs0_2008-07-21_03-35-03';
                                  'C1G50_he-5_ve0_hs0_vs0_2008-07-21_03-35-15 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-35-26  ';
                                  'C1G50_he5_ve0_hs0_vs0_2008-07-21_03-35-38  ';
                                  'C1G50_he10_ve0_hs0_vs0_2008-07-21_03-35-49 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-07-21_03-34-50';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-34-50';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-35-26';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-35-26';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-35-26']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G50_he0_ve-10_hs0_vs0_2008-07-21_03-36-14';
                                  'C1G50_he0_ve-5_hs0_vs0_2008-07-21_03-36-26 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-36-38  ';
                                  'C1G50_he0_ve5_hs0_vs0_2008-07-21_03-36-50  ';
                                  'C1G50_he0_ve10_hs0_vs0_2008-07-21_03-37-01 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-07-21_03-36-02';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-36-02';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-36-38';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-36-38';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-36-38']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G50_he0_ve0_hs-10_vs0_2008-07-21_03-37-26';
                                  'C1G50_he0_ve0_hs-5_vs0_2008-07-21_03-37-38 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-37-49  ';
                                  'C1G50_he0_ve0_hs5_vs0_2008-07-21_03-38-01  ';
                                  'C1G50_he0_ve0_hs10_vs0_2008-07-21_03-38-13 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-07-21_03-37-14';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-37-14';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-37-49';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-37-49';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-37-49']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G50_he0_ve0_hs0_vs-10_2008-07-21_03-38-38';
                                  'C1G50_he0_ve0_hs0_vs-5_2008-07-21_03-38-49 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-39-01  ';
                                  'C1G50_he0_ve0_hs0_vs5_2008-07-21_03-39-12  ';
                                  'C1G50_he0_ve0_hs0_vs10_2008-07-21_03-39-24 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-07-21_03-38-25';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-38-25';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-39-01';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-39-01';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-21_03-39-01']);
        end
    elseif (gap < 0.5*(60 + 70))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G60_he-10_ve0_hs0_vs0_2008-07-21_03-40-04';
                                  'C1G60_he-5_ve0_hs0_vs0_2008-07-21_03-40-16 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-40-28  ';
                                  'C1G60_he5_ve0_hs0_vs0_2008-07-21_03-40-40  ';
                                  'C1G60_he10_ve0_hs0_vs0_2008-07-21_03-40-51 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-07-21_03-39-52';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-39-52';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-40-28';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-40-28';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-40-28']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G60_he0_ve-10_hs0_vs0_2008-07-21_03-41-16';
                                  'C1G60_he0_ve-5_hs0_vs0_2008-07-21_03-41-29 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-41-40  ';
                                  'C1G60_he0_ve5_hs0_vs0_2008-07-21_03-41-52  ';
                                  'C1G60_he0_ve10_hs0_vs0_2008-07-21_03-42-03 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-07-21_03-41-04';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-41-04';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-41-40';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-41-40';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-41-40']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G60_he0_ve0_hs-10_vs0_2008-07-21_03-42-29';
                                  'C1G60_he0_ve0_hs-5_vs0_2008-07-21_03-42-40 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-42-52  ';
                                  'C1G60_he0_ve0_hs5_vs0_2008-07-21_03-43-03  ';
                                  'C1G60_he0_ve0_hs10_vs0_2008-07-21_03-43-15 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-07-21_03-42-16';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-42-16';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-42-52';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-42-52';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-42-52']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G60_he0_ve0_hs0_vs-10_2008-07-21_03-43-40';
                                  'C1G60_he0_ve0_hs0_vs-5_2008-07-21_03-43-52 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-44-03  ';
                                  'C1G60_he0_ve0_hs0_vs5_2008-07-21_03-44-15  ';
                                  'C1G60_he0_ve0_hs0_vs10_2008-07-21_03-44-26 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-07-21_03-43-28';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-43-28';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-44-03';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-44-03';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-21_03-44-03']);
        end
    elseif (gap < 0.5*(70 + 80))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G70_he-10_ve0_hs0_vs0_2008-07-21_03-45-04';
                                  'C1G70_he-5_ve0_hs0_vs0_2008-07-21_03-45-15 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-45-28  ';
                                  'C1G70_he5_ve0_hs0_vs0_2008-07-21_03-45-40  ';
                                  'C1G70_he10_ve0_hs0_vs0_2008-07-21_03-45-51 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-07-21_03-44-51';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-44-51';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-45-28';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-45-28';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-45-28']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G70_he0_ve-10_hs0_vs0_2008-07-21_03-46-16';
                                  'C1G70_he0_ve-5_hs0_vs0_2008-07-21_03-46-28 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-46-40  ';
                                  'C1G70_he0_ve5_hs0_vs0_2008-07-21_03-46-53  ';
                                  'C1G70_he0_ve10_hs0_vs0_2008-07-21_03-47-05 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-07-21_03-46-04';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-46-04';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-46-40';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-46-40';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-46-40']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G70_he0_ve0_hs-10_vs0_2008-07-21_03-47-30';
                                  'C1G70_he0_ve0_hs-5_vs0_2008-07-21_03-47-41 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-47-52  ';
                                  'C1G70_he0_ve0_hs5_vs0_2008-07-21_03-48-04  ';
                                  'C1G70_he0_ve0_hs10_vs0_2008-07-21_03-48-15 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-07-21_03-47-17';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-47-17';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-47-52';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-47-52';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-47-52']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G70_he0_ve0_hs0_vs-10_2008-07-21_03-48-41';
                                  'C1G70_he0_ve0_hs0_vs-5_2008-07-21_03-48-52 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-49-04  ';
                                  'C1G70_he0_ve0_hs0_vs5_2008-07-21_03-49-15  ';
                                  'C1G70_he0_ve0_hs0_vs10_2008-07-21_03-49-27 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-07-21_03-48-28';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-48-28';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-49-04';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-49-04';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-21_03-49-04']);
        end
    elseif (gap < 0.5*(80 + 90))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G80_he-10_ve0_hs0_vs0_2008-07-21_03-50-00';
                                  'C1G80_he-5_ve0_hs0_vs0_2008-07-21_03-50-11 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-50-24  ';
                                  'C1G80_he5_ve0_hs0_vs0_2008-07-21_03-50-35  ';
                                  'C1G80_he10_ve0_hs0_vs0_2008-07-21_03-50-47 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-07-21_03-49-47';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-49-47';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-50-24';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-50-24';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-50-24']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G80_he0_ve-10_hs0_vs0_2008-07-21_03-51-11';
                                  'C1G80_he0_ve-5_hs0_vs0_2008-07-21_03-51-23 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-51-35  ';
                                  'C1G80_he0_ve5_hs0_vs0_2008-07-21_03-51-47  ';
                                  'C1G80_he0_ve10_hs0_vs0_2008-07-21_03-51-58 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-07-21_03-50-59';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-50-59';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-51-35';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-51-35';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-51-35']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G80_he0_ve0_hs-10_vs0_2008-07-21_03-52-23';
                                  'C1G80_he0_ve0_hs-5_vs0_2008-07-21_03-52-34 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-52-46  ';
                                  'C1G80_he0_ve0_hs5_vs0_2008-07-21_03-52-57  ';
                                  'C1G80_he0_ve0_hs10_vs0_2008-07-21_03-53-09 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-07-21_03-52-11';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-52-11';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-52-46';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-52-46';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-52-46']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G80_he0_ve0_hs0_vs-10_2008-07-21_03-53-34';
                                  'C1G80_he0_ve0_hs0_vs-5_2008-07-21_03-53-45 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-53-57  ';
                                  'C1G80_he0_ve0_hs0_vs5_2008-07-21_03-54-08  ';
                                  'C1G80_he0_ve0_hs0_vs10_2008-07-21_03-54-19 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-07-21_03-53-21';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-53-21';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-53-57';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-53-57';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-21_03-53-57']);
        end
    elseif (gap < 0.5*(90 + 100))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G90_he-10_ve0_hs0_vs0_2008-07-21_03-54-54';
                                  'C1G90_he-5_ve0_hs0_vs0_2008-07-21_03-55-06 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-55-17  ';
                                  'C1G90_he5_ve0_hs0_vs0_2008-07-21_03-55-30  ';
                                  'C1G90_he10_ve0_hs0_vs0_2008-07-21_03-55-41 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-07-21_03-54-41';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-54-41';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-55-17';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-55-17';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-55-17']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G90_he0_ve-10_hs0_vs0_2008-07-21_03-56-06';
                                  'C1G90_he0_ve-5_hs0_vs0_2008-07-21_03-56-18 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-56-29  ';
                                  'C1G90_he0_ve5_hs0_vs0_2008-07-21_03-56-41  ';
                                  'C1G90_he0_ve10_hs0_vs0_2008-07-21_03-56-52 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-07-21_03-55-53';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-55-53';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-56-29';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-56-29';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-56-29']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G90_he0_ve0_hs-10_vs0_2008-07-21_03-57-17';
                                  'C1G90_he0_ve0_hs-5_vs0_2008-07-21_03-57-28 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-57-39  ';
                                  'C1G90_he0_ve0_hs5_vs0_2008-07-21_03-57-51  ';
                                  'C1G90_he0_ve0_hs10_vs0_2008-07-21_03-58-03 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-07-21_03-57-04';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-57-04';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-57-39';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-57-39';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-57-39']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G90_he0_ve0_hs0_vs-10_2008-07-21_03-58-27';
                                  'C1G90_he0_ve0_hs0_vs-5_2008-07-21_03-58-39 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-58-50  ';
                                  'C1G90_he0_ve0_hs0_vs5_2008-07-21_03-59-01  ';
                                  'C1G90_he0_ve0_hs0_vs10_2008-07-21_03-59-13 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-07-21_03-58-15';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-58-15';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-58-50';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-58-50';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-21_03-58-50']);
        end
    elseif (gap < 0.5*(100 + 110))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G100_he-10_ve0_hs0_vs0_2008-07-21_03-59-47';
                                  'C1G100_he-5_ve0_hs0_vs0_2008-07-21_03-59-59 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-00-10  ';
                                  'C1G100_he5_ve0_hs0_vs0_2008-07-21_04-00-21  ';
                                  'C1G100_he10_ve0_hs0_vs0_2008-07-21_04-00-33 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-07-21_03-59-35';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_03-59-35';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-00-10';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-00-10';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-00-10']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G100_he0_ve-10_hs0_vs0_2008-07-21_04-00-57';
                                  'C1G100_he0_ve-5_hs0_vs0_2008-07-21_04-01-09 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-01-21  ';
                                  'C1G100_he0_ve5_hs0_vs0_2008-07-21_04-01-34  ';
                                  'C1G100_he0_ve10_hs0_vs0_2008-07-21_04-01-45 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-07-21_04-00-45';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-00-45';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-01-21';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-01-21';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-01-21']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G100_he0_ve0_hs-10_vs0_2008-07-21_04-02-09';
                                  'C1G100_he0_ve0_hs-5_vs0_2008-07-21_04-02-21 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-02-32  ';
                                  'C1G100_he0_ve0_hs5_vs0_2008-07-21_04-02-44  ';
                                  'C1G100_he0_ve0_hs10_vs0_2008-07-21_04-02-56 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-07-21_04-01-57';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-01-57';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-02-32';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-02-32';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-02-32']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G100_he0_ve0_hs0_vs-10_2008-07-21_04-03-20';
                                  'C1G100_he0_ve0_hs0_vs-5_2008-07-21_04-03-31 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-03-43  ';
                                  'C1G100_he0_ve0_hs0_vs5_2008-07-21_04-03-54  ';
                                  'C1G100_he0_ve0_hs0_vs10_2008-07-21_04-04-05 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-07-21_04-03-08';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-03-08';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-03-43';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-03-43';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-21_04-03-43']);
        end
    elseif (gap < 0.5*(110 + 130))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G110_he-10_ve0_hs0_vs0_2008-07-21_04-04-50';
                                  'C1G110_he-5_ve0_hs0_vs0_2008-07-21_04-05-02 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-05-13  ';
                                  'C1G110_he5_ve0_hs0_vs0_2008-07-21_04-05-24  ';
                                  'C1G110_he10_ve0_hs0_vs0_2008-07-21_04-05-36 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-07-21_04-04-38';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-04-38';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-05-13';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-05-13';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-05-13']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G110_he0_ve-10_hs0_vs0_2008-07-21_04-06-00';
                                  'C1G110_he0_ve-5_hs0_vs0_2008-07-21_04-06-13 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-06-25  ';
                                  'C1G110_he0_ve5_hs0_vs0_2008-07-21_04-06-37  ';
                                  'C1G110_he0_ve10_hs0_vs0_2008-07-21_04-06-48 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-07-21_04-05-48';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-05-48';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-06-25';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-06-25';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-06-25']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G110_he0_ve0_hs-10_vs0_2008-07-21_04-07-13';
                                  'C1G110_he0_ve0_hs-5_vs0_2008-07-21_04-07-24 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-07-36  ';
                                  'C1G110_he0_ve0_hs5_vs0_2008-07-21_04-07-47  ';
                                  'C1G110_he0_ve0_hs10_vs0_2008-07-21_04-07-59 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-07-21_04-07-01';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-07-01';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-07-36';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-07-36';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-07-36']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G110_he0_ve0_hs0_vs-10_2008-07-21_04-08-24';
                                  'C1G110_he0_ve0_hs0_vs-5_2008-07-21_04-08-35 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-08-46  ';
                                  'C1G110_he0_ve0_hs0_vs5_2008-07-21_04-08-57  ';
                                  'C1G110_he0_ve0_hs0_vs10_2008-07-21_04-09-09 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-07-21_04-08-11';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-08-11';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-08-46';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-08-46';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-21_04-08-46']);
        end
    elseif (gap < 0.5*(130 + 150))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G130_he-10_ve0_hs0_vs0_2008-07-21_04-09-48';
                                  'C1G130_he-5_ve0_hs0_vs0_2008-07-21_04-09-59 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-10-11  ';
                                  'C1G130_he5_ve0_hs0_vs0_2008-07-21_04-10-22  ';
                                  'C1G130_he10_ve0_hs0_vs0_2008-07-21_04-10-34 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-07-21_04-09-36';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-09-36';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-10-11';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-10-11';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-10-11']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G130_he0_ve-10_hs0_vs0_2008-07-21_04-10-58';
                                  'C1G130_he0_ve-5_hs0_vs0_2008-07-21_04-11-10 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-11-21  ';
                                  'C1G130_he0_ve5_hs0_vs0_2008-07-21_04-11-32  ';
                                  'C1G130_he0_ve10_hs0_vs0_2008-07-21_04-11-44 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-07-21_04-10-46';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-10-46';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-11-21';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-11-21';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-11-21']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G130_he0_ve0_hs-10_vs0_2008-07-21_04-12-08';
                                  'C1G130_he0_ve0_hs-5_vs0_2008-07-21_04-12-20 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-12-32  ';
                                  'C1G130_he0_ve0_hs5_vs0_2008-07-21_04-12-44  ';
                                  'C1G130_he0_ve0_hs10_vs0_2008-07-21_04-12-55 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-07-21_04-11-56';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-11-56';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-12-32';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-12-32';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-12-32']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G130_he0_ve0_hs0_vs-10_2008-07-21_04-13-20';
                                  'C1G130_he0_ve0_hs0_vs-5_2008-07-21_04-13-31 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-13-43  ';
                                  'C1G130_he0_ve0_hs0_vs5_2008-07-21_04-13-54  ';
                                  'C1G130_he0_ve0_hs0_vs10_2008-07-21_04-14-05 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-07-21_04-13-07';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-13-07';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-13-43';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-13-43';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-21_04-13-43']);
        end
    elseif (gap < 0.5*(150 + 175))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G150_he-10_ve0_hs0_vs0_2008-07-21_04-14-46';
                                  'C1G150_he-5_ve0_hs0_vs0_2008-07-21_04-14-58 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-15-09  ';
                                  'C1G150_he5_ve0_hs0_vs0_2008-07-21_04-15-21  ';
                                  'C1G150_he10_ve0_hs0_vs0_2008-07-21_04-15-33 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-07-21_04-14-34';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-14-34';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-15-09';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-15-09';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-15-09']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G150_he0_ve-10_hs0_vs0_2008-07-21_04-15-58';
                                  'C1G150_he0_ve-5_hs0_vs0_2008-07-21_04-16-09 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-16-21  ';
                                  'C1G150_he0_ve5_hs0_vs0_2008-07-21_04-16-32  ';
                                  'C1G150_he0_ve10_hs0_vs0_2008-07-21_04-16-44 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-07-21_04-15-45';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-15-45';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-16-21';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-16-21';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-16-21']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G150_he0_ve0_hs-10_vs0_2008-07-21_04-17-09';
                                  'C1G150_he0_ve0_hs-5_vs0_2008-07-21_04-17-20 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-17-32  ';
                                  'C1G150_he0_ve0_hs5_vs0_2008-07-21_04-17-44  ';
                                  'C1G150_he0_ve0_hs10_vs0_2008-07-21_04-17-55 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-07-21_04-16-57';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-16-57';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-17-32';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-17-32';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-17-32']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G150_he0_ve0_hs0_vs-10_2008-07-21_04-18-20';
                                  'C1G150_he0_ve0_hs0_vs-5_2008-07-21_04-18-31 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-18-42  ';
                                  'C1G150_he0_ve0_hs0_vs5_2008-07-21_04-18-54  ';
                                  'C1G150_he0_ve0_hs0_vs10_2008-07-21_04-19-05 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-07-21_04-18-07';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-18-07';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-18-42';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-18-42';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-21_04-18-42']);
        end
    elseif (gap < 0.5*(175 + 200))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G175_he-10_ve0_hs0_vs0_2008-07-21_04-19-53';
                                  'C1G175_he-5_ve0_hs0_vs0_2008-07-21_04-20-04 ';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-20-17  ';
                                  'C1G175_he5_ve0_hs0_vs0_2008-07-21_04-20-28  ';
                                  'C1G175_he10_ve0_hs0_vs0_2008-07-21_04-20-39 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2008-07-21_04-19-41';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-19-41';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-20-17';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-20-17';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-20-17']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G175_he0_ve-10_hs0_vs0_2008-07-21_04-21-04';
                                  'C1G175_he0_ve-5_hs0_vs0_2008-07-21_04-21-16 ';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-21-27  ';
                                  'C1G175_he0_ve5_hs0_vs0_2008-07-21_04-21-38  ';
                                  'C1G175_he0_ve10_hs0_vs0_2008-07-21_04-21-50 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2008-07-21_04-20-52';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-20-52';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-21-27';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-21-27';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-21-27']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G175_he0_ve0_hs-10_vs0_2008-07-21_04-22-15';
                                  'C1G175_he0_ve0_hs-5_vs0_2008-07-21_04-22-26 ';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-22-37  ';
                                  'C1G175_he0_ve0_hs5_vs0_2008-07-21_04-22-49  ';
                                  'C1G175_he0_ve0_hs10_vs0_2008-07-21_04-23-00 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2008-07-21_04-22-02';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-22-02';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-22-37';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-22-37';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-22-37']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G175_he0_ve0_hs0_vs-10_2008-07-21_04-23-25';
                                  'C1G175_he0_ve0_hs0_vs-5_2008-07-21_04-23-36 ';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-23-48  ';
                                  'C1G175_he0_ve0_hs0_vs5_2008-07-21_04-23-59  ';
                                  'C1G175_he0_ve0_hs0_vs10_2008-07-21_04-24-12 ']);
            fnMeasBkgr = cellstr(['C1G175_he0_ve0_hs0_vs0_2008-07-21_04-23-12';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-23-12';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-23-48';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-23-48';
                                  'C1G175_he0_ve0_hs0_vs0_2008-07-21_04-23-48']);
        end
    elseif (gap < 0.5*(200 + 240))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G200_he-10_ve0_hs0_vs0_2008-07-21_04-24-48';
                                  'C1G200_he-5_ve0_hs0_vs0_2008-07-21_04-25-00 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-25-12  ';
                                  'C1G200_he5_ve0_hs0_vs0_2008-07-21_04-25-24  ';
                                  'C1G200_he10_ve0_hs0_vs0_2008-07-21_04-25-35 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-07-21_04-24-36';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-24-36';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-25-12';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-25-12';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-25-12']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G200_he0_ve-10_hs0_vs0_2008-07-21_04-26-00';
                                  'C1G200_he0_ve-5_hs0_vs0_2008-07-21_04-26-11 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-26-23  ';
                                  'C1G200_he0_ve5_hs0_vs0_2008-07-21_04-26-34  ';
                                  'C1G200_he0_ve10_hs0_vs0_2008-07-21_04-26-45 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-07-21_04-25-47';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-25-47';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-26-23';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-26-23';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-26-23']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G200_he0_ve0_hs-10_vs0_2008-07-21_04-27-10';
                                  'C1G200_he0_ve0_hs-5_vs0_2008-07-21_04-27-21 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-27-33  ';
                                  'C1G200_he0_ve0_hs5_vs0_2008-07-21_04-27-44  ';
                                  'C1G200_he0_ve0_hs10_vs0_2008-07-21_04-27-55 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-07-21_04-26-58';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-26-58';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-27-33';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-27-33';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-27-33']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G200_he0_ve0_hs0_vs-10_2008-07-21_04-28-19';
                                  'C1G200_he0_ve0_hs0_vs-5_2008-07-21_04-28-31 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-28-42  ';
                                  'C1G200_he0_ve0_hs0_vs5_2008-07-21_04-28-54  ';
                                  'C1G200_he0_ve0_hs0_vs10_2008-07-21_04-29-05 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-07-21_04-28-07';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-28-07';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-28-42';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-28-42';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-21_04-28-42']);
        end
    elseif (gap >= 0.5*(200 + 240))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G240_he-10_ve0_hs0_vs0_2008-07-21_04-29-48';
                                  'C1G240_he-5_ve0_hs0_vs0_2008-07-21_04-30-00 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-30-11  ';
                                  'C1G240_he5_ve0_hs0_vs0_2008-07-21_04-30-22  ';
                                  'C1G240_he10_ve0_hs0_vs0_2008-07-21_04-30-34 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-07-21_04-29-36';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-29-36';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-30-11';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-30-11';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-30-11']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G240_he0_ve-10_hs0_vs0_2008-07-21_04-30-58';
                                  'C1G240_he0_ve-5_hs0_vs0_2008-07-21_04-31-11 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-31-22  ';
                                  'C1G240_he0_ve5_hs0_vs0_2008-07-21_04-31-34  ';
                                  'C1G240_he0_ve10_hs0_vs0_2008-07-21_04-31-46 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-07-21_04-30-46';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-30-46';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-31-22';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-31-22';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-31-22']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G240_he0_ve0_hs-10_vs0_2008-07-21_04-32-10';
                                  'C1G240_he0_ve0_hs-5_vs0_2008-07-21_04-32-22 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-32-33  ';
                                  'C1G240_he0_ve0_hs5_vs0_2008-07-21_04-32-45  ';
                                  'C1G240_he0_ve0_hs10_vs0_2008-07-21_04-32-56 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-07-21_04-31-58';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-31-58';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-32-33';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-32-33';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-32-33']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G240_he0_ve0_hs0_vs-10_2008-07-21_04-33-21';
                                  'C1G240_he0_ve0_hs0_vs-5_2008-07-21_04-33-32 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-33-43  ';
                                  'C1G240_he0_ve0_hs0_vs5_2008-07-21_04-33-55  ';
                                  'C1G240_he0_ve0_hs0_vs10_2008-07-21_04-34-07 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-07-21_04-33-08';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-33-08';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-33-43';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-33-43';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-21_04-33-43']);
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU44 TEMPO  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(idName, 'HU44_TEMPO')
    vCurVals = [-10, -5, 0, 5, 10];
    if (gap <0.5*(15.5+ 18))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G15_5_he-10_ve0_hs0_vs0_2008-07-14_09-09-51';
                                  'C1G15_5_he-5_ve0_hs0_vs0_2008-07-14_09-10-05 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-10-19  ';
                                  'C1G15_5_he5_ve0_hs0_vs0_2008-07-14_09-10-32  ';
                                  'C1G15_5_he10_ve0_hs0_vs0_2008-07-14_09-10-46 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-09-36';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-09-36';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-10-19';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-10-19';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-10-19']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G15_5_he0_ve-10_hs0_vs0_2008-07-14_09-11-17';
                                  'C1G15_5_he0_ve-5_hs0_vs0_2008-07-14_09-11-30 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-11-44  ';
                                  'C1G15_5_he0_ve5_hs0_vs0_2008-07-14_09-11-59  ';
                                  'C1G15_5_he0_ve10_hs0_vs0_2008-07-14_09-12-12 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-11-01';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-11-01';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-11-44';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-11-44';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-11-44']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G15_5_he0_ve0_hs-10_vs0_2008-07-14_09-12-41';
                                  'C1G15_5_he0_ve0_hs-5_vs0_2008-07-14_09-12-56 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-13-09  ';
                                  'C1G15_5_he0_ve0_hs5_vs0_2008-07-14_09-13-24  ';
                                  'C1G15_5_he0_ve0_hs10_vs0_2008-07-14_09-13-39 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-12-27';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-12-27';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-13-09';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-13-09';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-13-09']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G15_5_he0_ve0_hs0_vs-10_2008-07-14_09-14-09';
                                  'C1G15_5_he0_ve0_hs0_vs-5_2008-07-14_09-14-24 ';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-14-38  ';
                                  'C1G15_5_he0_ve0_hs0_vs5_2008-07-14_09-14-52  ';
                                  'C1G15_5_he0_ve0_hs0_vs10_2008-07-14_09-15-06 ']);
            fnMeasBkgr = cellstr(['C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-13-54';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-13-54';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-14-38';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-14-38';
                                  'C1G15_5_he0_ve0_hs0_vs0_2008-07-14_09-14-38']);
        end
    elseif (gap <0.5*(18+ 20))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G18_he-10_ve0_hs0_vs0_2008-07-14_10-21-06';
                                  'C1G18_he-5_ve0_hs0_vs0_2008-07-14_10-21-20 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-21-34  ';
                                  'C1G18_he5_ve0_hs0_vs0_2008-07-14_10-21-48  ';
                                  'C1G18_he10_ve0_hs0_vs0_2008-07-14_10-22-02 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-07-14_10-20-51';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-20-51';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-21-34';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-21-34';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-21-34']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G18_he0_ve-10_hs0_vs0_2008-07-14_10-22-33';
                                  'C1G18_he0_ve-5_hs0_vs0_2008-07-14_10-22-47 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-23-00  ';
                                  'C1G18_he0_ve5_hs0_vs0_2008-07-14_10-23-15  ';
                                  'C1G18_he0_ve10_hs0_vs0_2008-07-14_10-23-28 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-07-14_10-22-17';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-22-17';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-23-00';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-23-00';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-23-00']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G18_he0_ve0_hs-10_vs0_2008-07-14_10-23-59';
                                  'C1G18_he0_ve0_hs-5_vs0_2008-07-14_10-24-14 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-24-28  ';
                                  'C1G18_he0_ve0_hs5_vs0_2008-07-14_10-24-42  ';
                                  'C1G18_he0_ve0_hs10_vs0_2008-07-14_10-24-56 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-07-14_10-23-44';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-23-44';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-24-28';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-24-28';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-24-28']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G18_he0_ve0_hs0_vs-10_2008-07-14_10-25-28';
                                  'C1G18_he0_ve0_hs0_vs-5_2008-07-14_10-25-41 ';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-25-56  ';
                                  'C1G18_he0_ve0_hs0_vs5_2008-07-14_10-26-11  ';
                                  'C1G18_he0_ve0_hs0_vs10_2008-07-14_10-26-25 ']);
            fnMeasBkgr = cellstr(['C1G18_he0_ve0_hs0_vs0_2008-07-14_10-25-12';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-25-12';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-25-56';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-25-56';
                                  'C1G18_he0_ve0_hs0_vs0_2008-07-14_10-25-56']);
        end
    elseif (gap <0.5*(20+ 25))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G20_he-10_ve0_hs0_vs0_2008-07-14_10-34-08';
                                  'C1G20_he-5_ve0_hs0_vs0_2008-07-14_10-34-23 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-34-36  ';
                                  'C1G20_he5_ve0_hs0_vs0_2008-07-14_10-34-50  ';
                                  'C1G20_he10_ve0_hs0_vs0_2008-07-14_10-35-03 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-07-14_10-33-53';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-33-53';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-34-36';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-34-36';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-34-36']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G20_he0_ve-10_hs0_vs0_2008-07-14_10-35-35';
                                  'C1G20_he0_ve-5_hs0_vs0_2008-07-14_10-35-49 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-36-04  ';
                                  'C1G20_he0_ve5_hs0_vs0_2008-07-14_10-36-18  ';
                                  'C1G20_he0_ve10_hs0_vs0_2008-07-14_10-36-33 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-07-14_10-35-19';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-35-19';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-36-04';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-36-04';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-36-04']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G20_he0_ve0_hs-10_vs0_2008-07-14_10-37-04';
                                  'C1G20_he0_ve0_hs-5_vs0_2008-07-14_10-37-17 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-37-31  ';
                                  'C1G20_he0_ve0_hs5_vs0_2008-07-14_10-37-46  ';
                                  'C1G20_he0_ve0_hs10_vs0_2008-07-14_10-37-59 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-07-14_10-36-48';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-36-48';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-37-31';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-37-31';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-37-31']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G20_he0_ve0_hs0_vs-10_2008-07-14_10-38-29';
                                  'C1G20_he0_ve0_hs0_vs-5_2008-07-14_10-38-43 ';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-38-58  ';
                                  'C1G20_he0_ve0_hs0_vs5_2008-07-14_10-39-11  ';
                                  'C1G20_he0_ve0_hs0_vs10_2008-07-14_10-39-26 ']);
            fnMeasBkgr = cellstr(['C1G20_he0_ve0_hs0_vs0_2008-07-14_10-38-14';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-38-14';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-38-58';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-38-58';
                                  'C1G20_he0_ve0_hs0_vs0_2008-07-14_10-38-58']);
        end
    elseif (gap <0.5*(25+ 30))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G25_he-10_ve0_hs0_vs0_2008-07-14_10-41-36';
                                  'C1G25_he-5_ve0_hs0_vs0_2008-07-14_10-41-51 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-42-05  ';
                                  'C1G25_he5_ve0_hs0_vs0_2008-07-14_10-42-19  ';
                                  'C1G25_he10_ve0_hs0_vs0_2008-07-14_10-42-34 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-07-14_10-41-20';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-41-20';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-42-05';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-42-05';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-42-05']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G25_he0_ve-10_hs0_vs0_2008-07-14_10-43-03';
                                  'C1G25_he0_ve-5_hs0_vs0_2008-07-14_10-43-17 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-43-30  ';
                                  'C1G25_he0_ve5_hs0_vs0_2008-07-14_10-43-44  ';
                                  'C1G25_he0_ve10_hs0_vs0_2008-07-14_10-43-59 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-07-14_10-42-49';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-42-49';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-43-30';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-43-30';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-43-30']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G25_he0_ve0_hs-10_vs0_2008-07-14_10-44-31';
                                  'C1G25_he0_ve0_hs-5_vs0_2008-07-14_10-44-44 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-44-58  ';
                                  'C1G25_he0_ve0_hs5_vs0_2008-07-14_10-45-13  ';
                                  'C1G25_he0_ve0_hs10_vs0_2008-07-14_10-45-27 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-07-14_10-44-15';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-44-15';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-44-58';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-44-58';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-44-58']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G25_he0_ve0_hs0_vs-10_2008-07-14_10-45-58';
                                  'C1G25_he0_ve0_hs0_vs-5_2008-07-14_10-46-12 ';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-46-27  ';
                                  'C1G25_he0_ve0_hs0_vs5_2008-07-14_10-46-41  ';
                                  'C1G25_he0_ve0_hs0_vs10_2008-07-14_10-46-54 ']);
            fnMeasBkgr = cellstr(['C1G25_he0_ve0_hs0_vs0_2008-07-14_10-45-42';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-45-42';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-46-27';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-46-27';
                                  'C1G25_he0_ve0_hs0_vs0_2008-07-14_10-46-27']);
        end
    elseif (gap <0.5*(30+ 35))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G30_he-10_ve0_hs0_vs0_2008-07-14_10-50-52';
                                  'C1G30_he-5_ve0_hs0_vs0_2008-07-14_10-51-07 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-51-20  ';
                                  'C1G30_he5_ve0_hs0_vs0_2008-07-14_10-51-35  ';
                                  'C1G30_he10_ve0_hs0_vs0_2008-07-14_10-51-50 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-07-14_10-50-37';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-50-37';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-51-20';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-51-20';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-51-20']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G30_he0_ve-10_hs0_vs0_2008-07-14_10-52-22';
                                  'C1G30_he0_ve-5_hs0_vs0_2008-07-14_10-52-36 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-52-50  ';
                                  'C1G30_he0_ve5_hs0_vs0_2008-07-14_10-53-05  ';
                                  'C1G30_he0_ve10_hs0_vs0_2008-07-14_10-53-18 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-07-14_10-52-05';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-52-05';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-52-50';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-52-50';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-52-50']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G30_he0_ve0_hs-10_vs0_2008-07-14_10-53-48';
                                  'C1G30_he0_ve0_hs-5_vs0_2008-07-14_10-54-02 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-54-16  ';
                                  'C1G30_he0_ve0_hs5_vs0_2008-07-14_10-54-30  ';
                                  'C1G30_he0_ve0_hs10_vs0_2008-07-14_10-54-43 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-07-14_10-53-33';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-53-33';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-54-16';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-54-16';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-54-16']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G30_he0_ve0_hs0_vs-10_2008-07-14_10-55-13';
                                  'C1G30_he0_ve0_hs0_vs-5_2008-07-14_10-55-27 ';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-55-42  ';
                                  'C1G30_he0_ve0_hs0_vs5_2008-07-14_10-55-57  ';
                                  'C1G30_he0_ve0_hs0_vs10_2008-07-14_10-56-11 ']);
            fnMeasBkgr = cellstr(['C1G30_he0_ve0_hs0_vs0_2008-07-14_10-54-58';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-54-58';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-55-42';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-55-42';
                                  'C1G30_he0_ve0_hs0_vs0_2008-07-14_10-55-42']);
        end
    elseif (gap <0.5*(35+ 40))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G35_he-10_ve0_hs0_vs0_2008-07-14_10-57-57';
                                  'C1G35_he-5_ve0_hs0_vs0_2008-07-14_10-58-13 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_10-58-28  ';
                                  'C1G35_he5_ve0_hs0_vs0_2008-07-14_10-58-42  ';
                                  'C1G35_he10_ve0_hs0_vs0_2008-07-14_10-58-56 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-07-14_10-57-43';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_10-57-43';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_10-58-28';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_10-58-28';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_10-58-28']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G35_he0_ve-10_hs0_vs0_2008-07-14_10-59-26';
                                  'C1G35_he0_ve-5_hs0_vs0_2008-07-14_10-59-41 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_10-59-56  ';
                                  'C1G35_he0_ve5_hs0_vs0_2008-07-14_11-00-11  ';
                                  'C1G35_he0_ve10_hs0_vs0_2008-07-14_11-00-25 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-07-14_10-59-11';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_10-59-11';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_10-59-56';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_10-59-56';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_10-59-56']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G35_he0_ve0_hs-10_vs0_2008-07-14_11-00-56';
                                  'C1G35_he0_ve0_hs-5_vs0_2008-07-14_11-01-09 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_11-01-23  ';
                                  'C1G35_he0_ve0_hs5_vs0_2008-07-14_11-01-37  ';
                                  'C1G35_he0_ve0_hs10_vs0_2008-07-14_11-01-51 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-07-14_11-00-41';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_11-00-41';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_11-01-23';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_11-01-23';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_11-01-23']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G35_he0_ve0_hs0_vs-10_2008-07-14_11-02-23';
                                  'C1G35_he0_ve0_hs0_vs-5_2008-07-14_11-02-39 ';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_11-02-53  ';
                                  'C1G35_he0_ve0_hs0_vs5_2008-07-14_11-03-07  ';
                                  'C1G35_he0_ve0_hs0_vs10_2008-07-14_11-03-22 ']);
            fnMeasBkgr = cellstr(['C1G35_he0_ve0_hs0_vs0_2008-07-14_11-02-07';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_11-02-07';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_11-02-53';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_11-02-53';
                                  'C1G35_he0_ve0_hs0_vs0_2008-07-14_11-02-53']);
        end
    elseif (gap <0.5*(40+ 45))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G40_he-10_ve0_hs0_vs0_2008-07-14_11-08-30';
                                  'C1G40_he-5_ve0_hs0_vs0_2008-07-14_11-08-44 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-08-58  ';
                                  'C1G40_he5_ve0_hs0_vs0_2008-07-14_11-09-11  ';
                                  'C1G40_he10_ve0_hs0_vs0_2008-07-14_11-09-26 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-07-14_11-08-15';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-08-15';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-08-58';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-08-58';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-08-58']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G40_he0_ve-10_hs0_vs0_2008-07-14_11-09-56';
                                  'C1G40_he0_ve-5_hs0_vs0_2008-07-14_11-10-10 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-10-23  ';
                                  'C1G40_he0_ve5_hs0_vs0_2008-07-14_11-10-38  ';
                                  'C1G40_he0_ve10_hs0_vs0_2008-07-14_11-10-52 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-07-14_11-09-40';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-09-40';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-10-23';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-10-23';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-10-23']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G40_he0_ve0_hs-10_vs0_2008-07-14_11-11-23';
                                  'C1G40_he0_ve0_hs-5_vs0_2008-07-14_11-11-38 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-11-52  ';
                                  'C1G40_he0_ve0_hs5_vs0_2008-07-14_11-12-08  ';
                                  'C1G40_he0_ve0_hs10_vs0_2008-07-14_11-12-21 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-07-14_11-11-08';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-11-08';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-11-52';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-11-52';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-11-52']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G40_he0_ve0_hs0_vs-10_2008-07-14_11-12-51';
                                  'C1G40_he0_ve0_hs0_vs-5_2008-07-14_11-13-05 ';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-13-20  ';
                                  'C1G40_he0_ve0_hs0_vs5_2008-07-14_11-13-35  ';
                                  'C1G40_he0_ve0_hs0_vs10_2008-07-14_11-13-48 ']);
            fnMeasBkgr = cellstr(['C1G40_he0_ve0_hs0_vs0_2008-07-14_11-12-36';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-12-36';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-13-20';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-13-20';
                                  'C1G40_he0_ve0_hs0_vs0_2008-07-14_11-13-20']);
        end
    elseif (gap <0.5*(45+ 50))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G45_he-10_ve0_hs0_vs0_2008-07-14_11-15-56';
                                  'C1G45_he-5_ve0_hs0_vs0_2008-07-14_11-16-10 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-16-24  ';
                                  'C1G45_he5_ve0_hs0_vs0_2008-07-14_11-16-37  ';
                                  'C1G45_he10_ve0_hs0_vs0_2008-07-14_11-16-52 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-07-14_11-15-41';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-15-41';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-16-24';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-16-24';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-16-24']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G45_he0_ve-10_hs0_vs0_2008-07-14_11-17-22';
                                  'C1G45_he0_ve-5_hs0_vs0_2008-07-14_11-17-35 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-17-50  ';
                                  'C1G45_he0_ve5_hs0_vs0_2008-07-14_11-18-04  ';
                                  'C1G45_he0_ve10_hs0_vs0_2008-07-14_11-18-16 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-07-14_11-17-07';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-17-07';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-17-50';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-17-50';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-17-50']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G45_he0_ve0_hs-10_vs0_2008-07-14_11-18-47';
                                  'C1G45_he0_ve0_hs-5_vs0_2008-07-14_11-19-01 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-19-15  ';
                                  'C1G45_he0_ve0_hs5_vs0_2008-07-14_11-19-30  ';
                                  'C1G45_he0_ve0_hs10_vs0_2008-07-14_11-19-44 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-07-14_11-18-32';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-18-32';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-19-15';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-19-15';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-19-15']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G45_he0_ve0_hs0_vs-10_2008-07-14_11-20-15';
                                  'C1G45_he0_ve0_hs0_vs-5_2008-07-14_11-20-30 ';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-20-44  ';
                                  'C1G45_he0_ve0_hs0_vs5_2008-07-14_11-20-57  ';
                                  'C1G45_he0_ve0_hs0_vs10_2008-07-14_11-21-12 ']);
            fnMeasBkgr = cellstr(['C1G45_he0_ve0_hs0_vs0_2008-07-14_11-20-00';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-20-00';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-20-44';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-20-44';
                                  'C1G45_he0_ve0_hs0_vs0_2008-07-14_11-20-44']);
        end
    elseif (gap <0.5*(50+ 60))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G50_he-10_ve0_hs0_vs0_2008-07-14_11-24-46';
                                  'C1G50_he-5_ve0_hs0_vs0_2008-07-14_11-25-00 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-25-13  ';
                                  'C1G50_he5_ve0_hs0_vs0_2008-07-14_11-25-28  ';
                                  'C1G50_he10_ve0_hs0_vs0_2008-07-14_11-25-41 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-07-14_11-24-31';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-24-31';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-25-13';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-25-13';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-25-13']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G50_he0_ve-10_hs0_vs0_2008-07-14_11-26-12';
                                  'C1G50_he0_ve-5_hs0_vs0_2008-07-14_11-26-26 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-26-39  ';
                                  'C1G50_he0_ve5_hs0_vs0_2008-07-14_11-26-53  ';
                                  'C1G50_he0_ve10_hs0_vs0_2008-07-14_11-27-07 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-07-14_11-25-57';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-25-57';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-26-39';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-26-39';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-26-39']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G50_he0_ve0_hs-10_vs0_2008-07-14_11-27-39';
                                  'C1G50_he0_ve0_hs-5_vs0_2008-07-14_11-27-52 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-28-07  ';
                                  'C1G50_he0_ve0_hs5_vs0_2008-07-14_11-28-20  ';
                                  'C1G50_he0_ve0_hs10_vs0_2008-07-14_11-28-35 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-07-14_11-27-22';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-27-22';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-28-07';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-28-07';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-28-07']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G50_he0_ve0_hs0_vs-10_2008-07-14_11-29-05';
                                  'C1G50_he0_ve0_hs0_vs-5_2008-07-14_11-29-19 ';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-29-34  ';
                                  'C1G50_he0_ve0_hs0_vs5_2008-07-14_11-29-49  ';
                                  'C1G50_he0_ve0_hs0_vs10_2008-07-14_11-30-02 ']);
            fnMeasBkgr = cellstr(['C1G50_he0_ve0_hs0_vs0_2008-07-14_11-28-50';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-28-50';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-29-34';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-29-34';
                                  'C1G50_he0_ve0_hs0_vs0_2008-07-14_11-29-34']);
        end
    elseif (gap <0.5*(60+ 70))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G60_he-10_ve0_hs0_vs0_2008-07-14_11-34-22';
                                  'C1G60_he-5_ve0_hs0_vs0_2008-07-14_11-34-36 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-34-50  ';
                                  'C1G60_he5_ve0_hs0_vs0_2008-07-14_11-35-03  ';
                                  'C1G60_he10_ve0_hs0_vs0_2008-07-14_11-35-18 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-07-14_11-34-06';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-34-06';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-34-50';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-34-50';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-34-50']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G60_he0_ve-10_hs0_vs0_2008-07-14_11-35-49';
                                  'C1G60_he0_ve-5_hs0_vs0_2008-07-14_11-36-04 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-36-17  ';
                                  'C1G60_he0_ve5_hs0_vs0_2008-07-14_11-36-31  ';
                                  'C1G60_he0_ve10_hs0_vs0_2008-07-14_11-36-45 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-07-14_11-35-34';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-35-34';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-36-17';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-36-17';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-36-17']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G60_he0_ve0_hs-10_vs0_2008-07-14_11-37-17';
                                  'C1G60_he0_ve0_hs-5_vs0_2008-07-14_11-37-31 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-37-46  ';
                                  'C1G60_he0_ve0_hs5_vs0_2008-07-14_11-38-00  ';
                                  'C1G60_he0_ve0_hs10_vs0_2008-07-14_11-38-15 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-07-14_11-37-01';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-37-01';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-37-46';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-37-46';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-37-46']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G60_he0_ve0_hs0_vs-10_2008-07-14_11-38-46';
                                  'C1G60_he0_ve0_hs0_vs-5_2008-07-14_11-39-00 ';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-39-14  ';
                                  'C1G60_he0_ve0_hs0_vs5_2008-07-14_11-39-29  ';
                                  'C1G60_he0_ve0_hs0_vs10_2008-07-14_11-39-43 ']);
            fnMeasBkgr = cellstr(['C1G60_he0_ve0_hs0_vs0_2008-07-14_11-38-30';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-38-30';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-39-14';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-39-14';
                                  'C1G60_he0_ve0_hs0_vs0_2008-07-14_11-39-14']);
        end
    elseif (gap <0.5*(70+ 80))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G70_he-10_ve0_hs0_vs0_2008-07-14_11-41-22';
                                  'C1G70_he-5_ve0_hs0_vs0_2008-07-14_11-41-35 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-41-49  ';
                                  'C1G70_he5_ve0_hs0_vs0_2008-07-14_11-42-04  ';
                                  'C1G70_he10_ve0_hs0_vs0_2008-07-14_11-42-17 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-07-14_11-41-06';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-41-06';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-41-49';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-41-49';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-41-49']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G70_he0_ve-10_hs0_vs0_2008-07-14_11-42-49';
                                  'C1G70_he0_ve-5_hs0_vs0_2008-07-14_11-43-02 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-43-17  ';
                                  'C1G70_he0_ve5_hs0_vs0_2008-07-14_11-43-30  ';
                                  'C1G70_he0_ve10_hs0_vs0_2008-07-14_11-43-44 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-07-14_11-42-33';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-42-33';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-43-17';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-43-17';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-43-17']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G70_he0_ve0_hs-10_vs0_2008-07-14_11-44-14';
                                  'C1G70_he0_ve0_hs-5_vs0_2008-07-14_11-44-28 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-44-42  ';
                                  'C1G70_he0_ve0_hs5_vs0_2008-07-14_11-44-56  ';
                                  'C1G70_he0_ve0_hs10_vs0_2008-07-14_11-45-10 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-07-14_11-43-59';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-43-59';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-44-42';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-44-42';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-44-42']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G70_he0_ve0_hs0_vs-10_2008-07-14_11-45-39';
                                  'C1G70_he0_ve0_hs0_vs-5_2008-07-14_11-45-54 ';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-46-08  ';
                                  'C1G70_he0_ve0_hs0_vs5_2008-07-14_11-46-21  ';
                                  'C1G70_he0_ve0_hs0_vs10_2008-07-14_11-46-35 ']);
            fnMeasBkgr = cellstr(['C1G70_he0_ve0_hs0_vs0_2008-07-14_11-45-25';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-45-25';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-46-08';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-46-08';
                                  'C1G70_he0_ve0_hs0_vs0_2008-07-14_11-46-08']);
        end
    elseif (gap <0.5*(80+ 90))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G80_he-10_ve0_hs0_vs0_2008-07-14_11-49-35';
                                  'C1G80_he-5_ve0_hs0_vs0_2008-07-14_11-49-49 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-50-03  ';
                                  'C1G80_he5_ve0_hs0_vs0_2008-07-14_11-50-16  ';
                                  'C1G80_he10_ve0_hs0_vs0_2008-07-14_11-50-30 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-07-14_11-49-20';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-49-20';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-50-03';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-50-03';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-50-03']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G80_he0_ve-10_hs0_vs0_2008-07-14_11-51-01';
                                  'C1G80_he0_ve-5_hs0_vs0_2008-07-14_11-51-14 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-51-29  ';
                                  'C1G80_he0_ve5_hs0_vs0_2008-07-14_11-51-42  ';
                                  'C1G80_he0_ve10_hs0_vs0_2008-07-14_11-51-56 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-07-14_11-50-45';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-50-45';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-51-29';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-51-29';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-51-29']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G80_he0_ve0_hs-10_vs0_2008-07-14_11-52-26';
                                  'C1G80_he0_ve0_hs-5_vs0_2008-07-14_11-52-41 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-52-56  ';
                                  'C1G80_he0_ve0_hs5_vs0_2008-07-14_11-53-10  ';
                                  'C1G80_he0_ve0_hs10_vs0_2008-07-14_11-53-24 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-07-14_11-52-10';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-52-10';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-52-56';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-52-56';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-52-56']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G80_he0_ve0_hs0_vs-10_2008-07-14_11-53-54';
                                  'C1G80_he0_ve0_hs0_vs-5_2008-07-14_11-54-08 ';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-54-22  ';
                                  'C1G80_he0_ve0_hs0_vs5_2008-07-14_11-54-36  ';
                                  'C1G80_he0_ve0_hs0_vs10_2008-07-14_11-54-51 ']);
            fnMeasBkgr = cellstr(['C1G80_he0_ve0_hs0_vs0_2008-07-14_11-53-39';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-53-39';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-54-22';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-54-22';
                                  'C1G80_he0_ve0_hs0_vs0_2008-07-14_11-54-22']);
        end
    elseif (gap <0.5*(90+ 100))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G90_he-10_ve0_hs0_vs0_2008-07-14_11-58-30';
                                  'C1G90_he-5_ve0_hs0_vs0_2008-07-14_11-58-43 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_11-58-58  ';
                                  'C1G90_he5_ve0_hs0_vs0_2008-07-14_11-59-10  ';
                                  'C1G90_he10_ve0_hs0_vs0_2008-07-14_11-59-25 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-07-14_11-58-16';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_11-58-16';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_11-58-58';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_11-58-58';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_11-58-58']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G90_he0_ve-10_hs0_vs0_2008-07-14_11-59-56';
                                  'C1G90_he0_ve-5_hs0_vs0_2008-07-14_12-00-09 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-00-24  ';
                                  'C1G90_he0_ve5_hs0_vs0_2008-07-14_12-00-38  ';
                                  'C1G90_he0_ve10_hs0_vs0_2008-07-14_12-00-53 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-07-14_11-59-40';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_11-59-40';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-00-24';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-00-24';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-00-24']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G90_he0_ve0_hs-10_vs0_2008-07-14_12-01-22';
                                  'C1G90_he0_ve0_hs-5_vs0_2008-07-14_12-01-37 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-01-51  ';
                                  'C1G90_he0_ve0_hs5_vs0_2008-07-14_12-02-05  ';
                                  'C1G90_he0_ve0_hs10_vs0_2008-07-14_12-02-19 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-07-14_12-01-08';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-01-08';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-01-51';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-01-51';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-01-51']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G90_he0_ve0_hs0_vs-10_2008-07-14_12-02-51';
                                  'C1G90_he0_ve0_hs0_vs-5_2008-07-14_12-03-04 ';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-03-18  ';
                                  'C1G90_he0_ve0_hs0_vs5_2008-07-14_12-03-32  ';
                                  'C1G90_he0_ve0_hs0_vs10_2008-07-14_12-03-46 ']);
            fnMeasBkgr = cellstr(['C1G90_he0_ve0_hs0_vs0_2008-07-14_12-02-35';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-02-35';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-03-18';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-03-18';
                                  'C1G90_he0_ve0_hs0_vs0_2008-07-14_12-03-18']);
        end
    elseif (gap <0.5*(100+ 110))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G100_he-10_ve0_hs0_vs0_2008-07-14_12-04-49';
                                  'C1G100_he-5_ve0_hs0_vs0_2008-07-14_12-05-03 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-05-17  ';
                                  'C1G100_he5_ve0_hs0_vs0_2008-07-14_12-05-30  ';
                                  'C1G100_he10_ve0_hs0_vs0_2008-07-14_12-05-44 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-07-14_12-04-33';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-04-33';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-05-17';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-05-17';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-05-17']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G100_he0_ve-10_hs0_vs0_2008-07-14_12-06-16';
                                  'C1G100_he0_ve-5_hs0_vs0_2008-07-14_12-06-31 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-06-44  ';
                                  'C1G100_he0_ve5_hs0_vs0_2008-07-14_12-06-58  ';
                                  'C1G100_he0_ve10_hs0_vs0_2008-07-14_12-07-13 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-07-14_12-05-59';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-05-59';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-06-44';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-06-44';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-06-44']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G100_he0_ve0_hs-10_vs0_2008-07-14_12-07-43';
                                  'C1G100_he0_ve0_hs-5_vs0_2008-07-14_12-07-57 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-08-11  ';
                                  'C1G100_he0_ve0_hs5_vs0_2008-07-14_12-08-25  ';
                                  'C1G100_he0_ve0_hs10_vs0_2008-07-14_12-08-38 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-07-14_12-07-27';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-07-27';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-08-11';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-08-11';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-08-11']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G100_he0_ve0_hs0_vs-10_2008-07-14_12-09-07';
                                  'C1G100_he0_ve0_hs0_vs-5_2008-07-14_12-09-21 ';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-09-35  ';
                                  'C1G100_he0_ve0_hs0_vs5_2008-07-14_12-09-50  ';
                                  'C1G100_he0_ve0_hs0_vs10_2008-07-14_12-10-04 ']);
            fnMeasBkgr = cellstr(['C1G100_he0_ve0_hs0_vs0_2008-07-14_12-08-52';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-08-52';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-09-35';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-09-35';
                                  'C1G100_he0_ve0_hs0_vs0_2008-07-14_12-09-35']);
        end
    elseif (gap <0.5*(110+ 120))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G110_he-10_ve0_hs0_vs0_2008-07-14_12-12-57';
                                  'C1G110_he-5_ve0_hs0_vs0_2008-07-14_12-13-13 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-13-27  ';
                                  'C1G110_he5_ve0_hs0_vs0_2008-07-14_12-13-40  ';
                                  'C1G110_he10_ve0_hs0_vs0_2008-07-14_12-13-56 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-07-14_12-12-41';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-12-41';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-13-27';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-13-27';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-13-27']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G110_he0_ve-10_hs0_vs0_2008-07-14_12-14-25';
                                  'C1G110_he0_ve-5_hs0_vs0_2008-07-14_12-14-39 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-14-54  ';
                                  'C1G110_he0_ve5_hs0_vs0_2008-07-14_12-15-08  ';
                                  'C1G110_he0_ve10_hs0_vs0_2008-07-14_12-15-22 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-07-14_12-14-10';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-14-10';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-14-54';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-14-54';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-14-54']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G110_he0_ve0_hs-10_vs0_2008-07-14_12-15-52';
                                  'C1G110_he0_ve0_hs-5_vs0_2008-07-14_12-16-06 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-16-21  ';
                                  'C1G110_he0_ve0_hs5_vs0_2008-07-14_12-16-36  ';
                                  'C1G110_he0_ve0_hs10_vs0_2008-07-14_12-16-51 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-07-14_12-15-37';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-15-37';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-16-21';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-16-21';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-16-21']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G110_he0_ve0_hs0_vs-10_2008-07-14_12-17-22';
                                  'C1G110_he0_ve0_hs0_vs-5_2008-07-14_12-17-37 ';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-17-51  ';
                                  'C1G110_he0_ve0_hs0_vs5_2008-07-14_12-18-04  ';
                                  'C1G110_he0_ve0_hs0_vs10_2008-07-14_12-18-19 ']);
            fnMeasBkgr = cellstr(['C1G110_he0_ve0_hs0_vs0_2008-07-14_12-17-07';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-17-07';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-17-51';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-17-51';
                                  'C1G110_he0_ve0_hs0_vs0_2008-07-14_12-17-51']);
        end
    elseif (gap <0.5*(120+ 130))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G120_he-10_ve0_hs0_vs0_2008-07-14_12-19-45';
                                  'C1G120_he-5_ve0_hs0_vs0_2008-07-14_12-19-59 ';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-20-13  ';
                                  'C1G120_he5_ve0_hs0_vs0_2008-07-14_12-20-26  ';
                                  'C1G120_he10_ve0_hs0_vs0_2008-07-14_12-20-39 ']);
            fnMeasBkgr = cellstr(['C1G120_he0_ve0_hs0_vs0_2008-07-14_12-19-30';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-19-30';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-20-13';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-20-13';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-20-13']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G120_he0_ve-10_hs0_vs0_2008-07-14_12-21-10';
                                  'C1G120_he0_ve-5_hs0_vs0_2008-07-14_12-21-26 ';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-21-39  ';
                                  'C1G120_he0_ve5_hs0_vs0_2008-07-14_12-21-53  ';
                                  'C1G120_he0_ve10_hs0_vs0_2008-07-14_12-22-07 ']);
            fnMeasBkgr = cellstr(['C1G120_he0_ve0_hs0_vs0_2008-07-14_12-20-55';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-20-55';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-21-39';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-21-39';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-21-39']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G120_he0_ve0_hs-10_vs0_2008-07-14_12-22-38';
                                  'C1G120_he0_ve0_hs-5_vs0_2008-07-14_12-22-52 ';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-23-05  ';
                                  'C1G120_he0_ve0_hs5_vs0_2008-07-14_12-23-20  ';
                                  'C1G120_he0_ve0_hs10_vs0_2008-07-14_12-23-34 ']);
            fnMeasBkgr = cellstr(['C1G120_he0_ve0_hs0_vs0_2008-07-14_12-22-22';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-22-22';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-23-05';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-23-05';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-23-05']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G120_he0_ve0_hs0_vs-10_2008-07-14_12-24-05';
                                  'C1G120_he0_ve0_hs0_vs-5_2008-07-14_12-24-20 ';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-24-35  ';
                                  'C1G120_he0_ve0_hs0_vs5_2008-07-14_12-24-49  ';
                                  'C1G120_he0_ve0_hs0_vs10_2008-07-14_12-25-04 ']);
            fnMeasBkgr = cellstr(['C1G120_he0_ve0_hs0_vs0_2008-07-14_12-23-49';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-23-49';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-24-35';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-24-35';
                                  'C1G120_he0_ve0_hs0_vs0_2008-07-14_12-24-35']);
        end
    elseif (gap <0.5*(130+ 140))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G130_he-10_ve0_hs0_vs0_2008-07-14_12-29-38';
                                  'C1G130_he-5_ve0_hs0_vs0_2008-07-14_12-29-53 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-30-07  ';
                                  'C1G130_he5_ve0_hs0_vs0_2008-07-14_12-30-22  ';
                                  'C1G130_he10_ve0_hs0_vs0_2008-07-14_12-30-36 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-07-14_12-29-23';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-29-23';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-30-07';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-30-07';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-30-07']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G130_he0_ve-10_hs0_vs0_2008-07-14_12-31-08';
                                  'C1G130_he0_ve-5_hs0_vs0_2008-07-14_12-31-23 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-31-36  ';
                                  'C1G130_he0_ve5_hs0_vs0_2008-07-14_12-31-50  ';
                                  'C1G130_he0_ve10_hs0_vs0_2008-07-14_12-32-04 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-07-14_12-30-52';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-30-52';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-31-36';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-31-36';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-31-36']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G130_he0_ve0_hs-10_vs0_2008-07-14_12-32-35';
                                  'C1G130_he0_ve0_hs-5_vs0_2008-07-14_12-32-50 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-33-04  ';
                                  'C1G130_he0_ve0_hs5_vs0_2008-07-14_12-33-19  ';
                                  'C1G130_he0_ve0_hs10_vs0_2008-07-14_12-33-34 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-07-14_12-32-20';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-32-20';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-33-04';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-33-04';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-33-04']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G130_he0_ve0_hs0_vs-10_2008-07-14_12-34-04';
                                  'C1G130_he0_ve0_hs0_vs-5_2008-07-14_12-34-19 ';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-34-32  ';
                                  'C1G130_he0_ve0_hs0_vs5_2008-07-14_12-34-47  ';
                                  'C1G130_he0_ve0_hs0_vs10_2008-07-14_12-35-00 ']);
            fnMeasBkgr = cellstr(['C1G130_he0_ve0_hs0_vs0_2008-07-14_12-33-49';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-33-49';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-34-32';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-34-32';
                                  'C1G130_he0_ve0_hs0_vs0_2008-07-14_12-34-32']);
        end
    elseif (gap <0.5*(140+ 150))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G140_he-10_ve0_hs0_vs0_2008-07-14_12-41-27';
                                  'C1G140_he-5_ve0_hs0_vs0_2008-07-14_12-41-40 ';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-41-55  ';
                                  'C1G140_he5_ve0_hs0_vs0_2008-07-14_12-42-10  ';
                                  'C1G140_he10_ve0_hs0_vs0_2008-07-14_12-42-23 ']);
            fnMeasBkgr = cellstr(['C1G140_he0_ve0_hs0_vs0_2008-07-14_12-41-11';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-41-11';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-41-55';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-41-55';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-41-55']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G140_he0_ve-10_hs0_vs0_2008-07-14_12-42-55';
                                  'C1G140_he0_ve-5_hs0_vs0_2008-07-14_12-43-09 ';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-43-23  ';
                                  'C1G140_he0_ve5_hs0_vs0_2008-07-14_12-43-38  ';
                                  'C1G140_he0_ve10_hs0_vs0_2008-07-14_12-43-51 ']);
            fnMeasBkgr = cellstr(['C1G140_he0_ve0_hs0_vs0_2008-07-14_12-42-39';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-42-39';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-43-23';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-43-23';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-43-23']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G140_he0_ve0_hs-10_vs0_2008-07-14_12-44-22';
                                  'C1G140_he0_ve0_hs-5_vs0_2008-07-14_12-44-35 ';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-44-50  ';
                                  'C1G140_he0_ve0_hs5_vs0_2008-07-14_12-45-04  ';
                                  'C1G140_he0_ve0_hs10_vs0_2008-07-14_12-45-19 ']);
            fnMeasBkgr = cellstr(['C1G140_he0_ve0_hs0_vs0_2008-07-14_12-44-06';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-44-06';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-44-50';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-44-50';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-44-50']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G140_he0_ve0_hs0_vs-10_2008-07-14_12-45-49';
                                  'C1G140_he0_ve0_hs0_vs-5_2008-07-14_12-46-05 ';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-46-20  ';
                                  'C1G140_he0_ve0_hs0_vs5_2008-07-14_12-46-35  ';
                                  'C1G140_he0_ve0_hs0_vs10_2008-07-14_12-46-49 ']);
            fnMeasBkgr = cellstr(['C1G140_he0_ve0_hs0_vs0_2008-07-14_12-45-34';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-45-34';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-46-20';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-46-20';
                                  'C1G140_he0_ve0_hs0_vs0_2008-07-14_12-46-20']);
        end
    elseif (gap <0.5*(150+ 170))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G150_he-10_ve0_hs0_vs0_2008-07-14_12-49-54';
                                  'C1G150_he-5_ve0_hs0_vs0_2008-07-14_12-50-07 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-50-21  ';
                                  'C1G150_he5_ve0_hs0_vs0_2008-07-14_12-50-34  ';
                                  'C1G150_he10_ve0_hs0_vs0_2008-07-14_12-50-47 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-07-14_12-49-39';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-49-39';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-50-21';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-50-21';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-50-21']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G150_he0_ve-10_hs0_vs0_2008-07-14_12-51-18';
                                  'C1G150_he0_ve-5_hs0_vs0_2008-07-14_12-51-31 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-51-46  ';
                                  'C1G150_he0_ve5_hs0_vs0_2008-07-14_12-52-00  ';
                                  'C1G150_he0_ve10_hs0_vs0_2008-07-14_12-52-13 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-07-14_12-51-03';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-51-03';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-51-46';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-51-46';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-51-46']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G150_he0_ve0_hs-10_vs0_2008-07-14_12-52-43';
                                  'C1G150_he0_ve0_hs-5_vs0_2008-07-14_12-52-56 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-53-11  ';
                                  'C1G150_he0_ve0_hs5_vs0_2008-07-14_12-53-25  ';
                                  'C1G150_he0_ve0_hs10_vs0_2008-07-14_12-53-39 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-07-14_12-52-28';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-52-28';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-53-11';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-53-11';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-53-11']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G150_he0_ve0_hs0_vs-10_2008-07-14_12-54-10';
                                  'C1G150_he0_ve0_hs0_vs-5_2008-07-14_12-54-24 ';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-54-39  ';
                                  'C1G150_he0_ve0_hs0_vs5_2008-07-14_12-54-54  ';
                                  'C1G150_he0_ve0_hs0_vs10_2008-07-14_12-55-08 ']);
            fnMeasBkgr = cellstr(['C1G150_he0_ve0_hs0_vs0_2008-07-14_12-53-54';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-53-54';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-54-39';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-54-39';
                                  'C1G150_he0_ve0_hs0_vs0_2008-07-14_12-54-39']);
        end
    elseif (gap <0.5*(170+ 200))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G170_he-10_ve0_hs0_vs0_2008-07-14_12-57-59';
                                  'C1G170_he-5_ve0_hs0_vs0_2008-07-14_12-58-12 ';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_12-58-26  ';
                                  'C1G170_he5_ve0_hs0_vs0_2008-07-14_12-58-39  ';
                                  'C1G170_he10_ve0_hs0_vs0_2008-07-14_12-58-53 ']);
            fnMeasBkgr = cellstr(['C1G170_he0_ve0_hs0_vs0_2008-07-14_12-57-44';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_12-57-44';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_12-58-26';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_12-58-26';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_12-58-26']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G170_he0_ve-10_hs0_vs0_2008-07-14_12-59-22';
                                  'C1G170_he0_ve-5_hs0_vs0_2008-07-14_12-59-37 ';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_12-59-51  ';
                                  'C1G170_he0_ve5_hs0_vs0_2008-07-14_13-00-05  ';
                                  'C1G170_he0_ve10_hs0_vs0_2008-07-14_13-00-18 ']);
            fnMeasBkgr = cellstr(['C1G170_he0_ve0_hs0_vs0_2008-07-14_12-59-07';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_12-59-07';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_12-59-51';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_12-59-51';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_12-59-51']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G170_he0_ve0_hs-10_vs0_2008-07-14_13-00-47';
                                  'C1G170_he0_ve0_hs-5_vs0_2008-07-14_13-01-02 ';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_13-01-17  ';
                                  'C1G170_he0_ve0_hs5_vs0_2008-07-14_13-01-31  ';
                                  'C1G170_he0_ve0_hs10_vs0_2008-07-14_13-01-46 ']);
            fnMeasBkgr = cellstr(['C1G170_he0_ve0_hs0_vs0_2008-07-14_13-00-33';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_13-00-33';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_13-01-17';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_13-01-17';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_13-01-17']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G170_he0_ve0_hs0_vs-10_2008-07-14_13-02-16';
                                  'C1G170_he0_ve0_hs0_vs-5_2008-07-14_13-02-31 ';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_13-02-45  ';
                                  'C1G170_he0_ve0_hs0_vs5_2008-07-14_13-03-00  ';
                                  'C1G170_he0_ve0_hs0_vs10_2008-07-14_13-03-14 ']);
            fnMeasBkgr = cellstr(['C1G170_he0_ve0_hs0_vs0_2008-07-14_13-02-02';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_13-02-02';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_13-02-45';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_13-02-45';
                                  'C1G170_he0_ve0_hs0_vs0_2008-07-14_13-02-45']);
        end
    elseif (gap <0.5*(200+ 240))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G200_he-10_ve0_hs0_vs0_2008-07-14_13-04-37';
                                  'C1G200_he-5_ve0_hs0_vs0_2008-07-14_13-04-50 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-05-04  ';
                                  'C1G200_he5_ve0_hs0_vs0_2008-07-14_13-05-19  ';
                                  'C1G200_he10_ve0_hs0_vs0_2008-07-14_13-05-33 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-07-14_13-04-22';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-04-22';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-05-04';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-05-04';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-05-04']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G200_he0_ve-10_hs0_vs0_2008-07-14_13-06-04';
                                  'C1G200_he0_ve-5_hs0_vs0_2008-07-14_13-06-17 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-06-31  ';
                                  'C1G200_he0_ve5_hs0_vs0_2008-07-14_13-06-46  ';
                                  'C1G200_he0_ve10_hs0_vs0_2008-07-14_13-06-59 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-07-14_13-05-48';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-05-48';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-06-31';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-06-31';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-06-31']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G200_he0_ve0_hs-10_vs0_2008-07-14_13-07-29';
                                  'C1G200_he0_ve0_hs-5_vs0_2008-07-14_13-07-43 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-07-56  ';
                                  'C1G200_he0_ve0_hs5_vs0_2008-07-14_13-08-10  ';
                                  'C1G200_he0_ve0_hs10_vs0_2008-07-14_13-08-25 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-07-14_13-07-15';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-07-15';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-07-56';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-07-56';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-07-56']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G200_he0_ve0_hs0_vs-10_2008-07-14_13-08-54';
                                  'C1G200_he0_ve0_hs0_vs-5_2008-07-14_13-09-09 ';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-09-22  ';
                                  'C1G200_he0_ve0_hs0_vs5_2008-07-14_13-09-36  ';
                                  'C1G200_he0_ve0_hs0_vs10_2008-07-14_13-09-50 ']);
            fnMeasBkgr = cellstr(['C1G200_he0_ve0_hs0_vs0_2008-07-14_13-08-39';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-08-39';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-09-22';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-09-22';
                                  'C1G200_he0_ve0_hs0_vs0_2008-07-14_13-09-22']);
        end
    %elseif (gap >=240)
    elseif (gap >= 0.5*(200+240))
        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['C1G240_he-10_ve0_hs0_vs0_2008-07-14_13-11-19';
                                  'C1G240_he-5_ve0_hs0_vs0_2008-07-14_13-11-32 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-11-46  ';
                                  'C1G240_he5_ve0_hs0_vs0_2008-07-14_13-12-01  ';
                                  'C1G240_he10_ve0_hs0_vs0_2008-07-14_13-12-14 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-07-14_13-11-04';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-11-04';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-11-46';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-11-46';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-11-46']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['C1G240_he0_ve-10_hs0_vs0_2008-07-14_13-12-45';
                                  'C1G240_he0_ve-5_hs0_vs0_2008-07-14_13-13-00 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-13-13  ';
                                  'C1G240_he0_ve5_hs0_vs0_2008-07-14_13-13-27  ';
                                  'C1G240_he0_ve10_hs0_vs0_2008-07-14_13-13-40 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-07-14_13-12-30';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-12-30';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-13-13';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-13-13';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-13-13']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['C1G240_he0_ve0_hs-10_vs0_2008-07-14_13-14-10';
                                  'C1G240_he0_ve0_hs-5_vs0_2008-07-14_13-14-24 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-14-39  ';
                                  'C1G240_he0_ve0_hs5_vs0_2008-07-14_13-14-53  ';
                                  'C1G240_he0_ve0_hs10_vs0_2008-07-14_13-15-08 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-07-14_13-13-55';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-13-55';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-14-39';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-14-39';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-14-39']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['C1G240_he0_ve0_hs0_vs-10_2008-07-14_13-15-38';
                                  'C1G240_he0_ve0_hs0_vs-5_2008-07-14_13-15-53 ';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-16-07  ';
                                  'C1G240_he0_ve0_hs0_vs5_2008-07-14_13-16-21  ';
                                  'C1G240_he0_ve0_hs0_vs10_2008-07-14_13-16-35 ']);
            fnMeasBkgr = cellstr(['C1G240_he0_ve0_hs0_vs0_2008-07-14_13-15-24';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-15-24';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-16-07';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-16-07';
                                  'C1G240_he0_ve0_hs0_vs0_2008-07-14_13-16-07']);
        end
    end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU44_SEXTANTS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(idName, 'HU44_SEXTANTS')
    vCurVals = [-10, -5, 0, 5, 10];

    if(gap < 0.5*(15.5+ 18))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G155_he-10_ve0_hs0_vs0_2014-03-10_03-23-48.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he-5_ve0_hs0_vs0_2014-03-10_03-24-05.mat ';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-24-21.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G155_he5_ve0_hs0_vs0_2014-03-10_03-24-38.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G155_he10_ve0_hs0_vs0_2014-03-10_03-24-55.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-23-30.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-23-30.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-24-21.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-24-21.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-24-21.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G155_he0_ve-10_hs0_vs0_2014-03-10_03-25-32.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve-5_hs0_vs0_2014-03-10_03-25-49.mat ';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-26-05.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve5_hs0_vs0_2014-03-10_03-26-23.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve10_hs0_vs0_2014-03-10_03-26-40.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-25-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-25-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-26-05.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-26-05.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-26-05.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs-10_vs0_2014-03-10_03-27-17.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs-5_vs0_2014-03-10_03-27-35.mat ';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-27-52.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs5_vs0_2014-03-10_03-28-10.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs10_vs0_2014-03-10_03-28-28.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-26-59.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-26-59.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-27-52.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-27-52.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-27-52.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs-10_2014-03-10_03-29-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs-5_2014-03-10_03-29-20.mat ';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-29-38.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs5_2014-03-10_03-29-55.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs10_2014-03-10_03-30-13.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-28-45.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-28-45.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-29-38.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-29-38.mat';
                                  'Efficiency_HU44_SEXTANTS_G155_he0_ve0_hs0_vs0_2014-03-10_03-29-38.mat']);
        end
    elseif(gap < 0.5*(18+ 20))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G180_he-10_ve0_hs0_vs0_2014-03-10_03-30-59.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he-5_ve0_hs0_vs0_2014-03-10_03-31-17.mat ';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-31-35.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G180_he5_ve0_hs0_vs0_2014-03-10_03-31-51.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G180_he10_ve0_hs0_vs0_2014-03-10_03-32-08.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-30-41.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-30-41.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-31-35.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-31-35.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-31-35.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G180_he0_ve-10_hs0_vs0_2014-03-10_03-32-43.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve-5_hs0_vs0_2014-03-10_03-33-00.mat ';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-33-18.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve5_hs0_vs0_2014-03-10_03-33-35.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve10_hs0_vs0_2014-03-10_03-33-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-32-25.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-32-25.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-33-18.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-33-18.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-33-18.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs-10_vs0_2014-03-10_03-34-27.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs-5_vs0_2014-03-10_03-34-45.mat ';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-35-03.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs5_vs0_2014-03-10_03-35-20.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs10_vs0_2014-03-10_03-35-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-34-10.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-34-10.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-35-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-35-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-35-03.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs-10_2014-03-10_03-36-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs-5_2014-03-10_03-36-30.mat ';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-36-48.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs5_2014-03-10_03-37-06.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs10_2014-03-10_03-37-23.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-35-55.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-35-55.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-36-48.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-36-48.mat';
                                  'Efficiency_HU44_SEXTANTS_G180_he0_ve0_hs0_vs0_2014-03-10_03-36-48.mat']);
        end
    elseif(gap < 0.5*(20+ 22.5))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G200_he-10_ve0_hs0_vs0_2014-03-10_03-38-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he-5_ve0_hs0_vs0_2014-03-10_03-38-23.mat ';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-38-40.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G200_he5_ve0_hs0_vs0_2014-03-10_03-38-57.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G200_he10_ve0_hs0_vs0_2014-03-10_03-39-14.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-37-48.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-37-48.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-38-40.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-38-40.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-38-40.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G200_he0_ve-10_hs0_vs0_2014-03-10_03-39-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve-5_hs0_vs0_2014-03-10_03-40-06.mat ';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-40-24.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve5_hs0_vs0_2014-03-10_03-40-40.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve10_hs0_vs0_2014-03-10_03-40-58.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-39-32.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-39-32.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-40-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-40-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-40-24.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs-10_vs0_2014-03-10_03-41-34.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs-5_vs0_2014-03-10_03-41-51.mat ';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-42-09.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs5_vs0_2014-03-10_03-42-27.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs10_vs0_2014-03-10_03-42-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-41-15.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-41-15.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-42-09.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-42-09.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-42-09.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs-10_2014-03-10_03-43-21.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs-5_2014-03-10_03-43-38.mat ';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-43-55.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs5_2014-03-10_03-44-12.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs10_2014-03-10_03-44-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-43-02.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-43-02.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-43-55.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-43-55.mat';
                                  'Efficiency_HU44_SEXTANTS_G200_he0_ve0_hs0_vs0_2014-03-10_03-43-55.mat']);
        end
    elseif(gap < 0.5*(22.5+ 25))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G225_he-10_ve0_hs0_vs0_2014-03-10_03-45-12.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he-5_ve0_hs0_vs0_2014-03-10_03-45-28.mat ';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-45-46.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G225_he5_ve0_hs0_vs0_2014-03-10_03-46-02.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G225_he10_ve0_hs0_vs0_2014-03-10_03-46-21.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-44-53.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-44-53.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-45-46.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-45-46.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-45-46.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G225_he0_ve-10_hs0_vs0_2014-03-10_03-46-58.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve-5_hs0_vs0_2014-03-10_03-47-15.mat ';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-47-32.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve5_hs0_vs0_2014-03-10_03-47-49.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve10_hs0_vs0_2014-03-10_03-48-07.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-46-39.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-46-39.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-47-32.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-47-32.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-47-32.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs-10_vs0_2014-03-10_03-48-42.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs-5_vs0_2014-03-10_03-48-58.mat ';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-49-16.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs5_vs0_2014-03-10_03-49-32.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs10_vs0_2014-03-10_03-49-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-48-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-48-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-49-16.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-49-16.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-49-16.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs-10_2014-03-10_03-50-26.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs-5_2014-03-10_03-50-43.mat ';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-51-00.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs5_2014-03-10_03-51-18.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs10_2014-03-10_03-51-35.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-50-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-50-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-51-00.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-51-00.mat';
                                  'Efficiency_HU44_SEXTANTS_G225_he0_ve0_hs0_vs0_2014-03-10_03-51-00.mat']);
        end
    elseif(gap < 0.5*(25+ 27.5))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G250_he-10_ve0_hs0_vs0_2014-03-10_03-52-17.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he-5_ve0_hs0_vs0_2014-03-10_03-52-33.mat ';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-52-49.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G250_he5_ve0_hs0_vs0_2014-03-10_03-53-07.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G250_he10_ve0_hs0_vs0_2014-03-10_03-53-24.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-51-59.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-51-59.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-52-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-52-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-52-49.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G250_he0_ve-10_hs0_vs0_2014-03-10_03-54-00.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve-5_hs0_vs0_2014-03-10_03-54-16.mat ';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-54-34.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve5_hs0_vs0_2014-03-10_03-54-51.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve10_hs0_vs0_2014-03-10_03-55-08.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-53-42.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-53-42.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-54-34.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-54-34.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-54-34.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs-10_vs0_2014-03-10_03-55-45.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs-5_vs0_2014-03-10_03-56-02.mat ';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-56-18.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs5_vs0_2014-03-10_03-56-36.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs10_vs0_2014-03-10_03-56-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-55-26.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-55-26.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-56-18.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-56-18.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-56-18.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs-10_2014-03-10_03-57-29.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs-5_2014-03-10_03-57-47.mat ';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-58-04.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs5_2014-03-10_03-58-22.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs10_2014-03-10_03-58-40.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-57-12.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-57-12.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-58-04.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-58-04.mat';
                                  'Efficiency_HU44_SEXTANTS_G250_he0_ve0_hs0_vs0_2014-03-10_03-58-04.mat']);
        end
    elseif(gap < 0.5*(27.5+ 30))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G275_he-10_ve0_hs0_vs0_2014-03-10_03-59-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he-5_ve0_hs0_vs0_2014-03-10_03-59-40.mat ';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_03-59-58.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G275_he5_ve0_hs0_vs0_2014-03-10_04-00-15.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G275_he10_ve0_hs0_vs0_2014-03-10_04-00-32.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_03-59-06.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_03-59-06.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_03-59-58.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_03-59-58.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_03-59-58.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G275_he0_ve-10_hs0_vs0_2014-03-10_04-01-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve-5_hs0_vs0_2014-03-10_04-01-24.mat ';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-01-42.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve5_hs0_vs0_2014-03-10_04-01-58.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve10_hs0_vs0_2014-03-10_04-02-14.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-00-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-00-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-01-42.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-01-42.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-01-42.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs-10_vs0_2014-03-10_04-02-51.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs-5_vs0_2014-03-10_04-03-08.mat ';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-03-25.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs5_vs0_2014-03-10_04-03-43.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs10_vs0_2014-03-10_04-04-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-02-33.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-02-33.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-03-25.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-03-25.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-03-25.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs-10_2014-03-10_04-04-37.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs-5_2014-03-10_04-04-53.mat ';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-05-11.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs5_2014-03-10_04-05-28.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs10_2014-03-10_04-05-46.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-04-19.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-04-19.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-05-11.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-05-11.mat';
                                  'Efficiency_HU44_SEXTANTS_G275_he0_ve0_hs0_vs0_2014-03-10_04-05-11.mat']);
        end
    elseif(gap < 0.5*(30+ 35))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G300_he-10_ve0_hs0_vs0_2014-03-10_04-06-28.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he-5_ve0_hs0_vs0_2014-03-10_04-06-46.mat ';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-07-02.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G300_he5_ve0_hs0_vs0_2014-03-10_04-07-18.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G300_he10_ve0_hs0_vs0_2014-03-10_04-07-35.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-06-11.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-06-11.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-07-02.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-07-02.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-07-02.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G300_he0_ve-10_hs0_vs0_2014-03-10_04-08-11.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve-5_hs0_vs0_2014-03-10_04-08-28.mat ';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-08-45.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve5_hs0_vs0_2014-03-10_04-09-02.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve10_hs0_vs0_2014-03-10_04-09-18.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-07-52.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-07-52.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-08-45.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-08-45.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-08-45.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs-10_vs0_2014-03-10_04-09-53.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs-5_vs0_2014-03-10_04-10-11.mat ';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-10-27.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs5_vs0_2014-03-10_04-10-45.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs10_vs0_2014-03-10_04-11-02.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-09-36.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-09-36.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-10-27.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-10-27.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-10-27.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs-10_2014-03-10_04-11-39.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs-5_2014-03-10_04-11-56.mat ';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-12-13.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs5_2014-03-10_04-12-31.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs10_2014-03-10_04-12-47.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-11-20.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-11-20.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-12-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-12-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G300_he0_ve0_hs0_vs0_2014-03-10_04-12-13.mat']);
        end
    elseif(gap < 0.5*(35+ 40))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G350_he-10_ve0_hs0_vs0_2014-03-10_04-13-30.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he-5_ve0_hs0_vs0_2014-03-10_04-13-46.mat ';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-14-03.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G350_he5_ve0_hs0_vs0_2014-03-10_04-14-20.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G350_he10_ve0_hs0_vs0_2014-03-10_04-14-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-13-12.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-13-12.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-14-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-14-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-14-03.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G350_he0_ve-10_hs0_vs0_2014-03-10_04-15-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve-5_hs0_vs0_2014-03-10_04-15-29.mat ';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-15-46.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve5_hs0_vs0_2014-03-10_04-16-02.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve10_hs0_vs0_2014-03-10_04-16-20.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-14-56.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-14-56.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-15-46.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-15-46.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-15-46.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs-10_vs0_2014-03-10_04-16-56.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs-5_vs0_2014-03-10_04-17-13.mat ';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-17-30.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs5_vs0_2014-03-10_04-17-48.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs10_vs0_2014-03-10_04-18-04.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-16-38.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-16-38.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-17-30.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-17-30.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-17-30.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs-10_2014-03-10_04-18-42.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs-5_2014-03-10_04-18-58.mat ';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-19-16.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs5_2014-03-10_04-19-34.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs10_2014-03-10_04-19-51.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-18-23.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-18-23.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-19-16.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-19-16.mat';
                                  'Efficiency_HU44_SEXTANTS_G350_he0_ve0_hs0_vs0_2014-03-10_04-19-16.mat']);
        end
    elseif(gap < 0.5*(40+ 50))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G400_he-10_ve0_hs0_vs0_2014-03-10_04-20-33.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he-5_ve0_hs0_vs0_2014-03-10_04-20-50.mat ';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-21-06.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G400_he5_ve0_hs0_vs0_2014-03-10_04-21-23.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G400_he10_ve0_hs0_vs0_2014-03-10_04-21-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-20-16.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-20-16.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-21-06.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-21-06.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-21-06.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G400_he0_ve-10_hs0_vs0_2014-03-10_04-22-15.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve-5_hs0_vs0_2014-03-10_04-22-33.mat ';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-22-49.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve5_hs0_vs0_2014-03-10_04-23-06.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve10_hs0_vs0_2014-03-10_04-23-23.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-21-57.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-21-57.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-22-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-22-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-22-49.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs-10_vs0_2014-03-10_04-24-00.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs-5_vs0_2014-03-10_04-24-17.mat ';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-24-34.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs5_vs0_2014-03-10_04-24-50.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs10_vs0_2014-03-10_04-25-08.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-23-41.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-23-41.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-24-34.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-24-34.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-24-34.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs-10_2014-03-10_04-25-45.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs-5_2014-03-10_04-26-02.mat ';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-26-19.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs5_2014-03-10_04-26-36.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs10_2014-03-10_04-26-54.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-25-26.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-25-26.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-26-19.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-26-19.mat';
                                  'Efficiency_HU44_SEXTANTS_G400_he0_ve0_hs0_vs0_2014-03-10_04-26-19.mat']);
        end
    elseif(gap < 0.5*(50+ 60))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G500_he-10_ve0_hs0_vs0_2014-03-10_04-27-38.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he-5_ve0_hs0_vs0_2014-03-10_04-27-54.mat ';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-28-11.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G500_he5_ve0_hs0_vs0_2014-03-10_04-28-28.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G500_he10_ve0_hs0_vs0_2014-03-10_04-28-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-27-20.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-27-20.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-28-11.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-28-11.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-28-11.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G500_he0_ve-10_hs0_vs0_2014-03-10_04-29-20.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve-5_hs0_vs0_2014-03-10_04-29-37.mat ';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-29-53.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve5_hs0_vs0_2014-03-10_04-30-11.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve10_hs0_vs0_2014-03-10_04-30-29.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-29-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-29-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-29-53.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-29-53.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-29-53.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs-10_vs0_2014-03-10_04-31-04.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs-5_vs0_2014-03-10_04-31-22.mat ';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-31-40.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs5_vs0_2014-03-10_04-31-56.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs10_vs0_2014-03-10_04-32-13.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-30-46.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-30-46.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-31-40.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-31-40.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-31-40.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs-10_2014-03-10_04-32-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs-5_2014-03-10_04-33-06.mat ';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-33-24.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs5_2014-03-10_04-33-42.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs10_2014-03-10_04-34-00.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-32-31.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-32-31.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-33-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-33-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G500_he0_ve0_hs0_vs0_2014-03-10_04-33-24.mat']);
        end
    elseif(gap < 0.5*(60+ 70))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G600_he-10_ve0_hs0_vs0_2014-03-10_04-34-45.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he-5_ve0_hs0_vs0_2014-03-10_04-35-01.mat ';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-35-18.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G600_he5_ve0_hs0_vs0_2014-03-10_04-35-34.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G600_he10_ve0_hs0_vs0_2014-03-10_04-35-51.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-34-27.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-34-27.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-35-18.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-35-18.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-35-18.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G600_he0_ve-10_hs0_vs0_2014-03-10_04-36-27.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve-5_hs0_vs0_2014-03-10_04-36-45.mat ';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-37-02.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve5_hs0_vs0_2014-03-10_04-37-19.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve10_hs0_vs0_2014-03-10_04-37-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-36-10.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-36-10.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-37-02.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-37-02.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-37-02.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs-10_vs0_2014-03-10_04-38-12.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs-5_vs0_2014-03-10_04-38-29.mat ';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-38-46.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs5_vs0_2014-03-10_04-39-04.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs10_vs0_2014-03-10_04-39-21.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-37-54.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-37-54.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-38-46.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-38-46.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-38-46.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs-10_2014-03-10_04-39-56.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs-5_2014-03-10_04-40-14.mat ';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-40-31.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs5_2014-03-10_04-40-49.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs10_2014-03-10_04-41-07.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-39-39.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-39-39.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-40-31.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-40-31.mat';
                                  'Efficiency_HU44_SEXTANTS_G600_he0_ve0_hs0_vs0_2014-03-10_04-40-31.mat']);
        end
    elseif(gap < 0.5*(70+ 80))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G700_he-10_ve0_hs0_vs0_2014-03-10_04-41-52.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he-5_ve0_hs0_vs0_2014-03-10_04-42-09.mat ';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-42-27.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G700_he5_ve0_hs0_vs0_2014-03-10_04-42-44.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G700_he10_ve0_hs0_vs0_2014-03-10_04-43-00.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-41-34.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-41-34.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-42-27.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-42-27.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-42-27.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G700_he0_ve-10_hs0_vs0_2014-03-10_04-43-36.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve-5_hs0_vs0_2014-03-10_04-43-53.mat ';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-44-09.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve5_hs0_vs0_2014-03-10_04-44-26.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve10_hs0_vs0_2014-03-10_04-44-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-43-19.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-43-19.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-44-09.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-44-09.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-44-09.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs-10_vs0_2014-03-10_04-45-18.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs-5_vs0_2014-03-10_04-45-35.mat ';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-45-53.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs5_vs0_2014-03-10_04-46-10.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs10_vs0_2014-03-10_04-46-27.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-45-00.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-45-00.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-45-53.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-45-53.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-45-53.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs-10_2014-03-10_04-47-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs-5_2014-03-10_04-47-20.mat ';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-47-38.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs5_2014-03-10_04-47-56.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs10_2014-03-10_04-48-13.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-46-44.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-46-44.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-47-38.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-47-38.mat';
                                  'Efficiency_HU44_SEXTANTS_G700_he0_ve0_hs0_vs0_2014-03-10_04-47-38.mat']);
        end
    elseif(gap < 0.5*(80+ 90))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G800_he-10_ve0_hs0_vs0_2014-03-10_04-48-58.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he-5_ve0_hs0_vs0_2014-03-10_04-49-15.mat ';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-49-31.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G800_he5_ve0_hs0_vs0_2014-03-10_04-49-48.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G800_he10_ve0_hs0_vs0_2014-03-10_04-50-05.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-48-41.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-48-41.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-49-31.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-49-31.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-49-31.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G800_he0_ve-10_hs0_vs0_2014-03-10_04-50-41.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve-5_hs0_vs0_2014-03-10_04-50-58.mat ';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-51-15.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve5_hs0_vs0_2014-03-10_04-51-33.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve10_hs0_vs0_2014-03-10_04-51-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-50-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-50-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-51-15.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-51-15.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-51-15.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs-10_vs0_2014-03-10_04-52-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs-5_vs0_2014-03-10_04-52-42.mat ';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-53-00.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs5_vs0_2014-03-10_04-53-17.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs10_vs0_2014-03-10_04-53-34.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-52-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-52-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-53-00.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-53-00.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-53-00.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs-10_2014-03-10_04-54-09.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs-5_2014-03-10_04-54-27.mat ';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-54-44.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs5_2014-03-10_04-55-02.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs10_2014-03-10_04-55-20.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-53-52.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-53-52.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-54-44.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-54-44.mat';
                                  'Efficiency_HU44_SEXTANTS_G800_he0_ve0_hs0_vs0_2014-03-10_04-54-44.mat']);
        end
    elseif(gap < 0.5*(90+ 100))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G900_he-10_ve0_hs0_vs0_2014-03-10_04-56-06.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he-5_ve0_hs0_vs0_2014-03-10_04-56-23.mat ';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-56-39.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G900_he5_ve0_hs0_vs0_2014-03-10_04-56-56.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G900_he10_ve0_hs0_vs0_2014-03-10_04-57-13.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-55-47.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-55-47.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-56-39.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-56-39.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-56-39.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G900_he0_ve-10_hs0_vs0_2014-03-10_04-57-48.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve-5_hs0_vs0_2014-03-10_04-58-05.mat ';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-58-22.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve5_hs0_vs0_2014-03-10_04-58-39.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve10_hs0_vs0_2014-03-10_04-58-55.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-57-31.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-57-31.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-58-22.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-58-22.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-58-22.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs-10_vs0_2014-03-10_04-59-30.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs-5_vs0_2014-03-10_04-59-48.mat ';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_05-00-04.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs5_vs0_2014-03-10_05-00-22.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs10_vs0_2014-03-10_05-00-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-59-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_04-59-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_05-00-04.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_05-00-04.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_05-00-04.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs-10_2014-03-10_05-01-15.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs-5_2014-03-10_05-01-33.mat ';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_05-01-49.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs5_2014-03-10_05-02-06.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs10_2014-03-10_05-02-23.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_05-00-57.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_05-00-57.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_05-01-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_05-01-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G900_he0_ve0_hs0_vs0_2014-03-10_05-01-49.mat']);
        end
    elseif(gap < 0.5*(100+ 110))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1000_he-10_ve0_hs0_vs0_2014-03-10_05-03-09.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he-5_ve0_hs0_vs0_2014-03-10_05-03-25.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-03-42.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he5_ve0_hs0_vs0_2014-03-10_05-03-59.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he10_ve0_hs0_vs0_2014-03-10_05-04-15.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-02-50.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-02-50.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-03-42.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-03-42.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-03-42.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1000_he0_ve-10_hs0_vs0_2014-03-10_05-04-50.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve-5_hs0_vs0_2014-03-10_05-05-08.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-05-24.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve5_hs0_vs0_2014-03-10_05-05-41.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve10_hs0_vs0_2014-03-10_05-05-58.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-04-33.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-04-33.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-05-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-05-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-05-24.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs-10_vs0_2014-03-10_05-06-34.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs-5_vs0_2014-03-10_05-06-52.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-07-09.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs5_vs0_2014-03-10_05-07-27.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs10_vs0_2014-03-10_05-07-45.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-06-16.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-06-16.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-07-09.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-07-09.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-07-09.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs-10_2014-03-10_05-08-22.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs-5_2014-03-10_05-08-39.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-08-56.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs5_2014-03-10_05-09-14.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs10_2014-03-10_05-09-32.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-08-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-08-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-08-56.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-08-56.mat';
                                  'Efficiency_HU44_SEXTANTS_G1000_he0_ve0_hs0_vs0_2014-03-10_05-08-56.mat']);
        end
    elseif(gap < 0.5*(110+ 130))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1100_he-10_ve0_hs0_vs0_2014-03-10_05-10-17.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he-5_ve0_hs0_vs0_2014-03-10_05-10-34.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-10-52.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he5_ve0_hs0_vs0_2014-03-10_05-11-08.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he10_ve0_hs0_vs0_2014-03-10_05-11-25.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-09-59.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-09-59.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-10-52.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-10-52.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-10-52.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1100_he0_ve-10_hs0_vs0_2014-03-10_05-12-00.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve-5_hs0_vs0_2014-03-10_05-12-18.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-12-35.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve5_hs0_vs0_2014-03-10_05-12-51.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve10_hs0_vs0_2014-03-10_05-13-09.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-11-43.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-11-43.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-12-35.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-12-35.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-12-35.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs-10_vs0_2014-03-10_05-13-45.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs-5_vs0_2014-03-10_05-14-03.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-14-20.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs5_vs0_2014-03-10_05-14-38.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs10_vs0_2014-03-10_05-14-54.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-13-26.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-13-26.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-14-20.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-14-20.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-14-20.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs-10_2014-03-10_05-15-32.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs-5_2014-03-10_05-15-49.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-16-07.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs5_2014-03-10_05-16-24.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs10_2014-03-10_05-16-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-15-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-15-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-16-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-16-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G1100_he0_ve0_hs0_vs0_2014-03-10_05-16-07.mat']);
        end
    elseif(gap < 0.5*(130+ 150))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1300_he-10_ve0_hs0_vs0_2014-03-10_05-17-30.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he-5_ve0_hs0_vs0_2014-03-10_05-17-47.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-18-04.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he5_ve0_hs0_vs0_2014-03-10_05-18-21.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he10_ve0_hs0_vs0_2014-03-10_05-18-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-17-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-17-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-18-04.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-18-04.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-18-04.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1300_he0_ve-10_hs0_vs0_2014-03-10_05-19-14.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve-5_hs0_vs0_2014-03-10_05-19-31.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-19-48.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve5_hs0_vs0_2014-03-10_05-20-05.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve10_hs0_vs0_2014-03-10_05-20-21.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-18-56.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-18-56.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-19-48.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-19-48.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-19-48.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs-10_vs0_2014-03-10_05-20-57.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs-5_vs0_2014-03-10_05-21-15.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-21-32.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs5_vs0_2014-03-10_05-21-49.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs10_vs0_2014-03-10_05-22-06.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-20-39.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-20-39.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-21-32.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-21-32.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-21-32.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs-10_2014-03-10_05-22-44.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs-5_2014-03-10_05-23-00.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-23-18.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs5_2014-03-10_05-23-34.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs10_2014-03-10_05-23-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-22-25.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-22-25.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-23-18.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-23-18.mat';
                                  'Efficiency_HU44_SEXTANTS_G1300_he0_ve0_hs0_vs0_2014-03-10_05-23-18.mat']);
        end
    elseif(gap < 0.5*(150+ 175))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1500_he-10_ve0_hs0_vs0_2014-03-10_05-24-41.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he-5_ve0_hs0_vs0_2014-03-10_05-24-57.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-25-14.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he5_ve0_hs0_vs0_2014-03-10_05-25-31.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he10_ve0_hs0_vs0_2014-03-10_05-25-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-24-23.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-24-23.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-25-14.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-25-14.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-25-14.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1500_he0_ve-10_hs0_vs0_2014-03-10_05-26-24.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve-5_hs0_vs0_2014-03-10_05-26-41.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-26-58.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve5_hs0_vs0_2014-03-10_05-27-15.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve10_hs0_vs0_2014-03-10_05-27-32.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-26-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-26-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-26-58.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-26-58.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-26-58.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs-10_vs0_2014-03-10_05-28-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs-5_vs0_2014-03-10_05-28-25.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-28-42.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs5_vs0_2014-03-10_05-29-00.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs10_vs0_2014-03-10_05-29-18.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-27-50.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-27-50.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-28-42.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-28-42.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-28-42.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs-10_2014-03-10_05-29-54.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs-5_2014-03-10_05-30-12.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-30-29.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs5_2014-03-10_05-30-47.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs10_2014-03-10_05-31-04.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-29-36.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-29-36.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-30-29.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-30-29.mat';
                                  'Efficiency_HU44_SEXTANTS_G1500_he0_ve0_hs0_vs0_2014-03-10_05-30-29.mat']);
        end
    elseif(gap < 0.5*(175+ 200))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1750_he-10_ve0_hs0_vs0_2014-03-10_05-31-55.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he-5_ve0_hs0_vs0_2014-03-10_05-32-11.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-32-29.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he5_ve0_hs0_vs0_2014-03-10_05-32-45.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he10_ve0_hs0_vs0_2014-03-10_05-33-02.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-31-36.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-31-36.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-32-29.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-32-29.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-32-29.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1750_he0_ve-10_hs0_vs0_2014-03-10_05-33-38.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve-5_hs0_vs0_2014-03-10_05-33-56.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-34-13.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve5_hs0_vs0_2014-03-10_05-34-30.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve10_hs0_vs0_2014-03-10_05-34-47.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-33-20.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-33-20.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-34-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-34-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-34-13.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs-10_vs0_2014-03-10_05-35-23.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs-5_vs0_2014-03-10_05-35-40.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-35-58.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs5_vs0_2014-03-10_05-36-16.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs10_vs0_2014-03-10_05-36-32.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-35-06.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-35-06.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-35-58.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-35-58.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-35-58.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs-10_2014-03-10_05-37-08.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs-5_2014-03-10_05-37-26.mat ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-37-43.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs5_2014-03-10_05-38-01.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs10_2014-03-10_05-38-18.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-36-51.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-36-51.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-37-43.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-37-43.mat';
                                  'Efficiency_HU44_SEXTANTS_G1750_he0_ve0_hs0_vs0_2014-03-10_05-37-43.mat']);
        end
    elseif(gap < 0.5*(200+ 225))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2000_he-10_ve0_hs0_vs0_2014-03-10_05-39-07.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he-5_ve0_hs0_vs0_2014-03-10_05-39-24.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-39-40.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he5_ve0_hs0_vs0_2014-03-10_05-39-58.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he10_ve0_hs0_vs0_2014-03-10_05-40-14.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-38-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-38-49.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-39-40.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-39-40.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-39-40.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2000_he0_ve-10_hs0_vs0_2014-03-10_05-40-52.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve-5_hs0_vs0_2014-03-10_05-41-09.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-41-25.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve5_hs0_vs0_2014-03-10_05-41-42.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve10_hs0_vs0_2014-03-10_05-41-59.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-40-32.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-40-32.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-41-25.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-41-25.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-41-25.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs-10_vs0_2014-03-10_05-42-35.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs-5_vs0_2014-03-10_05-42-53.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-43-10.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs5_vs0_2014-03-10_05-43-28.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs10_vs0_2014-03-10_05-43-45.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-42-16.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-42-16.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-43-10.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-43-10.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-43-10.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs-10_2014-03-10_05-44-21.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs-5_2014-03-10_05-44-39.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-44-56.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs5_2014-03-10_05-45-14.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs10_2014-03-10_05-45-31.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-44-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-44-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-44-56.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-44-56.mat';
                                  'Efficiency_HU44_SEXTANTS_G2000_he0_ve0_hs0_vs0_2014-03-10_05-44-56.mat']);
        end
    elseif(gap < 0.5*(225+ 240))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2250_he-10_ve0_hs0_vs0_2014-03-10_05-46-21.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he-5_ve0_hs0_vs0_2014-03-10_05-46-37.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-46-54.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he5_ve0_hs0_vs0_2014-03-10_05-47-12.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he10_ve0_hs0_vs0_2014-03-10_05-47-29.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-46-02.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-46-02.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-46-54.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-46-54.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-46-54.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2250_he0_ve-10_hs0_vs0_2014-03-10_05-48-06.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve-5_hs0_vs0_2014-03-10_05-48-22.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-48-39.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve5_hs0_vs0_2014-03-10_05-48-56.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve10_hs0_vs0_2014-03-10_05-49-13.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-47-48.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-47-48.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-48-39.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-48-39.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-48-39.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs-10_vs0_2014-03-10_05-49-50.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs-5_vs0_2014-03-10_05-50-07.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-50-23.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs5_vs0_2014-03-10_05-50-41.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs10_vs0_2014-03-10_05-50-59.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-49-31.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-49-31.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-50-23.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-50-23.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-50-23.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs-10_2014-03-10_05-51-36.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs-5_2014-03-10_05-51-53.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-52-10.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs5_2014-03-10_05-52-28.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs10_2014-03-10_05-52-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-51-17.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-51-17.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-52-10.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-52-10.mat';
                                  'Efficiency_HU44_SEXTANTS_G2250_he0_ve0_hs0_vs0_2014-03-10_05-52-10.mat']);
        end
    else	% Gap > 240

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2400_he-10_ve0_hs0_vs0_2014-03-10_05-53-30.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he-5_ve0_hs0_vs0_2014-03-10_05-53-46.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-54-03.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he5_ve0_hs0_vs0_2014-03-10_05-54-20.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he10_ve0_hs0_vs0_2014-03-10_05-54-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-53-11.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-53-11.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-54-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-54-03.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-54-03.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2400_he0_ve-10_hs0_vs0_2014-03-10_05-55-13.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve-5_hs0_vs0_2014-03-10_05-55-31.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-55-47.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve5_hs0_vs0_2014-03-10_05-56-05.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve10_hs0_vs0_2014-03-10_05-56-22.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-54-55.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-54-55.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-55-47.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-55-47.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-55-47.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs-10_vs0_2014-03-10_05-57-00.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs-5_vs0_2014-03-10_05-57-16.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-57-34.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs5_vs0_2014-03-10_05-57-52.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs10_vs0_2014-03-10_05-58-08.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-56-41.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-56-41.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-57-34.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-57-34.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-57-34.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs-10_2014-03-10_05-58-44.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs-5_2014-03-10_05-59-02.mat ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-59-20.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs5_2014-03-10_05-59-37.mat  ';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs10_2014-03-10_05-59-54.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-58-27.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-58-27.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-59-20.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-59-20.mat';
                                  'Efficiency_HU44_SEXTANTS_G2400_he0_ve0_hs0_vs0_2014-03-10_05-59-20.mat']);
        end

    end	% End of HU44_SEXTANTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU36_SIRIUS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(idName, 'HU36_SIRIUS')
    vCurVals = [-10, -5, 0, 5, 10];

    if(gap < 0.5*(12+ 12.5))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G120_he-10_ve0_hs0_vs0_2013-06-18_00-21-09.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he-5_ve0_hs0_vs0_2013-06-18_00-21-28.mat ';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-21-47.mat  ';
                                  'Efficiency_HU36_SIRIUS_G120_he5_ve0_hs0_vs0_2013-06-18_00-22-07.mat  ';
                                  'Efficiency_HU36_SIRIUS_G120_he10_ve0_hs0_vs0_2013-06-18_00-22-26.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-20-50.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-20-50.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-21-47.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-21-47.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-21-47.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G120_he0_ve-10_hs0_vs0_2013-06-18_00-23-04.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve-5_hs0_vs0_2013-06-18_00-23-23.mat ';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-23-43.mat  ';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve5_hs0_vs0_2013-06-18_00-24-02.mat  ';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve10_hs0_vs0_2013-06-18_00-24-21.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-22-45.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-22-45.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-23-43.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-23-43.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-23-43.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G120_he0_ve0_hs-10_vs0_2013-06-18_00-25-00.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs-5_vs0_2013-06-18_00-25-19.mat ';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-25-38.mat  ';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs5_vs0_2013-06-18_00-25-57.mat  ';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs10_vs0_2013-06-18_00-26-16.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-24-40.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-24-40.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-25-38.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-25-38.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-25-38.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs-10_2013-06-18_00-26-55.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs-5_2013-06-18_00-27-14.mat ';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-27-33.mat  ';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs5_2013-06-18_00-27-52.mat  ';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs10_2013-06-18_00-28-11.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-26-35.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-26-35.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-27-33.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-27-33.mat';
                                  'Efficiency_HU36_SIRIUS_G120_he0_ve0_hs0_vs0_2013-06-18_00-27-33.mat']);
        end
    elseif(gap < 0.5*(12.5+ 13))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G125_he-10_ve0_hs0_vs0_2013-06-18_00-29-02.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he-5_ve0_hs0_vs0_2013-06-18_00-29-21.mat ';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-29-40.mat  ';
                                  'Efficiency_HU36_SIRIUS_G125_he5_ve0_hs0_vs0_2013-06-18_00-30-00.mat  ';
                                  'Efficiency_HU36_SIRIUS_G125_he10_ve0_hs0_vs0_2013-06-18_00-30-19.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-28-43.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-28-43.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-29-40.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-29-40.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-29-40.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G125_he0_ve-10_hs0_vs0_2013-06-18_00-30-57.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve-5_hs0_vs0_2013-06-18_00-31-16.mat ';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-31-36.mat  ';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve5_hs0_vs0_2013-06-18_00-31-55.mat  ';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve10_hs0_vs0_2013-06-18_00-32-14.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-30-38.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-30-38.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-31-36.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-31-36.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-31-36.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G125_he0_ve0_hs-10_vs0_2013-06-18_00-32-52.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs-5_vs0_2013-06-18_00-33-12.mat ';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-33-31.mat  ';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs5_vs0_2013-06-18_00-33-50.mat  ';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs10_vs0_2013-06-18_00-34-09.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-32-33.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-32-33.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-33-31.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-33-31.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-33-31.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs-10_2013-06-18_00-34-48.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs-5_2013-06-18_00-35-07.mat ';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-35-26.mat  ';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs5_2013-06-18_00-35-45.mat  ';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs10_2013-06-18_00-36-05.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-34-29.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-34-29.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-35-26.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-35-26.mat';
                                  'Efficiency_HU36_SIRIUS_G125_he0_ve0_hs0_vs0_2013-06-18_00-35-26.mat']);
        end
    elseif(gap < 0.5*(13+ 14))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G130_he-10_ve0_hs0_vs0_2013-06-18_00-36-56.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he-5_ve0_hs0_vs0_2013-06-18_00-37-15.mat ';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-37-34.mat  ';
                                  'Efficiency_HU36_SIRIUS_G130_he5_ve0_hs0_vs0_2013-06-18_00-37-53.mat  ';
                                  'Efficiency_HU36_SIRIUS_G130_he10_ve0_hs0_vs0_2013-06-18_00-38-13.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-36-36.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-36-36.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-37-34.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-37-34.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-37-34.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G130_he0_ve-10_hs0_vs0_2013-06-18_00-38-51.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve-5_hs0_vs0_2013-06-18_00-39-10.mat ';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-39-29.mat  ';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve5_hs0_vs0_2013-06-18_00-39-49.mat  ';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve10_hs0_vs0_2013-06-18_00-40-08.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-38-32.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-38-32.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-39-29.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-39-29.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-39-29.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G130_he0_ve0_hs-10_vs0_2013-06-18_00-40-46.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs-5_vs0_2013-06-18_00-41-05.mat ';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-41-25.mat  ';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs5_vs0_2013-06-18_00-41-44.mat  ';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs10_vs0_2013-06-18_00-42-03.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-40-27.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-40-27.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-41-25.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-41-25.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-41-25.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs-10_2013-06-18_00-42-41.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs-5_2013-06-18_00-43-01.mat ';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-43-20.mat  ';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs5_2013-06-18_00-43-39.mat  ';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs10_2013-06-18_00-43-58.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-42-22.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-42-22.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-43-20.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-43-20.mat';
                                  'Efficiency_HU36_SIRIUS_G130_he0_ve0_hs0_vs0_2013-06-18_00-43-20.mat']);
        end
    elseif(gap < 0.5*(14+ 16))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G140_he-10_ve0_hs0_vs0_2013-06-18_00-44-49.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he-5_ve0_hs0_vs0_2013-06-18_00-45-08.mat ';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-45-27.mat  ';
                                  'Efficiency_HU36_SIRIUS_G140_he5_ve0_hs0_vs0_2013-06-18_00-45-47.mat  ';
                                  'Efficiency_HU36_SIRIUS_G140_he10_ve0_hs0_vs0_2013-06-18_00-46-06.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-44-30.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-44-30.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-45-27.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-45-27.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-45-27.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G140_he0_ve-10_hs0_vs0_2013-06-18_00-46-44.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve-5_hs0_vs0_2013-06-18_00-47-03.mat ';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-47-22.mat  ';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve5_hs0_vs0_2013-06-18_00-47-42.mat  ';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve10_hs0_vs0_2013-06-18_00-48-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-46-25.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-46-25.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-47-22.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-47-22.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-47-22.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G140_he0_ve0_hs-10_vs0_2013-06-18_00-48-39.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs-5_vs0_2013-06-18_00-48-58.mat ';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-49-18.mat  ';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs5_vs0_2013-06-18_00-49-37.mat  ';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs10_vs0_2013-06-18_00-49-56.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-48-20.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-48-20.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-49-18.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-49-18.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-49-18.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs-10_2013-06-18_00-50-34.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs-5_2013-06-18_00-50-54.mat ';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-51-13.mat  ';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs5_2013-06-18_00-51-32.mat  ';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs10_2013-06-18_00-51-51.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-50-15.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-50-15.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-51-13.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-51-13.mat';
                                  'Efficiency_HU36_SIRIUS_G140_he0_ve0_hs0_vs0_2013-06-18_00-51-13.mat']);
        end
    elseif(gap < 0.5*(16+ 18))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G160_he-10_ve0_hs0_vs0_2013-06-18_00-52-42.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he-5_ve0_hs0_vs0_2013-06-18_00-53-01.mat ';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-53-20.mat  ';
                                  'Efficiency_HU36_SIRIUS_G160_he5_ve0_hs0_vs0_2013-06-18_00-53-39.mat  ';
                                  'Efficiency_HU36_SIRIUS_G160_he10_ve0_hs0_vs0_2013-06-18_00-53-59.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-52-23.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-52-23.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-53-20.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-53-20.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-53-20.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G160_he0_ve-10_hs0_vs0_2013-06-18_00-54-37.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve-5_hs0_vs0_2013-06-18_00-54-56.mat ';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-55-15.mat  ';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve5_hs0_vs0_2013-06-18_00-55-35.mat  ';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve10_hs0_vs0_2013-06-18_00-55-54.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-54-18.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-54-18.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-55-15.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-55-15.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-55-15.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G160_he0_ve0_hs-10_vs0_2013-06-18_00-56-32.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs-5_vs0_2013-06-18_00-56-51.mat ';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-57-11.mat  ';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs5_vs0_2013-06-18_00-57-30.mat  ';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs10_vs0_2013-06-18_00-57-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-56-13.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-56-13.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-57-11.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-57-11.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-57-11.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs-10_2013-06-18_00-58-27.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs-5_2013-06-18_00-58-47.mat ';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-59-06.mat  ';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs5_2013-06-18_00-59-25.mat  ';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs10_2013-06-18_00-59-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-58-08.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-58-08.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-59-06.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-59-06.mat';
                                  'Efficiency_HU36_SIRIUS_G160_he0_ve0_hs0_vs0_2013-06-18_00-59-06.mat']);
        end
    elseif(gap < 0.5*(18+ 20))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G180_he-10_ve0_hs0_vs0_2013-06-18_01-00-35.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he-5_ve0_hs0_vs0_2013-06-18_01-00-54.mat ';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-01-13.mat  ';
                                  'Efficiency_HU36_SIRIUS_G180_he5_ve0_hs0_vs0_2013-06-18_01-01-32.mat  ';
                                  'Efficiency_HU36_SIRIUS_G180_he10_ve0_hs0_vs0_2013-06-18_01-01-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-00-16.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-00-16.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-01-13.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-01-13.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-01-13.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G180_he0_ve-10_hs0_vs0_2013-06-18_01-02-30.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve-5_hs0_vs0_2013-06-18_01-02-49.mat ';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-03-08.mat  ';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve5_hs0_vs0_2013-06-18_01-03-28.mat  ';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve10_hs0_vs0_2013-06-18_01-03-47.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-02-11.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-02-11.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-03-08.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-03-08.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-03-08.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G180_he0_ve0_hs-10_vs0_2013-06-18_01-04-25.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs-5_vs0_2013-06-18_01-04-44.mat ';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-05-04.mat  ';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs5_vs0_2013-06-18_01-05-23.mat  ';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs10_vs0_2013-06-18_01-05-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-04-06.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-04-06.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-05-04.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-05-04.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-05-04.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs-10_2013-06-18_01-06-21.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs-5_2013-06-18_01-06-40.mat ';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-06-59.mat  ';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs5_2013-06-18_01-07-18.mat  ';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs10_2013-06-18_01-07-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-06-01.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-06-01.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-06-59.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-06-59.mat';
                                  'Efficiency_HU36_SIRIUS_G180_he0_ve0_hs0_vs0_2013-06-18_01-06-59.mat']);
        end
    elseif(gap < 0.5*(20+ 22.5))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G200_he-10_ve0_hs0_vs0_2013-06-18_01-08-28.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he-5_ve0_hs0_vs0_2013-06-18_01-08-47.mat ';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-09-07.mat  ';
                                  'Efficiency_HU36_SIRIUS_G200_he5_ve0_hs0_vs0_2013-06-18_01-09-26.mat  ';
                                  'Efficiency_HU36_SIRIUS_G200_he10_ve0_hs0_vs0_2013-06-18_01-09-45.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-08-09.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-08-09.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-09-07.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-09-07.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-09-07.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G200_he0_ve-10_hs0_vs0_2013-06-18_01-10-23.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve-5_hs0_vs0_2013-06-18_01-10-43.mat ';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-11-02.mat  ';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve5_hs0_vs0_2013-06-18_01-11-21.mat  ';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve10_hs0_vs0_2013-06-18_01-11-40.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-10-04.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-10-04.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-11-02.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-11-02.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-11-02.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G200_he0_ve0_hs-10_vs0_2013-06-18_01-12-19.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs-5_vs0_2013-06-18_01-12-38.mat ';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-12-57.mat  ';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs5_vs0_2013-06-18_01-13-16.mat  ';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs10_vs0_2013-06-18_01-13-35.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-11-59.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-11-59.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-12-57.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-12-57.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-12-57.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs-10_2013-06-18_01-14-14.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs-5_2013-06-18_01-14-33.mat ';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-14-52.mat  ';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs5_2013-06-18_01-15-11.mat  ';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs10_2013-06-18_01-15-31.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-13-55.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-13-55.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-14-52.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-14-52.mat';
                                  'Efficiency_HU36_SIRIUS_G200_he0_ve0_hs0_vs0_2013-06-18_01-14-52.mat']);
        end
    elseif(gap < 0.5*(22.5+ 25))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G225_he-10_ve0_hs0_vs0_2013-06-18_01-16-21.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he-5_ve0_hs0_vs0_2013-06-18_01-16-40.mat ';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-17-00.mat  ';
                                  'Efficiency_HU36_SIRIUS_G225_he5_ve0_hs0_vs0_2013-06-18_01-17-19.mat  ';
                                  'Efficiency_HU36_SIRIUS_G225_he10_ve0_hs0_vs0_2013-06-18_01-17-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-16-02.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-16-02.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-17-00.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-17-00.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-17-00.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G225_he0_ve-10_hs0_vs0_2013-06-18_01-18-16.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve-5_hs0_vs0_2013-06-18_01-18-36.mat ';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-18-55.mat  ';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve5_hs0_vs0_2013-06-18_01-19-14.mat  ';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve10_hs0_vs0_2013-06-18_01-19-33.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-17-57.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-17-57.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-18-55.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-18-55.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-18-55.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G225_he0_ve0_hs-10_vs0_2013-06-18_01-20-12.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs-5_vs0_2013-06-18_01-20-31.mat ';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-20-50.mat  ';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs5_vs0_2013-06-18_01-21-09.mat  ';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs10_vs0_2013-06-18_01-21-28.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-19-52.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-19-52.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-20-50.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-20-50.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-20-50.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs-10_2013-06-18_01-22-07.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs-5_2013-06-18_01-22-26.mat ';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-22-45.mat  ';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs5_2013-06-18_01-23-04.mat  ';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs10_2013-06-18_01-23-23.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-21-48.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-21-48.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-22-45.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-22-45.mat';
                                  'Efficiency_HU36_SIRIUS_G225_he0_ve0_hs0_vs0_2013-06-18_01-22-45.mat']);
        end
    elseif(gap < 0.5*(25+ 27.5))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G250_he-10_ve0_hs0_vs0_2013-06-18_01-24-14.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he-5_ve0_hs0_vs0_2013-06-18_01-24-33.mat ';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-24-52.mat  ';
                                  'Efficiency_HU36_SIRIUS_G250_he5_ve0_hs0_vs0_2013-06-18_01-25-12.mat  ';
                                  'Efficiency_HU36_SIRIUS_G250_he10_ve0_hs0_vs0_2013-06-18_01-25-31.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-23-55.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-23-55.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-24-52.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-24-52.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-24-52.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G250_he0_ve-10_hs0_vs0_2013-06-18_01-26-09.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve-5_hs0_vs0_2013-06-18_01-26-28.mat ';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-26-48.mat  ';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve5_hs0_vs0_2013-06-18_01-27-07.mat  ';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve10_hs0_vs0_2013-06-18_01-27-26.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-25-50.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-25-50.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-26-48.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-26-48.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-26-48.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G250_he0_ve0_hs-10_vs0_2013-06-18_01-28-04.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs-5_vs0_2013-06-18_01-28-24.mat ';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-28-43.mat  ';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs5_vs0_2013-06-18_01-29-02.mat  ';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs10_vs0_2013-06-18_01-29-21.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-27-45.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-27-45.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-28-43.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-28-43.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-28-43.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs-10_2013-06-18_01-30-00.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs-5_2013-06-18_01-30-19.mat ';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-30-38.mat  ';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs5_2013-06-18_01-30-57.mat  ';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs10_2013-06-18_01-31-17.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-29-41.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-29-41.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-30-38.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-30-38.mat';
                                  'Efficiency_HU36_SIRIUS_G250_he0_ve0_hs0_vs0_2013-06-18_01-30-38.mat']);
        end
    elseif(gap < 0.5*(27.5+ 30))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G275_he-10_ve0_hs0_vs0_2013-06-18_01-32-07.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he-5_ve0_hs0_vs0_2013-06-18_01-32-27.mat ';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-32-46.mat  ';
                                  'Efficiency_HU36_SIRIUS_G275_he5_ve0_hs0_vs0_2013-06-18_01-33-05.mat  ';
                                  'Efficiency_HU36_SIRIUS_G275_he10_ve0_hs0_vs0_2013-06-18_01-33-24.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-31-48.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-31-48.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-32-46.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-32-46.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-32-46.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G275_he0_ve-10_hs0_vs0_2013-06-18_01-34-02.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve-5_hs0_vs0_2013-06-18_01-34-22.mat ';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-34-41.mat  ';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve5_hs0_vs0_2013-06-18_01-35-00.mat  ';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve10_hs0_vs0_2013-06-18_01-35-19.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-33-43.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-33-43.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-34-41.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-34-41.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-34-41.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G275_he0_ve0_hs-10_vs0_2013-06-18_01-35-58.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs-5_vs0_2013-06-18_01-36-17.mat ';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-36-36.mat  ';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs5_vs0_2013-06-18_01-36-55.mat  ';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs10_vs0_2013-06-18_01-37-15.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-35-38.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-35-38.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-36-36.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-36-36.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-36-36.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs-10_2013-06-18_01-37-53.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs-5_2013-06-18_01-38-13.mat ';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-38-32.mat  ';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs5_2013-06-18_01-38-51.mat  ';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs10_2013-06-18_01-39-10.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-37-34.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-37-34.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-38-32.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-38-32.mat';
                                  'Efficiency_HU36_SIRIUS_G275_he0_ve0_hs0_vs0_2013-06-18_01-38-32.mat']);
        end
    elseif(gap < 0.5*(30+ 35))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G300_he-10_ve0_hs0_vs0_2013-06-18_01-40-01.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he-5_ve0_hs0_vs0_2013-06-18_01-40-20.mat ';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-40-39.mat  ';
                                  'Efficiency_HU36_SIRIUS_G300_he5_ve0_hs0_vs0_2013-06-18_01-40-58.mat  ';
                                  'Efficiency_HU36_SIRIUS_G300_he10_ve0_hs0_vs0_2013-06-18_01-41-18.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-39-42.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-39-42.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-40-39.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-40-39.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-40-39.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G300_he0_ve-10_hs0_vs0_2013-06-18_01-41-56.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve-5_hs0_vs0_2013-06-18_01-42-15.mat ';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-42-34.mat  ';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve5_hs0_vs0_2013-06-18_01-42-53.mat  ';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve10_hs0_vs0_2013-06-18_01-43-13.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-41-37.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-41-37.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-42-34.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-42-34.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-42-34.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G300_he0_ve0_hs-10_vs0_2013-06-18_01-43-51.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs-5_vs0_2013-06-18_01-44-10.mat ';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-44-29.mat  ';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs5_vs0_2013-06-18_01-44-49.mat  ';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs10_vs0_2013-06-18_01-45-08.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-43-32.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-43-32.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-44-29.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-44-29.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-44-29.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs-10_2013-06-18_01-45-46.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs-5_2013-06-18_01-46-05.mat ';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-46-25.mat  ';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs5_2013-06-18_01-46-44.mat  ';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs10_2013-06-18_01-47-03.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-45-27.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-45-27.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-46-25.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-46-25.mat';
                                  'Efficiency_HU36_SIRIUS_G300_he0_ve0_hs0_vs0_2013-06-18_01-46-25.mat']);
        end
    elseif(gap < 0.5*(35+ 40))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G350_he-10_ve0_hs0_vs0_2013-06-18_01-47-54.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he-5_ve0_hs0_vs0_2013-06-18_01-48-13.mat ';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-48-32.mat  ';
                                  'Efficiency_HU36_SIRIUS_G350_he5_ve0_hs0_vs0_2013-06-18_01-48-51.mat  ';
                                  'Efficiency_HU36_SIRIUS_G350_he10_ve0_hs0_vs0_2013-06-18_01-49-10.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-47-34.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-47-34.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-48-32.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-48-32.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-48-32.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G350_he0_ve-10_hs0_vs0_2013-06-18_01-49-49.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve-5_hs0_vs0_2013-06-18_01-50-08.mat ';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-50-27.mat  ';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve5_hs0_vs0_2013-06-18_01-50-46.mat  ';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve10_hs0_vs0_2013-06-18_01-51-05.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-49-30.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-49-30.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-50-27.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-50-27.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-50-27.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G350_he0_ve0_hs-10_vs0_2013-06-18_01-51-44.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs-5_vs0_2013-06-18_01-52-03.mat ';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-52-22.mat  ';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs5_vs0_2013-06-18_01-52-41.mat  ';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs10_vs0_2013-06-18_01-53-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-51-25.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-51-25.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-52-22.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-52-22.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-52-22.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs-10_2013-06-18_01-53-39.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs-5_2013-06-18_01-53-58.mat ';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-54-18.mat  ';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs5_2013-06-18_01-54-37.mat  ';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs10_2013-06-18_01-54-56.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-53-20.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-53-20.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-54-18.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-54-18.mat';
                                  'Efficiency_HU36_SIRIUS_G350_he0_ve0_hs0_vs0_2013-06-18_01-54-18.mat']);
        end
    elseif(gap < 0.5*(40+ 50))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G400_he-10_ve0_hs0_vs0_2013-06-18_01-55-47.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he-5_ve0_hs0_vs0_2013-06-18_01-56-06.mat ';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-56-25.mat  ';
                                  'Efficiency_HU36_SIRIUS_G400_he5_ve0_hs0_vs0_2013-06-18_01-56-44.mat  ';
                                  'Efficiency_HU36_SIRIUS_G400_he10_ve0_hs0_vs0_2013-06-18_01-57-03.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-55-28.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-55-28.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-56-25.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-56-25.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-56-25.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G400_he0_ve-10_hs0_vs0_2013-06-18_01-57-42.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve-5_hs0_vs0_2013-06-18_01-58-01.mat ';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-58-20.mat  ';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve5_hs0_vs0_2013-06-18_01-58-40.mat  ';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve10_hs0_vs0_2013-06-18_01-58-59.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-57-23.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-57-23.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-58-20.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-58-20.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-58-20.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G400_he0_ve0_hs-10_vs0_2013-06-18_01-59-37.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs-5_vs0_2013-06-18_01-59-56.mat ';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_02-00-16.mat  ';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs5_vs0_2013-06-18_02-00-35.mat  ';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs10_vs0_2013-06-18_02-00-54.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-59-18.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_01-59-18.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_02-00-16.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_02-00-16.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_02-00-16.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs-10_2013-06-18_02-01-32.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs-5_2013-06-18_02-01-52.mat ';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_02-02-11.mat  ';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs5_2013-06-18_02-02-30.mat  ';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs10_2013-06-18_02-02-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_02-01-13.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_02-01-13.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_02-02-11.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_02-02-11.mat';
                                  'Efficiency_HU36_SIRIUS_G400_he0_ve0_hs0_vs0_2013-06-18_02-02-11.mat']);
        end
    elseif(gap < 0.5*(50+ 60))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G500_he-10_ve0_hs0_vs0_2013-06-18_02-03-43.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he-5_ve0_hs0_vs0_2013-06-18_02-04-02.mat ';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-04-22.mat  ';
                                  'Efficiency_HU36_SIRIUS_G500_he5_ve0_hs0_vs0_2013-06-18_02-04-41.mat  ';
                                  'Efficiency_HU36_SIRIUS_G500_he10_ve0_hs0_vs0_2013-06-18_02-05-00.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-03-24.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-03-24.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-04-22.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-04-22.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-04-22.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G500_he0_ve-10_hs0_vs0_2013-06-18_02-05-39.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve-5_hs0_vs0_2013-06-18_02-05-58.mat ';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-06-17.mat  ';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve5_hs0_vs0_2013-06-18_02-06-36.mat  ';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve10_hs0_vs0_2013-06-18_02-06-56.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-05-20.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-05-20.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-06-17.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-06-17.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-06-17.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G500_he0_ve0_hs-10_vs0_2013-06-18_02-07-34.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs-5_vs0_2013-06-18_02-07-53.mat ';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-08-12.mat  ';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs5_vs0_2013-06-18_02-08-32.mat  ';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs10_vs0_2013-06-18_02-08-51.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-07-15.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-07-15.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-08-12.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-08-12.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-08-12.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs-10_2013-06-18_02-09-29.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs-5_2013-06-18_02-09-49.mat ';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-10-08.mat  ';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs5_2013-06-18_02-10-27.mat  ';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs10_2013-06-18_02-10-46.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-09-10.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-09-10.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-10-08.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-10-08.mat';
                                  'Efficiency_HU36_SIRIUS_G500_he0_ve0_hs0_vs0_2013-06-18_02-10-08.mat']);
        end
    elseif(gap < 0.5*(60+ 70))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G600_he-10_ve0_hs0_vs0_2013-06-18_02-11-40.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he-5_ve0_hs0_vs0_2013-06-18_02-11-59.mat ';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-12-18.mat  ';
                                  'Efficiency_HU36_SIRIUS_G600_he5_ve0_hs0_vs0_2013-06-18_02-12-37.mat  ';
                                  'Efficiency_HU36_SIRIUS_G600_he10_ve0_hs0_vs0_2013-06-18_02-12-57.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-11-21.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-11-21.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-12-18.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-12-18.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-12-18.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G600_he0_ve-10_hs0_vs0_2013-06-18_02-13-35.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve-5_hs0_vs0_2013-06-18_02-13-54.mat ';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-14-14.mat  ';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve5_hs0_vs0_2013-06-18_02-14-33.mat  ';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve10_hs0_vs0_2013-06-18_02-14-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-13-16.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-13-16.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-14-14.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-14-14.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-14-14.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G600_he0_ve0_hs-10_vs0_2013-06-18_02-15-30.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs-5_vs0_2013-06-18_02-15-50.mat ';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-16-09.mat  ';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs5_vs0_2013-06-18_02-16-28.mat  ';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs10_vs0_2013-06-18_02-16-48.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-15-11.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-15-11.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-16-09.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-16-09.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-16-09.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs-10_2013-06-18_02-17-26.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs-5_2013-06-18_02-17-45.mat ';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-18-05.mat  ';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs5_2013-06-18_02-18-24.mat  ';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs10_2013-06-18_02-18-43.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-17-07.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-17-07.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-18-05.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-18-05.mat';
                                  'Efficiency_HU36_SIRIUS_G600_he0_ve0_hs0_vs0_2013-06-18_02-18-05.mat']);
        end
    elseif(gap < 0.5*(70+ 80))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G700_he-10_ve0_hs0_vs0_2013-06-18_02-19-37.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he-5_ve0_hs0_vs0_2013-06-18_02-19-56.mat ';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-20-15.mat  ';
                                  'Efficiency_HU36_SIRIUS_G700_he5_ve0_hs0_vs0_2013-06-18_02-20-34.mat  ';
                                  'Efficiency_HU36_SIRIUS_G700_he10_ve0_hs0_vs0_2013-06-18_02-20-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-19-17.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-19-17.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-20-15.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-20-15.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-20-15.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G700_he0_ve-10_hs0_vs0_2013-06-18_02-21-32.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve-5_hs0_vs0_2013-06-18_02-21-51.mat ';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-22-10.mat  ';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve5_hs0_vs0_2013-06-18_02-22-30.mat  ';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve10_hs0_vs0_2013-06-18_02-22-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-21-13.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-21-13.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-22-10.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-22-10.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-22-10.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G700_he0_ve0_hs-10_vs0_2013-06-18_02-23-27.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs-5_vs0_2013-06-18_02-23-46.mat ';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-24-06.mat  ';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs5_vs0_2013-06-18_02-24-25.mat  ';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs10_vs0_2013-06-18_02-24-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-23-08.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-23-08.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-24-06.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-24-06.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-24-06.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs-10_2013-06-18_02-25-22.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs-5_2013-06-18_02-25-42.mat ';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-26-01.mat  ';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs5_2013-06-18_02-26-23.mat  ';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs10_2013-06-18_02-26-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-25-03.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-25-03.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-26-01.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-26-01.mat';
                                  'Efficiency_HU36_SIRIUS_G700_he0_ve0_hs0_vs0_2013-06-18_02-26-01.mat']);
        end
    elseif(gap < 0.5*(80+ 90))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G800_he-10_ve0_hs0_vs0_2013-06-18_02-27-36.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he-5_ve0_hs0_vs0_2013-06-18_02-27-55.mat ';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-28-14.mat  ';
                                  'Efficiency_HU36_SIRIUS_G800_he5_ve0_hs0_vs0_2013-06-18_02-28-33.mat  ';
                                  'Efficiency_HU36_SIRIUS_G800_he10_ve0_hs0_vs0_2013-06-18_02-28-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-27-16.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-27-16.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-28-14.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-28-14.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-28-14.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G800_he0_ve-10_hs0_vs0_2013-06-18_02-29-31.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve-5_hs0_vs0_2013-06-18_02-29-50.mat ';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-30-09.mat  ';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve5_hs0_vs0_2013-06-18_02-30-28.mat  ';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve10_hs0_vs0_2013-06-18_02-30-48.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-29-12.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-29-12.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-30-09.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-30-09.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-30-09.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G800_he0_ve0_hs-10_vs0_2013-06-18_02-31-26.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs-5_vs0_2013-06-18_02-31-45.mat ';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-32-04.mat  ';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs5_vs0_2013-06-18_02-32-24.mat  ';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs10_vs0_2013-06-18_02-32-43.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-31-07.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-31-07.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-32-04.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-32-04.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-32-04.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs-10_2013-06-18_02-33-21.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs-5_2013-06-18_02-33-40.mat ';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-34-00.mat  ';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs5_2013-06-18_02-34-19.mat  ';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs10_2013-06-18_02-34-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-33-02.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-33-02.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-34-00.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-34-00.mat';
                                  'Efficiency_HU36_SIRIUS_G800_he0_ve0_hs0_vs0_2013-06-18_02-34-00.mat']);
        end
    elseif(gap < 0.5*(90+ 100))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G900_he-10_ve0_hs0_vs0_2013-06-18_02-35-32.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he-5_ve0_hs0_vs0_2013-06-18_02-35-51.mat ';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-36-10.mat  ';
                                  'Efficiency_HU36_SIRIUS_G900_he5_ve0_hs0_vs0_2013-06-18_02-36-29.mat  ';
                                  'Efficiency_HU36_SIRIUS_G900_he10_ve0_hs0_vs0_2013-06-18_02-36-48.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-35-12.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-35-12.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-36-10.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-36-10.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-36-10.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G900_he0_ve-10_hs0_vs0_2013-06-18_02-37-27.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve-5_hs0_vs0_2013-06-18_02-37-46.mat ';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-38-05.mat  ';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve5_hs0_vs0_2013-06-18_02-38-24.mat  ';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve10_hs0_vs0_2013-06-18_02-38-43.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-37-08.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-37-08.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-38-05.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-38-05.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-38-05.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G900_he0_ve0_hs-10_vs0_2013-06-18_02-39-22.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs-5_vs0_2013-06-18_02-39-41.mat ';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-40-00.mat  ';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs5_vs0_2013-06-18_02-40-20.mat  ';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs10_vs0_2013-06-18_02-40-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-39-03.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-39-03.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-40-00.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-40-00.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-40-00.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs-10_2013-06-18_02-41-17.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs-5_2013-06-18_02-41-37.mat ';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-41-56.mat  ';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs5_2013-06-18_02-42-15.mat  ';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs10_2013-06-18_02-42-34.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-40-58.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-40-58.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-41-56.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-41-56.mat';
                                  'Efficiency_HU36_SIRIUS_G900_he0_ve0_hs0_vs0_2013-06-18_02-41-56.mat']);
        end
    elseif(gap < 0.5*(100+ 110))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1000_he-10_ve0_hs0_vs0_2013-06-18_02-43-28.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he-5_ve0_hs0_vs0_2013-06-18_02-43-47.mat ';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-44-06.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1000_he5_ve0_hs0_vs0_2013-06-18_02-44-25.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1000_he10_ve0_hs0_vs0_2013-06-18_02-44-45.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-43-09.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-43-09.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-44-06.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-44-06.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-44-06.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1000_he0_ve-10_hs0_vs0_2013-06-18_02-45-23.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve-5_hs0_vs0_2013-06-18_02-45-42.mat ';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-46-01.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve5_hs0_vs0_2013-06-18_02-46-21.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve10_hs0_vs0_2013-06-18_02-46-40.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-45-04.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-45-04.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-46-01.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-46-01.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-46-01.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs-10_vs0_2013-06-18_02-47-18.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs-5_vs0_2013-06-18_02-47-38.mat ';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-47-57.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs5_vs0_2013-06-18_02-48-16.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs10_vs0_2013-06-18_02-48-35.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-46-59.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-46-59.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-47-57.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-47-57.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-47-57.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs-10_2013-06-18_02-49-13.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs-5_2013-06-18_02-49-33.mat ';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-49-52.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs5_2013-06-18_02-50-11.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs10_2013-06-18_02-50-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-48-54.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-48-54.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-49-52.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-49-52.mat';
                                  'Efficiency_HU36_SIRIUS_G1000_he0_ve0_hs0_vs0_2013-06-18_02-49-52.mat']);
        end
    elseif(gap < 0.5*(110+ 130))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1100_he-10_ve0_hs0_vs0_2013-06-18_02-51-24.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he-5_ve0_hs0_vs0_2013-06-18_02-51-43.mat ';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-52-02.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1100_he5_ve0_hs0_vs0_2013-06-18_02-52-21.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1100_he10_ve0_hs0_vs0_2013-06-18_02-52-41.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-51-05.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-51-05.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-52-02.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-52-02.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-52-02.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1100_he0_ve-10_hs0_vs0_2013-06-18_02-53-19.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve-5_hs0_vs0_2013-06-18_02-53-38.mat ';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-53-57.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve5_hs0_vs0_2013-06-18_02-54-17.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve10_hs0_vs0_2013-06-18_02-54-36.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-53-00.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-53-00.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-53-57.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-53-57.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-53-57.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs-10_vs0_2013-06-18_02-55-14.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs-5_vs0_2013-06-18_02-55-33.mat ';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-55-53.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs5_vs0_2013-06-18_02-56-12.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs10_vs0_2013-06-18_02-56-31.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-54-55.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-54-55.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-55-53.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-55-53.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-55-53.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs-10_2013-06-18_02-57-10.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs-5_2013-06-18_02-57-29.mat ';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-57-48.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs5_2013-06-18_02-58-07.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs10_2013-06-18_02-58-26.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-56-50.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-56-50.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-57-48.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-57-48.mat';
                                  'Efficiency_HU36_SIRIUS_G1100_he0_ve0_hs0_vs0_2013-06-18_02-57-48.mat']);
        end
    elseif(gap < 0.5*(130+ 150))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1300_he-10_ve0_hs0_vs0_2013-06-18_02-59-23.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he-5_ve0_hs0_vs0_2013-06-18_02-59-42.mat ';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-00-01.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1300_he5_ve0_hs0_vs0_2013-06-18_03-00-21.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1300_he10_ve0_hs0_vs0_2013-06-18_03-00-40.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_02-59-04.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_02-59-04.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-00-01.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-00-01.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-00-01.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1300_he0_ve-10_hs0_vs0_2013-06-18_03-01-18.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve-5_hs0_vs0_2013-06-18_03-01-37.mat ';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-01-57.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve5_hs0_vs0_2013-06-18_03-02-16.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve10_hs0_vs0_2013-06-18_03-02-35.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-00-59.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-00-59.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-01-57.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-01-57.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-01-57.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs-10_vs0_2013-06-18_03-03-14.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs-5_vs0_2013-06-18_03-03-33.mat ';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-03-52.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs5_vs0_2013-06-18_03-04-12.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs10_vs0_2013-06-18_03-04-31.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-02-55.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-02-55.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-03-52.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-03-52.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-03-52.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs-10_2013-06-18_03-05-09.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs-5_2013-06-18_03-05-28.mat ';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-05-48.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs5_2013-06-18_03-06-07.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs10_2013-06-18_03-06-26.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-04-50.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-04-50.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-05-48.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-05-48.mat';
                                  'Efficiency_HU36_SIRIUS_G1300_he0_ve0_hs0_vs0_2013-06-18_03-05-48.mat']);
        end
    elseif(gap < 0.5*(150+ 200))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1500_he-10_ve0_hs0_vs0_2013-06-18_03-07-23.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he-5_ve0_hs0_vs0_2013-06-18_03-07-42.mat ';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-08-01.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1500_he5_ve0_hs0_vs0_2013-06-18_03-08-21.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1500_he10_ve0_hs0_vs0_2013-06-18_03-08-40.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-07-04.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-07-04.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-08-01.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-08-01.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-08-01.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1500_he0_ve-10_hs0_vs0_2013-06-18_03-09-18.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve-5_hs0_vs0_2013-06-18_03-09-38.mat ';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-09-57.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve5_hs0_vs0_2013-06-18_03-10-16.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve10_hs0_vs0_2013-06-18_03-10-36.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-08-59.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-08-59.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-09-57.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-09-57.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-09-57.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs-10_vs0_2013-06-18_03-11-14.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs-5_vs0_2013-06-18_03-11-33.mat ';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-11-52.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs5_vs0_2013-06-18_03-12-12.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs10_vs0_2013-06-18_03-12-31.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-10-55.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-10-55.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-11-52.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-11-52.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-11-52.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs-10_2013-06-18_03-13-09.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs-5_2013-06-18_03-13-28.mat ';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-13-48.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs5_2013-06-18_03-14-07.mat  ';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs10_2013-06-18_03-14-26.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-12-50.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-12-50.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-13-48.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-13-48.mat';
                                  'Efficiency_HU36_SIRIUS_G1500_he0_ve0_hs0_vs0_2013-06-18_03-13-48.mat']);
        end
    else	% Gap > 200

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G2000_he-10_ve0_hs0_vs0_2013-06-18_03-15-32.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he-5_ve0_hs0_vs0_2013-06-18_03-15-51.mat ';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-16-10.mat  ';
                                  'Efficiency_HU36_SIRIUS_G2000_he5_ve0_hs0_vs0_2013-06-18_03-16-29.mat  ';
                                  'Efficiency_HU36_SIRIUS_G2000_he10_ve0_hs0_vs0_2013-06-18_03-16-48.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-15-12.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-15-12.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-16-10.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-16-10.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-16-10.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G2000_he0_ve-10_hs0_vs0_2013-06-18_03-17-27.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve-5_hs0_vs0_2013-06-18_03-17-46.mat ';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-18-05.mat  ';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve5_hs0_vs0_2013-06-18_03-18-24.mat  ';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve10_hs0_vs0_2013-06-18_03-18-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-17-08.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-17-08.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-18-05.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-18-05.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-18-05.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs-10_vs0_2013-06-18_03-19-22.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs-5_vs0_2013-06-18_03-19-42.mat ';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-20-01.mat  ';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs5_vs0_2013-06-18_03-20-20.mat  ';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs10_vs0_2013-06-18_03-20-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-19-03.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-19-03.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-20-01.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-20-01.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-20-01.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs-10_2013-06-18_03-21-18.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs-5_2013-06-18_03-21-37.mat ';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-21-56.mat  ';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs5_2013-06-18_03-22-15.mat  ';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs10_2013-06-18_03-22-34.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-20-58.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-20-58.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-21-56.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-21-56.mat';
                                  'Efficiency_HU36_SIRIUS_G2000_he0_ve0_hs0_vs0_2013-06-18_03-21-56.mat']);
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU42_HERMES  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(idName, 'HU42_HERMES')
    vCurVals = [-10, -5, 0, 5,10];

    if (gap < 0.5*(15.5+ 16))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G155_he-10_ve0_hs0_vs0_2014-01-25_23-48-59.mat';
                                  'Efficiency_HU42_HERMES_G155_he-5_ve0_hs0_vs0_2014-01-25_23-49-18.mat ';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-49-37.mat  ';
                                  'Efficiency_HU42_HERMES_G155_he5_ve0_hs0_vs0_2014-01-25_23-49-57.mat  ';
                                  'Efficiency_HU42_HERMES_G155_he10_ve0_hs0_vs0_2014-01-25_23-50-16.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-48-39.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-48-39.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-49-37.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-49-37.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-49-37.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G155_he0_ve-10_hs0_vs0_2014-01-25_23-50-54.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve-5_hs0_vs0_2014-01-25_23-51-14.mat ';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-51-33.mat  ';
                                  'Efficiency_HU42_HERMES_G155_he0_ve5_hs0_vs0_2014-01-25_23-51-53.mat  ';
                                  'Efficiency_HU42_HERMES_G155_he0_ve10_hs0_vs0_2014-01-25_23-52-12.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-50-35.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-50-35.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-51-33.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-51-33.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-51-33.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G155_he0_ve0_hs-10_vs0_2014-01-25_23-52-50.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs-5_vs0_2014-01-25_23-53-10.mat ';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-53-29.mat  ';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs5_vs0_2014-01-25_23-53-48.mat  ';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs10_vs0_2014-01-25_23-54-07.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-52-31.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-52-31.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-53-29.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-53-29.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-53-29.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs-10_2014-01-25_23-54-46.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs-5_2014-01-25_23-55-05.mat ';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-55-25.mat  ';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs5_2014-01-25_23-55-44.mat  ';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs10_2014-01-25_23-56-03.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-54-27.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-54-27.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-55-25.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-55-25.mat';
                                  'Efficiency_HU42_HERMES_G155_he0_ve0_hs0_vs0_2014-01-25_23-55-25.mat']);
        end
    elseif(gap < 0.5*(16+ 18))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G160_he-10_ve0_hs0_vs0_2014-01-25_23-56-55.mat';
                                  'Efficiency_HU42_HERMES_G160_he-5_ve0_hs0_vs0_2014-01-25_23-57-14.mat ';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-57-33.mat  ';
                                  'Efficiency_HU42_HERMES_G160_he5_ve0_hs0_vs0_2014-01-25_23-57-53.mat  ';
                                  'Efficiency_HU42_HERMES_G160_he10_ve0_hs0_vs0_2014-01-25_23-58-12.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-56-36.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-56-36.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-57-33.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-57-33.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-57-33.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G160_he0_ve-10_hs0_vs0_2014-01-25_23-58-51.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve-5_hs0_vs0_2014-01-25_23-59-10.mat ';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-59-30.mat  ';
                                  'Efficiency_HU42_HERMES_G160_he0_ve5_hs0_vs0_2014-01-25_23-59-49.mat  ';
                                  'Efficiency_HU42_HERMES_G160_he0_ve10_hs0_vs0_2014-01-26_00-00-08.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-58-31.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-58-31.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-59-30.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-59-30.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-25_23-59-30.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G160_he0_ve0_hs-10_vs0_2014-01-26_00-00-47.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs-5_vs0_2014-01-26_00-01-07.mat ';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-01-26.mat  ';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs5_vs0_2014-01-26_00-01-45.mat  ';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs10_vs0_2014-01-26_00-02-05.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-00-28.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-00-28.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-01-26.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-01-26.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-01-26.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs-10_2014-01-26_00-02-44.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs-5_2014-01-26_00-03-03.mat ';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-03-23.mat  ';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs5_2014-01-26_00-03-42.mat  ';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs10_2014-01-26_00-04-02.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-02-24.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-02-24.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-03-23.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-03-23.mat';
                                  'Efficiency_HU42_HERMES_G160_he0_ve0_hs0_vs0_2014-01-26_00-03-23.mat']);
        end
    elseif(gap < 0.5*(18+ 20))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G180_he-10_ve0_hs0_vs0_2014-01-26_00-04-53.mat';
                                  'Efficiency_HU42_HERMES_G180_he-5_ve0_hs0_vs0_2014-01-26_00-05-12.mat ';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-05-31.mat  ';
                                  'Efficiency_HU42_HERMES_G180_he5_ve0_hs0_vs0_2014-01-26_00-05-50.mat  ';
                                  'Efficiency_HU42_HERMES_G180_he10_ve0_hs0_vs0_2014-01-26_00-06-10.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-04-33.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-04-33.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-05-31.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-05-31.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-05-31.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G180_he0_ve-10_hs0_vs0_2014-01-26_00-06-49.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve-5_hs0_vs0_2014-01-26_00-07-08.mat ';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-07-28.mat  ';
                                  'Efficiency_HU42_HERMES_G180_he0_ve5_hs0_vs0_2014-01-26_00-07-47.mat  ';
                                  'Efficiency_HU42_HERMES_G180_he0_ve10_hs0_vs0_2014-01-26_00-08-06.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-06-30.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-06-30.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-07-28.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-07-28.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-07-28.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G180_he0_ve0_hs-10_vs0_2014-01-26_00-08-45.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs-5_vs0_2014-01-26_00-09-04.mat ';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-09-23.mat  ';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs5_vs0_2014-01-26_00-09-42.mat  ';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs10_vs0_2014-01-26_00-10-02.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-08-25.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-08-25.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-09-23.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-09-23.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-09-23.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs-10_2014-01-26_00-10-40.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs-5_2014-01-26_00-10-59.mat ';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-11-19.mat  ';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs5_2014-01-26_00-11-38.mat  ';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs10_2014-01-26_00-11-57.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-10-21.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-10-21.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-11-19.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-11-19.mat';
                                  'Efficiency_HU42_HERMES_G180_he0_ve0_hs0_vs0_2014-01-26_00-11-19.mat']);
        end
    elseif(gap < 0.5*(20+ 22.5))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G200_he-10_ve0_hs0_vs0_2014-01-26_00-12-48.mat';
                                  'Efficiency_HU42_HERMES_G200_he-5_ve0_hs0_vs0_2014-01-26_00-13-07.mat ';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-13-27.mat  ';
                                  'Efficiency_HU42_HERMES_G200_he5_ve0_hs0_vs0_2014-01-26_00-13-46.mat  ';
                                  'Efficiency_HU42_HERMES_G200_he10_ve0_hs0_vs0_2014-01-26_00-14-05.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-12-29.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-12-29.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-13-27.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-13-27.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-13-27.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G200_he0_ve-10_hs0_vs0_2014-01-26_00-14-44.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve-5_hs0_vs0_2014-01-26_00-15-03.mat ';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-15-22.mat  ';
                                  'Efficiency_HU42_HERMES_G200_he0_ve5_hs0_vs0_2014-01-26_00-15-42.mat  ';
                                  'Efficiency_HU42_HERMES_G200_he0_ve10_hs0_vs0_2014-01-26_00-16-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-14-25.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-14-25.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-15-22.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-15-22.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-15-22.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G200_he0_ve0_hs-10_vs0_2014-01-26_00-16-41.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs-5_vs0_2014-01-26_00-17-00.mat ';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-17-19.mat  ';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs5_vs0_2014-01-26_00-17-39.mat  ';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs10_vs0_2014-01-26_00-17-58.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-16-20.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-16-20.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-17-19.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-17-19.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-17-19.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs-10_2014-01-26_00-18-36.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs-5_2014-01-26_00-18-56.mat ';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-19-15.mat  ';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs5_2014-01-26_00-19-34.mat  ';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs10_2014-01-26_00-19-54.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-18-17.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-18-17.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-19-15.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-19-15.mat';
                                  'Efficiency_HU42_HERMES_G200_he0_ve0_hs0_vs0_2014-01-26_00-19-15.mat']);
        end
    elseif(gap < 0.5*(22.5+ 25))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G225_he-10_ve0_hs0_vs0_2014-01-26_00-20-48.mat';
                                  'Efficiency_HU42_HERMES_G225_he-5_ve0_hs0_vs0_2014-01-26_00-21-07.mat ';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-21-27.mat  ';
                                  'Efficiency_HU42_HERMES_G225_he5_ve0_hs0_vs0_2014-01-26_00-21-46.mat  ';
                                  'Efficiency_HU42_HERMES_G225_he10_ve0_hs0_vs0_2014-01-26_00-22-05.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-20-28.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-20-28.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-21-27.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-21-27.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-21-27.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G225_he0_ve-10_hs0_vs0_2014-01-26_00-22-44.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve-5_hs0_vs0_2014-01-26_00-23-03.mat ';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-23-22.mat  ';
                                  'Efficiency_HU42_HERMES_G225_he0_ve5_hs0_vs0_2014-01-26_00-23-42.mat  ';
                                  'Efficiency_HU42_HERMES_G225_he0_ve10_hs0_vs0_2014-01-26_00-24-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-22-24.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-22-24.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-23-22.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-23-22.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-23-22.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G225_he0_ve0_hs-10_vs0_2014-01-26_00-24-39.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs-5_vs0_2014-01-26_00-24-59.mat ';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-25-18.mat  ';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs5_vs0_2014-01-26_00-25-37.mat  ';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs10_vs0_2014-01-26_00-25-56.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-24-20.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-24-20.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-25-18.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-25-18.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-25-18.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs-10_2014-01-26_00-26-36.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs-5_2014-01-26_00-26-55.mat ';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-27-14.mat  ';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs5_2014-01-26_00-27-33.mat  ';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs10_2014-01-26_00-27-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-26-16.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-26-16.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-27-14.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-27-14.mat';
                                  'Efficiency_HU42_HERMES_G225_he0_ve0_hs0_vs0_2014-01-26_00-27-14.mat']);
        end
    elseif(gap < 0.5*(25+ 27.5))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G250_he-10_ve0_hs0_vs0_2014-01-26_00-28-44.mat';
                                  'Efficiency_HU42_HERMES_G250_he-5_ve0_hs0_vs0_2014-01-26_00-29-03.mat ';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-29-22.mat  ';
                                  'Efficiency_HU42_HERMES_G250_he5_ve0_hs0_vs0_2014-01-26_00-29-42.mat  ';
                                  'Efficiency_HU42_HERMES_G250_he10_ve0_hs0_vs0_2014-01-26_00-30-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-28-25.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-28-25.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-29-22.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-29-22.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-29-22.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G250_he0_ve-10_hs0_vs0_2014-01-26_00-30-39.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve-5_hs0_vs0_2014-01-26_00-30-59.mat ';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-31-18.mat  ';
                                  'Efficiency_HU42_HERMES_G250_he0_ve5_hs0_vs0_2014-01-26_00-31-37.mat  ';
                                  'Efficiency_HU42_HERMES_G250_he0_ve10_hs0_vs0_2014-01-26_00-31-56.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-30-20.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-30-20.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-31-18.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-31-18.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-31-18.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G250_he0_ve0_hs-10_vs0_2014-01-26_00-32-35.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs-5_vs0_2014-01-26_00-32-54.mat ';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-33-13.mat  ';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs5_vs0_2014-01-26_00-33-33.mat  ';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs10_vs0_2014-01-26_00-33-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-32-16.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-32-16.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-33-13.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-33-13.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-33-13.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs-10_2014-01-26_00-34-31.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs-5_2014-01-26_00-34-50.mat ';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-35-09.mat  ';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs5_2014-01-26_00-35-29.mat  ';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs10_2014-01-26_00-35-48.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-34-11.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-34-11.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-35-09.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-35-09.mat';
                                  'Efficiency_HU42_HERMES_G250_he0_ve0_hs0_vs0_2014-01-26_00-35-09.mat']);
        end
    elseif(gap < 0.5*(27.5+ 30))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G275_he-10_ve0_hs0_vs0_2014-01-26_00-36-40.mat';
                                  'Efficiency_HU42_HERMES_G275_he-5_ve0_hs0_vs0_2014-01-26_00-36-59.mat ';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-37-19.mat  ';
                                  'Efficiency_HU42_HERMES_G275_he5_ve0_hs0_vs0_2014-01-26_00-37-38.mat  ';
                                  'Efficiency_HU42_HERMES_G275_he10_ve0_hs0_vs0_2014-01-26_00-37-57.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-36-20.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-36-20.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-37-19.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-37-19.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-37-19.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G275_he0_ve-10_hs0_vs0_2014-01-26_00-38-36.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve-5_hs0_vs0_2014-01-26_00-38-55.mat ';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-39-15.mat  ';
                                  'Efficiency_HU42_HERMES_G275_he0_ve5_hs0_vs0_2014-01-26_00-39-34.mat  ';
                                  'Efficiency_HU42_HERMES_G275_he0_ve10_hs0_vs0_2014-01-26_00-39-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-38-17.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-38-17.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-39-15.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-39-15.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-39-15.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G275_he0_ve0_hs-10_vs0_2014-01-26_00-40-32.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs-5_vs0_2014-01-26_00-40-51.mat ';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-41-10.mat  ';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs5_vs0_2014-01-26_00-41-30.mat  ';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs10_vs0_2014-01-26_00-41-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-40-13.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-40-13.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-41-10.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-41-10.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-41-10.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs-10_2014-01-26_00-42-28.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs-5_2014-01-26_00-42-47.mat ';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-43-06.mat  ';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs5_2014-01-26_00-43-25.mat  ';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs10_2014-01-26_00-43-45.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-42-08.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-42-08.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-43-06.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-43-06.mat';
                                  'Efficiency_HU42_HERMES_G275_he0_ve0_hs0_vs0_2014-01-26_00-43-06.mat']);
        end
    elseif(gap < 0.5*(30+ 35))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G300_he-10_ve0_hs0_vs0_2014-01-26_00-44-36.mat';
                                  'Efficiency_HU42_HERMES_G300_he-5_ve0_hs0_vs0_2014-01-26_00-44-55.mat ';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-45-14.mat  ';
                                  'Efficiency_HU42_HERMES_G300_he5_ve0_hs0_vs0_2014-01-26_00-45-34.mat  ';
                                  'Efficiency_HU42_HERMES_G300_he10_ve0_hs0_vs0_2014-01-26_00-45-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-44-16.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-44-16.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-45-14.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-45-14.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-45-14.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G300_he0_ve-10_hs0_vs0_2014-01-26_00-46-31.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve-5_hs0_vs0_2014-01-26_00-46-50.mat ';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-47-10.mat  ';
                                  'Efficiency_HU42_HERMES_G300_he0_ve5_hs0_vs0_2014-01-26_00-47-30.mat  ';
                                  'Efficiency_HU42_HERMES_G300_he0_ve10_hs0_vs0_2014-01-26_00-47-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-46-12.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-46-12.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-47-10.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-47-10.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-47-10.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G300_he0_ve0_hs-10_vs0_2014-01-26_00-48-28.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs-5_vs0_2014-01-26_00-48-47.mat ';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-49-06.mat  ';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs5_vs0_2014-01-26_00-49-26.mat  ';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs10_vs0_2014-01-26_00-49-45.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-48-09.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-48-09.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-49-06.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-49-06.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-49-06.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs-10_2014-01-26_00-50-23.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs-5_2014-01-26_00-50-43.mat ';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-51-03.mat  ';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs5_2014-01-26_00-51-23.mat  ';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs10_2014-01-26_00-51-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-50-04.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-50-04.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-51-03.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-51-03.mat';
                                  'Efficiency_HU42_HERMES_G300_he0_ve0_hs0_vs0_2014-01-26_00-51-03.mat']);
        end
    elseif(gap < 0.5*(35+ 40))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G350_he-10_ve0_hs0_vs0_2014-01-26_00-52-33.mat';
                                  'Efficiency_HU42_HERMES_G350_he-5_ve0_hs0_vs0_2014-01-26_00-52-53.mat ';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-53-12.mat  ';
                                  'Efficiency_HU42_HERMES_G350_he5_ve0_hs0_vs0_2014-01-26_00-53-31.mat  ';
                                  'Efficiency_HU42_HERMES_G350_he10_ve0_hs0_vs0_2014-01-26_00-53-51.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-52-14.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-52-14.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-53-12.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-53-12.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-53-12.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G350_he0_ve-10_hs0_vs0_2014-01-26_00-54-29.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve-5_hs0_vs0_2014-01-26_00-54-49.mat ';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-55-08.mat  ';
                                  'Efficiency_HU42_HERMES_G350_he0_ve5_hs0_vs0_2014-01-26_00-55-27.mat  ';
                                  'Efficiency_HU42_HERMES_G350_he0_ve10_hs0_vs0_2014-01-26_00-55-46.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-54-10.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-54-10.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-55-08.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-55-08.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-55-08.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G350_he0_ve0_hs-10_vs0_2014-01-26_00-56-25.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs-5_vs0_2014-01-26_00-56-44.mat ';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-57-03.mat  ';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs5_vs0_2014-01-26_00-57-23.mat  ';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs10_vs0_2014-01-26_00-57-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-56-05.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-56-05.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-57-03.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-57-03.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-57-03.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs-10_2014-01-26_00-58-21.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs-5_2014-01-26_00-58-40.mat ';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-58-59.mat  ';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs5_2014-01-26_00-59-18.mat  ';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs10_2014-01-26_00-59-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-58-01.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-58-01.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-58-59.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-58-59.mat';
                                  'Efficiency_HU42_HERMES_G350_he0_ve0_hs0_vs0_2014-01-26_00-58-59.mat']);
        end
    elseif(gap < 0.5*(40+ 50))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G400_he-10_ve0_hs0_vs0_2014-01-26_01-00-29.mat';
                                  'Efficiency_HU42_HERMES_G400_he-5_ve0_hs0_vs0_2014-01-26_01-00-48.mat ';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-01-07.mat  ';
                                  'Efficiency_HU42_HERMES_G400_he5_ve0_hs0_vs0_2014-01-26_01-01-27.mat  ';
                                  'Efficiency_HU42_HERMES_G400_he10_ve0_hs0_vs0_2014-01-26_01-01-46.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-00-09.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-00-09.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-01-07.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-01-07.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-01-07.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G400_he0_ve-10_hs0_vs0_2014-01-26_01-02-25.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve-5_hs0_vs0_2014-01-26_01-02-44.mat ';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-03-04.mat  ';
                                  'Efficiency_HU42_HERMES_G400_he0_ve5_hs0_vs0_2014-01-26_01-03-23.mat  ';
                                  'Efficiency_HU42_HERMES_G400_he0_ve10_hs0_vs0_2014-01-26_01-03-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-02-06.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-02-06.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-03-04.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-03-04.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-03-04.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G400_he0_ve0_hs-10_vs0_2014-01-26_01-04-21.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs-5_vs0_2014-01-26_01-04-40.mat ';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-05-00.mat  ';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs5_vs0_2014-01-26_01-05-19.mat  ';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs10_vs0_2014-01-26_01-05-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-04-02.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-04-02.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-05-00.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-05-00.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-05-00.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs-10_2014-01-26_01-06-17.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs-5_2014-01-26_01-06-36.mat ';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-06-56.mat  ';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs5_2014-01-26_01-07-15.mat  ';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs10_2014-01-26_01-07-34.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-05-58.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-05-58.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-06-56.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-06-56.mat';
                                  'Efficiency_HU42_HERMES_G400_he0_ve0_hs0_vs0_2014-01-26_01-06-56.mat']);
        end
    elseif(gap < 0.5*(50+ 60))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G500_he-10_ve0_hs0_vs0_2014-01-26_01-08-28.mat';
                                  'Efficiency_HU42_HERMES_G500_he-5_ve0_hs0_vs0_2014-01-26_01-08-48.mat ';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-09-07.mat  ';
                                  'Efficiency_HU42_HERMES_G500_he5_ve0_hs0_vs0_2014-01-26_01-09-26.mat  ';
                                  'Efficiency_HU42_HERMES_G500_he10_ve0_hs0_vs0_2014-01-26_01-09-46.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-08-09.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-08-09.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-09-07.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-09-07.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-09-07.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G500_he0_ve-10_hs0_vs0_2014-01-26_01-10-24.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve-5_hs0_vs0_2014-01-26_01-10-43.mat ';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-11-03.mat  ';
                                  'Efficiency_HU42_HERMES_G500_he0_ve5_hs0_vs0_2014-01-26_01-11-22.mat  ';
                                  'Efficiency_HU42_HERMES_G500_he0_ve10_hs0_vs0_2014-01-26_01-11-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-10-05.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-10-05.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-11-03.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-11-03.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-11-03.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G500_he0_ve0_hs-10_vs0_2014-01-26_01-12-20.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs-5_vs0_2014-01-26_01-12-40.mat ';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-12-59.mat  ';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs5_vs0_2014-01-26_01-13-18.mat  ';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs10_vs0_2014-01-26_01-13-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-12-01.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-12-01.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-12-59.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-12-59.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-12-59.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs-10_2014-01-26_01-14-17.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs-5_2014-01-26_01-14-36.mat ';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-14-55.mat  ';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs5_2014-01-26_01-15-15.mat  ';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs10_2014-01-26_01-15-34.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-13-58.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-13-58.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-14-55.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-14-55.mat';
                                  'Efficiency_HU42_HERMES_G500_he0_ve0_hs0_vs0_2014-01-26_01-14-55.mat']);
        end
    elseif(gap < 0.5*(60+ 70))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G600_he-10_ve0_hs0_vs0_2014-01-26_01-16-28.mat';
                                  'Efficiency_HU42_HERMES_G600_he-5_ve0_hs0_vs0_2014-01-26_01-16-47.mat ';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-17-06.mat  ';
                                  'Efficiency_HU42_HERMES_G600_he5_ve0_hs0_vs0_2014-01-26_01-17-26.mat  ';
                                  'Efficiency_HU42_HERMES_G600_he10_ve0_hs0_vs0_2014-01-26_01-17-45.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-16-09.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-16-09.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-17-06.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-17-06.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-17-06.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G600_he0_ve-10_hs0_vs0_2014-01-26_01-18-24.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve-5_hs0_vs0_2014-01-26_01-18-43.mat ';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-19-03.mat  ';
                                  'Efficiency_HU42_HERMES_G600_he0_ve5_hs0_vs0_2014-01-26_01-19-22.mat  ';
                                  'Efficiency_HU42_HERMES_G600_he0_ve10_hs0_vs0_2014-01-26_01-19-41.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-18-05.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-18-05.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-19-03.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-19-03.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-19-03.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G600_he0_ve0_hs-10_vs0_2014-01-26_01-20-20.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs-5_vs0_2014-01-26_01-20-39.mat ';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-20-59.mat  ';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs5_vs0_2014-01-26_01-21-18.mat  ';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs10_vs0_2014-01-26_01-21-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-20-01.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-20-01.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-20-59.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-20-59.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-20-59.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs-10_2014-01-26_01-22-16.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs-5_2014-01-26_01-22-35.mat ';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-22-54.mat  ';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs5_2014-01-26_01-23-13.mat  ';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs10_2014-01-26_01-23-33.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-21-56.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-21-56.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-22-54.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-22-54.mat';
                                  'Efficiency_HU42_HERMES_G600_he0_ve0_hs0_vs0_2014-01-26_01-22-54.mat']);
        end
    elseif(gap < 0.5*(70+ 80))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G700_he-10_ve0_hs0_vs0_2014-01-26_01-24-27.mat';
                                  'Efficiency_HU42_HERMES_G700_he-5_ve0_hs0_vs0_2014-01-26_01-24-46.mat ';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-25-06.mat  ';
                                  'Efficiency_HU42_HERMES_G700_he5_ve0_hs0_vs0_2014-01-26_01-25-25.mat  ';
                                  'Efficiency_HU42_HERMES_G700_he10_ve0_hs0_vs0_2014-01-26_01-25-45.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-24-08.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-24-08.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-25-06.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-25-06.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-25-06.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G700_he0_ve-10_hs0_vs0_2014-01-26_01-26-23.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve-5_hs0_vs0_2014-01-26_01-26-42.mat ';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-27-02.mat  ';
                                  'Efficiency_HU42_HERMES_G700_he0_ve5_hs0_vs0_2014-01-26_01-27-21.mat  ';
                                  'Efficiency_HU42_HERMES_G700_he0_ve10_hs0_vs0_2014-01-26_01-27-40.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-26-04.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-26-04.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-27-02.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-27-02.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-27-02.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G700_he0_ve0_hs-10_vs0_2014-01-26_01-28-19.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs-5_vs0_2014-01-26_01-28-38.mat ';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-28-58.mat  ';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs5_vs0_2014-01-26_01-29-17.mat  ';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs10_vs0_2014-01-26_01-29-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-28-00.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-28-00.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-28-58.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-28-58.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-28-58.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs-10_2014-01-26_01-30-15.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs-5_2014-01-26_01-30-34.mat ';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-30-54.mat  ';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs5_2014-01-26_01-31-13.mat  ';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs10_2014-01-26_01-31-32.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-29-56.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-29-56.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-30-54.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-30-54.mat';
                                  'Efficiency_HU42_HERMES_G700_he0_ve0_hs0_vs0_2014-01-26_01-30-54.mat']);
        end
    elseif(gap < 0.5*(80+ 90))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G800_he-10_ve0_hs0_vs0_2014-01-26_01-32-26.mat';
                                  'Efficiency_HU42_HERMES_G800_he-5_ve0_hs0_vs0_2014-01-26_01-32-45.mat ';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-33-05.mat  ';
                                  'Efficiency_HU42_HERMES_G800_he5_ve0_hs0_vs0_2014-01-26_01-33-24.mat  ';
                                  'Efficiency_HU42_HERMES_G800_he10_ve0_hs0_vs0_2014-01-26_01-33-43.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-32-07.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-32-07.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-33-05.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-33-05.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-33-05.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G800_he0_ve-10_hs0_vs0_2014-01-26_01-34-22.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve-5_hs0_vs0_2014-01-26_01-34-41.mat ';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-35-00.mat  ';
                                  'Efficiency_HU42_HERMES_G800_he0_ve5_hs0_vs0_2014-01-26_01-35-20.mat  ';
                                  'Efficiency_HU42_HERMES_G800_he0_ve10_hs0_vs0_2014-01-26_01-35-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-34-03.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-34-03.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-35-00.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-35-00.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-35-00.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G800_he0_ve0_hs-10_vs0_2014-01-26_01-36-18.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs-5_vs0_2014-01-26_01-36-38.mat ';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-36-57.mat  ';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs5_vs0_2014-01-26_01-37-16.mat  ';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs10_vs0_2014-01-26_01-37-36.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-35-58.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-35-58.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-36-57.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-36-57.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-36-57.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs-10_2014-01-26_01-38-14.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs-5_2014-01-26_01-38-34.mat ';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-38-53.mat  ';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs5_2014-01-26_01-39-12.mat  ';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs10_2014-01-26_01-39-31.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-37-55.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-37-55.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-38-53.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-38-53.mat';
                                  'Efficiency_HU42_HERMES_G800_he0_ve0_hs0_vs0_2014-01-26_01-38-53.mat']);
        end
    elseif(gap < 0.5*(90+ 100))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G900_he-10_ve0_hs0_vs0_2014-01-26_01-40-25.mat';
                                  'Efficiency_HU42_HERMES_G900_he-5_ve0_hs0_vs0_2014-01-26_01-40-45.mat ';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-41-04.mat  ';
                                  'Efficiency_HU42_HERMES_G900_he5_ve0_hs0_vs0_2014-01-26_01-41-23.mat  ';
                                  'Efficiency_HU42_HERMES_G900_he10_ve0_hs0_vs0_2014-01-26_01-41-43.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-40-06.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-40-06.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-41-04.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-41-04.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-41-04.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G900_he0_ve-10_hs0_vs0_2014-01-26_01-42-21.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve-5_hs0_vs0_2014-01-26_01-42-40.mat ';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-43-00.mat  ';
                                  'Efficiency_HU42_HERMES_G900_he0_ve5_hs0_vs0_2014-01-26_01-43-19.mat  ';
                                  'Efficiency_HU42_HERMES_G900_he0_ve10_hs0_vs0_2014-01-26_01-43-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-42-02.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-42-02.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-43-00.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-43-00.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-43-00.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G900_he0_ve0_hs-10_vs0_2014-01-26_01-44-17.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs-5_vs0_2014-01-26_01-44-36.mat ';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-44-56.mat  ';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs5_vs0_2014-01-26_01-45-15.mat  ';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs10_vs0_2014-01-26_01-45-34.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-43-58.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-43-58.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-44-56.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-44-56.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-44-56.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs-10_2014-01-26_01-46-13.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs-5_2014-01-26_01-46-32.mat ';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-46-51.mat  ';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs5_2014-01-26_01-47-11.mat  ';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs10_2014-01-26_01-47-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-45-53.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-45-53.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-46-51.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-46-51.mat';
                                  'Efficiency_HU42_HERMES_G900_he0_ve0_hs0_vs0_2014-01-26_01-46-51.mat']);
        end
    elseif(gap < 0.5*(100+ 110))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1000_he-10_ve0_hs0_vs0_2014-01-26_01-48-25.mat';
                                  'Efficiency_HU42_HERMES_G1000_he-5_ve0_hs0_vs0_2014-01-26_01-48-44.mat ';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-49-03.mat  ';
                                  'Efficiency_HU42_HERMES_G1000_he5_ve0_hs0_vs0_2014-01-26_01-49-23.mat  ';
                                  'Efficiency_HU42_HERMES_G1000_he10_ve0_hs0_vs0_2014-01-26_01-49-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-48-05.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-48-05.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-49-03.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-49-03.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-49-03.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1000_he0_ve-10_hs0_vs0_2014-01-26_01-50-20.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve-5_hs0_vs0_2014-01-26_01-50-40.mat ';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-50-59.mat  ';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve5_hs0_vs0_2014-01-26_01-51-18.mat  ';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve10_hs0_vs0_2014-01-26_01-51-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-50-01.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-50-01.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-50-59.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-50-59.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-50-59.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1000_he0_ve0_hs-10_vs0_2014-01-26_01-52-16.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs-5_vs0_2014-01-26_01-52-36.mat ';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-52-55.mat  ';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs5_vs0_2014-01-26_01-53-14.mat  ';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs10_vs0_2014-01-26_01-53-33.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-51-57.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-51-57.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-52-55.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-52-55.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-52-55.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs-10_2014-01-26_01-54-12.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs-5_2014-01-26_01-54-32.mat ';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-54-51.mat  ';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs5_2014-01-26_01-55-10.mat  ';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs10_2014-01-26_01-55-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-53-53.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-53-53.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-54-51.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-54-51.mat';
                                  'Efficiency_HU42_HERMES_G1000_he0_ve0_hs0_vs0_2014-01-26_01-54-51.mat']);
        end
    elseif(gap < 0.5*(110+ 130))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1100_he-10_ve0_hs0_vs0_2014-01-26_01-56-24.mat';
                                  'Efficiency_HU42_HERMES_G1100_he-5_ve0_hs0_vs0_2014-01-26_01-56-43.mat ';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-57-02.mat  ';
                                  'Efficiency_HU42_HERMES_G1100_he5_ve0_hs0_vs0_2014-01-26_01-57-22.mat  ';
                                  'Efficiency_HU42_HERMES_G1100_he10_ve0_hs0_vs0_2014-01-26_01-57-41.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-56-05.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-56-05.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-57-02.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-57-02.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-57-02.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1100_he0_ve-10_hs0_vs0_2014-01-26_01-58-21.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve-5_hs0_vs0_2014-01-26_01-58-40.mat ';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-58-59.mat  ';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve5_hs0_vs0_2014-01-26_01-59-18.mat  ';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve10_hs0_vs0_2014-01-26_01-59-38.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-58-01.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-58-01.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-58-59.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-58-59.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-58-59.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1100_he0_ve0_hs-10_vs0_2014-01-26_02-00-16.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs-5_vs0_2014-01-26_02-00-36.mat ';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_02-00-55.mat  ';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs5_vs0_2014-01-26_02-01-14.mat  ';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs10_vs0_2014-01-26_02-01-34.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-59-57.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_01-59-57.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_02-00-55.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_02-00-55.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_02-00-55.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs-10_2014-01-26_02-02-13.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs-5_2014-01-26_02-02-32.mat ';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_02-02-51.mat  ';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs5_2014-01-26_02-03-11.mat  ';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs10_2014-01-26_02-03-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_02-01-53.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_02-01-53.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_02-02-51.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_02-02-51.mat';
                                  'Efficiency_HU42_HERMES_G1100_he0_ve0_hs0_vs0_2014-01-26_02-02-51.mat']);
        end
    elseif(gap < 0.5*(130+ 150))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1300_he-10_ve0_hs0_vs0_2014-01-26_02-04-27.mat';
                                  'Efficiency_HU42_HERMES_G1300_he-5_ve0_hs0_vs0_2014-01-26_02-04-47.mat ';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-05-06.mat  ';
                                  'Efficiency_HU42_HERMES_G1300_he5_ve0_hs0_vs0_2014-01-26_02-05-25.mat  ';
                                  'Efficiency_HU42_HERMES_G1300_he10_ve0_hs0_vs0_2014-01-26_02-05-45.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-04-08.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-04-08.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-05-06.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-05-06.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-05-06.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1300_he0_ve-10_hs0_vs0_2014-01-26_02-06-23.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve-5_hs0_vs0_2014-01-26_02-06-43.mat ';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-07-02.mat  ';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve5_hs0_vs0_2014-01-26_02-07-21.mat  ';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve10_hs0_vs0_2014-01-26_02-07-41.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-06-04.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-06-04.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-07-02.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-07-02.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-07-02.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1300_he0_ve0_hs-10_vs0_2014-01-26_02-08-19.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs-5_vs0_2014-01-26_02-08-38.mat ';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-08-58.mat  ';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs5_vs0_2014-01-26_02-09-17.mat  ';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs10_vs0_2014-01-26_02-09-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-08-00.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-08-00.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-08-58.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-08-58.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-08-58.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs-10_2014-01-26_02-10-15.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs-5_2014-01-26_02-10-34.mat ';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-10-54.mat  ';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs5_2014-01-26_02-11-13.mat  ';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs10_2014-01-26_02-11-33.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-09-56.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-09-56.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-10-54.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-10-54.mat';
                                  'Efficiency_HU42_HERMES_G1300_he0_ve0_hs0_vs0_2014-01-26_02-10-54.mat']);
        end
    elseif(gap < 0.5*(150+ 175))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1500_he-10_ve0_hs0_vs0_2014-01-26_02-12-30.mat';
                                  'Efficiency_HU42_HERMES_G1500_he-5_ve0_hs0_vs0_2014-01-26_02-12-49.mat ';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-13-09.mat  ';
                                  'Efficiency_HU42_HERMES_G1500_he5_ve0_hs0_vs0_2014-01-26_02-13-28.mat  ';
                                  'Efficiency_HU42_HERMES_G1500_he10_ve0_hs0_vs0_2014-01-26_02-13-48.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-12-11.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-12-11.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-13-09.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-13-09.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-13-09.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1500_he0_ve-10_hs0_vs0_2014-01-26_02-14-27.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve-5_hs0_vs0_2014-01-26_02-14-46.mat ';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-15-05.mat  ';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve5_hs0_vs0_2014-01-26_02-15-25.mat  ';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve10_hs0_vs0_2014-01-26_02-15-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-14-07.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-14-07.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-15-05.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-15-05.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-15-05.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1500_he0_ve0_hs-10_vs0_2014-01-26_02-16-23.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs-5_vs0_2014-01-26_02-16-42.mat ';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-17-01.mat  ';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs5_vs0_2014-01-26_02-17-22.mat  ';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs10_vs0_2014-01-26_02-17-41.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-16-03.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-16-03.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-17-01.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-17-01.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-17-01.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs-10_2014-01-26_02-18-20.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs-5_2014-01-26_02-18-39.mat ';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-18-59.mat  ';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs5_2014-01-26_02-19-18.mat  ';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs10_2014-01-26_02-19-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-18-01.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-18-01.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-18-59.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-18-59.mat';
                                  'Efficiency_HU42_HERMES_G1500_he0_ve0_hs0_vs0_2014-01-26_02-18-59.mat']);
        end
    elseif(gap < 0.5*(175+ 200))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1750_he-10_ve0_hs0_vs0_2014-01-26_02-20-34.mat';
                                  'Efficiency_HU42_HERMES_G1750_he-5_ve0_hs0_vs0_2014-01-26_02-20-54.mat ';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-21-13.mat  ';
                                  'Efficiency_HU42_HERMES_G1750_he5_ve0_hs0_vs0_2014-01-26_02-21-32.mat  ';
                                  'Efficiency_HU42_HERMES_G1750_he10_ve0_hs0_vs0_2014-01-26_02-21-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-20-15.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-20-15.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-21-13.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-21-13.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-21-13.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1750_he0_ve-10_hs0_vs0_2014-01-26_02-22-32.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve-5_hs0_vs0_2014-01-26_02-22-51.mat ';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-23-10.mat  ';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve5_hs0_vs0_2014-01-26_02-23-30.mat  ';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve10_hs0_vs0_2014-01-26_02-23-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-22-12.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-22-12.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-23-10.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-23-10.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-23-10.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1750_he0_ve0_hs-10_vs0_2014-01-26_02-24-27.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs-5_vs0_2014-01-26_02-24-48.mat ';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-25-07.mat  ';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs5_vs0_2014-01-26_02-25-27.mat  ';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs10_vs0_2014-01-26_02-25-46.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-24-08.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-24-08.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-25-07.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-25-07.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-25-07.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs-10_2014-01-26_02-26-24.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs-5_2014-01-26_02-26-44.mat ';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-27-03.mat  ';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs5_2014-01-26_02-27-22.mat  ';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs10_2014-01-26_02-27-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-26-05.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-26-05.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-27-03.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-27-03.mat';
                                  'Efficiency_HU42_HERMES_G1750_he0_ve0_hs0_vs0_2014-01-26_02-27-03.mat']);
        end
    elseif(gap < 0.5*(200+ 225))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2000_he-10_ve0_hs0_vs0_2014-01-26_02-28-39.mat';
                                  'Efficiency_HU42_HERMES_G2000_he-5_ve0_hs0_vs0_2014-01-26_02-28-58.mat ';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-29-18.mat  ';
                                  'Efficiency_HU42_HERMES_G2000_he5_ve0_hs0_vs0_2014-01-26_02-29-37.mat  ';
                                  'Efficiency_HU42_HERMES_G2000_he10_ve0_hs0_vs0_2014-01-26_02-29-56.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-28-20.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-28-20.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-29-18.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-29-18.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-29-18.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2000_he0_ve-10_hs0_vs0_2014-01-26_02-30-35.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve-5_hs0_vs0_2014-01-26_02-30-54.mat ';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-31-13.mat  ';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve5_hs0_vs0_2014-01-26_02-31-32.mat  ';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve10_hs0_vs0_2014-01-26_02-31-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-30-15.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-30-15.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-31-13.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-31-13.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-31-13.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2000_he0_ve0_hs-10_vs0_2014-01-26_02-32-31.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs-5_vs0_2014-01-26_02-32-50.mat ';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-33-09.mat  ';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs5_vs0_2014-01-26_02-33-29.mat  ';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs10_vs0_2014-01-26_02-33-48.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-32-11.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-32-11.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-33-09.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-33-09.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-33-09.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs-10_2014-01-26_02-34-27.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs-5_2014-01-26_02-34-46.mat ';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-35-06.mat  ';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs5_2014-01-26_02-35-25.mat  ';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs10_2014-01-26_02-35-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-34-08.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-34-08.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-35-06.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-35-06.mat';
                                  'Efficiency_HU42_HERMES_G2000_he0_ve0_hs0_vs0_2014-01-26_02-35-06.mat']);
        end
    elseif(gap < 0.5*(225+ 240))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2250_he-10_ve0_hs0_vs0_2014-01-26_02-36-42.mat';
                                  'Efficiency_HU42_HERMES_G2250_he-5_ve0_hs0_vs0_2014-01-26_02-37-01.mat ';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-37-20.mat  ';
                                  'Efficiency_HU42_HERMES_G2250_he5_ve0_hs0_vs0_2014-01-26_02-37-40.mat  ';
                                  'Efficiency_HU42_HERMES_G2250_he10_ve0_hs0_vs0_2014-01-26_02-37-59.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-36-22.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-36-22.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-37-20.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-37-20.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-37-20.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2250_he0_ve-10_hs0_vs0_2014-01-26_02-38-38.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve-5_hs0_vs0_2014-01-26_02-38-57.mat ';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-39-16.mat  ';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve5_hs0_vs0_2014-01-26_02-39-36.mat  ';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve10_hs0_vs0_2014-01-26_02-39-55.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-38-18.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-38-18.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-39-16.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-39-16.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-39-16.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2250_he0_ve0_hs-10_vs0_2014-01-26_02-40-34.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs-5_vs0_2014-01-26_02-40-53.mat ';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-41-12.mat  ';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs5_vs0_2014-01-26_02-41-32.mat  ';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs10_vs0_2014-01-26_02-41-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-40-14.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-40-14.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-41-12.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-41-12.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-41-12.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs-10_2014-01-26_02-42-30.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs-5_2014-01-26_02-42-49.mat ';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-43-09.mat  ';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs5_2014-01-26_02-43-28.mat  ';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs10_2014-01-26_02-43-47.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-42-11.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-42-11.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-43-09.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-43-09.mat';
                                  'Efficiency_HU42_HERMES_G2250_he0_ve0_hs0_vs0_2014-01-26_02-43-09.mat']);
        end
    else	% Gap > 240

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2400_he-10_ve0_hs0_vs0_2014-01-26_02-44-42.mat';
                                  'Efficiency_HU42_HERMES_G2400_he-5_ve0_hs0_vs0_2014-01-26_02-45-01.mat ';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-45-22.mat  ';
                                  'Efficiency_HU42_HERMES_G2400_he5_ve0_hs0_vs0_2014-01-26_02-45-41.mat  ';
                                  'Efficiency_HU42_HERMES_G2400_he10_ve0_hs0_vs0_2014-01-26_02-46-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-44-22.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-44-22.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-45-22.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-45-22.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-45-22.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2400_he0_ve-10_hs0_vs0_2014-01-26_02-46-39.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve-5_hs0_vs0_2014-01-26_02-46-58.mat ';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-47-18.mat  ';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve5_hs0_vs0_2014-01-26_02-47-37.mat  ';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve10_hs0_vs0_2014-01-26_02-47-56.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-46-20.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-46-20.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-47-18.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-47-18.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-47-18.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2400_he0_ve0_hs-10_vs0_2014-01-26_02-48-35.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs-5_vs0_2014-01-26_02-48-54.mat ';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-49-13.mat  ';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs5_vs0_2014-01-26_02-49-33.mat  ';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs10_vs0_2014-01-26_02-49-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-48-15.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-48-15.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-49-13.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-49-13.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-49-13.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs-10_2014-01-26_02-50-31.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs-5_2014-01-26_02-50-50.mat ';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-51-09.mat  ';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs5_2014-01-26_02-51-29.mat  ';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs10_2014-01-26_02-51-48.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-50-11.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-50-11.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-51-09.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-51-09.mat';
                                  'Efficiency_HU42_HERMES_G2400_he0_ve0_hs0_vs0_2014-01-26_02-51-09.mat']);
        end
    end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HU64_HERMES  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(idName, 'HU64_HERMES')
    vCurVals = [-10, -5, 0, 5, 10];

    if(gap < 0.5*(15.5+ 18))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G155_he-10_ve0_hs0_vs0_2012-08-31_23-42-29.mat';
                                  'Efficiency_HU64_HERMES_G155_he-5_ve0_hs0_vs0_2012-08-31_23-42-46.mat ';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-43-02.mat  ';
                                  'Efficiency_HU64_HERMES_G155_he5_ve0_hs0_vs0_2012-08-31_23-43-18.mat  ';
                                  'Efficiency_HU64_HERMES_G155_he10_ve0_hs0_vs0_2012-08-31_23-43-34.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-42-13.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-42-13.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-43-02.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-43-02.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-43-02.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G155_he0_ve-10_hs0_vs0_2012-08-31_23-44-06.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve-5_hs0_vs0_2012-08-31_23-44-22.mat ';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-44-39.mat  ';
                                  'Efficiency_HU64_HERMES_G155_he0_ve5_hs0_vs0_2012-08-31_23-44-55.mat  ';
                                  'Efficiency_HU64_HERMES_G155_he0_ve10_hs0_vs0_2012-08-31_23-45-11.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-43-50.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-43-50.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-44-39.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-44-39.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-44-39.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G155_he0_ve0_hs-10_vs0_2012-08-31_23-45-43.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs-5_vs0_2012-08-31_23-45-59.mat ';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-46-15.mat  ';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs5_vs0_2012-08-31_23-46-32.mat  ';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs10_vs0_2012-08-31_23-46-48.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-45-27.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-45-27.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-46-15.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-46-15.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-46-15.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs-10_2012-08-31_23-47-20.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs-5_2012-08-31_23-47-36.mat ';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-47-52.mat  ';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs5_2012-08-31_23-48-08.mat  ';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs10_2012-08-31_23-48-24.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-47-04.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-47-04.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-47-52.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-47-52.mat';
                                  'Efficiency_HU64_HERMES_G155_he0_ve0_hs0_vs0_2012-08-31_23-47-52.mat']);
        end
    elseif(gap < 0.5*(18+ 20))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G180_he-10_ve0_hs0_vs0_2012-08-31_23-49-09.mat';
                                  'Efficiency_HU64_HERMES_G180_he-5_ve0_hs0_vs0_2012-08-31_23-49-25.mat ';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-49-41.mat  ';
                                  'Efficiency_HU64_HERMES_G180_he5_ve0_hs0_vs0_2012-08-31_23-49-57.mat  ';
                                  'Efficiency_HU64_HERMES_G180_he10_ve0_hs0_vs0_2012-08-31_23-50-14.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-48-53.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-48-53.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-49-41.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-49-41.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-49-41.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G180_he0_ve-10_hs0_vs0_2012-08-31_23-50-46.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve-5_hs0_vs0_2012-08-31_23-51-02.mat ';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-51-18.mat  ';
                                  'Efficiency_HU64_HERMES_G180_he0_ve5_hs0_vs0_2012-08-31_23-51-34.mat  ';
                                  'Efficiency_HU64_HERMES_G180_he0_ve10_hs0_vs0_2012-08-31_23-51-51.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-50-30.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-50-30.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-51-18.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-51-18.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-51-18.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G180_he0_ve0_hs-10_vs0_2012-08-31_23-52-23.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs-5_vs0_2012-08-31_23-52-39.mat ';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-52-55.mat  ';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs5_vs0_2012-08-31_23-53-11.mat  ';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs10_vs0_2012-08-31_23-53-27.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-52-07.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-52-07.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-52-55.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-52-55.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-52-55.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs-10_2012-08-31_23-54-00.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs-5_2012-08-31_23-54-16.mat ';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-54-32.mat  ';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs5_2012-08-31_23-54-48.mat  ';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs10_2012-08-31_23-55-04.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-53-43.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-53-43.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-54-32.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-54-32.mat';
                                  'Efficiency_HU64_HERMES_G180_he0_ve0_hs0_vs0_2012-08-31_23-54-32.mat']);
        end
    elseif(gap < 0.5*(20+ 22.5))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G200_he-10_ve0_hs0_vs0_2012-08-31_23-55-49.mat';
                                  'Efficiency_HU64_HERMES_G200_he-5_ve0_hs0_vs0_2012-08-31_23-56-05.mat ';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-56-21.mat  ';
                                  'Efficiency_HU64_HERMES_G200_he5_ve0_hs0_vs0_2012-08-31_23-56-37.mat  ';
                                  'Efficiency_HU64_HERMES_G200_he10_ve0_hs0_vs0_2012-08-31_23-56-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-55-33.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-55-33.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-56-21.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-56-21.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-56-21.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G200_he0_ve-10_hs0_vs0_2012-08-31_23-57-25.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve-5_hs0_vs0_2012-08-31_23-57-42.mat ';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-57-58.mat  ';
                                  'Efficiency_HU64_HERMES_G200_he0_ve5_hs0_vs0_2012-08-31_23-58-14.mat  ';
                                  'Efficiency_HU64_HERMES_G200_he0_ve10_hs0_vs0_2012-08-31_23-58-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-57-09.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-57-09.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-57-58.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-57-58.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-57-58.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G200_he0_ve0_hs-10_vs0_2012-08-31_23-59-02.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs-5_vs0_2012-08-31_23-59-18.mat ';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-59-35.mat  ';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs5_vs0_2012-08-31_23-59-51.mat  ';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs10_vs0_2012-09-01_00-00-07.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-58-46.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-58-46.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-59-35.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-59-35.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-08-31_23-59-35.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs-10_2012-09-01_00-00-39.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs-5_2012-09-01_00-00-55.mat ';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-09-01_00-01-11.mat  ';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs5_2012-09-01_00-01-27.mat  ';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs10_2012-09-01_00-01-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-09-01_00-00-23.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-09-01_00-00-23.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-09-01_00-01-11.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-09-01_00-01-11.mat';
                                  'Efficiency_HU64_HERMES_G200_he0_ve0_hs0_vs0_2012-09-01_00-01-11.mat']);
        end
    elseif(gap < 0.5*(22.5+ 25))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G225_he-10_ve0_hs0_vs0_2012-09-01_00-02-28.mat';
                                  'Efficiency_HU64_HERMES_G225_he-5_ve0_hs0_vs0_2012-09-01_00-02-44.mat ';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-03-00.mat  ';
                                  'Efficiency_HU64_HERMES_G225_he5_ve0_hs0_vs0_2012-09-01_00-03-16.mat  ';
                                  'Efficiency_HU64_HERMES_G225_he10_ve0_hs0_vs0_2012-09-01_00-03-33.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-02-12.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-02-12.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-03-00.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-03-00.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-03-00.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G225_he0_ve-10_hs0_vs0_2012-09-01_00-04-05.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve-5_hs0_vs0_2012-09-01_00-04-21.mat ';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-04-37.mat  ';
                                  'Efficiency_HU64_HERMES_G225_he0_ve5_hs0_vs0_2012-09-01_00-04-53.mat  ';
                                  'Efficiency_HU64_HERMES_G225_he0_ve10_hs0_vs0_2012-09-01_00-05-09.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-03-49.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-03-49.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-04-37.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-04-37.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-04-37.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G225_he0_ve0_hs-10_vs0_2012-09-01_00-05-42.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs-5_vs0_2012-09-01_00-05-58.mat ';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-06-14.mat  ';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs5_vs0_2012-09-01_00-06-30.mat  ';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs10_vs0_2012-09-01_00-06-46.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-05-25.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-05-25.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-06-14.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-06-14.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-06-14.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs-10_2012-09-01_00-07-18.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs-5_2012-09-01_00-07-34.mat ';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-07-51.mat  ';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs5_2012-09-01_00-08-07.mat  ';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs10_2012-09-01_00-08-23.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-07-02.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-07-02.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-07-51.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-07-51.mat';
                                  'Efficiency_HU64_HERMES_G225_he0_ve0_hs0_vs0_2012-09-01_00-07-51.mat']);
        end
    elseif(gap < 0.5*(25+ 27.5))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G250_he-10_ve0_hs0_vs0_2012-09-01_00-09-07.mat';
                                  'Efficiency_HU64_HERMES_G250_he-5_ve0_hs0_vs0_2012-09-01_00-09-23.mat ';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-09-40.mat  ';
                                  'Efficiency_HU64_HERMES_G250_he5_ve0_hs0_vs0_2012-09-01_00-09-56.mat  ';
                                  'Efficiency_HU64_HERMES_G250_he10_ve0_hs0_vs0_2012-09-01_00-10-12.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-08-51.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-08-51.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-09-40.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-09-40.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-09-40.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G250_he0_ve-10_hs0_vs0_2012-09-01_00-10-44.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve-5_hs0_vs0_2012-09-01_00-11-00.mat ';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-11-16.mat  ';
                                  'Efficiency_HU64_HERMES_G250_he0_ve5_hs0_vs0_2012-09-01_00-11-33.mat  ';
                                  'Efficiency_HU64_HERMES_G250_he0_ve10_hs0_vs0_2012-09-01_00-11-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-10-28.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-10-28.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-11-16.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-11-16.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-11-16.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G250_he0_ve0_hs-10_vs0_2012-09-01_00-12-21.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs-5_vs0_2012-09-01_00-12-37.mat ';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-12-53.mat  ';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs5_vs0_2012-09-01_00-13-10.mat  ';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs10_vs0_2012-09-01_00-13-26.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-12-05.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-12-05.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-12-53.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-12-53.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-12-53.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs-10_2012-09-01_00-13-58.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs-5_2012-09-01_00-14-14.mat ';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-14-30.mat  ';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs5_2012-09-01_00-14-46.mat  ';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs10_2012-09-01_00-15-03.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-13-42.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-13-42.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-14-30.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-14-30.mat';
                                  'Efficiency_HU64_HERMES_G250_he0_ve0_hs0_vs0_2012-09-01_00-14-30.mat']);
        end
    elseif(gap < 0.5*(27.5+ 30))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G275_he-10_ve0_hs0_vs0_2012-09-01_00-15-47.mat';
                                  'Efficiency_HU64_HERMES_G275_he-5_ve0_hs0_vs0_2012-09-01_00-16-03.mat ';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-16-19.mat  ';
                                  'Efficiency_HU64_HERMES_G275_he5_ve0_hs0_vs0_2012-09-01_00-16-35.mat  ';
                                  'Efficiency_HU64_HERMES_G275_he10_ve0_hs0_vs0_2012-09-01_00-16-52.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-15-31.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-15-31.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-16-19.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-16-19.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-16-19.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G275_he0_ve-10_hs0_vs0_2012-09-01_00-17-24.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve-5_hs0_vs0_2012-09-01_00-17-40.mat ';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-17-56.mat  ';
                                  'Efficiency_HU64_HERMES_G275_he0_ve5_hs0_vs0_2012-09-01_00-18-12.mat  ';
                                  'Efficiency_HU64_HERMES_G275_he0_ve10_hs0_vs0_2012-09-01_00-18-28.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-17-08.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-17-08.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-17-56.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-17-56.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-17-56.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G275_he0_ve0_hs-10_vs0_2012-09-01_00-19-01.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs-5_vs0_2012-09-01_00-19-17.mat ';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-19-33.mat  ';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs5_vs0_2012-09-01_00-19-49.mat  ';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs10_vs0_2012-09-01_00-20-05.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-18-44.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-18-44.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-19-33.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-19-33.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-19-33.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs-10_2012-09-01_00-20-39.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs-5_2012-09-01_00-20-55.mat ';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-21-11.mat  ';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs5_2012-09-01_00-21-27.mat  ';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs10_2012-09-01_00-21-43.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-20-21.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-20-21.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-21-11.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-21-11.mat';
                                  'Efficiency_HU64_HERMES_G275_he0_ve0_hs0_vs0_2012-09-01_00-21-11.mat']);
        end
    elseif(gap < 0.5*(30+ 35))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G300_he-10_ve0_hs0_vs0_2012-09-01_00-22-28.mat';
                                  'Efficiency_HU64_HERMES_G300_he-5_ve0_hs0_vs0_2012-09-01_00-22-44.mat ';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-23-00.mat  ';
                                  'Efficiency_HU64_HERMES_G300_he5_ve0_hs0_vs0_2012-09-01_00-23-16.mat  ';
                                  'Efficiency_HU64_HERMES_G300_he10_ve0_hs0_vs0_2012-09-01_00-23-32.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-22-12.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-22-12.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-23-00.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-23-00.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-23-00.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G300_he0_ve-10_hs0_vs0_2012-09-01_00-24-05.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve-5_hs0_vs0_2012-09-01_00-24-22.mat ';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-24-38.mat  ';
                                  'Efficiency_HU64_HERMES_G300_he0_ve5_hs0_vs0_2012-09-01_00-24-54.mat  ';
                                  'Efficiency_HU64_HERMES_G300_he0_ve10_hs0_vs0_2012-09-01_00-25-10.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-23-49.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-23-49.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-24-38.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-24-38.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-24-38.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G300_he0_ve0_hs-10_vs0_2012-09-01_00-25-42.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs-5_vs0_2012-09-01_00-25-58.mat ';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-26-14.mat  ';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs5_vs0_2012-09-01_00-26-31.mat  ';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs10_vs0_2012-09-01_00-26-47.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-25-26.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-25-26.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-26-14.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-26-14.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-26-14.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs-10_2012-09-01_00-27-19.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs-5_2012-09-01_00-27-35.mat ';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-27-51.mat  ';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs5_2012-09-01_00-28-07.mat  ';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs10_2012-09-01_00-28-24.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-27-03.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-27-03.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-27-51.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-27-51.mat';
                                  'Efficiency_HU64_HERMES_G300_he0_ve0_hs0_vs0_2012-09-01_00-27-51.mat']);
        end
    elseif(gap < 0.5*(35+ 40))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G350_he-10_ve0_hs0_vs0_2012-09-01_00-29-11.mat';
                                  'Efficiency_HU64_HERMES_G350_he-5_ve0_hs0_vs0_2012-09-01_00-29-27.mat ';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-29-43.mat  ';
                                  'Efficiency_HU64_HERMES_G350_he5_ve0_hs0_vs0_2012-09-01_00-30-00.mat  ';
                                  'Efficiency_HU64_HERMES_G350_he10_ve0_hs0_vs0_2012-09-01_00-30-16.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-28-55.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-28-55.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-29-43.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-29-43.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-29-43.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G350_he0_ve-10_hs0_vs0_2012-09-01_00-30-48.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve-5_hs0_vs0_2012-09-01_00-31-04.mat ';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-31-20.mat  ';
                                  'Efficiency_HU64_HERMES_G350_he0_ve5_hs0_vs0_2012-09-01_00-31-36.mat  ';
                                  'Efficiency_HU64_HERMES_G350_he0_ve10_hs0_vs0_2012-09-01_00-31-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-30-32.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-30-32.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-31-20.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-31-20.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-31-20.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G350_he0_ve0_hs-10_vs0_2012-09-01_00-32-25.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs-5_vs0_2012-09-01_00-32-41.mat ';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-32-57.mat  ';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs5_vs0_2012-09-01_00-33-13.mat  ';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs10_vs0_2012-09-01_00-33-30.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-32-09.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-32-09.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-32-57.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-32-57.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-32-57.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs-10_2012-09-01_00-34-02.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs-5_2012-09-01_00-34-18.mat ';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-34-34.mat  ';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs5_2012-09-01_00-34-50.mat  ';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs10_2012-09-01_00-35-07.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-33-46.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-33-46.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-34-34.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-34-34.mat';
                                  'Efficiency_HU64_HERMES_G350_he0_ve0_hs0_vs0_2012-09-01_00-34-34.mat']);
        end
    elseif(gap < 0.5*(40+ 50))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G400_he-10_ve0_hs0_vs0_2012-09-01_00-35-54.mat';
                                  'Efficiency_HU64_HERMES_G400_he-5_ve0_hs0_vs0_2012-09-01_00-36-10.mat ';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-36-26.mat  ';
                                  'Efficiency_HU64_HERMES_G400_he5_ve0_hs0_vs0_2012-09-01_00-36-42.mat  ';
                                  'Efficiency_HU64_HERMES_G400_he10_ve0_hs0_vs0_2012-09-01_00-36-59.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-35-38.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-35-38.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-36-26.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-36-26.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-36-26.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G400_he0_ve-10_hs0_vs0_2012-09-01_00-37-31.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve-5_hs0_vs0_2012-09-01_00-37-47.mat ';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-38-03.mat  ';
                                  'Efficiency_HU64_HERMES_G400_he0_ve5_hs0_vs0_2012-09-01_00-38-19.mat  ';
                                  'Efficiency_HU64_HERMES_G400_he0_ve10_hs0_vs0_2012-09-01_00-38-35.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-37-15.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-37-15.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-38-03.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-38-03.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-38-03.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G400_he0_ve0_hs-10_vs0_2012-09-01_00-39-08.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs-5_vs0_2012-09-01_00-39-24.mat ';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-39-40.mat  ';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs5_vs0_2012-09-01_00-39-56.mat  ';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs10_vs0_2012-09-01_00-40-12.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-38-52.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-38-52.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-39-40.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-39-40.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-39-40.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs-10_2012-09-01_00-40-44.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs-5_2012-09-01_00-41-01.mat ';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-41-17.mat  ';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs5_2012-09-01_00-41-33.mat  ';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs10_2012-09-01_00-41-49.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-40-28.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-40-28.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-41-17.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-41-17.mat';
                                  'Efficiency_HU64_HERMES_G400_he0_ve0_hs0_vs0_2012-09-01_00-41-17.mat']);
        end
    elseif(gap < 0.5*(50+ 60))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G500_he-10_ve0_hs0_vs0_2012-09-01_00-42-36.mat';
                                  'Efficiency_HU64_HERMES_G500_he-5_ve0_hs0_vs0_2012-09-01_00-42-52.mat ';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-43-09.mat  ';
                                  'Efficiency_HU64_HERMES_G500_he5_ve0_hs0_vs0_2012-09-01_00-43-25.mat  ';
                                  'Efficiency_HU64_HERMES_G500_he10_ve0_hs0_vs0_2012-09-01_00-43-41.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-42-20.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-42-20.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-43-09.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-43-09.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-43-09.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G500_he0_ve-10_hs0_vs0_2012-09-01_00-44-13.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve-5_hs0_vs0_2012-09-01_00-44-29.mat ';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-44-45.mat  ';
                                  'Efficiency_HU64_HERMES_G500_he0_ve5_hs0_vs0_2012-09-01_00-45-02.mat  ';
                                  'Efficiency_HU64_HERMES_G500_he0_ve10_hs0_vs0_2012-09-01_00-45-18.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-43-57.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-43-57.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-44-45.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-44-45.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-44-45.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G500_he0_ve0_hs-10_vs0_2012-09-01_00-45-50.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs-5_vs0_2012-09-01_00-46-06.mat ';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-46-22.mat  ';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs5_vs0_2012-09-01_00-46-38.mat  ';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs10_vs0_2012-09-01_00-46-54.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-45-34.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-45-34.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-46-22.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-46-22.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-46-22.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs-10_2012-09-01_00-47-27.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs-5_2012-09-01_00-47-43.mat ';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-47-59.mat  ';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs5_2012-09-01_00-48-15.mat  ';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs10_2012-09-01_00-48-31.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-47-11.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-47-11.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-47-59.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-47-59.mat';
                                  'Efficiency_HU64_HERMES_G500_he0_ve0_hs0_vs0_2012-09-01_00-47-59.mat']);
        end
    elseif(gap < 0.5*(60+ 70))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G600_he-10_ve0_hs0_vs0_2012-09-01_00-49-19.mat';
                                  'Efficiency_HU64_HERMES_G600_he-5_ve0_hs0_vs0_2012-09-01_00-49-35.mat ';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-49-51.mat  ';
                                  'Efficiency_HU64_HERMES_G600_he5_ve0_hs0_vs0_2012-09-01_00-50-07.mat  ';
                                  'Efficiency_HU64_HERMES_G600_he10_ve0_hs0_vs0_2012-09-01_00-50-23.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-49-03.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-49-03.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-49-51.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-49-51.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-49-51.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G600_he0_ve-10_hs0_vs0_2012-09-01_00-50-56.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve-5_hs0_vs0_2012-09-01_00-51-12.mat ';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-51-28.mat  ';
                                  'Efficiency_HU64_HERMES_G600_he0_ve5_hs0_vs0_2012-09-01_00-51-44.mat  ';
                                  'Efficiency_HU64_HERMES_G600_he0_ve10_hs0_vs0_2012-09-01_00-52-00.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-50-39.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-50-39.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-51-28.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-51-28.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-51-28.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G600_he0_ve0_hs-10_vs0_2012-09-01_00-52-32.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs-5_vs0_2012-09-01_00-52-49.mat ';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-53-05.mat  ';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs5_vs0_2012-09-01_00-53-21.mat  ';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs10_vs0_2012-09-01_00-53-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-52-16.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-52-16.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-53-05.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-53-05.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-53-05.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs-10_2012-09-01_00-54-09.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs-5_2012-09-01_00-54-25.mat ';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-54-41.mat  ';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs5_2012-09-01_00-54-58.mat  ';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs10_2012-09-01_00-55-14.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-53-53.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-53-53.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-54-41.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-54-41.mat';
                                  'Efficiency_HU64_HERMES_G600_he0_ve0_hs0_vs0_2012-09-01_00-54-41.mat']);
        end
    elseif(gap < 0.5*(70+ 80))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G700_he-10_ve0_hs0_vs0_2012-09-01_00-56-01.mat';
                                  'Efficiency_HU64_HERMES_G700_he-5_ve0_hs0_vs0_2012-09-01_00-56-17.mat ';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-56-33.mat  ';
                                  'Efficiency_HU64_HERMES_G700_he5_ve0_hs0_vs0_2012-09-01_00-56-50.mat  ';
                                  'Efficiency_HU64_HERMES_G700_he10_ve0_hs0_vs0_2012-09-01_00-57-06.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-55-45.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-55-45.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-56-33.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-56-33.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-56-33.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G700_he0_ve-10_hs0_vs0_2012-09-01_00-57-38.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve-5_hs0_vs0_2012-09-01_00-57-54.mat ';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-58-10.mat  ';
                                  'Efficiency_HU64_HERMES_G700_he0_ve5_hs0_vs0_2012-09-01_00-58-26.mat  ';
                                  'Efficiency_HU64_HERMES_G700_he0_ve10_hs0_vs0_2012-09-01_00-58-42.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-57-22.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-57-22.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-58-10.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-58-10.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-58-10.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G700_he0_ve0_hs-10_vs0_2012-09-01_00-59-15.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs-5_vs0_2012-09-01_00-59-31.mat ';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-59-47.mat  ';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs5_vs0_2012-09-01_01-00-03.mat  ';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs10_vs0_2012-09-01_01-00-19.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-58-59.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-58-59.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-59-47.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-59-47.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_00-59-47.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs-10_2012-09-01_01-00-52.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs-5_2012-09-01_01-01-08.mat ';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_01-01-24.mat  ';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs5_2012-09-01_01-01-40.mat  ';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs10_2012-09-01_01-01-56.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_01-00-35.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_01-00-35.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_01-01-24.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_01-01-24.mat';
                                  'Efficiency_HU64_HERMES_G700_he0_ve0_hs0_vs0_2012-09-01_01-01-24.mat']);
        end
    elseif(gap < 0.5*(80+ 90))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G800_he-10_ve0_hs0_vs0_2012-09-01_01-02-44.mat';
                                  'Efficiency_HU64_HERMES_G800_he-5_ve0_hs0_vs0_2012-09-01_01-03-00.mat ';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-03-16.mat  ';
                                  'Efficiency_HU64_HERMES_G800_he5_ve0_hs0_vs0_2012-09-01_01-03-32.mat  ';
                                  'Efficiency_HU64_HERMES_G800_he10_ve0_hs0_vs0_2012-09-01_01-03-48.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-02-27.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-02-27.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-03-16.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-03-16.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-03-16.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G800_he0_ve-10_hs0_vs0_2012-09-01_01-04-20.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve-5_hs0_vs0_2012-09-01_01-04-37.mat ';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-04-53.mat  ';
                                  'Efficiency_HU64_HERMES_G800_he0_ve5_hs0_vs0_2012-09-01_01-05-09.mat  ';
                                  'Efficiency_HU64_HERMES_G800_he0_ve10_hs0_vs0_2012-09-01_01-05-25.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-04-04.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-04-04.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-04-53.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-04-53.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-04-53.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G800_he0_ve0_hs-10_vs0_2012-09-01_01-05-57.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs-5_vs0_2012-09-01_01-06-13.mat ';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-06-29.mat  ';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs5_vs0_2012-09-01_01-06-46.mat  ';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs10_vs0_2012-09-01_01-07-02.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-05-41.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-05-41.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-06-29.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-06-29.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-06-29.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs-10_2012-09-01_01-07-34.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs-5_2012-09-01_01-07-50.mat ';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-08-06.mat  ';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs5_2012-09-01_01-08-22.mat  ';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs10_2012-09-01_01-08-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-07-18.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-07-18.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-08-06.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-08-06.mat';
                                  'Efficiency_HU64_HERMES_G800_he0_ve0_hs0_vs0_2012-09-01_01-08-06.mat']);
        end
    elseif(gap < 0.5*(90+ 100))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G900_he-10_ve0_hs0_vs0_2012-09-01_01-09-26.mat';
                                  'Efficiency_HU64_HERMES_G900_he-5_ve0_hs0_vs0_2012-09-01_01-09-42.mat ';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-09-58.mat  ';
                                  'Efficiency_HU64_HERMES_G900_he5_ve0_hs0_vs0_2012-09-01_01-10-14.mat  ';
                                  'Efficiency_HU64_HERMES_G900_he10_ve0_hs0_vs0_2012-09-01_01-10-31.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-09-10.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-09-10.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-09-58.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-09-58.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-09-58.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G900_he0_ve-10_hs0_vs0_2012-09-01_01-11-03.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve-5_hs0_vs0_2012-09-01_01-11-19.mat ';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-11-35.mat  ';
                                  'Efficiency_HU64_HERMES_G900_he0_ve5_hs0_vs0_2012-09-01_01-11-51.mat  ';
                                  'Efficiency_HU64_HERMES_G900_he0_ve10_hs0_vs0_2012-09-01_01-12-07.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-10-47.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-10-47.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-11-35.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-11-35.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-11-35.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G900_he0_ve0_hs-10_vs0_2012-09-01_01-12-40.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs-5_vs0_2012-09-01_01-12-56.mat ';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-13-12.mat  ';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs5_vs0_2012-09-01_01-13-28.mat  ';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs10_vs0_2012-09-01_01-13-44.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-12-24.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-12-24.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-13-12.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-13-12.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-13-12.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs-10_2012-09-01_01-14-17.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs-5_2012-09-01_01-14-33.mat ';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-14-49.mat  ';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs5_2012-09-01_01-15-05.mat  ';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs10_2012-09-01_01-15-21.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-14-00.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-14-00.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-14-49.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-14-49.mat';
                                  'Efficiency_HU64_HERMES_G900_he0_ve0_hs0_vs0_2012-09-01_01-14-49.mat']);
        end
    elseif(gap < 0.5*(100+ 125))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G1000_he-10_ve0_hs0_vs0_2012-09-01_01-16-09.mat';
                                  'Efficiency_HU64_HERMES_G1000_he-5_ve0_hs0_vs0_2012-09-01_01-16-25.mat ';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-16-41.mat  ';
                                  'Efficiency_HU64_HERMES_G1000_he5_ve0_hs0_vs0_2012-09-01_01-16-57.mat  ';
                                  'Efficiency_HU64_HERMES_G1000_he10_ve0_hs0_vs0_2012-09-01_01-17-13.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-15-52.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-15-52.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-16-41.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-16-41.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-16-41.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G1000_he0_ve-10_hs0_vs0_2012-09-01_01-17-45.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve-5_hs0_vs0_2012-09-01_01-18-02.mat ';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-18-18.mat  ';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve5_hs0_vs0_2012-09-01_01-18-34.mat  ';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve10_hs0_vs0_2012-09-01_01-18-50.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-17-29.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-17-29.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-18-18.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-18-18.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-18-18.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G1000_he0_ve0_hs-10_vs0_2012-09-01_01-19-22.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs-5_vs0_2012-09-01_01-19-38.mat ';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-19-55.mat  ';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs5_vs0_2012-09-01_01-20-11.mat  ';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs10_vs0_2012-09-01_01-20-27.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-19-06.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-19-06.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-19-55.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-19-55.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-19-55.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs-10_2012-09-01_01-20-59.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs-5_2012-09-01_01-21-15.mat ';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-21-31.mat  ';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs5_2012-09-01_01-21-48.mat  ';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs10_2012-09-01_01-22-04.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-20-43.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-20-43.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-21-31.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-21-31.mat';
                                  'Efficiency_HU64_HERMES_G1000_he0_ve0_hs0_vs0_2012-09-01_01-21-31.mat']);
        end
    elseif(gap < 0.5*(125+ 239))

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G1250_he-10_ve0_hs0_vs0_2012-09-01_01-22-57.mat';
                                  'Efficiency_HU64_HERMES_G1250_he-5_ve0_hs0_vs0_2012-09-01_01-23-13.mat ';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-23-30.mat  ';
                                  'Efficiency_HU64_HERMES_G1250_he5_ve0_hs0_vs0_2012-09-01_01-23-46.mat  ';
                                  'Efficiency_HU64_HERMES_G1250_he10_ve0_hs0_vs0_2012-09-01_01-24-02.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-22-41.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-22-41.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-23-30.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-23-30.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-23-30.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G1250_he0_ve-10_hs0_vs0_2012-09-01_01-24-34.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve-5_hs0_vs0_2012-09-01_01-24-50.mat ';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-25-06.mat  ';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve5_hs0_vs0_2012-09-01_01-25-23.mat  ';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve10_hs0_vs0_2012-09-01_01-25-39.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-24-18.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-24-18.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-25-06.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-25-06.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-25-06.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G1250_he0_ve0_hs-10_vs0_2012-09-01_01-26-11.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs-5_vs0_2012-09-01_01-26-27.mat ';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-26-43.mat  ';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs5_vs0_2012-09-01_01-27-00.mat  ';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs10_vs0_2012-09-01_01-27-16.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-25-55.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-25-55.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-26-43.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-26-43.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-26-43.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs-10_2012-09-01_01-27-48.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs-5_2012-09-01_01-28-04.mat ';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-28-20.mat  ';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs5_2012-09-01_01-28-36.mat  ';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs10_2012-09-01_01-28-53.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-27-32.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-27-32.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-28-20.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-28-20.mat';
                                  'Efficiency_HU64_HERMES_G1250_he0_ve0_hs0_vs0_2012-09-01_01-28-20.mat']);
        end
    else	% Gap > 239

        if strcmp(corName, 'CHE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G2390_he-10_ve0_hs0_vs0_2012-09-01_01-30-19.mat';
                                  'Efficiency_HU64_HERMES_G2390_he-5_ve0_hs0_vs0_2012-09-01_01-30-35.mat ';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-30-51.mat  ';
                                  'Efficiency_HU64_HERMES_G2390_he5_ve0_hs0_vs0_2012-09-01_01-31-08.mat  ';
                                  'Efficiency_HU64_HERMES_G2390_he10_ve0_hs0_vs0_2012-09-01_01-31-24.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-30-03.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-30-03.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-30-51.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-30-51.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-30-51.mat']);
        elseif strcmp(corName, 'CVE')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G2390_he0_ve-10_hs0_vs0_2012-09-01_01-31-56.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve-5_hs0_vs0_2012-09-01_01-32-12.mat ';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-32-28.mat  ';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve5_hs0_vs0_2012-09-01_01-32-44.mat  ';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve10_hs0_vs0_2012-09-01_01-33-01.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-31-40.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-31-40.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-32-28.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-32-28.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-32-28.mat']);
        elseif strcmp(corName, 'CHS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G2390_he0_ve0_hs-10_vs0_2012-09-01_01-33-33.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs-5_vs0_2012-09-01_01-33-49.mat ';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-34-05.mat  ';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs5_vs0_2012-09-01_01-34-21.mat  ';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs10_vs0_2012-09-01_01-34-37.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-33-17.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-33-17.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-34-05.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-34-05.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-34-05.mat']);
        elseif strcmp(corName, 'CVS')
            fnMeasMain = cellstr(['Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs-10_2012-09-01_01-35-10.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs-5_2012-09-01_01-35-26.mat ';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-35-42.mat  ';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs5_2012-09-01_01-35-58.mat  ';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs10_2012-09-01_01-36-14.mat ']);
            fnMeasBkgr = cellstr(['Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-34-53.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-34-53.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-35-42.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-35-42.mat';
                                  'Efficiency_HU64_HERMES_G2390_he0_ve0_hs0_vs0_2012-09-01_01-35-42.mat']);
        end

    end
end