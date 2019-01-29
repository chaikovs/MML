function setRFfrequency(RFvalue)
% setRFfrequency -Set RF frequency to a given value by steps of 100 Hz 
%
%  INPUTS
%  1. RFvalue input value
%
%  See Also
%  stepref, getrf, setrrf

%
% Written by Laurent S. Nadolski

RFthreshold = 1e-6; % MHz
RFstep = 50e-6; % MHz  changement le 30 aout 2009 100Hz/2s-> 50Hz/1s (meme si ça a l'air pareil..)
RFpause = 1.5; % s changement le 30 aout 2009 100Hz/2s-> 50Hz/1s

RF = getrf;
DeltaRF = RF - RFvalue;

% loop for changinf RF frequency by step of 100 Hz
while abs(DeltaRF) > RFthreshold; 
    if abs(DeltaRF) > RFstep
        DeltaRF = RFstep*sign(DeltaRF);
    end
    steprf(-DeltaRF);
    pause(RFpause);
    RF = getrf;
    DeltaRF = RF - RFvalue;
end

fprintf('RF frequency set \n');
