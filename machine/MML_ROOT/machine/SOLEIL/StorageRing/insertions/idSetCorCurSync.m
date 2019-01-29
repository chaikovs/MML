function res = idSetCorCurSync(idName, curToSetCHE, curToSetCVE, curToSetCHS, curToSetCVS, curAbsTol)

res = 0;
DServName = '';
attr_name_list = {'', '', '', ''};

numLoopsWaitRes = 20;
sleepTime = 1; %[s]

%idDevServCor01 = '';
%idDevServCor02 = '';
%idDevServCor03 = '';
%idDevServCor04 = '';
curCh01 = 0;
curCh02 = 0;
curCh03 = 0;
curCh04 = 0;

[DServName, StandByStr] = idGetUndDServer(idName);

if strncmp(idName, 'HU80', 4) || strncmp(idName, 'HU52', 4) || strncmp(idName, 'HU44', 4)  || strncmp(idName, 'HU60', 4)|| strncmp(idName, 'HU36', 4)|| strncmp(idName, 'HU42', 4)|| strncmp(idName, 'HU64', 4)
    
%First call after turning on the correctors should be: idSetCorCurSync('HU80_TEMPO', 0., 0.1, 0, 0.1, 0.001)

%Names of Level 1 DServers of coils (no longer used)
	%idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
	%idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
	%idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
	%idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
    
%Formulae used for the Virtual Correctors:
	curCh01 = 0.5*(-curToSetCVE - curToSetCHE);
	curCh02 = 0.5*(-curToSetCVE + curToSetCHE);
	curCh03 = 0.5*(-curToSetCVS - curToSetCHS);
	curCh04 = 0.5*(-curToSetCVS + curToSetCHS);
    
    fprintf('Expected current values in primary channels: #1: %f, #2: %f, #3: %f, #4: %f\n', curCh01, curCh02, curCh03, curCh04);

    %attr_name_val_list(1).name = 'currentCHE'; attr_name_val_list(1).value = curToSetCHE;
    %attr_name_val_list(2).name = 'currentCVE'; attr_name_val_list(2).value = curToSetCVE;
    %attr_name_val_list(3).name = 'currentCHS'; attr_name_val_list(3).value = curToSetCHS;
    %attr_name_val_list(4).name = 'currentCVS'; attr_name_val_list(4).value = curToSetCVS; 
    
    
    
    attr_name_val_list(1).name = 'currentCHE'; attr_name_val_list(1).value = curToSetCHE; %curCh01; %curToSetCHE;
    attr_name_val_list(2).name = 'currentCVE'; attr_name_val_list(2).value = curToSetCVE; %curCh02; %curToSetCVE;
    attr_name_val_list(3).name = 'currentCHS'; attr_name_val_list(3).value = curToSetCHS; %curCh03; %curToSetCHS;
    attr_name_val_list(4).name = 'currentCVS'; attr_name_val_list(4).value = curToSetCVS; %curCh04; %curToSetCVS;   
  
    %if strcmp(idName, 'HU80_TEMPO')
    %    DServName = 'ANS-C08/EI/M-HU80.2'; %Name of Level 2 DServer
    %    attr_name_val_list(1).name = 'currentCHE'; attr_name_val_list(1).value = curToSetCHE;
    %    attr_name_val_list(2).name = 'currentCVE'; attr_name_val_list(2).value = curToSetCVE;
    %    attr_name_val_list(3).name = 'currentCHS'; attr_name_val_list(3).value = curToSetCHS;
    %    attr_name_val_list(4).name = 'currentCVS'; attr_name_val_list(4).value = curToSetCVS;
    %elseif strcmp(idName, 'HU80_PLEIADES')
    %    DServName = 'ANS-C04/EI/M-HU80.1'; %Name of Level 2 DServer
    %    attr_name_val_list(1).name = 'currentCHE'; attr_name_val_list(1).value = curToSetCHE;
    %    attr_name_val_list(2).name = 'currentCVE'; attr_name_val_list(2).value = curToSetCVE;
    %    attr_name_val_list(3).name = 'currentCHS'; attr_name_val_list(3).value = curToSetCHS;
    %    attr_name_val_list(4).name = 'currentCVS'; attr_name_val_list(4).value = curToSetCVS;
    %elseif strcmp(idName, 'HU80_CASSIOPEE')
    %    DServName = 'ANS-C04/EI/M-HU80.1'; %Name of Level 2 DServer
    %    attr_name_val_list(1).name = 'currentCHE'; attr_name_val_list(1).value = curToSetCHE;
    %    attr_name_val_list(2).name = 'currentCVE'; attr_name_val_list(2).value = curToSetCVE;
    %    attr_name_val_list(3).name = 'currentCHS'; attr_name_val_list(3).value = curToSetCHS;
    %    attr_name_val_list(4).name = 'currentCVS'; attr_name_val_list(4).value = curToSetCVS;        
    %end
elseif strncmp(idName, 'HU256', 5)
    attr_name_val_list(1).name = 'currentCHE'; attr_name_val_list(1).value = curToSetCHE;
    attr_name_val_list(2).name = 'currentCVE'; attr_name_val_list(2).value = curToSetCVE;
    attr_name_val_list(3).name = 'currentCHS'; attr_name_val_list(3).value = curToSetCHS;
    attr_name_val_list(4).name = 'currentCVS'; attr_name_val_list(4).value = curToSetCVS;
    numLoopsWaitRes = 60;
end
    
attr_name_list = {attr_name_val_list(1).name, attr_name_val_list(2).name, attr_name_val_list(3).name, attr_name_val_list(4).name};


%for i = 1:4
%    attr_name_list(i) = attr_name_val_list(i).name;
%end

if strcmp(DServName, '') ~= 0
    fprintf('Device Server name is not specified\n');
    res = -1;
    return;
end

% tango_write_attributes(DServName, attr_name_val_list);
for i=1:4
% i=1;
    FullAttribute=[DServName '/'  attr_name_val_list(i).name];
    Value=attr_name_val_list(i).value;
    writeattribute(FullAttribute,Value);
    % temporisation
     attr_val_list = tango_read_attributes(DServName, attr_name_list);
    if (tango_error == -1) %handle error 
        tango_print_error_stack; return;
    end
        valRequested = attr_name_val_list(i).value;
        valSet = attr_val_list(i).value(1); %check why (1)
        %if(abs(attr_name_val_list(j).value - attr_val_list(j)) > curAbsTol)
        
        % Modif FB 12/09/2016 : ça bugue sur HU256, on ne passe jamais à
        % CVE.
        % Comme je ne comprends pas l'intéret, je strappe...
        
        if(abs(valRequested - valSet) > curAbsTol)
            %canQuit = 0; break;
        end

     % rajaute par FM 9/03/14
     %%pause(1.5); %% Modified on 05/03/2011 : without it (1.5 s), sepoint is got, but current dosen't move! FB & MV
    %pause(5); %% Modified on 09/03/2014 : without it (5 s), sepoint is got, but current doesn't reach! FM
end

if (tango_error == -1) %handle error 
    tango_print_error_stack; return;
end

%Waiting until the current values are set
for i = 1:numLoopsWaitRes
    attr_val_list = tango_read_attributes(DServName, attr_name_list);
    if (tango_error == -1) %handle error 
        tango_print_error_stack; return;
    end

    canQuit = 1;
    for j = 1:4
        valRequested = attr_name_val_list(j).value;
        valSet = attr_val_list(j).value(1); %check why (1)
        %if(abs(attr_name_val_list(j).value - attr_val_list(j)) > curAbsTol)
        if(abs(valRequested - valSet) > curAbsTol)
            canQuit = 0; break;
        end
    end
  
    if(canQuit == 1)
        return; %Normal exit
    end
    pause(sleepTime);
end

res = -1;
fprintf('Failed to set requested current values\n');
