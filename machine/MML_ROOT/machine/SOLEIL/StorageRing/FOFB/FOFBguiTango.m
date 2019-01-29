function FOFBguiTango(action, Input2, Input3)
%FOFBguiTango - GUI for FOFB correction configurion and RF Feedback
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
%  NOTES
%  1. Settings for FOFB and manual orbit correction are often different
%  2. Manual Correction : 3 iterations are done in a row

%
%  See Also setorbit, FOFBgui

% For Compiler
%#function lat_2020_3170a
%#function solamor2linb
%#function solamor2linc
%#function gethbpmaverage
%#function getvbpmaverage
%#function gethbpmgroup
%#function getvbpmgroup




%
%  Written by Laurent S. Nadolski

% Check if the AO exists
checkforao;
devSpeakerName = getfamilydata('TANGO', 'TEXTTALKERS');
devLockName    = 'ANS/CA/SERVICE-LOCKER';
devRFFBManager = 'ANS/DG/RFFB-MANAGER';
devFOFBManager = 'ANS/DG/FOFB-MANAGER';

% orbit golden
fileName = 'GoldenMatrix4FPGA.mat';


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

% Common variables
SR_GEV = getenergy('Energy');

% BPM Families
BPMxFamily = 'BPMx';
BPMyFamily = 'BPMz';

% Corrector Families
HCMFamily  = 'FHCOR';
VCMFamily  = 'FVCOR';

% number of correctors and BPMs
HCMfullList  = family2dev(HCMFamily,0);
VCMfullList  = family2dev(VCMFamily,0);
BPMxfullList = family2dev(BPMxFamily,0);
BPMyfullList = family2dev(BPMyFamily,0);

nHCM =  size(HCMfullList,1);
nVCM =  size(VCMfullList,1);
nBPMx=  size(BPMxfullList,1);
nBPMy=  size(BPMyfullList,1);
%

% Minimum stored current to allow correction
DCCTMIN = 1; % mA

%%%%%%%%%%%%%%%%
%% Main Program
%%%%%%%%%%%%%%%%

switch(action)

%% StopOrbitFeedback    
    case 'StopOrbitFeedback'

        setappdata(findobj(gcbf,'Tag','FOFBguiTangoFig1'),'RF_FEEDBACK_STOP_FLAG', 1);
        set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextInformation'),'String','RF Feedback stopped');
        pause(0);

%% StopOrbitDCFeedback        
    case 'StopOrbitDCFeedback'

        setappdata(findobj(gcbf,'Tag','FOFBguiTangoFig1'),'DC_FEEDBACK_STOP_FLAG', 1);
        %set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextInformation'),'String','DC Feedback stopped');
        pause(0);

%% Initialize       
    case 'Initialize'

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % GUI  CONSTRUCTION
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ButtonWidth   = 250;
        ButtonHeight  = 25;

        Offset1f    = 2*(ButtonHeight+3);             % Frame around Text information
        Offset5f    = Offset1f + 3*(ButtonHeight+3);  % Frame around DC DB
        Offset2f    = Offset5f + 4*(ButtonHeight+3);  % Frame around FOFB and RF FB
        Offset3f    = Offset2f + 11*(ButtonHeight+3); % FOFB Configuration
        FigWidth    = ButtonWidth + 6;                % Figure width
        FigHeight   = Offset3f + 5.5*(ButtonHeight+3);% Figure heigth
        ButtonWidth = ButtonWidth-6;

        % Change figure position
        set(0,'Units','pixels');
        p = get(0,'screensize');

        orbfig = findobj(allchild(0),'tag','FOFBguiTangoFig1');

        if ~isempty(orbfig)
            return; % IHM already exists
        end

        h0 = figure( ...
            'Color',[0.1 0.1 1], ...
            'HandleVisibility','Off', ...
            'Interruptible', 'on', ...
            'MenuBar','none', ...
            'Name','FOFB CONTROL TANGO', ...
            'NumberTitle','off', ...
            'Units','pixels', ...
            'Position',[30 p(4)-FigHeight-40 FigWidth FigHeight], ...
            'Resize','off', ...
            'HitTest','off', ...
            'IntegerHandle', 'off', ...
            'Tag','FOFBguiTangoFig1');

        % Frame Box I
        uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 0], ...
            'ListboxTop',0, ...
            'Position',[3 Offset3f ButtonWidth+6 4.5*ButtonHeight+25], ...
            'Style','frame');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 0], ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[6 3 + 4*(ButtonHeight+3)+Offset3f  ButtonWidth .6*ButtonHeight], ...
            'String','FOFB configuration', ...
            'Style','text');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 0], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3 + 3*(ButtonHeight+3) + Offset3f ButtonWidth-32 .8*ButtonHeight], ...
            'String','H-plane', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','FOFBguiTangoCheckboxHcorrection');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 0], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3+2*(ButtonHeight+3)+Offset3f ButtonWidth-32 .8*ButtonHeight], ...
            'String','V-plane', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','FOFBguiTangoCheckboxVcorrection');

        uicontrol('Parent',h0, ...
            'Callback','FOFBguiTango(''OrbitCorrectionFOFB'');', ...
            'Interruptible','Off', ...
            'Enable','On', ...
            'Position',[6 3+1*(ButtonHeight+3)+Offset3f ButtonWidth ButtonHeight], ...
            'String','Correct Orbit', ...
            'Tag','FOFBguiTangoButtonOrbitCorrection');

        uicontrol('Parent',h0, ...
            'CreateFcn','FOFBguiTango(''OrbitCorrectionSetupFOFB'',1);', ...
            'callback','FOFBguiTango(''OrbitCorrectionSetupFOFB'',0);', ...
            'Enable','on', ...
            'Interruptible', 'off', ...
            'Position',[6 3+0*(ButtonHeight+3)+Offset3f ButtonWidth 0.8*ButtonHeight], ...
            'String','Edit BPM, CM Lists', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB');
 
        % modif 03/01/2012 pour suppression bouton Generate new Matrix for
        % FPGA
%         uicontrol('Parent',h0, ...
%             'callback','FOFBguiTango(''ConvertMatrix4FPGA'',0);', ...
%             'Enable','on', ...
%             'Interruptible', 'off', ...
%             'Position',[6 3+Offset3f ButtonWidth 0.8*ButtonHeight], ...
%             'String','Generate new Matrix for FPGA', ...
%             'Style','PushButton', ...
%             'Value',0,...
%             'Tag','FOFBguiTangoButtonConvertMatrix4FPGA');

        % Frame Box II
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ListboxTop',0, ...
            'Position',[3 Offset2f ButtonWidth+6 11*ButtonHeight+5], ...
            'Style','frame');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[6 3+9*(ButtonHeight+3)+ Offset2f ButtonWidth .55*ButtonHeight], ...
            'String','FOFB and RF Feedback', ...
            'Style','text');

        h1 = uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''TOGGLEHPLANEFOFB'');', ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3 + 8*(ButtonHeight+3) + Offset2f ButtonWidth-32 .8*ButtonHeight], ...
            'String','H-plane', ...
            'Style','checkbox', ...
            'Value',0,...
            'Tag','FOFBguiTangoCheckboxHFOFB');

        h2 = uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''TOGGLEVPLANEFOFB'');', ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3+7*(ButtonHeight+3)+Offset2f ButtonWidth-32 .8*ButtonHeight], ...
            'String','V-plane', ...
            'Style','checkbox', ...
            'Value',0,...
            'Tag','FOFBguiTangoCheckboxVFOFB');

        h3 = uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','off', ...
            'Interruptible', 'on', ...
            'Position',[26 3+6*(ButtonHeight+3)+Offset2f ButtonWidth-32 .8*ButtonHeight], ...
            'String','Correct RF Frequency', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','FOFBguiTangoCheckboxRF');
   
        h4 = uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 + 0.5*ButtonWidth  3 + 8*(ButtonHeight+3) + Offset2f 0.5*ButtonWidth-32 .8*ButtonHeight], ...
            'String','H-Loop-Gain = ', ...
            'Style','text', ...
            'Tag','FOFBguiTangoXgain');
 
        h5 = uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 + 0.5*ButtonWidth  3+7*(ButtonHeight+3)+Offset2f 0.5*ButtonWidth-32 .8*ButtonHeight], ...
            'String','V-Loop-Gain = ', ...
            'Style','text', ...
            'Tag','FOFBguiTangoYgain');

        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''FOFBRunningMode'');', ...
            'BackgroundColor',[1 0.4 0.4], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 + 0.5*ButtonWidth 3+6*(ButtonHeight+3)+Offset2f 0.5*ButtonWidth-32 .8*ButtonHeight], ...
            'String','FOFB+SOFB', ...
            'Style','checkbox', ...
            'Value',0,...
            'Tag','FOFBguiTangoCheckboxFOFB_SOFB');

        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''STARTRFFOFB'');', ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[8 3+5*(ButtonHeight+3)+ Offset2f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','Start RFFB', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonStartRFFB');

        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''STOPRFFOFB'');pause(0);', ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[.5*FigWidth+3 3+5*(ButtonHeight+3)+Offset2f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','Stop RFFB', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonStopRFFB');
        
        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''StartFOFB'');pause(0);', ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[8 3+4*(ButtonHeight+3)+Offset2f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','Start FOFB', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonStop2CurrentValues');

        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''StartFOFBConfig'');pause(0);', ...
            'BackgroundColor', [1 0 0], ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[.5*FigWidth+3 3+4*(ButtonHeight+3)+ Offset2f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','Start FOFB+config', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonStart');


        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''StopFOFB2CurrentValues'');pause(0);', ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[8 3+3*(ButtonHeight+3)+Offset2f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','Stop to current', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonStop2CurrentValues');

        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''StopFOFB2Zero'');pause(0);', ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[.5*FigWidth+3 3+3*(ButtonHeight+3)+Offset2f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','Stop FOFB to zero', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonStop2Zero');

        uicontrol('Parent',h0, ...
            'callback','FOFB_defauts;', ...
            'BackgroundColor', [1 1 0], ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[8 3+2*(ButtonHeight+3)+Offset2f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','Defaults', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonFOFBDefaults');

        uicontrol('Parent',h0, ...
            'callback','system(''atkpanel ANS/DG/FOFB-MANAGER &'')', ...
            'BackgroundColor', [1 1 0], ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[.5*FigWidth+3 3+2*(ButtonHeight+3)+Offset2f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','FOFB-Manager', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonFOFBManager');

        uicontrol('Parent',h0, ...
            'callback','system(''atkpanel ANS/DG/RFFB-MANAGER &'');', ...
            'BackgroundColor', [1 1 0], ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[.5*FigWidth+3 3+1*(ButtonHeight+3)+Offset2f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','RFFB-Manager', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonRFFBManager');

        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''ZeroingFHCOR'');pause(0);', ...
            'BackgroundColor', [1 0 0], ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[6 3+0*(ButtonHeight+3)+Offset2f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','FHCOR2zeros', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonHfcm2zero');

        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''ZeroingFVCOR'');pause(0);', ...
            'BackgroundColor', [1 0 0], ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[.5*FigWidth+3 3+0*(ButtonHeight+3)+Offset2f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','FVCOR2zeros', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonVfcm2zero');

%         uicontrol('Parent',h0, ...
%             'CreateFcn','FOFBguiTango(''FeedbackSetupFOFB'',1);', ...
%             'callback','FOFBguiTango(''FeedbackSetupFOFB'',0);', ...
%             'Enable','on', ...
%             'Interruptible', 'off', ...
%             'Position',[8 3 + Offset2f ButtonWidth-5 .75*ButtonHeight], ...
%             'String','Edit FOFB Setup', ...
%             'Style','PushButton', ...
%             'Value',0,...
%             'Tag','FOFBguiTangoButtonFeedbackSetup');
% 
        % Frame Box III % Orbit DC Feedback

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ListboxTop',0, ...
            'Position',[3 Offset5f ButtonWidth+6 4*ButtonHeight+5], ...
            'Style','frame');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[26 3+3*(ButtonHeight+3)+Offset5f 0.8*ButtonWidth .55*ButtonHeight], ...
            'String','Orbit DC Feedback', ...
            'Style','text');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[26 3+2*(ButtonHeight+3)+Offset5f ButtonWidth-32 .8*ButtonHeight], ...
            'String','H-plane', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','FOFBguiTangoCheckboxHDCFB');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[6+0.4*ButtonWidth 3+2*(ButtonHeight+3)+Offset5f 0.6*ButtonWidth-32 .8*ButtonHeight], ...
            'String','V-plane', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','FOFBguiTangoCheckboxVDCFB');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3+1*(ButtonHeight+3)+Offset5f ButtonWidth-32 .8*ButtonHeight], ...
            'String','Correct DC RF Frequency', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','FOFBguiTangoCheckboxDCRF');

        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''StartDCFB'');', ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[8 6+Offset5f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','Start DCFB', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonStartDC');

        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''StopOrbitDCFeedback'');pause(0);', ...
            'Enable','off', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[.5*FigWidth+3 6 + Offset5f .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','Stop DC FB', ...
            'Value',0, ...
            'Tag','FOFBguiTangoPushbuttonStopDC');

       
        % Frame Box IV
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ListboxTop',0, ...
            'Position',[3 Offset1f  ButtonWidth+6 3*ButtonHeight], ...
            'Style','frame');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'HorizontalAlignment','center', ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[6 Offset1f + 2.2*ButtonHeight 1*ButtonWidth .7*ButtonHeight], ...
            'String','FOFB status ', ...
            'Style','text');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'HorizontalAlignment','center', ...
            'ListboxTop',0, ...
            'Position',[6 Offset1f + 1.5*ButtonHeight 0.6*ButtonWidth .7*ButtonHeight], ...
            'String','To get Status Push button: ', ...
            'Style','text', ...
            'Tag','FOFBguiTangoStaticTextHeader');

        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''UpdateStatusFOFB'');pause(0);', ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'HorizontalAlignment','center', ...
            'ListboxTop',0, ...
            'Position',[6 + 0.6*ButtonWidth Offset1f + 1.7*ButtonHeight 0.3*ButtonWidth .7*ButtonHeight], ...
            'String','Update', ...
            'Style','PushButton', ...
            'Tag','FOFBguiTangoUpdateStatusFOFB');

        uicontrol('Parent',h0, ...
            'callback','FOFBguiTango(''OpenSynchInterface'');pause(0);', ...
            'BackgroundColor',[1 0 0], ...
            'HorizontalAlignment','center', ...
            'ListboxTop',0, ...
            'Position',[6 Offset1f + 0.95*ButtonHeight 0.98*ButtonWidth .7*ButtonHeight], ...
            'String','BPM not synchronized', ...
            'Style','PushButton', ...
            'Tag','FOFBguiTangoOpenSynchInterface');
        
        uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 1], ...
            'ForegroundColor','b', ...
            'ListboxTop',0, ...
            'Position',[6+ 0*ButtonWidth 3 + Offset1f + .05*ButtonHeight 0.18*ButtonWidth .7*ButtonHeight], ...
            'String','H-plane', ...
            'Style','text', ...
            'Tag','FOFBguiTangoisxFOFBRunning');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 1], ...
            'ForegroundColor','b', ...
            'ListboxTop',0, ...
            'Position',[6+0.2*ButtonWidth 3 + Offset1f + .05*ButtonHeight 0.18*ButtonWidth .7*ButtonHeight], ...
            'String','V-plane', ...
            'Style','text', ...
            'Tag','FOFBguiTangoiszFOFBRunning');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 1], ...
            'ForegroundColor','b', ...
            'ListboxTop',0, ...
            'Position',[6+0.4*ButtonWidth 3 + Offset1f + .05*ButtonHeight 0.18*ButtonWidth .7*ButtonHeight], ...
            'String','RF', ...
            'Style','text', ...
            'Tag','FOFBguiTangoisRFRunning');
        
        uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 1], ...
            'ForegroundColor','b', ...
            'ListboxTop',0, ...
            'Position',[6+0.6*ButtonWidth 3 + Offset1f + .05*ButtonHeight 0.18*ButtonWidth .7*ButtonHeight], ...
            'String','DC', ...
            'Style','text', ...
            'Tag','FOFBguiTangoisDCFBRunning');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 1], ...
            'ForegroundColor','b', ...
            'ListboxTop',0, ...
            'Position',[6+0.8*ButtonWidth 3 + Offset1f + .05*ButtonHeight 0.18*ButtonWidth .7*ButtonHeight], ...
            'String','SOFB', ...
            'Style','text', ...
            'Tag','FOFBguiTangoisSOFBRunning');
        

        % Frame Box "Close"
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ListboxTop',0, ...
            'Position',[3 8 ButtonWidth+6 ButtonHeight+8], ...
            'Style','frame');

        uicontrol('Parent',h0, ...
            'Callback', 'close(gcbf);', ...
            'Enable','On', ...
            'Interruptible','Off', ...
            'Position',[6 13 ButtonWidth ButtonHeight], ...
            'String','Close', ...
            'Tag','FOFBguiTangoClose');

        % Read planes for FOFB correction in device server
        attr_list={'applyCmdsToXPlane','applyCmdsToZPlane'};
        result=tango_read_attributes2(devFOFBManager,attr_list);

        set(h1, 'Value',result(1).value(1));
        set(h2, 'value',result(2).value(1));
        set(h3, 'value',readattribute([devRFFBManager, '/isRunning']));
        
        %Read BPM Synchronisation status in device server
        SynchStatus=CheckFOFBSynch;

        if SynchStatus
            set(findobj(h0,'Tag','FOFBguiTangoOpenSynchInterface'),'BackGroundColor', [0 1 0],'String','BPMs synchronized');
        else
            set(findobj(h0,'Tag','FOFBguiTangoOpenSynchInterface'),'BackGroundColor', [1 0 0],'String','BPMs not synchronized! Click here!');
        end


        % Read default loop gain and display it 
        FB=get(findobj(h0,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata');
        set(h4,'string',['H-Loop-Gain = ',num2str(FB.Xgain)]);
        set(h5,'string',['V-Loop-Gain = ',num2str(FB.Ygain)]);
         
        
        % Does not work. Need to get the full interfaced built!
        %FOFBguiTango('UpdateStatusFOFB');pause(0);
        
        % Lock RF FB now that RF is taken care by fast horizontal steerers
        set(findobj(h0,'Tag','FOFBguiTangoPushbuttonStartRFFB'), 'Enable','off');
        set(findobj(h0,'Tag','FOFBguiTangoPushbuttonStopRFFB'), 'Enable','off');
        
        isRFRunning    = readattribute([devRFFBManager, '/isRunning']);
        isxFOFBRunning = readattribute([devFOFBManager, '/xFofbRunning']);
        iszFOFBRunning = readattribute([devFOFBManager, '/zFofbRunning']);

        set(findobj(h0,'Tag','FOFBguiTangoButtonOrbitCorrection'),'Enable','off');

        if isRFRunning || isxFOFBRunning || iszFOFBRunning
            % Disable buttons in GUI
            set(0,'showhiddenhandles','on');
            set(findobj(h0,'Tag','FOFBguiTangoButtonOrbitCorrection'),'Enable','off');
            set(findobj(h0,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Enable','on');
            set(findobj(h0,'Tag','FOFBguiTangoButtonFeedbackSetup'),'Enable','off');
            set(findobj(h0,'Tag','FOFBguiTangoClose'),'Enable','on');
            set(findobj(h0,'Tag','FOFBguiTangoCheckboxHSOFB'),'Enable','off');
            set(findobj(h0,'Tag','FOFBguiTangoCheckboxVSOFB'),'Enable','off');
            set(findobj(h0,'Tag','FOFBguiTangoCheckboxHcorrection'),'Enable','off');
            set(findobj(h0,'Tag','FOFBguiTangoCheckboxVcorrection'),'Enable','off');
            set(findobj(h0,'Tag','FOFBguiTangoCheckboxRF'),'Enable','off');
            set(findobj(h0,'Tag','FOFBguiTangoCheckboxSOFB'),'Enable','off')
            set(findobj(h0,'Tag','FOFBguiTangoCheckboxFOFB'),'Enable','off')
            set(findobj(h0,'Tag','FOFBguiTangoButtonConvertMatrix4FPGA'),'Enable','on');
            %set(findobj(h0,'Tag','FOFBguiTangoPushbuttonStartDC'),'Enable','off');
            pause(0);
        end
        
        % init FOFB structure
        pause(0.5)
        FOFBguiTango('UpdateStatusFOFB');
                    
        
%%  UpdateStatusFOFB       
    case 'UpdateStatusFOFB'
        try
            isRFRunning    = readattribute([devRFFBManager, '/isRunning']);
            isxFOFBRunning = readattribute([devFOFBManager, '/xFofbRunning']);
            iszFOFBRunning = readattribute([devFOFBManager, '/zFofbRunning']);
            isDCFBRunning  = readattribute([devLockName, '/dcfb']);
            isSOFBRunning  = readattribute([devLockName, '/sofb']);
            SynchStatus=CheckFOFBSynch;

            %FOFBguiTangoiszFOFBRunning
            %FOFBguiTangoUpdateStatusFOFB
            if isempty(gcbf)
                %mainFig = gcf;
                mainFig = findobj(allchild(0),'tag','FOFBguiTangoFig1');
            else
                mainFig = gcbf;
            end
            
            if isRFRunning
                set(findobj(mainFig,'Tag','FOFBguiTangoisRFRunnning'),'BackGroundColor', [0 1 0]);
            else
                set(findobj(mainFig,'Tag','FOFBguiTangoisRFRunnning'),'BackGroundColor', [1 1 1]);
            end

            if isxFOFBRunning
                set(findobj(mainFig,'Tag','FOFBguiTangoisxFOFBRunning'),'BackGroundColor', [0 1 0]);
            else
                set(findobj(mainFig,'Tag','FOFBguiTangoisxFOFBRunning'),'BackGroundColor', [1 1 1]);
            end

            if iszFOFBRunning
                set(findobj(mainFig,'Tag','FOFBguiTangoiszFOFBRunning'),'BackGroundColor', [0 1 0]);
            else
                set(findobj(mainFig,'Tag','FOFBguiTangoiszFOFBRunning'),'BackGroundColor', [1 1 1]);
            end

            if isDCFBRunning
                set(findobj(mainFig,'Tag','FOFBguiTangoisDCFBRunning'),'BackGroundColor', [0 1 0]);
            else
                set(findobj(mainFig,'Tag','FOFBguiTangoisDCFBRunning'),'BackGroundColor', [1 1 1]);
            end

            if isSOFBRunning
                set(findobj(mainFig,'Tag','FOFBguiTangoisSOFBRunning'),'BackGroundColor', [0 1 0]);
            else
                set(findobj(mainFig,'Tag','FOFBguiTangoisSOFBRunning'),'BackGroundColor', [1 1 1]);
            end
            if SynchStatus
                set(findobj(mainFig,'Tag','FOFBguiTangoOpenSynchInterface'),'BackGroundColor', [0 1 0],'String','BPMs synchronized');
            else
                set(findobj(mainFig,'Tag','FOFBguiTangoOpenSynchInterface'),'BackGroundColor', [1 0 0],'String','BPMs not synchronized! Click here!');
            end
 

            % Update time on status
            set(findobj(mainFig,'Tag','FOFBguiTangoStaticTextHeader'),'String', datestr(clock));

        catch
            fprintf('\n  %s \n',lasterr);
            fprintf('Error in UpdateStatusFOFB\n') ;
        end

        %%  OpenSynchInterface       
    case 'OpenSynchInterface'
        try
           system('pytango /home/production/scripts/DG/python/bin/com_libera.py &');
           SynchStatus=CheckFOFBSynch;
           if isempty(gcbf)
                %mainFig = gcf;
                mainFig = findobj(allchild(0),'tag','FOFBguiTangoFig1');
           else
                mainFig = gcbf;
            end
            
            if SynchStatus
                set(findobj(mainFig,'Tag','FOFBguiTangoOpenSynchInterface'),'BackGroundColor', [0 1 0],'String','BPMs synchronized');
            else
                set(findobj(mainFig,'Tag','FOFBguiTangoOpenSynchInterface'),'BackGroundColor', [1 0 0],'String','BPMs not synchronized! Click here!');
            end
           
               
        catch
            fprintf('\n  %s \n',lasterr);
            fprintf('Error in OpenSynchInterface\n') ;
        end
        
%% OrbitCorrectionSetupFOFB       
    case 'OrbitCorrectionSetupFOFB'
        % NOTES setting for FOFB and manual orbit correction are often
        % different

        InitFlag = Input2;  % Input #2: if InitFlag, then initialize variables

        if InitFlag % just at startup

            % Setup orbit correction elements : DEFAULT configuration
            %disp('Orbit correction condition: InitFlag=1 -- debugging message');

            % Get list of BPMs et corrector magnets
            [HCMlist VCMlist BPMlist] = getlocallist;
            
            % Read configuration of FOFB from file having R-matrix for FPGA
            try
                data = load([getfamilydata('Directory' , 'OpsData') fileName]);
            catch exception
                data = load(fullfile(getfamilydata('Directory', 'FOFBdata'), 'GoldenMatrix4FPGADefault.mat'));
                warndlg('Generate Matrix for FPGA, Wrong default values loaded');
            end

            % Look for removed BPM
            idx = find(sum(abs(data.matrixX)) == 0);
            
            % becarefull does not work if missing BPM in BPMlist           
            BPMlist(idx,:) = [];

            % Look for removed HFCOR
            idx = find(sum(abs(data.matrixX')) == 0);
            HCMlist(idx,:) = [];
            
            % Look for removed HFCOR
            idz = find(sum(abs(data.matrixZ')) == 0);
            VCMlist(idz,:) = [];

            % LSN
            % SVD orbit correction singular values
            Xivec = 1:50; % 6 octobre 2014 (regularisation)
            Yivec = 1:50; % 6 octobre 2014 (regularisation)
            
            % Old values and valid configuration for Low-alpha
            %Xivec = 1:45; % 40 w/o Orthogonal correction 41 if orthogonal correction
            %Yivec = 1:44;
            
            % Gain correction values
            %Xgain = 150 ; % 30 aout 2016 (pb excitation Fsynchrotron)
            Xgain = 200 ; % 6 octobre 2014 (regularisation)
            Ygain = 170;  % 6 octobre 2014 (regularisation)
            %Xgain = 90 ; % ajusted for 45 vp for H-plane, nominal alpha
            %Ygain = 90;% ajusted for 44 vp for V-plane, nominal alpha
               

            % initialize RFCorrFlag
            %RFCorrFlag = 'No';
            RFCorrFlag = 'Yes';

            % Goal orbit
            Xgoal = getgolden(BPMxFamily, BPMlist, 'numeric');
            Ygoal = getgolden(BPMyFamily, BPMlist, 'numeric');

            % BPM weights
            Xweight = ones(size(BPMlist,1), 1);
            Yweight = ones(size(BPMlist,1), 1);

            % Correctors weights
            HCMweight = ones(size(HCMlist,1), 1);
            VCMweight = ones(size(VCMlist,1), 1);

        else % For orbit correction Configuration
            % Get vector for orbit correction
            FB = get(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata');
            BPMlist = FB.BPMlist;
            HCMlist = FB.HCMlist;
            VCMlist = FB.VCMlist;
            Xivec = FB.Xivec;
            Yivec = FB.Yivec;
            Xgain = FB.Xgain;
            Ygain = FB.Ygain;
            Xgoal = FB.Xgoal;
            Ygoal = FB.Ygoal;
            RFCorrFlag = FB.RFCorrFlag;

            HCMweight = FB.OCSx.CMWeight;
            VCMweight = FB.OCSy.CMWeight;
            Xweight = FB.OCSx.BPMWeight;
            Yweight = FB.OCSy.BPMWeight;

            % Add button to change #ivectors, CMs, IDBPMs,
            EditFlag = 0;
            h_fig1 = figure;

            while EditFlag ~= 11

                % get Sensitivity matrices
                Sh = getrespmat(BPMxFamily, BPMlist, HCMFamily, HCMlist, [], SR_GEV);
                Sv = getrespmat(BPMyFamily, BPMlist, VCMFamily, VCMlist, [], SR_GEV);
                % Computes SVD to get singular values
                [Ux, SVx, Vx] = svd(Sh);
                [Uy, SVy, Vy] = svd(Sv);

                % Remove singular values greater than the actual number of singular values
                i = find(Xivec>length(diag(SVx)));
                if ~isempty(i)
                    disp('   Horizontal singular value vector scaled since there were more elements in the vector than singular values.');
                    pause(0);
                    Xivec(i) = [];
                end
                i = find(Yivec>length(diag(SVy)));
                if ~isempty(i)
                    disp('   Vertical singular value vector scaled since there were more elements in the vector than singular values.');
                    pause(0);
                    Yivec(i) = [];
                end

                % Display singular value plot for both planes

                figure(h_fig1);

                subplot(2,1,1);
                semilogy(diag(SVx),'b');
                hold on;
                semilogy(diag(SVx(Xivec,Xivec)),'xr');
                ylabel('Horizontal');
                title('Response Matrix Singular Values');
                hold off; grid on;

                subplot(2,1,2);
                semilogy(diag(SVy),'b');
                hold on;
                semilogy(diag(SVy(Yivec,Yivec)),'xr');
                xlabel('Singular Value Number');
                ylabel('Vertical');
                hold off; grid on;
                drawnow;

                % End of display

                if strcmpi(RFCorrFlag,'No')
                    RFCorrState = 'NOT CORRECTED';
                elseif strcmp(RFCorrFlag,'Yes')
                    RFCorrState = 'CORRECTED';
                else
                    RFCorrState = '???';
                end

                EditFlag = menu('Change Parameters?','Singular Values',  ...
                    'Horizontal corrector magnet list', 'Horizontal corrector magnet weights', ...
                    'Vertical corrector magnet list', 'Vertical corrector magnet weights',  ...
                    'BPM list', 'BPM weights','Correction Gain', 'Golden Orbit value',...
                    sprintf('RF Frequency (currently %s)',RFCorrState),'Return');

                % Edition switchyard for orbit correction
                switch EditFlag
                    case 1 % Singular value edition

                        % Build up matlab prompt
                        prompt = {'Enter the horizontal singular value vector (Matlab vector format):', ...
                            'Enter the vertical singular value vector (Matlab vector format):'};
                        % default values
                        def = {sprintf('[%d:%d]',1,Xivec(end)),sprintf('[%d:%d]',1,Yivec(end))};
                        titlestr = 'SVD Orbit Correction';
                        lineNo = 1;

                        answer = inputdlg(prompt,titlestr,lineNo,def);

                        % Answer parsing
                        if ~isempty(answer)
                            % Horizontal plane
                            XivecNew = fix(str2num(answer{1}));
                            if isempty(XivecNew)
                                disp('   Horizontal singular value number cannot be empty.  No change made.');
                            else
                                if any(XivecNew<=0) || max(XivecNew)>length(diag(SVx))
                                    disp('   Error reading horizontal singular value vector  No change made.');
                                else
                                    Xivec = XivecNew;
                                end
                            end
                            % Vertical plane
                            YivecNew = fix(str2num(answer{2}));
                            if isempty(YivecNew)
                                disp('   Vertical singular value vector cannot be empty.  No change made.');
                            else
                                if any(YivecNew<=0) || max(YivecNew)>length(diag(SVy))
                                    disp('   Error reading vertical singular value vector.  No change made.');
                                else
                                    Yivec = YivecNew;
                                end
                            end
                        end

                    case 2 % Horizontal corrector list edition
                        List = getlist(HCMFamily);
                        ListOld = HCMlist;
                        CheckList = zeros(size(List,1));
                        Elem = dev2elem(HCMFamily, HCMlist);
                        CheckList(Elem) = ones(size(Elem));
                        CheckList = CheckList(dev2elem(HCMFamily,List));
                        newList = editlist(List, HCMFamily, CheckList);

                        if isempty(newList)
                            fprintf('   Horizontal corrector magnet list cannot be empty.  No change made.\n');
                        else
                            HCMlist = newList;
                        end

                        %set correctors weight values
                        HCMweightOld = HCMweight;
                        HCMweight = ones(size(HCMlist,1), 1);

                        %if a new corrector is added, then set the weight values to
                        %one.
                        % Otherwise keep the present weight values
                        for i = 1:size(HCMlist,1)

                            % Is it a new corrector?
                            k = find(HCMlist(i,1)==ListOld(:,1));
                            l = find(HCMlist(i,2)==ListOld(k,2));

                            if isempty(k) || isempty(l)
                                % New corrector
                            else
                                % Use the old value for old correctors
                                HCMweight(i) = HCMweightOld(k(l));
                            end
                        end

                    case 3 % Horizontal corrector weight edition

                        % Ask user to select HCM for modifying weight
                        ChangeList = editlist(HCMlist, 'Change HCM', ...
                            zeros(size(HCMlist,1),1));

                        % Ask the new weight for each selected corrector
                        for i = 1:size(ChangeList,1)

                            k = find(ChangeList(i,1) == HCMlist(:,1));
                            l = find(ChangeList(i,2) == HCMlist(k,2));

                            prompt = {sprintf('Enter the new weight for HCM(%d,%d):', ...
                                HCMlist(k(l),1), HCMlist(k(l),2))};
                            def = {sprintf('%f',HCMweight(k(l))),sprintf('%f',HCMweight(k(l)))};
                            titlestr = 'CHANGE THE HCM WEIGHTS';
                            lineNo = 1;
                            answer = inputdlg(prompt, titlestr, lineNo, def);

                            if isempty(answer)
                                % No change
                                fprintf('   No change was made to the VCM weight.\n');
                            else
                                HCMweightnew = str2num(answer{1});
                                if isempty(HCMweightnew)
                                    fprintf('   No change was made to the horizontal BPM weight.\n');
                                else
                                    HCMweight(k(l)) = HCMweightnew;
                                end
                            end
                        end

                        if ~isempty(ChangeList)
                            fprintf('   Note:  changing the HCM weight for "Orbit Correction" does not change the goal orbit for "Slow Orbit FeedbackFOFB."\n');
                        end

                    case 4 % Vertical corrector list edition
                        List = getlist(VCMFamily);
                        CheckList = zeros(size(List,1));
                        ListOld = VCMlist;
                        Elem = dev2elem(VCMFamily, VCMlist);
                        CheckList(Elem) = ones(size(Elem));
                        CheckList = CheckList(dev2elem(VCMFamily,List));
                        newList = editlist(List, VCMFamily, CheckList);
                        if isempty(newList)
                            fprintf('   Vertical corrector magnet cannot be empty.  No change made.\n');
                        else
                            VCMlist = newList;
                        end

                        %set correctors weight values
                        VCMweightOld = VCMweight;
                        VCMweight = ones(size(VCMlist,1), 1);

                        %if a new corrector is added, then set the weight values to
                        %one.
                        % Otherwise keep the present weight values
                        for i = 1:size(VCMlist,1)

                            % Is it a new corrector?
                            k = find(VCMlist(i,1)==ListOld(:,1));
                            l = find(VCMlist(i,2)==ListOld(k,2));

                            if isempty(k) || isempty(l)
                                % New corrector
                            else
                                % Use the old value for old correctors                              
                                VCMweight(i) = VCMweightOld(k(l));
                            end
                        end
                    case 5 % Vertical corrector weight edition
                        % Ask user to select VCM for modifying weight
                        ChangeList = editlist(VCMlist, 'Change VCM', ...
                            zeros(size(VCMlist,1),1));

                        % Ask the new weight for each selected corrector
                        for i = 1:size(ChangeList,1)

                            k = find(ChangeList(i,1) == VCMlist(:,1));
                            l = find(ChangeList(i,2) == VCMlist(k,2));

                            prompt = {sprintf('Enter the new weight for VCM(%d,%d):', ...
                                VCMlist(k(l),1), VCMlist(k(l),2))};
                            def = {sprintf('%f',VCMweight(k(l))),sprintf('%f',VCMweight(k(l)))};
                            titlestr = 'CHANGE THE VCM WEIGHTS';
                            lineNo = 1;
                            answer = inputdlg(prompt, titlestr, lineNo, def);

                            if isempty(answer)
                                % No change
                                fprintf('   No change was made to the VCM weight.\n');
                            else
                                VCMweightnew = str2num(answer{1});
                                if isempty(VCMweightnew)
                                    fprintf('   No change was made to the horizontal BPM weight.\n');
                                else
                                    VCMweight(k(l)) = VCMweightnew;
                                end
                            end
                        end

                        if ~isempty(ChangeList)
                            fprintf('   Note:  changing the VCM weight for "Orbit Correction" does not change the goal orbit for "Slow Orbit FeedbackFOFB."\n');
                        end

                    case 6 % BPM list edition
                        % Backup element before edition
                        ListOld = BPMlist;
                        XgoalOld = Xgoal;
                        YgoalOld = Ygoal;
                        XweightOld = Xweight;
                        YweightOld = Yweight;

                        % Get full BPM list
                        List = family2dev(BPMxFamily);

                        % Check BPM already in the list CheckList(i) = 1
                        %       BPM not in the list CheckList(i) = 0
                        CheckList = zeros(size(List,1),1);
                        if ~isempty(BPMlist)
                            for i = 1:size(List,1)
                                k = find(List(i,1) == BPMlist(:,1));
                                l = find(List(i,2) == BPMlist(k,2));
                                if isempty(k) || isempty(l)
                                    % Item not in list
                                else
                                    CheckList(i) = 1;
                                end
                            end
                        end

                        % User edition of the BPM list
                        newList = editlist(List, 'BPM', CheckList);
                        if isempty(newList)
                            fprintf('   BPM list cannot be empty.  No change made.\n');
                        else
                            BPMlist = newList;
                        end

                        % Set the goal orbit to the golden orbit
                        Xgoal = getgolden(BPMxFamily, BPMlist);
                        Ygoal = getgolden(BPMyFamily, BPMlist);
                        Xweight = ones(size(BPMlist,1),1);
                        Yweight = ones(size(BPMlist,1),1);

                        % If a new BPM is added, then set the goal orbit to the golden orbit
                        % For other BPMs, present goal orbit is kept
                        for i = 1:size(BPMlist,1)

                            % Is it a new BPM?
                            k = find(BPMlist(i,1) == ListOld(:,1));
                            l = find(BPMlist(i,2) == ListOld(k,2));

                            if isempty(k) || isempty(l)
                                % New BPM
                            else
                                % Use the old value for old BPM
                                Xgoal(i) = XgoalOld(k(l));
                                Ygoal(i) = YgoalOld(k(l));
                                Xweight(i) = XweightOld(k(l));
                                Yweight(i) = YweightOld(k(l));
                            end
                        end

                    case 7 % BPM weight edition
                        % Ask user to select BPM for modifying weight
                        ChangeList = editlist(BPMlist, 'Change BPM', ...
                            zeros(size(BPMlist,1),1));

                        % Ask the new weight for each selected BPM
                        for i = 1:size(ChangeList,1)

                            k = find(ChangeList(i,1) == BPMlist(:,1));
                            l = find(ChangeList(i,2) == BPMlist(k,2));

                            prompt = {sprintf('Enter the new weight for BPMx(%d,%d):', ...
                                BPMlist(k(l),1), BPMlist(k(l),2)), ...
                                sprintf('Enter the new weight for BPMz(%d,%d):', ...
                                BPMlist(k(l),1),BPMlist(k(l),2))};
                            def = {sprintf('%f',Xweight(k(l))),sprintf('%f',Yweight(k(l)))};
                            titlestr = 'CHANGE THE BPM WEIGHTS';
                            lineNo = 1;
                            answer = inputdlg(prompt, titlestr, lineNo, def);

                            if isempty(answer)
                                % No change
                                fprintf('   No change was made to the BPM weight.\n');
                            else
                                Xweightnew = str2num(answer{1});
                                if isempty(Xweightnew)
                                    fprintf('   No change was made to the horizontal BPM weight.\n');
                                else
                                    Xweight(k(l)) = Xweightnew;
                                end

                                Yweightnew = str2num(answer{2});
                                if isempty(Yweightnew)
                                    fprintf('   No change was made to the vertical BPM weight.\n');
                                else
                                    Yweight(k(l)) = Yweightnew;
                                end
                            end
                        end

                        if ~isempty(ChangeList)
                            fprintf('   Note:  changing the BPM weight for "Orbit Correction" does not change the goal orbit for "Slow Orbit FeedbackFOFB."\n');
                        end

                    case 8 % Correction Gain edition

                        % Build up matlab prompt
                        prompt = {'Enter the horizontal loop gain value :', ...
                            'Enter the vertical loop gain value :'};
                        % default values
                        def = {sprintf('%d',Xgain),sprintf('%d',Ygain)};
                        titlestr = 'Change loop gain value';
                        lineNo = 1;

                        answer = inputdlg(prompt,titlestr,lineNo,def);

                        % Answer parsing
                        if ~isempty(answer)
                            % Horizontal plane
                            XgainNew = fix(str2num(answer{1}));
                            if isempty(XgainNew)
                                disp('   Horizontal gain value cannot be empty.  No change made.');
                            else
                                if (XgainNew<=0)
                                    disp('   Error reading horizontal gain value. No change made.');
                                else
                                    Xgain = XgainNew;
                                    % Display new value on main pannel
                                    set(findobj(gcbf,'Tag','FOFBguiTangoXgain'),'string',['H-Loop-Gain = ',num2str(Xgain)]);
                                 end
                            end
                            % Vertical plane
                            YgainNew = fix(str2num(answer{2}));
                            if isempty(YgainNew)
                                disp('   Vertical gain value cannot be empty.  No change made.');
                            else
                                if (YgainNew<=0) 
                                    disp('   Error reading vertical gain value.  No change made.');
                                else
                                    Ygain = YgainNew;
                                    % Display new value on main pannel
                                    set(findobj(gcbf,'Tag','FOFBguiTangoYgain'),'string',['V-Loop-Gain = ',num2str(Ygain)]);
                                end
                            end
                        end
                        
                    case 9 % Golden orbit manual edition

                        % Ask user to select BPM for modifying golden orbit
                        ChangeList = editlist(BPMlist, 'Change BPM', ...
                            zeros(size(BPMlist,1),1));

                        % Ask the new golden orbit for each selected BPM
                        for i = 1:size(ChangeList,1)

                            k = find(ChangeList(i,1) == BPMlist(:,1));
                            l = find(ChangeList(i,2) == BPMlist(k,2));

                            prompt = {sprintf('Enter the new horizontal goal orbit for BPMx(%d,%d):', ...
                                BPMlist(k(l),1), BPMlist(k(l),2)), ...
                                sprintf('Enter the new vertical goal orbit for BPMz(%d,%d):', ...
                                BPMlist(k(l),1),BPMlist(k(l),2))};
                            def = {sprintf('%f',Xgoal(k(l))),sprintf('%f',Ygoal(k(l)))};
                            titlestr = 'CHANGE THE GOAL ORBIT';
                            lineNo = 1;
                            answer = inputdlg(prompt, titlestr, lineNo, def);

                            if isempty(answer)
                                % No change
                                fprintf('   No change was made to the golden orbit.\n');
                            else
                                Xgoalnew = str2num(answer{1});
                                if isempty(Xgoalnew)
                                    fprintf('   No change was made to the horizontal golden orbit.\n');
                                else
                                    Xgoal(k(l)) = Xgoalnew;
                                end

                                Ygoalnew = str2num(answer{2});
                                if isempty(Ygoalnew)
                                    fprintf('   No change was made to the vertical golden orbit.\n');
                                else
                                    Ygoal(k(l)) = Ygoalnew;
                                end
                            end
                        end

                        if ~isempty(ChangeList)
                            fprintf('   Note:  changing the goal orbit for "Orbit Correction" does not change the goal orbit for "Slow Orbit Feedback."\n');
                            fprintf('          Re-running soleilinit will restart the goal orbit to the golden orbit."\n');
                        end

                    case 10 % RF flag edition
                        RFCorrFlag = questdlg(sprintf('Include RF Frequency in magnet correction?'),'RF Frequency','Yes','No', 'Yes');
                        if strcmp(RFCorrFlag,'No')
                            disp('   RF Frequency will not be included in global orbit correction.');
                        elseif strcmp(RFCorrFlag,'Yes')
                            disp('   RF Frequency will be included in global orbit correction.');
                        end
                        FB.RFCorrFlag = RFCorrFlag;
                end
            end
            close(h_fig1);
        end
        % END of switchyard for orbit correction edition

        % This part is common for case 'orbit correction edition'

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Build up Orbit correction Structures   %
        %  for setorbit programme : OCSx and OCSy%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %  ORBIT CORRECTION STRUCTURE (OCS)
        %    OCS.BPM (data structure)
        %    OCS.CM  (data structure)
        %    OCS.GoalOrbit
        %    OCS.NIter
        %    OCS.SVDIndex
        %    OCS.IncrementalFlag = 'Yes'/'No'
        %    OCS.BPMWeight
        %    OCS.Flags = { 'FitRF' , etc.  }

        % Horizontal plane
        OCSx.BPM = getx(BPMlist, 'struct');
        OCSx.GoalOrbit = Xgoal;
        OCSx.CM  = getam(HCMFamily, HCMlist, 'struct','Model');
        OCSx.NIter = 1; % Number of iteration
        OCSx.SVDIndex = Xivec; % number of eigenvectors for correction
        OCSx.IncrementalFlag = 'No';
        if strcmp(RFCorrFlag,'Yes')
            OCSx.FitRF = 1; % take RF as a corrector
        else
            OCSx.FitRF = 0;
        end

        %Default weight for correctores and BPMs
        OCSx.CMWeight  = HCMweight;
        OCSx.BPMWeight = Xweight;

        % Vertical plane
        OCSy.BPM = getz(BPMlist, 'struct');
        OCSy.CM  = getam(VCMFamily, VCMlist, 'struct','Model');
        OCSy.GoalOrbit = Ygoal;
        OCSy.NIter = 1;
        OCSy.SVDIndex = Yivec;
        OCSy.IncrementalFlag = 'No';
        OCSy.FitRF = 0;

        %Default weight for correctors and BPMs
        OCSy.CMWeight  = VCMweight;
        OCSy.BPMWeight = Yweight;

        % Save structures for later orbit correction
        FB.OCSx = OCSx;
        FB.OCSy = OCSy;

        % List of BPM et correctors to be used
        FB.BPMlist = BPMlist;
        FB.HCMlist = HCMlist;
        FB.VCMlist = VCMlist;

        % List of singular values
        FB.Xivec = Xivec;
        FB.Yivec = Yivec;

        % Loop gain values
        FB.Xgain = Xgain;
        FB.Ygain = Ygain;

        % Goal orbit
        FB.Xgoal = OCSx.GoalOrbit;
        FB.Ygoal = OCSy.GoalOrbit;

        % RF corrector flag
        FB.RFCorrFlag = RFCorrFlag;

        FB.SOFBandFOFB = 0;
        % For SOFB GUI, to know which FOFB version is running
   %     FB.FOFBversionWithXBPM=0;
        
        % save FB structure in application
        set(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata',FB);
        
        % save data for SOFB
        savaData2File;
        
        % modif 03/01/2012 pour suppression bouton Generate new Matrix for
        % FPGA
        if ~InitFlag
        FOFBguiTango('ConvertMatrix4FPGA');
        end
%% OrbitCorrectionFOFB
    case 'OrbitCorrectionFOFB' % Manual Orbit Correction

        try
            check4feedbackflag(devLockName);
            %setup average data for reading BPMs
            setfamilydata('gethbpmaverage','BPMx','Monitor', 'SpecialFunctionGet')
            setfamilydata('getvbpmaverage','BPMz','Monitor', 'SpecialFunctionGet')

        catch
            fprintf('\n  %s \n',lasterr);
            fprintf('   %s \n', datestr(clock));
            disp('   ********************************');
            disp('   **  Orbit Correction Aborted  **');
            disp('   ********************************');
            fprintf('\n');
            return
        end

        OrbitLoopIter = 3; % a 3 step iteration

        fprintf('\n');
        fprintf('   *********************************\n');
        fprintf('   **  Starting Orbit Correction  **\n');
        fprintf('   *********************************\n');
        fprintf('   %s \n', datestr(clock));

        StartFlag = questdlg(sprintf('Start orbit correction ?'),'Orbit Correction','Yes','No','No');
        if strcmp(StartFlag,'No')
            disp('   ********************************');
            disp('   **  Orbit Correction Aborted  **');
            disp('   ********************************');
            fprintf('\n');
            return
        end

        if getdcct < DCCTMIN    % Don't correct the orbit if the current is too small
            fprintf('   Orbit not corrected due to small current.\n');
            return
        end

        % get Structure for correction
        FB = get(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata');

        fprintf('   Starting horizontal and vertical global orbit correction (SVD method).\n');

        % Number of steerer magnet correctors
        N_HCM = size(FB.HCMlist,1);
        N_VCM = size(FB.VCMlist,1);


        for iloop = 1:OrbitLoopIter,
            try
                %%%%%%%%%%%%%%%%%
                % use the following to get corrector settings in OCS and
                % check everything seems Ok and gives back predicted correction
                %% V-plane checks
                if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHcorrection'),'Value') == 1
                    HOrbitCorrectionFlag = 1;
                    %FB.OCSx = setorbit(FB.OCSx,'Nodisplay','Nosetsp');
                    FB.OCSx = setorbit(FB.OCSx,'Nodisplay','Nosetsp','FitRFHCM0');

                    HCMSP = getAM(HCMFamily, FB.HCMlist);  % present corrector values
                    HCMSP_next = HCMSP + FB.OCSx.CM.Delta(1:N_HCM);       % next corrector values, just slow correctors (no RF)

                    MaxSP = maxsp(HCMFamily,FB.HCMlist);
                    MinSP = minsp(HCMFamily,FB.HCMlist);

                    if any(MaxSP - HCMSP_next  < 0)
                        HCMnum = find(HCMSP_next > MaxSP);
                        % message to screen
                        fprintf('**One or more of the horizontal correctors is at its maximum positive value!! Stopping orbit Feedback. \n');
                        fprintf('%s\n',datestr(now));
                        fprintf('**%s is one of the problem correctors.\n', ...
                            cell2mat(family2tango(HCMFamily,'Setpoint',FB.HCMlist(HCMnum(1),:))));
                        HOrbitCorrectionFlag = 0;
                    end

                    if any(MinSP - HCMSP_next  > 0)
                        HCMnum = find(HCMSP_next < MinSP);
                        % message to screen
                        fprintf('**One or more of the horizontal correctors is at its maximum negative value!! Stopping orbit Feedback. \n');
                        fprintf('%s\n',datestr(now));
                        fprintf('**%s is one of the problem correctors.\n', ...
                            cell2mat(family2tango(HCMFamily,'Setpoint',FB.HCMlist(HCMnum(1),:))));
                        HOrbitCorrectionFlag = 0;
                    end

                    if any(HCMSP_next > MaxSP - 1)
                        HCMnum = find(HCMSP_next > MaxSP - 1);
                        for ik = 1:length(HCMnum)
                            fprintf('**Horizontal correctors %s is above %f! \n', ...
                                cell2mat(family2tango(HCMFamily,'Setpoint',FB.HCMlist(HCMnum(ik),:))), ...
                                MaxSP(HCMnum(ik)) - 1);
                        end
                        fprintf('%s\n',datestr(now));
                        fprintf('**The orbit correction is still working but this problem should be investigated. \n');
                    end

                    if any(HCMSP_next < MinSP + 1)
                        HCMnum = find(HCMSP_next < MinSP + 1);
                        for ik = 1:length(HCMnum)
                            fprintf('**Horizontal correctors %s is below %f! \n', ...
                                cell2mat(family2tango(HCMFamily,'Setpoint',FB.HCMlist(HCMnum(ik),:))), ...
                                MinSP(HCMnum(ik)) + 1);
                        end
                        fprintf('%s\n',datestr(now));
                        fprintf('**The orbit correction is still working but this problem should be investigated. \n');
                    end

                end

                %% V-plane checks
                if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVcorrection'),'Value') ==1
                    FB.OCSy = setorbit(FB.OCSy,'Nodisplay','Nosetsp');
                    VOrbitCorrectionFlag = 1;
                    VCMSP = getAM(VCMFamily,FB.VCMlist); % Get corrector values before correction
                    VCMSP_next = VCMSP + FB.OCSy.CM.Delta(1:N_VCM); % New corrector values to be set in

                    MaxSP = maxsp(VCMFamily,FB.VCMlist);
                    MinSP = minsp(VCMFamily,FB.VCMlist);

                    if any(MaxSP - VCMSP_next  < 0)
                        VCMnum = find(VCMSP_next > MaxSP);
                        % message to screen
                        fprintf('**One or more of the vertical correctors is at its maximum positive value!! Stopping orbit Feedback. \n');
                        fprintf('%s\n',datestr(now));
                        fprintf('**%s is one of the problem correctors.\n', ...
                            cell2mat(family2tango(VCMFamily,'Setpoint',FB.VCMlist(VCMnum(1),:))));
                    end

                    if any(MinSP - VCMSP_next  > 0)
                        VCMnum = find(VCMSP_next < MinSP);
                        % message to screen
                        fprintf('**One or more of the vertical correctors is at its maximum negative value!! Stopping orbit Feedback. \n');
                        fprintf('%s\n',datestr(now));
                        fprintf('**%s is one of the problem correctors.\n', ...
                            cell2mat(family2tango(VCMFamily,'Setpoint',FB.VCMlist(VCMnum(1),:))));
                    end

                    if any(VCMSP_next > MaxSP - 1)
                        VCMnum = find(VCMSP_next > MaxSP - 1);
                        for ik = 1:length(VCMnum)
                            fprintf('**Vertical correctors %s is above %f! \n', ...
                                cell2mat(family2tango(VCMFamily,'Setpoint',FB.VCMlist(VCMnum(ik),:))), ...
                                MaxSP(VCMnum(ik)) - 1);
                        end
                        fprintf('%s\n',datestr(now));
                        fprintf('**The orbit correction is still working but this problem should be investigated. \n');
                    end

                    if any(VCMSP_next < MinSP + 1)
                        VCMnum = find(VCMSP_next < MinSP + 1);
                        for ik = 1:length(VCMnum)
                            fprintf('**Vertical correctors %s is below %f! \n', ...
                                cell2mat(family2tango(VCMFamily,'Setpoint',FB.VCMlist(VCMnum(ik),:))), ...
                                MinSP(VCMnum(ik)) + 1);
                        end
                        fprintf('%s\n',datestr(now));
                        fprintf('**The orbit correction is still working but this problem should be investigated. \n');
                    end
                end

                %%%%%%%%%%%%%%%%%%%%%%


                if (get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHcorrection'),'Value') == 1) && HOrbitCorrectionFlag
                    % Correct horizontal orbit
                    %FB.OCSx = setorbit(FB.OCSx,'NoDisplay');
                    FB.OCSx = setorbit(FB.OCSx,'NoDisplay', 'FitRFHCM0');
                end

                if (get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVcorrection'),'Value') == 1) && VOrbitCorrectionFlag
                    % Correct vertical orbit
                    FB.OCSy = setorbit(FB.OCSy,'NoDisplay');
                end

                % Check for current in machine - stop orbit correction if
                % DCCT < DCCTMIN
                if (getdcct < DCCTMIN)
                    error('**There is less than %d in the machine! Stopping orbit correction.', DCCTMIN);
                end

                % Residual orbit
                Horbit = getx(FB.OCSx.BPM.DeviceList);
                Vorbit = getz(FB.OCSy.BPM.DeviceList);

                x = FB.OCSx.GoalOrbit - Horbit;
                y = FB.OCSy.GoalOrbit - Vorbit;

                fprintf('   %d. Horizontal RMS = %.3f mm (absolute %.3f mm)\n', iloop, std(x), std(Horbit));
                fprintf('   %d.   Vertical RMS = %.3f mm (absolute %.3f mm)\n', iloop, std(y), std(Vorbit));

                pause(0);

            catch
                fprintf('   %s \n',lasterr);
                fprintf('   Orbit correction failed due to error condition!\n  Fix the problem, reload the lattice (refreshthering), and try again.  \n\n');
                return
            end
        end

        fprintf('   %s \n', datestr(clock));
        fprintf('   *********************************\n');
        fprintf('   **  Orbit Correction Complete  **\n');
        fprintf('   *********************************\n\n');

        %setup manager data for reading BPMs
        setfamilydata('gethbpmgroup','BPMx','Monitor', 'SpecialFunctionGet')
        setfamilydata('getvbpmgroup','BPMz','Monitor', 'SpecialFunctionGet')

%% FeedbackSetupFOFB       
    case 'FeedbackSetupFOFB' % Fast orbit Feedback (FOFB)

        InitFlag = Input2;           % Input #2: if InitFlag, then initialize variables

        if InitFlag % Used only at startup
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Edit the following lists to change default configuration of Orbit Correction %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            % WARNING CAN BE DIFFERENT FROM THE ORBIT CORRECTION
            % To start with same correctors and Bpms are used as in manual
            % correction
            % Corrector magnets
            [HCMlist VCMlist BPMlist] = getlocallist;

            % Singular value number
            Xivec = 1:45; % 40 w/o Orthogonal correction 41 if orthogonal correction
            Yivec = 1:44;

            % Get goal orbit for FOFB
            Xgoal = getgolden(BPMxFamily, BPMlist);
            Ygoal = getgolden(BPMyFamily, BPMlist);

            % BPM weights
            Xweight = ones(size(BPMlist,1), 1);
            Yweight = ones(size(BPMlist,1), 1);

            % Correctors weights
            HCMweight = ones(size(HCMlist,1), 1);
            VCMweight = ones(size(VCMlist,1), 1);
            
            
        else % use for FOFB Edition

            % Get FB structure
            FB = get(findobj(gcbf,'Tag','FOFBguiTangoButtonFeedbackSetup'),'Userdata');

            BPMlist = FB.BPMlist;
            HCMlist = FB.HCMlist;
            VCMlist = FB.VCMlist;

            Xivec = FB.Xivec;
            Yivec = FB.Yivec;

            Xgoal = FB.Xgoal;
            Ygoal = FB.Ygoal;

            HCMweight = FB.OCSx.CMWeight;
            VCMweight = FB.OCSy.CMWeight;
            Xweight = FB.OCSx.BPMWeight;
            Yweight = FB.OCSy.BPMWeight;

            % Add button to change #ivectors, cm
            EditFlag = 0;
            h_fig1 = figure;

            while EditFlag ~= 9

                % get Sensitivity matrices
                Sh = getrespmat(BPMxFamily, BPMlist, HCMFamily, HCMlist, [], SR_GEV);
                Sv = getrespmat(BPMyFamily, BPMlist, VCMFamily, VCMlist, [], SR_GEV);

                % Compute SVD
                [Ux, SVx, Vx] = svd(Sh);
                [Uy, SVy, Vy] = svd(Sv);

                % Remove singular values greater than the actual number of singular values
                i = find(Xivec>length(diag(SVx)));
                if ~isempty(i)
                    disp('   Horizontal singular value vector scaled since there were more elements in the vector than singular values.');
                    pause(0);
                    Xivec(i) = [];
                end
                i = find(Yivec>length(diag(SVy)));
                if ~isempty(i)
                    disp('   Vertical singular value vector scaled since there were more elements in the vector than singular values.');
                    pause(0);
                    Yivec(i) = [];
                end

                % Display singular value plot
                figure(h_fig1);
                subplot(2,1,1);
                semilogy(diag(SVx),'b');
                hold on;
                semilogy(diag(SVx(Xivec,Xivec)),'xr');
                ylabel('Horizontal');
                title('Response Matrix Singular Values');
                hold off;
                subplot(2,1,2);
                semilogy(diag(SVy),'b');
                hold on;
                semilogy(diag(SVy(Yivec,Yivec)),'xr');
                xlabel('Singular Value Number');
                ylabel('Vertical');
                hold off;
                drawnow;

                % Build up menu edition
                EditFlag = menu('Change Parameters?','Singular Values','HCM List', 'HCM weight', ...
                    'VCM List', 'VCM weight', ...
                    'BPM List', 'BPM weight', 'Change the Goal Orbit', 'Return');

                % Begin FOFB edition switchyard
                switch EditFlag
                    case 1
                        prompt = {'Enter the horizontal singular value number (Matlab vector format):', ...
                            'Enter the vertical singular value numbers (Matlab vector format):'};
                        def = {sprintf('[%d:%d]',1,Xivec(end)),sprintf('[%d:%d]',1,Yivec(end))};
                        titlestr='SVD Orbit Feedback';
                        lineNo=1;
                        answer=inputdlg(prompt,titlestr,lineNo,def);
                        if ~isempty(answer)
                            XivecNew = fix(str2num(answer{1}));
                            if isempty(XivecNew)
                                disp('   Horizontal singular value vector cannot be empty.  No change made.');
                            else
                                if any(XivecNew<=0) || max(XivecNew)>length(diag(SVx))
                                    disp('   Error reading horizontal singular value vector.  No change made.');
                                else
                                    Xivec = XivecNew;
                                end
                            end
                            YivecNew = fix(str2num(answer{2}));
                            if isempty(YivecNew)
                                disp('   Vertical singular value vector cannot be empty.  No change made.');
                            else
                                if any(YivecNew<=0) || max(YivecNew)>length(diag(SVy))
                                    disp('   Error reading vertical singular value vector.  No change made.');
                                else
                                    Yivec = YivecNew;
                                end
                            end
                        end


                    case 2 % Horizontal corrector list edition
                        List= getlist(HCMFamily);
                        CheckList = zeros(size(List,1));
                        ListOld = HCMlist;
                        Elem = dev2elem(HCMFamily, HCMlist);
                        CheckList(Elem) = ones(size(Elem));
                        CheckList = CheckList(dev2elem(HCMFamily,List));

                        newList = editlist(List, HCMFamily, CheckList);

                        if isempty(newList)
                            fprintf('   Horizontal corrector magnet list cannot be empty.  No change made.\n');
                        else
                            HCMlist = newList;
                        end

                        %set correctors weight values
                        HCMweightOld = HCMweight;
                        HCMweight = ones(size(HCMlist,1), 1);

                        %if a new corrector is added, then set the weight values to
                        %one.
                        % Otherwise keep the present weight values
                        for i = 1:size(HCMlist,1)

                            % Is it a new corrector?
                            k = find(HCMlist(i,1)==ListOld(:,1));
                            l = find(HCMlist(i,2)==ListOld(k,2));

                            if isempty(k) || isempty(l)
                                % New corrector
                            else
                                % Use the old value for old correctors
                                HCMweight(i) = HCMweightOld(k(l));
                            end
                        end
                    case 3 % Horizontal corrector weight edition

                        % Ask user to select HCM for modifying weight
                        ChangeList = editlist(HCMlist, 'Change HCM', ...
                            zeros(size(HCMlist,1),1));

                        % Ask the new weight for each selected corrector
                        for i = 1:size(ChangeList,1)

                            k = find(ChangeList(i,1) == HCMlist(:,1));
                            l = find(ChangeList(i,2) == HCMlist(k,2));

                            prompt = {sprintf('Enter the new weight for HCM(%d,%d):', ...
                                HCMlist(k(l),1), HCMlist(k(l),2))};
                            def = {sprintf('%f',HCMweight(k(l))),sprintf('%f',HCMweight(k(l)))};
                            titlestr = 'CHANGE THE HCM WEIGHTS';
                            lineNo = 1;
                            answer = inputdlg(prompt, titlestr, lineNo, def);

                            if isempty(answer)
                                % No change
                                fprintf('   No change was made to the VCM weight.\n');
                            else
                                HCMweightnew = str2num(answer{1});
                                if isempty(HCMweightnew)
                                    fprintf('   No change was made to the horizontal BPM weight.\n');
                                else
                                    HCMweight(k(l)) = HCMweightnew;
                                end
                            end
                        end

                        if ~isempty(ChangeList)
                            fprintf('   Note:  changing the HCM weight for "Slow Orbit Feedback" does not change the goal orbit for "Orbit Correction."\n');
                        end

                    case 4 % Vertical corrector list edition
                        List = getlist(VCMFamily);
                        CheckList = zeros(size(List,1));
                        ListOld = VCMlist;
                        Elem = dev2elem(VCMFamily, VCMlist);
                        CheckList(Elem) = ones(size(Elem));
                        CheckList = CheckList(dev2elem(VCMFamily,List));

                        newList = editlist(List, VCMFamily, CheckList);

                        if isempty(newList)
                            fprintf('   Vertical corrector magnet cannot be empty.  No change made.\n');
                        else
                            VCMlist = newList;
                        end

                        %set correctors weight values
                        VCMweightOld = VCMweight;
                        VCMweight = ones(size(VCMlist,1), 1);

                        %if a new corrector is added, then set the weight values to
                        %one.
                        % Otherwise keep the present weight values
                        for i = 1:size(VCMlist,1)

                            % Is it a new corrector?
                            k = find(VCMlist(i,1)==ListOld(:,1));
                            l = find(VCMlist(i,2)==ListOld(k,2));

                            if isempty(k) || isempty(l)
                                % New corrector
                            else
                                % Use the old value for old correctors
                                VCMweight(i) = VCMweightOld(k(l));
                            end
                        end

                    case 5 % Vertical corrector weight edition
                        % Ask user to select VCM for modifying weight
                        ChangeList = editlist(VCMlist, 'Change VCM', ...
                            zeros(size(VCMlist,1),1));

                        % Ask the new weight for each selected corrector
                        for i = 1:size(ChangeList,1)

                            k = find(ChangeList(i,1) == VCMlist(:,1));
                            l = find(ChangeList(i,2) == VCMlist(k,2));

                            prompt = {sprintf('Enter the new weight for VCM(%d,%d):', ...
                                VCMlist(k(l),1), VCMlist(k(l),2))};
                            def = {sprintf('%f',VCMweight(k(l))),sprintf('%f',VCMweight(k(l)))};
                            titlestr = 'CHANGE THE VCM WEIGHTS';
                            lineNo = 1;
                            answer = inputdlg(prompt, titlestr, lineNo, def);

                            if isempty(answer)
                                % No change
                                fprintf('   No change was made to the VCM weight.\n');
                            else
                                VCMweightnew = str2num(answer{1});
                                if isempty(VCMweightnew)
                                    fprintf('   No change was made to the horizontal BPM weight.\n');
                                else
                                    VCMweight(k(l)) = VCMweightnew;
                                end
                            end
                        end

                        if ~isempty(ChangeList)
                            fprintf('   Note:  changing the VCM weight for "Slow Orbit Feedback" does not change the goal orbit for "Orbit Correction."\n');
                        end

                    case 6 % BPM List edition
                        % Back present BPM list and goal orbit
                        ListOld = BPMlist;
                        XgoalOld = Xgoal;
                        YgoalOld = Ygoal;
                        XweightOld = Xweight;
                        YweightOld = Yweight;

                        List = family2dev(BPMxFamily);

                        %Check BPM already in the list CheckList(i) = 1
                        %      BPM not in the list CheckList(i) = 0
                        CheckList = zeros(size(List,1),1);
                        if ~isempty(BPMlist)
                            for i = 1:size(List,1)
                                k = find(List(i,1)==BPMlist(:,1));
                                l = find(List(i,2)==BPMlist(k,2));

                                if isempty(k) || isempty(l)
                                    % Item not in list
                                else
                                    CheckList(i) = 1;
                                end
                            end
                        end

                        % User edition of the BPM lsit
                        newList = editlist(List, 'BPM', CheckList);
                        if isempty(newList)
                            fprintf('   BPM list cannot be empty.  No change made.\n');
                        else
                            BPMlist = newList;
                        end

                        % Set the goal orbit to the golden orbit and weight values
                        Xgoal = getgolden(BPMxFamily, BPMlist);
                        Ygoal = getgolden(BPMyFamily, BPMlist);
                        Xweight = ones(size(BPMlist,1),1);
                        Yweight = ones(size(BPMlist,1),1);

                        %if a new BPM is added, then set the goal orbit to
                        %the golden orbit.
                        % Otherwise keep the present goal orbit
                        for i = 1:size(BPMlist,1)

                            % Is it a new BPM?
                            k = find(BPMlist(i,1)==ListOld(:,1));
                            l = find(BPMlist(i,2)==ListOld(k,2));

                            if isempty(k) || isempty(l)
                                % New BPM
                            else
                                % Use the old value for old BPM
                                Xgoal(i) = XgoalOld(k(l));
                                Ygoal(i) = YgoalOld(k(l));
                                Xweight(i) = XweightOld(k(l));
                                Yweight(i) = YweightOld(k(l));
                            end
                        end

                    case 7 % BPM weight edition
                        % Ask user to select BPM for modifying weight
                        ChangeList = editlist(BPMlist, 'Change BPM', ...
                            zeros(size(BPMlist,1),1));

                        % Ask the new weight for each selected BPM
                        for i = 1:size(ChangeList,1)

                            k = find(ChangeList(i,1) == BPMlist(:,1));
                            l = find(ChangeList(i,2) == BPMlist(k,2));

                            prompt = {sprintf('Enter the new weight for BPMx(%d,%d):', ...
                                BPMlist(k(l),1), BPMlist(k(l),2)), ...
                                sprintf('Enter the new weight for BPMz(%d,%d):', ...
                                BPMlist(k(l),1),BPMlist(k(l),2))};
                            def = {sprintf('%f',Xweight(k(l))),sprintf('%f',Yweight(k(l)))};
                            titlestr = 'CHANGE THE BPM WEIGHTS';
                            lineNo = 1;
                            answer = inputdlg(prompt, titlestr, lineNo, def);

                            if isempty(answer)
                                % No change
                                fprintf('   No change was made to the BPM weight.\n');
                            else
                                Xweightnew = str2num(answer{1});
                                if isempty(Xweightnew)
                                    fprintf('   No change was made to the horizontal BPM weight.\n');
                                else
                                    Xweight(k(l)) = Xweightnew;
                                end

                                Yweightnew = str2num(answer{2});
                                if isempty(Yweightnew)
                                    fprintf('   No change was made to the vertical BPM weight.\n');
                                else
                                    Yweight(k(l)) = Yweightnew;
                                end
                            end
                        end

                        if ~isempty(ChangeList)
                            fprintf('   Note:  changing the BPM weight for "Slow Orbit Feedback" does not change the goal orbit for "Orbit Correction."\n');
                        end

                    case 8 % Goal orbit edition
                        ChangeList = editlist(BPMlist, 'Change BPM', zeros(size(BPMlist,1),1));

                        for i = 1:size(ChangeList,1)

                            k = find(ChangeList(i,1)==BPMlist(:,1));
                            l = find(ChangeList(i,2)==BPMlist(k,2));

                            prompt={sprintf('Enter the new horizontal goal orbit for BPMx(%d,%d):', ...
                                BPMlist(k(l),1),BPMlist(k(l),2)), ...
                                sprintf('Enter the new vertical goal orbit for BPMz(%d,%d):', ...
                                BPMlist(k(l),1),BPMlist(k(l),2))};
                            def={sprintf('%f',Xgoal(k(l))),sprintf('%f',Ygoal(k(l)))};
                            titlestr='CHANGE THE GOAL ORBIT';
                            lineNo=1;
                            answer = inputdlg(prompt, titlestr, lineNo, def);

                            if isempty(answer)
                                % No change
                                fprintf('   No change was made to the golden orbit.\n');
                            else
                                Xgoalnew = str2num(answer{1});
                                if isempty(Xgoalnew)
                                    fprintf('   No change was made to the horizontal golden orbit.\n');
                                else
                                    Xgoal(k(l)) = Xgoalnew;
                                end

                                Ygoalnew = str2num(answer{2});
                                if isempty(Ygoalnew)
                                    fprintf('   No change was made to the vertical golden orbit.\n');
                                else
                                    Ygoal(k(l)) = Ygoalnew;
                                end
                            end
                        end
                        if ~isempty(ChangeList)
                            fprintf('   Note:  Changing the goal orbit for "Slow Orbit Feedback" does not change the goal orbit for "Orbit Correction."\n');
                            fprintf('          Re-running srcontrol will restart the goal orbit to the golden orbit."\n');
                        end
                end
            end
            close(h_fig1);
        end

        % End of FOFB edition switchyard

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %         Build up FOFB Structures       %
        %  for setorbit programme : OCSx and OCSy%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %  ORBIT CORRECTION STRUCTURE (OCS)
        %    OCS.BPM (data structure)
        %    OCS.CM  (data structure)
        %    OCS.GoalOrbit
        %    OCS.NIter
        %    OCS.SVDIndex
        %    OCS.IncrementalFlag = 'Yes'/'No'
        %    OCS.BPMWeight
        %    OCS.Flags = { 'FitRF' , etc.  }

        OCSx.BPM = getx(BPMlist, 'struct');
        OCSx.CM =  getam(HCMFamily, HCMlist, 'struct');
        OCSx.GoalOrbit = Xgoal;
        OCSx.NIter = 2;
        OCSx.SVDIndex = Xivec;
        OCSx.IncrementalFlag = 'No';
        OCSx.CMWeight  = HCMweight;
        OCSx.BPMWeight = Xweight;
        OCSx.FitRF = 0;

        OCSy.BPM = getz(BPMlist, 'struct');
        OCSy.CM = getam(VCMFamily, VCMlist, 'struct');
        OCSy.GoalOrbit = Ygoal;
        OCSy.NIter = 2;
        OCSy.SVDIndex = Yivec;
        OCSy.IncrementalFlag = 'No';
        OCSy.CMWeight  = VCMweight;
        OCSy.BPMWeight = Yweight;
        OCSy.FitRF = 0;

        % Save FOFB strucutre
        FB.OCSx = OCSx;
        FB.OCSy = OCSy;

        % BPM and CM list
        FB.BPMlist = BPMlist;
        FB.HCMlist = HCMlist;
        FB.VCMlist = VCMlist;

        % Singular value number
        FB.Xivec = Xivec;
        FB.Yivec = Yivec;

        % Goal orbit list
        FB.Xgoal = Xgoal;
        FB.Ygoal = Ygoal;

        
        
%% STARTRFFOFB
    case 'STARTRFFOFB'

        % RF FeedbackFOFB only
        try
            % First check if current in storage ring
            if getdcct < DCCTMIN     % Don't Feedback if the current is too small
                fprintf('%s  Orbit Feedback not started due to low beam current (<%d mA)\n',datestr(now), DCCTMIN);
                return;
            end
            % read RF

            % read status of RF feedback
            statusValue = readattribute([devRFFBManager '/State']);
            % Test masterclock
            rfvalue = getrf;

            fprintf('\n');
            fprintf('   *******************************\n');
            fprintf('   **  Starting RF Feedback  **\n');
            fprintf('   *******************************\n');
            fprintf('   %s \n', datestr(clock));

        catch
            fprintf('\n  %s \n',lasterr);
            fprintf('   %s \n', datestr(clock));
            fprintf('   *************************************************************\n');
            fprintf('   **  RF Feedback could not start due to error condition  **\n');
            fprintf('   *************************************************************\n\n');
            set(0,'showhiddenhandles','off');
            pause(0);
            return
        end

        % Check whether RF feedback is already running
        isRunning = readattribute([devRFFBManager '/isRunning']);

        if isRunning
            fprintf('\n  %s \n',lasterr);
            fprintf('   %s \n', datestr(clock));
            fprintf('   *************************************************************\n');
            fprintf('   **          RF feedback is already running                            **\n');
            fprintf('   *************************************************************\n\n');
            warndlg(' RF feedback is already running');
            return;
        end

        %% Check if other errors
        if statusValue ~= 0 && statusValue ~= 1 && statusValue ~= 8
            fprintf('\n  %s \n',lasterr);
            fprintf('   %s \n', datestr(clock));
            fprintf('   *************************************************************\n');
            fprintf('   **  RF Feedback could not start due to error condition  **\n');
            fprintf('   *************************************************************\n\n');
            rep = readattribute([devRFFBManager '/Status']);
            fprintf('%s \n', rep{1});
            set(0,'showhiddenhandles','off');
            pause(0);
            return
        end

        % Confirmation dialogbox
        StartFlag = questdlg('Start RF Feedback?', 'RF Feedback','Yes','No','No');
        set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextInformation'),'String','RF Feedback Started');

        if strcmp(StartFlag,'No')
            fprintf('   %s \n', datestr(clock));
            fprintf('   ***************************\n');
            fprintf('   **  RF Feedback Exit  **\n');
            fprintf('   ***************************\n\n');
            pause(0);
            return
        end

        set(0,'showhiddenhandles','on');

        try

            tango_command_inout2(devRFFBManager,'Start');

            %set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextHorizontal'),'String', ...
            %    sprintf('Horizontal RMS = %.4f mm',STDx),'ForegroundColor',[0 0 0]);
            %set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextVertical'),'String', ...
            %    sprintf('Vertical RMS = %.4f mm',STDy),'ForegroundColor',[0 0 0]);

            check4feedbackflag(devLockName);

            % Lock  SOFB service
            %Locktag  = tango_command_inout2(devLockName,'Lock', 'rffb');

            pause(0);
            isRunning = readattribute([devRFFBManager '/isRunning']);

            if ~isRunning
                fprintf('\n  %s \n',lasterr);
                fprintf('   %s \n', datestr(clock));
                fprintf('   *************************************************************\n');
                fprintf('   **          RF feedback no started                         **\n');
                fprintf('   *************************************************************\n\n');
                return;
            end
        catch

            fprintf('\n  %s \n',lasterr);

            fprintf('   %s \n', datestr(clock));
            fprintf('   *************************************************************\n');
            fprintf('   **  Orbit Feedback could not start due to error condition  **\n');
            fprintf('   *************************************************************\n\n');

            set(0,'showhiddenhandles','off');
            pause(0);
            return
        end

        pause(0.5)
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxRF'), 'value',readattribute([devRFFBManager, '/isRunning']));

        % Disable buttons in GUI
        set(0,'showhiddenhandles','on');
        %set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxDCRF'),'Enable','off');
        %set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStartRFFB'),'Enable','off');
        %set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStopRFFB'),'Enable','on');
        set(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrection'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Enable','on');
        set(findobj(gcbf,'Tag','FOFBguiTangoButtonFeedbackSetup'),'Enable','off');
        %set(findobj(gcbf,'Tag','FOFBguiTangoClose'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHSOFB'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVSOFB'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHcorrection'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVcorrection'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxRF'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxSOFB'),'Enable','off')
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxFOFB'),'Enable','off')
        set(findobj(gcbf,'Tag','FOFBguiTangoButtonConvertMatrix4FPGA'),'Enable','off');
        %set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStartDC'),'Enable','off');
        pause(0);
        FOFBguiTango('UpdateStatusFOFB');

%%  STOPRFFOFB      
    case 'STOPRFFOFB'

        isRunning = readattribute([devRFFBManager '/isRunning']);
        if ~isRunning
            fprintf(' Error: RFFB already stopped! \n')
            return;
        end

        button=questdlg('Voulez-vous vraiment arreter le RFFB? ','Attention','Confirmer','Annuler','Annuler');

        switch button
            case'Confirmer'
                statusValue = readattribute([devRFFBManager '/State']);
                if statusValue == 12 || statusValue == 10

                    tango_command_inout2(devRFFBManager,'Stop');

                    pause(0.5);

                    isRunning = readattribute([devRFFBManager '/isRunning']);

                    if isRunning
                        fprintf(' Error impossible to stop  RFFB! \n')
                    end
                else
                    fprintf(' Error, impossible to stop RFFB. Is it running? \n');
                    return;
                end

                pause(0.5)
                set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxRF'), 'value',readattribute([devRFFBManager, '/isRunning']));

                % Disable buttons in GUI
                set(0,'showhiddenhandles','on');
                set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxDCRF'),'Enable','off');
                %set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStartRFFB'),'Enable','on');
                %set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStopRFFB'),'Enable','off');
                set(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrection'),'Enable','on');
                set(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Enable','on');
                set(findobj(gcbf,'Tag','FOFBguiTangoButtonFeedbackSetup'),'Enable','on');
                %set(findobj(gcbf,'Tag','FOFBguiTangoClose'),'Enable','on');
                set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHSOFB'),'Enable','on');
                set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVSOFB'),'Enable','on');
                set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHcorrection'),'Enable','on');
                set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVcorrection'),'Enable','on');
                set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxRF'),'Enable','on');
                set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxSOFB'),'Enable','on')
                set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxFOFB'),'Enable','on')
                set(findobj(gcbf,'Tag','FOFBguiTangoButtonConvertMatrix4FPGA'),'Enable','on');
                set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStartDC'),'Enable','on');

            otherwise
                fprintf('Aborting STOPRFFOFB\n');
        end
        FOFBguiTango('UpdateStatusFOFB');
        
%% ZeroingFHCOR        
    case 'ZeroingFHCOR'

        %check FOFB OFF and RFFB OFF
        isRFRunning = readattribute([devRFFBManager, '/isRunning']);
        isxFOFBRunning = readattribute([devFOFBManager, '/xFofbRunning']);
        iszFOFBRunning = readattribute([devFOFBManager, '/zFofbRunning']);

        if isRFRunning 
            fprintf('RFFB is running stop it first! \n');
            return;
        end
        
        if isxFOFBRunning 
            fprintf('FOFB for H-plane is running. Stop it first! \n');
            return;
        end

        if iszFOFBRunning
            fprintf('FOFB for V-plane is running. Stop it first! \n');
            return;
        end

        isSOFBRunning = readattribute([devLockName, '/sofb']);
        if ~isSOFBRunning
            fprintf('SOFB is not running. Start it first! \n');
            return;
        end

        %everything is OKh
        
        button=questdlg('!!!Attention!!!! Les correcteurs HFCOR vont etre forcés à Zéro par étapes. Voulez-vous continuer? ','Attention','Continuer','Annuler','Annuler');

        switch button
            case 'Continuer'
                hfcm2zero
            otherwise
                fprintf('Zeroing HFCOR aborted\n')
        end

%% ZeroingFVCOR
    case 'ZeroingFVCOR'

        %check FOFB OFF and RFFB OFF
        isRFRunning = readattribute([devRFFBManager, '/isRunning']);
        isxFOFBRunning = readattribute([devFOFBManager, '/xFofbRunning']);
        iszFOFBRunning = readattribute([devFOFBManager, '/zFofbRunning']);

        if isRFRunning 
            fprintf('RFFB is running stop it first! \n');
            return;
        end
        
        if isxFOFBRunning 
            fprintf('FOFB for H-plane is running. Stop it first! \n');
            return;
        end

        if iszFOFBRunning
            fprintf('FOFB for V-plane is running. Stop it first! \n');
            return;
        end

        isSOFBRunning = readattribute([devLockName, '/sofb']);
        if ~isSOFBRunning
            fprintf('SOFB is not running. Start it first! \n');
            return;
        end

        %everything is OKh
        
        button=questdlg('!!!Attention!!!! Les correcteurs FVCOR vont etre forcés à Zéro par étapes. Voulez-vous continuer? ','Attention','Continuer','Annuler','Annuler');

        switch button
            case 'Continuer'
                vfcm2zero
            otherwise
                fprintf('Zeroing HVCOR aborted\n')
        end

%% TOGGLEHPLANEFOFB        
    case 'TOGGLEHPLANEFOFB'
        tango_write_attribute2(devFOFBManager,'applyCmdsToXPlane',uint8(get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHFOFB'),'Value')));

%% TOGGLEVPLANEFOFB        
    case 'TOGGLEVPLANEFOFB'
        tango_write_attribute2(devFOFBManager,'applyCmdsToZPlane',uint8(get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVFOFB'),'Value')));

%% StartFOFBConfig        
    case 'StartFOFBConfig'
        fprintf('%s: StartFOFB (+ config)\n',datestr(now))
        
        if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHFOFB'),'value') || ...
                get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVFOFB'),'value')

         % Check BPM synchronization first
         SynchStatus=CheckFOFBSynch;
           if isempty(gcbf)
                %mainFig = gcf;
                mainFig = findobj(allchild(0),'tag','FOFBguiTangoFig1');
           else
                mainFig = gcbf;
            end
            
            if SynchStatus
                set(findobj(mainFig,'Tag','FOFBguiTangoOpenSynchInterface'),'BackGroundColor', [0 1 0],'String','BPMs synchronized');
            else
                set(findobj(mainFig,'Tag','FOFBguiTangoOpenSynchInterface'),'BackGroundColor', [1 0 0],'String','BPMs not synchronized! Click here!');
                fprintf('BPMs are not synchronized\n BPMs have to be synchronized before starting the FOFB\n Click on red synch status button to open synchornization interface\n FOFB start+config procedure aborted\n')
                return
            end
            
            button=questdlg('!!!Attention!!!! Les correcteurs vont etre forcés à Zéro pendant la phase d initialisation. Voulez-vous continuer? ','Attention','Continuer','Annuler','Annuler');

            switch button
                case 'Continuer'
                    h=waitbar(0,'Initialisation en cours...');

                % Reset Errors
                tango_command_inout2(devFOFBManager,'AcknowledgeError');

                %Stop FOFB2zeros to reset steerers settings and Libera orders
                 tango_command_inout2(devFOFBManager,'StopToZero');
                    if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHFOFB'),'value')
                        %tango_command_inout2(devFOFBManager,'StopStep01StopXFOFBToZero');
                        fprintf('   *************************************************************\n');
                        fprintf('   **          FOFB stopped to zeros in H-plane               **\n');
                        fprintf('   *************************************************************\n\n');
                        fprintf('   %s \n', datestr(clock));

                    end
                    if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVFOFB'),'value')
                        %tango_command_inout2(devFOFBManager,'StopStep02StopZFOFBToZero');
                        fprintf('   *************************************************************\n');
                        fprintf('   **          FOFB stopped to zeros  in V-plane              **\n');
                        fprintf('   *************************************************************\n\n');
                        fprintf('   %s \n', datestr(clock));
                    end
                    
                % Force reading of all BPMs to resfresh TANGO connections (BUg in Matlab)
                FOFBstruct = get(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata');
                getx(FOFBstruct.BPMlist);
                pause(0.5);
             
                GoldenOrbitFlag = 0;
                if GoldenOrbitFlag % correction around FOFB golden orbit
                    A = load([getfamilydata('Directory' , 'OpsData') 'fofb_golden.mat']);
                else % Correction around current orbit
                    %get current orbit as reference
                    % Change all BPM in the loop                    
                    BPMxIdx = findrowindex(FOFBstruct.BPMlist, BPMxfullList);

                    % Get Golden data for BPM with 0 status
                    %A = load([getfamilydata('Directory' , 'OpsData') 'fofb_golden.mat']);
                    % Offsets from FA and SA sources
                    % OffsetSA_FA = load([getfamilydata('Directory' , 'OpsBPMData') 'offsetSA_FA_golden.mat']);
                    %OffsetSA_FA = load('/home/operateur/GrpDiagnostics/matlab/FOFB/GUI/golden/offsetSA_FA_02_fevrier_09.mat');
                    % Update data for Status 1 BPMs
                    % 21 November 2009 Offsets disappeared !!!!
                    %OffsetSA_FA.X_offset = OffsetSA_FA.X_offset*0;
                    %OffsetSA_FA.Z_offset = OffsetSA_FA.Z_offset*0;
                    %A.new_goldenX(BPMxIdx) = (getx(FOFBstruct.BPMlist) - OffsetSA_FA.X_offset(BPMxIdx))*1e6;
                    %A.new_goldenZ(BPMxIdx) = (getz(FOFBstruct.BPMlist) - OffsetSA_FA.Z_offset(BPMxIdx))*1e6;
                    
                    A.new_goldenX = zeros(1,size(family2status('BPMx'),1));
                    A.new_goldenZ = A.new_goldenX;
                    
                    A.new_goldenX(BPMxIdx) = getx(FOFBstruct.BPMlist)*1e6;
                    A.new_goldenZ(BPMxIdx) = getz(FOFBstruct.BPMlist)*1e6;
                    
                    if any(isnan(A.new_goldenX(BPMxIdx))) || any(isnan(A.new_goldenZ(BPMxIdx)))
                        fprintf('Error in StartFOFBConfig: at least one BPM is a NaN\n');
                        fprintf('Error in StartFOFBConfig: Try again Start+Config\n');
                        return;
                    end
                    
                end
                B = load([getfamilydata('Directory' , 'OpsData') fileName]);

                % set FOFB gain
                
                % gain is now edited in edit menu
                gainX = FOFBstruct.Xgain;  
                gainZ = FOFBstruct.Ygain; 
   
                % gain for nominal operation
                %gainX = 90; % ajusted for 45 vp for H-plane 
                %gainZ = 90; % ajusted for 44 vp for V-plane
                
                %test
                %gainX=80; % 41 vp for H-plane
                %gainZ=70; % 40 vp for V-plane
                
                % Low alpha sur 25
                %gainX = 30; % ajusted for 45 vp for H-plane in Low Alpha mode
                %gainZ = 65; % ajusted for 44 vp for V-plane in Low Alpha mode
                
                
                coeff = 1.77*1717.412;
                
                % build response matrix
                B.matrixX = -(B.matrixX.*coeff*gainX);
                B.matrixZ = -(B.matrixZ.*coeff*gainZ);

                % Load configuration FOFBmanager
                % Load orbit
                tango_write_attribute2(devFOFBManager,'xRefOrbit',A.new_goldenX*1e-6);
                tango_write_attribute2(devFOFBManager,'zRefOrbit',A.new_goldenZ*1e-6);

                % Load response matrices
                tango_write_attribute2(devFOFBManager,'xInvRespMatrix',B.matrixX);
                tango_write_attribute2(devFOFBManager,'zInvRespMatrix',B.matrixZ);
                pause(2)

                % Load configuration on FPGA
                tango_command_inout2(devFOFBManager,'StartStep04LoadXRefOrbit');
                tango_command_inout2(devFOFBManager,'StartStep05LoadZRefOrbit');
                tango_command_inout2(devFOFBManager,'StartStep06LoadXInvRespMatrix');
                tango_command_inout2(devFOFBManager,'StartStep07LoadZInvRespMatrix');

                pause(10)

                tango_command_inout2(devFOFBManager,'ColdStart');
                pause(3)
                state_fofb_manager = tango_read_attribute(devFOFBManager,'State');
                if state_fofb_manager.value~=6
                    warndlg('StartFOFBConfig: L ''initialisation n''a pas pu demarrer. Verifier Defauts')
                else
                    i=0;
                    while state_fofb_manager.value == 6
                        state_fofb_manager = tango_read_attribute(devFOFBManager,'State');
                        i=i+1;
                        waitbar(i/50)
                        pause(1)
                    end
                    close(h)
                end
            otherwise
                fprintf('Error in StartFOFBConfig\n');
            end

            FOFBguiTango('UpdateStatusFOFB');
        
        else
            warndlg('Aborting StartFOFBConfig: select a plane first')
        end

%% StartFOFB
    case 'StartFOFB'
      fprintf('%s: StartFOFB (hot start)\n',datestr(now))
      % Check BPM synchronization first
         SynchStatus=CheckFOFBSynch;
           if isempty(gcbf)
                %mainFig = gcf;
                mainFig = findobj(allchild(0),'tag','FOFBguiTangoFig1');
           else
                mainFig = gcbf;
            end
            
            if SynchStatus
                set(findobj(mainFig,'Tag','FOFBguiTangoOpenSynchInterface'),'BackGroundColor', [0 1 0],'String','BPMs synchronized');
            else
                set(findobj(mainFig,'Tag','FOFBguiTangoOpenSynchInterface'),'BackGroundColor', [1 0 0],'String','BPMs not synchronized! Click here!');
                fprintf('BPMs are not synchronized\n BPMs have to be synchronized before starting the FOFB\n Click on red synch status button to open synchornization interface\n FOFB start procedure aborted\n')
                return
            end
    
        % Check if FOFB is well configured
        rep = tango_read_attributes2(devFOFBManager, ...
            {'xInvRespMatrixLoadedOnBpms', 'zInvRespMatrixLoadedOnBpms', ...
            'xInvRespMatrixLoadedOnDevice', 'zInvRespMatrixLoadedOnDevice', ...
            'xRefOrbitLoadedOnBpms', 'zRefOrbitLoadedOnBpms' ...
            'xRefOrbitLoadedOnDevice', 'zRefOrbitLoadedOnDevice'});

        isum = sum([rep.value]);

        if isum ~= size(rep,2)
            warndlg('FOFB not configured anymore. Use START FOFB+Config');
            fprintf('%s: StartFOFB (hot start) aborted: FOFB not configured properly\n',datestr(now))
            return;
        end
        
        % Check if steerer PS are well configured
        % H plane
        if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHFOFB'),'value')
            rep = tango_read_attributes2(devFOFBManager,{'xSpsIsLiberaControlled','xSpsIsOn'});
            if (sum(rep(1).value) == 0)||(sum(rep(2).value) == 0)
                warndlg('steerer power-supplies not configured anymore (switched OFF or not controlled by Liberas). Use START FOFB+Config');
                fprintf('%s: StartFOFB (hot start) aborted: PS not configured properly\n',datestr(now))
                return;
            end
          if (sum(rep(1).value) < size(rep(1).value,2)||(sum(rep(2).value) < size(rep(2).value,2)))
                oldcolor=get(0,'DefaultUicontrolBackgroundColor');
                oldfontsize=get(0,'DefaultUicontrolFontSize');
                set(0,'DefaultUicontrolBackgroundColor','r');
                set(0,'DefaultUicontrolFontSize',14);
                ButtonName = questdlg('At least one steerer power-supplies is not configured properly in H plane (switched OFF or not controlled by Liberas). Check if this is normal first (PS out of feedback). If Yes, you can continue, otherwise cancel and use Start + Config', ...
                                         'WARNING', ...
                                         'Cancel', 'Yes, continue', 'Cancel');
                set(0,'DefaultUicontrolBackgroundColor',oldcolor)
                set(0,'DefaultUicontrolFontSize',oldfontsize)
               switch ButtonName,
                 case 'Cancel',
                  disp('Wrong PS configuration detected (H). Starting FOFB canceled by user');
                  return;
                 case 'Yes, continue',
                  disp('Wrong PS configuration detected (H). Continue starting FOFB')
                  otherwise
                  disp('QuestionBox closed by user (wrong PS configuration detected (H)). Starting FOFB canceled'); 
                  return;
               end % switch     
          end
        end
        % V plane
        if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVFOFB'),'value')
            rep = tango_read_attributes2(devFOFBManager,{'zSpsIsLiberaControlled','zSpsIsOn'});
            if (sum(rep(1).value) == 0)||(sum(rep(2).value) == 0)
                warndlg('steerer power-supplies not configured anymore (switched OFF or not controlled by Liberas). Use START FOFB+Config');
                fprintf('%s: StartFOFB (hot start) aborted: PS not configured properly\n',datestr(now))
            return;
            end
          if (sum(rep(1).value) < size(rep(1).value,2)||(sum(rep(2).value) < size(rep(2).value,2)))% at least one PS not configured
                oldcolor=get(0,'DefaultUicontrolBackgroundColor');
                oldfontsize=get(0,'DefaultUicontrolFontSize');
                set(0,'DefaultUicontrolBackgroundColor','r');
                set(0,'DefaultUicontrolFontSize',14);
                ButtonName = questdlg('At least one steerer power-supplies is not configured properly in V plane (switched OFF or not controlled by Liberas). Check if this is normal first (PS out of feedback). If Yes, you can continue, otherwise cancel and use Start + Config', ...
                                         'WARNING', ...
                                         'Cancel', 'Yes, continue', 'Cancel');
                set(0,'DefaultUicontrolBackgroundColor',oldcolor)
                set(0,'DefaultUicontrolFontSize',oldfontsize)
               switch ButtonName,
                 case 'Cancel',
                  disp('Wrong PS configuration detected (V). Starting FOFB canceled by user');
                  return;
                 case 'Yes, continue',
                  disp('Wrong PS configuration detected(V). Continue starting FOFB')
                  otherwise
                  disp('QuestionBox closed by user (wrong PS configuration detected(V)). Starting FOFB canceled'); 
                  return;
               end % switch                
            end
       end
        
        if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHFOFB'),'value') || ...
                get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVFOFB'),'value')
            button = questdlg('!!!Attention!!!! Le Feedback doit etre initialisé pour effectuer cette commande. Voulez-vous continuer? ', ...
                'Attention','Continuer','Annuler','Annuler');
            switch button
                case'Continuer'
                   %22/05/2017 modification to start on current orbit
                    %instead of last golden orbit
                    
                    % Force reading of all BPMs to resfresh TANGO connections (BUg in Matlab)
                    FOFBstruct = get(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata');
                    getx(FOFBstruct.BPMlist);
                    pause(0.5);
                    
                    GoldenOrbitFlag = 0;%to select current orbit or last golden loaded
                    if GoldenOrbitFlag % correction around FOFB golden orbit
                        %do nothing, last golden loaded in FOFB Manager
                        %will be loaded
                    else % Correction around current orbit
                        %get current orbit as reference
                        % Change all BPM in the loop                    
                        BPMxIdx = findrowindex(FOFBstruct.BPMlist, BPMxfullList);
                        
                        % Hplane
                        if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHFOFB'),'value')
                            A.new_goldenX = zeros(1,size(family2status('BPMx'),1));% initialise with 0                         
                            A.new_goldenX(BPMxIdx) = getx(FOFBstruct.BPMlist)*1e6;   %read current orbit                        
                            if any(isnan(A.new_goldenX(BPMxIdx)))
                                fprintf('Error in StartFOFBConfig: at least one BPM is a NaN\n');
                                fprintf('Error in StartFOFBConfig: Try again Start+Config\n');
                                return;
                            end
                            % Load configuration FOFBmanager
                            % Load orbit
                            tango_write_attribute2(devFOFBManager,'xRefOrbit',A.new_goldenX*1e-6);
                            pause(1)

                            % Load configuration on FPGA
                            tango_command_inout2(devFOFBManager,'StartStep04LoadXRefOrbit');
                        end
                        % Vplane
                        if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVFOFB'),'value')
                            A.new_goldenZ = zeros(1,size(family2status('BPMz'),1));
                            A.new_goldenZ(BPMxIdx) = getz(FOFBstruct.BPMlist)*1e6;
                            if any(isnan(A.new_goldenZ(BPMxIdx)))
                                fprintf('Error in StartFOFBConfig: at least one BPM is a NaN\n');
                                fprintf('Error in StartFOFBConfig: Try again Start+Config\n');
                                return;
                            end
                           % Load configuration FOFBmanager
                            % Load orbit
                           tango_write_attribute2(devFOFBManager,'zRefOrbit',A.new_goldenZ*1e-6);
                            pause(1)

                            % Load configuration on FPGA
                            tango_command_inout2(devFOFBManager,'StartStep05LoadZRefOrbit');
 
                        end
                    end   
                    % end of 22/05/2017 modification
 
                    
                    % Reset Errors
                    tango_command_inout2(devFOFBManager,'AcknowledgeError');
                    pause(0.5);
                    % Start feedback
                    tango_command_inout2(devFOFBManager,'HotStart')
                otherwise
                    warndlg('Aborting StartFOFB');
            end
        else
            warndlg('Aborting RestartFOFB: select a plane first')
        end
        FOFBguiTango('UpdateStatusFOFB');

%% StopFOFB2Zero        
    case 'StopFOFB2Zero'
        fprintf('%s: StopFOFB (to zero)\n',datestr(now))
        if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHFOFB'),'value') || ...
                get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVFOFB'),'value')

            button=questdlg('Voulez-vous vraiment arreter le FOFB en remettant à Zéro les correcteurs? ',...
                'Attention','Confirmer','Annuler','Annuler');
            switch button
                case'Confirmer'
                    %devFOFBManager='ANS/DG/FOFB-MANAGER';
                    tango_command_inout2(devFOFBManager,'StopToZero');
                    if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHFOFB'),'value')
                        %tango_command_inout2(devFOFBManager,'StopStep01StopXFOFBToZero');
                        fprintf('   *************************************************************\n');
                        fprintf('   **          FOFB stopped to zeros in H-plane               **\n');
                        fprintf('   *************************************************************\n\n');
                        fprintf('   %s \n', datestr(clock));

                    end
                    if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVFOFB'),'value')
                        %tango_command_inout2(devFOFBManager,'StopStep02StopZFOFBToZero');
                        fprintf('   *************************************************************\n');
                        fprintf('   **          FOFB stopped to zeros  in V-plane              **\n');
                        fprintf('   *************************************************************\n\n');
                        fprintf('   %s \n', datestr(clock));
                    end

                otherwise
                    fprintf('Aborting StopFOFB2Zero\n');
            end
        else
            warndlg('Aborting StopFOFB2Zero: select a plane first')
        end
        FOFBguiTango('UpdateStatusFOFB');


%% StopFOFB2CurrentValues      
    case 'StopFOFB2CurrentValues'
        fprintf('%s: StopFOFB (to current value)\n',datestr(now))
        if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHFOFB'),'value') || ...
                get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVFOFB'),'value')

            button=questdlg('Voulez-vous vraiment arreter le FOFB sur la valeur courante des correcteurs? ',...
                'Attention','Confirmer','Annuler','Annuler');
            switch button
                case'Confirmer'
                    tango_command_inout2(devFOFBManager,'Stop');
                    if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHFOFB'),'value')
                        fprintf('   *************************************************************\n');
                        fprintf('   **          FOFB stopped to current values in H-plane      **\n');
                        fprintf('   *************************************************************\n\n');
                        fprintf('   %s \n', datestr(clock));
                    end
                    if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVFOFB'),'value')
                        fprintf('   *************************************************************\n');
                        fprintf('   **          FOFB stopped to current values in V-plane      **\n');
                        fprintf('   *************************************************************\n\n');
                        fprintf('   %s \n', datestr(clock));
                    end

                otherwise
                    fprintf('Aborting StopFOFB2CurrentValues\n');
            end
        else
            warndlg('Aborting StopFOFB2CurrentValues: select a plane first')
        end
        FOFBguiTango('UpdateStatusFOFB');

%% ConvertMatrix4FPGA        
    case 'ConvertMatrix4FPGA'

        
        
        % CONVERTMATRIX4FPGA - FPGA requires always 122x50 matrices whatever the numbers of BPM or corrector are

        % get Feedback struture
        FBstruct = get(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata');

        Sh = getrespmat(BPMxFamily, FBstruct.BPMlist, HCMFamily, FBstruct.HCMlist, [], SR_GEV);
        Sv = getrespmat(BPMyFamily, FBstruct.BPMlist, VCMFamily, FBstruct.VCMlist, [], SR_GEV);

        %VP regularisation        
        regularisationFlag=0; %LSN
        regularisationFlag=1;
        
        mux=0.001;
        muz=0.001;
        
        % Flag for RF correction done by fast horizontal steerers
       if strcmp(FBstruct.RFCorrFlag,'No')
            RFIncludedInCORFlag=0;
       else
           RFIncludedInCORFlag=1;
       end
        
        
        % H-plane

        %compute matrix for valid BPM & correctors

        Smat = Sh;

        if ~RFIncludedInCORFlag
            Eta = getdisp(BPMxFamily, FBstruct.BPMlist); % todo: to be stored in application
            RFWeight = 10 * mean(std(Smat)) / std(Eta);
            Smat = [Smat RFWeight*Eta];
        end

        % compute 
        [U, S, V] = svd(Smat, 0);  %'econ');
        S = diag(S);

        %% Number of singular values
        SVDIndex = FBstruct.OCSx.SVDIndex;
             
        if regularisationFlag
%            D = S.^2 ./ (S.^2 + mux);Ne tient pas compte de la valeur
%            courante des VP
            D = S(SVDIndex).^2 ./ (S(SVDIndex).^2 + mux);   
            RinvH = V(:,SVDIndex)*(diag(D)*diag(S(SVDIndex).^(-1)))*U(:,SVDIndex)';
            figure
            semilogy(S,'b','Linewidth',2); hold on
            pureinverse = 1./S(SVDIndex);
            reginverse = D.*pureinverse;
            semilogy(1./reginverse,'r','Linewidth',2);
            legend('no regularisation','with regularisation')
            title('Horizontal plane')
        else  
            RinvH = V(:,SVDIndex)*diag(S(SVDIndex).^(-1))*U(:,SVDIndex)';
        end
         
    
        fprintf('Horizontal singular value number %d\n', SVDIndex(end));

        %deltacm = RinvH*deltaXOrbit';
        %deltacm(end)*RFWeight

        %build matrix for FPGA
        RinvHfull=zeros(nHCM,nBPMx);

        % look for index of valid BPM and correctors
        HCMIdx  = findrowindex(FBstruct.HCMlist, HCMfullList);
        BPMxIdx = findrowindex(FBstruct.OCSx.BPM.DeviceList, BPMxfullList);
        %HCMIdx = [HCMIdx(2:end); HCMIdx(1)];
        %BPMxIdx = [BPMxIdx(2:end); BPMxIdx(1)];

        % Remove RF part: last element of RinvH
        % Put zero where BPM and correctors are not taken into account

        if ~RFIncludedInCORFlag
            RinvHfull(HCMIdx, BPMxIdx) = RinvH(1:end-1,:);
        else
            RinvHfull(HCMIdx, BPMxIdx) = RinvH(:,:);
        end

        % V-plane

        %compute matrix for valid BPMs & correctors
        Smat =  Sv;

        % compute SVD
        [U, S, V] = svd(Smat, 0);  %'econ');
        S = diag(S);

        %% Number of singular values
        SVDIndex = FBstruct.OCSy.SVDIndex;
        
        
        if regularisationFlag
            %D = S.^2 ./ (S.^2 + muz);  Ne tient pas compte de la valeur courant des VP 
            D = S(SVDIndex).^2 ./ (S(SVDIndex).^2 + muz);   
            RinvV = V(:,SVDIndex)*(diag(D)*diag(S(SVDIndex).^(-1)))*U(:,SVDIndex)';
            figure
            semilogy(S,'b','Linewidth',2); hold on
            pureinverse = 1./S(SVDIndex);
            reginverse = D.*pureinverse;
            semilogy(1./reginverse,'r','Linewidth',2);
            legend('no regularisation','with regularisation')
            title('Vertical plane')

        else  
            RinvV = V(:,SVDIndex)*diag(S(SVDIndex).^(-1))*U(:,SVDIndex)';
        end
        
        fprintf('Vertical singular value number %d\n', SVDIndex(end));
        %deltacm = RinvV*deltaXOrbit';

        %build matrix for FPGA
        RinvVfull=zeros(nVCM,nBPMy);

        % look for index of valid BPM and correctors
        VCMIdx = findrowindex(FBstruct.VCMlist, VCMfullList);
        BPMyIdx = findrowindex(FBstruct.OCSy.BPM.DeviceList, BPMyfullList);

        %VCMIdx = [VCMIdx(2:end); VCMIdx(1)];
        %BPMyIdx = [BPMyIdx(2:end); BPMyIdx(1)];

        % Put zero where BPM and correctors are not taken into account
        RinvVfull(VCMIdx, BPMyIdx) = RinvV(:,:);

        fprintf('Matrices computed successfully')

        % save data into a file
        dirName = getfamilydata('Directory' , 'OpsData');
        matrixX = RinvHfull;
        matrixZ = RinvVfull;

        %fileName = 'matrix4FOFB';
        % Confirmation dialogbox
        StartFlag = questdlg('Save new Response matrix for FOFB? To apply your modifications, choose yes and do START+CONFIG at next FOFB start', 'Response matrix generation','Yes','No','No');

        % Diag for Laurent
        if 0
            figure;
            mesh(matrixX)
            title('Horizontal Inverse Response Matrix')

            figure;
            mesh(matrixZ)
            title('Vertical Inverse Response Matrix')
        end

        if strcmp(StartFlag,'No')
            fprintf('   %s \n', datestr(clock));
            fprintf('   ***************************\n');
            fprintf('   **  No Data Saved         **\n');
            fprintf('   ***************************\n\n');
            pause(0);
            return
        end

        save([dirName fileName], 'matrixX','matrixZ');

        fprintf('   %s \n', datestr(clock));
        fprintf('   *************************************************\n');
        fprintf('   **  New Response matrix for FOFB Saved         **\n');
        fprintf('   ***********************************************\n\n');
        
        %% Configuration for BPM of the RF feedback
        FB = get(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata');
        activeBPMs = zeros(1,size(family2dev('BPMx', 0),1));
        activeBPMs(dev2elem('BPMx', FB.BPMlist)) = 1;
        fprintf('Updating list of BPM for RFFB\n');
       
        %button=questdlg('Voulez-vous reconfigurer le FOFB et RFFB? ','Attention','Confirmer','Annuler','Annuler');
        % As RFFB is not used anymore, suppression of dialogbox. BPM list
        % always updated on RFFB dev. To be completly suppressed?
        button='Confirmer';
        switch button
            case'Confirmer'
                try
                    tango_write_attribute2(devRFFBManager,'activeBPM', int32(activeBPMs));
                    fprintf('Updating list of BPM done\n');
                catch
                    fprintf('\n  %s \n',lasterr);
                    fprintf('Error while updating list of BPM for RFFB\n');
                end
            otherwise
                fprintf('Configuration aborted\n')
        end

        % save data for SOFB
        savaData2File;
        

        FOFBMANAGERFLAG = 1;
        if FOFBMANAGERFLAG
            % get BPM list used in FOFB-Manager
            bpmdata  = tango_get_properties2(devFOFBManager, {'BPMList'});

            % Configuration
            % H means H-plane only
            % V means V-plane only
            % B means both planes H and V (nominal config)
            % N means excluded for both planes, only survey on private network
            % O means out of order for both planes

            % update all the list of BPM
            FullBPMDevList = family2dev('BPMx', 0);

            %%WARNING may not work if added BPM
            % Idx = strfind(bpmdata.value, 'ANS-C01/DG/BPM.2')
            for ik = 1:size(FullBPMDevList,1),
                if bpmdata.value{ik}(end) ~= 'O'; % do nothing if out of order
                    if activeBPMs(ik)
                        bpmdata.value{ik}(end) = 'B';
                    else
                        bpmdata.value{ik}(end) = 'N'; % not more diagnostics on Orbit, BPM not used in correction
                        %bpmdata.value{ik}(end) = 'O'; % out of order by expectedbpm has to be changed
                        %ExpectedBpmCnt property has to be modified
                    end
                else
                    fprintf('Config not taken into account BPM(%2d, %2d) out of order\n ', FullBPMDevList(ik,:));
                end
            end

            % set back BPM list used to FOFB-Manager
            tango_put_property2(devFOFBManager, 'BPMList', bpmdata.value);

            % To be activated if out of Order Libera
            % rep = tango_get_properties2(devFOFBManager, {'ExpectedBpmCnt'});
            % val.value{1} = num2str(length(activeBPMs));
            % tango_put_property2(devFOFBManager, 'ExpectedBpmCnt', val.value);

            % get H-corrector list used in FOFB-Manager
            HSteerer  = tango_get_properties2(devFOFBManager, {'HSteererList'});
            
            % Configuration
            % U means Up = OK
            % O means out of order for both planes
            
            for ik = 1:size(HCMfullList,1),
                if ~isempty(findrowindex(HCMfullList(ik,:),HCMfullList(HCMIdx,:)))
                    HSteerer.value{ik}(end) = 'U';
                else
                    HSteerer.value{ik}(end) = 'O'; % not more diagnostics on Orbit, BPM not used in correction
                end
            end

            % set back HCOR list used to FOFB-Manager
            tango_put_property2(devFOFBManager, 'HSteererList', HSteerer.value);

            % get V-corrector list used in FOFB-Manager
            VSteerer  = tango_get_properties2(devFOFBManager, {'VSteererList'});
            
            % Configuration
            % U means Up = OK
            % O means out of order for both planes
            
            for ik = 1:size(VCMfullList,1),
                if ~isempty(findrowindex(VCMfullList(ik,:),VCMfullList(VCMIdx,:)))
                    VSteerer.value{ik}(end) = 'U';
                else
                    VSteerer.value{ik}(end) = 'O'; % not more diagnotics on Orbit, BPM not used in correction
                end
            end

            % set back VCOR list used to FOFB-Manager
            tango_put_property2(devFOFBManager, 'VSteererList', VSteerer.value);

            % init on device to take into account the new property
            tango_command_inout2(devFOFBManager, 'Init');
        end

%% StartDCFB
    case 'StartDCFB' %Retrieve DC part of fast correctors

        FOFBguiTango('UpdateStatusFOFB');
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % H-plane: 1/ only corrector 2/ RF part
        % V-plane
        % Need to know configuration of the SOFB and of the FOFB
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        FBstruct = get(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata');

        Sh = getrespmat(BPMxFamily, FBstruct.BPMlist, HCMFamily, FBstruct.HCMlist, [], SR_GEV);
        Sv = getrespmat(BPMyFamily, FBstruct.BPMlist, VCMFamily, FBstruct.VCMlist, [], SR_GEV);

        Eta = getdisp(BPMxFamily, FBstruct.BPMlist);

        % reconstruct orbit

        % Load current configuration data for FOFB from a file!
        DirName = getfamilydata('Directory', 'FOFBdata');
        tmp = load(fullfile(DirName, 'SOFBconfiguration'), 'FB');
        FB_SOFB = tmp.FB;

        % Precompute matrices

        %%%%%%%%%%%
        % H-plane %
        %%%%%%%%%%%

        %compute matrix for valid BPM & correctors

        Smat = Sh;
        RFWeight = 10 * mean(std(Smat)) / std(Eta);
        Smat = [Smat RFWeight*Eta];

        % compute SVD
        [U, S, V] = svd(Smat, 0);  %'econ');
        S = diag(S);

        % Number of singular values
        SVDIndex = FBstruct.OCSx.SVDIndex;
        RH = U(:,SVDIndex)*diag(S(SVDIndex))*V(:,SVDIndex)';

        % retrieve H-plane response matrix with good BPM and correctors
        %SOFB_RMat = getrespmat(FB_SOFB.OCSx.BPM.FamilyName, FB_SOFB.OCSx.BPM.DeviceList, FB_SOFB.OCSx.CM.FamilyName, FB_SOFB.OCSx.CM.DeviceList, [], SR_GEV);
        %SOFB_Eta = getdisp(FB_SOFB.OCSx.BPM.FamilyName, FB_SOFB.OCSx.BPM.DeviceList);
        % Need to take BPM list from this program, i.e. FOFB.
        % TODO: may  not be OKay
        SOFB_RMat = getrespmat(FB_SOFB.OCSx.BPM.FamilyName, FBstruct.BPMlist, FB_SOFB.OCSx.CM.FamilyName, FB_SOFB.OCSx.CM.DeviceList, [], SR_GEV);
        SOFB_Eta  = getdisp(FB_SOFB.OCSx.BPM.FamilyName, FBstruct.BPMlist);

        Smat = SOFB_RMat;
        RFWeight = 10* mean(std(Smat)) / std(SOFB_Eta); % TODO: global variable
        Smat = [Smat RFWeight*SOFB_Eta];

        % Compute SVD and inverse matrix
        [SOFB_UH, SOFB_SH, SOFB_VH] = svd(Smat, 0);  %'econ');
        SOFB_SH = diag(SOFB_SH);
        SOFB_SVDIndexH = FB_SOFB.OCSx.SVDIndex;
        SOFB_RinvH = SOFB_VH(:,SOFB_SVDIndexH)*diag(SOFB_SH(SOFB_SVDIndexH).^(-1)) * SOFB_UH(:,SOFB_SVDIndexH)';

        %%%%%%%%%%%
        % V-plane %
        %%%%%%%%%%%
        %compute matrix for valid BPM & correctors

        Smat = Sv;

        % compute SVD
        [U, S, V] = svd(Smat, 0);  %'econ');
        S = diag(S);

        % Number of singular values
        SVDIndex = FBstruct.OCSy.SVDIndex;
        RV = U(:,SVDIndex)*diag(S(SVDIndex))*V(:,SVDIndex)';

        % retrieve H-plane response matrix with good BPM and correctors
        % TODO flag saying data changed Then repcompute SVD and so on
        %SOFB_RMat = getrespmat(FB_SOFB.OCSy.BPM.FamilyName, FB_SOFB.OCSy.BPM.DeviceList, FB_SOFB.OCSy.CM.FamilyName, FB_SOFB.OCSy.CM.DeviceList, [], SR_GEV);
        SOFB_RMat = getrespmat(FB_SOFB.OCSy.BPM.FamilyName, FBstruct.BPMlist, FB_SOFB.OCSy.CM.FamilyName, FB_SOFB.OCSy.CM.DeviceList, [], SR_GEV);

        [SOFB_UV, SOFB_SV, SOFB_VV] = svd(SOFB_RMat, 0);  %'econ');
        SOFB_SV = diag(SOFB_SV);
        SOFB_SVDIndexV=FB_SOFB.OCSy.SVDIndex;
        %N_VCM=length(SOFB_SVDIndexV);
        SOFB_RinvV = SOFB_VV(:,SOFB_SVDIndexV)*diag(SOFB_SV(SOFB_SVDIndexV).^(-1))*SOFB_UV(:,SOFB_SVDIndexV)';

        %%%%%%%%%%%%%%%%%%%%%%%%%%
        % ORBIT DC FEEDBACK part %
        %%%%%%%%%%%%%%%%%%%%%%%%%%

        %FBloopIter = 3; % number of iterations for each loop

        DC_FEEDBACK_STOP_FLAG = 0;

        % Warning Flag for stale correctors
        HWarnNum = 0;
        VWarnNum = 0;

        % Feedback loop setup
        LoopDelay = 10.0;    % Period of Feedback loop [seconds], make sure the BPM averaging is correct

        % Percentage of correction to apply at each iteration
        Xgain  = 1.0;
        Ygain  = 1.0;

        % Maximum allowed frequency shift during a single correction
        deltaRFmax = 10e-6; % MHz
        deltaRFmin = 0.3e-6; % MHz ie 0.1 Hz

        % Load lattice set for tune feed forward

        set(0,'showhiddenhandles','on');

        try

            %setup average data for reading BPMs
            setfamilydata('gethbpmaverage','BPMx','Monitor', 'SpecialFunctionGet')
            setfamilydata('getvbpmaverage','BPMz','Monitor', 'SpecialFunctionGet')

            fprintf('\n');
            fprintf('   *******************************\n');
            fprintf('   **  Starting DC Orbit Feedback  **\n');
            fprintf('   *******************************\n');
            fprintf('   %s \n', datestr(clock));
            fprintf('   Note: the Matlab command window will be used to display status information.\n');
            fprintf('         It cannot be used to enter commands during slow orbit DC Feedback.\n');

            % Get FOFB Structure
            %FB = get(findobj(gcbf,'Tag','FOFBguiTangoButtonFeedbackSetup'),'Userdata');
            FB = get(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata');
            if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxDCRF'),'Value') == 1
                FB.OCSx.FitRF = 1;
            else
                FB.OCSx.FitRF = 0;
            end

            % look for already running FOFB
            check4DCfeedbackflag(devLockName);
        catch
            fprintf('\n  %s \n',lasterr);
            fprintf('   %s \n', datestr(clock));
            fprintf('   *************************************************************\n');
            fprintf('   **  Orbit DC Feedback could not start due to error condition  **\n');
            fprintf('   *************************************************************\n\n');
            set(0,'showhiddenhandles','off');
            pause(0);
            return
        end

        % Confirmation dialogbox
        StartFlag = questdlg('Start orbit DC Feedback?', 'Orbit DC Feedback','Yes','No','No');
        set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextInformation'),'String','DC FB Started');

        if strcmp(StartFlag,'No')
            fprintf('   %s \n', datestr(clock));
            fprintf('   ***************************\n');
            fprintf('   **  Orbit DC Feedback Exit  **\n');
            fprintf('   ***************************\n\n');
            pause(0);
            return
        end

        set(0,'showhiddenhandles','on');

        % Display information

        if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHFOFB'),'Value') == 1
            fprintf('   Using %d singular values horizontally.\n', length(FB.Xivec));
        end
        if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVFOFB'),'Value') == 1
            fprintf('   Using %d singular values vertically.\n',   length(FB.Yivec));
        end
        fprintf('   Starting FOFB DC correction every %.1f seconds.\n', LoopDelay);

        try
            % Compute residual closed orbit
            %x = FB.Xgoal - getx(FB.BPMlist);
            %y = FB.Ygoal - getz(FB.BPMlist);

            %STDx = norm(x)/sqrt(length(x));
            %STDy = norm(y)/sqrt(length(y));
            %STDx = std(x);
            %STDy = std(y);

            %set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextHorizontal'),'String', ...
            %    sprintf('Horizontal RMS = %.4f mm',STDx),'ForegroundColor',[0 0 0]);
            %set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextVertical'),'String', ...
            %    sprintf('Vertical RMS = %.4f mm',STDy),'ForegroundColor',[0 0 0]);

            if strcmp(getmode('BPMx'),'Online') && strcmp(getmode('BPMz'),'Online')
                % Lock FOFB FB service
                Locktag  = tango_command_inout2(devLockName,'Lock', 'dcfb');
            end
            pause(0);
        catch

            fprintf('\n  %s \n',lasterr);

            fprintf('   %s \n', datestr(clock));
            fprintf('   *************************************************************\n');
            fprintf('   **  Orbit DC Feedback could not start due to error condition  **\n');
            fprintf('   *************************************************************\n\n');

            set(0,'showhiddenhandles','off');
            pause(0);
            return
        end


        % Disable buttons in GUI
        set(0,'showhiddenhandles','on');
        set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStartDC'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStopDC'),'Enable','on');
        set(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrection'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoButtonFeedbackSetup'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoClose'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHSOFB'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVSOFB'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHcorrection'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVcorrection'),'Enable','off');
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxRF'),'Enable','off');
        set(findobj(gcbf,'TdevSpeakerNameag','FOFBguiTangoCheckboxSOFB'),'Enable','off')
        set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxFOFB'),'Enable','off')
        set(findobj(gcbf,'Tag','FOFBguiTangoButtonConvertMatrix4FPGA'),'Enable','off');
        %set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStart'),'Enable','off');
        pause(0);


        % Initialize Feedback loop
        %StartTime = gettime;
        %StartErrorTime = gettime;

        % Get orbit before FOFB startup
        %Xold = getx(FB.BPMlist);
        %Yold = getz(FB.BPMlist);
        % Stale number
        RF_frequency_stalenum = 0;
        %pause(LoopDelay);

        % Number of steerer magnet corrector
        N_HCM = size(FB_SOFB.OCSx.CM.DeviceList,1);
        N_VCM = size(FB_SOFB.OCSy.CM.DeviceList,1);

        % thresholds for multibunch filling pattern
        dhcmStd = 0.0002;
        dvcmStd = 0.0002;
        
        % Number of RF actuator
        N_RFMO = 1;

        % Maximum current modification in correction for one iteration of  DC feedback
        HDCMAX = 0.1; %A in H-plane
        VDCMAX = 0.1; %A in V-plane

        %%%%%%%%%%%%%%%%%%%%%%%%%%
        % Start DC Feedback loop %
        %%%%%%%%%%%%%%%%%%%%%%%%%%

        setappdata(findobj(gcbf,'Tag','FOFBguiTangoFig1'),'DC_FEEDBACK_STOP_FLAG',0);

        while DC_FEEDBACK_STOP_FLAG == 0 % infinite loop
            try
                t00 = gettime;
                fprintf('Iteration time %s\n',datestr(clock));

                % Check if GUI has been closed
                if isempty(gcbf)
                    DC_FEEDBACK_STOP_FLAG = 1;
                    lasterr('FOFBguiTango GUI DISAPPEARED!');
                    error('FOFBguiTango GUI DISAPPEARED!');
                end

                isxFOFBRunning = readattribute([devFOFBManager, '/xFofbRunning']);
                iszFOFBRunning = readattribute([devFOFBManager, '/zFofbRunning']);
                FOFBManagerState = readattribute([devFOFBManager, '/State']);
                
                %isRunningFOFB = readattribute([devLockName '/fofb']);

                if (get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHDCFB'),'Value') == 1 && ~isxFOFBRunning)  || FOFBManagerState ~= 0
                    DC_FEEDBACK_STOP_FLAG = 1;
                    fprintf('\n %s Arret: Programme FOFB is stopped in H-plane. Restart it first!\n\n', datestr(clock));
                    strgMessage = 'Arret de la compensation des correcteurs. Vairifier FOFB';
                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    break;
                end
                
                if (get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVDCFB'),'Value') == 1 && ~iszFOFBRunning) || FOFBManagerState ~= 0
                    DC_FEEDBACK_STOP_FLAG = 1;
                    fprintf('\n %s Arret: Programme FOFB is stopped in H-plane. Restart it first!\n\n', datestr(clock));
                    strgMessage = 'Arret de la compensation des correcteurs. Vérifier FOFB';
                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    break;
                end

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Horizontal plane DC Feedback %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                % Get orbit and check that the BPMs are different from the last update
                %Xnew = getx(FB.BPMlist);

%                 if any(isnan(Xnew))
%                     DC_FEEDBACK_STOP_FLAG = 1;
%                     fprintf('%s         Orbit DC Feedback stopped due to bad BPMs\n',datestr(now));
%                     BadBPMName = family2tangodev(BPMxFamily, FB.BPMlist(isnan(Xnew),:));
%                     for k=1:size(BadBPMName,1),
%                         fprintf('Bad Horizontal BPM %s\n',BadBPMName{k});
%                     end
%                     tango_command_inout2(devSpeakerName,'DevTalk','Arret de la correction d''orbite : problème BPM');
%                     warndlg('Arret de la correction d''orbite : problème BPM');
%                     break;
%                 end
% 
                if getdcct < DCCTMIN     % Don't Feedback if the current is too small
                    DC_FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         Orbit DC Feedback stopped due to low beam current (<%d mA)\n',datestr(now), DCCTMIN);
                    strgMessage = 'Arret de la correction d''orbite : courant trop bas';
                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    warndlg('Arret de la correction d''orbite : courant trop bas');
                    break;
                end

                %x = FB.Xgoal - Xnew;
                %STDx = std(x);

                if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHDCFB'),'Value') == 1
%                     if any(Xold == Xnew)
%                         N_Stale_Data_Points = find((Xold==Xnew)==1);
%                         for i = N_Stale_Data_Points'
%                             fprintf('   Stale data: BPMx(%2d,%d), Feedback step skipped (%s). \n', ...
%                                 FB.BPMlist(i,1), FB.BPMlist(i,2), datestr(clock));
%                         end
%                     else
                        % Compute horizontal correction
                        %%%%%%%%%%%
                        % H-plane %
                        %%%%%%%%%%%

                        % read current of steerers
                        %hcm = getam(HCMFamily, FBstruct.HCMlist);
                        hcm = getpv(HCMFamily, 'SetpointMean', FBstruct.HCMlist);

                        % Compute Delta orbit
                        hDeltaOrbit = RH*[hcm; 0];

                        SOFB_Dhcm =  SOFB_RinvH*hDeltaOrbit;
                        SOFB_DeltaRF = SOFB_Dhcm(end)*RFWeight;

                        % diagnostics to be put here

                        % Apply correction here

                        X = Xgain.*SOFB_Dhcm;

                        % check for corrector values and next step values, warn or stop FB as necessary
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        HCMSP = getam(FB_SOFB.OCSx.CM.FamilyName, FB_SOFB.OCSx.CM.DeviceList);  % present corrector values
                        HCMSP_next = HCMSP + X(SOFB_SVDIndexH);       % next corrector values, just slow correctors (no RF)

                        MaxSP = maxsp(FB_SOFB.OCSx.CM.FamilyName, FB_SOFB.OCSx.CM.DeviceList);
                        MinSP = minsp(FB_SOFB.OCSx.CM.FamilyName, FB_SOFB.OCSx.CM.DeviceList);

                        if any(MaxSP - HCMSP_next  < 0)
                            HCMnum = find(HCMSP_next > MaxSP);
                            % message to screen
                            fprintf('**One or more of the horizontal correctors is at its maximum positive value!! Stopping orbit Feedback. \n');
                            fprintf('%s\n',datestr(now));
                            fprintf('**%s is one of the problem correctors.\n', ...
                                cell2mat(family2tango(FB_SOFB.OCSx.CM.FamilyName,'Setpoint',FB_SOFB.OCSx.CM.DeviceList(HCMnum(1),:))));
                            strgMessage = 'DC feedback: Problème correcteur horizontal';
                            tango_giveInformationMessage(devSpeakerName,  strgMessage);
                            warndlg('DC feedback: Problème correcteur horizontal');
                            DC_FEEDBACK_STOP_FLAG = 1;
                        end
                        
                        if any(MinSP - HCMSP_next  > 0)
                            HCMnum = find(HCMSP_next < MinSP);
                            % message to screen
                            fprintf('**One or more of the horizontal correctors is at its maximum negative value!! Stopping orbit Feedback. \n');
                            fprintf('%s\n',datestr(now));
                            fprintf('**%s is one of the problem correctors.\n', ...
                                cell2mat(family2tango(FB_SOFB.OCSx.CM.FamilyName,'Setpoint',FB_SOFB.OCSx.CM.DeviceList(HCMnum(1),:))));
                            DC_FEEDBACK_STOP_FLAG = 1;
                            strgMessage = 'Problème de la correction d''orbite';
                            tango_giveInformationMessage(devSpeakerName,  strgMessage);
                            warndlg('DC feedback: Problème correcteur vertical');                    
                        end

                        pause(0);

                        if any(HCMSP_next > MaxSP - 1)
                            HCMnum = find(HCMSP_next > MaxSP - 1);
                            for ik = 1:length(HCMnum)
                                HWarnNum = HWarnNum+1;
                                fprintf('**Horizontal correctors %s is above %f! \n', ...
                                    cell2mat(family2tango(FB_SOFB.OCSx.CM.FamilyName,'Setpoint',FB_SOFB.OCSx.CM.DeviceList(HCMnum(ik),:))), ...
                                    MaxSP(HCMnum(ik)) - 1);
                            end
                            fprintf('%s\n',datestr(now));
                            fprintf('**The orbit DC Feedback is still working but this problem should be investigated. \n');
                            strgMessage = 'Problème de la correction d''orbite';
                            tango_giveInformationMessage(devSpeakerName,  strgMessage);
                        end

                        if any(HCMSP_next < MinSP + 1)
                            HCMnum = find(HCMSP_next < MinSP + 1);
                            for ik = 1:length(HCMnum)
                                HWarnNum = HWarnNum+1;
                                fprintf('**Horizontal correctors %s is below %f! \n', ...
                                    cell2mat(family2tango(FB_SOFB.OCSx.CM.FamilyName,'Setpoint',FB_SOFB.OCSx.CM.DeviceList(HCMnum(ik),:))), ...
                                    MinSP(HCMnum(ik)) + 1);
                            end
                            fprintf('%s\n',datestr(now));
                            fprintf('**The orbit Feedback is still working but this problem should be investigated. \n');
                            strgMessage = 'Problème de la correction d''orbite';
                            tango_giveInformationMessage(devSpeakerName,  strgMessage);
                        end

                        if getdcct < DCCTMIN     % Don't DC Feedback if the current is too small
                            DC_FEEDBACK_STOP_FLAG = 1;
                            fprintf('%s         Orbit DC Feedback stopped due to low beam current (<%d mA)\n',datestr(now), DCCTMIN);
                            strgMessage = 'Arret du DC feedback : courant trop bas';
                            tango_giveInformationMessage(devSpeakerName,  strgMessage);
                            warndlg('Arret du DC feedback : courant trop bas')
                            break;
                        end

                        % Apply new corrector values
                        
                        % check if correction variation are small enough
                        % if not apply just a percentatge of the correction
                        
                        % Maximum current modification in correction for one iteration of  DC feedback                        
                        % scaling off all correctors to get a maximum variation of HDCMAX
                        if max(abs(X(SOFB_SVDIndexH))) > HDCMAX
                            HDCfact = HDCMAX/max(abs(X(SOFB_SVDIndexH)));
                            fprintf('H-plane: valeur max is %f A > %f A', max(abs(X(SOFB_SVDIndexH))), HDCMAX);
                        else
                            HDCfact = 1.0;
                        end

                        if N_HCM > 0 && std(X(1:N_HCM)) > dhcmStd
                            fprintf('H-correction applied RMS HCOR was %f \n', std(X(1:N_HCM)))
                            if strcmp(getmode(HCMFamily),'Online')
                                profibus_sync(FB_SOFB.OCSx.CM.FamilyName); pause(0.2);
                            end
                            stepsp(FB_SOFB.OCSx.CM.FamilyName, HDCfact*X(1:N_HCM), FB_SOFB.OCSx.CM.DeviceList, 0);
                            if strcmp(getmode(HCMFamily),'Online')                            
                                profibus_unsyncall(FB_SOFB.OCSx.CM.FamilyName);
                            end
                        else
                            fprintf('No horizontal correction  applied, std corrector = %5.4f mA rms < threshold = %5.4f \n', ...
                                std(X(1:N_HCM)),dhcmStd);
                        end

                        % Don't DC Feedback if the current is too small, remove iteration
                        if getdcct < DCCTMIN
                            profibus_sync(FB_SOFB.OCSx.CM.FamilyName); pause(0.2);
                            stepsp(FB_SOFB.OCSx.CM.FamilyName, -HDCfact*X(1:N_HCM), FB_SOFB.OCSx.CM.DeviceList, 0);
                            profibus_unsyncall(FB_SOFB.OCSx.CM.FamilyName);
                        end
                        
                        % Apply RF correction

                        if FB.OCSx.FitRF
                            deltaRF = Xgain.*SOFB_DeltaRF;
                            if N_RFMO > 0
                                RFfrequency_last = getrf;
                                fprintf('Computed RF frequency correction is %5.1f Hz \n', hw2physics('RF','Setpoint', deltaRF));

                                if abs(deltaRF) > deltaRFmin % MHz
                                    if abs(deltaRF) < deltaRFmax % For avoiding too large RF step on orbit
                                        steprf(deltaRF);
                                        fprintf('RF change applied by %5.1f Hz\n', ...
                                            hw2physics('RF','Setpoint', deltaRF));
                                    else
                                        warning('RF change too large: %5.1f Hz (max is %5.1f Hz)', ...
                                            hw2physics('RF','Setpoint', deltaRF), hw2physics('RF','Setpoint', deltaRFmax));
                                        steprf(deltaRFmax*sign(deltaRF));
                                        fprintf('RF change applied by %5.1f Hz\n', hw2physics('RF','Setpoint', deltaRFmax*sign(deltaRF)));
                                    end

                                    RFfrequency_now = getrf;

                                    % Check for stale RF DC Feedback

                                    if RFfrequency_last == RFfrequency_now
                                        RF_frequency_stalenum = RF_frequency_stalenum + 1;
                                        if RF_frequency_stalenum == 30 % - warn and message if stale for 30 secs
                                            fprintf('**The RF is not responding to orbit DC Feedback changes! \n');
                                            fprintf('%s\n',datestr(now));
                                            fprintf('**The orbit DC Feedback is still working but this problem should be investigated. \n');
                                        end
                                        if rem(RF_frequency_stalenum,120)==0 % - message to screen every 2 minutes
                                            fprintf('**The RF is not responding to orbit DC Feedback changes! (%s)\n',datestr(now));
                                        end
                                    else
                                        RF_frequency_stalenum = 0;
                                    end

                                    fprintf('RF Done: time = %f \n', gettime-t00);
                                end
                            end
                        end
                    %end
                    %Xold = Xnew;
                end % End horizontal correction


                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Vertical plane "DC Feedback" %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                % Get orbit and check that the BPMs are different from the last update
                %Ynew = getz(FB.BPMlist);

%                 if any(isnan(Ynew))
%                     DC_FEEDBACK_STOP_FLAG = 1;
%                     fprintf('%s         Orbit DC Feedback stopped due to bad BPMs\n',datestr(now));
%                     BadBPMName = family2tangodev(BPMxFamily, FB.BPMlist(isnan(Xnew),:));
%                     for k=1:size(BadBPMName,1),
%                         fprintf('Bad Vertical BPM %s\n',BadBPMName{k});
%                     end
%                     tango_command_inout2(devSpeakerName,'DevTalk','Arret de la correction d''orbite : problème BPM');
%                     break;
%                 end

                if getdcct < DCCTMIN     % Don't DC Feedback if the current is too small
                    DC_FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         Orbit DC Feedback stopped due to low beam current (< %d mA)\n', datestr(now), DCCTMIN);
                    strgMessage = 'Arret de la correction d''orbite : courant trop bas';
                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    break;
                end

                %y = FB.Ygoal - Ynew;
                %STDy = norm(y)/sqrt(length(y));


                if get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVDCFB'),'Value') == 1

%                     if any(Yold == Ynew)
%                         fprintf('Info: Stale vertical BPM data, DC Feedback step skipped (%s). \n', datestr(clock));
%                         N_Stale_Data_Points = find((Yold==Ynew)==1);
%                         for i = N_Stale_Data_Points'
%                             fprintf('   Stale data: BPMz(%2d,%d), DC Feedback step skipped (%s). \n', ...
%                                 FB.BPMlist(i,1), FB.BPMlist(i,2), datestr(clock));
%                         end
% 
%                     else

                        %%%%%%%%%%%
                        % V-plane %
                        %%%%%%%%%%%

                        % read current of steerers
                        %vcm = getam(VCMFamily, FBstruct.VCMlist);
                        vcm = getpv(VCMFamily, 'SetpointMean', FBstruct.VCMlist);
                        
                        % Compute Delta orbit
                        % Load recorded offset between 10 Hz data and data build up from sniffer
                        %data = load('/home/operateur/GrpPhysiqueMachine/Laurent/matlab/FOFB/offset_sniffer_10Hz', 'hoffset', 'voffset');
                        vDeltaOrbit = RV*vcm;% - data.voffset*1e-6*0;
                        %                         figure(55)
                        %                         clf
                        %                         plot(getspos('BPMz'), vDeltaOrbit); hold on;
                        %                         plot(getspos('BPMz'), vDeltaOrbit+data.voffset*1e-6);

                        % retrieve V-plane response matrix with good BPM and correctors
                        SOFB_Dvcm =  SOFB_RinvV*vDeltaOrbit;

                        % set to gains for correction
                        Y = Ygain.*SOFB_Dvcm;

                        N_VCM = length(FB_SOFB.OCSy.SVDIndex);

                        % check for trim values+next step values, warn or stop FB as necessary

                        VCMSP = getsp(FB_SOFB.OCSy.CM.FamilyName, FB_SOFB.OCSy.CM.DeviceList); % Get corrector values before correction
                        VCMSP_next = VCMSP + Y(1:N_VCM); % New corrector values to be set in

                        pause(0);

                        if getdcct < DCCTMIN     % Don't DC Feedback if the current is too small
                            fprintf('%s         Orbit DC Feedback stopped due to low beam current (<%d mA)\n',datestr(now), DCCTMIN);
                            strgMessage = 'Arret de la correction d''orbite : courant trop bas';
                            tango_giveInformationMessage(devSpeakerName,  strgMessage);
                            DC_FEEDBACK_STOP_FLAG = 1;
                            break;
                        end

                        MaxSP = maxsp(FB_SOFB.OCSy.CM.FamilyName, FB_SOFB.OCSy.CM.DeviceList);
                        MinSP = minsp(FB_SOFB.OCSy.CM.FamilyName, FB_SOFB.OCSy.CM.DeviceList);

                        if any(MaxSP - VCMSP_next  < 0)
                            VCMnum = find(VCMSP_next > MaxSP);
                            % message to screen
                            fprintf('**One or more of the vertical correctors is at its maximum positive value!! Stopping orbit DC Feedback. \n');
                            fprintf('%s\n',datestr(now));
                            fprintf('**%s is one of the problem correctors.\n', ...
                                cell2mat(family2tango(FB_SOFB.OCSy.CM.FamilyName,'Setpoint',FB_SOFB.OCSy.CM.DeviceList(VCMnum(1),:))));
                            DC_FEEDBACK_STOP_FLAG = 1;
                        end

                        if any(MinSP - VCMSP_next  > 0)
                            VCMnum = find(VCMSP_next < MinSP);
                            % message to screen
                            fprintf('**One or more of the vertical correctors is at its maximum negative value!! Stopping orbit DC Feedback. \n');
                            fprintf('%s\n',datestr(now));
                            fprintf('**%s is one of the problem correctors.\n', ...
                                cell2mat(family2tango(FB_SOFB.OCSy.CM.FamilyName,'Setpoint',FB_SOFB.OCSy.CM.DeviceList(VCMnum(1),:))));
                            DC_FEEDBACK_STOP_FLAG = 1;
                        end

                        pause(0);

                        if any(VCMSP_next > MaxSP - 1)
                            VCMnum = find(VCMSP_next > MaxSP - 1);
                            for ik = 1:length(VCMnum)
                                VWarnNum = VWarnNum+1;
                                fprintf('**Vertical correctors %s is above %f! \n', ...
                                    cell2mat(family2tango(FB_SOFB.OCSy.CM.FamilyName,'Setpoint',FB_SOFB.OCSy.CM.DeviceList(VCMnum(ik),:))), ...
                                    MaxSP(VCMnum(ik)) - 1);
                            end
                            fprintf('%s\n',datestr(now));
                            fprintf('**The orbit DC Feedback is still working but this problem should be investigated. \n');
                        end

                        if any(VCMSP_next < MinSP + 1)
                            VCMnum = find(VCMSP_next < MinSP + 1);
                            for ik = 1:length(VCMnum)
                                VWarnNum = VWarnNum+1;
                                fprintf('**Vertical correctors %s is below %f! \n', ...
                                    cell2mat(family2tango(FB_SOFB.OCSy.CM.FamilyName,'Setpoint',FB_SOFB.OCSy.CM.DeviceList(VCMnum(ik),:))), ...
                                    MinSP(VCMnum(ik)) + 1);
                            end
                            fprintf('%s\n',datestr(now));
                            fprintf('**The orbit DC Feedback is still working but this problem should be investigated. \n');
                        end

                        % Maximum current modification in correction for one iteration of  DC feedback                        
                        % scaling off all correctors to get a maximum variation of VDCMAX
                        if max(abs(Y(SOFB_SVDIndexV))) > VDCMAX
                            VDCfact = VDCMAX/max(abs(Y(SOFB_SVDIndexV)));
                            fprintf('V-plane: valeur max is %f A > %f A', max(abs(Y(SOFB_SVDIndexV))), VDCMAX);
                        else
                            VDCfact = 1.0;
                        end

                        % Apply vertical correction
                        
                        if N_VCM > 0 && std(Y(1:N_VCM)) > dvcmStd
                            fprintf('V-correction applied RMS VCOR was %f \n', std(Y(1:N_VCM)))
                            if strcmp(getmode(VCMFamily),'Online')
                                profibus_sync(FB_SOFB.OCSy.CM.FamilyName); pause(0.2);
                            end

                            stepsp(FB_SOFB.OCSy.CM.FamilyName, VDCfact*Y(SOFB_SVDIndexV), FB_SOFB.OCSy.CM.DeviceList, 0);
                            if strcmp(getmode(VCMFamily),'Online')
                                profibus_unsyncall(FB_SOFB.OCSy.CM.FamilyName);
                            end
                        else
                            fprintf('No vertical correction  applied, std corrector = %5.4f mA rms < threshold = %5.4f \n', ...
                                std(Y(1:N_VCM)),dvcmStd);
                        end

                        % Don't DC Feedback if the current is too small, remove iteration
                        if getdcct < DCCTMIN     
                            profibus_sync(FB_SOFB.OCSy.CM.FamilyName); pause(0.2);
                            stepsp(FB_SOFB.OCSy.CM.FamilyName, -VDCfact*Y(SOFB_SVDIndexV), FB_SOFB.OCSy.CM.DeviceList, 0);
                            profibus_unsyncall(FB_SOFB.OCSy.CM.FamilyName);
                        end

                    %end
                end

                %Yold = Ynew;

                % Output info to screen
%                 set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextHorizontal'), ...
%                     'String',sprintf('Horizontal RMS = %.4f mm',STDx), ...
%                     'ForegroundColor',[0 0 0]);
%                 set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextVertical'), ...
%                     'String',sprintf('Vertical RMS = %.4f mm',STDy),...
%                     'ForegroundColor',[0 0 0]);
%                 pause(0);

                argin.svalue={'dcfb'};
                argin.lvalue=int32(Locktag);
                % Wait for next update time or stop request
                while DC_FEEDBACK_STOP_FLAG == 0 && (gettime-t00) < LoopDelay
                    pause(.2);
                    % Check if GUI has been closed
                    if isempty(gcbf)
                        DC_FEEDBACK_STOP_FLAG = 1;
                        lasterr('FOFBguiTango GUI DISAPPEARED!');
                        error('FOFBguiTango GUI DISAPPEARED!');
                    end
                    if DC_FEEDBACK_STOP_FLAG == 0
                        DC_FEEDBACK_STOP_FLAG = getappdata(findobj(gcbf,'Tag','FOFBguiTangoFig1'),'DC_FEEDBACK_STOP_FLAG');
                        % read FOFB status and stop DC loop if KO

                        isxFOFBRunning = readattribute([devFOFBManager, '/xFofbRunning']);
                        iszFOFBRunning = readattribute([devFOFBManager, '/zFofbRunning']);
                        if ~isxFOFBRunning || ~iszFOFBRunning
                            DC_FEEDBACK_STOP_FLAG = 1;
                            fprintf('DCFB stopped since FOFB is stopped!\n');
                        end                                                        
                   end
                    % Maintain lock on FOFB service
                    tango_command_inout2(devLockName,'MaintainLock', argin);
                end

                StartErrorTime = gettime;

                % Maintain lock on FOFB service
                tango_command_inout2(devLockName,'MaintainLock', argin);


            catch
                fprintf('\n  %s \n',lasterr);
                DC_FEEDBACK_STOP_FLAG = 1;
                strgMessage = 'Arret du daichargement des correcteurs';
                tango_giveInformationMessage(devSpeakerName,  strgMessage);
                profibus_unsyncall(VCMFamily); % to be sure that correctors are controllable
            end

            % Check whether user asked for stopping FOFB
            if DC_FEEDBACK_STOP_FLAG == 0
                DC_FEEDBACK_STOP_FLAG = getappdata(findobj(gcbf,'Tag','FOFBguiTangoFig1'),'DC_FEEDBACK_STOP_FLAG');
            end


        end  % End of DC Feedback loop


        % End DC Feedback, reset all parameters
        try

            % Enable buttons
            set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStartDC'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStopDC'),'Enable','off');
            set(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrection'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoButtonFeedbackSetup'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoClose'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHSOFB'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVSOFB'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHcorrection'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVcorrection'),'Enable','on');
            %set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxRF'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxSOFB'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxFOFB'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHDCFB'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVDCFB'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextHorizontal'),'String',sprintf('Horizontal RMS = _____ mm'),'ForegroundColor',[0 0 0]);
            set(findobj(gcbf,'Tag','FOFBguiTangoStaticTextVertical'),'String',sprintf('Vertical RMS = _____ mm'),'ForegroundColor',[0 0 0]);
            set(findobj(gcbf,'Tag','FOFBguiTangoButtonConvertMatrix4FPGA'),'Enable','on');
            set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStart'),'Enable','on');
            pause(0);

        catch
            % GUI must have been closed
            fprintf('GUI must have been closed\n');
        end

        fprintf('   %s \n', datestr(clock));
        fprintf('   ******************************\n');
        fprintf('   **  Orbit DC Feedback Stopped  **\n');
        fprintf('   ******************************\n\n');
        set(0,'showhiddenhandles','off');
        pause(0);

        % Unlock SOFB service
        argin.svalue={'dcfb'};
        argin.lvalue=int32(Locktag);
        tango_command_inout2(devLockName,'Unlock', argin);

        %setup average data for reading BPMs
        setfamilydata('gethbpmgroup','BPMx','Monitor', 'SpecialFunctionGet')
        setfamilydata('getvbpmgroup','BPMz','Monitor', 'SpecialFunctionGet')

%% FOFBRunningMode
    case 'FOFBRunningMode' %Switch between FOFB mode
        % 0 means FOFB without SOFB and with DCFB
        % 1 means FOFB with SOFB but wihtout DCFB
        
        if readattribute([devLockName '/dcfb'])
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxFOFB_SOFB'),'Value', 0);
            warndlg('First Stop DCFB')
            return;
        end
        
        val = get(findobj(gcbf,'Tag','FOFBguiTangoCheckboxFOFB_SOFB'),'Value');

        isxFOFBRunning = readattribute([devFOFBManager, '/xFofbRunning']);
        iszFOFBRunning = readattribute([devFOFBManager, '/zFofbRunning']);

        if isxFOFBRunning || iszFOFBRunning
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxFOFB_SOFB'),'Value', mod(val+1,2));
            fprintf('First Stop FOFB\n')
            return;
        end

        
        if val == 1 % FOFB runs with SOFB but without DCFB
            set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStopDC'),'Enable', 'off');
            set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStartDC'),'Enable', 'off');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxDCRF'),'Enable', 'off');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHDCFB'),'Enable', 'off');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVDCFB'),'Enable', 'off');
            set(findobj(gcbf,'Tag','FOFBguiTangoFig1'),'Color', [0.84 0 0.89]);

        else % FOFB runs without SOFB and with DCFB
            set(findobj(gcbf,'Tag','FOFBguiTangoPushbuttonStartDC'),'Enable', 'on');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxDCRF'),'Enable', 'on');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxHDCFB'),'Enable', 'on');
            set(findobj(gcbf,'Tag','FOFBguiTangoCheckboxVDCFB'),'Enable', 'on');            
            set(findobj(gcbf,'Tag','FOFBguiTangoFig1'),'Color', [0.1 0.1 1]);
        end

        FB = get(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata');
        FB.SOFBandFOFB = val;
        set(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata',FB);
        savaData2File;
        
    otherwise
        fprintf('   Unknown action name: %s.\n', action);

end


%% getlocallist
function [HCMlist, VCMlist, BPMlist] = getlocallist

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit the following lists to change default configuration of Orbit Correction %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


HCMlist = family2dev('FHCOR');
VCMlist = family2dev('FVCOR');

% do not change this list
% otherwise incoherent state with matrix4fofb

BPMlist = [
    1     2
    1     3
    1     4
    1     5
    1     6
    1     7
    2     1
    2     2
    2     3
    2     4
    2     5
    2     6
    2     7
    2     8
    3     1
    3     2
    3     3
    3     4
    3     5
    3     6
    3     7
    3     8
    4     1
    4     2
    4     3
    4     4
    4     5
    4     6
    4     7
    5     1
    5     2
    5     3
    5     4
    5     5
    5     6
    5     7
    6     1
    6     2
    6     3
    6     4
    6     5
    6     6
    6     7
    6     8
    7     1
    7     2
    7     3
    7     4
    7     5
    7     6
    7     7
    7     8
    8     1
    8     2
    8     3
    8     4
    8     5
    8     6
    8     7
    9     1
    9     2
    9     3
    9     4
    9     5
    9     6
    9     7
    10     1
    10     2
    10     3
    10     4
    10     5
    10     6
    10     7
    10     8
    11     1
    11     2
    11     3
    11     4
    11     5
    11     6
    11     7
    11     8
    12     1
    12     2
    12     3
    12     4
    12     5
    12     6
    12     7
    13     1
    13     8
    13     9
    13     2
    13     3
    13     4
    13     5
    13     6
    13     7
    14     1
    14     2
    14     3
    14     4
    14     5
    14     6
    14     7
    14     8
    15     1
    15     2
    15     3
    15     4
    15     5
    15     6
    15     7
    15     8
    16     1
    16     2
    16     3
    16     4
    16     5
    16     6
    16     7
    1     1
    ];

function check4feedbackflag(devLockName)

if strcmp(getmode('BPMx'),'Online') && strcmp(getmode('BPMz'),'Online')
    %look for already running FOFB
    val = readattribute([devLockName '/sofb']);
    if val == 1
        error('SOFB already running. Stop other application first!')
    end
    val = readattribute([devLockName '/rffb']);
    if val == 1
        error('RFFB already running. Stop other application first!')
    end
end

function check4DCfeedbackflag(devLockName)

if strcmp(getmode('BPMx'),'Online') && strcmp(getmode('BPMz'),'Online')
    %look for already running FOFB
    val = readattribute([devLockName '/sofb']);
    if val == 1
        error('SOFB already running. Stop other application first!')
    end
    val = readattribute([devLockName '/dcfb']);
    if val == 1
        error('DCFB already running. Stop other application first!')
    end
end

% data saved to be used in another GUI by SOFB
function savaData2File

FB = get(findobj(gcbf,'Tag','FOFBguiTangoButtonOrbitCorrectionSetupFOFB'),'Userdata');
% Save current configuration data for FOFB into a file!
% Ugly but first quick solution before merging both FB
DirName = getfamilydata('Directory', 'FOFBdata');
FileName = fullfile(DirName, 'FOFBconfiguration');
save(FileName, 'FB');

fprintf('New FOFB configuration saved to file %s\n', FileName);
% %%
%       case Tango::ON:
%         lv_state = 0;
%         break;
%       case Tango::OFF:
%         lv_state = 1;
%         break;
%       case Tango::CLOSE:
%         lv_state = 2;
%         break;
%       case Tango::OPEN:
%         lv_state = 3;
%         break;
%       case Tango::INSERT:
%         lv_state = 4;
%         break;
%       case Tango::EXTRACT:
%         lv_state = 5;
%         break;
%       case Tango::MOVING:
%         lv_state = 6;
%         break;
%       case Tango::STANDBY:
%         lv_state = 7;
%         break;
%       case Tango::FAULT:
%         lv_state = 8;
%         break;
%       case Tango::INIT:
%         lv_state = 9;
%         break;
%       case Tango::RUNNING:
%         lv_state = 10;
%         break;
%       case Tango::ALARM:
%         lv_state = 11;
%         break;
%       case Tango::DISABLE:
%         lv_state = 12;
%         break;
%       default:
%       case Tango::UNKNOWN:
%         lv_state = 13;
%         break;
%



function [SynchStatus]=CheckFOFBSynch
result=tango_read_attribute2('ANS/DG/FOFB-MANAGER', 'bpmCnt');
SynchStatus=isequal(sum(result.value)./size(result.value,2),size(result.value,2));

