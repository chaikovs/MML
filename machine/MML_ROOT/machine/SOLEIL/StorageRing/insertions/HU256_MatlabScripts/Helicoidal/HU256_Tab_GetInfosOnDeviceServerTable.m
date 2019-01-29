function Result=HU256_Tab_GetInfosOnDeviceServerTable(HU256Cell, LinearOrHelicalOrTransition, Component, MoreInformation)
%% Infos
% Written by F.Briquez 08/10/2008
% Returns information about Device Server tables in a structure:
% - Directory if HU256Cell correctly specified
%     and / or
% - File name if other argins correctly specified

    Result=struct();

%% Directory of tables
    if (HU256Cell==4)
        Result.Directory='/usr/Local/configFiles/InsertionFFTables/ANS-C04-HU256';
    elseif (HU256Cell==12)
        Result.Directory='/usr/Local/configFiles/InsertionFFTables/ANS-C12-HU256';
    elseif (HU256Cell==15)
        Result.Directory='/usr/Local/configFiles/InsertionFFTables/ANS-C15-HU256';
    end

%% Name of table
    if (isa(LinearOrHelicalOrTransition, 'char'))
        
        if (strcmp(LinearOrHelicalOrTransition, 'Linear'))
            if (isa(Component, 'char')) % Linear => Component must be 'Bx' or 'Bz'
                
                if (isa(MoreInformation, 'numeric')||(isa(MoreInformation, 'char')&&strcmp(MoreInformation, '')))
                    if (strcmp(Component, 'Bz'))
                        Result.DeviceFileName='FF_LH';
                    elseif (strcmp(Component, 'Bx'))
                        Result.DeviceFileName='FF_LV';
                    end
                elseif ((isa(MoreInformation, 'char')&&strcmp(MoreInformation, 'Aperiodic')))
                    if (strcmp(Component, 'Bz'))
                       Result.DeviceFileName='FF_AH';
                    elseif (strcmp(Component, 'Bx'))
                        Result.DeviceFileName='FF_AV';
                    end
                end

            end
        elseif (strcmp(LinearOrHelicalOrTransition, 'Helical'))
            if (isa(MoreInformation, 'numeric')&&MoreInformation>=0)
                Result.DeviceFileName=['Table_circ_' num2str(MoreInformation)];
            elseif (isa(MoreInformation, 'char'))
                if (strcmp(MoreInformation, 'Up'))
                    Result.DeviceFileName='TableHelBx_Up';
                elseif (strcmp(MoreInformation, 'Cycles'))
                    Result.DeviceFileName='TableHelBx_Up';
                elseif (strcmp(MoreInformation, ''))
                    Result.DeviceFileName='TableHelBx';
                end
            end
        elseif (strcmp(LinearOrHelicalOrTransition, 'Transition'))
            if (isa(MoreInformation, 'char'))
                if (strcmp(MoreInformation ,'AH-LH'))
                    Result.DeviceFileName='TR_AH_LH';
                elseif (strcmp(MoreInformation ,'AV-LH'))
                    Result.DeviceFileName='TR_AV_LH';
                elseif (strcmp(MoreInformation ,'CR-LH'))
                    Result.DeviceFileName='TR_CR_LH';
                elseif (strcmp(MoreInformation ,'LH-AH'))
                    Result.DeviceFileName='TR_LH_AH';
                elseif (strcmp(MoreInformation ,'LH-AV'))
                    Result.DeviceFileName='TR_LH_AV';
                elseif (strcmp(MoreInformation ,'LH-CR'))
                    Result.DeviceFileName='TR_LH_CR';
                elseif (strcmp(MoreInformation ,'LH-LV'))
                    Result.DeviceFileName='TR_LH_LV';
                elseif (strcmp(MoreInformation ,'LV-LH'))
                    Result.DeviceFileName='TR_LV_LH';
                end
            end
        end
    end