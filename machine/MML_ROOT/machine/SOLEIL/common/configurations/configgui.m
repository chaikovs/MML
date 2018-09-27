function varargout = configgui(action, varargin)
% CONFIGGUI - Generates gui for configuration control
%  to launch:  >>configgui       (no input argument)

% For Compiler
%#function lat_2020_3170b
%#function lat_2020_3170a
%#function lat_2020_3170e
%#function lat_2020_3170f
%#function solamor2linb
%#function solamor2linc
%#function gethbpmaverage
%#function getvbpmaverage
%#function gethbpmgroup
%#function getvbpmgroup
%#function lat_pseudo_nanoscopium_juin2011_122BPM
%#function lat_nano_176_234_122BPM

%
% Written by Jeff Corbett
% Modified by Laurent S. Nadolski
% March 27, 2005 - Merge with LT1 programme
% September 2005 - Add Booster programme
% April 2006 - Add LT2
% September 2009 - Add Quads for nanoscopium
% Modified by Aurelien Bence
% April 2016 add btn for operation group put CNF in File , Golden & CyclingCurve

h = findobj(0,'Tag','cnffig');
if ~isempty(h) cnfdata=getappdata(h,'configguidata'); end

 

%===========================
%   DRAW MAIN GUI (nargin=0)
%===========================
if nargin == 0
    
    if isempty(getao)
        disp('Warning: Load ring AcceleratorObjects first');
        return
    else
        Machine = getfamilydata('SubMachine');
        switch Machine
            case {'StorageRing', 'LT1', 'LT2', 'Booster'}
                %%
            otherwise
                disp('Warning: Machine not recognized!');
                return
        end
    end
    
    %Clear previous configuration control gui
    if ~isempty(h) delete(h); end
    
    %set defaults
    cnfdata.field='setpoint';
    cnfdata.SetpointData=[];
    cnfdata.MonitorData=[];
    
    % generate main figure
    cnfdata.handles.figure=configgui('CNFFig',Machine);
    setappdata(cnfdata.handles.figure,'configguidata',cnfdata);
    
    configgui('UIControls',Machine);
    
    return
end

switch action
    %==========================================================
    case 'CNFFig'                                       %CNFFig
        %==========================================================
        %figure initialization
        
        [screen_wide, screen_high]=screensizecm;
        
        fig_start = [0.13*screen_wide 0.16*screen_high];
        
        Machine = varargin{1};
        
        switch Machine
            case {'LT1', 'Booster', 'LT2'}
                fig_size = [0.45*screen_wide 0.5*screen_high];
            case 'StorageRing'
                fig_size = [0.6*screen_wide 0.5*screen_high];
            otherwise
                error(['Wrong Machine: ' Machine]);
        end
        
        h = figure('Visible','off',...
            'units','centimeters','Resize','off',...
            'tag','cnffig',...
            'NumberTitle','off',...
            'Doublebuffer','on',...
            'Name',[Machine ': Setpoint file manager (Fichiers de consignes)'],...
            'PaperPositionMode','Auto'); %, 'IntegerHandle','off');
        set(h,'MenuBar','None');
        set(h,'Position',[fig_start fig_size],'Visible','on');
        
        varargout{1}=h;
        
        %==========================================================
    case 'UIControls'                           %  UIControls
        %==========================================================
        %UIControls - generate UIControls in gui
        
        Machine = varargin{1};
        
        switch Machine
            case {'LT1', 'LT2'}
                %UIControls - generate UIControls in gui
                [screen_wide, screen_high]=screensizecm;
                x0=0.01*screen_wide ; dx=0.04*screen_wide; y0=0.48*screen_high; dy=0.04*screen_high; dely=0.03*screen_high;
                
                col1_families={'BEND'; 'QP'; 'CH' ; 'CV'};
                
                families=col1_families(:);
                cnfdata.families=families;
                
                %check boxes
                for k=1:length(col1_families)
                    cnfdata.handles.([col1_families{k} 'chk'])=uicontrol('Style','checkbox','units', 'centimeters','FontWeight','demi', ...
                        'ToolTipString','Check to include in configuration load',...
                        'Position',[x0+0.5*dx,y0-(k-0.33)*dely,1.8*dx,dy/2],'HorizontalAlignment','center','String',col1_families{k},...
                        'callback','configgui(''CheckValid'')');
                    cnfdata.handles.([col1_families{k} 'flag'])=uicontrol('Style','text','units', 'centimeters', ...
                        'Position',[x0+0.22*dx,y0-(k-0.51)*dely,dx/5,dy/4],'HorizontalAlignment','center','String',' ','BackGroundColor','r','Userdata',0);
                end
                
                
                %select all
                x1 = 5.5;
                
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Select all families to include in configuration load',...
                    'Callback','configgui(''SelectAll'')',...
                    'Position',[x0+x1*dx,y0-1*dely,2*dx,dy/2],'HorizontalAlignment','center','String','Select All');
                
                %select none
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Select no families to include in configuration load',...
                    'Callback','configgui(''SelectNone'')',...
                    'Position',[x0+x1*dx,y0-2*dely,2*dx,dy/2],'HorizontalAlignment','center','String','Select None');
                
                %display partial configuration data
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Print configuration data to screen',...
                    'Callback','configgui(''ShowMainConfiguration'')',...
                    'Position',[x0+x1*dx,y0-3*dely,3.5*dx,dy/2],'HorizontalAlignment','center','String','Display Main Configuration');
                
                %display full configuration
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Print configuration data to screen',...
                    'Callback','configgui(''ShowConfiguration'')',...
                    'Position',[x0+x1*dx,y0-4*dely,3.5*dx,dy/2],'HorizontalAlignment','center','String','Display Full Configuration');
                
                %Cycle magnet when applying to machine
                setappdata(gcf,'cycling',0); % checkbox not checked
                uicontrol('Style','checkbox','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Cycle magnet when applying to machine',...
                    'Callback','setappdata(gcf,''cycling'',get(gcbo,''Value''));',...
                    'Position',[x0+x1*dx,y0-5.5*dely,2*dx,dy/2],'HorizontalAlignment','center','String','Cycling');
                
                %list box to display output dialog
                ts = ['Program Start-Up: ' datestr(now,0)];
                cnfdata.handles.listbox=uicontrol('Style','list','Units','centimeters','Position',[x0+0.5*dx y0-15.8*dely 10*dx 2*dy],'String',{ts});
                
                %configuration display
                cnfdata.handles.configname=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+0.5*dx y0-13*dely 8*dx dy/2],'HorizontalAlignment','left','String',' ');
                
                %Get Configuration
                x1 = 0.5; x2 = x1 + 1.5;
                uicontrol('Style','text','units', 'centimeters','FontWeight','demi', ...
                    'Position',[x0+x1*dx,y0-7*dely,3.5*dx,dy/2],'HorizontalAlignment','left',...
                    'String','Get Configuration from: ');
                %machine
                cnfdata.handles.GetMachine=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from Machine','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-7.8*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Machine',...
                    'Callback','configgui(''GetMachineConfig'')');
                cnfdata.handles.GetMachineTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-7.8*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %desired
                cnfdata.handles.GetDesired=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from Desired Setpoints ','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-8.6*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Desired',...
                    'Callback','configgui(''GetDesiredConfig'')');
                cnfdata.handles.GetDesiredTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-8.6*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %file
                cnfdata.handles.GetFile=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Read configuration from file','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-9.4*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','File',...
                    'Callback','configgui(''GetFileConfig'')');
                cnfdata.handles.GetFileTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-9.4*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                %golden
                cnfdata.handles.GetGolden=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Read configuration from Golden','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-10.2*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Golden',...
                    'Callback','configgui(''GetGoldenConfig'')');
                cnfdata.handles.GetGoldenTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-10.2*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                %simulator
                cnfdata.handles.GetSimulator=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from Simulator','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-11*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Simulator',...
                    'Callback','configgui(''GetSimulatorConfig'')');
                cnfdata.handles.GetSimulatorTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-11*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %workspace
                cnfdata.handles.GetWorkspace=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from WorkSpace','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-11.8*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Workspace',...
                    'Callback','configgui(''GetWorkspaceConfig'')');
                cnfdata.handles.GetWorkspaceTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-11.8*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %Set Configuration
                x1 = 5.5; x2= x1+1.5;
                uicontrol('Style','text','units', 'centimeters','FontWeight','demi', ...
                    'Position',[x0+x1*dx,y0-7*dely,3*dx,dy/2],'HorizontalAlignment','left','String','Set Configuration to: ');
                %machine
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Machine (only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-7.8*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Machine',...
                    'Callback','configgui(''SetMachineConfig'')');
                cnfdata.handles.LoadMachineTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-7.8*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %desired setpoints
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Desired Setpoints (only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-8.6*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Desired',...
                    'Callback','configgui(''SetDesiredConfig'')');
                cnfdata.handles.LoadDesiredTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-8.6*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %file
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Write configuration to file (all families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-9.4*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','File',...
                    'Callback','configgui(''SetFileConfig'')');
                cnfdata.handles.LoadFileTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-9.4*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                %golden
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Write configuration to Golden (all families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-10.2*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Golden',...
                    'Callback','configgui(''SetGoldenConfig'')');
                cnfdata.handles.LoadGoldenTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-10.2*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                %simulator
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Simulator (only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-11*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Simulator',...
                    'Callback','configgui(''SetSimulatorConfig'')');
                cnfdata.handles.LoadSimulatorTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-11*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %workspace
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Workspace (only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-11.8*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Workspace',...
                    'Callback','configgui(''SetWorkspaceConfig'')');
                cnfdata.handles.LoadWorkspaceTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-11.8*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
            case 'Booster'
                %% Booster
                
                %UIControls - generate UIControls in gui
                [screen_wide, screen_high]=screensizecm;
                x0=0.01*screen_wide ; dx=0.04*screen_wide; y0=0.48*screen_high; dy=0.04*screen_high; dely=0.03*screen_high;
                
                col1_families={'BEND'; 'QF'; 'QD'; 'SF'; 'SD'};
                col2_families={'HCOR' ; 'VCOR'; 'K_Inj'; 'SEP_Inj'};
                
                families=[col1_families(:); col2_families];
                cnfdata.families=families;
                
                %check boxes
                for k=1:length(col1_families)
                    cnfdata.handles.([col1_families{k} 'chk'])=uicontrol('Style','checkbox','units', 'centimeters','FontWeight','demi', ...
                        'ToolTipString','Check to include in configuration load',...
                        'Position',[x0+0.5*dx,y0-(k-0.33)*dely,1.8*dx,dy/2],'HorizontalAlignment','center','String',col1_families{k},...
                        'callback','configgui(''CheckValid'')');
                    cnfdata.handles.([col1_families{k} 'flag'])=uicontrol('Style','text','units', 'centimeters', ...
                        'Position',[x0+0.22*dx,y0-(k-0.51)*dely,dx/5,dy/4],'HorizontalAlignment','center','String',' ','BackGroundColor','r','Userdata',0);
                end
                
                for k=1:length(col2_families)
                    cnfdata.handles.([col2_families{k} 'chk'])=uicontrol('Style','checkbox','units', 'centimeters','FontWeight','demi', ...
                        'ToolTipString','Check to include in configuration load',...
                        'Position',[x0+3.0*dx,y0-(k-0.33)*dely,1.8*dx,dy/2],'HorizontalAlignment','center','String',col2_families{k},...
                        'callback','configgui(''CheckValid'')');
                    cnfdata.handles.([col2_families{k} 'flag'])=uicontrol('Style','text','units', 'centimeters', ...
                        'Position',[x0+2.7*dx,y0-(k-0.51)*dely,dx/5,dy/4],'HorizontalAlignment','center','String',' ','BackGroundColor','r','Userdata',0);
                end
                %select all
                x1 = 5.5;
                
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Select all families to include in configuration load',...
                    'Callback','configgui(''SelectAll'')',...
                    'Position',[x0+x1*dx,y0-1*dely,2*dx,dy/2],'HorizontalAlignment','center','String','Select All');
                
                %select none
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Select no families to include in configuration load',...
                    'Callback','configgui(''SelectNone'')',...
                    'Position',[x0+x1*dx,y0-2*dely,2*dx,dy/2],'HorizontalAlignment','center','String','Select None');
                
                %display partial configuration data
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Print configuration data to screen',...
                    'Callback','configgui(''ShowMainConfiguration'')',...
                    'Position',[x0+x1*dx,y0-3*dely,3.5*dx,dy/2],'HorizontalAlignment','center','String','Display Main Configuration');
                
                %display full configuration
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Print configuration data to screen',...
                    'Callback','configgui(''ShowConfiguration'')',...
                    'Position',[x0+x1*dx,y0-4*dely,3.5*dx,dy/2],'HorizontalAlignment','center','String','Display Full Configuration');
                
                %Cycle magnet when applying to machine
                setappdata(gcf,'cycling',0); % checkbox not checked
                uicontrol('Style','checkbox','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Cycle magnet when applying to machine',...
                    'Callback','setappdata(gcf,''cycling'',get(gcbo,''Value''));',...
                    'Position',[x0+x1*dx,y0-5.5*dely,2*dx,dy/2],'HorizontalAlignment','center','String','Cycling');
                
                %list box to display output dialog
                ts = ['Program Start-Up: ' datestr(now,0)];
                cnfdata.handles.listbox=uicontrol('Style','list','Units','centimeters','Position',[x0+0.5*dx y0-15.8*dely 10*dx 2*dy],'String',{ts});
                
                %configuration display
                cnfdata.handles.configname=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+0.5*dx y0-13*dely 8*dx dy/2],'HorizontalAlignment','left','String',' ');
                
                %Get Configuration
                x1 = 0.5; x2 = x1 + 1.5;
                uicontrol('Style','text','units', 'centimeters','FontWeight','demi', ...
                    'Position',[x0+x1*dx,y0-7*dely,3.5*dx,dy/2],'HorizontalAlignment','left',...
                    'String','Get Configuration from: ');
                %machine
                cnfdata.handles.GetMachine=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from Machine','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-7.8*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Machine',...
                    'Callback','configgui(''GetMachineConfig'')');
                cnfdata.handles.GetMachineTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-7.8*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %desired
                cnfdata.handles.GetDesired=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from Desired Setpoints ','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-8.6*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Desired',...
                    'Callback','configgui(''GetDesiredConfig'')');
                cnfdata.handles.GetDesiredTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-8.6*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %file
                cnfdata.handles.GetFile=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Read configuration from file','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-9.4*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','File',...
                    'Callback','configgui(''GetFileConfig'')');
                cnfdata.handles.GetFileTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-9.4*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                %golden
                cnfdata.handles.GetGolden=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Read configuration from Golden','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-10.2*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Golden',...
                    'Callback','configgui(''GetGoldenConfig'')');
                cnfdata.handles.GetGoldenTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-10.2*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                %simulator
                cnfdata.handles.GetSimulator=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from Simulator','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-11*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Simulator',...
                    'Callback','configgui(''GetSimulatorConfig'')');
                cnfdata.handles.GetSimulatorTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-11*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %workspace
                cnfdata.handles.GetWorkspace=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from WorkSpace','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-11.8*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Workspace',...
                    'Callback','configgui(''GetWorkspaceConfig'')');
                cnfdata.handles.GetWorkspaceTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-11.8*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %Set Configuration
                x1 = 5.5; x2= x1+1.5;
                cnfdata.handles.SetFile= uicontrol('Style','text','units', 'centimeters','FontWeight','demi', ...
                    'Position',[x0+x1*dx,y0-7*dely,3*dx,dy/2],'HorizontalAlignment','left','String','Set Configuration to: ');
                %machine
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Machine (only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-7.8*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Machine',...
                    'Callback','configgui(''SetMachineConfig'')');
                cnfdata.handles.LoadMachineTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-7.8*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %desired setpoints
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Desired Setpoints (only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-8.6*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Desired',...
                    'Callback','configgui(''SetDesiredConfig'')');
                cnfdata.handles.LoadDesiredTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-8.6*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %file
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Write configuration to file (all families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-9.4*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','File',...
                    'Callback','configgui(''SetFileConfig'')');
                cnfdata.handles.LoadFileTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-9.4*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                %golden
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Write configuration to Golden (all families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-10.2*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Golden',...
                    'Callback','configgui(''SetGoldenConfig'')');
                cnfdata.handles.LoadGoldenTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-10.2*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                %simulator
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Simulator (only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-11*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Simulator',...
                    'Callback','configgui(''SetSimulatorConfig'')');
                cnfdata.handles.LoadSimulatorTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-11*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %workspace
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Workspace (only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-11.8*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Workspace',...
                    'Callback','configgui(''SetWorkspaceConfig'')');
                cnfdata.handles.LoadWorkspaceTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-11.8*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                
            case 'StorageRing'
                
                [screen_wide, screen_high]=screensizecm;
                x0=0.01*screen_wide ; dx=0.04*screen_wide; y0=0.48*screen_high; dy=0.04*screen_high; dely=0.03*screen_high;
                
                col1_families={'BEND'; 'HCOR' ; 'VCOR'; 'QT'};
                col2_families={'Q1'; 'Q2'; 'Q3'; 'Q4'; 'Q5'; 'Q6'};
                col3_families={'Q7'; 'Q8'; 'Q9'; 'Q10'; 'Q11'; 'Q12'};
                col4_families={'S1'; 'S2'; 'S3'; 'S4'; 'S5'; 'S6'};
                col5_families={'S7'; 'S8'; 'S9'; 'S10'; 'S11'; 'S12'};
                
                families=[col1_families(:); col2_families(:); col3_families(:) ; col4_families(:) ; col5_families(:)];
                cnfdata.families=families;
                
                %check boxes
                for k=1:length(col1_families)
                    cnfdata.handles.([col1_families{k} 'chk'])=uicontrol('Style','checkbox','units', 'centimeters','FontWeight','demi', ...
                        'ToolTipString','Check to include in configuration load',...
                        'Position',[x0+0.5*dx,y0-(k-0.33)*dely,1.8*dx,dy/2],'HorizontalAlignment','center','String',col1_families{k},...
                        'callback','configgui(''CheckValid'')');
                    cnfdata.handles.([col1_families{k} 'flag'])=uicontrol('Style','text','units', 'centimeters', ...
                        'Position',[x0+0.22*dx,y0-(k-0.51)*dely,dx/5,dy/4],'HorizontalAlignment','center','String',' ','BackGroundColor','r','Userdata',0);
                    
                end
                
                for k=1:length(col2_families),
                    cnfdata.handles.([col2_families{k} 'chk'])=uicontrol('Style','checkbox','units', 'centimeters','FontWeight','demi', ...
                        'ToolTipString','Check to include in configuration load',...
                        'Position',[x0+3.0*dx,y0-(k-0.33)*dely,1.8*dx,dy/2],'HorizontalAlignment','center','String',col2_families{k},...
                        'callback','configgui(''CheckValid'')');
                    cnfdata.handles.([col2_families{k} 'flag'])=uicontrol('Style','text','units', 'centimeters', ...
                        'Position',[x0+2.7*dx,y0-(k-0.51)*dely,dx/5,dy/4],'HorizontalAlignment','center','String',' ','BackGroundColor','r','Userdata',0);
                end
                
                for k=1:length(col3_families),
                    cnfdata.handles.([col3_families{k} 'chk'])=uicontrol('Style','checkbox','units', 'centimeters','FontWeight','demi', ...
                        'ToolTipString','Check to include in configuration load',...
                        'Position',[x0+5.5*dx,y0-(k-0.33)*dely,1.8*dx,dy/2],'HorizontalAlignment','center','String',col3_families{k},...
                        'callback','configgui(''CheckValid'')');
                    cnfdata.handles.([col3_families{k} 'flag'])=uicontrol('Style','text','units', 'centimeters', ...
                        'Position',[x0+5.2*dx,y0-(k-0.51)*dely,dx/5,dy/4],'HorizontalAlignment','center','String',' ','BackGroundColor','r','Userdata',0);
                end
                
                for k=1:length(col4_families),
                    cnfdata.handles.([col4_families{k} 'chk'])=uicontrol('Style','checkbox','units', 'centimeters','FontWeight','demi', ...
                        'ToolTipString','Check to include in configuration load',...
                        'Position',[x0+8.0*dx,y0-(k-0.33)*dely,1.8*dx,dy/2],'HorizontalAlignment','center','String',col4_families{k},...
                        'callback','configgui(''CheckValid'')');
                    cnfdata.handles.([col4_families{k} 'flag'])=uicontrol('Style','text','units', 'centimeters', ...
                        'Position',[x0+7.7*dx,y0-(k-0.51)*dely,dx/5,dy/4],'HorizontalAlignment','center','String',' ','BackGroundColor','r','Userdata',0);
                end
                
                for k=1:length(col5_families),
                    cnfdata.handles.([col5_families{k} 'chk'])=uicontrol('Style','checkbox','units', 'centimeters','FontWeight','demi', ...
                        'ToolTipString','Check to include in configuration load',...
                        'Position',[x0+10.5*dx,y0-(k-0.33)*dely,1.8*dx,dy/2],'HorizontalAlignment','center','String',col5_families{k},...
                        'callback','configgui(''CheckValid'')');
                    cnfdata.handles.([col5_families{k} 'flag'])=uicontrol('Style','text','units', 'centimeters', ...
                        'Position',[x0+10.2*dx,y0-(k-0.51)*dely,dx/5,dy/4],'HorizontalAlignment','center','String',' ','BackGroundColor','r','Userdata',0);
                end
                
                
                
                him = uicontrol('style','pushbutton', 'Units', 'centimeter', 'Position', [x0+11.5*dx,y0-15*dely,2.5*dx,1.5*dy]);
                a = imread('soleilquadri_small.jpg'); % set background to white
                set(him,'cdata',a(1:2:end,1:2:end,:)) % make smaller image
                
                %select all
                x1 = 10.5;
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Select all families to include in configuration load',...
                    'Callback','configgui(''SelectAll'')',...
                    'Position',[x0+x1*dx,y0-7*dely,2*dx,dy/2],'HorizontalAlignment','center','String','Select All');
                
                %select all quad
                x1 = 10.5;
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Select all families to include in configuration load',...
                    'Callback','configgui(''SelectAllQuad'')',...
                    'Position',[x0+x1*dx + 2.1*dx,y0-7*dely,2*dx,dy/2],'HorizontalAlignment','center','String','Select All Quad');
                
                %select all sextu
                x1 = 10.5;
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Select all families to include in configuration load',...
                    'Callback','configgui(''SelectAllSextu'')',...
                    'Position',[x0+x1*dx + 2.1*dx,y0-8.0*dely,2*dx,dy/2],'HorizontalAlignment','center','String','Select All Sextu');
                
                %select none
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Select no families to include in configuration load',...
                    'Callback','configgui(''SelectNone'')',...
                    'Position',[x0+x1*dx,y0-8.0*dely,2*dx,dy/2],'HorizontalAlignment','center','String','Select None');
                
                %display partial configuration data
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Print configuration data to screen',...
                    'Callback','configgui(''ShowMainConfiguration'')',...
                    'Position',[x0+x1*dx,y0-9.0*dely,3.5*dx,dy/2],'HorizontalAlignment','center','String','Display Main Configuration');
                
                %display full configuration
                uicontrol('Style','pushbutton','units', 'centimeters','FontWeight','demi', ...
                    'ToolTipString','Print configuration data to screen',...
                    'Callback','configgui(''ShowConfiguration'')',...
                    'Position',[x0+x1*dx,y0-10*dely,3.5*dx,dy/2],'HorizontalAlignment','center','String','Display Full Configuration');
                
                %S11 flag
                %Create the button group.
                cnfdata.handles.S11button = uibuttongroup('visible','on','units', 'centimeters', 'Position',[x0+x1*dx,y0-12*dely,4*dx,dy], ...
                    'FontWeight','demi', 'title', 'S11 config panel');
                % Create three radio buttons in the button group.
                uicontrol('Style','Radio','String','S11config',...
                    'units', 'centimeters','FontWeight','demi', ...
                    'pos',[0,0,2*dx,dy],'parent',cnfdata.handles.S11button,'HandleVisibility','off', 'value', 1);
                uicontrol('Style','Radio','String','no S11',...
                    'units', 'centimeters','FontWeight','demi', ...
                    'pos',[2*dx,0,2*dx,dy],'parent',cnfdata.handles.S11button,'HandleVisibility','off');
                
                % Initialize some button group properties.
                set(cnfdata.handles.S11button,'Visible','on');
                
                %list box to display output dialog
                ts = ['Program Start-Up: ' datestr(now,0)];
                cnfdata.handles.listbox=uicontrol('Style','list','Units','centimeters','Position',[x0+0.5*dx y0-15.8*dely 10*dx 2*dy],'String',{ts});
                
                %configuration display
                cnfdata.handles.configname=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+0.5*dx y0-13*dely 8*dx dy/2],'HorizontalAlignment','left','String',' ');
                
                %Get Configuration
                x1 = 0.5; x2 = x1 + 1.5; yoff=6.5;
                uicontrol('Style','text','units', 'centimeters','FontWeight','demi', ...
                    'Position',[x0+x1*dx,y0-yoff*dely,3.5*dx,dy/2],'HorizontalAlignment','left',...
                    'String','Get Configuration from: '); 
                yoff=yoff+0.8;
                %machine
                cnfdata.handles.GetMachine=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from Machine','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Machine',...
                    'Callback','configgui(''GetMachineConfig'')');
                cnfdata.handles.GetMachineTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                yoff=yoff+0.8;
                %desired
                cnfdata.handles.GetDesired=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from Desired Setpoints (SPEAR 3)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Desired',...
                    'Callback','configgui(''GetDesiredConfig'')');
                cnfdata.handles.GetDesiredTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                yoff=yoff+0.8;
                %file
                cnfdata.handles.GetFile=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Read configuration from file','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','File',...
                    'Callback','configgui(''GetFileConfig'')');
                cnfdata.handles.GetFileTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                yoff=yoff+0.8;
                %golden
                cnfdata.handles.GetGolden=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Read configuration from Golden','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Golden',...
                    'Callback','configgui(''GetGoldenConfig'')');
                cnfdata.handles.GetGoldenTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                yoff=yoff+0.8;
                %simulator
                cnfdata.handles.GetSimulator=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from Simulator','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Simulator',...
                    'Callback','configgui(''GetSimulatorConfig'')');
                cnfdata.handles.GetSimulatorTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                yoff=yoff+0.8;
                %workspace
                cnfdata.handles.GetWorkspace=uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Acquire configuration from WorkSpace','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Workspace',...
                    'Callback','configgui(''GetWorkspaceConfig'')');
                cnfdata.handles.GetWorkspaceTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                
                %Set Configuration
                x1 = 5.5; x2= x1+1.5;yoff=6.5;
                cnfdata.handles.SetFile = uicontrol('Style','text','units', 'centimeters','FontWeight','demi', ...
                    'Position',[x0+x1*dx,y0-yoff*dely,3*dx,dy/2],'HorizontalAlignment','left','String','Set Configuration to: ');
                 yoff=yoff+0.8;
                %machine
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Machine (only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Machine',...
                    'Callback','configgui(''SetMachineConfig'')');
                cnfdata.handles.LoadMachineTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                 yoff=yoff+0.8;
                %desired setpoints
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Desired Setpoints (SPEAR 3, only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Desired',...
                    'Callback','configgui(''SetDesiredConfig'')');
                cnfdata.handles.LoadDesiredTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                 yoff=yoff+0.8;
                %file
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Write configuration to file (all families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','File',...
                    'Callback','configgui(''SetFileConfig'')');
                cnfdata.handles.LoadFileTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                 yoff=yoff+0.8;
                %golden
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Write configuration to Golden (all families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Golden',...
                    'Callback','configgui(''SetGoldenConfig'')');
                cnfdata.handles.LoadGoldenTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                 yoff=yoff+0.8;
                %simulator
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Simulator (only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Simulator',...
                    'Callback','configgui(''SetSimulatorConfig'')');
                cnfdata.handles.LoadSimulatorTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                 yoff=yoff+0.8;
                %workspace
                uicontrol('Style','PushButton','units', 'centimeters', ...
                    'ToolTipString','Load configuration to Workspace (only selected families)','BackGroundColor',[1 1 1],...
                    'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','Workspace',...
                    'Callback','configgui(''SetWorkspaceConfig'')');
                cnfdata.handles.LoadWorkspaceTime=uicontrol('Style','text','units', 'centimeters', ...
                    'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                 yoff=yoff+0.8;
                
                if iscontrolroom
                %FileGoldenCycling
                  
                        uicontrol('Style','PushButton','units', 'centimeters', ...
                            'ToolTipString','Write configuration to file and Golden (all families) + load CyclingCurve','BackGroundColor',[1 1 1],...
                            'Position',[x0+x1*dx,y0-yoff*dely,1.2*dx,dy/2],'HorizontalAlignment','center','String','File+Golden+Cycling',...
                            'Callback','configgui(''SetFileGoldendCyclConfig'')');
                        cnfdata.handles.LoadFGCspaceTime=uicontrol('Style','text','units', 'centimeters', ...
                            'Position',[x0+x2*dx,y0-yoff*dely,3.0*dx,dy/2],'HorizontalAlignment','center','String','');
                     
                end
                
            otherwise
                error('wrong Machine');
                set(h,'HandleVisibility','off');
        end
        setappdata(h,'configguidata',cnfdata);
        
        %============================================================
    %% Checkvalid
    case 'CheckValid'
        %============================================================
        val=get(gcbo,'Value');
        if val==1
            family=get(gcbo,'String');
            if get(cnfdata.handles.([family 'flag']),'BackGroundColor')==[1 0 0];  %red
                set(gcbo,'Value',0);
            end
        end
    %% GetMachineConfig    
        %============================================================
    case 'GetMachineConfig'
        %============================================================
        % get configuration from Machine
        
        configgui('LBoxWait');
        cnfdata.SetpointData=[];
        cnfdata.MonitorData=[];
        
        
        [cnfdata.SetpointData,cnfdata.MonitorData]=getmachineconfig('online');
        
        setappdata(h,'configguidata',cnfdata);
        
        configgui('ShowActiveFamilies');
        configgui('ShowLastGet');
        
        set(cnfdata.handles.GetMachineTime,'String',datestr(now,0));
        set(cnfdata.handles.configname,'String', 'Machine Configuration');
        configgui('LBoxWriteLast',' Get Configuration from Machine ');
        
        %============================================================
    case 'GetDesiredConfig'
        %============================================================
        % get configuration from Desired Setpoints (SPEAR 3)
        
        configgui('LBoxWait');
        %get configuration from machine
        [cnfdata.SetpointData,cnfdata.MonitorData]=getmachineconfig('online');
        %load Desired values into Data field
        ao=getao;
        for k=1:length(cnfdata.families)
            family=cnfdata.families{k};
            if isfield(ao.(family),'Desired');
                cnfdata.SetpointData.(family).Data=getpv(family,'Desired',[]);
                cnfdata.MonitorData.(family).Data=cnfdata.SetpointData.(family).Data;
            end
        end
        
        setappdata(h,'configguidata',cnfdata);
        
        configgui('ShowActiveFamilies');
        configgui('ShowLastGet');
        
        
        set(cnfdata.handles.configname,'String', 'Desired Setpoint Configuration');
        set(cnfdata.handles.GetDesiredTime,'String',datestr(now,0));
        configgui('LBoxWriteLast',' Load Desired Setpoints into Machine Configuration');
        
        %============================================================
    case 'GetFileConfig'
        %============================================================
        %load configuration file via browser
        configgui('LBoxWait');
        
        DirSpec   =  getfamilydata('Directory','ConfigData');           %default to Configuration data directory
        FileName  =  [];                                %no default file
        [FileName, DirSpec] = uigetfile('*.mat','Select Configuration File',[DirSpec FileName]);
        FileSpec = fullfile(DirSpec, FileName);
        
        msg = [];
        Machine = getfamilydata('SubMachine');
        
        try %% added for nanoscopium S11 new family October 2010
            cnf=load(FileSpec);          %load configuration from archive
            if strcmp(Machine, 'StorageRing') && ...
                strcmp(get(get(cnfdata.handles.S11button,'SelectedObject'),'String'), 'S11config')
                [cnf newS11Flag] = convertS1toS11(cnf);
                if newS11Flag
                    msg = 'S11=S1 added!';
                end
            end
        catch exception
            disp('Erreur in GetFileConfig')
            return
        end
        
        cnfdata.SetpointData=[];
        cnfdata.MonitorData=[];
        
        cnfdata.SetpointData=cnf.ConfigSetpoint;
        cnfdata.MonitorData =cnf.ConfigMonitor;
        
        set(cnfdata.handles.configname,'String', ['File Configuration: ' FileName]);
        %set(cnfdata.handles.GetFile,'TooltipString',FileName);
        
        setappdata(h,'configguidata',cnfdata);
        
        configgui('ShowActiveFamilies');
        configgui('ShowLastGet');
        
        
        set(cnfdata.handles.GetFileTime,'String',datestr(now,0));
        configgui('LBoxWriteLast', [msg ' Get Configuration from File ' FileName]);
        
        %============================================================
    case 'GetGoldenConfig'
        %============================================================
        % get configuration from Golden File (PhysData)
        configgui('LBoxWait');
        cnfdata.SetpointData=[];
        cnfdata.MonitorData=[];
             
        msg = [];
        Machine = getfamilydata('SubMachine');

        try %% added for nanoscopium S11 new family October 2010
            FileName = getfamilydata('OpsData', 'LatticeFile');
            DirectoryName = getfamilydata('Directory', 'OpsData');        
            cnf=load([DirectoryName FileName]); %load configuration from archive
            if strcmp(Machine, 'StorageRing') && ...
            strcmp(get(get(cnfdata.handles.S11button,'SelectedObject'),'String'), 'S11config')
                [cnf newS11Flag] = convertS1toS11(cnf);
                if newS11Flag
                    msg = 'S11=S1 added!';
                end
            end
        catch exception
            disp('Erreur in GetGoldenConfig')
            return
        end
                        
        cnfdata.SetpointData=cnf.ConfigSetpoint;
        cnfdata.MonitorData =cnf.ConfigMonitor;
        
        setappdata(h,'configguidata',cnfdata);
        
        configgui('ShowActiveFamilies');
        configgui('ShowLastGet');
        
        
        set(cnfdata.handles.configname,'String', 'File Configuration: Golden');
        set(cnfdata.handles.GetGoldenTime,'String',datestr(now,0));
        configgui('LBoxWriteLast',[msg ' Get Golden Configuration ']);
        
        %============================================================
    case 'GetSimulatorConfig'
        %============================================================
        % get configuration from Simulator
        configgui('LBoxWait');
        cnfdata.SetpointData=[];
        cnfdata.MonitorData=[];
        [cnfdata.SetpointData,cnfdata.MonitorData] = getmachineconfig('simulator');
        
        setappdata(h,'configguidata',cnfdata);
        
        configgui('ShowActiveFamilies');
        configgui('ShowLastGet');
        
        set(cnfdata.handles.configname,'String', 'Simulator Configuration');
        set(cnfdata.handles.GetSimulatorTime,'String',datestr(now,0));
        configgui('LBoxWriteLast',' Get Configuration from Simulator ');
        
        %============================================================
    case 'GetWorkspaceConfig'
        %============================================================
        % get configuration from Workspace
        configgui('LBoxWait');
        
        %load setpoint data
        evalin('base',['if exist(''SetpointData'');',...
            'h=findobj(0,''Tag'',''cnffig'');',...
            'cnfdata=getappdata(h,''configguidata'');',...
            'cnfdata.SetpointData=SetpointData;',...
            'setappdata(h,''configguidata'',cnfdata);',...
            'disp(''   Setpoint configuration found in workspace'');',...
            'else;',...
            'disp(''   No Setpoint configuration found in workspace'');',...
            'end;']);
        
        %load monitor data
        evalin('base',['if exist(''MonitorData'');',...
            'h=findobj(0,''Tag'',''cnffig'');',...
            'cnfdata=getappdata(h,''configguidata'');',...
            'cnfdata.MonitorData=MonitorData;',...
            'setappdata(h,''configguidata'',cnfdata);',...
            'disp(''   Monitor configuration found in workspace'');',...
            'else;',...
            'disp(''   No Monitor configuration found in workspace'');',...
            'end;']);
        
        
        configgui('ShowActiveFamilies');
        configgui('ShowLastGet');
        
        set(cnfdata.handles.configname,'String', 'Workspace Configuration');
        set(cnfdata.handles.GetWorkspaceTime,'String',datestr(now,0));
        configgui('LBoxWriteLast',' Get Configuration from Workspace ');
        
        
        %============================================================
    case 'ShowLastGet'
        %============================================================
        %Turn last 'Get' pushbutton green
        
        set(cnfdata.handles.GetMachine,'BackGroundColor',[1 1 1]);
        set(cnfdata.handles.GetDesired,'BackGroundColor',[1 1 1]);
        set(cnfdata.handles.GetFile,'BackGroundColor',[1 1 1]);
        set(cnfdata.handles.GetGolden,'BackGroundColor',[1 1 1]);
        set(cnfdata.handles.GetSimulator,'BackGroundColor',[1 1 1]);
        set(cnfdata.handles.GetWorkspace,'BackGroundColor',[1 1 1]);
        
        set(gcbo,'BackGroundColor','g');
        
        %============================================================
    case 'SetMachineConfig'
        %============================================================
        %Set/Load configuration to machine
        configgui('LBoxWait');
        if  strcmpi(cnfdata.field,'setpoint')
            cnf=cnfdata.SetpointData;
        elseif  strcmpi(cnfdata.field,'monitor')
            cnf=cnfdata.MonitorData;
        end
        
        %find which families are active
        config=[];
        for k=1:length(cnfdata.families)
            family=cnfdata.families{k};
            if get(cnfdata.handles.([family 'chk']),'Value')==1
                config.(family)=cnf.(family);
            end
        end
        
        if isempty(config)
            configgui('LBoxWriteLast',' No families loaded Online ');
            return
        end
        
        if getappdata(gcf,'cycling')
            disp('cycling not implemented yet!!!')
        end
        setmachineconfig(config,'online');
        
        set(cnfdata.handles.LoadMachineTime,'String',datestr(now,0));
        configgui('LBoxWriteLast',' Load Configuration to Machine ');
        
        %============================================================
    case 'SetDesiredConfig'
        %============================================================
        %Set configuration to Desired Setpoints (SPEAR 3 application)
        configgui('LBoxWait');
        for k=1:length(cnfdata.families)
            family=cnfdata.families{k};
            if get(cnfdata.handles.([family 'chk']),'Value')==1
                if (~strcmpi(family,'HCOR') && ~strcmpi(family,'VCOR') && ...
                        ~strcmpi(family,'SkewQuad') && ~strcmpi(family,'BEND'))
                    DeviceList=family2dev(family);
                    Desired=cnfdata.SetpointData.(family).Data;
                    setpv(family,'Desired',Desired,DeviceList);
                end
            end
        end
        
        set(cnfdata.handles.LoadDesiredTime,'String',datestr(now,0));
        configgui('LBoxWriteLast',' Load Configuration to Desired Setpoints');
        
        %============================================================
    case 'SetFileConfig'
        %============================================================
        SetFileConfig(cnfdata,'');
        
        
        
        %============================================================
    case 'SetGoldenConfig'
        %============================================================
        
        SetGoldenConfig(cnfdata);
        
        
        %============================================================
    case 'SetSimulatorConfig'
        %============================================================
        %Set/Load configuration to simulator
        configgui('LBoxWait');
        %find which families are active
        families=[];
        for k=1:length(cnfdata.families)
            family=cnfdata.families{k};
            if get(cnfdata.handles.([family 'chk']),'Value')==1
                families.(['f' num2str(k)])=family;
            end
        end
        
        if isempty(families)
            configgui('LBoxWriteLast',' No families loaded to Simulator ');
            return
        else
            families=struct2cell(families);
        end
        
        if  strcmpi(cnfdata.field,'setpoint')
            config=cnfdata.SetpointData;
        elseif  strcmpi(cnfdata.field,'monitor')
            config=cnfdata.MonitorData;
        end
        
        setmachineconfig(families,config,'simulator');
        
        set(cnfdata.handles.LoadSimulatorTime,'String',datestr(now,0));
        configgui('LBoxWriteLast',' Load Configuration to Simulator ');
        
        %============================================================
    case 'SetWorkspaceConfig'
        %============================================================
        %Set/Load configuration to workspace
        configgui('LBoxWait');
        %find which families are active
        families=[];
        for k=1:length(cnfdata.families)
            family=cnfdata.families{k};
            if get(cnfdata.handles.([family 'chk']),'Value')==1
                families.(['f' num2str(k)])=family;
            end
        end
        
        if isempty(families)
            configgui('LBoxWriteLast',' No families loaded to Workspace ');
            return
        end
        
        if      isfield(cnfdata,'SetpointData')
            evalin('base',['h=findobj(0,''Tag'',''cnffig'');',...
                'cnfdata=getappdata(h,''configguidata'');',...
                'SetpointData=cnfdata.SetpointData;',...
                'clear h;', 'clear cnfdata;']);
            disp('   Setpoint configuration data loaded to workspace as SetpointData');
        else
            disp('   No Setpoint data available');
        end
        if      isfield(cnfdata,'MonitorData')
            evalin('base',['h=findobj(0,''Tag'',''cnffig'');',...
                'cnfdata=getappdata(h,''configguidata'');',...
                'MonitorData=cnfdata.MonitorData;',...
                'clear h;', 'clear cnfdata;']);
            disp('   Monitor configuration data loaded to workspace as MonitorData');
        else
            disp('   No Monitor data available');
        end
        
        
        set(cnfdata.handles.LoadWorkspaceTime,'String',datestr(now,0));
        configgui('LBoxWriteLast',' Load Configuration to Workspace ');
        %============================================================
    case 'SetFileGoldendCyclConfig'
        %============================================================    
        SetFileConfig(cnfdata,'_Golden_RunX');
        SetGoldenConfig(cnfdata);
        
        %find which families are active
        config=[];
%         for k=1:length(cnfdata.families)
%             family=cnfdata.families{k};
%             if get(cnfdata.handles.([family 'chk']),'Value')==1
%                 config.(family)=cnf.(family);
%             end
%         end
        Families=cnfdata.families;
        switch questdlg('Do you want to load CyclingCurve ?', 'load CyclingCurve','Yes','No','No')
           case 'Yes'
            % Config magnet
            magnetcycle('Full','Golden',Families,'NoDisplay','Config','NoApply');
        end            
        set(cnfdata.handles.LoadFGCspaceTime,'String',datestr(now,0));
        configgui('LBoxWriteLast',' Write Configuration to Golden ');
                    
        
        %============================================================
    case 'SelectAll'
        %============================================================
        %select all families for configuration load
        for k=1:length(cnfdata.families)
            if get(cnfdata.handles.([cnfdata.families{k} 'flag']),'Userdata') == 1;   %contains valid data
                set(cnfdata.handles.([cnfdata.families{k} 'chk']),'Value',1);
            end
        end
        
        %============================================================
    case 'SelectAllQuad'
        %============================================================
        %select all families for configuration load
        for k = 1:length(cnfdata.families)
            if ~isempty(regexp(cnfdata.families{k},'Q[0-9]'))
                if get(cnfdata.handles.([cnfdata.families{k} 'flag']),'Userdata') == 1;   %contains valid data
                    set(cnfdata.handles.([cnfdata.families{k} 'chk']),'Value',1);
                end
            end
        end
        
        %============================================================
    case 'SelectAllSextu'
        %============================================================
        %select all families for configuration load
        for k=1:length(cnfdata.families)
            if ~isempty(regexp(cnfdata.families{k},'S[0-9]'))
                if get(cnfdata.handles.([cnfdata.families{k} 'flag']),'Userdata') == 1;   %contains valid data
                    set(cnfdata.handles.([cnfdata.families{k} 'chk']),'Value',1);
                end
            end
        end
        
        %============================================================
    case 'SelectNone'
        %============================================================
        %select no families for configuration load
        for k=1:length(cnfdata.families)
            set(cnfdata.handles.([cnfdata.families{k} 'chk']),'Value',0);
        end
        
        %============================================================
    case 'ShowActiveFamilies'
        %============================================================
        %turn box green for valid families
        
        for k=1:length(cnfdata.families)
            set(cnfdata.handles.([cnfdata.families{k} 'flag']),'BackGroundColor','r','Userdata',0);
        end
        
        if strcmpi(cnfdata.field,'setpoint');
            if isempty(cnfdata.SetpointData), return; end
            familynames=fieldnames(cnfdata.SetpointData);
        elseif strcmpi(cnfdata.field,'monitor');
            if isempty(cnfdata.MonitorData), return; end
            familynames=fieldnames(cnfdata.MonitorData);
        end
        
        %indicate valid families
        for k=1:length(cnfdata.families)
            for l=1:length(familynames)
                if strcmpi(cnfdata.families{k},familynames{l})
                    %disp(familynames{l})
                    set(cnfdata.handles.([familynames{l} 'flag']),'BackGroundColor','g','Userdata',1);
                end
            end
        end
        
        %===========================================================
    case 'LBoxWriteLast'                          %*** LBoxWriteLast ***
        %===========================================================
        %load latest sequence of strings into graphical display listbox
        comment=varargin{1};
        ts = datestr(now,0);
        addstr={[ts  ': ' comment]};
        str=get(cnfdata.handles.listbox,'String');
        
        [ione,itwo]=size(str);
        if ione>0
            str=[str(1:end-1); addstr];
        else
            str=addstr;
        end
        nentry=50;
        if ione>=nentry                %keep only top entries
            str=str(ione-nentry+1:ione,1);
            [ione,itwo]=size(str);
        end
        set(cnfdata.handles.listbox,'String',str,'listboxtop',ione);
        
        
        %===========================================================
    case 'LBoxWait'                          %*** LBoxWait ***
        %===========================================================
        %load latest sequence of strings into graphical display listbox
        
        addstr={'... Working ...' };
        str=get(cnfdata.handles.listbox,'String');
        str=[str; addstr];
        [ione,itwo]=size(str);
        nentry=50;
        if ione>=nentry                %keep only top entries
            str=str(ione-nentry+1:ione,1);
            [ione,itwo]=size(str);
        end
        set(cnfdata.handles.listbox,'String',str,'listboxtop',ione);
        sleep(0.01);
        
        %===========================================================
    case 'ShowConfiguration'          %*** ShowConfiguration ***
        %===========================================================
        %display setpoint and monitors for families in cnfdata structure
        
        families=cnfdata.families;
        filename = tempname;
        fid = fopen(filename,'w');
        
        for k=1:length(families)
            Family=families{k};
            if ~isfield(cnfdata.SetpointData,Family)
                fprintf('   Warning: family %s not available... \n', Family);
            else
                if isempty(cnfdata.SetpointData.(Family).Setpoint.Data)
                    fprintf('Warning: family %s MML status 0 \n', Family);
                else
                    DeviceList     =family2dev(Family);
                    Field          ='Setpoint';
                    SetpointPV     =getfamilydata(Family,Field,'TangoNames');
                    SetpointData   =cnfdata.SetpointData.(Family).(Field).Data;
                    [iFound, iNotFound, iFoundList1] = findrowindex(family2dev(Family), cnfdata.SetpointData.(Family).(Field).DeviceList);
                    if ~isempty(iNotFound)
                        A = getam(Family); A(iFoundList1) = SetpointData; A(iNotFound) = NaN; SetpointData = A;
                    else
                        SetpointData = SetpointData(iFound);
                    end
                    PhysicsSetpoint=hw2physics(Family,Field,SetpointData);
                    Field = 'Monitor';
                    MonitorPV      =getfamilydata(Family,Field,'TangoNames');
                    MonitorData    =cnfdata.MonitorData.(Family).(Field).Data;
                    if ~isempty(iNotFound)
                        A = getam(Family); A(iFoundList1) = MonitorData; A(iNotFound) = NaN; MonitorData = A; 
                    else
                        MonitorData = MonitorData(iFound);
                    end
                    PhysicsMonitor =hw2physics(Family,'Monitor', MonitorData);
                    
                    %display hardware values
                    fprintf(fid,'%s\n','   Family  DeviceList  HWSetpoint PhysicsSetpoint     HWReadback    PhysicsReadback )');
                    
                    for jj=1:size(DeviceList,1)
                        fprintf(fid,'%8s    [%2d,%d] %14.5f %14.5f %14.5f %14.5f \n',...
                            Family,DeviceList(jj,1),DeviceList(jj,2),SetpointData(jj),PhysicsSetpoint(jj),...
                            MonitorData(jj),PhysicsMonitor(jj));
                    end
                end
            end
        end
        fclose(fid);
        
        edit(filename);
        
        %===========================================================
    case 'ShowMainConfiguration'       %*** ShowMainConfiguration ***
        %===========================================================
        %display setpoint and monitors for families in cnfdata structure
        
        families=cnfdata.families;
        
        filename = tempname;
        fid = fopen(filename,'w');
        %display hardware values
        fprintf(fid,'   Family    HWSetpoint   PhysicsSetpoint \n');
        for k=1:length(families),
            Family=families{k};
            if ~isfield(cnfdata.SetpointData,Family)
                fprintf('  Warning: family %s not available... \n', Family);
            elseif isempty(cnfdata.SetpointData.(Family).Setpoint.Data)
                fprintf('Warning: family %s MML status 0 \n', Family);
            else
                DeviceList     =family2dev(Family);
                Field = 'Setpoint';
                SetpointPV     =getfamilydata(Family,Field,'TangoNames');
                SetpointData   =cnfdata.SetpointData.(Family).(Field).Data;
                [iFound, iNotFound, iFoundList1] = findrowindex(family2dev(Family), cnfdata.SetpointData.(Family).(Field).DeviceList);
                    if ~isempty(iNotFound)
                        A = getam(Family); A(iFoundList1) = SetpointData; A(iNotFound) = NaN; SetpointData = A;
                    else
                        SetpointData = SetpointData(iFound);
                    end
                PhysicsSetpoint = hw2physics(Family,Field,SetpointData);
                Field = 'Monitor';
                MonitorPV      = getfamilydata(Family,Field,'TangoNames');
                MonitorData    = cnfdata.MonitorData.(Family).(Field).Data;
                if ~isempty(iNotFound)
                    A = getam(Family); A(iFoundList1) = MonitorData; A(iNotFound) = NaN; MonitorData = A;
                else
                    MonitorData = MonitorData(iFound);
                end
                PhysicsMonitor = hw2physics(Family,Field, MonitorData);
                %display hardware values First element if several power
                %supplies
                if ~strcmpi(Family,'HCOR') && ~strcmpi(Family,'VCOR') && ~strcmpi(Family,'SkewQuad')
                    fprintf(fid,'%8s  %14.5e %14.5e\n',Family,SetpointData(1),PhysicsSetpoint(1));
                end
            end
        end
        
        fclose(fid);
        
        edit(filename);
    otherwise
        disp(['Warning: no CASE found in configgui: ' action]);
        disp(action);
end  %end switchyard
end
function [cnf newS11Flag] = convertS1toS11(cnf)
% convertS1toS11 - If S11 family does not exist in the lattice file S11 get
% the data of S1

%  INPUTS 
%  1. cnf - config setting point file
%  
%  OUPUTS 
%  1. cnf - config setting point file
%  2. newS11Flag - Flag set to 1 if S11=S1 added

%  October 2010 for nanoscopium 2 sextupoles are taken out of S1 family
%  and define a new S11 family
%% Written by Laurent S. Nadolski

newS11Flag = 0;

% Check if field does not exist or is empty
% This means that S11 was not defined when file was registered
if ~isfield(cnf.ConfigMonitor, 'S11')|| isempty(cnf.ConfigMonitor.S11.Monitor.Data)
    fprintf('Warning S11 does not exist. Add S11 family to file (S11=S1)\n');
    cnf.ConfigMonitor.S11 = cnf.ConfigMonitor.S1;
    cnf.ConfigMonitor.S11.Monitor.FamilyName='S11';

    cnf.ConfigSetpoint.S11 = cnf.ConfigSetpoint.S1;
    cnf.ConfigSetpoint.S11.Setpoint.FamilyName='S11';
    newS11Flag = 1;
end
end
function SetGoldenConfig(cnfdata)
%Set/Write configuration to Golden
        configgui('LBoxWait');
        FileName = getfamilydata('OpsData','LatticeFile');
        DirectoryName = getfamilydata('Directory','OpsData');
        AnswerString = questdlg(strvcat('Are you sure you want to overwrite the default lattice file?',sprintf('File: %s',[DirectoryName FileName])),'Default Lattice','Yes','No','No');
        if strcmp(AnswerString,'Yes')
            [DirectoryName, DirectoryErrorFlag] = gotodirectory(DirectoryName);
            FileName = getfamilydata('OpsData', 'LatticeFile');
            DirectoryName = getfamilydata('Directory', 'OpsData');
            ConfigSetpoint=cnfdata.SetpointData;
            ConfigMonitor=cnfdata.MonitorData;
            save(FileName, 'ConfigMonitor', 'ConfigSetpoint');
        else
            fprintf('   File not saved (getmachineconfig)\n');
            return;
        end
        set(cnfdata.handles.LoadGoldenTime,'String',datestr(now,0));
        configgui('LBoxWriteLast',' Write Configuration to Golden ');
end
function SetFileConfig(cnfdata, addTxtFile)
     %Set/Write configuration to file
        configgui('LBoxWait');
        % Determine file and directory name
        FileName = getfamilydata('Default','CNFArchiveFile');
        DirectoryName = getfamilydata('Directory','ConfigData');
        FileName = appendtimestamp(FileName, clock);
        if ~isempty(addTxtFile)
            FileName=[FileName addTxtFile];
        end    
        [FileName, DirectoryName] = uiputfile('*.mat','Save Lattice to ...', [DirectoryName FileName]);
        if FileName == 0
            fprintf('   File not saved (getmachineconfig)\n');
            return;
        end
        
        % Save all data in structure to file
        DirStart = pwd;
        [DirectoryName, DirectoryErrorFlag] = gotodirectory(DirectoryName);
        ConfigSetpoint=cnfdata.SetpointData;
        ConfigMonitor=cnfdata.MonitorData;
        try
            save(FileName, 'ConfigSetpoint', 'ConfigMonitor');
        catch
            cd(DirStart);
            return
        end
        cd(DirStart);
        %set(cnfdata.handles.SetFile,'TooltipString',FileName);
        set(cnfdata.handles.LoadFileTime,'String',datestr(now,0));
        configgui('LBoxWriteLast', [' Write Configuration to File ' FileName]);
        fprintf('Write Configuration to File:\n %s\n\n', [getfamilydata('Directory', 'ConfigData') FileName]);
end    
   
        