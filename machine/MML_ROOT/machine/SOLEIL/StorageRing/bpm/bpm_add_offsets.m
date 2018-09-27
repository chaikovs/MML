function [AM, tout, DataTime, ErrorFlag] = bpm_add_offsets( X_raw , Z_raw , DeviceList , OffsetStructure , DataType )
%BPM_ADD_OFFSETS Add BPMs offsets into signals, according to TANGO device
%
%  [AM, tout, DataTime, ErrorFlag] = bpm_add_offsets(  X_raw , Z_raw , DeviceList , OffsetStructure , DataType )
%
%  INPUTS
%  1. X_raw , can be a vector (closed orbit : SA) or a matrix (turn-by-turn : DD)
%  2. Z_raw , can be a vector (closed orbit : SA) or a matrix (turn-by-turn : DD)
%  3. DeviceList is the TANGO device list
%  4. OffsetStructure is the output of get_bpm_offsets function
%  5. DataType is 'SA' for closed orbit or 'DD' for turn-by-turn data
%
%  OUTPUTS
%  1. AM = structure containing X and Z adjusted with the corresponding offsets
%  2. tout  (see help getpv)
%  3. DataTime  (see help getpv)
%  4. ErrorFlag  (see help getpv)
%
% See also get_bpm_offsets, get_bpm_co_rebuilt, get_bpm_tbt_rebuilt,
% get_bpm_rebuilt_position_expert, bpm_observe_sa_levels


% Written by  B. Beranger, Master 2013

%% Start time

t0 = clock; % starting time for getting data


%% Input control

if nargin < 5
    error('X_raw , Z_raw, DeviceList, OffsetStructure and DataType are required')
end

if ~isnumeric(X_raw)
    error('X must be a vector (closed orbit : SA) or a matrix (turn-by-turn : DD)')
end

if ~isnumeric(Z_raw)
    error('Z must be a vector (closed orbit : SA) or a matrix (turn-by-turn : DD)')
end

if ~isnumeric(DeviceList)
    error('DeviceList must be a vector of a 2-column matrix ')
end

if length(X_raw) ~= length(Z_raw) && length(X_raw) ~= size(DeviceList,1)
    error('X_raw , Z_raw and DeviceListmust have the same number of lines')
end

if ~isstruct(OffsetStructure)
    error('OffsetStructure must be a structure')
end

if ~ischar(DataType)
    error('DataType must be a string')
end

% Check closed orbit (SA) data or turn-by-turn (DD) data
if strcmpi(DataType,'SA')
    SAFlag = 1;
elseif strcmpi(DataType,'DD')
    SAFlag = 0;
end


%% Convert DeviceName into DeviceList for old data

if ~isfield(OffsetStructure,'DeviceList')
    if ~isfield(OffsetStructure,'DeviceName')
        error('DeviceList or DeviceName must apear in OffsetStructure')
    else
        OffsetStructure.DeviceList = cell2mat(tangodev2dev(OffsetStructure.DeviceName)');
    end
end


%% Add offset according to the TANGO device

X_with_offset = nan(size(X_raw));
Z_with_offset = nan(size(X_raw));

for DeviceNumber = 1:size(DeviceList,1)
    for OffsetNumber = 1:length(OffsetStructure.DeviceList)
        if DeviceList(DeviceNumber,1) == OffsetStructure.DeviceList(OffsetNumber,1) &&...
                DeviceList(DeviceNumber,2) == OffsetStructure.DeviceList(OffsetNumber,2)
            
            % --- Offset found for the device asked ---
            
            X_with_offset(DeviceNumber,:) = X_raw(DeviceNumber,:)...
                - OffsetStructure.BBA_offset(OffsetNumber,1)...
                - OffsetStructure.survey_offset(OffsetNumber,1)...
                - OffsetStructure.libera_RF_offset(OffsetNumber,1);
            
            Z_with_offset(DeviceNumber,:) = Z_raw(DeviceNumber,:)...
                - OffsetStructure.BBA_offset(OffsetNumber,2)...
                - OffsetStructure.survey_offset(OffsetNumber,2)...
                - OffsetStructure.libera_RF_offset(OffsetNumber,2);
            
            % Case using SA data : Block offset is also required
            if SAFlag
                
                X_with_offset(DeviceNumber,:) = X_with_offset(DeviceNumber,:)...
                    - OffsetStructure.block_offset(OffsetNumber,1);
                
                Z_with_offset(DeviceNumber,:) = Z_with_offset(DeviceNumber,:)...
                    - OffsetStructure.block_offset(OffsetNumber,2);
                
            end
            
            break
            
        end
    end
    
    % --- No offset corresponds to the device ---
    if OffsetNumber == length(OffsetStructure.DeviceList) &&...
            not(DeviceList(DeviceNumber,1) == OffsetStructure.DeviceList(OffsetNumber,1) &&...
            DeviceList(DeviceNumber,2) == OffsetStructure.DeviceList(OffsetNumber,2))
        
        warning('DataStructure:OffsetNotFound',...
            'Error : Offset not found in for device [ %d %d ]',...
            DeviceList(DeviceNumber,1),DeviceList(DeviceNumber,2));
        
    end
    
end


%% Output

DataTime = now;

AM = struct;
AM.DataDescriptor = 'BPM offsets added to X and Z';
AM.CreatedBy = mfilename;
AM.TimeStampe = datestr(DataTime);

AM.X_raw = X_raw;
AM.Z_raw = Z_raw;
AM.DeviceList = DeviceList;
AM.OffsetStructure = OffsetStructure;
AM.DataType = DataType;

AM.X_with_offset = X_with_offset;
AM.Z_with_offset = Z_with_offset;


ErrorFlag = 0;
tout = etime(clock, t0);

end