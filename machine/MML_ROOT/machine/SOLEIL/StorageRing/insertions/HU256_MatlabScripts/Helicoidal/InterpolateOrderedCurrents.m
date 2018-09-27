function slaveOutputCurrents=InterpolateOrderedCurrents(MainInputCurrents, SlaveInputCurrents, MainOutputCurrents)
%% Infos
    % Written by F. Briquez 15/01/2009
    % Dedicated mainly for interpolating modulation currents for HU256
    % MainInputCurrents are main currents, ordered in cycle order, with large steps (example : [0, -200, 200, 0]
    % SlaveInputCurrents are slave currents, ordered in cycle order, with large steps (example : [0.1, -0.2, 0.2, 0.1]
    % MainOutputCurrents are main currents, ordered in cycle order, with small steps (example : [0, -100, -200, 0, 100, 200, 100, 0]
    % Returns slaveOutputCurrents
%% Checking
    slaveOutputCurrents=-1;
    if (size(MainInputCurrents, 2)~=1||size(SlaveInputCurrents, 2)~=1||size(MainOutputCurrents, 2)~=1)
        fprintf('InterpolateOrderedCurrents : bad input\n')
        return
    end
    MaxMainInput=max(MainInputCurrents);
    MinMainInput=min(MainInputCurrents);
    MaxMainOutput=max(MainOutputCurrents);
    MinMainOutput=min(MainOutputCurrents);
    
    if (MaxMainInput~=MaxMainOutput||MinMainInput~=MinMainOutput)
        fprintf('InterpolateOrderedCurrents : bad input\n')
        return
    end
    InputExtremumPositions=find(MainInputCurrents==MinMainInput||MainInputCurrents==MaxMainInput)