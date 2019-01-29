function [ varargout ] = get_bpm_rebuilt_position_expert( varargin )
% GET_BPM_REBUILT_POSITION_EXPERT Uses Newton inversion's method to compute
% the true position of the beam, starting from the read position.
%==========================================================================
%
%
% USE :
% -----
%
% I. Using NonlinearRespStructure :
% This function uses a structure containing the electric charge ( Q(i) )
% and the beam position ( X_beam , Z_beam ) to compute, through Newton's
% Method, the true beam position from get_bpm_nonlinear_response_expert.m function.
%
% II. Using MeshStructure & DataStructure :
% The function computes the true beam position of the selected signal using
% structure from getbpmrawdata.m or bpm_tbt_demixing.m .
% 1. 'SA' data
% 2. 'DD' data : After 'SignalName' field, enter signal suffix as '','_exp','_IQ_sim',...
%
% SYNTAX(general form) :
% -----------------------
%
% [ varargout ] = get_bpm_rebuild_position_expert(
%                                  'MaxIteration', 50
%                                  'Tolerance', 1e-6
%                                  'Display'            // 'NoDisplay'
%                                  'Echo'               // 'NoEcho'
%                                  'IterationEcho'      // 'NoIterationEcho'
%                                  'Path'               // 'NoPath'
%
%                             I.   'NonlinearRespStructure', get_bpm_nonlinear_response_OutputStructure
%                                  'ShadingInterp'    // 'NoShadingInterp' (works with 'Display')
%                                                           OR
%                            II.   'MeshStructure', BoundaryMeshStructure_structure
%                                  'DataStructure', InputBpmDataStructure_struct
%                                  'DeviceList',[ 5 6 ; 3 2 ; 15 1 ] // 'DeviceList',[]
%                              1.  'SA'
%                              2.  'DD','SignalName','_exp'
%
%                                 )
%
% Two different ways to use this function :
% I. Using the output of get_bpm_nonlinear_response_expert.m function
% II. Using the output of getbpmrawdata.m function (real signals)
%       1. Closed orbit data 'SA'
%       2. Turn-by-turn data 'DD'
%
%
% EXAMPLES :
% ..........
%
% I. RebuiltData = get_bpm_rebuild_position_expert(...
%     'NonlinearRespStructure',get_bpm_nonlinear_response_expert_structure,...
%     'MaxIteration', 50,...
%     'Tolerance',1e-6,...
%     'Display','NoShadingInterp',...
%     'NoEcho',...
%     'Path');
% Here, get_bpm_rebuild_position_expert will rebuild the real position of beam using
% simulated data from get_bpm_nonlinear_response_expert.m . If 'Path' is activated, the
% function will save the path of iteration for each point.
%
%
% II. Using data from getbpmrawdata.m function, 'SA' our 'DD' must be
% indicated.
%
% 1. RebuiltData = get_bpm_rebuild_position_expert(...
%     'DataStructure',SA_raw_data,...
%     'MeshStructure',bpm_vacuum_chamber_mesh_generation_OutputStructure,...
%     'MaxIteration', 50,...
%     'Tolerance',1e-6,...
%     'DeviceList',[],...
%     'SA',...
%     'IterationEcho',...
%     'Display');
% Here, using 'SA' data, there is only one point for each BPM. Thus, all
% BPM signals are usually computed (using [] after 'DeviceList').
% 'ObserveSAOffset' field plots, when 'Display' is activated, the
% difference between raw signal and raw rebuilt by V(i).
%
% 2. RebuiltData = get_bpm_rebuild_position_expert(...
%     'DataStructure',DD_raw_data,...
%     'MeshStructure',bpm_vacuum_chamber_mesh_generation_OutputStructure,...
%     'MaxIteration', 50,...
%     'Tolerance',1e-6,...
%     'DeviceList',[],...
%     'DD','SignalName','_exp',...
%     'NoEcho');
% Here, using 'DD' data, computing every point of each BPM ( [] ) for the
% selected 'SignalName' takes time. Usually, only one device is selected
% ( ex: [ 5 6 ] ).
% WARNING : If 'Display' is activated, the function will display one figure
% for each BPM selected ( [] means all BPM )
%
%
% DEFAULT VALUES :
% ................
%
%   - NonlinearRespStructure = get_bpm_nonlinear_response_expert()
%   - 'NoDisplay'
%   - 'NoEcho'
%   - 'NoIterationEcho'
%   - MaxIteration = 50
%   - Tolerance = 1e-6
%   - 'NoPath'
%
%   (- SignalName = '')
%   (- []  (it means all BPM available))
%
%
%==========================================================================
%
% See also bpm_vacuum_chamber_mesh_generation,
% get_bpm_nonlinear_response_expert, getbpmrawdata, bpm_rebuild_position,
% bpm_add_offsets


% Written by  B. Beranger, Master 2013

%% Check input arguments

% --- Default values and flags ---
ProblemDetectionFlag = 0;
DisplayFlag = 0;
NonlinearRespFlag = 0;
get_bpm_nonlinear_response_expert_defaultFlag = 0;
MaxIterationFlag = 0;
ToleranceFlag = 0;
MeshFlag = 0;
Mesh_defaultFlag = 0;
DataFlag = 0;
SignalName = '';
SAFlag = 0;
DDFlag = 0;
ShadingInterpFlag = 0;
DeviceList = [];
PathFlag = 0;
OnePointFlag = 0;
EchoFlag = 0;
IterationEchoFlag = 0;
PathOfOnePointFlag = 0;


% --- Checking varargin ---
for i = length(varargin):-1:1
    
    % --- Display ---
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
        
        % --- NoDisplay ---
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
        
        % --- NonlinearRespStructure ---
    elseif strcmpi(varargin{i},'NonlinearRespStructure')
        if length(varargin) > i
            % Look for the structure as the next input
            if isstruct(varargin{i+1})
                NonlinearRespStructure = varargin{i+1};
                NonlinearRespFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Patameter must be structure.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- MaxIteration ---
    elseif strcmpi(varargin{i},'MaxIteration')
        if length(varargin) > i
            % Look for the positive integer as the next input
            if isscalar(varargin{i+1}) && varargin{i+1}>0 && varargin{i+1} == round(varargin{i+1})
                if varargin{i+1} < 10
                    warning('Warning:MaxIterationBellowThan10','Usually : MaxIteration > 10')
                end
                MaxIteration = varargin{i+1};
                MaxIterationFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Parameter must be a positive integer.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- Tolerance ---
    elseif strcmpi(varargin{i},'Tolerance')
        if length(varargin) > i
            % Look for the positive as the next input
            if isscalar(varargin{i+1}) && varargin{i+1}>0
                if varargin{i+1} > 1
                    warning('Warning:ToleranceBellowThanOne','Usually : Tolerance < 1')
                end
                Tolerance = varargin{i+1};
                ToleranceFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Parameter must be positive.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- Echo ---
    elseif strcmpi(varargin{i},'Echo')
        EchoFlag = 1;
        varargin(i) = [];
        
        % --- NoEcho ---
    elseif strcmpi(varargin{i},'NoEcho')
        EchoFlag = 0;
        varargin(i) = [];
        
        % --- MeshStructure ---
    elseif strcmpi(varargin{i},'MeshStructure')
        if length(varargin) > i
            % Look for the structure as the next input
            if isstruct(varargin{i+1})
                MeshStructure = varargin{i+1};
                MeshFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Patameter must be structure.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- DataStructure ---
    elseif strcmpi(varargin{i},'DataStructure')
        if length(varargin) > i
            % Look for the structure as the next input
            if isstruct(varargin{i+1})
                DataStructure = varargin{i+1};
                DataFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Patameter must be structure.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- SignalName ---
    elseif strcmpi(varargin{i},'SignalName')
        if length(varargin) > i
            % Look for the chain of characters as the next input
            if ischar(varargin{i+1})
                SignalName = varargin{i+1};
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Parameter must be a char.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- SA ---
    elseif strcmpi(varargin{i},'SA')
        SAFlag = 1;
        varargin(i) = [];
        
        % --- DD ---
    elseif strcmpi(varargin{i},'DD')
        DDFlag = 1;
        varargin(i) = [];
        
        % --- ShadingInterp ---
    elseif strcmpi(varargin{i},'ShadingInterp')
        ShadingInterpFlag = 1;
        varargin(i) = [];
        
        % --- NoShadingInterp ---
    elseif strcmpi(varargin{i},'NoShadingInterp')
        ShadingInterpFlag = 0;
        varargin(i) = [];
        
        % --- DeviceList ---
    elseif strcmpi(varargin{i},'DeviceList')
        if length(varargin) > i
            % Look for the numeric as the next input
            if isnumeric(varargin{i+1}) && size(varargin{i+1},2)<=2
                DeviceList = varargin{i+1};
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Parameter must be a matrix with 2 columns maximum .\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- Path ---
    elseif strcmpi(varargin{i},'Path')
        PathFlag = 1;
        varargin(i) = [];
        
        % --- NoPath ---
    elseif strcmpi(varargin{i},'NoPath')
        PathFlag = 0;
        varargin(i) = [];
        
        % --- IterationEcho ---
    elseif strcmpi(varargin{i},'IterationEcho')
        IterationEchoFlag = 1;
        varargin(i) = [];
        
        % --- NoIterationEcho ---
    elseif strcmpi(varargin{i},'NoIterationEcho')
        IterationEchoFlag = 0;
        varargin(i) = [];
        
        % --- PathOfOnePoint ---
    elseif strcmpi(varargin{i},'PathOfOnePoint')
        if length(varargin) > i
            % Look for number of the point as the next input
            if isscalar(varargin{i+1}) && varargin{i+1}>0 && varargin{i+1} == round(varargin{i+1})
                PathOfOnePoint = varargin{i+1};
                PathOfOnePointFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Parameter must be a char.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
    end
    
end

% --- If unidentified paramter(s) remain(s) ---
if ~isempty(varargin)
    fprintf('\nIn %s, parameter(s) not recognised : \n',mfilename)
    for p = 1:length(varargin)
        disp(varargin(p))
    end
    warning('Unknown:Parameter','Unknown parameter(s) detected')
end

% --- In case of main paramter default ---
if ~NonlinearRespFlag && ~DataFlag % No input structure at all
    NonlinearRespStructure = get_bpm_nonlinear_response_expert();
    NonlinearRespFlag = 1;
    get_bpm_nonlinear_response_expert_defaultFlag = 1;
elseif DataFlag && ~MeshFlag % Mesh missing
    MeshStructure = bpm_vacuum_chamber_mesh_generation();
    MeshFlag = 1;
    Mesh_defaultFlag = 1;
end

% ===== Security tests =====
if MeshFlag && DataFlag
    
    if ~SAFlag && ~DDFlag
        error('No data type selected. ''SA'' or ''DD'' required as function parameter.');
    elseif SAFlag && DDFlag
        error('Both ''SA'' and ''DD'' are selected.')
    end
    
    if SAFlag
        SignalName = ''; % Forcing SignalName value in case of using SA data
        
        % Test the number of points in each signals
        FieldNames = fieldnames(DataStructure.Data); % List of fields
        for FieldNumber = 1:length(FieldNames)
            if size(DataStructure.Data.(FieldNames{FieldNumber}),2) ~= 1
                error('DataStructure:NumberOfPoints',...
                    'SA data contains more than 1 point in %s, It must contain only 1 point',...
                    FieldNames{FieldNumber});
            end
        end
    end
    
    if DDFlag
        % Test the number of points in each signals
        NumberOfPointsLimit = 2;
        FieldNames = fieldnames(DataStructure.Data); % List of fields
        for FieldNumber = 1:length(FieldNames)
            if size(DataStructure.Data.(FieldNames{FieldNumber}),2) < NumberOfPointsLimit
                error('DataStructure:NumberOfPoints',...
                    'DD data contains less than %d point in %s, It must have more than %d point',...
                    NumberOfPointsLimit,FieldNames{FieldNumber},NumberOfPointsLimit);
            end
        end
        
        if PathOfOnePointFlag && size(DeviceList,1) ~= 1
            error('To use ''PathOfOnePoint'', select only one TangoDevice in case of ''DD'' data ')
        end
        
    end
    
    % The field 'DataType' does no exist in old data from getbpmrawdata.
    % If it exists, the lines bellow will operate a last check.
    if isfield(DataStructure,'DataType')
        if SAFlag
            if ~strcmp(DataStructure.DataType,'SA')
                error('SA data entered as function parameter, but DD detected in DataStructure');
            end
        else
            if ~strcmp(DataStructure.DataType,'DD')
                error('DD data entered as function parameter, but SA detected in DataStructure');
            end
        end
    end
    
end


%% Echo of all parameters used (used as control in the Command Window)

if EchoFlag
    
    % --- Echo for parameters used ---
    fprintf('\n ===== get_bpm_bpm_rebuild_position_expert Start ===== \n');
    
    % --- Echo for no problem detected ---
    if ProblemDetectionFlag == 0;
        fprintf('No parameter problem detected \n');
    end
    
    % --- Echo for the MaxIteration ---
    if MaxIterationFlag
        fprintf(' - MaxIteration             : %d \n',MaxIteration);
    else
        fprintf(' - MaxIteration             : Default value of bpm_rebuild_position \n');
    end
    
    % --- Echo for the Tolerance ---
    if ToleranceFlag
        fprintf(' - Tolerance                : %g \n',Tolerance);
    else
        fprintf(' - Tolerance                : Default value of bpm_rebuild_position \n');
    end
    
    % --- Echo for the NonlinearRespStructure ---
    if get_bpm_nonlinear_response_expert_defaultFlag
        fprintf(' - NonlinearRespStructure   : default value get_bpm_nonlinear_response_expert() \n');
    elseif NonlinearRespFlag
        fprintf(' - NonlinearRespStructure   : Parameter of function \n');
    end
    
    % --- Echo for the MeshStructure & DataStructure ---
    if MeshFlag && DataFlag
        if Mesh_defaultFlag
            fprintf(' - MeshStructure            : default value bpm_vacuum_chamber_mesh_generation() \n');
        else
            fprintf(' - MeshStructure            : Parameter of function \n');
        end
        fprintf(' - DataStructure            : Parameter of function \n');
        if DDFlag
            fprintf(' - SignalName (DD data )    : ''%s'' \n',SignalName);
        elseif SAFlag
            fprintf(' - SA data selected \n');
        end
    end
    
    % --- Echo for display parameters ---
    if DisplayFlag == 0
        DisplayText = 'Off';
    else
        DisplayText = 'On';
    end
    fprintf(' - Display                  : %s \n', DisplayText);
    
end


%% If using Tango name

if MeshFlag && DataFlag
    
    % if empty select all valid BPM
    if isempty(DeviceList)
        DeviceList = family2dev('BPMx');
    else
        if size(DeviceList,2) == 2 % DeviceList
        else %% Element list
            DeviceList = elem2dev('BPMx',DeviceList);
        end
    end
    
    % Status one devices
    Status     = family2status('BPMx',DeviceList);
    DeviceList = DeviceList(find(Status),:); %#ok<FNDSB>
    
    if isempty(DeviceList)
        disp('All BPM not valid')
        return;
    end
    
    DeviceListName = family2tangodev('BPMx',DeviceList);
    
end

%% Definition of used variables

% --- Variables in case of using NonlinearRespStructure ---
if NonlinearRespFlag
    X_beam = NonlinearRespStructure.X_beam;
    Z_beam = NonlinearRespStructure.Z_beam;
    X_read = NonlinearRespStructure.X_read;
    Z_read = NonlinearRespStructure.Z_read;
    IndexA = NonlinearRespStructure.MeshStructure.IndexA;
    IndexB = NonlinearRespStructure.MeshStructure.IndexB;
    IndexC = NonlinearRespStructure.MeshStructure.IndexC;
    IndexD = NonlinearRespStructure.MeshStructure.IndexD;
    X_middle_boundary = NonlinearRespStructure.MeshStructure.X_middle_boundary;
    Z_middle_boundary = NonlinearRespStructure.MeshStructure.Z_middle_boundary;
    X_boundary = NonlinearRespStructure.MeshStructure.X_boundary;
    Z_boundary = NonlinearRespStructure.MeshStructure.Z_boundary;
    Qa0 = NonlinearRespStructure.Qa;
    Qb0 = NonlinearRespStructure.Qb;
    Qc0 = NonlinearRespStructure.Qc;
    Qd0 = NonlinearRespStructure.Qd;
    OnePointFlag = 0;
    if(isscalar(X_beam) && isscalar(Z_beam))
        OnePointFlag = 1;
    end
    
    
    % --- Variables in case of using MeshStructure & DataStructure ---
elseif MeshFlag && DataFlag
    
    X_raw = nan(size(DeviceList,1),size(DataStructure.Data.X,2));
    Z_raw = nan(size(DeviceList,1),size(DataStructure.Data.X,2));
    X_read = nan(size(DeviceList,1),size(DataStructure.Data.X,2));
    Z_read = nan(size(DeviceList,1),size(DataStructure.Data.X,2));
    Qa0 = nan(size(DeviceList,1),size(DataStructure.Data.X,2));
    Qb0 = nan(size(DeviceList,1),size(DataStructure.Data.X,2));
    Qc0 = nan(size(DeviceList,1),size(DataStructure.Data.X,2));
    Qd0 = nan(size(DeviceList,1),size(DataStructure.Data.X,2));
    
    RebuiltDeviceList = DeviceList;
    k = 0; % Count for signals : the algorithme is only applied to the selected signals
    RebuiltDeviceList(:,3) = 0; % A 3rd column is added to assign real BPM number to the selected signals
    
    % --- Looking for the selected BPM in the DeviceName list ---
    for DeviceNumber = 1:size(DeviceList,1)
        for BpmNumber = 1:size(DataStructure.DeviceList,1)
            if DataStructure.DeviceList(BpmNumber,1) == DeviceList(DeviceNumber,1) &&...
                    DataStructure.DeviceList(BpmNumber,2) == DeviceList(DeviceNumber,2)
                
                % --- If device name in the input structure matches with selected BPM device name ---
                
                k = k+1;
                
                RebuiltDeviceList(DeviceNumber,3) = BpmNumber; %#ok<*AGROW>
                
                X_raw(k,:) = DataStructure.Data.X(BpmNumber,:);
                Z_raw(k,:) = DataStructure.Data.Z(BpmNumber,:);
                X_read(k,:) = DataStructure.Data.(genvarname(['X' SignalName]))(BpmNumber,:);
                Z_read(k,:) = DataStructure.Data.(genvarname(['Z' SignalName]))(BpmNumber,:);
                
                % --- Selection of potentials depending on the SignalName ---
                if strcmp(SignalName,'_V_exp') || strcmp(SignalName,'_V_sim')
                    Qa0(k,:) = DataStructure.Data.(genvarname(['Va' SignalName(3:end)]))(BpmNumber,:);
                    Qb0(k,:) = DataStructure.Data.(genvarname(['Vb' SignalName(3:end)]))(BpmNumber,:);
                    Qc0(k,:) = DataStructure.Data.(genvarname(['Vc' SignalName(3:end)]))(BpmNumber,:);
                    Qd0(k,:) = DataStructure.Data.(genvarname(['Vd' SignalName(3:end)]))(BpmNumber,:);
                elseif strcmp(SignalName,'_exp') || strcmp(SignalName,'_sim')
                    Qa0(k,:) = DataStructure.Data.Va(BpmNumber,:);
                    Qb0(k,:) = DataStructure.Data.Vb(BpmNumber,:);
                    Qc0(k,:) = DataStructure.Data.Vc(BpmNumber,:);
                    Qd0(k,:) = DataStructure.Data.Vd(BpmNumber,:);
                elseif strcmp(SignalName,'_IQ_exp') || strcmp(SignalName,'_IQ_sim')
                    Qa0(k,:) = DataStructure.Data.(genvarname(['Va' SignalName]))(BpmNumber,:);
                    Qb0(k,:) = DataStructure.Data.(genvarname(['Vb' SignalName]))(BpmNumber,:);
                    Qc0(k,:) = DataStructure.Data.(genvarname(['Vc' SignalName]))(BpmNumber,:);
                    Qd0(k,:) = DataStructure.Data.(genvarname(['Vd' SignalName]))(BpmNumber,:);
                else
                    Qa0(k,:) = DataStructure.Data.Va(BpmNumber,:);
                    Qb0(k,:) = DataStructure.Data.Vb(BpmNumber,:);
                    Qc0(k,:) = DataStructure.Data.Vc(BpmNumber,:);
                    Qd0(k,:) = DataStructure.Data.Vd(BpmNumber,:);
                end
                
                break
                
            end
        end
        
        % --- Check if the device number corresponds to the BPM signal ---
        if RebuiltDeviceList(DeviceNumber,3) == 0
            error('DataStructure:BpmNotFound',...
                'Error : BPM not found in DataStructure for device [ %d %d ]',...
                RebuiltDeviceList(DeviceNumber,1),RebuiltDeviceList(DeviceNumber,2));
        end
        
    end
    
    X_middle_boundary = MeshStructure.X_middle_boundary;
    Z_middle_boundary = MeshStructure.Z_middle_boundary;
    IndexA = MeshStructure.IndexA;
    IndexB = MeshStructure.IndexB;
    IndexC = MeshStructure.IndexC;
    IndexD = MeshStructure.IndexD;
    
end


%% Preparation of Newton's method

if NonlinearRespFlag
    NewtonError = zeros(size(X_read));
    NormalisedNewtonError = zeros(size(X_read));
end

% Organization of Potential cell Q
Q = cell(size(X_read));
for i = 1:size(X_read,1)
    for j = 1:size(X_read,2)
        Q{i,j} = [ Qa0(i,j) Qb0(i,j) Qc0(i,j) Qd0(i,j) ];
    end
end

% Gather rebuild function inputs
k = 0;
RebuildFunctionInputs = {};
if PathFlag
    k = k + 1;
    RebuildFunctionInputs{k} = 'Path';
end
if IterationEchoFlag
    k = k + 1;
    RebuildFunctionInputs{k} = 'IterationEcho';
end
if MaxIterationFlag
    k = k + 1;
    RebuildFunctionInputs{k} = 'MaxIteration';
    k = k + 1;
    RebuildFunctionInputs{k} = MaxIteration;
end
if MaxIterationFlag
    k = k + 1;
    RebuildFunctionInputs{k} = 'Tolerance';
    k = k + 1;
    RebuildFunctionInputs{k} = Tolerance;
end


%% Computation of Newton's method

if NonlinearRespFlag % Case : generated data
    bpm_rebuild_position_OutputStructure = bpm_rebuild_position( Q , X_read , Z_read ,...
        'MeshStructure',NonlinearRespStructure.MeshStructure,RebuildFunctionInputs{:} );
else % Case : real data
    if PathOfOnePointFlag % Special Case : path of one point for real data
        
        Q = Q(PathOfOnePoint);
        X_read = X_read(PathOfOnePoint);
        Z_read = Z_read(PathOfOnePoint);
        
        RebuildFunctionInputs{end+1} = 'LoopOnce';
        RebuildFunctionInputs{end+1} = 'IterationEcho';
        bpm_rebuild_position_OutputStructure = bpm_rebuild_position( Q , X_read , Z_read ,...
            'MeshStructure',MeshStructure,RebuildFunctionInputs{:} );
        
        Approximative_beam_position = bpm_approximate_beam_position(Q);
        X_beam = Approximative_beam_position.X_approximated;
        Z_beam = Approximative_beam_position.Z_approximated;
        
        NonlinearRespFlag = 1;
        OnePointFlag = 1;
        
        FieldNames = fieldnames(MeshStructure);
        for fieldNumber = 1:length(FieldNames)
            DynamicName = genvarname(FieldNames{fieldNumber});
            eval([DynamicName ' = MeshStructure. ' DynamicName ';']);
            
        end
    else
        bpm_rebuild_position_OutputStructure = bpm_rebuild_position( Q , X_read , Z_read , 'MeshStructure',MeshStructure,RebuildFunctionInputs{:} );
    end
end

MaxIteration = bpm_rebuild_position_OutputStructure.MaxIteration;
Tolerance = bpm_rebuild_position_OutputStructure.Tolerance;
det_J = bpm_rebuild_position_OutputStructure.det_J;
X_rebuilt = bpm_rebuild_position_OutputStructure.X_rebuilt;
Z_rebuilt = bpm_rebuild_position_OutputStructure.Z_rebuilt;
Iteration = bpm_rebuild_position_OutputStructure.Iteration;


%% Where algorithm reached MaxIteration, and compute error

if NonlinearRespFlag
    
    for i = 1:size(X_read,1)
        for j = 1:size(X_read,2)
            
            if Iteration(i,j) == MaxIteration
                fprintf('MaxIteration reached at point (X_beam,Z_beam) = ( %g , %g ) \n\n',X_beam(i,j),Z_beam(i,j));
            end
            
            if det_J(i,j) == 0
                fprintf('det_J(i,j) = 0 at point (X_beam,Z_beam) = ( %g , %g ) \n\n',X_beam(i,j),Z_beam(i,j));
            end
            
            NewtonError(i,j) = sqrt( ( X_rebuilt(i,j) - X_beam(i,j) ).^2 + ( Z_rebuilt(i,j) - Z_beam(i,j) ).^2 );
            NormalisedNewtonError(i,j) = NewtonError(i,j)/sqrt( X_beam(i,j).^2 + Z_beam(i,j).^2 )*100;
            
        end
    end
    
end


%% Adding offsets in case of real bpm data

if MeshFlag && DataFlag
    
    if SAFlag
        DataType = 'SA';
    elseif DDFlag
        DataType = 'DD';
    end
    
    bpm_add_offsets_OutputStructure = bpm_add_offsets(  X_rebuilt , Z_rebuilt , DeviceList , DataStructure.Offset , DataType );
    X_rebuilt = bpm_add_offsets_OutputStructure.X_with_offset;
    Z_rebuilt = bpm_add_offsets_OutputStructure.Z_with_offset;
    
end


%% Saving results

if NonlinearRespFlag
    if PathOfOnePointFlag
        varargout{1} = Approximative_beam_position;
        varargout{1}.X_approximative_beam = X_beam;
        varargout{1}.Z_approximative_beam = Z_beam;
    else
        varargout{1} = NonlinearRespStructure;
    end
    varargout{1}.Tolerance = Tolerance;
    varargout{1}.MaxIteration = MaxIteration;
    varargout{1}.det_J = det_J;
    varargout{1}.Iteration = Iteration;
    varargout{1}.NewtonError = NewtonError;
    varargout{1}.NormalisedNewtonError = NormalisedNewtonError;
    varargout{1}.X_rebuilt = X_rebuilt;
    varargout{1}.Z_rebuilt = Z_rebuilt;
    
elseif MeshFlag && DataFlag
    varargout{1} = DataStructure;
    varargout{1}.MeshStructure = MeshStructure;
    varargout{1}.RebuiltDeviceList = RebuiltDeviceList;
    varargout{1}.(genvarname(['X' SignalName '_rebuilt'])) = X_rebuilt; % Used as a control
    varargout{1}.(genvarname(['Z' SignalName '_rebuilt'])) = Z_rebuilt; % Used as a control
    %     for k = 1:size(DeviceList,1)
    %         varargout{1}.Data.(genvarname(['X' SignalName]))(DeviceList(k,3),:) = X_rebuilt(k,:); % It remplaces the previous signal => Because FilteringPrecess.m function uses only data in .Data substructure
    %         varargout{1}.Data.(genvarname(['Z' SignalName]))(DeviceList(k,3),:) = Z_rebuilt(k,:); % It remplaces the previous signal => Because FilteringPrecess.m function uses only data in .Data substructure
    %     end
    
end


if OnePointFlag || PathFlag
    Xpath = bpm_rebuild_position_OutputStructure.Xpath;
    Zpath = bpm_rebuild_position_OutputStructure.Zpath;
    Xpath_c = bpm_rebuild_position_OutputStructure.Xpath_c;
    Zpath_c = bpm_rebuild_position_OutputStructure.Zpath_c;
    varargout{1}.Xpath = bpm_rebuild_position_OutputStructure.Xpath;
    varargout{1}.Zpath = Zpath;
    varargout{1}.Xpath_c = Xpath_c;
    varargout{1}.Zpath_c = Zpath_c;
    
end


%% Display

LineWidth = 2;
FontSize = 20;

% Computing just one point from get_bpm_nonlinear_response_expert forces the display in
% command windows
if NonlinearRespFlag && OnePointFlag && EchoFlag
    fprintf('\n[ X_beam ; Z_beam ] = [ %g ; %g ]\n',X_beam,Z_beam)
    fprintf('\n[ X_read ; Z_read ] = [ %g ; %g ]\n',X_read,Z_read)
    display(Iteration)
    fprintf('[ X_rebuilt ; Z_rebuilt ] = [ %g ; %g ]\n',X_rebuilt,Z_rebuilt)
    display(NewtonError)
    display(NormalisedNewtonError)
    display(det_J);
end


if DisplayFlag && NonlinearRespFlag
    
    ButtonElectrodeColor = 'blackhexagram';
    
    % Figure representing the whole vacuum chamber with BeamPosition, ReadPosition and NewtonPosition
    figure('NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    hold all
    plot_boundary = plot(X_boundary,Z_boundary,'-black');
    plot_electrode = plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor);
    plot(X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor)
    plot(X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor)
    plot(X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
    plot_beam = plot(X_beam,Z_beam,'+blue','MarkerSize',2);
    plot_read = plot(X_read,Z_read,'*green','MarkerSize',6);
    plot_rebuilt = plot(X_rebuilt,Z_rebuilt,'ored','MarkerSize',5);
    legend([plot_boundary plot_electrode plot_beam(1) plot_read(1) plot_rebuilt(1)],'Boundary','Electrode points','Beam position','Read position','Rebuilt position')
    if size(X_beam,1) == 1 && size(X_beam,2) ~= 1
        set(gcf,'Name',sprintf('Rebuilt position for Z_beam = %g mm',Z_beam(1)))
        title(sprintf('Rebuilt position depending on position Read by BPM for Z_b_e_a_m = %g mm',Z_beam(1)),'FontSize',FontSize)
    elseif size(X_beam,2) == 1 && size(X_beam,1) ~= 1
        title(sprintf('Rebuilt position depending on position Read by BPM for X_b_e_a_m = %g mm',X_beam(1)),'FontSize',FontSize)
        set(gcf,'Name',sprintf('Rebuilt position for X_beam = %g mm',X_beam(1)))
    elseif PathOfOnePointFlag
        title([sprintf('Rebuilt position depending on position Read by BPM \n [ X_a_p_p_r_o_x_i_m_a_t_i_v_e, Z_a_p_p_r_o_x_i_m_a_t_i_v_e ] = [ %g , %g ]', X_beam,Z_beam)...
            sprintf('\t\t\t [ X_r_e_a_d , Z_r_e_a_d] = [ %g , %g ] \t\t\t [ X_r_e_b_u_i_l_t , Z_r_e_b_u_i_l_t] = [ %g , %g ]',...
            X_read,Z_read,X_rebuilt,Z_rebuilt)],'FontSize',FontSize)
        set(gcf,'Name','Rebuilt position depending on position Read by BPM')
    elseif isscalar(X_beam)
        title(sprintf(...
            'Rebuilt position depending on position Read by BPM \n [ X_b_e_a_m , Z_b_e_a_m ] = [ %g , %g ] \t\t\t [ X_r_e_a_d , Z_r_e_a_d] = [ %g , %g ] \t\t\t [ X_r_e_b_u_i_l_t , Z_r_e_b_u_i_l_t] = [ %g , %g ]',...
            X_beam,Z_beam,X_read,Z_read,X_rebuilt,Z_rebuilt),'FontSize',FontSize)
        set(gcf,'Name','Rebuilt position depending on position Read by BPM')
    else
        title(sprintf('Rebuilt position depending on position Read by BPM'),'FontSize',FontSize)
        set(gcf,'Name','Rebuilt position depending on position Read by BPM')
    end
    %     if ~PathOfOnePointFlag
    xlim([-45 45])
    ylim([-15 15])
    %     end
    set(gca,'XDir','reverse','FontSize',FontSize)
    xlabel('X [mm]','FontSize',FontSize)
    ylabel('Z [mm]','FontSize',FontSize)
    removemarge
    if ~PathOfOnePointFlag
        axis equal
    end
    
    % --- Case : 1 point is computed ---
    if OnePointFlag
        
        % Path before correction
        plot_path_c = plot([X_read(1,1) Xpath{1,1}],[Z_read(1,1) Zpath{1,1}],':red');
        for i = 1:length(Xpath{1,1})
            text(Xpath{1,1}(i),Zpath{1,1}(i),num2str(i),'Color',[1 0 0])
        end
        % Path after correction
        plot_path = plot([X_read(1,1) Xpath_c{1,1}],[Z_read(1,1) Zpath_c{1,1}],':blue');
        for i = 1:length(Xpath_c{1,1})
            text(Xpath_c{1,1}(i),Zpath_c{1,1}(i),num2str(i),'Color',[0 0 1])
        end
        % removemarge
        % axis equal
        
        legend([plot_boundary plot_electrode plot_beam(1) plot_read(1) plot_rebuilt(1) plot_path plot_path_c],...
            'Boundary','Electrode points','Beam position','Read position','Rebuilt position','Iteration path before correction','Iteration path after correction')
        
        
        % --- Case : 1 vector is computed ---
    elseif (isvector(X_beam) || isvector(Z_beam))
        
        % Figure representing X plot
        figure('Name','X','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        hold all
        grid on
        if size(X_beam,1) == 1
            plot(X_beam,X_beam,'*blue','MarkerSize',2)
            plot(X_beam,X_read,'*green','MarkerSize',4)
            plot(X_beam,X_rebuilt,'ored','MarkerSize',4)
            xlabel('X vacuum chamber [mm]','FontSize',FontSize)
            ylabel('X [mm]')
        elseif size(X_beam,2) == 1
            plot(Z_beam,X_beam,'*blue','MarkerSize',2)
            plot(Z_beam,X_read,'*green','MarkerSize',4)
            plot(Z_beam,X_rebuilt,'ored','MarkerSize',4)
            xlabel('Z vacuum chamber [mm]','FontSize',FontSize)
        end
        set(gca,'XDir','reverse','FontSize',FontSize)
        ylabel('X [mm]','FontSize',FontSize)
        legend('Beam position','Read position','Corrected position')
        removemarge
        axis equal
        
        
        % Figure representing Z plot
        figure('Name','Z','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        hold all
        grid on
        if size(X_beam,1) == 1
            plot(X_beam,Z_beam,'*blue','MarkerSize',2)
            plot(X_beam,Z_read,'*green','MarkerSize',4)
            plot(X_beam,Z_rebuilt,'ored','MarkerSize',4)
            xlabel('X vacuum chamber [mm]','FontSize',FontSize)
        elseif size(X_beam,2) == 1
            plot(Z_beam,Z_beam,'*blue','MarkerSize',2)
            plot(Z_beam,Z_read,'*green','MarkerSize',4)
            plot(Z_beam,Z_rebuilt,'ored','MarkerSize',4)
            xlabel('Z vacuum chamber [mm]','FontSize',FontSize)
        end
        ylabel('Z [mm]','FontSize',FontSize)
        legend('Beam position','Read position','Corrected position')
        removemarge
        axis equal
        
        
        % Figure representing the approximative determinant
        figure('Name','det(J)','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        if size(X_beam,1) == 1 || size(Z_beam,1) == 1
            semilogy(X_beam,det_J)
            xlabel('X vacuum chamber [mm]','FontSize',FontSize)
            set(gca,'XDir','reverse','FontSize',FontSize)
        elseif size(X_beam,2) == 1 || size(Z_beam,2) == 1
            semilogy(Z_beam,det_J)
            set(gca,'FontSize',FontSize)
            xlabel('Z vacuum chamber [mm]','FontSize',FontSize)
        end
        ylabel('det(J)','FontSize',FontSize);
        grid on
        removemarge
        axis tight
        
        
        % --- Case : a grid of beam position is computed ---
    elseif ~((size(X_beam,1) == 1) || (size(X_beam,2) == 1) || (size(Z_beam,1) == 1) || (size(Z_beam,2) == 1))
        
        
        % Figure representing the error inside the whole vacuum chamber
        figure('Name','Error between Beam position and Rebuilt position in millimeter [mm]','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        title('Error between Beam position and Rebuilt position in millimeter [mm]','FontSize',FontSize)
        hold all
        plot(X_boundary,Z_boundary,'-black')
        plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
            X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
            X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
            X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        surf( X_beam, Z_beam, NewtonError, 'LineStyle', 'None')
        if ShadingInterpFlag
            shading interp %#ok<*UNRCH>
        end
        xlim([-45 45])
        ylim([-15 15])
        set(gca,'XDir','reverse','FontSize',FontSize)
        xlabel('X [mm]','FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        removemarge
        colorbar
        axis equal
        
        
        %         NewtonErrorSaturation = 1e-3; % mm
        
        % Figure representing the base10 logarithm of error inside the
        % whole vacuum chamber with a saturation
        figure('Name','Log10 of error between Beam position and Rebuilt position in millimeter [mm]','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        title('Log10 of error between Beam position and Rebuilt position in millimeter [mm]','FontSize',FontSize)
        hold all
        plot(X_boundary,Z_boundary,'-black')
        plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
            X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
            X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
            X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        NewtonErrorSat = NewtonError;
        %         NewtonErrorSat(NewtonError>NewtonErrorSaturation) = NewtonErrorSaturation;
        surf( X_beam, Z_beam, log10(NewtonErrorSat), 'LineStyle', 'None')
        if ShadingInterpFlag
            shading interp %#ok<*UNRCH>
        end
        xlim([-45 45])
        ylim([-15 15])
        set(gca,'XDir','reverse','FontSize',FontSize)
        xlabel('X [mm]','FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        removemarge
        colorbar
        axis equal
        
        % Figure representing the normalised error inside the whole vacuum chamber
        figure('Name','Normalized error between Beam position and Rebuilt position in percent (%)','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        title('Normalized error between Beam position and Rebuilt position in percent (%)','FontSize',FontSize)
        hold all
        plot(X_boundary,Z_boundary,'-black')
        plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
            X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
            X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
            X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        surf( X_beam, Z_beam, NormalisedNewtonError, 'LineStyle', 'None')
        if ShadingInterpFlag
            shading interp
        end
        xlim([-45 45])
        ylim([-15 15])
        set(gca,'XDir','reverse','FontSize',FontSize)
        xlabel('X [mm]','FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        removemarge
        colorbar
        axis equal
        
        
        %         NormalisedNewtonErrorSaturation = 1e-1; % percent (%)
        
        % Figure representing the base10 logarithm of error inside the
        % whole vacuum chamber with a saturation
        figure('Name','Log10 of normalized error between Beam position and Rebuilt position in percent (%)','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        title('Log10 of normalized error between Beam position and Rebuilt position in percent (%)','FontSize',FontSize)
        hold all
        plot(X_boundary,Z_boundary,'-black')
        plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
            X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
            X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
            X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        NormalisedNewtonErrorSat = NormalisedNewtonError;
        %         NormalisedNewtonErrorSat(NewtonError>NormalisedNewtonErrorSaturation) = NormalisedNewtonErrorSaturation;
        surf( X_beam, Z_beam, log10(NormalisedNewtonErrorSat), 'LineStyle', 'None')
        if ShadingInterpFlag
            shading interp %#ok<*UNRCH>
        end
        xlim([-45 45])
        ylim([-15 15])
        set(gca,'XDir','reverse','FontSize',FontSize)
        xlabel('X [mm]','FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        removemarge
        colorbar
        axis equal
        
        
        % Figure representing the 10 base lorigthm of the inverse (to have same color code) of the approximate determinant
        figure('Name','log10 of 1/det(J)','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        title('log10 of 1/det(J)','FontSize',FontSize)
        hold all
        plot(X_boundary,Z_boundary,'-black')
        plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
            X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
            X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
            X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        surf( X_beam, Z_beam, log10(1./det_J), 'LineStyle', 'None')
        if ShadingInterpFlag
            shading interp
        end
        xlim([-45 45])
        ylim([-15 15])
        set(gca,'XDir','reverse','FontSize',FontSize)
        xlabel('X [mm]','FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        removemarge
        colorbar;
        axis equal
        
        
        % Figure representing the number of iterations required to converge
        % depending on the starting point obteain by get_bpm_nonlinear_response_expert
        figure('Name','Number of Iteration','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        title('Number of Iteration','FontSize',FontSize)
        hold all
        plot(X_boundary,Z_boundary,'-black')
        plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
            X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
            X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
            X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor);
        surf(X_beam,Z_beam,Iteration, 'LineStyle', 'None')
        if ShadingInterpFlag
            shading interp
        end
        colormap(jet(max(max(Iteration))))
        xlim([-45 45])
        ylim([-15 15])
        set(gca,'XDir','reverse','FontSize',FontSize)
        xlabel('X [mm]','FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        removemarge
        colorbar
        axis equal
        
        
    end
    
    % --- Case : real BPM signals ---
elseif DisplayFlag && MeshFlag && DataFlag
    
    % Case : SA data used
    if SAFlag
        
        spos = getspos('BPMx');
        
        % Figure reprensenting SA data
        figure('Name',sprintf('Closed orbit data (''SA'')'),'NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        hold all
        xlim([0 getcircumference])
        
        % X for SA data
        ax(1) = subplot(5,1,1:2);
        hold all
        grid on
        plot(spos,X_raw,'-black','LineWidth',LineWidth)
        plot(spos,X_rebuilt,'-red','LineWidth',LineWidth)
        ylabel('X [mm]','FontSize',FontSize)
        legend('Raw','Rebuilt')
        set(gca,'FontSize',FontSize)
        TI = get(gca,'TightInSet');
        OP = get(gca,'OuterPosition');
        Pos = OP + [ TI(1:2), -TI(1:2)-TI(3:4) ];
        set( gca,'Position',Pos);
        axis tight
        
        % Lattice
        ax(2) = subplot(5,1,3);
        drawlattice
        set(gca,'FontSize',FontSize)
        OP = get(gca,'OuterPosition');
        Pos = OP + [ TI(1:2), -TI(1:2)-TI(3:4) ];
        set( gca,'YTick',[],'XTick',[],'Position',Pos);
        axis tight
        
        % Z for SA data
        ax(3) = subplot(5,1,4:5);
        hold all
        grid on
        plot(spos,Z_raw,'-black','LineWidth',LineWidth)
        plot(spos,Z_rebuilt,'-red','LineWidth',LineWidth)
        xlabel('s (m)','FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        legend('Raw','Rebuilt')
        set(gca,'FontSize',FontSize)
        TI = get(gca,'TightInSet');
        OP = get(gca,'OuterPosition');
        Pos = OP + [ TI(1:2), -TI(1:2)-TI(3:4) ];
        set( gca,'Position',Pos);
        axis tight
        
        linkaxes(ax,'x')
        

        % --- Case : DD data ---
    elseif DDFlag
        
        % Loop for all the selected device number
        for k = 1:size(DeviceList,1)
            
            % X for DD data
            figure('Name',sprintf('X%s for %s',SignalName,DeviceListName{k}),'NumberTitle','off',...
                'units','normalized','OuterPosition',[0 0.03 1 0.97])
            hold all
            if all(X_raw(k,:) == X_read(k,:))
                plot(X_raw(k,:),'-black','LineWidth',2)
                plot(X_rebuilt(k,:),'-red','LineWidth',2)
                legend('Raw','Rebuilt')
            else
                plot(X_raw(k,:),'-black','LineWidth',2)
                plot(X_read(k,:),'-blue','LineWidth',2)
                plot(X_rebuilt(k,:),'-red','LineWidth',2)
                legend('Raw','Demixed','Demixed-Rebuilt')
            end
            xlabel('Turn','FontSize',FontSize)
            ylabel('Horizontal position','FontSize',FontSize)
            set(gca,'FontSize',FontSize)
            removemarge
            axis tight
            
            % Z for DD data
            figure('Name',sprintf('Z%s for %s',SignalName,DeviceListName{k}),'NumberTitle','off',...
                'units','normalized','OuterPosition',[0 0.03 1 0.97])
            hold all
            if all(X_raw(k,:) == X_read(k,:))
                plot(Z_raw(k,:),'-black','LineWidth',2)
                plot(Z_rebuilt(k,:),'-red','LineWidth',2)
                legend('Raw','Rebuilt')
            else
                plot(Z_raw(k,:),'-black','LineWidth',2)
                plot(Z_read(k,:),'-blue','LineWidth',2)
                plot(Z_rebuilt(k,:),'-red','LineWidth',2)
                legend('Raw','Demixed','Demixed-Rebuilt')
            end
            xlabel('Turn','FontSize',FontSize)
            ylabel('Vertical position','FontSize',FontSize)
            set(gca,'FontSize',FontSize)
            removemarge
            axis tight
            
        end
        
    end
    
end

%% End of function

if EchoFlag
    fprintf(' ===== get_bpm_bpm_rebuild_position_expert Done ===== \n\n')
end


end