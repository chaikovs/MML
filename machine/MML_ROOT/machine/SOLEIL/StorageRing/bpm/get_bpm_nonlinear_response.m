function [AM, tout, DataTime, ErrorFlag] = get_bpm_nonlinear_response( varargin )
%GET_BPM_NONLINEAR_RESPONSE - Get BPM response of Orbit in the SIMULATOR
%
%  [AM, tout, DataTime, ErrorFlag] = get_bpm_nonlinear_response(DeviceList,'Struct','MeshStructure',bpm_vacuum_chamber_mesh_generation_OutputStructure)
%
%  INPUTS
%  1. DeviceList (see help getpv)
%  2. 'Struct' will return a data structure
%     'Numeric' will return a vector output {default}
%  3. Optional : a MeshStructure can be entered to use non default
%  parametres for the mesh, such as :
%  'MeshStructure',bpm_vacuum_chamber_mesh_generation_OutputStructure
% 
%
%  OUTPUTS
%  1. AM = closed orbit vectors or data structure
%  2. tout  (see help getpv)
%  3. DataTime  (see help getpv)
%  4. ErrorFlag  (see help getpv)
%
%  NOTE
%  1. 'Struct', 'Numeric'
%  2. All inputs are optional
%
% See also getpv, bpm_compute_nonlinear_response, getx, getz, get_bpm_nonlinear_response_expert

% Written by  B. Beranger, Master 2013

%% Start time

t0 = clock; % starting time for getting data


%% Get input flags and variables

% Flags
StructOutputFlag = 0;
MeshStructureFlag = 0;

% Loop to check input arguments
for i = length(varargin):-1:1
    if ischar(varargin{i})
        
        if strcmpi(varargin{i},'Struct')
            StructOutputFlag = 1;
            
        elseif strcmpi(varargin{i},'Numeric')
            StructOutputFlag = 0;
            
        elseif strcmpi(varargin{i},'MeshStructure')
            if length(varargin) > i
                % Look for the file name as the next input
                if isstruct(varargin{i+1})
                    MeshStructure = varargin{i+1};
                    MeshStructureFlag = 1;
                    varargin(i+1) = [];
                else
                    fprintf('# Problem detected after the field ''%s'' : Patameter must be structure.\n',varargin{i});
                end
            else
                fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
            end
            varargin(i) = [];
        
        end
    end
end

if ~MeshStructureFlag
    MeshStructure = bpm_vacuum_chamber_mesh_generation();
end

%% Get data & Compute

if isempty(varargin)
    [X_AM, X_tout, X_DataTime, X_ErrorFlag] = getpv('BPMx','SIMULATOR');
    [Z_AM, Z_tout, Z_DataTime, Z_ErrorFlag] = getpv('BPMz','SIMULATOR');
    BPM_response = bpm_compute_nonlinear_response( X_AM , Z_AM , MeshStructure );
    
elseif StructOutputFlag
    [X_AM, X_tout, X_DataTime, X_ErrorFlag] = getpv('BPMx','SIMULATOR',varargin{:});
    [Z_AM, Z_tout, Z_DataTime, Z_ErrorFlag] = getpv('BPMz','SIMULATOR',varargin{:});
    BPM_response = bpm_compute_nonlinear_response( X_AM.Data , Z_AM.Data , MeshStructure );
    
else
    [X_AM, X_tout, X_DataTime, X_ErrorFlag] = getpv('BPMx','SIMULATOR',varargin{:});
    [Z_AM, Z_tout, Z_DataTime, Z_ErrorFlag] = getpv('BPMz','SIMULATOR',varargin{:});
    BPM_response = bpm_compute_nonlinear_response( X_AM , Z_AM , MeshStructure );
    
end


%% Output

DataTime = now;

if StructOutputFlag
    
    AM = struct;
    
    AM.DataDescriptor = 'BPM response of Orbit in the SIMULATOR';
    AM.CreatedBy = mfilename;
    AM.TimeStamp = datestr(now);
    
    AM.MeshStructure = MeshStructure;
    AM.X_getpv.AM = X_AM;
    AM.X_getpv.tout = X_tout;
    AM.X_getpv.DataTime = X_DataTime;
    AM.X_getpv.ErrorFlag = X_ErrorFlag;
    
    AM.Z_getpv.AM = Z_AM;
    AM.Z_getpv.tout = Z_tout;
    AM.Z_getpv.DataTime = Z_DataTime;
    AM.Z_getpv.ErrorFlag = Z_ErrorFlag;
    
    AM.BPM_response = BPM_response;
    
    
    
else
    AM = [ BPM_response.X_read BPM_response.Z_read ];
    
end

ErrorFlag = 0;
tout = etime(clock, t0);

end
