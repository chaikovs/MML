function [AM, tout, DataTime, ErrorFlag] = bpm_tbt_demixing( varargin )
% bpm_tbt_demixing Convolute experimental and simulated filters (from
% bpm_tbt_filter_generation function) to signal from BPM.
%==========================================================================
%
%  [AM, tout, DataTime, ErrorFlag] = bpm_tbt_demixing( 'InputStructure',getbpmrawdata([],'AllData','DD','Struct') , 'FilterFileName','TbT_Filters_27_05_2013' )
%
%  INPUTS
%  1. InputStructure/InputFileName is the output of getbpmrawdata function
%  2. FilterFileName/FilterStructure is the File/Structure containing BPM offsets
%
%  OUTPUTS
%  1. AM = structure containing demixed TbT data
%  2. tout  (see help getpv)
%  3. DataTime  (see help getpv)
%  4. ErrorFlag  (see help getpv)
%
%  NOTE
%  1. Fast computation speed, even for a great number of points.
%
%
% USE :
% -----
%
% This function will use the 'FiltersStructure'/'FilterFileName' generated
% by bpm_tbt_filter_generation function and convolute them with BPM signals from the
% 'InputStructure'/'InputFileName'.
% In order to rebuild X and Z from V(i)_exp and V(i)_sim, bpm_tbt_demixing
% function will also need a structure containing the offsets from
% get_bpm_offset function.
%
% IMPORTANT : The 'InputStructure'/'InputFileName' is the output of
% getbpmrawdata function.
%
% IMPORTANT : The function uses the offsets inside the
% 'InputStructure'/'InputFileName' as default.
%
%
% SYNTAX(general form) :
% -----------------------
%
%  AM = bpm_tbt_demixing(
%                        'FilterStructure', ExpSim_Filters_struct, // 'FilterFileName', 'ExpSim_Filters(.mat)',
%                        'InputStructure', bpm_raw_data_struct,    // 'InputFileName', 'bpm_raw_data(.mat)',
%                        'DisplayAllBPM',{'X_exp','Vc_sim',...}    // 'DisplayOneBPM',{'ANS-C02/DG/BPM.4','X_exp','Vc_sim',...}
%                        'Echo'                                    // 'NoEcho'
%                        'Diag'                                    // 'NoDiag'
%
%                        'OffsetStructure', offsets_struct,        // 'OffsetFileName', 'offsets_struct(.mat)',
%                       )
%
% Next parameter after 'FilterStructure','FilterFileName', 'InputStructure', 'InputFileName' has be the
% corresponding value.
% After 'Display', the DisplayList can be all fields contained in OutputSurcture.Data
%
% Diag is used to compute all rebuild all high level signals from low level
% signals. Exemple :  X_V, Z_V, X_IQ, Z_IQ, Va_IQ, Vb_IQ, Vc_IQ, Vd_IQ
%_exp
% DEFAULT VALUES :
% ................
%
%   - FilterFileName = TbT_Filters_27_05_2013.mat
%   - InputStructure = getbpmrawdata([],'AllData','DD','Struct')
%   - OffsetStructure = InputStructure.Offset;
%   - 'Echo'
%   - 'NoDisplay'
%
%==========================================================================
%
% See also getbpmrawdata, bpm_tbt_filter_generation, bpm_tbt_expert_gui

% Written by  B. Beranger, Master 2013


%% Start time

t0 = clock; % starting time for getting data


%% Check input arguments

% --- Default values and flags ---
ProblemDetectionFlag = 0;
DisplayAllFlag   = 0;
DisplayOneFlag   = 0;
FilterStructureFlag = 0;
FilterFileFlag = 1;
FilterFileName = 'TbT_Filters_27_05_2013.mat'; % Experimental filter data measured May 2013
InputStructureFlag = 0;
InputFileFlag = 0;
% InputFileName = 'HorizontalPlan_8kV_1';
OffsetStructureFlag = 0;
OffsetFileFlag = 0;
EchoFlag = 1;
DiagFlag = 0;

% --- Checking varargin ---
for i = length(varargin):-1:1
    
    % --- Filter strucuture ---
    if strcmpi(varargin{i},'FilterStructure')
        if length(varargin) > i
            % Look for the filter structure as the next input
            if isstruct(varargin{i+1})
                FilterStructure = varargin{i+1};
                FilterStructureFlag = 1;
                FilterFileFlag = 0;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- Filter file ---
    elseif strcmpi(varargin{i},'FilterFileName')
        if length(varargin) > i
            % Look for the filter file name as the next input
            if ischar(varargin{i+1})
                FilterFileName = varargin{i+1};
                FilterFileFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- Input signal structure ---
    elseif strcmpi(varargin{i},'InputStructure')
        if length(varargin) > i
            % Look for the input structure as the next input
            if isstruct(varargin{i+1})
                InputStructure = varargin{i+1};
                InputStructureFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- Input signal file ---
    elseif strcmpi(varargin{i},'InputFileName')
        if length(varargin) > i
            % Look for the input file name as the next input
            if ischar(varargin{i+1})
                InputFileName = varargin{i+1};
                InputFileFlag = 0;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- Display the chosen signal for all BPM ---
    elseif strcmpi(varargin{i},'DisplayAllBpm')
        if length(varargin) > i
            % Look for the signal list as the next input
            if iscellstr(varargin{i+1})
                DisplayList = varargin{i+1};
                DisplayAllFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- Display the chosen BPM for the chosen signals ---
    elseif strcmpi(varargin{i},'DisplayOneBpm')
        if length(varargin) > i
            % Look for the signal list as the next input
            if iscell(varargin{i+1})
                DisplayList = varargin{i+1};
                DisplayOneFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- Offset structure ---
    elseif strcmpi(varargin{i},'OffsetStructure')
        if length(varargin) > i
            % Look for the structure as the next input
            if isstruct(varargin{i+1})
                OffsetStructure = varargin{i+1};
                OffsetStructureFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- Offset file ---
    elseif strcmpi(varargin{i},'OffsetFileName')
        if length(varargin) > i
            % Look for the file name as the next input
            if ischar(varargin{i+1})
                OffsetFileName = varargin{i+1};
                OffsetFileFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s''. Default value will be used.\n',varargin{i});
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
        
        % --- Diag ---
    elseif strcmpi(varargin{i},'Diag')
        DiagFlag = 1;
        varargin(i) = [];
        
        % --- NoDiag ---
    elseif strcmpi(varargin{i},'NoDiag')
        DiagFlag = 0;
        varargin(i) = [];
        
    end
    
    
end

if ~isempty(varargin)
    disp('Last parameter(s) not recognised :')
    disp(varargin)
    warning('bpm_tbt_demixing:UnknownParameterDetected','Unknown parameter(s) detected')
end


%% Using the input structure OR loading a default .mat file

if FilterFileFlag == 1
    
    % --- Avoiding extension '.mat' problem in FilterFileName argument ---
    if isscalar(regexp(FilterFileName,'.mat')) == 1
        FilterFileName = FilterFileName(1:end-4);
    end
    
    % --- Loading the filter structure from the '.mat' file ---
    eval(['load ' FilterFileName ';']);
    %LSN
    FilterStructure = FilterStructure;
    %eval(['FilterStructure = ' FilterFileName ';']);
    
end

if InputFileFlag == 1
    
    % --- Avoiding extension '.mat' problem in InputFileName argument ---
    if isscalar(regexp(InputFileName,'.mat')) == 1
        InputFileName = InputFileName(1:end-4);
    end
    
    % --- Loading the Input structure from the '.mat' file ---
    eval(['load ' InputFileName ';']);
    eval(['InputStructure = ' InputFileName ';']);
    
end

if OffsetFileFlag == 1
    
    % --- Avoiding extension '.mat' problem in InputFileName argument ---
    if isscalar(regexp(OffsetFileName,'.mat')) == 1
        OffsetFileName = OffsetFileName(1:end-4);
    end
    
    % --- Loading the Input structure from the '.mat' file ---
    eval(['load ' OffsetFileName ';']);
    eval(['OffsetStructure = ' OffsetFileName ';']);
    OffsetStructureFlag = 1;
    
end

% If no input data selected, check if Online data are available
if ~InputFileFlag && ~InputStructureFlag
    AO = getfamilydata('BPMx');
    if strcmp(AO.Monitor.Mode,'Online') && isfield(AO,'BPM_offset')
        InputStructure = getbpmrawdata([],'AllData','Struct','DD');
    end
end

% If no input data can be selected, error
if ~exist('InputStructure','var')
    error('No input data detected and unable to get Online data')
end

if OffsetFileFlag == 0 || OffsetStructureFlag == 0
    if ~isfield(InputStructure,'Offset')
        error('BPM offsets are required in the input data')
    end
    OffsetStructure = InputStructure.Offset;
    OffsetStructureFlag = 1;
end

% --- Preparation of OutputStructure ---
OutputStructure = InputStructure;
OutputStructure.FilterStructure = FilterStructure;


%% Echo of all parameters used (used as control in the Command Window)

if EchoFlag
    
    % --- Echo for parameters used ---
    fprintf('\n ===== bpm_tbt_demixing Start ===== \n');
    
    % --- Echo for no problem detected ---
    if ProblemDetectionFlag == 0;
        fprintf('No parameter problem detected \n');
    end
    
    % --- Echo for the filter parameter ---
    if FilterStructureFlag == 0
        fprintf(' - FilterFileName   : %s \n',FilterFileName);
    elseif FilterStructureFlag == 1
        fprintf(' - FilterStructure  : Parameter of function \n');
    end
    
    % --- Echo for the input signals parameter ---
    if InputFileFlag == 1
        fprintf(' - InputFileName    : %s \n',InputFileName);
    elseif InputStructureFlag == 1
        fprintf(' - InputStructure   : Parameter of function \n');
    else
        fprintf(' - InputStructure   : getbpmrawdata([],''AllData'',''Struct'',''DD'') \n');
    end
    
    % --- Echo for the offset parameter ---
    if OffsetStructureFlag == 0 && OffsetFileFlag == 0
        fprintf(' - OffsetStructure  : InputStructure.Offset \n');
    elseif OffsetStructureFlag == 1
        fprintf(' - OffsetStructure  : Parameter of function \n');
    elseif OffsetFileFlag == 1
        fprintf(' - OffsetStructure  : %s \n',OffsetFileName');
    end
    
    % ---  Echo for display parameters ---
    if DisplayAllFlag == 0 && DisplayOneFlag == 0 ;
        DisplayText = 'Off';
    elseif DisplayAllFlag == 1 || DisplayOneFlag == 1 ;
        DisplayText = ['BPM = ' num2str(DisplayList{1}) '   Signal(s) ='];
        for Signal = 2:length(DisplayList)
            DisplayText = [DisplayText ' ' DisplayList{Signal}]; %#ok<AGROW>
        end
    end
    fprintf(' - Display          : %s \n', DisplayText);
    
end


%% Check if there is a filter and offset corresponding to the input device

% --- DeviceAssociationList is a list assigning each signal to the corresponding filter and offset ---
DeviceAssociationList = zeros(length(InputStructure.DeviceName),3);
DeviceAssociationList(:,1) = 1:length(InputStructure.DeviceName); % First column is the number of BPM
DeviceAssociationList(:,2) = NaN; % Second column is the number of the filter
DeviceAssociationList(:,3) = NaN; % Third column is the number of the offset

for InputDevice = 1:length(InputStructure.DeviceName)
    
    % --- Loop for the filters ---
    for FilterName = 1:length(FilterStructure.DeviceName)
        if strcmp(InputStructure.DeviceName{InputDevice},FilterStructure.DeviceName{FilterName});
            DeviceAssociationList(InputDevice,2) = FilterName;
            break;
        end
    end
    if isnan(DeviceAssociationList(InputDevice,2))
        fprintf('\nWARNING : No filter found for DeviceName = ''%s''  (number %d in the list)\n',InputStructure.DeviceName{InputDevice},InputDevice);
    end
    
    % --- Loop for the offsets ---
    for OffsetName = 1:length(OffsetStructure.DeviceName)
        if strcmp(InputStructure.DeviceName{InputDevice},OffsetStructure.DeviceName{OffsetName});
            DeviceAssociationList(InputDevice,3) = OffsetName;
            break;
        end
    end
    if isnan(DeviceAssociationList(InputDevice,3))
        fprintf('\nWARNING : No offsets found for DeviceName = ''%s''  (number %d in the list)\n',InputStructure.DeviceName{InputDevice},InputDevice);
    end
    
end

OutputStructure.DeviceAssociationList = DeviceAssociationList;


K_x = 11.4; % mm
K_z = 11.4; % mm

% --- Coefficient in the electronic block as : V(i) =  K_IQ * sqrt( I(i)^2 + Q(i)^2 ) * Coeff(i)
K_IQ = 1.646760125;


%% Filtering process from experimental filters

% All variables containing "_" at the end are remplaced at each loop
% iteration corresponding to the number of BMP. Used to simplify the
% expressions.

for Bpm = 1:size(InputStructure.DeviceList,1)
    %% Filtering all the signals
    
    
    % --- Assignment for experimental filters ---
    if ~isnan(DeviceAssociationList(Bpm,2))
        Filter_exp_ = FilterStructure.DeviceExperimentalFilters(DeviceAssociationList(Bpm,2),:);
    else
        Filter_exp_ = zeros(1,size(FilterStructure.DeviceExperimentalFilters,2));
        Filter_exp_(:) = NaN;
    end
    
    
    % --- Assignment for simulated filters ---
    Filter_sim_ = FilterStructure.SimulatedFilter;
    
    
    SignalList = {'X','Z','Sum','Q','Va','Vb','Vc','Vd','Ia','Ib','Ic','Id','Qa','Qb','Qc','Qd'};
    
    %% 2014-10-29 LSN fake field to save disk if Flag XZSumVx
    Mainfield = fieldnames(InputStructure.Data);
    [C ~] = intersect(Mainfield,SignalList);
    isize = size(InputStructure.Data.X);
    if length(C) < length(SignalList)
        InputStructure.Data.Q = zeros(isize);
        InputStructure.Data.Ia = zeros(isize);
        InputStructure.Data.Ib = zeros(isize);
        InputStructure.Data.Ic = zeros(isize);
        InputStructure.Data.Id = zeros(isize);
        InputStructure.Data.Qa = zeros(isize);
        InputStructure.Data.Qb = zeros(isize);
        InputStructure.Data.Qc = zeros(isize);
        InputStructure.Data.Qd = zeros(isize);

        OutputStructure = InputStructure;
    end
   
    %% End of fake
    
    for Signal = 1:length(SignalList)
        
        
        % --- Assignment for input signals ---
        Input_signal_ = InputStructure.Data.(SignalList{Signal})(Bpm,:);
        
        % --- Filtering process using experimental filters ---
        Convolution_exp_ = conv(Input_signal_,Filter_exp_,'same');
        
        % --- Filtering process using simulated filter ---
        Convolution_sim_ = conv(Input_signal_,Filter_sim_,'same');
        
        % --- Alignment of the maximum (Part1) ---
        Convolution_exp_(1) = [];
        Convolution_sim_(end) = [];
        
        Convolution_exp_(1:FilterStructure.NumberOfPoints) = NaN;
        Convolution_exp_(end-FilterStructure.NumberOfPoints:end) = NaN;
        
        Convolution_sim_(1:FilterStructure.NumberOfPoints) = NaN;
        Convolution_sim_(end-FilterStructure.NumberOfPoints:end) = NaN;
        
        
        % --- Gathering the result in the OutputStructure ---
        OutputStructure.Data.(genvarname([SignalList{Signal} '_exp']))(Bpm,:) = Convolution_exp_;
        OutputStructure.Data.(genvarname([SignalList{Signal} '_sim']))(Bpm,:) = Convolution_sim_;
        
        
    end
    
    
    %% --- Rebuilding X and Z using V(i)_exp, V(i)_sim and IQ signals ---
    
    
    if OffsetStructureFlag == 1
        
        if DiagFlag
                % --- Assigning temporary shortcuts ---
                Va_ = OutputStructure.Data.Va(Bpm,:);
                Vb_ = OutputStructure.Data.Vb(Bpm,:);
                Vc_ = OutputStructure.Data.Vc(Bpm,:);
                Vd_ = OutputStructure.Data.Vd(Bpm,:);
        end
        
        % --- Assigning temporary shortcuts ---
        Va_exp_ = OutputStructure.Data.Va_exp(Bpm,:);
        Vb_exp_ = OutputStructure.Data.Vb_exp(Bpm,:);
        Vc_exp_ = OutputStructure.Data.Vc_exp(Bpm,:);
        Vd_exp_ = OutputStructure.Data.Vd_exp(Bpm,:);
        
        Va_sim_ = OutputStructure.Data.Va_sim(Bpm,:);
        Vb_sim_ = OutputStructure.Data.Vb_sim(Bpm,:);
        Vc_sim_ = OutputStructure.Data.Vc_sim(Bpm,:);
        Vd_sim_ = OutputStructure.Data.Vd_sim(Bpm,:);
        
        Ia_exp_ = OutputStructure.Data.Ia_exp(Bpm,:);
        Ib_exp_ = OutputStructure.Data.Ib_exp(Bpm,:);
        Ic_exp_ = OutputStructure.Data.Ic_exp(Bpm,:);
        Id_exp_ = OutputStructure.Data.Id_exp(Bpm,:);
        
        Ia_sim_ = OutputStructure.Data.Ia_sim(Bpm,:);
        Ib_sim_ = OutputStructure.Data.Ib_sim(Bpm,:);
        Ic_sim_ = OutputStructure.Data.Ic_sim(Bpm,:);
        Id_sim_ = OutputStructure.Data.Id_sim(Bpm,:);
        
        Qa_exp_ = OutputStructure.Data.Qa_exp(Bpm,:);
        Qb_exp_ = OutputStructure.Data.Qb_exp(Bpm,:);
        Qc_exp_ = OutputStructure.Data.Qc_exp(Bpm,:);
        Qd_exp_ = OutputStructure.Data.Qd_exp(Bpm,:);
        
        Qa_sim_ = OutputStructure.Data.Qa_sim(Bpm,:);
        Qb_sim_ = OutputStructure.Data.Qb_sim(Bpm,:);
        Qc_sim_ = OutputStructure.Data.Qc_sim(Bpm,:);
        Qd_sim_ = OutputStructure.Data.Qd_sim(Bpm,:);
        
        % --- Assignment of offset ---
        if ~isnan(DeviceAssociationList(Bpm,3))
            Coeff_block_a_ = OffsetStructure.block_offset(DeviceAssociationList(Bpm,3),3);
            Coeff_block_b_ = OffsetStructure.block_offset(DeviceAssociationList(Bpm,3),4);
            Coeff_block_c_ = OffsetStructure.block_offset(DeviceAssociationList(Bpm,3),5);
            Coeff_block_d_ = OffsetStructure.block_offset(DeviceAssociationList(Bpm,3),6);
            Coeff_libera_a_ = OffsetStructure.libera_RF_offset(DeviceAssociationList(Bpm,3),3);
            Coeff_libera_b_ = OffsetStructure.libera_RF_offset(DeviceAssociationList(Bpm,3),4);
            Coeff_libera_c_ = OffsetStructure.libera_RF_offset(DeviceAssociationList(Bpm,3),5);
            Coeff_libera_d_ = OffsetStructure.libera_RF_offset(DeviceAssociationList(Bpm,3),6);
        else
            Coeff_block_a_ = NaN;
            Coeff_block_b_ = NaN;
            Coeff_block_c_ = NaN;
            Coeff_block_d_ = NaN;
            Coeff_libera_a_ = NaN;
            Coeff_libera_b_ = NaN;
            Coeff_libera_c_ = NaN;
            Coeff_libera_d_ = NaN;
        end
        
        if DiagFlag
                % --- X_V ---
                OutputStructure.Data.X_V(Bpm,:) = K_x*((Va_ + Vd_) - (Vb_ + Vc_))...
                    ./(Va_ + Vb_ + Vc_ + Vd_);
        
                % --- Z_V ---
                OutputStructure.Data.Z_V(Bpm,:) = K_z*((Va_ + Vb_) - (Vc_ + Vd_))...
                    ./(Va_ + Vb_ + Vc_ + Vd_);
        end
        
        Ia_ = OutputStructure.Data.Ia(Bpm,:);
        Ib_ = OutputStructure.Data.Ib(Bpm,:);
        Ic_ = OutputStructure.Data.Ic(Bpm,:);
        Id_ = OutputStructure.Data.Id(Bpm,:);
        
        Qa_ = OutputStructure.Data.Qa(Bpm,:);
        Qb_ = OutputStructure.Data.Qb(Bpm,:);
        Qc_ = OutputStructure.Data.Qc(Bpm,:);
        Qd_ = OutputStructure.Data.Qd(Bpm,:);
        
        % --- X_V_exp ---
        OutputStructure.Data.X_V_exp(Bpm,:) = K_x*((Va_exp_ + Vd_exp_) - (Vb_exp_ + Vc_exp_))...
            ./(Va_exp_ + Vb_exp_ + Vc_exp_ + Vd_exp_);
        
        % --- X_V_sim ---
        OutputStructure.Data.X_V_sim(Bpm,:) = K_x*((Va_sim_ + Vd_sim_) - (Vb_sim_ + Vc_sim_))...
            ./(Va_sim_ + Vb_sim_ + Vc_sim_ + Vd_sim_);
        
        % --- Z_V_exp ---
        OutputStructure.Data.Z_V_exp(Bpm,:) = K_z*((Va_exp_ + Vb_exp_) - (Vc_exp_ + Vd_exp_))...
            ./(Va_exp_ + Vb_exp_ + Vc_exp_ + Vd_exp_);
        
        % --- Z_V_sim ---
        OutputStructure.Data.Z_V_sim(Bpm,:) = K_z*((Va_sim_ + Vb_sim_) - (Vc_sim_ + Vd_sim_))...
            ./(Va_sim_ + Vb_sim_ + Vc_sim_ + Vd_sim_);
        
        % --- V(i)_IQ ---
        OutputStructure.Data.Va_IQ(Bpm,:) = K_IQ*sqrt(Ia_.^2 + Qa_.^2)*Coeff_block_a_*Coeff_libera_a_;
        OutputStructure.Data.Vb_IQ(Bpm,:) = K_IQ*sqrt(Ib_.^2 + Qb_.^2)*Coeff_block_b_*Coeff_libera_b_;
        OutputStructure.Data.Vc_IQ(Bpm,:) = K_IQ*sqrt(Ic_.^2 + Qc_.^2)*Coeff_block_c_*Coeff_libera_c_;
        OutputStructure.Data.Vd_IQ(Bpm,:) = K_IQ*sqrt(Id_.^2 + Qd_.^2)*Coeff_block_d_*Coeff_libera_d_;
        
        if DiagFlag
                Va_IQ_ = OutputStructure.Data.Va_IQ(Bpm,:);
                Vb_IQ_ = OutputStructure.Data.Vb_IQ(Bpm,:);
                Vc_IQ_ = OutputStructure.Data.Vc_IQ(Bpm,:);
                Vd_IQ_ = OutputStructure.Data.Vd_IQ(Bpm,:);
        
                % --- X_IQ ---
                OutputStructure.Data.X_IQ(Bpm,:) = K_x*((Va_IQ_ + Vd_IQ_) - (Vb_IQ_ + Vc_IQ_))...
                    ./(Va_IQ_ + Vb_IQ_ + Vc_IQ_ + Vd_IQ_);
        
                % --- Z_IQ ---
                OutputStructure.Data.Z_IQ(Bpm,:) = K_z*((Va_IQ_ + Vb_IQ_) - (Vc_IQ_ + Vd_IQ_))...
                    ./(Va_IQ_ + Vb_IQ_ + Vc_IQ_ + Vd_IQ_);
        end
        
        % --- V(i)_IQ_exp ---
        OutputStructure.Data.Va_IQ_exp(Bpm,:) = K_IQ*sqrt(Ia_exp_.^2 + Qa_exp_.^2)*Coeff_block_a_*Coeff_libera_a_;
        OutputStructure.Data.Vb_IQ_exp(Bpm,:) = K_IQ*sqrt(Ib_exp_.^2 + Qb_exp_.^2)*Coeff_block_b_*Coeff_libera_b_;
        OutputStructure.Data.Vc_IQ_exp(Bpm,:) = K_IQ*sqrt(Ic_exp_.^2 + Qc_exp_.^2)*Coeff_block_c_*Coeff_libera_c_;
        OutputStructure.Data.Vd_IQ_exp(Bpm,:) = K_IQ*sqrt(Id_exp_.^2 + Qd_exp_.^2)*Coeff_block_d_*Coeff_libera_d_;
        
        % --- V(i)_IQ_sim ---
        OutputStructure.Data.Va_IQ_sim(Bpm,:) = K_IQ*sqrt(Ia_sim_.^2 + Qa_sim_.^2)*Coeff_block_a_*Coeff_libera_a_;
        OutputStructure.Data.Vb_IQ_sim(Bpm,:) = K_IQ*sqrt(Ib_sim_.^2 + Qb_sim_.^2)*Coeff_block_b_*Coeff_libera_b_;
        OutputStructure.Data.Vc_IQ_sim(Bpm,:) = K_IQ*sqrt(Ic_sim_.^2 + Qc_sim_.^2)*Coeff_block_c_*Coeff_libera_c_;
        OutputStructure.Data.Vd_IQ_sim(Bpm,:) = K_IQ*sqrt(Id_sim_.^2 + Qd_sim_.^2)*Coeff_block_d_*Coeff_libera_d_;
        
        Va_IQ_exp_ = OutputStructure.Data.Va_IQ_exp(Bpm,:);
        Vb_IQ_exp_ = OutputStructure.Data.Vb_IQ_exp(Bpm,:);
        Vc_IQ_exp_ = OutputStructure.Data.Vc_IQ_exp(Bpm,:);
        Vd_IQ_exp_ = OutputStructure.Data.Vd_IQ_exp(Bpm,:);
        
        Va_IQ_sim_ = OutputStructure.Data.Va_IQ_sim(Bpm,:);
        Vb_IQ_sim_ = OutputStructure.Data.Vb_IQ_sim(Bpm,:);
        Vc_IQ_sim_ = OutputStructure.Data.Vc_IQ_sim(Bpm,:);
        Vd_IQ_sim_ = OutputStructure.Data.Vd_IQ_sim(Bpm,:);
        
        
        % --- X_IQ_exp ---
        OutputStructure.Data.X_IQ_exp(Bpm,:) = K_x*((Va_IQ_exp_ + Vd_IQ_exp_) - (Vb_IQ_exp_ + Vc_IQ_exp_))...
            ./(Va_IQ_exp_ + Vb_IQ_exp_ + Vc_IQ_exp_ + Vd_IQ_exp_);
        
        % --- X_IQ_sim ---
        OutputStructure.Data.X_IQ_sim(Bpm,:) = K_x*((Va_IQ_sim_ + Vd_IQ_sim_) - (Vb_IQ_sim_ + Vc_IQ_sim_))...
            ./(Va_IQ_sim_ + Vb_IQ_sim_ + Vc_IQ_sim_ + Vd_IQ_sim_);
        
        % --- Z_IQ_exp ---
        OutputStructure.Data.Z_IQ_exp(Bpm,:) = K_z*((Va_IQ_exp_ + Vb_IQ_exp_) - (Vc_IQ_exp_ + Vd_IQ_exp_))...
            ./(Va_IQ_exp_ + Vb_IQ_exp_ + Vc_IQ_exp_ + Vd_IQ_exp_);
        
        % --- Z_IQ_sim ---
        OutputStructure.Data.Z_IQ_sim(Bpm,:) = K_z*((Va_IQ_sim_ + Vb_IQ_sim_) - (Vc_IQ_sim_ + Vd_IQ_sim_))...
            ./(Va_IQ_sim_ + Vb_IQ_sim_ + Vc_IQ_sim_ + Vd_IQ_sim_);
        
    end
    
    
end

%% Add offsets

if DiagFlag
    SignalList = {'_V','_V_exp','_V_sim','_IQ','_IQ_exp','_IQ_sim'};
else
    SignalList = {'_V_exp','_V_sim','_IQ_exp','_IQ_sim'};
end

for Signal = 1:length(SignalList)
    bpm_add_offsets_OutputStructure = bpm_add_offsets(...
        OutputStructure.Data.(['X' SignalList{Signal}]) ,...
        OutputStructure.Data.(['Z' SignalList{Signal}]) ,...
        InputStructure.DeviceList ,...
        OffsetStructure ,...
        'DD' );
    OutputStructure.Data.(['X' SignalList{Signal}]) = bpm_add_offsets_OutputStructure.X_with_offset;
    OutputStructure.Data.(['Z' SignalList{Signal}]) = bpm_add_offsets_OutputStructure.Z_with_offset;
end


%% End of function

% --- Alignment of the maximum (Part2) ---

if DiagFlag
    SignalList = {'X','Z','Sum','Q','Va','Vb','Vc','Vd','Ia','Ib','Ic','Id','Qa','Qb','Qc','Qd','X_V','Z_V','X_IQ','Z_IQ','Va_IQ','Vb_IQ','Vc_IQ','Vd_IQ'};
else
    SignalList = {'X','Z','Sum','Q','Va','Vb','Vc','Vd','Ia','Ib','Ic','Id','Qa','Qb','Qc','Qd','Va_IQ','Vb_IQ','Vc_IQ','Vd_IQ'};
end

for Signal = 1:length(SignalList)
    OutputStructure.Data.(SignalList{Signal})(:,end) = [];
end


% --- End ---

DataTime = now;

AM = OutputStructure;

AM.DataDescriptor = 'Demixed TbT data';
AM.CreatedBy = mfilename;
AM.TimeStamp = datestr(DataTime);

ErrorFlag = 0;
tout = etime(clock, t0);


%% Plot


% --- Plot signals for all BPM ---
if DisplayAllFlag == 1
    
    for Signal = 1:length(DisplayList)
        
        figure('Name',sprintf('%s',DisplayList{Signal}),'NumberTitle','off');
        hold all;
        for Bpm = 1:length(InputStructure.DeviceName)
            plot(OutputStructure.Data.(DisplayList{Signal})(Bpm,:));
        end
        
    end
    
    % --- Plot signals for one selected BPM ---
elseif DisplayOneFlag == 1
    
    for InputDevice = 1:length(InputStructure.DeviceName)
        if strcmp(InputStructure.DeviceName{InputDevice},DisplayList{1});
            BPM_Number_Display = InputDevice;
            break;
        end
    end
    
    figure('Name',sprintf('%s',DisplayList{1}),'NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97]);
    hold all;
    for Signal = 2:length(DisplayList)
        plot(OutputStructure.Data.(DisplayList{Signal})(BPM_Number_Display,:),'LineWidth',2);
        Legend{Signal-1} = DisplayList{Signal}; %#ok<AGROW>
    end
    set(legend(Legend),'Interpreter','none');
    set(gca,'FontSize',20)
    removemarge
    axis tight
    %xlim([0 50]);
    
end


%% End of function

if EchoFlag
    fprintf(' ===== bpm_tbt_demixing Done ===== \n\n');
end


end