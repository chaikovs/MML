function tuneFBgui(action, Input2, Input3)
%tuneFBgui - GUI for tune feedback
%
%  INPUTS
%  None to launch the programme
%  1. action - Callback to execute
%  2. Input2 - First argument for callback function
%  3. Input3  First argument for callback function
%
%  OUPUTS
%  None
%

% For the compiler
%#function gettune
%#function solamor2linb
%#function solamor2linc
%#function lat_2020_3170f
%#function lat_2020_3170e
%#function lat_2020_3170b
%#function lat_2020_3170a
%#function lat_pseudo_nanoscopium_juin2011_122BPM
%#function lat_nano_176_234_122BPM
%#function lat_nano_155_229_122BPM_bxSDL01_09_11m

%
%  Written by Laurent S. Nadolski

% Check if the AO exists
checkforao;

DEBUGFLAG = 0;

% Dedicated dserver Device
devSpeakerName = getfamilydata('TANGO', 'TEXTTALKERS');

devLockName    = 'ANS/CA/SERVICE-LOCKER';

Mode = 'Online';
%Mode = 'Model';

% Arguments
if nargin < 1
    action = 'Initialize';
end

if nargin < 2
    Input2 = 0;
end

if nargin < 3
    Input3 = 0;
end

%

% Minimum stored current to allow correction
% Default values
DCCTMIN = read_fbnu_property('CurrentThreshold');
%DCCTMIN = 50; % mA multibunch
%DCCTMIN = 7; % mA single bunch

%%%%%%%%%%%%%%%%
%% Main Program
%%%%%%%%%%%%%%%%

switch(action)


    %% Initialize
    case 'Initialize'

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % GUI  CONSTRUCTION
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ButtonWidth  = 200;
        ButtonHeight = 25;

        Frame0height = 2*(ButtonHeight) + 10; % Close button. DO NOT MODIFY
        Frame1height = 12*(ButtonHeight) + 10 ; % Tune Feedback frame
        Frame2height = 4*(ButtonHeight) + 10 ; % Status frame
        FrameWidth   = ButtonWidth+6;
        FrameLeft    = 0.025*FrameWidth;
        LeftMargin   = 3*FrameLeft;

        Frametop  = Frame0height + Frame1height + Frame2height + 3*8;
        Frame1top = Frametop - 8;
        Frame2top = Frametop - Frame1height - 2*8;
        Frame0top = Frametop - Frame1height - Frame2height - 3*8;

        FigWidth    = 1.15*FrameWidth;                % Figure width
        FigHeight   = Frametop+0.2*ButtonHeight+6;% Figure heigth

        % Change figure position
        set(0,'Units','pixels');
        p = get(0,'screensize');

        orbfig = findobj(allchild(0),'tag','TUNEFBGUIFig1');

        if ~isempty(orbfig)
            return; % IHM already exists
        end

        h0 = figure( ...
            'Color',[0.1 0.1 1], ...
            'HandleVisibility','Off', ...
            'Interruptible', 'on', ...
            'MenuBar','none', ...
            'Name','TUNE FB CONTROL', ...
            'NumberTitle','off', ...
            'Units','pixels', ...
            'Position',[30 p(4)-FigHeight-40 FigWidth FigHeight], ...
            'Resize','off', ...
            'HitTest','off', ...
            'IntegerHandle', 'off', ...
            'Tag','TUNEFBGUIFig1');

        %% Frame Box I Tune Feedback frame
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ListboxTop',0, ...
            'Position',[FrameLeft Frame2top 1.1*FrameWidth Frame1height], ...
            'Style','frame');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin 3 + Frame1top - 1*(ButtonHeight+3) FrameWidth .6*ButtonHeight], ...
            'String','TUNE Feedback', ...
            'Style','text');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[LeftMargin 3 + Frame1top - 2*(ButtonHeight+3) 0.5*ButtonWidth-32 .8*ButtonHeight], ...
            'String','H-plane', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','TUNEFBGUICheckboxHcorrection');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[LeftMargin + 0.55*ButtonWidth 3 + Frame1top - 2*(ButtonHeight+3) 0.5*ButtonWidth-32 .8*ButtonHeight], ...
            'String','V-plane', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','TUNEFBGUICheckboxVcorrection');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 5*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','Golden Tunes', ...
            'Style','Text', ...
            'Value',0,...
            'Tag','TUNEFBGUIGoldenTune');


        uicontrol('Parent',h0, ...
            'Callback','tuneFBgui(''StartTuneFB'');', ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin 3 + Frame1top - 4*(ButtonHeight+3) 0.5*FrameWidth ButtonHeight], ...
            'String','Start TUNE FB', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','TUNEFBGUIStartTUNEFB');

        uicontrol('Parent',h0, ...
            'Callback','tuneFBgui(''StopTuneFB'');', ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin + 0.55*ButtonWidth  3 + Frame1top - 4*(ButtonHeight+3) 0.5*FrameWidth ButtonHeight], ...
            'String','Stop TUNE FB', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','TUNEFBGUIStopTUNEFB');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.5 0.5 1], ...
            'Enable','on', ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 6*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','Configuration settings', ...
            'Style','Text', ...
            'Value',0,...
            'Tag','TUNEFBGUISettings');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.5 0.5 1], ...
            'Enable','on', ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 7*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','Min Dnux', ...
            'Style','Text', ...
            'Value',0,...
            'Tag','TUNEFBGUIMinDnu');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.5 0.5 1], ...
            'Enable','on', ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 8*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','Max Dnux', ...
            'Style','Text', ...
            'Value',0,...
            'Tag','TUNEFBGUIMaxDnu');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.5 0.5 1], ...
            'Enable','on', ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 9*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','tuneFB.LoopDelay', ...
            'Style','Text', ...
            'Value',0,...
            'Tag','TUNEFBGUItuneFB.LoopDelay');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.5 0.5 1], ...
            'Enable','on', ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 10*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','tuneFB.factor', ...
            'Style','Text', ...
            'Value',0,...
            'Tag','TUNEFBGUItuneFB.factor');

        uicontrol('Parent',h0, ...
            'Callback','tuneFBgui(''CurrentThresholdSetting'');', ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ForegroundColor',[1 0 0], ...
            'Enable','on', ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 11*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','Current threshold setting', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','TUNEFBGUICurrentThresholdSetting');

        uicontrol('Parent',h0, ...
            'CreateFcn','tuneFBgui(''OrbitSetupTuneFB'',1);', ...
            'Callback','tuneFBgui(''OrbitSetupTuneFB'');', ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin 3 + Frame1top - 3*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','Edit FB configuration', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','TUNEFBGUIButtonTuneFBSetup');

        %% Frame Box Status
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ListboxTop',0, ...
            'Position',[FrameLeft Frame0top  1.1*FrameWidth Frame2height], ...
            'Style','frame');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'HorizontalAlignment','center', ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin Frame2top - 1*(ButtonHeight+3) ButtonWidth .7*ButtonHeight], ...
            'String','TUNEFB status ', ...
            'Style','text');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'HorizontalAlignment','center', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin Frame2top - 2*(ButtonHeight+3) 0.6*ButtonWidth .7*ButtonHeight], ...
            'String','To get Status Push button: ', ...
            'Style','text', ...
            'Tag','TUNEFBGUIStaticTextHeader');

        uicontrol('Parent',h0, ...
            'callback','tuneFBgui(''UpdateStatusTuneFB'');pause(0);', ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'HorizontalAlignment','center', ...
            'ListboxTop',0, ...
            'Position',[6 + 0.7*ButtonWidth Frame2top - 2.1*ButtonHeight 0.3*ButtonWidth .7*ButtonHeight], ...
            'String','Update', ...
            'Style','PushButton', ...
            'Tag','TUNEFBGUIUpdateStatusTuneFB');

        h1= uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 1], ...
            'ForegroundColor','b', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin+0.1*ButtonWidth Frame2top - 3*ButtonHeight 0.25*ButtonWidth .7*ButtonHeight], ...
            'String','H-plane', ...
            'Style','text', ...
            'Tag','TUNEFBGUIisTunexFBRunning');

        h2 = uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 1], ...
            'ForegroundColor','b', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin+0.4*ButtonWidth Frame2top - 3*ButtonHeight 0.25*ButtonWidth .7*ButtonHeight], ...
            'String','V-plane', ...
            'Style','text', ...
            'Tag','TUNEFBGUIisTunezFBRunning');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 0], ...
            'ForegroundColor','b', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin Frame2top - 4*ButtonHeight ButtonWidth .7*ButtonHeight], ...
            'String','current', ...
            'Style','text', ...
            'Tag','TUNEFBGUIStatus');

        %% Frame Box "Close"
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ListboxTop',0, ...
            'Position',[FrameLeft 8 1.1*FrameWidth 0.7*Frame0height], ...
            'Style','frame');

        uicontrol('Parent',h0, ...
            'Callback', 'close(gcbf);', ...
            'Enable','On', ...
            'Interruptible','Off', ...
            'Position',[LeftMargin 13 ButtonWidth ButtonHeight], ...
            'String','Close', ...
            'Tag','TUNEFBGUIClose');

        % Read planes for FB correction in device server

        try
            isTunexFBRunning = readattribute([devLockName, '/istunexfbrunning']);
            isTunezFBRunning = readattribute([devLockName, '/istunezfbrunning']);
        catch
            warndlg(sprintf('Error with dserveur %s', devLockName));
        end

        set(h1, 'Value',isTunexFBRunning);
        set(h2, 'value',isTunezFBRunning);


        if isTunexFBRunning || isTunezFBRunning
            % Disable buttons in GUI
            set(0,'showhiddenhandles','on');
            set(findobj(gcf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Enable','on');
            set(findobj(gcf,'Tag','TUNEFBGUIClose'),'Enable','on');
            set(findobj(gcf,'Tag','TUNEFBGUICheckboxHcorrection'),'Enable','off');
            set(findobj(gcf,'Tag','TUNEFBGUICheckboxVcorrection'),'Enable','off');
            pause(0);
        end

        % init FB structure
        pause(0.5)
        tuneFBgui('UpdateStatusTuneFB');               

        %tuneFBgui('ShowFBConfig');

    %% CurrentThresholdSetting
    case 'CurrentThresholdSetting'
     tuneFB = get(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Userdata');
     answer = inputdlg({'New Current Threshold'}, 'DIALOG BOX',1, {num2str(tuneFB.DCCTMIN)});
     if isempty(answer)
         return
     end
     tuneFB.DCCTMIN = str2num(answer{1});
     set(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Userdata', tuneFB);
     % UPDATE TANGO free property    
     write_fbnu_property('CurrentThreshold',num2str(tuneFB.DCCTMIN));
     
     strdata = sprintf('Corr. Percent.: %d %%  Min current: %d mA', tuneFB.fact*100, tuneFB.DCCTMIN);
     set(findobj(gcbf,'Tag','TUNEFBGUItuneFB.factor'),'String', strdata);


    %%  UpdateStatusTuneFB
    case 'UpdateStatusTuneFB'
        try
            isTunexFBRunning = readattribute([devLockName, '/istunexfbrunning']);
            isTunezFBRunning = readattribute([devLockName, '/istunezfbrunning']);

            if isempty(gcbf)
                mainFig = findall(0, 'Tag', 'TUNEFBGUIFig1');
            else
                mainFig = gcbf;
            end

            if isTunexFBRunning
                set(findobj(mainFig,'Tag','TUNEFBGUIisTunexFBRunning'),'BackGroundColor', [0 1 0]);
            else
                set(findobj(mainFig,'Tag','TUNEFBGUIisTunexFBRunning'),'BackGroundColor', [1 1 1]);
            end

            if isTunezFBRunning
                set(findobj(mainFig,'Tag','TUNEFBGUIisTunezFBRunning'),'BackGroundColor', [0 1 0]);
            else
                set(findobj(mainFig,'Tag','TUNEFBGUIisTunezFBRunning'),'BackGroundColor', [1 1 1]);
            end

            set(findobj(mainFig,'Tag','TUNEFBGUIStaticTextHeader'),'String', datestr(clock));

            sdata = sprintf('Stored current is %3.1f mA', getdcct(Mode));
            set(findobj(mainFig,'Tag','TUNEFBGUIStatus'),'String', sdata);
        catch
            dbstack
            fprintf('\n  %s \n',lasterr);
            fprintf('Error in UpdateStatusTuneFB\n') ;
        end

        %% OrbitSetupTuneFB
    case 'OrbitSetupTuneFB'
        % NOTES setting for FB

        InitFlag = Input2;  % Input #2: if InitFlag, then initialize variables

        if InitFlag % just at startup
            % Setup orbit correction elements : DEFAULT configuration
            tune0 = getgolden('TUNE',[1 1;1 2]);
            %tune0 = [0.2020; 0.3165];
            if any(tune0==0) % if bad golden
                tuneFB.Golden.tune(1) = 0.2020;
                tuneFB.Golden.tune(2) = 0.3100;
            else % otherwise take by default golden value
                tuneFB.Golden.tune = tune0;
            end

            % configuration of TUNEFB

            % minimum tune variation for correction
            tuneFB.minDeltaTuneX = 5e-4;
            tuneFB.minDeltaTuneZ = 6e-4;

            % maximum tune variation
            tuneFB.maxDeltaTuneX = 1e-2;
            tuneFB.maxDeltaTuneZ = 1e-2;

            % Feedback loop setup
            tuneFB.LoopDelay = 5.0;    % Period of Feedback loop [seconds], make sure the BPM averaging is correct

            % Maximum allowed tune variation during 3 seconds
            tuneFB.TuneErrorMax = 5e-3;

            % tuneFB.factor to apply for the correction 1 means full correction
            tuneFB.fact = 0.3;

            % Current trheshold for starting the feedback
            tuneFB.DCCTMIN = DCCTMIN;         

        else % For orbit correction Configuration
            tuneFB = get(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Userdata');
            answer = inputdlg({'Golden fractional tunex', 'Golden fractional tunez '},'DIALOG BOX',1,{num2str(tuneFB.Golden.tune(1)), num2str(tuneFB.Golden.tune(2))});
            if isempty(answer)
                return
            end
            tunex = str2num(answer{1});
            tunez = str2num(answer{2});

            if tunex > 0 && tunex < 0.5 && tunez > 0 && tunez < 0.5
                tuneFB.Golden.tune(1) = tunex;
                tuneFB.Golden.tune(2) = tunez;
            else
                warndlg('Wrong values: 0 < tune < 0.5')
                return;
            end
        end

        
        set(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Userdata', tuneFB);

        strdata = sprintf('tunex=%5.4f          tunez=%5.4f',tuneFB.Golden.tune);
        set(findobj(gcbf,'Tag','TUNEFBGUIGoldenTune'),'String', strdata);

        tuneFB = get(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Userdata');
        strdata = sprintf('Min DnuX=%5.1e    DnuZ=%5.1e', tuneFB.minDeltaTuneX, tuneFB.minDeltaTuneZ);
        set(findobj(gcbf,'Tag','TUNEFBGUIMinDnu'),'String', strdata);


        strdata = sprintf('Max DnuX=%5.1e    DnuZ=%5.1e', tuneFB.maxDeltaTuneX, tuneFB.maxDeltaTuneZ);
        set(findobj(gcbf,'Tag','TUNEFBGUIMaxDnu'),'String', strdata);


        strdata = sprintf('LoopDelay=%d s     TuneError=%5.1e', tuneFB.LoopDelay, tuneFB.TuneErrorMax);
        set(findobj(gcbf,'Tag','TUNEFBGUItuneFB.LoopDelay'),'String', strdata);


        strdata = sprintf('Corr. Percent.: %d %%  Min current: %d mA', tuneFB.fact*100, tuneFB.DCCTMIN);
        set(findobj(gcbf,'Tag','TUNEFBGUItuneFB.factor'),'String', strdata);


        %% StartTuneFB
    case 'StartTuneFB'

        % Check if not already running
        STATE = check4tunefb(devLockName);
        if STATE % Feedback already running
            fprintf('TuneFB:StartTuneFB: FB stopped (already running) at %s\n', datestr(clock));
            return;
        end


        % Check if plane(s) to correct is/are selected
        if ~get(findobj(gcbf,'Tag','TUNEFBGUICheckboxHcorrection'),'Value')  && ...
                ~get(findobj(gcbf,'Tag','TUNEFBGUICheckboxVcorrection'),'Value')
            warndlg('TuneFBgui:StartTuneFB: No plane selected, action aborted')
            fprintf('%s\n TuneFBgui:StartTuneFB: No plane selected, action aborted\n', datestr(clock))
            return;
        end


        % Confirmation dialogbox
        StartFlag = questdlg('Start orbit TUNE Feedback?', 'TUNE Feedback','Yes','No','No');

        if strcmp(StartFlag,'No')
            fprintf('   %s \n', datestr(clock));
            fprintf('   ***************************\n');
            fprintf('   **  TUNE  Feedback Exit  **\n');
            fprintf('   ***************************\n\n');
            pause(0);
            return
        end

        % Disable buttons in GUI
        set(0,'showhiddenhandles','on');
        set(findobj(gcf,'Tag','TUNEFBGUIButtonOrbitCorrectionSetupTuneFB'),'Enable','on');
        set(findobj(gcf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Enable','off');
        set(findobj(gcf,'Tag','TUNEFBGUIStartTUNEFB'),'Enable','off');
        set(findobj(gcf,'Tag','TUNEFBGUIStopTUNEFB'),'Enable','on');
        set(findobj(gcf,'Tag','TUNEFBGUICheckboxHcorrection'),'Enable','off');
        set(findobj(gcf,'Tag','TUNEFBGUICheckboxVcorrection'),'Enable','off');
        set(findobj(gcf,'Tag','TUNEFBGUIClose'),'Enable','off');
        pause(0);

        set(findobj(gcbf,'Tag','TUNEFBGUIStatus'),'BackgroundColor', [0 1 0])
        tuneFBgui('UpdateStatusTuneFB');

        tuneFB = get(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Userdata');
        % Lock service
        if get(findobj(gcbf,'Tag','TUNEFBGUICheckboxHcorrection'),'Value')
            tuneFB.XLockTag  = tango_command_inout2(devLockName,'Lock', 'istunexfbrunning');
        end
        if get(findobj(gcbf,'Tag','TUNEFBGUICheckboxVcorrection'),'Value')
            tuneFB.ZLockTag  = tango_command_inout2(devLockName,'Lock', 'istunezfbrunning');
        end

        set(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Userdata', tuneFB);
        tuneFBgui('UpdateStatusTuneFB');

        TUNE_FEEDBACK_STOP_FLAG = 0;
        setappdata(findobj(gcbf,'Tag','TUNEFBGUIFig1'),'TUNE_FEEDBACK_STOP_FLAG', TUNE_FEEDBACK_STOP_FLAG)

        % Number of error before stopping
        stallError = 0;
        stallErrorMax = 50; % Maximum error permissible
        % Init 
        tuneFB = get(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Userdata');
        
        tune_old  = tuneFB.Golden.tune;
        tune_old2 = tuneFB.Golden.tune;
        
        while TUNE_FEEDBACK_STOP_FLAG == 0 % infinite loop
            try
                t00 = gettime;
                fprintf('Iteration time %s\n',datestr(clock));

                % Check if GUI has been closed
                if isempty(gcbf)
                    TUNE_FEEDBACK_STOP_FLAG = 1;
                    lasterr('TUNE GUI DISAPPEARED!');
                    error('TUNE GUI DISAPPEARED!');
                end

                tuneFB = get(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Userdata');
                
                %% main loop
                % read tune from FBT

                if getdcct(Mode) < tuneFB.DCCTMIN     % Don't Feedback if the current is too small
                    TUNE_FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         TUNE Feedback stopped due to low beam current (<%d mA)\n',datestr(now), tuneFB.DCCTMIN);
                    strgMessage = 'Fideubaque des nombres d''ondes arraitai car le courant est trop bas';
                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    warndlg('TuneFB : arrété car courant trop bas');
                    tuneFBgui('StopTuneFB');
                    break;
                else
                    tune  = gettuneFBT;
                end

                % double reading for getting of parasite peaks
                pause(1);

                tune2  = gettuneFBT;

                ErrorTune = tune2-tune;
                if max(abs(ErrorTune)) > tuneFB.TuneErrorMax % redo measurement
                    fprintf('StallError #%d\n', stallError);
                    stallError = stallError + 1;
                    pause(1);
                    tune3  = gettuneFBT;
                    ErrorTune = tune3-tune2;
                    if max(abs(ErrorTune)) > tuneFB.TuneErrorMax %stop FB
                        TUNE_FEEDBACK_STOP_FLAG = 1;
                        fprintf('%s         TUNE Feedback stopped due tune oscillation\n',datestr(now));
                        strgMessage = 'Fideubaque des nombres d''ondes arraitai car oscillations des nombres d''ondes';
                        tango_giveInformationMessage(devSpeakerName,  strgMessage);
                        str1 = sprintf('TuneFB : arrété car oscillations des nombres d''ondes durant 3 s (max=%5.4f)\n', tuneFB.TuneErrorMax);
                        str2 = sprintf('tunex(1) = %5.4f tunex(2) = %5.4f tunex(3) = %5.4f\n', ...
                            tune(1), tune2(1), tune3(1));
                        str3 = sprintf('tunez(1) = %5.4f tunez(2) = %5.4f tunez(3) = %5.4f\n', ...
                            tune(2), tune2(2), tune3(2));
                        warndlg([str1 str2 str3]);
                        fprintf([str1 str2 str3]);
                        tuneFBgui('StopTuneFB');
                        pause(1)
                        break;
                    else
                        tune = tune3;
                    end
                end                      
                
                if stallError > stallErrorMax     % Don't Feedback if the current is too small
                    TUNE_FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         TUNE Feedback stopped due stallError Max reached on tunes\n',datestr(now));
                    strgMessage = 'Fideubaque des nombres d''ondes arraitai car trop d''erreurs';
                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    warndlg(sprintf('TuneFB : trop d''erreurs, %d', stallErrorMax));
                    tuneFBgui('StopTuneFB');
                    pause(1)
                    break;
                end

                % Further more checking on tune values

                if any(tune==0) || any(isnan(tune))
                    str1 = sprintf('TuneFB:StartTuneFB: something is wrong with the tunes reading\n');
                    str2 = sprintf('TuneFB:StartTuneFB: FB stopped at %s\n', datestr(clock));
                    fprintf([str1 str2]);
                    warndlg([str1 str2]);
                    strgMessage = 'Arret du fiideubaque des nombres d''ondes : problaime de mesure';
                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    tuneFBgui('StopTuneFB');
                    break                
                else
                    deltaTune = tune - tuneFB.Golden.tune;
                end


                % Zeroing tunex if not selected for correction
                if ~get(findobj(gcbf,'Tag','TUNEFBGUICheckboxHcorrection'),'Value')
                    deltaTune(1) =0;
                end

                % Zeroing tunez if not selected for correction
                if ~get(findobj(gcbf,'Tag','TUNEFBGUICheckboxVcorrection'),'Value')
                    deltaTune(2) =0;
                end

                if abs(deltaTune(1)) > tuneFB.maxDeltaTuneX && get(findobj(gcbf,'Tag','TUNEFBGUICheckboxHcorrection'),'Value')
                    TUNE_FEEDBACK_STOP_FLAG = 1;
                    fprintf('TuneFB:StartTuneFB:%s         TUNE Feedback stopped due to too large tune variations\n',datestr(now));
                    str1 = sprintf('deltaNux = %5.4f (max: %5.4f) \ndeltaNuz = %5.4f (max: %5.4f) \n', ...
                        deltaTune(1), tuneFB.maxDeltaTuneX, deltaTune(2), tuneFB.maxDeltaTuneZ);
                    fprintf(str1);
                    str2 = sprintf('TuneFB:StartTuneFB: arret Feedback \n car variations des nombres d''ondes trop importantes\n ');
                    strgMessage = 'Arret du fiideubaque des nombres d''ondes : variations trop grandes';
                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    warndlg([str2, str1]);
                    tuneFBgui('StopTuneFB');
                    break;
                elseif abs(deltaTune(2)) > tuneFB.maxDeltaTuneZ && get(findobj(gcbf,'Tag','TUNEFBGUICheckboxVcorrection'),'Value')
                    TUNE_FEEDBACK_STOP_FLAG = 1;
                    fprintf('TuneFB:StartTuneFB:%s         TUNE Feedback stopped due to too large tune variations\n',datestr(now));
                    str1 = sprintf('deltaNux = %5.4f (max: %5.4f) \ndeltaNuz = %5.4f (max: %5.4f) \n', ...
                        deltaTune(1), tuneFB.maxDeltaTuneX, deltaTune(2), tuneFB.maxDeltaTuneZ);
                    fprintf(str1);
                    str2 = sprintf('TuneFB:StartTuneFB: arret Feedback \n car variations des nombres d''ondes trop importantes\n ');
                    tango_command_inout2(devSpeakerName,'DevTalk','Arret du fiideubaque des nombres d''ondes : variations trop grandes');
                    warndlg([str2, str1]);
                    tuneFBgui('StopTuneFB');
                    break;
                elseif getdcct(Mode) < tuneFB.DCCTMIN     % Don't Feedback if the current is too small
                    TUNE_FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         TUNE Feedback stopped due to low beam current (<%d mA)\n',datestr(now), tuneFB.DCCTMIN);
                    strgMessage = 'Arret du fiideubaque des nombres d''ondes : courant trop bas';
                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    warndlg('TuneFB;StartTuneFB: arret Feedback car courant trop bas');
                    tuneFBgui('StopTuneFB');
                    break;
                else
                    % Correction tune using Q7 and Q9
                    if abs(deltaTune(1)) < tuneFB.minDeltaTuneX && abs(deltaTune(2)) < tuneFB.minDeltaTuneZ
                        fprintf('Skip correction Dnux = %5.4e < %5.4e, Dnuz = %5.4e < %5.4e\n', deltaTune(1), ...
                            tuneFB.minDeltaTuneX, deltaTune(2), tuneFB.minDeltaTuneZ)
                    else
                        if DEBUGFLAG
                            QuadVal = steptune(-deltaTune*tuneFB.fact,Mode,'NoSp');
                            fprintf('Correction Dnux=%5.4f Dnuz=%5.4f\n', deltaTune*tuneFB.fact)
                            fprintf('Quadrupole changes: Q7=%3.2e A, Q9=%3.2e A\n', QuadVal);
                        end                        
                        % Check if tune reading is frozen then stop FB
                        if any(tune - tune_old2 == 0)
                            if tune(1) == tune_old2(1)
                                str1 = sprintf('TuneFB:StartTuneFB: nux does not change\n');
                            end
                            if tune(2) == tune_old2(2)
                                str1 = sprintf('TuneFB:StartTuneFB: nuz does not change\n');
                            end
                            str2 = sprintf('TuneFB:StartTuneFB: FB stopped at %s\n', datestr(clock));
                            fprintf([str1 str2]);
                            fprintf('nux = %f nux_old = %f nuz = %f nuz_old = %f \n', tune(1), tune_old2(1), ...
                                tune(2), tune_old2(2));
                            warndlg([str1 str2]);
                            strgMessage = 'Arret du fiideubaque des nombres d''ondes : problaime de mesure';
                            tango_giveInformationMessage(devSpeakerName,  strgMessage);
                            tuneFBgui('StopTuneFB');
                            break
                        else
                            tune_old1 = tune_old;
                            tune_old = tune;
                            steptune(-deltaTune*tuneFB.fact, Mode);
                        end
                    end
                end

                % Pause until tuneFB.LoopDelay
                if DEBUGFLAG
                    fprintf('Time elapsed between 2 iterations (before pause) is %f s\n', gettime-t00);
                end

                while (gettime-t00) < tuneFB.LoopDelay
                    pause(.1); % pause large enough for allowing GUI interaction
                    % Check if GUI has been closed
                    if isempty(gcbf)
                        TUNE_FEEDBACK_STOP_FLAG = 1;
                        lasterr('TUNEGUI GUI DISAPPEARED!');
                        error('TUNEGUI GUI DISAPPEARED!');
                    end
                    %% fast loop to check whether FB loop was asked to be stopped
                    if TUNE_FEEDBACK_STOP_FLAG == 0
                        TUNE_FEEDBACK_STOP_FLAG = getappdata(findobj(gcbf,'Tag','TUNEFBGUIFig1'),'TUNE_FEEDBACK_STOP_FLAG');
                    end
                end
                tuneFBgui('UpdateStatusTuneFB');

                % Pause until tuneFB.LoopDelay
                if DEBUGFLAG
                    fprintf('Time elapsed between 2 iterations (after pause) is %f s\n', gettime-t00);
                end
                
                % Maintain lock on FB service
                if get(findobj(gcbf,'Tag','TUNEFBGUICheckboxHcorrection'),'Value')
                    argin.svalue={'istunexfbrunning'};
                    argin.lvalue=int32(tuneFB.XLockTag);
                    tango_command_inout2(devLockName,'MaintainLock', argin);
                end

                if get(findobj(gcbf,'Tag','TUNEFBGUICheckboxVcorrection'),'Value')
                    argin.svalue={'istunezfbrunning'};
                    argin.lvalue=int32(tuneFB.ZLockTag);
                    tango_command_inout2(devLockName,'MaintainLock', argin);
                end

                % Check if button stop was pressed
                TUNE_FEEDBACK_STOP_FLAG = getappdata(findobj(gcbf,'Tag','TUNEFBGUIFig1'),'TUNE_FEEDBACK_STOP_FLAG');

            catch
                dbstack
                fprintf('\n  %s \n',lasterr);
                warndlg('Tune Feedback stopped on fatal error');
                strgMessage = 'Erreur fatale, arret du fiideubaque des nombres d''ondes';
                tango_giveInformationMessage(devSpeakerName,  strgMessage);
                TUNE_FEEDBACK_STOP_FLAG = 1;
                tuneFBgui('StopTuneFB');
                set(findobj(gcbf,'Tag','TUNEFBGUIStatus'),'BackgroundColor', [1 0 0])
            end
        end



        %% StopTuneFB
    case 'StopTuneFB'

        setappdata(findobj(gcbf,'Tag','TUNEFBGUIFig1'),'TUNE_FEEDBACK_STOP_FLAG', 1);

        tuneFB = get(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Userdata');

        % Unlock TUNE service

        if get(findobj(gcbf,'Tag','TUNEFBGUICheckboxHcorrection'),'Value')
            argin.svalue={'istunexfbrunning'};
            argin.lvalue=int32(tuneFB.XLockTag);
            tango_command_inout2(devLockName,'Unlock', argin);
        end

        if get(findobj(gcbf,'Tag','TUNEFBGUICheckboxVcorrection'),'Value')
            argin.svalue={'istunezfbrunning'};
            argin.lvalue=int32(tuneFB.ZLockTag);
            tango_command_inout2(devLockName,'Unlock', argin);
        end

        set(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Userdata', tuneFB);
        tuneFBgui('UpdateStatusTuneFB');

        fprintf('   %s \n', datestr(clock));
        fprintf('   ***************************\n');
        fprintf('   **  TUNE  Feedback Stopped**\n');
        fprintf('   ***************************\n\n');
        pause(1);

        % enable buttons in GUI
        set(0,'showhiddenhandles','on');

        set(findobj(gcbf,'Tag','TUNEFBGUIButtonTuneFBSetup'),'Enable','on');
        set(findobj(gcbf,'Tag','TUNEFBGUIStartTUNEFB'),'Enable','on');
        set(findobj(gcbf,'Tag','TUNEFBGUIStopTUNEFB'),'Enable','off');
        set(findobj(gcbf,'Tag','TUNEFBGUICheckboxHcorrection'),'Enable','on');
        set(findobj(gcbf,'Tag','TUNEFBGUICheckboxVcorrection'),'Enable','on');
        set(findobj(gcbf,'Tag','TUNEFBGUIClose'),'Enable','on');
        pause(0);

    otherwise
        fprintf('   Unknown action name: %s.\n', action);

end

%% Check status of tune feedback
function STATE = check4tunefb(devLockName)

STATE = 0;
if strcmp(getmode('Q7'),'Online') && strcmp(getmode('Q9'),'Online')
    %look for already running feedback loops

    isTunexFBRunning = readattribute([devLockName, '/istunexfbrunning']);

    isTunezFBRunning = readattribute([devLockName, '/istunezfbrunning']);

    if isTunexFBRunning
        warning('TUNEX FB is already running. Stop other application first!')
        warndlg('TUNEX FB is already running. Stop other application first!')
        STATE = 1;
    end

    if isTunezFBRunning
        warning('TUNEZ FB is already running. Stop other application first!')
        warndlg('TUNEZ FB is already running. Stop other application first!')
        STATE = 1; 
    end
end



%% Write database property
function write_fbnu_property (prop_name, prop_val)
    db = tango_get_dbname; % Get database
    cmd_name = 'DbPutProperty';
    cmd_arg  = {'FBnu', '1', prop_name, '1', num2str(prop_val)};
    tango_command_inout2(db, cmd_name, cmd_arg);

   
%% Read database property    
function pv = read_fbnu_property(prop_name)
    db = tango_get_dbname;  % Get database
    cmd_name = 'DbGetProperty';
    cmd_arg  = {'FBnu', prop_name};
    cmd_res = tango_command_inout2(db, cmd_name, cmd_arg);
    pv = str2double(cmd_res(5));
