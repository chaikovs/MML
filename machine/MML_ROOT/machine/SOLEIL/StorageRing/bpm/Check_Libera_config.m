bpms_group=tango_group_create2('bpms');
dev_list=family2tangodev('BPMx');
for i=1:1:size(dev_list,1)
    tango_group_add(bpms_group,dev_list{i});
end
tango_group_ping(bpms_group);

SAEnabled=uint8(1);
Switches=int16(255);
SwitchingDelay=int32(0);
DSCMode=int16(2);
AGCEnabled=uint8(1);
TimePhase=int32(0);
CompensateTune=uint8(1);
ExternalSwitching=uint8(1);
OffsetTune=int32(220);
MCPLLStatus=1;
HasMAFSupport=0;
UseLiberaSAData=uint8(1);

attr_list={'SAEnabled','Switches','SwitchingDelay','DSCMode','AGCEnabled','TimePhase', ...
    'CompensateTune','ExternalSwitching','OffsetTune','UseLiberaSAData','MCPLLStatus','HasMAFSupport'};
nominal_values_array={SAEnabled Switches SwitchingDelay DSCMode AGCEnabled TimePhase ...
    CompensateTune ExternalSwitching OffsetTune UseLiberaSAData MCPLLStatus HasMAFSupport};
result=tango_group_read_attributes2(bpms_group,attr_list);

fprintf('\n');
fprintf('\n');
fprintf('***********************************************************************\n');
fprintf('Vérification de la configuration des Libéras pour les runs utilisateurs\n');
fprintf('***********************************************************************\n');

MAF_installed=0;
MC_not_locked=0;
erreurs=0;
for j=1:1:size(attr_list,2)
    for i=1:1:120
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
if erreurs==0 & MAF_installed==0 & MC_not_locked==0
    fprintf('Les Libéras sont bien configurés\n');
else
    if erreurs~=0
        fprintf('%d attributs sont mal configurés \n',erreurs);
        reply = input('voulez-vous appliquer la configuration nominale? Y/N [Y]: ', 's');
        if isempty(reply)
            reply = 'Y';
        end
        if reply == 'Y'
            for j=1:1:size(attr_list,2)-2
            tango_group_write_attribute2(bpms_group,attr_list{j},nominal_values_array{j});
            end
        end 
    end
    if MC_not_locked~=0
        fprintf('%d Libéras ne recoivent pas la Machine Clock \n',MC_not_locked);
    end
    if MAF_installed~=0
        fprintf('%d Libéras ont le filtre MAF installé ce n est pas compatible avec les runs utilisateurs \n',MC_not_locked);
    end

 end       
tango_group_kill(bpms_group)     
        