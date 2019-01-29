function outStruct = idReadUndState(inStruct, idType, dispData)

% Reading-in insertion device state, encoders positions, and current in correctors 
% according to its type
% idType is expected to be: 'HU80_TEMPO', 'U20_PROXIMA1', 'HU640_DESIRS', ...

idDevServMain01 = '';
idDevServMain02 = '';
idDevServMain03 = '';
idDevServCor01 = '';
idDevServCor02 = '';
idDevServCor03 = '';
idDevServCor04 = '';
idDevServVac01 = '';

if strncmp(idType, 'U20', 3)
    if strcmp(idType, 'U20_PROXIMA1')
        idDevServMain01 = 'ans-c10/ei/c-u20'; %to check the name
        %idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
        %idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
        %idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
        %idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
        %idDevServVac01 = 'tdl-i08-m/vi/jba.1';
    elseif strcmp(idType, 'U20_SWING')
        idDevServMain01 = 'ans-c11/ei/c-u20'; %to check the name
        %idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
        %idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
        %idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
        %idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
        %idDevServVac01 = 'tdl-i08-m/vi/jba.1';
    elseif strcmp(idType, 'U20_CRISTAL')
        idDevServMain01 = 'ans-c06/ei/c-u20'; %to check the name
        %idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
        %idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
        %idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
        %idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
        %idDevServVac01 = 'tdl-i08-m/vi/jba.1';    
    elseif strcmp(idType, 'U20_SIXS')
        idDevServMain01 = 'ans-c14/ei/c-u20'; %to check the name
        %idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
        %idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
        %idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
        %idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
        %idDevServVac01 = 'tdl-i08-m/vi/jba.1';    
    elseif strcmp(idType, 'U20_GALAXIES')
        idDevServMain01 = 'ans-c07/ei/c-u20'; %to check the name
        %idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
        %idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
        %idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
        %idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
        %idDevServVac01 = 'tdl-i08-m/vi/jba.1';    
    elseif strcmp(idType, 'U24_PXIIA')
        idDevServMain01 = 'ans-c11/ei/m-u24'; %to check the name
        %idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
        %idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
        %idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
        %idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
        %idDevServVac01 = 'tdl-i08-m/vi/jba.1';    
    elseif strcmp(idType, 'WSV50_PSICHE')
        idDevServMain01 = 'ans-c03/ei/c-wsv50'; %to check the name
        %idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
        %idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
        %idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
        %idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
        %idDevServVac01 = 'tdl-i08-m/vi/jba.1';  
        
    elseif strcmp(idType, 'U18_TOMO')
        idDevServMain01 = 'ans-c13/ei/l-U18.1'; %to check the name
        %idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
        %idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
        %idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
        %idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
        %idDevServVac01 = 'tdl-i08-m/vi/jba.1';    

    elseif strcmp(idType, 'U20_NANO')
        idDevServMain01 = 'ans-c13/ei/l-U20.2'; %to check the name
        %idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
        %idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
        %idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
        %idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
        %idDevServVac01 = 'tdl-i08-m/vi/jba.1';    
    elseif strcmp(idType, 'W164_PUMA_SLICING')
        idDevServMain01 = 'ans-c06/ei/m-W164'; %to check the name
        %idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
        %idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
        %idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
        %idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
        %idDevServVac01 = 'tdl-i08-m/vi/jba.1';  
        
        
    end
    % Gap encoders
	inStruct.encoder1 = readattribute([idDevServMain01, '/encoder1Position']);
	inStruct.encoder2 = readattribute([idDevServMain01, '/encoder2Position']);
    % Currents in the correction channels
    %inStruct.curCorCh1 = readattribute([idDevServCor, '/...']);
    %inStruct.curCorCh2 = readattribute([idDevServCor, '/...']);

elseif strncmp(idType, 'HU80', 4)
    if strcmp(idType, 'HU80_TEMPO')
        idDevServMain01 = 'ans-c08/ei/m-hu80.2';
        idDevServCor01 = 'ans-c08/ei/m-hu80.2_chan1';
        idDevServCor02 = 'ans-c08/ei/m-hu80.2_chan2';
        idDevServCor03 = 'ans-c08/ei/m-hu80.2_chan3';
        idDevServCor04 = 'ans-c08/ei/m-hu80.2_chan4';
        idDevServVac01 = 'tdl-i08-m/vi/jba.1';
    elseif strcmp(idType, 'HU80_PLEIADES')
        idDevServMain01 = 'ans-c04/ei/m-hu80.1';
        idDevServCor01 = 'ans-c04/ei/m-hu80.1_chan1';
        idDevServCor02 = 'ans-c04/ei/m-hu80.1_chan2';
        idDevServCor03 = 'ans-c04/ei/m-hu80.1_chan3';
        idDevServCor04 = 'ans-c04/ei/m-hu80.1_chan4';
        idDevServVac01 = 'ans-c04/vi/pi.02'; %to change to tdl when it' installed !!!
    elseif strcmp(idType, 'HU80_SEXTANTS')
        idDevServMain01 = 'ans-c14/ei/m-hu80.2';%'ans-c14/ei/m-hu80.1_motorscontrol';
        idDevServCor01 = 'ans-c14/ei/m-hu80.2_chan1'; %'ans-c14/ei/m-hu80.1_chan1';
        idDevServCor02 = 'ans-c14/ei/m-hu80.2_chan2'; %'ans-c14/ei/m-hu80.1_chan2';
        idDevServCor03 = 'ans-c14/ei/m-hu80.2_chan3'; %'ans-c14/ei/m-hu80.1_chan3';
        idDevServCor04 = 'ans-c14/ei/m-hu80.2_chan4'; %'ans-c14/ei/m-hu80.1_chan4';
        idDevServVac01 = 'tdl-i14-m/vi/pi.01';
    end
    
    % Gap encoders
    inStruct.idEncoder1 = readattribute([idDevServMain01, '/encoder1Position']);
    %inStruct.idEncoder1 = tango_read_attribute2(idDevServMain01, 'encoder1Position');
    inStruct.idEncoder2 = readattribute([idDevServMain01, '/encoder2Position']);
    %inStruct.idEncoder2 = tango_read_attribute2(idDevServMain01, 'encoder2Position');
    inStruct.idEncoder3 = readattribute([idDevServMain01, '/encoder3Position']);
    %inStruct.idEncoder3 = tango_read_attribute2(idDevServMain01, 'encoder3Position');
	inStruct.idEncoder4 = readattribute([idDevServMain01, '/encoder4Position']);
    %inStruct.idEncoder4 = tango_read_attribute2(idDevServMain01, 'encoder4Position');
    
    % Phase encoders
    inStruct.idEncoder5 = readattribute([idDevServMain01, '/encoder5Position']);
    %inStruct.idEncoder5 = tango_read_attribute2(idDevServMain01, 'encoder5Position');
    inStruct.idEncoder6 = readattribute([idDevServMain01, '/encoder6Position']);
    %inStruct.idEncoder6 = tango_read_attribute2(idDevServMain01, 'encoder6Position');
    
    % Currents in the correction channels
	inStruct.idCurCorCh1 = readattribute([idDevServCor01, '/current']);
	inStruct.idCurCorCh2 = readattribute([idDevServCor02, '/current']);
	inStruct.idCurCorCh3 = readattribute([idDevServCor03, '/current']);
	inStruct.idCurCorCh4 = readattribute([idDevServCor04, '/current']);
    
    % Pressure in the ring in the proximity of the SR spot made by the undulator
    inStruct.ringPres = readattribute([idDevServVac01, '/pressure']);
    
    if dispData ~= 0
        fprintf('pressure = %d\n', inStruct.ringPres);
        fprintf('idEncoder1 = %f\n', inStruct.idEncoder1);
        fprintf('idEncoder2 = %f\n', inStruct.idEncoder2);
        fprintf('idEncoder3 = %f\n', inStruct.idEncoder3);
        fprintf('idEncoder4 = %f\n', inStruct.idEncoder4);
        fprintf('idEncoder5 = %f\n', inStruct.idEncoder5);
        fprintf('idEncoder6 = %f\n', inStruct.idEncoder6);
        fprintf('idCurCorCh1 = %f\n', inStruct.idCurCorCh1);       
        fprintf('idCurCorCh2 = %f\n', inStruct.idCurCorCh2);       
        fprintf('idCurCorCh3 = %f\n', inStruct.idCurCorCh3);       
        fprintf('idCurCorCh4 = %f\n', inStruct.idCurCorCh4);       
    end
    
elseif strncmp(idType, 'HU52', 4)
    if strcmp(idType, 'HU52_DEIMOS')
        idDevServMain01 = 'ans-c07/ei/m-hu52.1';
        idDevServCor01 = 'ans-c07/ei/m-hu52.1_chan1';
        idDevServCor02 = 'ans-c07/ei/m-hu52.1_chan2';
        idDevServCor03 = 'ans-c07/ei/m-hu52.1_chan3';
        idDevServCor04 = 'ans-c07/ei/m-hu52.1_chan4';
        %idDevServVac01 = 'tdl-i07-m/vi/jba.1';
        idDevServVac01 = 'ans-c07/vi/pi.02';
    elseif strcmp(idType, 'HU52_LUCIA')
        idDevServMain01 = 'ans-c16/ei/m-hu52.1';
        idDevServCor01 = 'ans-c16/ei/m-hu52.1_chan1';
        idDevServCor02 = 'ans-c16/ei/m-hu52.1_chan2';
        idDevServCor03 = 'ans-c16/ei/m-hu52.1_chan3';
        idDevServCor04 = 'ans-c16/ei/m-hu52.1_chan4';
        idDevServVac01 = 'ans-c16/vi/pi.02'; %to change to tdl when it' installed !!!
    end
    
    % Gap encoders
    inStruct.idEncoder1 = readattribute([idDevServMain01, '/encoder1Position']);
    %inStruct.idEncoder1 = tango_read_attribute2(idDevServMain01, 'encoder1Position');
    inStruct.idEncoder2 = readattribute([idDevServMain01, '/encoder2Position']);
    %inStruct.idEncoder2 = tango_read_attribute2(idDevServMain01, 'encoder2Position');
    inStruct.idEncoder3 = readattribute([idDevServMain01, '/encoder3Position']);
    %inStruct.idEncoder3 = tango_read_attribute2(idDevServMain01, 'encoder3Position');
	inStruct.idEncoder4 = readattribute([idDevServMain01, '/encoder4Position']);
    %inStruct.idEncoder4 = tango_read_attribute2(idDevServMain01, 'encoder4Position');
    
    % Phase encoders
    inStruct.idEncoder5 = readattribute([idDevServMain01, '/encoder5Position']);
    %inStruct.idEncoder5 = tango_read_attribute2(idDevServMain01, 'encoder5Position');
    inStruct.idEncoder6 = readattribute([idDevServMain01, '/encoder6Position']);
    %inStruct.idEncoder6 = tango_read_attribute2(idDevServMain01, 'encoder6Position');
    
    % Currents in the correction channels
	inStruct.idCurCorCh1 = readattribute([idDevServCor01, '/current']);
	inStruct.idCurCorCh2 = readattribute([idDevServCor02, '/current']);
	inStruct.idCurCorCh3 = readattribute([idDevServCor03, '/current']);
	inStruct.idCurCorCh4 = readattribute([idDevServCor04, '/current']);
    
    % Pressure in the ring in the proximity of the SR spot made by the undulator
    inStruct.ringPres = readattribute([idDevServVac01, '/pressure']);
    
    if dispData ~= 0
        fprintf('pressure = %d\n', inStruct.ringPres);
        fprintf('idEncoder1 = %f\n', inStruct.idEncoder1);
        fprintf('idEncoder2 = %f\n', inStruct.idEncoder2);
        fprintf('idEncoder3 = %f\n', inStruct.idEncoder3);
        fprintf('idEncoder4 = %f\n', inStruct.idEncoder4);
        fprintf('idEncoder5 = %f\n', inStruct.idEncoder5);
        fprintf('idEncoder6 = %f\n', inStruct.idEncoder6);
        fprintf('idCurCorCh1 = %f\n', inStruct.idCurCorCh1);       
        fprintf('idCurCorCh2 = %f\n', inStruct.idCurCorCh2);       
        fprintf('idCurCorCh3 = %f\n', inStruct.idCurCorCh3);       
        fprintf('idCurCorCh4 = %f\n', inStruct.idCurCorCh4);       
    end
    
elseif strncmp(idType, 'HU44', 4)
    if strcmp(idType, 'HU44_TEMPO')
        idDevServMain01 = 'ans-c08/ei/m-hu44.1';
        idDevServCor01 = 'ans-c08/ei/m-hu44.1_chan1';
        idDevServCor02 = 'ans-c08/ei/m-hu44.1_chan2';
        idDevServCor03 = 'ans-c08/ei/m-hu44.1_chan3';
        idDevServCor04 = 'ans-c08/ei/m-hu44.1_chan4';
        idDevServVac01 = 'ans-c08/vi/pi.02';      
        %idDevServVac01 = 'ans-c04/vi/pi.02'; %change it !
    elseif strcmp(idType, 'HU44_SEXTANTS')
        idDevServMain01 = 'ans-c14/ei/m-hu44.1';
        idDevServCor01 = 'ans-c14/ei/m-hu44.1_chan1';
        idDevServCor02 = 'ans-c14/ei/m-hu44.1_chan2';
        idDevServCor03 = 'ans-c14/ei/m-hu44.1_chan3';
        idDevServCor04 = 'ans-c14/ei/m-hu44.1_chan4';
        idDevServVac01 = 'ans-c14/vi/pi.02';      % TO BE CHANGED !!!
    end
    
    % Gap encoders
    inStruct.idEncoder1 = readattribute([idDevServMain01, '/encoder1Position']);
    inStruct.idEncoder2 = readattribute([idDevServMain01, '/encoder2Position']);
    inStruct.idEncoder3 = readattribute([idDevServMain01, '/encoder3Position']);
	inStruct.idEncoder4 = readattribute([idDevServMain01, '/encoder4Position']);
    
    % Phase encoders
    inStruct.idEncoder5 = readattribute([idDevServMain01, '/encoder5Position']);
    inStruct.idEncoder6 = readattribute([idDevServMain01, '/encoder6Position']);
    
    % Currents in the correction channels
	inStruct.idCurCorCh1 = readattribute([idDevServCor01, '/current']);
	inStruct.idCurCorCh2 = readattribute([idDevServCor02, '/current']);
	inStruct.idCurCorCh3 = readattribute([idDevServCor03, '/current']);
	inStruct.idCurCorCh4 = readattribute([idDevServCor04, '/current']);
    
    % Pressure in the ring in the proximity of the SR spot made by the undulator
    inStruct.ringPres = readattribute([idDevServVac01, '/pressure']);
    
    if dispData ~= 0
        fprintf('pressure = %d\n', inStruct.ringPres);
        fprintf('idEncoder1 = %f\n', inStruct.idEncoder1);
        fprintf('idEncoder2 = %f\n', inStruct.idEncoder2);
        fprintf('idEncoder3 = %f\n', inStruct.idEncoder3);
        fprintf('idEncoder4 = %f\n', inStruct.idEncoder4);
        fprintf('idEncoder5 = %f\n', inStruct.idEncoder5);
        fprintf('idEncoder6 = %f\n', inStruct.idEncoder6);
        fprintf('idCurCorCh1 = %f\n', inStruct.idCurCorCh1);       
        fprintf('idCurCorCh2 = %f\n', inStruct.idCurCorCh2);       
        fprintf('idCurCorCh3 = %f\n', inStruct.idCurCorCh3);       
        fprintf('idCurCorCh4 = %f\n', inStruct.idCurCorCh4);       
    end
elseif strncmp(idType, 'HU60', 4)
    if strcmp(idType, 'HU60_CASSIOPEE')
        idDevServMain01 = 'ans-c15/ei/m-hu60.1';
        idDevServCor01 = 'ans-c15/ei/m-hu60.1_chan1';
        idDevServCor02 = 'ans-c15/ei/m-hu60.1_chan2';
        idDevServCor03 = 'ans-c15/ei/m-hu60.1_chan3';
        idDevServCor04 = 'ans-c15/ei/m-hu60.1_chan4';
        idDevServVac01 = 'tdl-i15-m/vi/pi.01';
    elseif strcmp(idType, 'HU60_ANTARES')
        idDevServMain01 = 'ans-c12/ei/m-hu60.1';
        idDevServCor01 = 'ans-c12/ei/m-hu60.1_chan1';
        idDevServCor02 = 'ans-c12/ei/m-hu60.1_chan2';
        idDevServCor03 = 'ans-c12/ei/m-hu60.1_chan3';
        idDevServCor04 = 'ans-c12/ei/m-hu60.1_chan4';
        idDevServVac01 = 'ans-c12/vi/pi.02'; %to change to tdl when it' installed !!!
    end
    
    % Gap encoders
    inStruct.idEncoder1 = readattribute([idDevServMain01, '/encoder1Position']);
    %inStruct.idEncoder1 = tango_read_attribute2(idDevServMain01, 'encoder1Position');
    inStruct.idEncoder2 = readattribute([idDevServMain01, '/encoder2Position']);
    %inStruct.idEncoder2 = tango_read_attribute2(idDevServMain01, 'encoder2Position');
    inStruct.idEncoder3 = readattribute([idDevServMain01, '/encoder3Position']);
    %inStruct.idEncoder3 = tango_read_attribute2(idDevServMain01, 'encoder3Position');
	inStruct.idEncoder4 = readattribute([idDevServMain01, '/encoder4Position']);
    %inStruct.idEncoder4 = tango_read_attribute2(idDevServMain01, 'encoder4Position');
    
    % Phase encoders
    inStruct.idEncoder5 = readattribute([idDevServMain01, '/encoder5Position']);
    %inStruct.idEncoder5 = tango_read_attribute2(idDevServMain01, 'encoder5Position');
    inStruct.idEncoder6 = readattribute([idDevServMain01, '/encoder6Position']);
    %inStruct.idEncoder6 = tango_read_attribute2(idDevServMain01, 'encoder6Position');
    
    % Currents in the correction channels
        inStruct.idCurCorCh1 = readattribute([idDevServCor01, '/current']);
        inStruct.idCurCorCh2 = readattribute([idDevServCor02, '/current']);
        inStruct.idCurCorCh3 = readattribute([idDevServCor03, '/current']);
        inStruct.idCurCorCh4 = readattribute([idDevServCor04, '/current']);
    
    % Pressure in the ring in the proximity of the SR spot made by the undulator
        inStruct.ringPres = readattribute([idDevServVac01, '/pressure']);
    
    if dispData ~= 0
        fprintf('pressure = %d\n', inStruct.ringPres);
        fprintf('idEncoder1 = %f\n', inStruct.idEncoder1);
        fprintf('idEncoder2 = %f\n', inStruct.idEncoder2);
        fprintf('idEncoder3 = %f\n', inStruct.idEncoder3);
        fprintf('idEncoder4 = %f\n', inStruct.idEncoder4);
        fprintf('idEncoder5 = %f\n', inStruct.idEncoder5);
        fprintf('idEncoder6 = %f\n', inStruct.idEncoder6);
        fprintf('idCurCorCh1 = %f\n', inStruct.idCurCorCh1);       
        fprintf('idCurCorCh2 = %f\n', inStruct.idCurCorCh2);       
        fprintf('idCurCorCh3 = %f\n', inStruct.idCurCorCh3);       
        fprintf('idCurCorCh4 = %f\n', inStruct.idCurCorCh4);       
    end
    
elseif strncmp(idType, 'HU36', 4)
    if strcmp(idType, 'HU36_SIRIUS')
        idDevServMain01 = 'ans-c15/ei/c-hu36';
        idDevServCor01 = 'ans-c15/ei/c-hu36_chan1';
        idDevServCor02 = 'ans-c15/ei/c-hu36_chan2';
        idDevServCor03 = 'ans-c15/ei/c-hu36_chan3';
        idDevServCor04 = 'ans-c15/ei/c-hu36_chan4';
        idDevServVac01 = 'tdl-i15-c/vi/pi.01';%to change to tdl when it' installed !!!
    end
    
    % Gap encoders
    inStruct.idEncoder1 = readattribute([idDevServMain01, '/encoder1Position']);
    %inStruct.idEncoder1 = tango_read_attribute2(idDevServMain01, 'encoder1Position');
    inStruct.idEncoder2 = readattribute([idDevServMain01, '/encoder2Position']);
    %inStruct.idEncoder2 = tango_read_attribute2(idDevServMain01, 'encoder2Position');
    inStruct.idEncoder3 = readattribute([idDevServMain01, '/encoder3Position']);
    %inStruct.idEncoder3 = tango_read_attribute2(idDevServMain01, 'encoder3Position');
	inStruct.idEncoder4 = readattribute([idDevServMain01, '/encoder4Position']);
    %inStruct.idEncoder4 = tango_read_attribute2(idDevServMain01, 'encoder4Position');
    
    % Phase encoders
    inStruct.idEncoder5 = readattribute([idDevServMain01, '/encoder5Position']);
    %inStruct.idEncoder5 = tango_read_attribute2(idDevServMain01, 'encoder5Position');
    inStruct.idEncoder6 = readattribute([idDevServMain01, '/encoder6Position']);
    %inStruct.idEncoder6 = tango_read_attribute2(idDevServMain01, 'encoder6Position');
    
    % Currents in the correction channels
        inStruct.idCurCorCh1 = readattribute([idDevServCor01, '/current']);
        inStruct.idCurCorCh2 = readattribute([idDevServCor02, '/current']);
        inStruct.idCurCorCh3 = readattribute([idDevServCor03, '/current']);
        inStruct.idCurCorCh4 = readattribute([idDevServCor04, '/current']);
    
    % Pressure in the ring in the proximity of the SR spot made by the undulator
        inStruct.ringPres = readattribute([idDevServVac01, '/pressure']);
    
    if dispData ~= 0
        fprintf('pressure = %d\n', inStruct.ringPres);
        fprintf('idEncoder1 = %f\n', inStruct.idEncoder1);
        fprintf('idEncoder2 = %f\n', inStruct.idEncoder2);
        fprintf('idEncoder3 = %f\n', inStruct.idEncoder3);
        fprintf('idEncoder4 = %f\n', inStruct.idEncoder4);
        fprintf('idEncoder5 = %f\n', inStruct.idEncoder5);
        fprintf('idEncoder6 = %f\n', inStruct.idEncoder6);
        fprintf('idCurCorCh1 = %f\n',inStruct.idCurCorCh1);       
        fprintf('idCurCorCh2 = %f\n',inStruct.idCurCorCh2);       
        fprintf('idCurCorCh3 = %f\n',inStruct.idCurCorCh3);       
        fprintf('idCurCorCh4 = %f\n',inStruct.idCurCorCh4);       
    end
 elseif strncmp(idType, 'HU42', 4)
    if strcmp(idType, 'HU42_HERMES')
        idDevServMain01 = 'ans-c10/ei/m-hu42.1';
        idDevServCor01 = 'ans-c10/ei/m-hu42.1_chan1';
        idDevServCor02 = 'ans-c10/ei/m-hu42.1_chan2';
        idDevServCor03 = 'ans-c10/ei/m-hu42.1_chan3';
        idDevServCor04 = 'ans-c10/ei/m-hu42.1_chan4';
        idDevServVac01 = 'tdl-i10-m/vi/pi.01';%to change to tdl when it' installed !!!
    end
    
    % Gap encoders
    inStruct.idEncoder1 = readattribute([idDevServMain01, '/encoder1Position']);
    inStruct.idEncoder2 = readattribute([idDevServMain01, '/encoder2Position']);
    inStruct.idEncoder3 = readattribute([idDevServMain01, '/encoder3Position']);
	inStruct.idEncoder4 = readattribute([idDevServMain01, '/encoder4Position']);
    
    % Phase encoders
    inStruct.idEncoder5 = readattribute([idDevServMain01, '/encoder5Position']);
    inStruct.idEncoder6 = readattribute([idDevServMain01, '/encoder6Position']);
    
    % Currents in the correction channels
        inStruct.idCurCorCh1 = readattribute([idDevServCor01, '/current']);
        inStruct.idCurCorCh2 = readattribute([idDevServCor02, '/current']);
        inStruct.idCurCorCh3 = readattribute([idDevServCor03, '/current']);
        inStruct.idCurCorCh4 = readattribute([idDevServCor04, '/current']);
    
    % Pressure in idReadUndStatethe ring in the proximity of the SR spot made by the undulator
        inStruct.ringPres = readattribute([idDevServVac01, '/pressure']);
    
    if dispData ~= 0
        fprintf('pressure = %d\n', inStruct.ringPres);
        fprintf('idEncoder1 = %f\n', inStruct.idEncoder1);
        fprintf('idEncoder2 = %f\n', inStruct.idEncoder2);
        fprintf('idEncoder3 = %f\n', inStruct.idEncoder3);
        fprintf('idEncoder4 = %f\n', inStruct.idEncoder4);
        fprintf('idEncoder5 = %f\n', inStruct.idEncoder5);
        fprintf('idEncoder6 = %f\n', inStruct.idEncoder6);
        fprintf('idCurCorCh1 = %f\n',inStruct.idCurCorCh1);       
        fprintf('idCurCorCh2 = %f\n',inStruct.idCurCorCh2);       
        fprintf('idCurCorCh3 = %f\n',inStruct.idCurCorCh3);       
        fprintf('idCurCorCh4 = %f\n',inStruct.idCurCorCh4);       
    end

    elseif strncmp(idType, 'HU64', 4)
    if strcmp(idType, 'HU64_HERMES')
        idDevServMain01 = 'ans-c10/ei/m-hu64.2';
        idDevServCor01 = 'ans-c10/ei/m-hu64.2_chan1';
        idDevServCor02 = 'ans-c10/ei/m-hu64.2_chan2';
        idDevServCor03 = 'ans-c10/ei/m-hu64.2_chan3';
        idDevServCor04 = 'ans-c10/ei/m-hu64.2_chan4';
        %idDevServVac01 = 'tdl-i07-m/vi/jba.1';
        idDevServVac01 = 'ans-c07/vi/pi.02';
    end
    
    % Gap encoders
    inStruct.idEncoder1 = readattribute([idDevServMain01, '/encoder1Position']);
    %inStruct.idEncoder1 = tango_read_attribute2(idDevServMain01, 'encoder1Position');
    inStruct.idEncoder2 = readattribute([idDevServMain01, '/encoder2Position']);
    %inStruct.idEncoder2 = tango_read_attribute2(idDevServMain01, 'encoder2Position');
    inStruct.idEncoder3 = readattribute([idDevServMain01, '/encoder3Position']);
    %inStruct.idEncoder3 = tango_read_attribute2(idDevServMain01, 'encoder3Position');
	inStruct.idEncoder4 = readattribute([idDevServMain01, '/encoder4Position']);
    %inStruct.idEncoder4 = tango_read_attribute2(idDevServMain01, 'encoder4Position');
    
    % Phase encoders
    inStruct.idEncoder5 = readattribute([idDevServMain01, '/encoder5Position']);
    %inStruct.idEncoder5 = tango_read_attribute2(idDevServMain01, 'encoder5Position');
    inStruct.idEncoder6 = readattribute([idDevServMain01, '/encoder6Position']);
    %inStruct.idEncoder6 = tango_read_attribute2(idDevServMain01, 'encoder6Position');
    
    % Currents in the correction channels
	inStruct.idCurCorCh1 = readattribute([idDevServCor01, '/current']);
	inStruct.idCurCorCh2 = readattribute([idDevServCor02, '/current']);
	inStruct.idCurCorCh3 = readattribute([idDevServCor03, '/current']);
	inStruct.idCurCorCh4 = readattribute([idDevServCor04, '/current']);
    
    % Pressure in the ring in the proximity of the SR spot made by the undulator
    inStruct.ringPres = readattribute([idDevServVac01, '/pressure']);
   
    
    
elseif strncmp(idType, 'HU256', 5)
    deviceName=idGetUndDServer(idType);
    idDevServMain01 = [deviceName '/currentBX1'];
	idDevServMain02 = [deviceName '/currentBX2'];
	idDevServMain03 = [deviceName '/currentBZP'];
    inStruct.BX1 = readattribute(idDevServMain01);
	inStruct.BX2= readattribute(idDevServMain02);
    inStruct.BZP= readattribute(idDevServMain03);
    
elseif strcmp(idType, 'HU640_DESIRS')
	idDevServMain01 = 'ans-c05/ei/l-hu640_ps1';
	idDevServMain02 = 'ans-c05/ei/l-hu640_ps2';
	idDevServMain03 = 'ans-c05/ei/l-hu640_ps3';

    % Currents in the main coils
	inStruct.idCurMain1 = readattribute([idDevServMain01, '/current']);
	inStruct.idCurMain2 = readattribute([idDevServMain02, '/current']);
    inStruct.idCurMain3 = readattribute([idDevServMain03, '/current']);

    if dispData ~= 0
        % Display on screen
        fprintf('RMS ecart orbite X = \n')
        fprintf('RMS ecart orbite Z = \n' )
        fprintf('PS1 = %f\n', inStruct.idCurMain1)
        fprintf('PS2 = %f\n', inStruct.idCurMain2)
        fprintf('PS3 = %f\n', inStruct.idCurMain3)
    end
end
outStruct = inStruct;