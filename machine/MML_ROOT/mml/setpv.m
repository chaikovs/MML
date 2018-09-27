function ErrorFlag = setpv(varargin)
%SETPV - Setpoint change of the online system or model
%
%  FamilyName Method
%  ErrorFlag = setpv(Family, Field, NewSP, DeviceList, WaitFlag)
%
%  Data Structure
%  ErrorFlag = setpv(DataStructure, WaitFlag)
%
%  ChannelName (EPICS/TANGO) Method
%  ErrorFlag = setpv(TangoName, NewSP, WaitFlag)
%  ErrorFlag = setpv(ChannelName, NewSP, WaitFlag)
%  ErrorFlag = setpv(ChannelName, Field, NewSP, WaitFlag)
%
%  CommonName Method
%  ErrorFlag = setpv(CommonNames, NewSP, WaitFlag)
%  ErrorFlag = setpv(CommonNames, Field, NewSP, WaitFlag)
%  ErrorFlag = setpv(Family, Field, NewSP, CommonNames, WaitFlag)
%
%  INPUTS
%  1. Family - FamilyName
%              Data Structure
%              Channel Name or matrix of Channel Names (see note #5)
%              Tango Name or matrix of Tango Names
%              AcceleratorObject
%              Use Family=[] in CommonName method to search all Families
%              (or Cell Array of inputs)
%
%  2. Field - AcceleratorObject Field name ('Monitor', 'Setpoint', etc)
%             {Default: 'Monitor' or '' for ChannelNames method}
%             If Family is a cell array then Field must be a cell array
%
%  3. NewSP - New Setpoints or cell array of Setpoints
%             Note: Present, only LabCA can handle string setpoints.  String setpoints
%                   will fail if hw2physics or physics2hw are needed.
%
%  4. DeviceList - ([Sector Device #] or [element #]) {Default or empty list: whole family}
%                  Note: all numerical inputs must be column vectors
%     CommonName - Common name can replace a DeviceList (scalar or vector outputs)
%
%  5. WaitFlag - 0    -> return immediately {Default}
%                > 0  -> wait until ramping is done then adds an extra delay equal to WaitFlag
%                = -1 -> wait until ramping is done
%                = -2 -> wait until ramping is done then adds an extra delay for fresh data
%                        from the BPMs
%                = -3 -> wait until ramping is done then adds an extra delay for fresh data
%                        from the tune measurement system
%                = -4 -> wait until ramping is done then wait for a carriage return
%     Note: For channel names, it is assumed the ramp time is immediate.
%
%  6. Units flag overrides
%     'Physics'  - Use physics  units
%     'Hardware' - Use hardware units
%
%  7. Mode flag overrides
%     'Online' - Set data online
%     'Model'  - Set data on the model
%     'Manual' - Set data manually
%
%  8. 'Abs' or 'Absolute'   - Absolute setpoint change {Default}
%     'Inc' or 'Incremental' - Incremental setpoint change
%
%  OUTPUTS
%  1. ErrorFlag - 0   -> OK
%                else -> error or warning condition occurred
%     Note: ErrorFlag is only used if AD.ErrorWarningLevel < 0, otherwise a Matlab error
%           in issued.  Use try;catch statements to catch the errors.
%
%  NOTES
%  1. For data structure inputs:
%     Family     = DataStructure.FamilyName (This field must exist)
%     Field      = DataStructure.Field      (Field can be overridden on the input line)
%     NewSP      = DataStructure.Data       (NewSP can be overridden on the input line)
%     DeviceList = DataStructure.DeviceList (DeviceList can be overridden on the input line)
%     Units      = DataStructure.Units      (Units can be overridden on the input line)
%     (The Mode field is ignored!)
%
%  2. The number of colomns of NewSP and DeviceList must be equal,
%     or NewSP must be a scalar.  If NewSP is a scalar, then all
%     devices in DeviceList will be set to the same value.
%
%  3. When using cell array all inputs must be the same size cell array
%     and the output will also be a cell array.  Field and WaitFlag can be
%     cells but they don't have to be.
%
%  4. ChannelName method:
%     a. Always Online!
%     b. The optional Field input is added as a .Field to the channel name
%     c. If use setpv(ChannelName, NewSP, WaitFlag) then NewSP must a numeric.
%        Use setpv(ChannelName, '',NewSP, WaitFlag) if NewSP is a string.
%
%  5. For cell array inputs:
%     a. Input 1 defines the maximum size of all cells
%     b. The cell array size must be 1 or equal to the number of cell in input #1
%     c. WaitFlag can be a cell but it doesn't have to be.
%
%  6. WaitFlag
%     a. If no change is seen on the AM then an error will occur.  The tolerance for this
%        may need to be changed depending on the accelerator (edit the end of this function to do so)
%     b. The delay for WaitFlag = -2 is in the AD.  It is often better to use the FreshDataFlag when
%        getting BPM data but the data must to noisy for this to work.
%
%  7. Strings - when setting string the Field input must exist otherwise the setpoint will be
%               confused for a Field.
%
%  8. If say Golden is a software field in the MML structure in the BPMx family, then 
%     setpv('BPMx','Golden', NewValue, DeviceList) will set the data in that field. 
%
%  EXAMPES
%  1. setpv('HCM','Setpoint',1.23);               Sets the entire HCM family to 1.23
%  2. setpv({'HCM','VCM'},'Setpoint',{10.4,5.3}); Sets the entire HCM family to 10.4 and VCM family to 5.3
%  3. setpv('HCM','Setpoint',1.23,[1 3]);    Simple DeviceList method
%  4. setpv('HCM','Setpoint',1.23, 3);       Simple ElementList method
%  5. setpv(AO('HCM'),'Setpoint',1.5,[1 2]);     If AO is a properly formatted AcceleratorObject Structure
%                                                    then this sets the 1st sector, 2nd element to 1.5
%  6. setpv('HCM','Setpoint',1.23,'1CX3');   CommonName method with Family specified (spear3 naming convection)
%  7. setpv([],'Setpoint',1.23,'1CX3');      CommonName method without Family (spear3 naming convection)
%
%  See also getam, getsp, getpv, setsp, steppv, stepsp, setpvmodel, setpvonline
%
%  Written by Greg Portmann


% Defaults
WaitFlagDefault = 0;
FieldDefault = 'Setpoint';


%%%%%%%%%%%%%%%%%
% Input Parsing %
%%%%%%%%%%%%%%%%%
Field = FieldDefault;
IncrementalFlag = 0;
DeviceList = [];
WaitFlag = [];
ModeFlag = '';
UnitsFlag = '';
InputFlags = {};
InputFlags2 = {};

for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignor structures
    elseif iscell(varargin{i})
        % Ignor cells
    elseif isa(varargin{i},'AccObj')
        AccObj1 = struct(varargin{i});
        Families = fieldnames(AccObj1);
        j = 0;
        for k = 1:length(Families)
            if ~isempty(AccObj1.(Families{k}))
                j = j + 1;
                tmpcell{j} = AccObj1.(Families{k});
            end
        end
        if length(tmpcell) == 1
            varargin{i} = tmpcell{1};
        else
            varargin{i} = tmpcell;
        end
    elseif strcmpi(varargin{i},'struct')
        % Remove and ignor
        varargin(i) = [];
    elseif strcmpi(varargin{i},'numeric')
        % Remove and ignor
        varargin(i) = [];
    elseif strcmpi(varargin{i},'simulator') || strcmpi(varargin{i},'model')
        ModeFlag = 'SIMULATOR';
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Online')
        ModeFlag = 'Online';
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Manual')
        ModeFlag = 'Manual';
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Special')
        ModeFlag = 'Special';
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'physics')
        UnitsFlag = 'Physics';
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'hardware')
        UnitsFlag = 'Hardware';
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Inc') || strcmpi(varargin{i},'Incremental')
        IncrementalFlag = 1;
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Abs') || strcmpi(varargin{i},'Absolute')
        IncrementalFlag = 0;
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'String')
        % Remove and ignor
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Retry')
        InputFlags = [InputFlags varargin(i)];
        InputFlags2 = [InputFlags2 varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoRetry')
        InputFlags = [InputFlags varargin(i)];
        InputFlags2 = [InputFlags2 varargin(i)];
        varargin(i) = [];
    end
end

if isempty(varargin)
    error('Not enough inputs');
end

Family = varargin{1};


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CELL OR CELL ARRAY INPUT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if iscell(varargin{1})
    % Iterate on each cell
    % ErrorFlag = setpv(Family, Field, NewSP, DeviceList, WaitFlag)
    % ErrorFlag = setpv(DataStructure, WaitFlag)
    % ErrorFlag = setpv(ChannelName, NewSP)
    % ErrorFlag = setpv(Family, Field, NewSP, CommonNames, WaitFlag)

    % Set everything with WaitFlag==0
    DoItAgainFlag = 0;
    ErrorFlag = 0;
    for i = 1:size(varargin{1},1)
        for j = 1:size(varargin{1},2)

            % Build the input line
            for k = 1:length(varargin)
                if ~iscell(varargin{k})
                    Inputs1{1,k} = varargin{k};
                elseif length(varargin{k}) == 1
                    Inputs1{1,k} = varargin{k}{1};
                elseif (size(varargin{k},1) == size(varargin{1},1)) && (size(varargin{k},2) == size(varargin{1},2))
                    Inputs1{1,k} = varargin{k}{i,j};
                else
                    error('When using cells, all the cells must be the same size or length 1 (repeated).');
                end
            end

            % Remove WaitFlag on first set if WaitFlag~=0 on any cell
            if isstruct(varargin{1}{i,j})
                if length(Inputs1) >= 2
                    if ischar(Inputs1{2})
                        % Inputs1{2} might be 'setpoint' due to setsp
                        if length(Inputs1) >= 3
                            if Inputs1{3} ~= 0
                                DoItAgainFlag = 1;
                                Inputs1{2} = 0;
                            end
                            Inputs1(3) = [];
                        else
                            DoItAgainFlag = 1;
                        end
                    else
                        if Inputs1{2} ~= 0
                            DoItAgainFlag = 1;
                            Inputs1{2} = 0;
                        end
                    end
                else
                    DoItAgainFlag = 1;
                end
            elseif length(Inputs1) == 2
                % For ChannelName just set once
            elseif length(Inputs1) == 3
                DoItAgainFlag = 1;
                Inputs1{4} = [];
                Inputs1{5} = 0;
            elseif length(Inputs1) == 4
                DoItAgainFlag = 1;
                Inputs1{5} = 0;
            elseif length(Inputs1) >= 5
                if Inputs1{5} ~= 0
                    DoItAgainFlag = 1;
                    Inputs1{5} = 0;
                end
            end
            
            % Make the setpoint change
            ErrorFlagNew = setpv(Inputs1{:}, InputFlags{:});
            ErrorFlag = ErrorFlag | any(ErrorFlagNew);
        end
    end

    % Wait for the waitflag
    if DoItAgainFlag
        for i = 1:size(varargin{1},1)
            for j = 1:size(varargin{1},2)

                % Build the input line
                for k = 1:length(varargin)
                    if ~iscell(varargin{k})
                        Inputs1{1,k} = varargin{k};
                    elseif length(varargin{k}) == 1
                        Inputs1{1,k} = varargin{k}{1};
                    elseif (size(varargin{k},1) == size(varargin{1},1)) && (size(varargin{k},2) == size(varargin{1},2))
                        Inputs1{1,k} = varargin{k}{i,j};
                    else
                        error('When using cells, all the cells must be the same size or length 1 (repeated).');
                    end
                end

                % Make the setpoint change
                ErrorFlagNew = setpv(Inputs1{:}, InputFlags{:});
                ErrorFlag = ErrorFlag | any(ErrorFlagNew);
            end
        end
    end

    return
end
%%%%%%%%%%%%%%%%%%
% End cell input %
%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMMONNAME - Commonname input with no family input %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(Family)
    % Common names with Family = []
    % [], Field, NewSP, CommonNames
    
    if length(varargin) >= 2
        if ischar(varargin{2})
            Field = varargin{2};
            varargin(2) = [];
        end
    end
    if isempty(Field)
        Field = FieldDefault;
    end
    if length(varargin) >= 2
        NewSP = varargin{2};
    else
        error('New setpoint not found on input line');
    end
    if length(varargin) >= 3
        CommonNames = varargin{3};
    else
        CommonNames = [];
    end
    if length(varargin) >= 4
        WaitFlag = varargin{4};
    end
    if isempty(WaitFlag)
        WaitFlag = WaitFlagDefault;
    end

    if size(NewSP,1) == 1
        % Set all elements to same value
        NewSP = ones(size(CommonNames,1),1) * NewSP;
    elseif size(NewSP,1) == size(CommonNames,1)
        % Input OK
    else
        error('Size of NewSP must be equal to the number of Commonnames or a scalar!');
    end

    % Convert all the common names to Family and Device lists
    [DeviceList, Family, ErrorFlag] = common2dev(CommonNames, Field);

    % If all the families are the same then compress them
    FamilyTest = unique(Family, 'rows');

    if size(FamilyTest, 1) == 1
        % 1 Family, Multiple devices are ok
        ErrorFlag = setpv(FamilyTest, Field, NewSP, DeviceList, WaitFlag, InputFlags{:});
    else
        % Multiple families (loop)
        % It has to be in a loop for the simulator and to pickup special functions
        for i = 1:size(Family,1)
            ErrorFlag1 = setpv(Family(i,:), Field, NewSP(i,:), DeviceList(i,:), 0, InputFlags{:});
            ErrorFlag = ErrorFlag | ErrorFlag1;
        end
        if WaitFlag
            for i = 1:size(Family,1)
                ErrorFlag1 = setpv(Family(i,:), Field, NewSP(i,:), DeviceList(i,:), WaitFlag, InputFlags{:});
                ErrorFlag = ErrorFlag | ErrorFlag1;
            end
        end
    end
    
    return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End CommonName input with no family input %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parce inputs depending on Data structure, AO structure, Family, ChannelName method %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isstruct(Family)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % STRUCTURE INPUTS - Data structure or AO structure %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if isfield(varargin{1},'FamilyName') && isfield(varargin{1},'Field')
        % setpv(DataStruct, Field, NewSP, WaitFlag)
        %   Select FamilyName, DeviceList, Units from the structure (if not on the input line)
        %   Mode in the structure is ignored
        Family = varargin{1}.FamilyName;

        % The only input for a Data Structure can Field and WaitFlag
        Field = '';
        if length(varargin) >= 2
            if ischar(varargin{2})
                Field = varargin{2};
                varargin(2) = [];
            end
        end
        if isempty(Field)
            Field = varargin{1}.Field;
        end

        NewSP = varargin{1}.Data;
        DeviceList = varargin{1}.DeviceList;

        if length(varargin) >= 2
           WaitFlag = varargin{2};
        end

        %if length(varargin) >= 2
        %    NewSP = varargin{2};
        %else
        %    NewSP = varargin{1}.Data;
        %end
        %if length(varargin) >= 3
        %    DeviceList = varargin{3};
        %else
        %    DeviceList = varargin{1}.DeviceList;
        %end
        %if length(varargin) >= 4
        %    WaitFlag = varargin{4};
        %end

        [FamilyIndex, AO] = isfamily(Family);

        % Change Units to the data structure units (command-line override comes latter)
        if isfield(AO, Field)
            AO.(Field).Units = varargin{1}.Units;
        end
        
        if FamilyIndex == 0
            error('Unknown family in the data structure');
        end

    elseif isfield(varargin{1},'FamilyName')
        % AO structure - use the AO structure directly
        % setpv(AO, Field, NewSP, DeviceList, WaitFlag)

        Field = '';
        if length(varargin) >= 2
            if ischar(varargin{2})
                Field = varargin{2};
                varargin(2) = [];
            end
        end
        if length(varargin) >= 2
            NewSP = varargin{2};
        else
            error('New setpoint not found on input line');
        end
        if length(varargin) >= 3
            DeviceList = varargin{3};
        else
            DeviceList = varargin{1}.DeviceList;
            iStatus = find(varargin{1}.Status == 0);
            DeviceList(iStatus,:) = [];
        end
        if length(varargin) >= 4
            WaitFlag = varargin{4};
        end

        FamilyIndex = 1;
        AO = Family;

    else
        error('Input #1 of unknown type');
    end

else

    % Family or ChannelName/TangoName is the only thing left
    [FamilyIndex, AO] = isfamily(Family);

    if FamilyIndex

        %%%%%%%%%%%%%%
        % FamilyName %
        %%%%%%%%%%%%%%
        if length(varargin) >= 2
            if ischar(varargin{2})
                Field = varargin{2};
                varargin(2) = [];
            end
        end
        if isempty(Field)
            Field = FieldDefault;
        end
        if length(varargin) >= 2
            NewSP = varargin{2};
        else
            error('New setpoint not found on input line');
        end
        if length(varargin) >= 3
            DeviceList = varargin{3};
        end
        if length(varargin) >= 4
            WaitFlag = varargin{4};
        end
        if isempty(WaitFlag)
            WaitFlag = WaitFlagDefault;
        end

    else

        % Look to see if it's a channel name or a common name
        % Just check the first name so it's a faster test
        [DeviceListTest, FamilyTest] = common2dev(Family(1,:));

        if ~isempty(FamilyTest)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Common names where the family was the common name %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % The DeviceList should not be on the input line!

            if length(varargin) >= 2
                if ischar(varargin{2})
                    Field = varargin{2};
                    varargin(2) = [];
                end
            end
            if isempty(Field)
                Field = FieldDefault;
            end
            if length(varargin) >= 2
                NewSP = varargin{2};
            else
                error('New setpoint not found on input line');
            end
            if length(varargin) >= 3
                WaitFlag = varargin{3};
            end
            if isempty(WaitFlag)
                WaitFlag = WaitFlagDefault;
            end

            CommonNames = Family;

            if size(NewSP,1) == 1
                % Set all elements to same value
                NewSP = ones(size(CommonNames,1),1) * NewSP;
            elseif size(NewSP,1) == size(CommonNames,1)
                % Input OK
            else
                error('Size of NewSP must be equal to the number of Commonnames or a scalar!');
            end

            % Convert all the common names to Family and Device lists
            [DeviceList, Family, ErrorFlag] = common2dev(CommonNames);

            % If all the families are the same then compress them
            FamilyTest = unique(Family, 'rows');

            if size(FamilyTest, 1) == 1
                % 1 Family, Multiple devices are ok
                ErrorFlag = setpv(FamilyTest, Field, NewSP, DeviceList, WaitFlag, InputFlags{:});
            else
                % Multiple families (loop)
                % It has to be in a loop for the simulator and to pickup special functions
                for i = 1:size(Family,1)
                    ErrorFlag1 = setpv(Family(i,:), Field, NewSP(i,:), DeviceList(i,:), 0, InputFlags{:});
                    ErrorFlag = ErrorFlag | ErrorFlag1;
                end
                if WaitFlag
                    for i = 1:size(Family,1)
                        ErrorFlag1 = setpv(Family(i,:), Field, NewSP(i,:), DeviceList(i,:), WaitFlag, InputFlags{:});
                        ErrorFlag = ErrorFlag | ErrorFlag1;
                    end
                end
            end
                   
            % Return for common names
           return
            
        else

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % CHANNEL NAME or TANGO NAME - Online Only %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            % setpv(ChannelName, Field, NewSP, WaitFlag)
            % setpv(ChannelName, Field, NewSP)
            % setpv(ChannelName, NewSP, WaitFlag)  % NewSP cannot be string for this case
            % setpv(ChannelName, NewSP)
            Field = '';
            if length(varargin) == 2
                % setpv(ChannelName, NewSP)
                NewSP = varargin{2};
            elseif length(varargin) >= 3
                if ischar(varargin{2})
                    Field = varargin{2};
                    varargin(2) = [];
                end
                NewSP = varargin{2};
            end

            if length(varargin) >= 3
                WaitFlag = varargin{3};
            else
                WaitFlag = [];
            end
            if isempty(WaitFlag)
                WaitFlag = WaitFlagDefault;
            end

            % Don't set NaN's for now???
            %iNaN = find(isnan(NewSP));
            %if ~isempty(iNaN)
            %    Family(iNaN,:) = [];
            %    NewSP(iNaN,:) = [];
            %end

        % Can't use overrides with channel / TANGO name method
            if ~isempty(UnitsFlag)
            error('You cannot change the units when using channel or attribute names.')
            end
            if ~(isempty(ModeFlag) | strcmpi(ModeFlag, 'Online'))
                error('Channel or Tango names only have an ''Online'' Mode.')
            end

        % Get rid of repeated & blank channel or attribute names
            [Family, i] = unique(Family, 'rows');
            if size(NewSP,1) ~= 1
                NewSP = NewSP(i,:);
            end
            if isempty(deblank(Family(1,:)))
                Family(1,:) = [];
                if size(NewSP,1) ~= 1
                    NewSP(1,:) = [];
                end
            end

            % Add Field to Family.Field
            if ~isempty(Field)
                Family = strcat(Family, ['.',Field]);
            end
            
            % Incremental change in the setpoint
            if IncrementalFlag
                % Note: ModeFlag, UnitsFlag are ignored for channel name inputs
                %NewSP = NewSP + getpv(Family);
                if size(NewSP,2) == 1
                    SPpresent = getpvonline(Family, '', 1);
                else
                    SPpresent = getpvonline(Family);
                end
                NewSP = NewSP + SPpresent;
            else
                if size(NewSP,1) == 1 && size(Family,1) > 1
                    % Set all elements to same value
                    NewSP = NewSP * ones(size(Family,1),1);
                end
            end


            %%%%%%%%%%%%
            % Set data %
            %%%%%%%%%%%%
            % Could add N-Steps here???
            ErrorFlag = setpvonline(Family, NewSP);


            % Add a delay based on the WaitFlag
            if WaitFlag > 0
                sleep(WaitFlag);
            elseif WaitFlag == -2
                [N, BPMDelay] = getbpmaverages;
                BPMDelay = 2.2 * max(BPMDelay);
                if ~isempty(BPMDelay)
                    sleep(BPMDelay);
                end
            elseif WaitFlag == -3
                TuneDelay = getfamilydata('TuneDelay');
                if ~isempty(TuneDelay)
                    sleep(TuneDelay);
                end
            elseif WaitFlag == -4
                tmp = input('   Setpoint changed.  Hit return ready. ');
            end

            return
        end
    end
end
% End input selection:  data structure, AO structure, family, commonname, and channelname method



%%%%%%%%%%%%%%%%%%%%%%%%%
% SET DATA FOR FAMILIES %
%%%%%%%%%%%%%%%%%%%%%%%%%

% Family = FamilyName or AO structure with DeviceList or CommonName List

if isempty(DeviceList)                   % This is a very important line, it determines the default behavior
    DeviceList = family2dev(Family);     % Default behavior comes from family2dev
    %DeviceList = family2dev(Family,1);  % Good status only
    %DeviceList = AO.DeviceList;         % All devices
end

% If DeviceList is a string it's a common name list
if ischar(DeviceList)
    DeviceList = common2dev(DeviceList, AO);
end

% Convert DeviceList format to ElementList format
if (size(DeviceList,2) == 1)
    DeviceList = elem2dev(Family, DeviceList);
end

if isempty(WaitFlag)
    WaitFlag = WaitFlagDefault;
end


% Look for command-line over rides
if ~isempty(UnitsFlag)
    AO.(Field).Units = UnitsFlag;
end
if ~isempty(ModeFlag)
    AO.(Field).Mode = ModeFlag;
end


if size(NewSP,1) == 1 && size(DeviceList,1) > 1
    % Set all elements to same value
    NewSP = NewSP * ones(size(DeviceList,1),1);

elseif size(NewSP,1) ~= size(DeviceList,1)
    % This is either an error or NewSP equals the number of power supplies (not magnets)
    [DeviceList, ii, jj] = unique(DeviceList, 'rows');
    [TangoNames, i, j] = unique(family2tango(Family, DeviceList), 'rows');
    
    if size(NewSP,1) == size(TangoNames,1)
        NewSP = NewSP(j);
        NewSP = NewSP(ii);
    else
        error('The number of setpoints does not equal the number of magnets or magnet power supplies.');
    end
end


% Incremental change in the setpoint
if IncrementalFlag
    SPold = getpv(Family, Field, DeviceList, AO.(Field).Units, AO.(Field).Mode, InputFlags2{:});
    if ~any(isnan(SPold))
        NewSP = NewSP + SPold;
    else
        ErrorFlag = -1;
        return;
    end
end


% Main call for all applications except ChannelName / TangoName method
ErrorFlag = local_setpv(AO, Field, NewSP, DeviceList, WaitFlag, InputFlags2{:});


%%%%%%%%%%%%%%%%
% End of setpv %
%%%%%%%%%%%%%%%%
return



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Main Function for Setting Data using the Accelerator Object  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ErrorFlag = local_setpv(AO, Field, NewSP, DeviceList, WaitFlag, varargin)
%  INPUTS
%  1. AO - the ACCELERATOR_OBJECT structure for the called family
%  2. Field - 'Monitor' or 'Setpoint'
%  3. NewSP - setpoint values
%  4. DeviceList - Device list 
%
%  OUTPUTS
%  1. ErrorFlag - 0 if OK, else 1
%
%  NOTES
%  1. AO comes directly from the main AcceleratorObject family
%  2. Field is which field to use
%  3. DeviceList is which device list to use
%  4. AO.DeviceList is the entire device list
%
%  Note: local_setpv can not be used for channel names


TimeOutPeriodOnWaitFlag = 10;  % Seconds of monitor not changing
ErrorFlag = 0;


% Don't set NaN's for now???
iNaN = find(isnan(NewSP));
if ~isempty(iNaN)
    NewSP(iNaN,:) = [];
    DeviceList(iNaN,:) = [];
end


% Check for empty device list
if isempty(DeviceList)
    AM = [];
    %fprintf('   WARNING:  No devices to get for Family %s\n', AO.FamilyName));
    return;
end


% Find the index for where the desired data is in the total device list
DeviceListTotal = AO.DeviceList;
[DeviceIndex, iNotFound] = findrowindex(DeviceList, DeviceListTotal);
if length(iNotFound) > 0
    % Device not found
    for i = 1:length(iNotFound)
        fprintf('   No devices to get for Family %s(%d,%d)\n', AO.FamilyName, DeviceList(i,1), DeviceList(i,2));
    end
    error(sprintf('%d Devices not found', length(iNotFound)));
end


% If Field is not found in the AO, it is unclear what to do next.
% I could error here, but it's convenient to try to set
% EPICS subfields or other simulator fields at this point.
if ~isfield(AO, Field)
    % Try to check it online or simulator
    if isfield(AO, 'Setpoint')
        Mode = getfamilydata(AO.FamilyName, 'Setpoint', 'Mode');
    elseif isfield(AO, 'Monitor')
        Mode = getfamilydata(AO.FamilyName, 'Monitor', 'Mode');
    else
        Mode = '';
    end
    if strcmpi(Mode,'Simulator') || strcmpi(Mode,'Model')
        ErrorFlag = setpvmodel(AO.FamilyName, Field, NewSP, DeviceList, 'Physics');
        return
    end


    % Try changing the suffix of the Monitor or Setpoint field
    if isfield(AO, 'Setpoint')
        Tango = family2tango(AO, 'Setpoint', DeviceList);
    elseif isfield(AO, 'Monitor')
        Tango = family2tango(AO, 'Monitor', DeviceList);
    else
        error(sprintf('Field %s not found for Family %s', Field, AO.FamilyName));
    end
    
    % Get rid of repeated & blank TANGO names
    [Tango, i] = unique(Tango, 'rows');
    if size(NewSP,1) ~= 1
        NewSP = NewSP(i,:);
    end
    if isempty(deblank(Tango(1,:)))
        Tango(1,:) = [];
        if size(NewSP,1) ~= 1
            NewSP(1,:) = [];
        end
    end

    if any(strcmpi(getfamilydata('Machine'),{'spear3','spear'}))
        % Change the last ':' Field 
        %i = findstr(Channel(1,:),':');
        %if ~isempty(i)
        %    Channel(:,i:end) = [];
        %end
        %ChannelNew = strcat(Channel, [':',Field]);

        % Since the location of ":" can be different in each row, loop
        ChannelNew = [];
        for j = 1:size(Channel,1)
            i = findstr(Channel(j,:),':');
            if isempty(i)
                % I'm not sure what to do if ":" is missing, I'm just add a ":"
                ChannelNew = strvcat(ChannelNew, [Channel(j,1:i), ':', Field]);
            else
                ChannelNew = strvcat(ChannelNew, [Channel(j,1:i), Field]);
            end
        end
        TangoNew = strcat(Tango, [':',Field]);
    else
        % Add a .Field 
        TangoNew = strcat(Tango, ['.',Field]);
    end
    
    
    ErrorFlag = setpvonline(TangoNew, NewSP, varargin{:});

    if WaitFlag > 0
        sleep(WaitFlag);
    elseif WaitFlag == -2
        [N, BPMDelay] = getbpmaverages;
        BPMDelay = 2.2 * max(BPMDelay);
        if ~isempty(BPMDelay)
            sleep(BPMDelay);
        end
    elseif WaitFlag == -3
        TuneDelay = getfamilydata('TuneDelay');
        if ~isempty(TuneDelay)
            sleep(TuneDelay);
        end
    elseif WaitFlag == -4
        tmp = input('   Setpoint changed.  Hit return ready. ');
    end
    return
end


% Extract 'Mode'
if isfield(AO.(Field), 'Mode')
    Mode = AO.(Field).Mode;
else
    Mode = 'Online';
end


% Check if Online should really be special
if strcmpi(Mode, 'Online')
   if isfield(AO.(Field), 'SpecialFunctionSet')
       Mode = 'Special';
   end
end


if ~isstruct(AO.(Field))
    % If it's not a structure that just set the field
    % Hardward and physics get ignored
    setfamilydata(NewSP, AO.FamilyName, Field, DeviceList);
    
elseif strcmpi(Mode,'Online')
    %%%%%%%%%% 
    % Online %
    %%%%%%%%%%


    % Could add N-Steps here???

    
    % Change to hardware units if in physics units
    if strcmpi(AO.(Field).Units, 'Physics')
        NewSP = physics2hw(AO.FamilyName, Field, NewSP, DeviceList);
    end

    if  strcmpi(AO.(Field).DataType,'scalar')
        
        ErrorFlag = setpvonline(AO.(Field).TangoNames(DeviceIndex,:), NewSP, varargin{:});
        
    elseif  strcmpi(AO.(Field).DataType,'vector')
        
        % There can only be one Tango name for DataType='Vector'
        TangName = deblank(AO.(Field).TangoNames(1,:));
        
        % Get the vector and only load what is requested
        FullVector = getpvonline(TangName);
        
        if isfield(AO.(Field), 'DataTypeIndex')
            FullVector(AO.(Field).DataTypeIndex(DeviceIndex)) = NewSP;
        else
            FullVector(DeviceIndex) = NewSP;
        end        
        
        % Vectorized put
        ErrorFlag = setpvonline(TangName, FullVector, varargin{:});

    else       
        % Not a scalar or vector 
        error(sprintf('Unknown DataType %s for family %s.', AO.(Field).DataType, AO.FamilyName));
    end 
    
    %%%%%%%%%%%%%%%%%%%%%%%
    % WaitFlag Processing %
    %%%%%%%%%%%%%%%%%%%%%%%
    if WaitFlag && WaitFlag~=-4

        t00 = gettime;
        [RunFlag, Delta0, Tol] = getrunflag(AO, Field, DeviceList);
        %fprintf('RunFlag:%d Delta=%f (Tol=%f)\n',RunFlag, Delta0, Tol); 
        RampRate = getramprate(AO, DeviceList, 'Hardware');

        if any(Tol == 0) || isempty(Tol)
            % Tol should not be set to zero, but if it is then base time-out on percentage of SP
            % This many not be a good criterion and may need to be adjusted based on the machine!!!
            TimeoutTol = NewSP / 200;   % .5 percent
        else
            % Check if the Delta has changed by at least a few tolerances in the last TimeOutPeriodOnWaitFlag seconds
            % This many not be a good criterion and may need to be adjusted based on the machine!!!
            TimeoutTol = 5 * Tol;

            % Or base on the ramprate
            %if ~isempty(RampRate) & ~any(isnan(RampRate))
            %    RR = max(abs(RampRate));
            %    if ~isnan(RR)
            %        % Base time-out on .1 what the monitor should have changed in TimeOutPeriodOnWaitFlag seconds
            %        TimeoutTol = .1 * RR * TimeOutPeriodOnWaitFlag;
            %    end
            %end
        end

        t0  = gettime;
        while any(RunFlag)
            % Pause a little so that the network doesn't get too thrashed
            sleep(.1);

            [RunFlag, Delta, Tol] = getrunflag(AO, Field, DeviceList);

            % Check if the Delta has changed in the last TimeOutPeriodOnWaitFlag seconds
            if gettime-t0 > TimeOutPeriodOnWaitFlag
                x = (abs(Delta) > Tol) & (abs(abs(Delta)-abs(Delta0)) <= TimeoutTol);
                if any(x)
                    TangoName = '';
                    for i = 1:length(x)
                        if x(i)
                            TangoNameNext = family2tango(AO.FamilyName,  DeviceList(i,:));
                            if ~strcmp(TangoName, TangoNameNext)
                                if isfield(AO,'Monitor') & isfield(AO,'Setpoint')
                                    fprintf('   %s(%d,%d) SP-AM > Tol and the monitor does not appear to be changing.\n', AO.FamilyName,  DeviceList(i,1), DeviceList(i,2));
                                    SP = getsp(AO.FamilyName,  DeviceList(i,:));
                                    AM = getam(AO.FamilyName,  DeviceList(i,:));
                                    fprintf('           Setpoint = %f,  Monitor = %f,  SP-AM = %f,  getrunflag Delta = %f,  Tolerance = %f\n', SP, AM, SP-AM, Delta(i), Tol(i));
                                else
                                    fprintf('   %s(%d,%d) timed-out waiting for run flag to change.\n', AO.FamilyName,  DeviceList(i,1), DeviceList(i,2));
                                end
                            end
                            TangoName = TangoNameNext;
                        end
                    end

                    % Decide whether or not to error on a SP-AM problem
                    ErrorWarningLevel = getfamilydata('ErrorWarningLevel');
                    if isempty(ErrorWarningLevel) || ErrorWarningLevel >= 0
                        error(sprintf('Time-Out:  Monitor did not appear to be changing for the last %.1f seconds.', TimeOutPeriodOnWaitFlag));
                    elseif ErrorWarningLevel == -1
                        warning('Time-Out:  Monitor did not appear to be changing for the last %.1f seconds.', TimeOutPeriodOnWaitFlag);
                    elseif ErrorWarningLevel == -2
                        try
                            % Make some noise
                            %sound(cos(1:10000));
                        catch
                        end
                        CommandInput = questdlg( ...
                            {'The run flag is not changing.  This is often a', ...
                             'Setpoint-Monitor tolerance problem.  Either manually', ...
                             'varify that the magnet is at the proper setpoint and', ...
                             ' ', ...
                             'Continue - recheck the run condition', ...
                             'Stop - issue an error and see if there is error handling', ...
                             'Ignore the problem and push on'}, ...
                            'SETPV Question', ...
                            'Continue', ...
                            'Stop', ...
                            'Ignore', ...
                            'Continue');
                        switch CommandInput
                            case 'Stop'
                                error('SP-AM error in setpv.');
                            case 'Continue'
                            case 'Ignore'
                                RunFlag = 0;
                        end
                    else % ErrorWarningLevel <= -3
                        % Do nothing
                        ErrorFlag = -1;
                    end
                end

                % Reset Delta0 and timeout timer
                Delta0 = Delta;
                t0 = gettime;
            end
        end

        % Add extra delay for continued ramping due to the size of the tolerance
        if isempty(Tol) && isempty(Delta0)
            % If Tol and Delta) are empty, then WaitFlag is probably not wanted
            %if WaitFlag < 0
            %    WaitFlag = 0;
            %end
        else
            % In case Tol is large, use the min of Tol and the present Delta SP-AM
            if any(isnan(RampRate))
                % For lack of a better idea: If the RampRate is not defined, calculate what it has been doing.
                iNaN = find(isnan(RampRate));
                RampRate(iNaN) = abs(Delta0(iNaN) / (gettime-t00));
            end
            if isempty(RampRate)
                % For lack of a better idea: If the RampRate is not defined, calculate what it has been doing.
                RampRate = abs(Delta0 / (gettime-t00));
            end
            if any(RampRate == 0)
            else
                T = min([(Tol./RampRate) abs(Delta0./RampRate)],[],2);
                if ~isempty(max(T))
                    sleep(1.05*max(T));
                end
            end
        end
    end
    
    if WaitFlag && ~strcmpi(Mode,'Simulator')
        % Add a delay based on the WaitFlag
        if WaitFlag > 0
            sleep(WaitFlag);
        elseif WaitFlag == -2
            [N, BPMDelay] = getbpmaverages;
            BPMDelay = 2.2 * max(BPMDelay);
            if ~isempty(BPMDelay)
                sleep(BPMDelay);
            end
        elseif WaitFlag == -3
            TuneDelay = 2.2 * getfamilydata('TuneDelay');
            if ~isempty(TuneDelay)
                sleep(TuneDelay);
            end
        elseif WaitFlag == -4
            tmp = input('   Setpoint changed.  Hit return ready. ');
        end
    end


elseif strcmpi(Mode,'Manual')
    %%%%%%%%%%%%%%%
    % Manual mode %
    %%%%%%%%%%%%%%%
    
    % Change to hardware units if in physics units
    if strcmpi(AO.(Field).Units, 'Physics')
        NewSP = physics2hw(AO.FamilyName, Field, NewSP, DeviceList);
    end

    % NewSP is always in hardware units at this point    
    for i = 1:length(DeviceIndex)
        if strcmpi(AO.(Field).Units, 'Hardware')
            fprintf('   Manually set:  %s(%d,%d) = %f [%s]\n', AO.FamilyName, AO.DeviceList(DeviceIndex(i),1), AO.DeviceList(DeviceIndex(i),2), NewSP(i), AO.(Field).HWUnits);
        else
            NewSP(i) = hw2physics(AO.FamilyName, Field, NewSP(i), AO.DeviceList(DeviceIndex(i),:));
            fprintf('   Manually set:  %s(%d,%d) = %f [%s]\n', AO.FamilyName, AO.DeviceList(DeviceIndex(i),1), AO.DeviceList(DeviceIndex(i),2), NewSP(i), AO.(Field).PhysicsUnits);
        end
    end
    if length(NewSP) == 1
        input(sprintf('   Set device manually and hit return '));
    else
        input(sprintf('   Set these devices manually and hit return '));
    end    
    fprintf('   \n');
    
elseif strcmpi(Mode,'Special')
    %===================================
    % Special mode (evaluate a function)
    %===================================
    
    % Could add N-Steps here???

    % Change to hardware units if in physics units
    if strcmpi(AO.(Field).Units, 'Physics')
        NewSP = physics2hw(AO.FamilyName, Field, NewSP, DeviceList);
    end
    
    if isfield(AO.(Field), 'SpecialFunctionSet')
        ErrorFlag = feval(AO.(Field).SpecialFunctionSet, AO.FamilyName, Field, NewSP, DeviceList, WaitFlag); 
    else
        error(sprintf('No special function specified for Family %s (setpv).', AO.FamilyName));
    end
    
elseif strcmpi(Mode,'Simulator')
    %==================
    % AT simulator mode
    %==================
    
    ErrorFlag = setpvmodel(AO, Field, NewSP, DeviceList, AO.(Field).Units);
    
else
    error(sprintf('Unknown mode % for family %s.', Mode, AO.FamilyName));
end


