function attributeValue=idGetUndParam(idName, attrName)

attributeValue=[];
useAppleIIDServerLevel1 = 0;

[DServName, StandByStr] = idGetUndDServer(idName);
if strcmp(DServName, '') ~= 0
    fprintf('Device Server name can not be found\n');
    return;
end

if strcmpi(attrName, 'Mode')
    TempStruct=tango_read_attribute2(DServName, 'phaseCtrlMode');
    if tango_error==-1
        fprintf('idGetUndParam : Tango error while reading mode of id ''%s''\n', idName)
        return;
    end
    TempValue=TempStruct.value(1);
    if TempValue==0
        attributeValue='ii';
    elseif TempValue==1
        attributeValue='x';
    elseif TempValue==2
        attributeValue='i2';
    elseif TempValue==3
        attributeValue='x2';
    else
        fprintf 'idGetUndParam : wrong mode number\n')
    end
    return
    
else
    if strcmpi(attrName, 'Gap')
        attrName='gap';
    elseif strcmpi(attrName, 'Phase')
        attrName='phase';
    elseif strcmpi(attrName, 'Offset')
        attrName='offset';
    end
    if ~useAppleIIDServerLevel1

        TempStruct=tango_read_attribute2(DServName, attrName);
        if tango_error==-1
            fprintf('idGetUndParam : Tango error while reading attribute ''%s'' of id ''%s''\n', attrName, idName)
            return;
        end
        attributeValue=TempStruct.value(1);

    else
        %special case: controlling via devices of Level 1
        if strcmpi(attrName, 'gap')
            attr_name_list = {'encoder1Position','encoder2Position','encoder3Position','encoder4Position'};
        elseif (strcmpi(attrName, 'phase'))
            attr_name_list = {'encoder5Position','encoder6Position'};
        end
        attr_val_list = tango_read_attributes(DServName, attr_name_list);
        if (tango_error == -1)
            fprintf('idGetUndParam : Tango error while reading attribute ''%s'' of id ''%s'' using devices of Level 1\n', attrName, idName)
            return;
        end
        
        if strcmpi(attrName, 'Gap')
            attributeValue = 0.5*(attr_val_list(1).value + attr_val_list(2).value + attr_val_list(3).value + attr_val_list(4).value);
        elseif strcmpi(attrName, 'Phase')
            attributeValue = 0.5*(abs(attr_val_list(1).value) + abs(attr_val_list(2).value))*sign(attr_val_list(1).value);
            if(sign(attr_val_list(1).value) ~= sign(attr_val_list(2).value))    %s anti-parallel mode
%                 attributeValue = param + i;   ???
            end
        end
        return
    end
end




