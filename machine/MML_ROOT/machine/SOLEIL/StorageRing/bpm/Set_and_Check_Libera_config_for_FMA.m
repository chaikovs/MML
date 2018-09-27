%function Set_and_Check_Libera_config_for_FMA
%
% See Also Set_and_Check_Libera_config_for_USERS

% Création d'un groupe tango
bpms_group=family2tangogroup('BPMx');

% get BPM device list 
dev_list=family2tangodev('BPMx');
for i=1:size(dev_list,1),
    tango_group_add(bpms_group,dev_list{i});
end
tango_group_ping(bpms_group);

%% liste des parametres libera
DDEnabled         = uint8(1);
Switches          = int16(3);
SwitchingDelay    = int32(0);
%%%% DSCMode=int16(0);
AGCEnabled        = uint8(0);
Gain              = -22; % 1/4 10 mA
CompensateTune    = uint8(0);
ExternalSwitching = uint8(1);
OffsetTune        = int32(0);
MCPLLStatus       = 1;
HasMAFSupport     = 0;

%%%%UseLiberaSAData=uint8(1);
FMABufferSize = int32(2000); % buffersize
%time phase
%file = 'liste_bpm_timephase.txt'; % for 120 BPM
% timephase file
file = 'liste_bpm_timephase122BPM.txt'; % November 14, 2011
file = [getfamilydata('Directory','DataRoot'), 'KickerEM/',file];
fid  = fopen(file,'r');
entete=fscanf(fid, '%s',[5]); 
name=[]; TimePhase=[];

% build TimePhase array
for i=1:length(dev_list),
    text = fscanf(fid, '%s', [3]) ;
    name = [name ; {text(1:16)}];
    TimePhase=[TimePhase ; int32(str2num(text(18:19)))];
end
fclose(fid);
%%

% lecture de la configuration actuelle des liberas
attr_list={'DDBufferSize','DDEnabled','Switches','SwitchingDelay','AGCEnabled','Gain', ...
    'CompensateTune','ExternalSwitching','OffsetTune','MCPLLStatus','HasMAFSupport'};
nominal_values_array={FMABufferSize DDEnabled Switches SwitchingDelay AGCEnabled Gain  ...
    CompensateTune ExternalSwitching OffsetTune MCPLLStatus HasMAFSupport};
result=tango_group_read_attributes2(bpms_group,attr_list);
attr_list1 = {'TimePhase'};
nominal_values_array1={TimePhase};
result1=tango_group_read_attributes2(bpms_group,attr_list1);

fprintf('\n');
fprintf('\n');
fprintf('***********************************************************************\n');
fprintf('Vérification de la configuration des Libéras pour la FMA\n');
fprintf('***********************************************************************\n');

MAF_installed=0;
MC_not_locked=0;
erreurs=0;
for j=1:1:size(attr_list,2)
    for i=1:length(dev_list),
        if result.dev_replies(i).attr_values(j).value(1)~=nominal_values_array{j}
            fprintf('L attribut %s est mal configuré sur le BPM: %s, %d au lieu de %d \n', ...
                result.dev_replies(i).attr_values(j).attr_name, ...
                result.dev_replies(i).dev_name, ...
                result.dev_replies(i).attr_values(j).value(1), ...
                nominal_values_array{j}); 
            
            if isequal(attr_list(j),{'MCPLLStatus'})
                MC_not_locked=MC_not_locked+1;
            else if isequal(attr_list(j),{'HasMAFSupport'})
                MAF_installed=MAF_installed+1;
                else
                   erreurs=erreurs+1;
                end
            end
        end
    end
end
erreur1 = 0; % test timephase
for j=1:1:size(attr_list1,2)
    for i=1:length(dev_list),

        if result.dev_replies(i).attr_values(j).value(1)~=nominal_values_array{j}
            fprintf('L attribut %s est mal configuré sur le BPM: %s, %d au lieu de %d \n', ...
                result.dev_replies(i).attr_values(j).attr_name, ...
                result.dev_replies(i).dev_name, ...
                result.dev_replies(i).attr_values(j).value(1), ...
                nominal_values_array{j}); 
            erreur1 = erreur1+1;
        end
    end
end

if erreurs==0 & MAF_installed==0 & MC_not_locked==0 & erreur1==0 
    fprintf('Les Libéras sont bien configurés\n');
else
    if erreurs~=0|erreur1~=0
        fprintf('%d attributs sont mal configurés \n',erreurs);
        reply = input('voulez-vous appliquer la configuration FMA ? Y/N [Y]: ', 's');
        if isempty(reply)
            reply = 'Y';
        end
        if reply == 'Y'
            if erreurs~=0
                for j=1:1:size(attr_list,2)-2
                    tango_group_write_attribute2(bpms_group,attr_list{j},nominal_values_array{j});
                end
            end
            if erreur1~=0  % erreur timephase
                for j=1:1:size(attr_list1,2)
                    tango_group_write_attribute2(bpms_group,attr_list1{j},nominal_values_array1{j});
                end
            end
        end
    end
    if MC_not_locked~=0
        fprintf('%d Libéras ne recoivent pas la Machine Clock \n',MC_not_locked);
    end
    if MAF_installed~=0
        fprintf('%d Libéras ont le filtre MAF installé. Ce n''est pas compatible avec le run FMA actuellement \n',MC_not_locked);
    end

 end       
%tango_group_kill(bpms_group)     
        