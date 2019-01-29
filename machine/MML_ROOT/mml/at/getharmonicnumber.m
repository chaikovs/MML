function HarmNumber = getharmonicnumber
%GETHARMONICNUMBER - Returns the harmonic number from the AT model
%  HarmonicNumber = getharmonicnumber
%
%  If there is not a cavity in the model, getharmonicnumber returns
%  HarmonicNumber = getfamilydata('HarmonicNumber');
%
%  Written by Greg Portmann


[CavityState, PassMethod, ATCavityIndex, RF, HarmNumber] = getcavity;

if isempty(HarmNumber)
    HarmNumber = getfamilydata('HarmonicNumber');

    if isempty(HarmNumber)
        % Machine   Energy   HarmonicNumber  RF Freq [MHz]
        % ALS        1.9        328          499.6403489
        % ALBA       3.0        448          499.65
        % ASP        3.0        360          499.666694585
        % CAMD       3.0         92          499.6541
        % CLS        3.0        285          500.004977352
        % Diamond    3.0        936          499.6540967
        % DSR        0.274       64          178.55
        % NSRRC      1.5        200          499.65
        % PLS        2.5        468          500.0008
        % Spear3     3.0        372          476.300005749
        % Soleil     2.7391     416          352.2
        % SPS        1.2         32          118.0006
        % SSRF       3.5        720          499.650966666
        % VUV        0.808        9           52.88
        % X-Ray      2.8         30           52.88

        if isempty(HarmNumber)
            MachineName = getfamilydata('Machine');
            if strcmpi(MachineName, 'ALS')
                HarmNumber = 328;
           elseif strcmpi(MachineName, 'ALBA')
                HarmNumber = 448;
            elseif strcmpi(MachineName, 'ASP')
                HarmNumber = 360;
            elseif strcmpi(MachineName, 'CAMD')
                HarmNumber = 92;
            elseif strcmpi(MachineName, 'CLS')
                HarmNumber = 285;
            elseif strcmpi(MachineName, 'Diamond')
                HarmNumber = 936;
            elseif strcmpi(MachineName, 'DSR')
                HarmNumber = 72;
            elseif strcmpi(MachineName, 'NSRRC')
                HarmNumber = 200;
            elseif strcmpi(MachineName, 'PLS')
                HarmNumber = 468;
            elseif strcmpi(MachineName, 'Spear3')
                HarmNumber = 372;
            elseif strcmpi(MachineName, 'Soleil')
                HarmNumber = 416;
            elseif strcmpi(MachineName, 'SPS')
                HarmNumber = 32;
            elseif strcmpi(MachineName, 'SSRF')
                HarmNumber = 720;
            elseif strcmpi(MachineName, 'VUV')
                HarmNumber = 9;
            elseif strcmpi(MachineName, 'XRAY')
                HarmNumber = 30;
            else
                error('Harmonic number unknown.  Either add an RF cavity to the AT model or add AD.HarmonicNumber to the Middle Layer.');
            end
        end
    end
end

