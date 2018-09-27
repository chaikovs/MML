function outStruct = idGetGeomParamForUndSOLEIL(idName)
%Alias of idGetParamForUndSOLEIL;

% outStruct.sectLenBwBPMs = 2.*3.14155; %[m] straight section length between BPMs
% outStruct.idCenPos = 1.333; %[m] center longitudinal position of the ID with respect to the straight section center
% outStruct.idLen = 1.8; %[m] ID length
% outStruct.idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
% outStruct.indUpstrBPM = dev2elem('BPMx', [8 1]); %absolute index of BPM at the upstream edge of the straight section where the ID is located
% outStruct.indRelBPMs = [8 1;8 2]; %relative indexes of upstream and downstream BPMs of the straight section where the ID is located

%
%% Written by A.Bence


    res=idGetParamForUndSOLEIL(idName);
    
    outStruct.idCenPos = res.idCenPos; %[m] center longitudinal position of the ID with respect to the straight section center
    outStruct.idLen = res.idLen; %[m] ID length
    outStruct.idKickOfst = res.idKickOfst; %[m] offset from ID edge to effective position of a "kick"
    outStruct.indRelBPMs = res.indRelBPMs;
    outStruct.sectLenBwBPMs = res.sectLenBwBPMs; %[m] straight section length between BPMs
    outStruct.indUpstrBPM = res.indUpstrBPM; % absolute index of BPM at the upstream edge of the straight section where the ID is located
