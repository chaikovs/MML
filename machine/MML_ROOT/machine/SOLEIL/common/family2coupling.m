function [AM ErrorFlag] = family2coupling(varargin)
%FAMILY2DEVCELL - Returns the device list for a family and a cell
%  DeviceList = family2dev(FamilyName, StatusFlag)
%
%  INPUTS
%  1. Family = Family name ('BPMx', etc.)
%              Data Structure (only the FamilyName field is used)
%              Accelerator Object (only the FamilyName field is used)
%              Cell Array
%  2. DeviceList - DeviceList eg. 1, [2 3]
%  3. StatusFlag - 0 return all devices
%                  1 return only devices with good status {Default}
%
%  OUTPUTS
%  1. AM - Structure with matrix for uncoupled BPM
%                  Empty if not found
%
%  NOTES
%  1. Matrix = inv [ HBPMGain      HBPMCoupling
%                    VBPMCoupling  VBPMCoupling]
%  Data come from LOCO
%
%  2. File used is generated by loco_build_BPMmat
%
%
%  See Also dev2family, family2common, family2dev, family2handle
%          family2status, family2tol, family2units, family2tango
%          loco_build_BPMmat


%
%  Written by Laurent S. Nadolski

% TODO
% Choose other file than golden with a 'File' Flag

ErrorFlag = 0;
BPMFamily = 'BPMx';

% Load golden file
FileName      = getfamilydata('OpsData', 'BPMGainAndCouplingFile');
DirectoryName = getfamilydata('Directory', 'OpsData');
FileName      = fullfile(DirectoryName, FileName);
Data          = load(FileName);

% Return only device specified
if ~isempty(varargin)
    if isnumeric(varargin{1})
        DeviceList = varargin{1};
    elseif isfamily(varargin{1})
        BPMFamily = varargin{1};
        if length(varargin) >= 2
            DeviceList = varargin{2};
        else
            DeviceList = family2dev(BPMFamily);
        end        
    end
else % take all the BPM
    DeviceList = family2dev(BPMFamily);
end

Cinv = cell(1, size(DeviceList,1));

[iFound iNotFound] = findrowindex(DeviceList, Data.AM.DeviceList);

[AM.Cinv] = Data.AM.Cinv(iFound);

if ~isempty(iNotFound)
    % warning message + ones
    for ik=1:length(iNotFound),
        fprintf('family2coupling: BPM [%d %d] not found Gain set to unity & coupling set to zero\n', DeviceList(iNotFound(ik),:))
        if iNotFound(ik) == 1 %first element
            AM.Cinv = [[1 0; 0 1]; AM.Cinv(:)];
        elseif iNotFound(ik) < size(DeviceList,1)
            AM.Cinv = [AM.Cinv(1:iNotFound(ik)-1); [1 0; 0 1]; AM.Cinv(iNotFound(ik):end)];
        else % last element
            AM.Cinv = [AM.Cinv(:); [1 0; 0 1]];
        end
    end
    ErrorFlag = 1;
end
    
