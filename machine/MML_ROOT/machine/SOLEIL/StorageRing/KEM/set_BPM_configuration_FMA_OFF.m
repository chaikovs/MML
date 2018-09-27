function set_BPM_configuration_FMA_OFF
%
% 8 juillet 2008
% retour à la configuration standard des BPM pour les mesures tour par tour 
% 
%
% DETUNE
% modifie le SWITCH (255)
% modifie la profondeur de buffer (1024)
% 
% ajuste les retards fins de phase à 0 :!! a une incidence sur FOFB 
% mode AGC on
% 

DDFlag = 1; % for standard filter
actual_directory = pwd;
cd('/home/diag/diag/Matlab/DserverBPM')

%% LISTE BPM
% liste de BPM
%devList = getBPMlist4FMA;
devList = family2tangodev('BPMx');

%% cree un tango group des BPM concernés
GroupId = tango_group_create2('BPM_FMA');
tango_group_add(GroupId,devList');
pause(0.5)
disp('Tango Group achieved')

%% profondeur de buffer par défaut (celle inscrite sur la propriete DefaultDDBufferSize)
res = tango_get_property2('ANS-C01/DG/BPM.1','DefaultDDBufferSize');
Value = res.value;
attribute = 'DDBufferSize';
tango_group_write_attribute2(GroupId,attribute,int32(str2num(Value{:})));
disp('DDBufferSize equal to default value (=1026)')

%% detune
h = waitbar(0,'Please wait...');
for i=1:1:size(devList,1)

    waitbar(i/size(devList,1));
    %%%libera_ip=tango_get_property2(devList(i,:),'LiberaIpAddr')
    libera_ip=tango_get_property2(devList{i},'LiberaIpAddr')

    
    % fichier où l'on va écrire l'adresse des BPM une à une
    %%%fid=fopen('/home/diag/diag/Matlab/DserverBPM/liste-IP-libera-test.txt','wt');   
    fid=fopen('liste-IP-libera-test.txt','wt');   

    fprintf(fid,libera_ip.value{1});
    fclose(fid);
    
    % script de commande unix
    %%%command='./home/diag/diag/Matlab/DserverBPM/Detune_liste.sh liste-IP-libera-test.txt';   
    command='. Detune_liste.sh liste-IP-libera-test.txt';   

    [status,result]=unix(command,'-echo');
    
    % test
    detune_index=regexp(result,' -o ');
    if isempty(detune_index)
        %%%val_list(i,:)=[devList(i,5:8),devList(i,12:16),' no detuning'];
        val_list(i,:)=[devList{i}(5:8),devList{i}(12:16),' no detuning'];

    else
        ligne=[result(detune_index+1:detune_index+5),'      '];
        %%%val_list(i,:)=[devList(i,5:8),devList(i,12:16),' ',ligne];
        val_list(i,:)=[devList{i}(5:8),devList{i}(12:16),' ',ligne];

    end
end
pause(0.5)
disp(val_list); % afficher le résultat valeur = 220

%% SWITCH + DD Buffer size à modifier ultérieurement en tango_group
switchbpm('Injection');  % ATTENTION PERTURBATION IMPORTANTE DU FAISCEAU STOCKE
pause(0.5)

%% AGC enabled
Value=uint8(1);
attribute = 'AGCEnabled';
tango_group_write_attribute(GroupId,attribute,1,Value);
disp('AGC on')
pause(0.5)
MeanVal = mean(tango_group_read_attribute2(GroupId, attribute));
if MeanVal ~= double(Value);
    fprintf('At least one BPM has AGC set on \n')
end

%% mettre les phases à 0 en fin de FMA (standard pour FOFB)
if DDFlag
    cd(fullfile(getfamilydata('Directory', 'DataRoot'), filesep, 'KickerEM'));
    reset_bpm_timephase
    disp('BPM Phases tuned to 0')
end

cd(actual_directory)
pause(0.5)

%% faire disparaitre le groupe tango
tango_group_kill(GroupId);
pause(0.5)
disp('Tango Group killed')
disp('BPM Configuration completed')


% libera_ip = 
% 
%      name: 'LiberaIpAddr'
%     value: {'172.17.15.54'}
% 
% ./Detune_liste.sh: line 2: [[: liste-IP-libera-test.txt: syntax error in expression (error token is ".txt")
% Pseudo-terminal will not be allocated because stdin is not a terminal.
% 
% stdin: is not a tty
% kill: usage: kill [-s sigspec | -n signum | -sigspec] [pid | job]... or kill -l [sigspec]
% /opt/bin/lmtd: invalid option -- f

