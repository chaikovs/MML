function outStruct = idGetGeomParamForUndSOLEIL(idName)


elseif strncmp(idName, 'HU256', 5)
    outStruct.sectLenBwBPMs = 2.*3.14155; %[m] straight section length between BPMs
    outStruct.idCenPos = 0.8945; %[m] center longitudinal position of the ID with respect to the straight section center
    outStruct.idLen = 3.392; %[m] ID length
	outStruct.idKickOfst = 0; %[m] offset from ID edge to effective position of a "kick"
    if strcmp(idName, 'HU256_CASSIOPEE')
        outStruct.indUpstrBPM = 106; %absolute index of BPM at the upstream edge of the straight section where the ID is located
    elseif strcmp(idName, 'HU256_PLEIADES')
        outStruct.indUpstrBPM = 24;
    elseif strcmp(idName, 'HU256_ANTARES')
        outStruct.indUpstrBPM = 84;
    end

