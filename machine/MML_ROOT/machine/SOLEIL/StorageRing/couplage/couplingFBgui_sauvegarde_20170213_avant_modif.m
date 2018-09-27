function couplingFBgui(action, Input2, Input3)
%couplingFBgui - GUI for coupling feedback
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
%  Version RUN3_2013

% For the compiler
%#function getcoupling
%#function solamor2linb
%#function solamor2linc
%#function lat_2020_3170f
%#function lat_2020_3170e
%#function lat_2020_3170b
%#function lat_2020_3170a
%#function lat_pseudo_nanoscopium_juin2011_122BPM
%#function lat_nano_176_234_122BPM

%
%%  Written by Mat from tuneFBgui


% Check if the AO exists
checkforao;
Nbuffer = 3 ; % profondeur du buffer d'enregistrement de la taille verticale pour le test de valeur fig�e
DEBUGFLAG = 0; % pour avoir des d�tails sur la correction propos�e
TESTFLAG = 0; % pour tester l'interface avant que n'existe le device SERVICE_LOKER, et sans acc�s possible aux devices DCCT et emit

% Dedicated dserver Device
devSpeakerName = 'ans/ca/texttalker.2';
devLockName    = 'ANS/CA/SERVICE-LOCKER';
devemit = 'ANS-C02/DG/PHC-EMIT';
devImA = 'ANS-C02/DG/PHC-IMAGEANALYZER';
temp = tango_read_attribute2('ANS/FC/PUB-SLICING','isSlicing')
isSlicing = temp.value(1) ;

%%%betaz = 15.25 ; % MODIFIER taille verticale � la PHC1 fonction de l'optique - on automatise ?
betaz = readattribute([devemit '/BetaZ']) ; % correction bug 03/10/2016
%%%MXphc1  = 5.703/4.365 ;
a=tango_get_property(devemit,'DistPinholeV2Convert') ; DistPinholeV2Convert = str2num(a.value{:})	;
a=tango_get_property(devemit,'DistSource2PinholeV') ; DistSource2PinholeV = str2num(a.value{:});
MXphc1  = DistPinholeV2Convert / DistSource2PinholeV ; % correction bug 03/10/2016

Mode = 'Online';
if TESTFLAG
    Mode = 'Model';
end
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
% liste complete de QT pour initialisation
QTList = family2dev('QT');
IndexQToff = [ ] ;

% Minimum stored current to allow correction
% Default values
%DCCTMIN = 50; % mA multibunch
%DCCTMIN = 7; % mA single bunch
if TESTFLAG
    DCCTMIN = 350; % revenir provisoire
else
    DCCTMIN = read_fbcoupling_property('CurrentThreshold'); % attention
end

% informations relatives au fichier de dispersion verticale utilis�, et au
% pourcentage d'application de la dispersion verticale (fix� en dur dans le script)
% a ne pas confondre avec le pourcentage d'application de la correction qui
% est reglable dans l'interface
if TESTFLAG
    couplingFB.FileName_Dz = fullfile(getfamilydata('Directory', 'Coupling'), filesep, 'Nanoscopium', filesep, '2012-07-23_couplage', filesep,'QT_Dipersion_verticale_pure_Nanoscopium.mat');
    %couplingFB.FileName_Dz = '/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/SkewQuad/solution_QT/Nanoscopium/2012-07-23_couplage/QT_Dipersion_verticale_pure_Nanoscopium.mat' ;
    %couplingFB.FileName_Min = '/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/SkewQuad/solution_QT/Nanoscopium/QT_couplage_min_nanoscopium.mat' ;
    couplingFB.FileName_Min = fullfile(getfamilydata('Directory', 'Coupling'), filesep, 'Nanoscopium', filesep, 'QT_couplage_min_nanoscopium.mat');

else
    DirName = getfamilydata('Directory','OpsData');
    %couplingFB.FileName_Dz = '/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/SkewQuad/solution_QT/Nanoscopium/QT_Dipersion_verticale_pure_Nanoscopium.mat' ;
    %couplingFB.FileName_Min = '/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/SkewQuad/solution_QT/Nanoscopium/QT_couplage_min_nanoscopium_redemarrage_5mai2013.mat' ;
    %couplingFB.FileName_Min = '/home/production/matlab/matlabML/measdata/SOLEIL/StorageRingdata/SkewQuad/solution_QT/Nanoscopium/QT_couplage_min_nanoscopium_redemarrage_5mai2013.mat' ;
    couplingFB.FileName_Dz = fullfile(DirName,'QT_Golden_Nano24oct13_partieDz.mat');
    %couplingFB.FileName_Dz =fullfile(DirName,'QT_Golden_ANCIEN_NANO_partieDz.mat');
    %couplingFB.FileName_Min =fullfile(DirName,'QT_Kminimum_LOCO_16sept13');
    %couplingFB.FileName_Min =fullfile(DirName,'QT_Kminimum_Golden_WSV50_ferme');
    %couplingFB.FileName_Min =fullfile(DirName,'QT_Kmin_26octobre2014_w_WSV50'); % 26 octobre 2014
    %couplingFB.FileName_Min =fullfile(DirName,'QT_Kminimum_Golden_WSV50_ferme_redemarrage_RUN1_2015'); % RUN1 2015
    %couplingFB.FileName_Min =fullfile(DirName,'QT_Kminimum_Golden_WSV50_ferme_redemarrage_RUN2_2015'); % RUN2 2015
    %couplingFB.FileName_Min =fullfile(DirName,'QT_Kminimum_Golden_sans_WSV50_redemarrage_RUN5_2015'); % RUN2 2015
    if ~isSlicing
        couplingFB.FileName_Min =fullfile(DirName,'QTmin_RUN4_LOCOiter2_machine_Golden_WSV50'); % RUN1 2016
    else
        %couplingFB.FileName_Min =fullfile(DirName,'QTmin_LOCO_RUN1_2016_wW164_wWSV50_gap_slicing'); % RUN2 2016 premiere semaine
        %couplingFB.FileName_Min =fullfile(DirName,'QTmin_RUN4_SLICING_W164_16p7mm_WSV50_VRAI'); % RUN4 2016 
        couplingFB.FileName_Min_Puma    =fullfile(DirName,'QTmin_RUN1_2017_PUMA_W164_14p7mm_WSV50'); % RUN1 2017 avec PUMA @ 14.7 mm 

    end
    
end

couplingFB.pourcentage = 5 ;
couplingFB.Maxpourcentage = 50.;%
MeasureWaittime_1 = 0.250 ;% to be adjusted as soon as devices run faster
MeasureWaittime_2 = 0.1 ; % rather fixed 
GUIWaittime_1 = 0.5 ; % fixed
GUIWaittime_2 = 1. ; % fixed
couplingFB.QTList = family2dev('QT');
couplingFB.IndexQToff = [ ] ;


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
        Frame1height = 12*(ButtonHeight) + 30 ; %10 ; % coupling Feedback frame
        Frame2height = 4*(ButtonHeight) + 10 ; % Status frame
        FrameWidth   = ButtonWidth+6;
        FrameLeft    = 0.025*FrameWidth;
        LeftMargin   = 3*FrameLeft;
        LeftMargin_2   = 2*FrameLeft;
        FrameWidth_2   = ButtonWidth/2+6;

        Frametop  = Frame0height + Frame1height + Frame2height + 3*8;
        Frame1top = Frametop - 8;
        Frame2top = Frametop - Frame1height - 2*8;
        Frame0top = Frametop - Frame1height - Frame2height - 3*8;

        FigWidth    = 1.15*FrameWidth;                % Figure width
        FigHeight   = Frametop+0.2*ButtonHeight+6;% Figure heigth

        % Change figure position
        set(0,'Units','pixels');
        p = get(0,'screensize');

        orbfig = findobj(allchild(0),'tag','couplingFBguiFig1');

        if ~isempty(orbfig)
            return; % IHM already exists
        end
        if isSlicing
            u = [0 1 0] ;
        else
            u = [.651 0.855 0.924] ;
        end

        v = [0.8 0.8 0.8] ;
        %v = [.751 0.955 0.524] ;
        % u = [1 1 0] 
        % u = [1 0 1];
        h0 = figure( ...
            'Color',u, ...
            'HandleVisibility','Off', ...
            'Interruptible', 'on', ...
            'MenuBar','none', ...
            'Name','coupling FB CONTROL', ...
            'NumberTitle','off', ...
            'Units','pixels', ...
            'Position',[30 p(4)-FigHeight-40 FigWidth FigHeight], ...
            'Resize','off', ...
            'HitTest','off', ...
            'IntegerHandle', 'off', ...
            'Tag','couplingFBguiFig1');

        %% Frame Box I coupling Feedback frame
        uicontrol('Parent',h0, ...
            'BackgroundColor',v, ...
            'ListboxTop',0, ...
            'Position',[FrameLeft Frame2top 1.1*FrameWidth Frame1height], ...
            'Style','frame');
        if isSlicing
            uicontrol('Parent',h0, ...
                'BackgroundColor',v, ...
                'FontSize',10, ...
                'FontWeight', 'Bold', ...
                'ListboxTop',0, ...
                'Position',[LeftMargin 3 + Frame1top - 1.5*(ButtonHeight+3) FrameWidth .6*ButtonHeight], ...
                'String','Coupling Feedback SLICING VERSION', ...
                'Style','text');
        else
            uicontrol('Parent',h0, ...
                'BackgroundColor',v, ...
                'FontSize',10, ...
                'FontWeight', 'Bold', ...
                'ListboxTop',0, ...
                'Position',[LeftMargin 3 + Frame1top - 1.5*(ButtonHeight+3) FrameWidth .6*ButtonHeight], ...
                'String','Coupling Feedback', ...
                'Style','text');
        end
        % 'Position',[LeftMargin 3 + Frame1top - 1*(ButtonHeight+3) FrameWidth .6*ButtonHeight], ...
%         uicontrol('Parent',h0, ...
%             'BackgroundColor',[0.8 0.8 0.8], ...
%             'Enable','on', ...
%             'Interruptible', 'on', ...
%             'Position',[LeftMargin 3 + Frame1top - 2*(ButtonHeight+3) 0.5*ButtonWidth-32 .8*ButtonHeight], ...
%             'String','H-plane', ...
%             'Style','checkbox', ...
%             'Value',1,...
%             'Tag','couplingFBguiCheckboxHcorrection');

%         uicontrol('Parent',h0, ...
%             'BackgroundColor',[0.8 0.8 0.8], ...
%             'Enable','on', ...
%             'Interruptible', 'on', ...
%             'Position',[LeftMargin + 0.55*ButtonWidth 3 + Frame1top - 2*(ButtonHeight+3) 0.5*ButtonWidth-32 .8*ButtonHeight], ...
%             'String','V-plane', ...
%             'Style','checkbox', ...
%             'Value',1,...
%             'Tag','couplingFBguiCheckboxVcorrection');

        uicontrol('Parent',h0, ...
            'BackgroundColor',v, ...
            'Enable','on', ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  Frame1top - 5*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','Golden Emiitance V', ...
            'Style','Text', ...
            'Value',0,...
            'Tag','couplingFBguiGoldencoupling');


        uicontrol('Parent',h0, ...
            'Callback','couplingFBgui(''StartcouplingFB'');', ...
            'BackgroundColor',v, ...
            'Enable','on', ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin 3 + Frame1top - 4*(ButtonHeight+3) 0.5*FrameWidth ButtonHeight], ...
            'String','Start coupling FB', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','couplingFBguiStartcouplingFB');

        uicontrol('Parent',h0, ...
            'Callback','couplingFBgui(''StopcouplingFB'');', ...
            'BackgroundColor',v, ...
            'Enable','on', ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin + 0.55*ButtonWidth  3 + Frame1top - 4*(ButtonHeight+3) 0.5*FrameWidth ButtonHeight], ...
            'String','Stop coupling FB', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','couplingFBguiStopcouplingFB');

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
            'Tag','couplingFBguiSettings');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.5 0.5 1], ...
            'Enable','on', ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 7*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','Min Delta Ez', ...
            'Style','Text', ...
            'Value',0,...
            'Tag','couplingFBguiMinDnu');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.5 0.5 1], ...
            'Enable','on', ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 8*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','Max Delta Ez', ...
            'Style','Text', ...
            'Value',0,...
            'Tag','couplingFBguiMaxDnu'); % revenir

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.5 0.5 1], ...
            'Enable','on', ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 9*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','couplingFB.LoopDelay', ...
            'Style','Text', ...
            'Value',0,...
            'Tag','couplingFBguicouplingFB.LoopDelay');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.5 0.5 1], ...
            'Enable','on', ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 10*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','couplingFB.factor', ...
            'Style','Text', ...
            'Value',0,...
            'Tag','couplingFBguicouplingFB.factor');

        uicontrol('Parent',h0, ...
            'Callback','couplingFBgui(''CurrentThresholdSetting'');', ...
            'BackgroundColor',v, ...
            'ForegroundColor',[1 0 0], ...
            'Enable','on', ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 11*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','Current threshold setting', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','couplingFBguiCurrentThresholdSetting');
        uicontrol('Parent',h0, ...
            'Callback','couplingFBgui(''QTList'');', ...
            'BackgroundColor',v, ...
            'ForegroundColor',[1 0 0], ...
            'Enable','on', ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[LeftMargin  3 + Frame1top - 12*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','edit QT list', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','couplingFBguiCurrentThresholdSetting');  %% verifier !!
% 'BackgroundColor',[0.8 0.8 0.8], ...
        uicontrol('Parent',h0, ...
            'CreateFcn','couplingFBgui(''SetupcouplingFB'',1);', ...
            'Callback','couplingFBgui(''SetupcouplingFB'');', ...
            'BackgroundColor',v, ...
            'FontSize',10, ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin 3 + Frame1top - 3*(ButtonHeight+3) FrameWidth ButtonHeight], ...
            'String','Edit FB configuration', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','couplingFBguiButtoncouplingFBSetup');

        %% Frame Box Status
        uicontrol('Parent',h0, ...
            'BackgroundColor',v, ...
            'ListboxTop',0, ...
            'Position',[FrameLeft Frame0top  1.1*FrameWidth Frame2height], ...
            'Style','frame');

        uicontrol('Parent',h0, ...
            'BackgroundColor',v, ...
            'HorizontalAlignment','center', ...
            'FontWeight', 'Bold', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin Frame2top - 1*(ButtonHeight+3) ButtonWidth .7*ButtonHeight], ...
            'String','couplingFB status ', ...
            'Style','text');
   %                'Position',[LeftMargin Frame2top - 1*(ButtonHeight+3) ButtonWidth .7*ButtonHeight], ...
    %        'String','couplingFB status ', ...
     %       'Style','text');

        uicontrol('Parent',h0, ...
            'BackgroundColor',v, ...
            'HorizontalAlignment','center', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin Frame2top - 2*(ButtonHeight+3) 0.6*ButtonWidth .7*ButtonHeight], ...
            'String','Date', ...
            'Style','text', ...
            'Tag','couplingFBguiStaticTextHeader');
% 'String','To get Status Push button: ', ...

        uicontrol('Parent',h0, ...
            'callback','couplingFBgui(''UpdateStatuscouplingFB'');pause(0);', ...
            'BackgroundColor',v, ...
            'HorizontalAlignment','center', ...
            'ListboxTop',0, ...
            'Position',[6 + 0.7*ButtonWidth Frame2top - 2.1*ButtonHeight 0.3*ButtonWidth .7*ButtonHeight], ...
            'String','Update', ...
            'Style','PushButton', ...
            'Tag','couplingFBguiUpdateStatuscouplingFB');

        h1= uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 1], ...
            'ForegroundColor','b', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin+0.38*ButtonWidth Frame2top - 3*ButtonHeight 0.25*ButtonWidth .7*ButtonHeight], ...
            'String','FB Status', ...
            'Style','text', ...
            'Tag','couplingFBguiiscouplingFBRunning');
  

       
%         h2 = uicontrol('Parent',h0, ...
%             'BackgroundColor',[1 1 1], ...
%             'ForegroundColor','b', ...
%             'ListboxTop',0, ...
%             'Position',[LeftMargin+0.4*ButtonWidth Frame2top - 3*ButtonHeight 0.25*ButtonWidth .7*ButtonHeight], ...
%             'String','V-plane', ...
%             'Style','text', ...
%             'Tag','couplingFBguiiscouplingzFBRunning');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[1 1 0], ...
            'ForegroundColor','b', ...
            'ListboxTop',0, ...
            'Position',[LeftMargin Frame2top - 4*ButtonHeight ButtonWidth .7*ButtonHeight], ...
            'String','stored current', ...
            'Style','text', ...
            'Tag','couplingFBguiStatus');

        %% Frame Box "Close"
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ListboxTop',0, ...
             'Position',[FrameLeft 8 1.1*FrameWidth 0.9*Frame0height], ...
            'Style','frame');
   %         'Position',[FrameLeft 8 1.1*FrameWidth 0.7*Frame0height], ...
    %        'Style','frame');

        uicontrol('Parent',h0, ...
            'Callback', 'close(gcbf);', ...
            'Enable','On', ...
            'Interruptible','Off', ...
            'Position',[LeftMargin 13 ButtonWidth ButtonHeight*0.8], ...
            'String','Close', ...
            'Tag','couplingFBguiClose');
        
        uicontrol('Parent',h0, ...
            'Callback','couplingFBgui(''ApplyGoldenQT'');', ...
            'ForegroundColor',[1 0 0], ...
            'Enable','On', ...
            'Interruptible','Off', ...
            'Position',[LeftMargin 35 ButtonWidth ButtonHeight*0.8], ...
            'String','Apply Golden QT (slowly)', ...
            'Tag','couplingFBguiClose');
        % Read planes for FB correction in device server
        
if TESTFLAG
    iscouplingFBRunning=1; % revenir temporaire
else
        try
            iscouplingFBRunning = readattribute([devLockName, '/iscouplingfbrunning']);
        catch
            warndlg(sprintf('Error with dserveur %s', devLockName));
        end
end
    
        set(h1, 'Value',iscouplingFBRunning);
        if iscouplingFBRunning %|| iscouplingzFBRunning
            % Disable buttons in GUI
            set(0,'showhiddenhandles','on');
            set(findobj(gcf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Enable','on');
            set(findobj(gcf,'Tag','couplingFBguiClose'),'Enable','on');
%             set(findobj(gcf,'Tag','couplingFBguiCheckboxHcorrection'),'Enable','off');
%             set(findobj(gcf,'Tag','couplingFBguiCheckboxVcorrection'),'Enable','off');
            pause(0);
        end

        % init FB structure
        pause(GUIWaittime_1)
        couplingFBgui('UpdateStatuscouplingFB');     
        
        %couplingFBgui('ShowFBConfig');
        
        %% CurrentThresholdSetting
    case 'CurrentThresholdSetting'
        couplingFB = get(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata');
        answer = inputdlg({'New Current Threshold'}, 'DIALOG BOX',1, {num2str(couplingFB.DCCTMIN)});
        if isempty(answer)
            return
        end
        couplingFB.DCCTMIN = str2double(answer{1});
        set(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata', couplingFB);
        if ~TESTFLAG
        % UPDATE TANGO free property
            write_fbcoupling_property('CurrentThreshold',num2str(couplingFB.DCCTMIN)); 
        end
        
        strdata = sprintf('Corr. Percent.: %d %%  Min current: %d mA', couplingFB.fact*100, couplingFB.DCCTMIN);
        set(findobj(gcbf,'Tag','couplingFBguicouplingFB.factor'),'String', strdata);
        
        
        %% QTList
    case 'QTList'
        
        ListOld = QTList;
        
        % Get full QT list
        List = family2dev('QT');
        
        % Check QT already in the list CheckList(i) = 1
        %       QT not in the list CheckList(i) = 0
        CheckList = zeros(size(List,1),1);
        if ~isempty(QTList)
            for i = 1:size(List,1)
                k = find(List(i,1) == QTList(:,1));
                l = find(List(i,2) == QTList(k,2));
                if isempty(k) || isempty(l)
                    % Item not in list
                else
                    CheckList(i) = 1;
                end
            end
        end
        
        % User edition of the QT list
        newList = editlist(List, 'QT', CheckList);
        if isempty(newList)
            fprintf('   QT list cannot be empty.  No change made.\n');
        else
            QTList = newList;
        end
        
        % identify QT that have been substracted        
        CheckList = zeros(size(List,1),1);
        if ~isempty(QTList)
            for i = 1:size(List,1)
                k = find(List(i,1) == QTList(:,1));
                l = find(List(i,2) == QTList(k,2));
                if isempty(k) || isempty(l)
                    % Item not in list
                else
                    CheckList(i) = 1;
                end
            end
        end   
        IndexQToff = find(CheckList==0) ;
        
        % save
        couplingFB = get(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata');

        couplingFB.IndexQToff = IndexQToff ;
        couplingFB.QTList = QTList ;
        set(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata', couplingFB);

        disp(' ');

        
%         % Set the goal orbit to the golden orbit
%         Xgoal = getgolden(BPMxFamily, BPMlist);
%         Ygoal = getgolden(BPMyFamily, BPMlist);
%         Xweight = ones(size(BPMlist,1),1);
%         Yweight = ones(size(BPMlist,1),1);
%         
%         % If a new BPM is added, then set the goal orbit to the golden orbit
%         % For other BPMs, present goal orbit is kept
%         for i = 1:size(BPMlist,1)
%             
%             % Is it a new BPM?
%             k = find(BPMlist(i,1) == ListOld(:,1));
%             l = find(BPMlist(i,2) == ListOld(k,2));
%             
%             if isempty(k) || isempty(l)
%                 % New BPM
%             else
%                 % Use the old value for old BPM
%                 Xgoal(i) = XgoalOld(k(l));
%                 Ygoal(i) = YgoalOld(k(l));
%                 Xweight(i) = XweightOld(k(l));
%                 Yweight(i) = YweightOld(k(l));
%             end
%         end
        
        
        %% ApplyGoldenQT
    case 'ApplyGoldenQT'

        % load list and golden values
        couplingFB = get(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata');
        IndexQToff = couplingFB.IndexQToff ;
        QTList = couplingFB.QTList ;
        load(couplingFB.FileName_Dz);
        QTdz = Deltaskewquad;
        load(couplingFB.FileName_Min);
        QTmin = Deltaskewquad;
        % QTright = QTmin + 0.8 * QTdz ; % modif 1 paquet
        QTright = QTmin + QTdz ; % autres operations
        
        if ~size(IndexQToff,1)==0
            QTright(IndexQToff) = [ ] ;
        end
        FlagGolden = 0; ncoup = 0;
        QTwrong = getam('QT',QTList); % get the present (wrong) values
        
        while FlagGolden == 0
            QTdiff = QTright - QTwrong ;
            ncoup = ncoup +1;
            pause(3);
            QTwrong = getam('QT',QTList); % get the present (wrong) values
            [ispeed j] = find(abs(QTright - QTwrong )<0.2);
            [ispeed2 j] = find(abs(QTright - QTwrong )<0.05);
            if length(ispeed2)==length(QTList);
                stepsp('QT',QTdiff/2,QTList);
            elseif length(ispeed)==length(QTList);
                stepsp('QT',QTdiff/5,QTList);
            else
                stepsp('QT',QTdiff/10,QTList);
            end          
            [i j] = find(abs(QTright - QTwrong )<0.02);
            fprintf('           wait... only %2.0f SQ over %2.0f, back to their Golden value\n',length(i), length(QTList))
            if length(i)==length(QTList);
                FlagGolden = 1;
            end
            if ncoup==200
                disp('             This was not possible to apply Golden QT, please check the SkewQuad') 
                strgMessage = 'Arret de l''application Q T goldène, il y a un problème avec les Q T ';
                tango_giveInformationMessage( strgMessage);
                return
            end
        end
        fprintf('           \n')
        disp('             User applied Golden QT')  
        strgMessage = 'Bravo, vous avez appliké les Q T goldène ';
        tango_giveInformationMessage( strgMessage);
        
        
        %%  UpdateStatuscouplingFB
    case 'UpdateStatuscouplingFB'
        
        try
            if TESTFLAG
                iscouplingFBRunning=1; % revenir temporaire    
            else
                iscouplingFBRunning = readattribute([devLockName, '/iscouplingfbrunning']);
            end
        
            if isempty(gcbf)
                mainFig = findall(0, 'Tag', 'couplingFBguiFig1');
            else
                mainFig = gcbf;
            end

            if iscouplingFBRunning
                set(findobj(mainFig,'Tag','couplingFBguiiscouplingFBRunning'),'BackGroundColor', [0 1 0]);
            else
                set(findobj(mainFig,'Tag','couplingFBguiiscouplingFBRunning'),'BackGroundColor', [1 1 1]);
            end

            set(findobj(mainFig,'Tag','couplingFBguiStaticTextHeader'),'String', datestr(clock));

            if TESTFLAG
                sdata = sprintf('Stored current is %3.1f mA', 403.2);% revenir temporaire
            else
                sdata = sprintf('Stored current is %3.1f mA', getdcct(Mode)); 
            end
            set(findobj(mainFig,'Tag','couplingFBguiStatus'),'String', sdata);
        catch
            dbstack
            fprintf('\n  %s \n',lasterr);
            fprintf('Error in UpdateStatuscouplingFB\n') ;
        end

        %% SetupcouplingFB  % attention
    case 'SetupcouplingFB'
        % NOTES setting for FB

        InitFlag = Input2;  % Input #2: if InitFlag, then initialize variables

        if InitFlag % just at startup

%              % MODIFIER
            K = 0.01 ; %K = getgolden('COUPLING'); % MODIFIER
            %  E = modelemit;           
            %  Vbeamsize0 = sqrt(K * E(1)*1e-9 * betaz) * MXphc1 ;

            Ex0 = 5e-9 ; % 5 nmrad in presence of undulators
            Ez0 = K * Ex0 ; % 50 pmrad by default
            Vbeamsize0 = sqrt(Ez0 * betaz) * MXphc1 ;

            if Vbeamsize0==0 % if bad golden
                couplingFB.Golden.Vbeamsize = 32e-6;
                couplingFB.Golden.Ez = 39e-12 ; % Ez = 50 pmrad
                % attention dim = 1
%                 tuneFB.Golden.tune(2) = 0.3100;
            else % otherwise take by default golden value
                couplingFB.Golden.Vbeamsize = Vbeamsize0;
                couplingFB.Golden.Ez = Ez0 ;
            end

            % configuration of couplingFB

            % minimum coupling variation for correction
            deltaK = 5e-4; %3e-4; %2e-4; %5e-4;
            couplingFB.minDeltaEz = deltaK * Ex0 ;
            couplingFB.minDeltaVbeamsize = min(abs((sqrt(K * Ex0 * betaz) - sqrt((K - deltaK) * Ex0 * betaz)) * MXphc1),...
                abs((sqrt(K * Ex0 * betaz) - sqrt((K + deltaK) * Ex0 * betaz)) * MXphc1))
            %1e-6 ; % sqrt(deltaK * Ex0 * betaz) * MXphc1 ;
            %tuneFB.minDeltaTuneZ = 6e-4;

            % maximum coupling variation
            deltaK = 0.6e-2;
            couplingFB.maxDeltaEz = deltaK * Ex0 ;
            couplingFB.maxDeltaVbeamsize = min(abs((sqrt(K * Ex0 * betaz) - sqrt((K - deltaK) * Ex0 * betaz)) * MXphc1),...
                abs((sqrt(K * Ex0 * betaz) - sqrt((K + deltaK) * Ex0 * betaz)) * MXphc1))
            
            % 12e-6 ; 
            
            %sqrt(deltaK * Ex0 * betaz) * MXphc1 ;
            %tuneFB.maxDeltaTuneZ = 1e-2;

            % Feedback loop setup
            couplingFB.LoopDelay = 3.;    % Period of Feedback loop [seconds], make sure the BPM averaging is correct

            % Maximum allowed coupling variation during 3 seconds
            deltaK = 5e-3;
            couplingFB.EzErrorMax = deltaK * Ex0 ;
            couplingFB.VbeamsizeErrorMax = min(abs((sqrt(K * Ex0 * betaz) - sqrt((K - deltaK) * Ex0 * betaz)) * MXphc1),...
                abs((sqrt(K * Ex0 * betaz) - sqrt((K + deltaK) * Ex0 * betaz)) * MXphc1))
            %15e-6 ; %sqrt(deltaK * Ex0 * betaz) * MXphc1 ;

            % couplingFB.factor to apply for the correction ; 1 means full correction
            couplingFB.fact =  1.2; % 1 ; % 0.3;
            %couplingFB.fact =  1; % 1 ; % 0.3; % modif 1 paquet
            
            % Current trheshold for starting the feedback
            couplingFB.DCCTMIN = DCCTMIN;         

        else % For orbit correction Configuration
            couplingFB = get(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata');
            answer = inputdlg({'Golden Emittance V' },'DIALOG BOX',1,{num2str(couplingFB.Golden.Ez)});
            %%%%answer = inputdlg({'Golden coupling'},'DIALOG BOX',1,{'0.01'}) % revenir temporaire
            if isempty(answer)
                return
            end
            Ez = str2num(answer{1});
            %tunez = str2num(answer{2});

            if Ez > 0 && Ez < 500e-12  % entre 0 et 500 pmrad soit entre K=0 et K= 16%   % && tunez > 0 && tunez < 0.5
                couplingFB.Golden.Ez = Ez;
                couplingFB.Golden.Vbeamsize = sqrt(Ez * betaz) * MXphc1 ;
            else
                warndlg('Wrong values: you must have 0 < Ez < 500 pmrad')
                return;
            end
            
  
            
        end

        
        set(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata', couplingFB);

        strdata = sprintf('Golden Emittance V=%5.1f pmrad        ',couplingFB.Golden.Ez*1e12);
        set(findobj(gcbf,'Tag','couplingFBguiGoldencoupling'),'String', strdata);

        couplingFB = get(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata');
        strdata = sprintf('Min Delta Ez=%2.1f  pmrad  ', couplingFB.minDeltaEz*1e12);
        set(findobj(gcbf,'Tag','couplingFBguiMinDnu'),'String', strdata);
% revenir

        strdata = sprintf('Max Delta Ez=%2.1f pmrad   ', couplingFB.maxDeltaEz*1e12 );
        set(findobj(gcbf,'Tag','couplingFBguiMaxDnu'),'String', strdata);


        strdata = sprintf('LoopDelay=%d s   EzErrorMax=%2.1f pmrad', couplingFB.LoopDelay, couplingFB.EzErrorMax*1e12);
        set(findobj(gcbf,'Tag','couplingFBguicouplingFB.LoopDelay'),'String', strdata);


        strdata = sprintf('Factor of correction: %d %%  Min stored current: %d mA', couplingFB.fact*100, couplingFB.DCCTMIN);
        set(findobj(gcbf,'Tag','couplingFBguicouplingFB.factor'),'String', strdata);


        %% StartcouplingFB
    case 'StartcouplingFB'

        % Check if not already running
        if TESTFLAG
            STATE = 0;
        else
            STATE = check4couplingfb(devLockName);
        end
        if STATE % Feedback already running
            fprintf('CouplingFB:StartCouplingeFB: FB stopped (already running) at %s\n', datestr(clock));
            return;
        end

%         % Check if plane(s) to correct is/are selected
%         if ~get(findobj(gcbf,'Tag','couplingFBguiCheckboxHcorrection'),'Value')  && ...
%                 ~get(findobj(gcbf,'Tag','couplingFBguiCheckboxVcorrection'),'Value')
%             warndlg('couplingFBgui:StartcouplingFB: No plane selected, action aborted')
%             fprintf('%s\n couplingFBgui:StartcouplingFB: No plane selected, action aborted\n', datestr(clock))
%             return;
%         end


        % Confirmation dialogbox
        StartFlag = questdlg('Start coupling Feedback?', 'coupling Feedback','Yes','No','No');

        if strcmp(StartFlag,'No')
            fprintf('   %s \n', datestr(clock));
            fprintf('   ***************************\n');
            fprintf('   **  coupling  Feedback Exit  **\n');
            fprintf('   ***************************\n\n');
            pause(0);
            return
        end

        % Disable buttons in GUI
        set(0,'showhiddenhandles','on');
        %set(findobj(gcf,'Tag','couplingFBguiButtonOrbitCorrectionSetupcouplingFB'),'Enable','on'); A TESTER  DE SUPPRIMER
        set(findobj(gcf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Enable','off');
        set(findobj(gcf,'Tag','couplingFBguiStartcouplingFB'),'Enable','off');
        set(findobj(gcf,'Tag','couplingFBguiStopcouplingFB'),'Enable','on');
%         set(findobj(gcf,'Tag','couplingFBguiCheckboxHcorrection'),'Enable','off');
%         set(findobj(gcf,'Tag','couplingFBguiCheckboxVcorrection'),'Enable','off');
        set(findobj(gcf,'Tag','couplingFBguiClose'),'Enable','off');
        pause(0);

        set(findobj(gcbf,'Tag','couplingFBguiStatus'),'BackgroundColor', [0 1 0])
        couplingFBgui('UpdateStatuscouplingFB');

        couplingFB = get(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata');
        % Lock service
        %if get(findobj(gcbf,'Tag','couplingFBguiCheckboxcorrection'),'Value')
        if TESTFLAG
        else
            couplingFB.LockTag  = tango_command_inout2(devLockName,'Lock', 'iscouplingfbrunning');
        end
        %end

        set(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata', couplingFB);
        couplingFBgui('UpdateStatuscouplingFB');

        coupling_FEEDBACK_STOP_FLAG = 0;
        setappdata(findobj(gcbf,'Tag','couplingFBguiFig1'),'coupling_FEEDBACK_STOP_FLAG', coupling_FEEDBACK_STOP_FLAG)

        % Number of error before stopping
        stallError = 0;
        stallErrorMax = 50; % Maximum error permissible
        % Init 
        couplingFB = get(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata');
        
        % load QT List
        QTList = couplingFB.QTList ;
        IndexQToff = couplingFB.IndexQToff ;
        
        for i=1:Nbuffer
            Vbeamsize_old(i)  = couplingFB.Golden.Vbeamsize;
        end
        
        while coupling_FEEDBACK_STOP_FLAG == 0 % infinite loop
            try
                t00 = gettime;
                fprintf('Iteration time %s\n',datestr(clock));
                
                if iscontrolroom% test fuite mémoire : 2 fevrier 2015-Maj_13-03-2015
                    memoire=java.lang.Runtime.getRuntime.freeMemory;
                    disp(['freeMemory: ',int2str(memoire)]);
                    tango_write_attribute('ANS/FC/PUB-APP-MONITOR', 'MEM_FB_COUPLING', int32(memoire));
                    if (tango_error == -1)
                        tango_print_error_stack;
                    end
                end
                % Check if GUI has been closed
                if isempty(gcbf)
                    coupling_FEEDBACK_STOP_FLAG = 1;
                    lasterr('coupling GUI DISAPPEARED!');
                    error('coupling GUI DISAPPEARED!');
                end
                
                couplingFB = get(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata');
                
                %% main loop
                % read coupling from device emit
                if TESTFLAG
                    dcctvalue = 402.12 ; % courant factice
                else
                    dcctvalue = getdcct(Mode) ; %
                end
                if dcctvalue < couplingFB.DCCTMIN     % Don't Feedback if the current is too small
                    coupling_FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         coupling Feedback stopped due to low beam current (<%d mA)\n',datestr(now), couplingFB.DCCTMIN);
                    strgMessage = 'Fideubaque du couplage arraitai car le courant est trop bas';
                    tango_giveInformationMessage( strgMessage);
                    warndlg('couplingFB : arrété car courant trop bas');
                    couplingFBgui('StopcouplingFB');
                    break;
                else
                    if TESTFLAG
%                         E = modelemit;
%                         fprintf('Couplage =  %4.2f % \n',100*E(2)/E(1) )
%                         coupling = E(2)/E(1) ;
                        Vbeamsize =  36.078e-6 + 1e-6 *randn(1,1);% ; 36.078e-6 + 10e-6 ;%*randn(1,1); ; 
                        Iqt=getam('QT',QTList);
                        figure(10);hold on ; plot(Iqt,'Color',nxtcolor)
                    else
                        Vbeamsize  = 1e-6 * readattribute([devImA '/YProjFitSigma']); % taille verticale exprim�e en m
                    end
                end

                % double reading for getting of parasite peaks
                pause(MeasureWaittime_1);

                %coupling2  = getcouplingFBT; % attention
                if TESTFLAG
                        Vbeamsize2 = 35e-6 ; % 35e-6 ;
                else
                    Vbeamsize2  = 1e-6 * readattribute([devImA '/YProjFitSigma']); % taille verticale exprim�e en m
                end
                
                ErrorVbeamsize = Vbeamsize2-Vbeamsize;
                if max(abs(ErrorVbeamsize)) > couplingFB.VbeamsizeErrorMax % redo measurement
                    fprintf('StallError #%d\n', stallError);
                    stallError = stallError + 1;
                    pause(MeasureWaittime_1);
                    
                    if TESTFLAG
                        Vbeamsize3 = 36.0e-6 + 1e-6 *randn(1,1);% ; % 34e-6 ;
                    else
                        Vbeamsize3  = 1e-6 * readattribute([devImA '/YProjFitSigma']); % taille verticale exprim�e en m
                    end
                    ErrorVbeamsize = Vbeamsize3-Vbeamsize2;
                    if max(abs(ErrorVbeamsize)) > couplingFB.VbeamsizeErrorMax %stop FB
                        coupling_FEEDBACK_STOP_FLAG = 1;
                        fprintf('%s         coupling Feedback stopped due to Vertical beamsize oscillation\n',datestr(now));
                        strgMessage = 'Fideubaque du couplage arraitai car oscillations du couplage';
                        tango_giveInformationMessage( strgMessage);
                        str1 = sprintf('couplingFB : arret car oscillations du couplage durant 3 s (max=%5.4f)\n', couplingFB.couplingErrorMax);
                        str2 = sprintf('Vbeamsize(1) = %5.4f Vbeamsize(2) = %5.4f Vbeamsize(3) = %5.4f\n', ...
                            Vbeamsize, Vbeamsize2, Vbeamsize3);
                        warndlg([str1 str2 ]);
                        fprintf([str1 str2 ]);
                        couplingFBgui('StopcouplingFB');
                        pause(GUIWaittime_2)
                        break;
                    else
                        Vbeamsize = Vbeamsize3;
                    end
                end                      
                
                if stallError > stallErrorMax     % Don't Feedback if too much errors
                    coupling_FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         coupling Feedback stopped due stallError Max reached on couplings\n',datestr(now));
                    strgMessage = 'Fideubaque du couplaage arraitai car trop d''erreurs';
                    tango_giveInformationMessage( strgMessage);
                    warndlg(sprintf('couplingFB : trop d''erreurs, %d', stallErrorMax));
                    couplingFBgui('StopcouplingFB');
                    pause(GUIWaittime_2)
                    break;
                end

                % Further more checking on coupling value

                if Vbeamsize==0 || isnan(Vbeamsize)
                    str1 = sprintf('couplingFB:StartcouplingFB: something is wrong with the Vertical beamsize reading\n');
                    str2 = sprintf('couplingFB:StartcouplingFB: FB stopped at %s\n', datestr(clock));
                    fprintf([str1 str2]);
                    warndlg([str1 str2]);
                    strgMessage = 'Arret du fiideubaque du couplaage : problaime de mesure';
                    tango_giveInformationMessage( strgMessage);
                    couplingFBgui('StopcouplingFB');
                    break                
                else
                    deltaVbeamsize = Vbeamsize - couplingFB.Golden.Vbeamsize;
                end


%                 % Zeroing coupling if not selected for correction
%                 if ~get(findobj(gcbf,'Tag','couplingFBguiCheckboxHcorrection'),'Value')
%                     deltacoupling(1) =0;
%                 end

%                 % Zeroing couplingz if not selected for correction
%                 if ~get(findobj(gcbf,'Tag','couplingFBguiCheckboxVcorrection'),'Value')
%                     deltacoupling(2) =0;
%                 end  
% attention dim deltacoupling

                if abs(deltaVbeamsize) > couplingFB.maxDeltaVbeamsize %% && get(findobj(gcbf,'Tag','couplingFBguiCheckboxHcorrection'),'Value')
                    coupling_FEEDBACK_STOP_FLAG = 1;
                    fprintf('couplingFB:StartcouplingFB:%s         coupling Feedback stopped due to too large coupling variations\n',datestr(now));
                     str1 = sprintf('deltaVBeamSize = %5.4f (max: %5.4f) \n', ...
                        deltaVbeamsize, couplingFB.maxDeltaVbeamsize);
                    fprintf(str1);
                    str2 = sprintf('couplingFB:StartcouplingFB: arret Feedback \n car variations du couplage trop importantes\n ');
                    strgMessage = 'Arret du fiiidbaque du couplage : variations trop grandes';
                    tango_giveInformationMessage( strgMessage);
                    warndlg([str2, str1]);
                    couplingFBgui('StopcouplingFB');
                    break;
                    if TESTFLAG
                        dcctvalue = 399.8 ; % courant factice
                    else
                        dcctvalue = getdcct(Mode) ; %
                    end
                    
                elseif dcctvalue < couplingFB.DCCTMIN     % Don't Feedback if the current is too small
                    coupling_FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         coupling Feedback stopped due to low beam current (<%d mA)\n',datestr(now), couplingFB.DCCTMIN);
                    strgMessage = 'Arret du fiideubaque du couplaage : courant trop bas';
                    tango_giveInformationMessage( strgMessage);
                    warndlg('couplingFB;StartcouplingFB: arret Feedback car courant trop bas');
                    couplingFBgui('StopcouplingFB');
                    break;
                else
                    
                    % store the measured value for frozen test at next
                    % iteration %% verifier !!!!  19 juin 2015
                    for i=Nbuffer:-1:2
                        Vbeamsize_old(i) = Vbeamsize_old(i-1);
                    end
                    Vbeamsize_old(1) = Vbeamsize ;
                    %if TESTFLAG
                    fprintf(' %10.8f %10.8f  %10.8f   \n',Vbeamsize_old(1),Vbeamsize_old(2),Vbeamsize_old(3) );
                    %end
                    % Check if coupling reading is frozen then stop FB

                    if Vbeamsize - Vbeamsize_old(Nbuffer) == 0
                        
                        str1 = sprintf('couplingFB:StartcouplingFB: coupling does not change\n');
                        
                        str2 = sprintf('couplingFB:StartcouplingFB: FB stopped at %s\n', datestr(clock));
                        fprintf([str1 str2]);
                        fprintf('Vbeamsize = %f Vbeamsize_old = %f \n', Vbeamsize, Vbeamsize_old(Nbuffer));
                        warndlg([str1 str2]);
                        strgMessage = 'Arret du fiideubaque du couplage : problaime de mesure';
                        tango_giveInformationMessage( strgMessage);
                        couplingFBgui('StopcouplingFB');
                        break
                    else
                        
                        if abs(deltaVbeamsize) < couplingFB.minDeltaVbeamsize
                        fprintf('Skip correction Delta Vbeamsize = abs(%5.4e ) < %5.4e \n', deltaVbeamsize, ...
                            couplingFB.minDeltaVbeamsize)
                    else
                        if DEBUGFLAG
                            % 
                        end                        
%                         % Check if coupling reading is frozen then stop FB
%                         if Vbeamsize - Vbeamsize_old(Nbuffer) == 0
%                            
%                             str1 = sprintf('couplingFB:StartcouplingFB: coupling does not change\n');
%                          
%                             str2 = sprintf('couplingFB:StartcouplingFB: FB stopped at %s\n', datestr(clock));
%                             fprintf([str1 str2]);
%                             fprintf('Vbeamsize = %f Vbeamsize_old = %f \n', Vbeamsize, Vbeamsize_old(Nbuffer));
%                             warndlg([str1 str2]);
%                             strgMessage = 'Arret du fiideubaque du couplage : problaime de mesure';
%                             tango_giveInformationMessage( strgMessage);
%                             couplingFBgui('StopcouplingFB');
%                             break
%                         else
%                             % store the measured value for frozen test at next iteration
%                             for i=Nbuffer:-1:2
%                                 Vbeamsize_old(i) = Vbeamsize_old(i-1);
%                             end 
%                             Vbeamsize_old(1) = Vbeamsize ;
%                             if TESTFLAG
%                                 fprintf(' %f %f  %f   \n',Vbeamsize_old(1),Vbeamsize_old(2),Vbeamsize_old(3) );
%                             end
                            
                            % calcul de la SOLUTION
                            load(couplingFB.FileName_Dz)
                            if deltaVbeamsize<0
                                deltaQTSP = couplingFB.pourcentage*1e-2*Deltaskewquad*couplingFB.fact; % SUPERPOSITION du jeu de QT (augmentation de la taille V)
                            else
                                deltaQTSP = -couplingFB.pourcentage*1e-2*Deltaskewquad*couplingFB.fact; % SUPERPOSITION du jeu de QT (diminution de la taille V)
                            end
                            deltaQTSP(IndexQToff) = [ ] ;
                            %  Check values of skew quadrupoles
                            %  max/min value
                            QTSP = getsp('QT',QTList,Mode);
                            % get max values for the correctors
                            MaxSP = maxsp('QT',QTList);
                            MinSP = minsp('QT',QTList);
                            WarningMaxSP = maxsp('QT',QTList) - 2;
                            WarningMinSP = minsp('QT',QTList) - 2;                           
                            QTSP_next = QTSP + deltaQTSP ;
                            
                            
                            if any(MaxSP - QTSP_next  < 0)
                                QTnum = find(QTSP_next > MaxSP);
                                % message to screen
                                %%%QTList = family2tango('QT','Setpoint');
                                %%%verifier
                                fprintf('**One or more of the QT is at its maximum positive value!! Stopping coupling feedback. \n');
                                fprintf('%s\n',datestr(now));
                                fprintf('**%s is one of the problem correctors.\n', QTList{QTnum});
                                strgMessage = 'Arret du fiideubaque du couplaage : correcteur trop fort';
                                tango_giveInformationMessage( strgMessage);
                                warndlg('couplingFB;StartcouplingFB: arret Feedback car correcteur trop fort');
                                couplingFBgui('StopcouplingFB');
                            end
                            if any(MinSP - QTSP_next  > 0)
                                QTnum = find(QTSP_next < MinSP);
                                % message to screen
                                %%%QTList = family2tango('QT','Setpoint');
                                %%%%%%verifier
                                fprintf('**One or more of the QT is at its maximum negative value!! Stopping coupling feedback. \n');
                                fprintf('%s\n',datestr(now));
                                fprintf('**%s is one of the problem correctors.\n', QTList{QTnum});
                                strgMessage = 'Arret du fiideubaque du couplaage : correcteur trop fort';
                                tango_giveInformationMessage( strgMessage);
                                warndlg('couplingFB;StartcouplingFB: arret Feedback car correcteur trop fort');
                                couplingFBgui('StopcouplingFB');
                            end
                            
                            if any(WarningMaxSP - QTSP_next  < 0)
                                QTnum = find(QTSP_next > WarningMaxSP);
                                % message to screen
                                %%%QTList = family2tango('QT','Setpoint');
                                %%% verifier
                                fprintf('**One or more of the QT is at at a high positive value!! Check the problem. \n');
                                fprintf('%s\n',datestr(now));
                                fprintf('**%s is one of the problem correctors.\n', QTList{QTnum});
                                strgMessage = 'Attention : la valeur des qouaadruupole tournai est trooop grande';
                                tango_giveInformationMessage( strgMessage);
                                %%%%%%% ???? tango_command_inout2(dev/home/production/matlab/matlabML/machine/SOLEIL/StorageRing/couplageSpeakerName,'DevTalk','Attention : la valeur des qouaadruupole tournai est trooop grande');
                            end
                            if any(WarningMinSP - QTSP_next  > 0)
                                QTnum = find(QTSP_next < WarningMinSP);
                                % message to screen
                                %%%QTList = family2tango('QT','Setpoint');
                                %%% verifier
                                fprintf('**One or more of the QT is at a high negative value!! Check the problem. \n');
                                fprintf('%s\n',datestr(now));
                                fprintf('**%s is one of the problem correctors.\n', QTList{QTnum});
                                strgMessage = 'Attention : la valeur des qouaadruupole tournai est trooop grande';
                                tango_giveInformationMessage( strgMessage);
                            end
                            
                            load(couplingFB.FileName_Min)
                            Deltaskewquad(IndexQToff) = [ ] ;
                            Iqtmin = Deltaskewquad;
                            IqtDz = QTSP - Iqtmin;
                            load(couplingFB.FileName_Dz)
                            Deltaskewquad(IndexQToff) = [ ] ;
                            IqtDzTH = Deltaskewquad;
                            fac = IqtDz./IqtDzTH;
                            %% LSN Aout 30 -- Attention parfois  QTSP = Iqtmin pour une
                            %% alim
                            min(fac) 
                            fac_threshold = 0.25; % original
                            if TESTFLAG==-1
                                
                            elseif any(abs(fac)<fac_threshold&abs(IqtDzTH)>0.20),
                              
                                fprintf('**One or more of the QT is too much decreasing !! Stopping coupling feedback. \n');
                                fprintf('%s\n',datestr(now));               
            
                                strgMessage = 'Arret du fiideubaque du couplaage : les correcteurs diminuent trop vite ';
                                tango_giveInformationMessage( strgMessage);
                                
                                warndlg('couplingFB;StartcouplingFB: arret Feedback car les correcteur diminuent trop vite');
                                fprintf('%s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d \n',...
                                    'valeurs actuelles des QT :',QTSP)
                               
                                fprintf('%s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d \n',...
                                    'valeurs actuelles des QT, partie dispersion :',IqtDz)
                                
                                fprintf('%s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d \n',...
                                    'facteur testé qui doit etre > à 0.25 si IqtDz>0.05:',fac)     
                                
                                couplingFBgui('StopcouplingFB');
                            end
                            
                            %%%DeviceList = family2dev('QT');
                            DeviceList =QTList ; % verifier !!
                            
                            %  ACTION !!!
                            %Error = stepsp('QT',deltaQTSP,Mode,-1); % SUPERPOSITION du jeu de QT (augmentation ou diminution de la taille V)
                            Error = stepsp('QT',deltaQTSP,DeviceList,Mode,-1);
                             %AM = getqtgroup; % modification 20 mai 2013 ajout de groupe
                             %setqtgroup(AM+deltaQTSP);
                            
                            
                            if Error~=0 % one power supply fails (OFF, stall)
                                stepsp('QT',-deltaQTSP,DeviceList,Mode); % go back for good power supplies % verifier !!
                                fprintf('**One or more of the Skew Quad power supply encountered a problem !! Stopping coupling feedback. \n');
                                fprintf('%s\n',datestr(now));
                                strgMessage = 'Arret du fiideubaque du couplaage : problaime d''alimentation de qouadrupole touournai';
                                tango_giveInformationMessage( strgMessage);
                                warndlg('couplingFB;StartcouplingFB: arret Feedback car problème d''alimentation');
                                couplingFBgui('StopcouplingFB');
                            end
                            
                                
                        end
                    end
                end

                % Pause until couplingFB.LoopDelay
                if DEBUGFLAG
                    fprintf('Time elapsed between 2 iterations (before pause) is %f s\n', gettime-t00);
                end

                while (gettime-t00) < couplingFB.LoopDelay
                    pause(MeasureWaittime_2); % pause large enough for allowing GUI interaction
                    % Check if GUI has been closed
                    if isempty(gcbf)
                        coupling_FEEDBACK_STOP_FLAG = 1;
                        lasterr('couplingGUI GUI DISAPPEARED!');
                        error('couplingGUI GUI DISAPPEARED!');
                    end
                    %% fast loop to check whether FB loop was asked to be stopped
                    if coupling_FEEDBACK_STOP_FLAG == 0
                        coupling_FEEDBACK_STOP_FLAG = getappdata(findobj(gcbf,'Tag','couplingFBguiFig1'),'coupling_FEEDBACK_STOP_FLAG');
                    end
                end
                couplingFBgui('UpdateStatuscouplingFB');

                % Pause until couplingFB.LoopDelay
                if DEBUGFLAG
                    fprintf('Time elapsed between 2 iterations (after pause) is %f s\n', gettime-t00);
                end
                
                % Maintain lock on FB service
                argin.svalue={'iscouplingfbrunning'};
                if TESTFLAG
                else
                    argin.lvalue=int32(couplingFB.LockTag);
                    tango_command_inout2(devLockName,'MaintainLock', argin);
                end

                % Check if button stop was pressed
                coupling_FEEDBACK_STOP_FLAG = getappdata(findobj(gcbf,'Tag','couplingFBguiFig1'),'coupling_FEEDBACK_STOP_FLAG');

            catch
                dbstack
                fprintf('\n  %s \n',lasterr);
                warndlg('coupling Feedback stopped on fatal error');
                if TESTFLAG
                else
                    strgMessage = 'Erreur fatale, arret du fiideubaque du couplage';
                    tango_giveInformationMessage( strgMessage);
                end
                coupling_FEEDBACK_STOP_FLAG = 1;
                couplingFBgui('StopcouplingFB');
                set(findobj(gcbf,'Tag','couplingFBguiStatus'),'BackgroundColor', [1 0 0])
            end
        end



        %% StopcouplingFB
    case 'StopcouplingFB'

        setappdata(findobj(gcbf,'Tag','couplingFBguiFig1'),'coupling_FEEDBACK_STOP_FLAG', 1);

        couplingFB = get(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata');

        % Unlock coupling service

        %if get(findobj(gcbf,'Tag','couplingFBguiCheckboxHcorrection'),'Value')
            argin.svalue={'iscouplingfbrunning'};
            if TESTFLAG
            else
                argin.lvalue=int32(couplingFB.LockTag);
                tango_command_inout2(devLockName,'Unlock', argin);
            end
       % end

%         if get(findobj(gcbf,'Tag','couplingFBguiCheckboxVcorrection'),'Value')
%             argin.svalue={'iscouplingzfbrunning'};
%             argin.lvalue=int32(couplingFB.ZLockTag);
%             tango_command_inout2(devLockName,'Unlock', argin);
%         end

        set(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata', couplingFB);
        couplingFBgui('UpdateStatuscouplingFB');

        fprintf('   %s \n', datestr(clock));
        fprintf('   ********************************\n');
        fprintf('   **  coupling Feedback Stopped **\n');
        fprintf('   ********************************\n\n');
        pause(GUIWaittime_2);

        % enable buttons in GUI
        set(0,'showhiddenhandles','on');

        set(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Enable','on');
        set(findobj(gcbf,'Tag','couplingFBguiStartcouplingFB'),'Enable','on');
        set(findobj(gcbf,'Tag','couplingFBguiStopcouplingFB'),'Enable','off');
%         set(findobj(gcbf,'Tag','couplingFBguiCheckboxHcorrection'),'Enable','on');
%         set(findobj(gcbf,'Tag','couplingFBguiCheckboxVcorrection'),'Enable','on');
        set(findobj(gcbf,'Tag','couplingFBguiClose'),'Enable','on');
        pause(0);

    otherwise
        fprintf('   Unknown action name: %s.\n', action);

end

%% Check status of coupling feedback
function STATE = check4couplingfb(devLockName)

% reflechir s'il faut un test �quivalent � Q7 et Q9 online
%if strcmp(getmode('Q7'),'Online') && strcmp(getmode('Q9'),'Online')
%look for already running feedback loops
TESTFLAG=0;
STATE = 0;
if TESTFLAG
    iscouplingFBRunning = 0; % revenir temporaire
else
    iscouplingFBRunning = readattribute([devLockName, '/iscouplingfbrunning']);
end
if iscouplingFBRunning
    warning('coupling FB is already running. Stop other application first!')
    warndlg('coupling FB is already running. Stop other application first!')
    STATE = 1;
end

%end


% Write database property % attention
function write_fbcoupling_property (prop_name, prop_val)
    db = tango_get_dbname; % Get database
    cmd_name = 'DbPutProperty';
    cmd_arg  = {'FBcoupling', '1', prop_name, '1', num2str(prop_val)};
    tango_command_inout2(db, cmd_name, cmd_arg);

   
% Read database property     % attention
function pv = read_fbcoupling_property(prop_name)
    db = tango_get_dbname;  % Get database
    cmd_name = 'DbGetProperty';
    cmd_arg  = {'FBcoupling', prop_name};
    cmd_res = tango_command_inout2(db, cmd_name, cmd_arg);
    pv = str2double(cmd_res(5));
