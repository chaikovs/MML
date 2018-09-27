function HU256_SetCorrectorsToZero()
    
    global HU256CELL;
    idDevServ=['ANS-C' num2str(HU256CELL, '%02.0f')];
    
    idDevServ1=[idDevServ '/EI/m-HU256.2_shim.1/current'];
    idDevServ2=[idDevServ '/EI/m-HU256.2_shim.2/current'];

    writeattribute([idDevServ1 '1'], 0);
    writeattribute([idDevServ1 '4'], 0);
    writeattribute([idDevServ2 '1'], 0);
    writeattribute([idDevServ2 '4'], 0);
    pause(1);