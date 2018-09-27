function Alpha = getmcf(ModelString)
%GETMCF - Returns the momentum compaction factor (MCF) stored in the AD or the model
%  Alpha = getmcf               % returns getfamilydata('MCF')
%  Alpha = getmcf('Model')      % returns mcf(THERING)
%
% INPUTS
% 1. ModelString - optional 'Model' or 'Simulator' Calls modelmcf
%                - default online
%
% OUTPUTS
% 1. Alpha - Momen compaction factor
%
% NOTES
% 1. Make sure the model is up to date before calling.
%
% See Also getbrho, getenergy, modelmcf, makephysdata

%
%  Written by Gregory J. Portmann

if nargin < 1
    ModelString = '';
end

if strcmpi(ModelString,'model') | strcmpi(ModelString,'simulator')
    % Get from the model
    Alpha = modelmcf;
else
    Alpha = getfamilydata('MCF');
%     try
%         % Get from the model
%         Alpha = modelmcf;
%     catch
%         Alpha = getfamilydata('MCF');
%         fprintf('   modelmcf failing so MCF = %f (getfamilydata(''MCF'')) is being used.\n', Alpha);
%     end
end

