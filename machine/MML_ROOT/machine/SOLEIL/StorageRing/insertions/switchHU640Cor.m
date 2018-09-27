function switchHU640Cor(varargin)
%  SWITCHHU640COR - turn off/on the status of the H640 correctors
%
%  INPUTS
%  1. 'ON', {'OFF'}
%

%
% Written by Laurent S. Nadolski

if isempty(varargin)
    Flag = 'OFF';
else
    Flag = upper(deblank(varargin{1}));
end

if strcmp(Flag,'OFF')
    % Deactivation of the HU640 correctors
    setfamilydata(0,'HCOR', 'Status', [5 8])
    setfamilydata(0,'HCOR', 'Status', [5 9])

    setfamilydata(0,'VCOR', 'Status', [5 8])
    setfamilydata(0,'VCOR', 'Status', [5 9])
    
elseif strcmp(Flag,'ON')
    % Activation of the HU640 correctors
    setfamilydata(1,'HCOR', 'Status', [5 8])
    setfamilydata(1,'HCOR', 'Status', [5 9])

    setfamilydata(1,'VCOR', 'Status', [5 8])
    setfamilydata(1,'VCOR', 'Status', [5 9])
else
    error('Unknown Option. Action Aborted');
end
