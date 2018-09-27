function HU256_SetCorrectorsToZero()
    idDevServ1='ANS-C15/EI/m-HU256.2-shim.1/current';
    idDevServ2='ANS-C15/EI/m-HU256.2-shim.2/current';
    writeattribute([idDevServ1 '1'], 0);
    writeattribute([idDevServ1 '4'], 0);
    writeattribute([idDevServ2 '1'], 0);
    writeattribute([idDevServ2 '4'], 0);
    pause(1);