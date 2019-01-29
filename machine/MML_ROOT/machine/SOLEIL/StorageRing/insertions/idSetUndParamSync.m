function res = idSetUndParamSync(idName, attrName, attrValue, attrAbsTol)
    res=-1;
    res= idSetUndParamSync_old(idName, attrName, attrValue, attrAbsTol);
    if (res==-1)
        return
    end
    if (strcmp(idName, 'HU64_HERMES')&&strcmpi(attrName, 'phase'))
        res= idSetUndParamSync_old(idName, attrName, attrValue, attrAbsTol);
    end
end

function res= idSetUndParamSync_old(idName, attrName, attrValue, attrAbsTol)

    res = 0;
    %DServName = '';
    %StandByStr = ''; %String to search in the return of "Status" command of DServer
    %ActStatusStr = '';
    %attr_name_list = {''};

    numLoopsWaitRes = 300; %% valeur originale 300
    sleepTime = 3; %[s]
    sleepTimeFin = 3; % 7; %[s]
    useAppleIIDServerLevel1 = 0;
    %useModeAnti = 0; 
    %attrNameIsRecognized = 0;

    [DServName, StandByStr] = idGetUndDServer(idName);

%     if strcmp(idName, 'HU80_TEMPO')
%         %DServName = 'ANS-C08/EI/M-HU80.2'; %Name of Level 2 DServer
%         %StandByStr = 'ANS-C08/EI/M-HU80.2_MotorsControl : STANDBY'; 
% 
%         %if strcmp(attrName, 'gap')
%         %    attrNameIsRecognized = 1;
%         %elseif strcmp(attrName, 'phase')
%         %    attrNameIsRecognized = 1;
%         %end
%         %if attrNameIsRecognized == 0
%         %    fprintf('Undulator Parameter / Device Server Attribute name is not recognized\n');
%         %    res = -1; return;
%         %end
% 
%         if strcmp(attrName, 'mode')
%            attrValue = int16(attrValue);
%         end
% 
%         %Debug
%         %    attr_val_list = tango_read_attributes(DServName, attr_name_list);
%         %    if (tango_error == -1) %handle error 
%         %        tango_print_error_stack; return;
%         %    end
%         %End Debug
%     end

    if strcmp(DServName, '') ~= 0
        fprintf('Device Server name is not specified\n');
        res = -1;
        return
    end
    
    if strcmpi(attrName, 'Mode')
    Mode=idGetUndParam(idName, attrName);
        if ~strcmpi(Mode, attrValue)
            if strcmp(attrValue, 'ii')
                attrValue=0;
            elseif strcmp(attrValue, 'x')
                attrValue=1;
            elseif strcmp(attrValue, 'i2')
                attrValue=2;
            elseif strcmp(attrValue, 'x2')
                attrValue=3;
            else
                fprintf ('Wrong mode\n')
                return
            end
            attrValue=int16(attrValue);
            tango_write_attribute2(DServName, 'phaseCtrlMode', attrValue);
            if tango_error==-1
                fprintf('Problem while writing mode\n')
                res = -1;
                return
            end
            pause(sleepTime);
            res=0;
            return
        else
            res=0;
            return
        end
    end
%     TempValue=TempStruct.value;
%     TempValue=TempValue(1);  
    attr_name_val_list(1).name = attrName;
    attr_name_val_list(1).value = attrValue;
    attr_name_list = {attr_name_val_list(1).name};
    %attr_name_list_AppleIILevel1 = {'encoder1Position','encoder2Position','encoder3Position','encoder4Position'};

%     if strcmp(idName, 'HU52_DEIMOS')
%         useAppleIIDServerLevel1 = 0;
%     end

%     if useAppleIIDServerLevel1
%         %special case: controlling via DServer of Level 1
% 
%         if (strcmpi(attrName, 'gap'))
%             attr_name_list = {'encoder1Position','encoder2Position','encoder3Position','encoder4Position'};
%             tango_command_inout2(DServName, 'GotoGap', attrValue);
%         elseif (strcmpi(attrName, 'phase'))
%             attr_name_list = {'encoder5Position','encoder6Position'};
%             multMode = 1;
%             if(imag(attrValue) ~= 0)
%                 multMode = -1;
%             end
%             tango_command_inout2(DServName, 'GotoPhase', [real(attrValue), multMode*real(attrValue)]);
%         end
%     else 
         tango_write_attributes(DServName, attr_name_val_list);
%     end


    if (tango_error == -1) %handle error 
        tango_print_error_stack;

        pause(sleepTime);
        fprintf('Trying to repeat writing attributes after pause...\n');

        if useAppleIIDServerLevel1
            %special case: controlling via DServer of Level 1
            if strcmpi(attrName, 'gap')
                tango_command_inout2(DServName, 'GotoGap', attrValue);
            elseif strcmpi(attrName, 'phase')
                multMode = 1;
                if(imag(attrValue) ~= 0)
                    multMode = -1;
                end
                tango_command_inout2(DServName, 'GotoPhase', [real(attrValue), multMode*real(attrValue)]);
            end
        else 
            tango_write_attributes(DServName, attr_name_val_list);
        end

        if (tango_error == -1) %handle error 
            tango_print_error_stack;
            fprintf('Failed again. Returning from the function abnormally.\n');
            res = -1; %hoping that it could still recover
            return;
        else
            fprintf('Succeeded writing attributes from 2nd attempt. Continuing execution of the function.\n');
        end
    end

    %Waiting until the parameter is actually set
    for i = 1:numLoopsWaitRes

        attr_val_list = tango_read_attributes(DServName, attr_name_list);

        if (tango_error == -1) %handle error 
            tango_print_error_stack; 

            pause(sleepTime);
            fprintf('Trying to repeat reading attributes after pause...\n');
            attr_val_list = tango_read_attributes(DServName, attr_name_list);
            if (tango_error == -1) %handle error 
                tango_print_error_stack;
                fprintf('Failed again. Returning from the function abnormally.\n');
                res = -1; %hoping that it could still recover
                return;
            else
                fprintf('Succeeded reading attributes from 2nd attempt. Continuing execution of the function.\n');
            end
        end

        %valRequested = attr_name_val_list(1).value;
        valRequested = real(attrValue);
%         if (strcmp(idName, 'HU64_HERMES')&&strcmp(attrName, 'phase'))
%             valSet=tango_read_attribute('ANS-C10/EI/M-HU64.2', 'encoder7Position');
%             valSet=valSet.value;
%         else
            valSet = attr_val_list(1).value(1); %check why (1)
%         end
        if useAppleIIDServerLevel1
            if strcmpi(attrName, 'gap')
                valSet = 0.5*(attr_val_list(1).value + attr_val_list(2).value + attr_val_list(3).value + attr_val_list(4).value); %check
            elseif strcmpi(attrName, 'phase')
                valSet = 0.5*(abs(attr_val_list(1).value) + abs(attr_val_list(2).value))*sign(attr_val_list(1).value); %check
            end
        end

        if(abs(valRequested - valSet) <= attrAbsTol)
            %fprintf('%s',StandByStr )
            %fprintf('\n' )
            if strcmp(StandByStr, '') == 0
                % fprintf('%s', 'STANDBYSTR NON NUL') 
                attr_val_list_status = tango_read_attributes(DServName, {'Status'});
                if (tango_error == -1) %handle error 
                    tango_print_error_stack; 

                    pause(sleepTime);
                    fprintf('Trying to repeat reading attributes after pause...\n');
                    attr_val_list_status = tango_read_attributes(DServName, {'Status'});
                    if (tango_error == -1) %handle error 
                        tango_print_error_stack;
                        fprintf('Failed again. Returning from the function abnormally.\n');
                        res = -1; %hoping that it could still recover
                        return;
                    else
                        fprintf('Succeeded reading attributes from 2nd attempt. Continuing execution of the function.\n');
                    end
                end
                ActStatusStr = attr_val_list_status.value;
                %fprintf('%s %s',ActStatusStr, 'Number 2')
                cmpStatus = strfind(ActStatusStr, StandByStr);
                if (~isempty(cmpStatus))
                    pause(sleepTimeFin); %to ensure that corrector values are set
                    return; %Normal exit
                end
            else
                pause(sleepTimeFin); %to ensure that corrector values are set
                % fprintf('%s', 'STANDBYSTR NUL') 
                return; %Normal exit
            end
        end
        pause(sleepTime);
    end

    res = -1;
    fprintf('Failed to set requested Undulator Parameter value\n');
end
