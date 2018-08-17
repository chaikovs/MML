function varargout = getbpmrawdata(varargin)
% GETBPMRAWDATA - Get turn by turn data for  BPM
%
%  INPUTS
%  1. Device List bpm number (scalar or vector) list ([] means all valid BPM)
%
%  Optional input arguments
%  2. Optional display {Default}
%     'Display'     - Plot BPM data X,Z, Sum, Q 
%     {'NoDisplay'} - No plotting
%  3. 'NoArchive' - No file archive {Default}
%     'Archive'   - Save a BPM data structure to \<Directory.BPMData>\<DispArchiveFile><Date><Time>.mat
%                   To change the filename, included the filename after the 'Archive', '' to browse
%                   Structure output  is forced
%  4. 'Struct'    - Return out as a structure
%  5. 'Freezing'  - Buffer freezing mechanism 
%     'NoFreezing'
%  6. 'Group'  - TAngo group mecanism 
%     'NoGroup'
%  7. {'XZSum'}  - Select only X Z and Sum signals
%      'NoXZSum' or 'AllData' - Select only X Z Sum Q, Va, Vb, Vc and Vd signals
%
%  OUTPUTS
%  structure output if 'Struct' precised
%  AM
%
%  Vector output
%  1. X - Horizontal data
%  2. Z - Vertical data
%  3. Sum - Sum signal data
%  4. Q  - Quadrusspole signal data
%  5. Va - electrode data
%  6. Vb - electrode data
%  7. Vc - electrode data
%
%  EXAMPLES
%  1. Display BPM 18
%      getbpmrawdata(18)
%  2. Display all valid BPM and output data as a structure
%      getbpmrawdata([],'Struct');
%  3. Output all valid BPM data
%      [X Z Sum Q Va Vb Vc Vd] = getbpmrawdata([],'NoDisplay');
%  4. Archives BPM 17 and 18 w/o displaying
%     getbpmrawdata([17; 18],'Archive','NoDisplay');
%  5. Archives BPM 17 and 18 w/o displaying w/ buffer freezing mechanism
%     getbpmrawdata([17; 18],'Archive','NoDisplay','Freezing');
%  6. Idem via devicelist
%     getbpmrawdata([17 1; 18 1],'Archive','NoDisplay','Freezing');
%
% See Also anabpmfirstturn, convertBPMData2CERNformat

%
% Written by Laurent S. Nadolski
% 17 May 2006: group added

% TODO freezing mechanism
OldLiberaFlag = 0; % Booster version
DisplayFlag   = 0;
ArchiveFlag   = 0;
StructureFlag = 0;
FreezingFlag  = 0;
GroupFlag     = 1;
XZSumFlag     = 1;
FileName      = '';
varargin2     = {};
SAFlag = 0;

if ~exist('DeviceName','var')
    DeviceName = [];
end

% Flag factory
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'SA')
        SAFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Group')
        GroupFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoGroup')
        GroupFlag = 0;
        % Marie-Agnes modification 23 mai 2006
        varargin2 = {varargin2{:} varargin{i}};
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Archive')
        ArchiveFlag = 1;
        StructureFlag = 1;
        if length(varargin) > i
            % Look for a filename as the next input
            if ischar(varargin{i+1})
                FileName = varargin{i+1};
                varargin(i+1) = [];
            end
        end
%        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoArchive')
        ArchiveFlag = 0;
%        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Struct')
        StructureFlag = 1;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Freezing')
        FreezingFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoFreezing')
        FreezingFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'XZSum')
        XZSumFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoXZSum') || strcmpi(varargin{i},'AllData')
        XZSumFlag = 0;
        varargin(i) = [];
    end
end

Machine = getsubmachinename;

switch Machine
    case 'OldBooster'  % Modif Alex shuntant l'ancien mode BPM booster 28-08-06 
        OldLiberaFlag = 1;
    otherwise
        OldLiberaFlag = 0;
end

AO = getfamilydata('BPMx');

% if empty select all valid BPM
if isempty(varargin)
    num = 1:length(AO.DeviceName);
    DeviceList = family2dev('BPMx');
else
    DeviceList = varargin{1};
    if size(DeviceList,2) == 2 % DeviceList
        %%
    else %% Element list        
        DeviceList = elem2dev('BPMx',DeviceList);
    end    
end

% Status one devices
Status     = family2status('BPMx',DeviceList);
DeviceList = DeviceList(find(Status),:);

if isempty(DeviceList)
    disp('All BPM not valid')
    AM = -1;
    return;
end


%% Buffer freezing
% Enable freezing mechanism

if (FreezingFlag)

    if OldLiberaFlag
        Enablecmd   = 'EnableBufferFreezing';
        UnFreezecmd = 'UnFreezeBuffer';
    else
        Enablecmd   = 'EnableDDBufferFreezing';
        UnFreezecmd = 'UnFreezeDDBuffer';
    end

    disp([mfilename ': Enabling freezing mecanism']);
    for k = 1:length(DeviceList)
        tango_command_inout2(DeviceName{k},Enablecmd);
    end
    disp([mfilename ': Freezing BPM: pseudo synchronism']);
    for k = 1:length(DeviceList)
        tango_command_inout2(DeviceName{k},UnFreezecmd);
    end
end

% Group definition
if GroupFlag
    if ~SAFlag
        if OldLiberaFlag
            attr_name = ...
                {'XPosVector','ZPosVector', 'QuadVector', 'SumVector', ...
                'VaVector', 'VbVector', 'VcVector', 'VdVector'};
        else
            if ~XZSumFlag
                attr_name = ...
                    {'XPosDD','ZPosDD', 'SumDD', 'QuadDD', ...
                    'VaDD', 'VbDD', 'VcDD', 'VdDD'};
            else
                attr_name = {'XPosDD','ZPosDD', 'SumDD'};
            end
        end
    else
            if ~XZSumFlag
                attr_name = ...
                    {'XPosSA','ZPosSA', 'SumSA', 'QuadSA', ...
                    'VaSA', 'VbSA', 'VcSA', 'VdSA'};
            else
                attr_name = {'XPosSA','ZPosSA', 'SumSA'};
            end
    end

    GroupId =getfamilydata('BPMx', 'GroupId');

    % get all BPMs
    DeviceListFull = family2dev('BPMx',0);
    % disable all
    tango_group_disable_device2(GroupId, dev2tangodev('BPMx',DeviceListFull));
    % Enable only valid BPM
    tango_group_enable_device2(GroupId, dev2tangodev('BPMx',DeviceList));

    % Stimulate connexion TANGO bug
    tango_group_ping(GroupId);

    if ~SAFlag
        % Check buffer size
        rep = tango_group_read_attribute2(GroupId,'DDBufferSize',0);

        % take minimum turn number for common buffersize
        turnNumber = min(rep);
        if mean(rep) ~= rep(1)
            warning(['Buffer size not the same for all BPMs: max= %d turns,  min= %d turns', ...
                '\nCheck BPM buffer size for all BPMs'],max(rep), min(rep));
        end
    else
        turnNumber = 1;
    end
    
    rep = tango_group_read_attributes(GroupId,attr_name,0);
    if tango_error == -1
        tango_print_error_stack
        return
    end
    
    if rep.has_failed
        disp('Error when reading data for BPM');
        for k = 1:length(rep.dev_replies),
            if rep.dev_replies(k).has_failed
                fprintf('Error with device %s\n',rep.dev_replies(k).dev_name)
                tango_print_error_stack_as_it_is(rep.dev_replies(k).attr_values(1).error)
            end
        end        
        error('Programme %s Stopped', mfilename);
    else
        kActiveBPM = zeros(size(rep.dev_replies,2),1);

        AM.DeviceName = cell(size(rep.dev_replies,2),1);
        % initialize data
        % read turnNumber on first BPM and assume all BPM have the same number of turns
        %turnNumber  = readattribute([char(family2tangodev('BPMx', DeviceList(1,:))) '/DDBufferSize']);
        AM.Data.X   = zeros(size(rep.dev_replies,2),turnNumber); 
        AM.Data.Z   = zeros(size(rep.dev_replies,2),turnNumber); 
        AM.Data.Sum = zeros(size(rep.dev_replies,2),turnNumber); 
        
        if ~XZSumFlag
            AM.Data.Q  = zeros(size(rep.dev_replies,2),turnNumber);
            AM.Data.Va = zeros(size(rep.dev_replies,2),turnNumber);
            AM.Data.Vb = zeros(size(rep.dev_replies,2),turnNumber);
            AM.Data.Vc = zeros(size(rep.dev_replies,2),turnNumber);
            AM.Data.Vd = zeros(size(rep.dev_replies,2),turnNumber);
        end
        
        % Loop over all BPM
        for kbpm = 1:size(rep.dev_replies,2),
            kActiveBPM(kbpm) = rep.dev_replies(kbpm).is_enabled;
            
            % Selected just active BPM
            if rep.dev_replies(kbpm).is_enabled
                %rep.dev_replies(k).attr_values(1).dev_name;
                AM.DeviceName{kbpm} = rep.dev_replies(kbpm).attr_values(1).dev_name;
                if length(rep.dev_replies(kbpm).attr_values(1).value) < turnNumber
                    error('BPM %s datalength is %d <= %d', AM.DeviceName{kbpm}, ...
                        length(rep.dev_replies(kbpm).attr_values(1).value), turnNumber);
                end
                AM.Data.X(kbpm,:)   = rep.dev_replies(kbpm).attr_values(1).value(1:turnNumber);
                AM.Data.Z(kbpm,:)   = rep.dev_replies(kbpm).attr_values(2).value(1:turnNumber);
                AM.Data.Sum(kbpm,:) = rep.dev_replies(kbpm).attr_values(3).value(1:turnNumber);

                % If more than X, Z, SUM is needed
                if ~XZSumFlag
                    AM.Data.Q(kbpm,:)   = rep.dev_replies(kbpm).attr_values(4).value(1:turnNumber);
                    AM.Data.Va(kbpm,:)  = rep.dev_replies(kbpm).attr_values(5).value(1:turnNumber);
                    AM.Data.Vb(kbpm,:)  = rep.dev_replies(kbpm).attr_values(6).value(1:turnNumber);
                    AM.Data.Vc(kbpm,:)  = rep.dev_replies(kbpm).attr_values(7).value(1:turnNumber);
                    AM.Data.Vd(kbpm,:)  = rep.dev_replies(kbpm).attr_values(8).value(1:turnNumber);
                end
                %%%%%%%%%%% modification
                klast = kbpm;
                %%%%%%%%%%%%%%%%%%%%%%%%
           
                % Display Data X Z SUM
                if DisplayFlag
                    figure
                    subplot(3,1,1)
                    plot(AM.Data.X(kbpm,:))
                    ylabel('X (mm)')
                    grid on

                    subplot(3,1,2)
                    plot(AM.Data.Z(kbpm,:))
                    ylabel('Z (mm)')
                    grid on

                    subplot(3,1,3)
                    plot(AM.Data.Sum(kbpm,:))
                    ylabel('SUM')
                    xlabel('turn number')
                    grid on
                    addlabel(1,0,datestr(clock));
                    suptitle(sprintf('Turn by turn data for %s',AM.DeviceName{kbpm}))
                end % Display loop
            end % enabled BPM
        end % BPM loop
        
        % Selected only data for asked BPMs 
        AM.DeviceName(find(1-kActiveBPM)) = []; % Remove empty data BPM
        
        % Store data in structure
        kgoodBPM = find(kActiveBPM);
        
        % Slected only valid data, ie. for selectged BPM, other are zeros
        AM.Data.X   = AM.Data.X(kgoodBPM,:);
        AM.Data.Z   = AM.Data.Z(kgoodBPM,:);
        AM.Data.Sum = AM.Data.Sum(kgoodBPM,:);
        
        if ~XZSumFlag
            AM.Data.Q  = AM.Data.Q(kgoodBPM,:);
            AM.Data.Va = AM.Data.Va(kgoodBPM,:);
            AM.Data.Vb = AM.Data.Vb(kgoodBPM,:);
            AM.Data.Vc = AM.Data.Vc(kgoodBPM,:);
            AM.Data.Vd = AM.Data.Vd(kgoodBPM,:);
        end
        
        % add description data
        AM.TimeStamp = datestr(now);
        AM.DataDescriptor = ['Turn by turn data for ' getsubmachinename];
        AM.CreatedBy = mfilename;
        AM.DeviceList = DeviceList;
        AM.DeviceName = AM.DeviceName';
        AM.Dcct = getdcct;
    end
else
    %% loop of bpm list
    if size(DeviceList,1) > 1
        AM.DeviceList=[];
        for k = 1:length(DeviceList)
            AM0 = getbpmrawdata(DeviceList(k,:),varargin2{:},'Struct');
            try
                AM.DeviceName{k} = AM0.DeviceName{:};
                AM.Data.X(k,:) = AM0.Data.X(:); AM.Data.Z(k,:) = AM0.Data.Z(:);
                AM.Data.Sum(k,:) = AM0.Data.Sum(:); 
                if ~XZSumFlag
                    AM.Data.Q(k,:)  = AM0.Data.Q(:);
                    AM.Data.Va(k,:) = AM0.Data.Va(:); AM.Data.Vb(k,:) = AM0.Data.Vb(:);
                    AM.Data.Vc(k,:) = AM0.Data.Vc(:); AM.Data.Vd(k,:) = AM0.Data.Vd(:);
                end
                AM.TimeStamp = datestr(now);
                AM.DataDescriptor = ['Turn by turn data for ' getsubmachinename];
                AM.CreatedBy = mfilename;
                AM.DeviceList = [AM.DeviceList; AM0.DeviceList];
            catch
                switch lasterr
                    case 'Subscripted assignment dimension mismatch.'
                        error('BPM do not have the same number of samples !!!\n see BPM %s', AM.DeviceName{k})
                    otherwise
                        fprintf('error %s\n', lasterr)
                end
            end
        end

        if (FreezingFlag)

            % Disable freezing mechanism
            if OldLiberaFlag
                Disablecmd = 'DisableBufferFreezing';
            else
                Disablecmd = 'DisableDDBufferFreezing';
            end

            disp([mfilename ': disabling buffer freezing for BPM'])
            for k = 1:length(DeviceList)
                tango_command_inout2(DeviceName{k}, Disablecmd);
            end
        end

    else
        %% Loop for one BPM
        AO = getfamilydata('BPMx');
        DeviceName = family2tangodev('BPMx',DeviceList);

        if OldLiberaFlag
            attr_name = ...
                {'XPosVector','ZPosVector', 'QuadVector', 'SumVector', ...
                'VaVector', 'VbVector', 'VcVector', 'VdVector'};
        else
            if ~XZSumFlag
                attr_name = ...
                    {'XPosDD','ZPosDD', 'QuadDD', 'SumDD', ...
                    'VaDD', 'VbDD', 'VcDD', 'VdDD'};
            else
                attr_name = {'XPosDD','ZPosDD', 'SumDD'};
            end
        end



        rep = tango_read_attributes2(DeviceName{:},attr_name);

        X   = rep(1).value;
        Z   = rep(2).value;
        Sum = rep(3).value;
        if ~XZSumFlag
            Q   = rep(4).value;
            Va  = rep(5).value;
            Vb  = rep(6).value;
            Vc  = rep(7).value;
            Vd  = rep(8).value;
        end
        %% Display part

        if DisplayFlag
            figure
            subplot(3,1,1)
            plot(X)
            ylabel('X (mm)')
            grid on

            subplot(3,1,2)
            plot(Z)
            ylabel('Z (mm)')
            grid on

            subplot(3,1,3)
            plot(Sum)
            ylabel('SUM')
            xlabel('turn number')
            grid on

            addlabel(1,0,datestr(clock));
            suptitle(sprintf('Turn by turn data for %s',DeviceName{:}))
        end

        if StructureFlag % Build up structure            
            AM.DeviceList = DeviceList;           
            AM.DeviceName = DeviceName;
            AM.Data.X   = X;
            AM.Data.Z   = Z;
            AM.Data.Sum = Sum;
            if ~XZSumFlag
                AM.Data.Q   = Q;
                AM.Data.Va  = Va;
                AM.Data.Vb  = Vb;
                AM.Data.Vc  = Vc;
                AM.Data.Vd  = Vd;
            end
            %time stamp of recording
            AM.TimeStamp = datestr(now);
            AM.DataDescriptor = ['Turn by turn data for ' getfamilydata('Machine')];
            AM.CreatedBy  = mfilename;
            AM.DeviceList = DeviceList;
        end
    end
end

if ArchiveFlag
    % filling up data
    % Archive data structure
    if isempty(FileName)
        FileName = appendtimestamp('BPMTurnByTurn');
        DirectoryName = getfamilydata('Directory','BPMData');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot') 'BPM', filesep];
        else
            % Make sure default directory exists
            DirStart = pwd;
            [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
            cd(DirStart);
        end
        [DirectoryName FileName]
        [FileName, DirectoryName] = uiputfile('*.mat', 'Select FileName', [DirectoryName FileName]);
        if FileName == 0
            ArchiveFlag = 0;
            disp('   BPM measurement canceled.');
            FileName='';
            return
        end
        FileName = [DirectoryName, FileName];
    elseif FileName == -1
        FileName = appendtimestamp(getfamilydata('Default', 'BPMArchiveFile'));
        DirectoryName = getfamilydata('Directory','BPMData');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot') 'BPM', filesep];
        end
        FileName = [DirectoryName, FileName];
    end

    save(FileName,'AM');

end

% Build up structure 
if StructureFlag
    varargout{1} = AM;
else
    if exist('AM','var') % not nice but it works
        varargout{1} = AM.Data.X;   varargout{2}  =  AM.Data.Z;
        varargout{3} = AM.Data.Sum;
        if ~XZSumFlag
            varargout{4} =  AM.Data.Q;
            varargout{5} = AM.Data.Va;  varargout{6}  =  AM.Data.Vb;
            varargout{7} = AM.Data.Vc;  varargout{8}  =  AM.Data.Vd;
        end
    else
        varargout{1} = X;   varargout{2} =   Z;
        varargout{3} = Sum;
        if ~XZSumFlag
            varargout{4} =  Q;
            varargout{5} = Va;  varargout{6} =  Vb;
            varargout{7} = Vc;  varargout{8} =  Vd;
        end
    end
end
