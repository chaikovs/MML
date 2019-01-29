function [CavityState, PassMethod, ATCavityIndex, RF, HarmNumber] = getcavity
%GETCAVITY - Returns the RF cavity state ('On' / 'Off')
%  [CavityState, PassMethod, ATCavityIndex, RF, HarmonicNumber] = getcavity
%
%  OUTPUTS
%  1. CavityState
%  2. PassMethod
%  3. ATCavityIndex - AT Index of the RF cavities
%  4. RF - RF frequency [Hz]
%  5. HarmonicNumber - Harmonic number
%
%  See also setcavity, setradiation
%
%  Written by Greg Portmann


global THERING

ATCavityIndex = findcells(THERING, 'Frequency');

CavityState = '';
PassMethod = '';
RF = [];
HarmNumber = [];

if isempty(ATCavityIndex)
    %disp('   No cavities were found in the lattice');
    return
end

ATCavityIndex =ATCavityIndex(:)';
for ii = ATCavityIndex(:)'
    if strcmpi(THERING{ii}.PassMethod, 'DriftPass') || strcmpi(THERING{ii}.PassMethod, 'IdentityPass')
        CavityState = strvcat(CavityState,'Off');
    else
        CavityState = strvcat(CavityState,'On');
    end
    PassMethod = strvcat(PassMethod, THERING{ii}.PassMethod);
    RF =  [RF; THERING{ii}.Frequency];
    
    if isfield(THERING{ii}, 'HarmNumber')
        HarmNumber = THERING{ii}.HarmNumber;
    end
end

ATCavityIndex = ATCavityIndex(:);


