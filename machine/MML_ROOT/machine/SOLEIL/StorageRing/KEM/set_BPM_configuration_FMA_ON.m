function set_BPM_configuration_FMA_ON
%
% 8 juillet 2008
% configure une liste de BPM pour les mesures tour par tour 
% necessaire a l'analyse en frequence
%
% RETUNE
% modifie le SWITCH
% modifie la profondeur de buffer
% mode DDenabled
% ajuste les retards fins de phase :!! a une incidence sur FOFB PENSER A REMETTRE TOUT EN ORDRE
% mode AGC off
% gain fixee de facon a� avoir 1e8 = signal somme pour 10 mA sur 95 ns
% 

%  NOTES
%  Injection in quart 2 with Linac pulse of 1.5nC 110MeV 90ns


DDFlag = 1; % for standard filter
actual_directory = pwd;
cd('/home/operateur/GrpDiagnostics/matlab/DserverBPM')

%% LISTE BPM
% liste de BPM
%devList = getBPMlist4FMA;
devList = family2tangodev('BPMx');

%% cree un tango group des BPM concernes
GroupId = tango_group_create2('BPM_FMA');
tango_group_add(GroupId,devList');
tango_group_ping(GroupId)
disp('Tango Group achieved')

%% profondeur de buffer
%Value=uint32(2000);
% Value=int32(2000);
% attribute = 'DDBufferSize';
% tango_group_write_attribute2(GroupId,attribute,Value);
% disp('DDBufferSize equal to 2000')

%% retune
h = waitbar(0,'Please wait...');
for i=1:1:size(devList,1)

    waitbar(i/size(devList,1));
    libera_ip = tango_get_property2(devList{i},'LiberaIpAddr')
    
    % fichier où l'on va ecrire l'adresse des BPM une a une
    fid=fopen('liste-IP-libera-test.txt','wt');   
    fprintf(fid,libera_ip.value{1});
    fclose(fid);
    
    % script de commande unix
    
    command='.  Retune_liste.sh liste-IP-libera-test.txt';   
    [status,result]=unix(command,'-echo');
    
    % test
    detune_index=regexp(result,' -o ');
    if isempty(detune_index)
        val_list(i,:)=[devList{i}(5:8),devList{i}(12:16),' no detuning'];
    else
        ligne=[result(detune_index+1:detune_index+5),'      '];
        val_list(i,:)=[devList{i}(5:8),devList{i}(12:16),' ',ligne];
    end
end
disp(val_list); % afficher le resultat

% C01/BPM.1 -o 0       
% C01/BPM.2 -o 0       
% C01/BPM.4 -o 0       
% C02/BPM.5 -o 0       
% C09/BPM.1 -o 0       
% C09/BPM.2 -o 0  

%% SWITCH + DD Buffer size a modifier ulterieurement en tango_group
% TODO put BPM device list as input argument
switchbpm('KEM');  % ATTENTION PERTURBATION IMPORTANTE DU FAISCEAU STOCKE

%% DD enabled
Value=uint8(1);
attribute = 'DDEnabled';
tango_group_write_attribute2(GroupId,attribute,Value);
disp('DDenabled achieved')
MeanVal = mean(tango_group_read_attribute2(GroupId, attribute));
if MeanVal ~= double(Value);
    fprintf('At least one BPM is not DD enabled \n')
end
pause(0.5)

%% AGC not enabled
Value=uint8(0);
attribute = 'AGCEnabled';
tango_group_write_attribute2(GroupId,attribute,Value);
disp('AGC off')
MeanVal = mean(tango_group_read_attribute2(GroupId, attribute));
if MeanVal ~= double(Value);
    fprintf('At least one BPM has AGC set off \n')
end
pause(0.5)

%% valeur du gain
Value=-22;
attribute = 'Gain';
tango_group_write_attribute2(GroupId,attribute,Value);
disp('Gain fixed to -22')

MeanVal = mean(tango_group_read_attribute2(GroupId, attribute));
if MeanVal ~= double(Value);
    fprintf('At least one BPM has gain different from %d \n', Value)
end
pause(0.5)

%% retard fin  a modifier ulterieurement en tango_group
if DDFlag
    cd(fullfile(getfamilydata('Directory', 'DataRoot'), filesep, 'KickerEM'));
    set_bpm_timephase;
    disp('BPM Phases tuned')
end

fprintf('Penser a remettre les phases a 0 en fin de FMA (standard pour FOFB)\n')
cd(actual_directory)

%% faire disparaitre le groupe tango
tango_group_kill(GroupId);
disp('Tango Group killed')
disp('BPM Configuration completed')
