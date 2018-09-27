function [fnMeasMain, fnMeasBkgr, vCurVals] = idReadCorElecBeamMeasData(idName, gap, corName)

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
%% IN VACUUM INSERTION DEVICES %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strncmp(idName, 'U20', 3) || strncmp(idName, 'U24', 3) || strncmp(idName, 'WSV50', 5) || strncmp(idName, 'U18', 3) || strncmp(idName, 'W164', 4)
    [fnMeasMain, fnMeasBkgr, vCurVals] = idReadCorElecBeamMeasData_InVacuumAndWigglers(idName, gap, corName);
    
%%%%%%%%%%%%%%%%%%%%%%%%
%% APPLE 2 UNDULATORS %%
%%%%%%%%%%%%%%%%%%%%%%%%

elseif strncmp(idName, 'HU80', 4) || strncmp(idName, 'HU64', 4) || strncmp(idName, 'HU60', 4) || strncmp(idName, 'HU52', 4) || strncmp(idName, 'HU44', 4) || strncmp(idName, 'HU42', 4) || strncmp(idName, 'HU36', 4)
    [fnMeasMain, fnMeasBkgr, vCurVals] = idReadCorElecBeamMeasData_Apple2(idName, gap, corName);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ELECTRO-MAGNETIC UNDULATORS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elseif strncmp(idName, 'HU256', 5) || strncmp(idName, 'HU640', 5)
    [fnMeasMain, fnMeasBkgr, vCurVals] = idReadCorElecBeamMeasData_Electromagnetic(idName, gap, corName);
end
return