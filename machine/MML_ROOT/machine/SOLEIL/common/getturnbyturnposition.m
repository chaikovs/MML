function varargout = getturnbyturnposition(varargin)
% getturnbyturnposition - Gets turn by turn data for  BPM
%
%  INPUTS
%  1. Device List bpm number (scalar or vector) list ([] means all valid BPM)
%
%  Optional input arguments
%  2. Optional display
%     'Display'   - Plot BPM data X,Z, Sum, Q 
%     'NoDisplay' - No plotting
%  3. 'NoArchive' - No file archive {Default}
%     'Archive'   - Save a dispersion data structure to \<Directory.BPMData>\<DispArchiveFile><Date><Time>.mat
%                   To change the filename, included the filename after the 'Archive', '' to browse
%                   Structure output  is forced
%  4. 'Struct'    - Return out as a structure
%  5. 'Freezing'  - Buffer freezing mechanism 
%     'NoFreezing'
%  6. 'Group'  - TAngo group mecanism 
%     'NoGroup'
%
%  7. 'XZSumFlag' - Select only X Z and Sum signals
%
%  OUTPUTS
%  structure output if 'Struct' precised
%  AM
%
%  vector output
%  1. X - Horizontal data
%  2. Z - Vertical data
%
%  EXAMPLES
%  1. Display BPM 18
%      getturnbyturnposition(18)
%  2. Display all valid BPM and output data as a structure
%      getturnbyturnposition([],'Struct');
%  3. Output all valid BPM data
%      [X Z Sum Q Va Vb Vc Vd] = getturnbyturnposition([],'NoDisplay');
%  4. Archives BPM 17 and 18 w/o displaying
%     getturnbyturnposition([17; 18],'Archive','NoDisplay');
%  5. Archives BPM 17 and 18 w/o displaying w/ buffer freezing mechanism
%     getturnbyturnposition([17; 18],'Archive','NoDisplay','Freezing');
%  6. Idem via devicelist
%     getturnbyturnposition([17 1; 18 1],'Archive','NoDisplay','Freezing');
%
% See Also anabpmfirstturn

%
% Written by Laurent S. Nadolski
% 17 May 2006: group added

% TODO freezing mechanism
OldLiberaFlag = 0; % Booster version
DisplayFlag   = 1;
ArchiveFlag   = 0;
StructureFlag = 0;
FreezingFlag  = 0;
GroupFlag     = 1;
XZSumFlag     = 0;
FileName      = '';
varargin2     = {};

if ~exist('DeviceName','var')
    DeviceName = [];
end

for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin2 = {varargin2{:} varargin{i}};
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
    end
end

Machine = getfamilydata('SubMachine');

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

%
% % read BPM number of samples
% % If all not the same stop program and ask action to user
% for k = 1:length(num)
%     modestr{k} = char(readattribute([AO.DeviceName{num(k)} '/Mode']));
% end
% 
% for k = 1:length(num)
%     sampleNumber(k) = readattribute([AO.DeviceName{num(k)} '/NumSamples']);
% end
% 
% notTheSame = sampleNumber-sampleNumber(1);
% 
% if ~all(strcmp(modestr,modestr{1}))
%    disp([mfilename ' STOP!']); 
%    error('Not all BPM in the same mode')
%    return;
% end
% 
% if (sum(notTheSame) ~= 0)
%    disp([mfilename ' STOP!']); 
%    error('Not all BPM with the same number of samples')
%    return;
% end

%% Buffer freezing
% Enable freezing mechanism


if GroupFlag
    if ~XZSumFlag
        attr_name = ...
            {'XPosDD','ZPosDD', 'QuadDD', 'SumDD', ...
            'VaDD', 'VbDD', 'VcDD', 'VdDD'};
    else
        attr_name = {'XPosDD','ZPosDD', 'SumDD'};
    end

    GroupId = tango_group_id('BPM');

    DeviceListFull = family2dev('BPMx',0);
    tango_group_disable_device2(GroupId, dev2tangodev('BPMx',DeviceListFull));
    tango_group_enable_device2(GroupId, dev2tangodev('BPMx',DeviceList));
    %rep = tango_group_read_attributes(GroupId,attr_name,0);

    % Stimulate connexion TANGO bug
    tango_group_ping(GroupId);
    rep = tango_group_read_attributes(GroupId,attr_name,0);
    
    if tango_error == -1
        tango_print_error_stack
        return,
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
        vect = [];
        for k = 1:length(rep.dev_replies),
            % modification Marie-Agnes 23 mai 2006 c'est moche bien sur
            vect = [vect ; rep.dev_replies(k).is_enabled];
            
            if rep.dev_replies(k).is_enabled
                %rep.dev_replies(k).attr_values(1).dev_name;
                AM.DeviceName{k} = rep.dev_replies(k).attr_values(1).dev_name;
                AM.Data.X(k,:)   = rep.dev_replies(k).attr_values(1).value;
                AM.Data.Z(k,:)   = rep.dev_replies(k).attr_values(2).value;
                AM.Data.Sum(k,:) = rep.dev_replies(k).attr_values(4).value;
                if ~XZSumFlag
                    AM.Data.Q(k,:)   = rep.dev_replies(k).attr_values(3).value;
                    AM.Data.Va(k,:)  = rep.dev_replies(k).attr_values(5).value;
                    AM.Data.Vb(k,:)  = rep.dev_replies(k).attr_values(6).value;
                    AM.Data.Vc(k,:)  = rep.dev_replies(k).attr_values(7).value;
                    AM.Data.Vd(k,:)  = rep.dev_replies(k).attr_values(8).value;
                end
                %%%%%%%%%%% modification
                klast = k;
                %%%%%%%%%%%%%%%%%%%%%%%%
           
                if DisplayFlag
                    figure
                    subplot(3,1,1)
                    plot(AM.Data.X(k,:))
                    ylabel('X (mm)')
                    grid on

                    subplot(3,1,2)
                    plot(AM.Data.Z(k,:))
                    ylabel('Z (mm)')
                    grid on

                    subplot(3,1,3)
                    plot(AM.Data.Sum(k,:))
                    ylabel('SUM')
                    xlabel('turn number')
                    grid on
                    addlabel(1,0,datestr(clock));
                    suptitle(sprintf('Turn by turn data for %s',AM.DeviceName{k}))
                end
                
            end
        end
        % modification
        vect = vect(1:klast);
        AM.DeviceName(find(1 - vect)) = [];
        AM.Data.X   = AM.Data.X(find(vect),:);
        AM.Data.Z   = AM.Data.Z(find(vect),:);
        AM.Data.Sum = AM.Data.Sum(find(vect),:);
        if ~XZSumFlag
            AM.Data.Q = AM.Data.Q(find(vect),:);
            AM.Data.Va = AM.Data.Va(find(vect),:);
            AM.Data.Vb = AM.Data.Vb(find(vect),:);
            AM.Data.Vc = AM.Data.Vc(find(vect),:);
            AM.Data.Vd = AM.Data.Vd(find(vect),:);
        end
        %%%%%%%%%%%%%%
        AM.TimeStamp = datestr(now);
        AM.DataDescriptor = ['Turn by turn data for ' getsubmachinename];
        AM.CreatedBy = mfilename;
        AM.DeviceList = DeviceList;
    end
else
    %% loop of bpm list
    if size(DeviceList,1) > 1
        AM.DeviceList=[];
        for k = 1:length(DeviceList)
            AM0 = getturnbyturnposition(DeviceList(k,:),varargin2{:},'Struct');
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

        if StructureFlag
            
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
        [FileName, DirectoryName] = uiputfile('*.mat', 'Select Dispersion File', [DirectoryName FileName]);
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

if StructureFlag
    varargout{1} = AM;
else
    if exist('AM','var') % not nice but it works
        varargout{1} = AM.Data.X;   varargout{2}  =  AM.Data.Z;
        varargout{3} = AM.Data.Sum;
        if ~XZSumFlag
            varargout{4}  =  AM.Data.Q;
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
