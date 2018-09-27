function orbitcontrol(action, Input2, Input3)
%ORBITCONTROL - GUI for orbit correction and SOFB
%
%  INPUTS
%  None to launch the programme
%  1. action - Callback to execute
%  2. Input2 - First argument for callback function
%  3. Input3 - First argument for callback function
%
%  OUPUTS
%  None
%
%  NOTES
%  1. Settings for SOFB and manual orbit correction are often different
%  2. Manual Correction : 4 iterations are done in a row
%
%  See Also setorbit

% TODO
% look for marker TEST LAURENT MASTERCLOCK KO, SOFB

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
%#function lat_nano_155_229_122BPM_bxSDL01_09_11m

%
%  Written by Laurent S. Nadolski (inspired by ALS srcontrol programme)
%  28 September 2009. Retry flag added for avoiding direct SOFB stop if communication issue with MasterClock device
%  TODO
%  Weight edition ?
%  HWarnNum, VwarnNum
%  publisher SOFB as a global variable in the function
%  Add Flag for FB interaction


% FLAG for interaction between FOFB and SOFB
FB.UPDATE_FOFB = 0; % to be replaced by FOFB.SOFBandFOFB

devFOFBManager = 'ANS/DG/FOFB-MANAGER';

XBPMFlag = 0;

% Check if the AO exists
checkforao;
devSpeakerName = getfamilydata('TANGO', 'TEXTTALKERS');
devLockName = getfamilydata('TANGO', 'SERVICELOCK');

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
BPMxFamily = gethbpmfamily;

if XBPMFlag
    BPMyFamily = 'PBPMz';
else
    BPMyFamily = getvbpmfamily;
end

% Corrector Families
HCMFamily  = gethcmfamily;
VCMFamily  = getvcmfamily;

% Minimum stored current to allow correction
%DCCTMIN = 0.001; % mA 


%%%%%%%%%%%%%%%%
%% Main Program
%%%%%%%%%%%%%%%%

switch(action)
    %% StopOrbitFeedback
    case 'StopOrbitFeedback'
        
        setappdata(findobj(gcbf,'Tag','ORBITCTRLFig1'),'FEEDBACK_STOP_FLAG', 1);
        set(findobj(gcbf,'Tag','ORBITCTRLStaticTextInformation'),'String','SOFB STOP');
        pause(0);
        
        %% Initialize
    case 'Initialize'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % GUI  CONSTRUCTION
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ButtonWidth   = 200;
        ButtonHeight  = 25;
        
        Offset1     = 3*(ButtonHeight+3);            % Frame around Text information
        Offset2     = Offset1 + 2*(ButtonHeight+3);  % Frame around SOFB
        Offset3     = Offset2 + 11*(ButtonHeight+3); % Manual Orbit
        FigWidth    = ButtonWidth + 6;               % Figure width
        FigHeight   = Offset3 + 5.5*(ButtonHeight+3);% Figure heigth
        ButtonWidth = 200-6;
        
        % Change figure position
        set(0,'Units','pixels');
        p = get(0,'screensize');
        
        orbfig = findobj(allchild(0),'tag','ORBITCTRLFig1');
        
        if ~isempty(orbfig)
            return; % IHM already exists
        end
        
        h0 = figure( ...
            'Color',[0.1 0.1 1], ...
            'HandleVisibility','Off', ...
            'Interruptible', 'on', ...
            'MenuBar','none', ...
            'Name','SOLEIL ORBIT CONTROL', ...
            'NumberTitle','off', ...
            'Units','pixels', ...
            'Position',[30 p(4)-FigHeight-40 FigWidth FigHeight], ...
            'Resize','off', ...
            'HitTest','off', ...
            'IntegerHandle', 'off', ...
            'Tag','ORBITCTRLFig1');
        
        % Frame Box I
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ListboxTop',0, ...
            'Position',[3 Offset3 ButtonWidth+6 4.5*ButtonHeight+25], ...
            'Style','frame');
        
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[6 3 + 4*(ButtonHeight+3)+Offset3  ButtonWidth .6*ButtonHeight], ...
            'String','Manual Orbit Correction', ...
            'Style','text');
        
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3 + 3*(ButtonHeight+3) + Offset3 ButtonWidth-32 .8*ButtonHeight], ...
            'String','H-plane', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','ORBITCTRLCheckboxHcorrection');
        
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3+2*(ButtonHeight+3)+Offset3 ButtonWidth-32 .8*ButtonHeight], ...
            'String','V-plane', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','ORBITCTRLCheckboxVcorrection');
        
        uicontrol('Parent',h0, ...
            'Callback','orbitcontrol(''OrbitCorrection'');', ...
            'Interruptible','Off', ...
            'Enable','On', ...
            'Position',[6 3+1*(ButtonHeight+3)+Offset3 ButtonWidth ButtonHeight], ...
            'String','Correct Orbit', ...
            'Tag','ORBITCTRLButtonOrbitCorrection');
        
        uicontrol('Parent',h0, ...
            'CreateFcn','orbitcontrol(''OrbitCorrectionSetup'',1);', ...
            'callback','orbitcontrol(''OrbitCorrectionSetup'',0);', ...
            'Enable','on', ...
            'Interruptible', 'off', ...
            'Position',[6 3+Offset3 ButtonWidth 0.8*ButtonHeight], ...
            'String','Edit BPM, CM Lists', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','ORBITCTRLButtonOrbitCorrectionSetup');
        
        uicontrol('Parent',h0, ...
            'callback','orbitcontrol(''InteractionMode'',0);', ...
            'BackgroundColor',[1 0 0], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3 + Offset3 - ButtonHeight ButtonWidth-32 .8*ButtonHeight], ...
            'String','SOFB + FOFB interaction', ...
            'Style','checkbox', ...
            'Value',0,...
            'Tag','ORBITCTRLCheckboxInteractionMode');
        
        
        % Frame Box II
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ListboxTop',0, ...
            'Position',[3 Offset2 ButtonWidth+6 11*ButtonHeight+5], ...
            'Style','frame');
        
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[6 3+9*(ButtonHeight+3)+ Offset2 ButtonWidth .55*ButtonHeight], ...
            'String','Orbit Feedback', ...
            'Style','text');
        
           uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[6 3+8.4*(ButtonHeight+3)+ Offset2 ButtonWidth-6 .6*ButtonHeight], ...
            'String','Min Current to Start = ', ...
            'Style','text',...
            'Tag','ORBITCTRLStaticTextDCCT');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'callback','orbitcontrol(''SOFBHSelected'');', ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3 + 7.4*(ButtonHeight+3) + Offset2 ButtonWidth-32 .8*ButtonHeight], ...
            'String','H-plane', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','ORBITCTRLCheckboxHSOFB');
        
           uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[6 3+6.9*(ButtonHeight+3)+ Offset2 0.5*ButtonWidth-20 .6*ButtonHeight], ...
            'String','Gain = ', ...
            'Style','text',...
            'Tag','ORBITCTRLStaticTextGainH');

           uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[0.5*ButtonWidth-10 3+6.9*(ButtonHeight+3)+ Offset2 0.5*ButtonWidth-6 .6*ButtonHeight], ...
            'String','Min = ', ...
            'Style','text',...
            'Tag','ORBITCTRLStaticTextThresholdH');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3+6*(ButtonHeight+3)+Offset2 ButtonWidth-32 .8*ButtonHeight], ...
            'String','V-plane', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','ORBITCTRLCheckboxVSOFB');
        
       
            uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[6 3+5.3*(ButtonHeight+3)+ Offset2 0.5*ButtonWidth-20 .8*ButtonHeight], ...
            'String','Gain = ', ...
            'Style','text',...
            'Tag','ORBITCTRLStaticTextGainV');

           uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[0.5*ButtonWidth-10 3+5.3*(ButtonHeight+3)+ Offset2 0.5*ButtonWidth-6 .8*ButtonHeight], ...
            'String','Min = ', ...
            'Style','text',...
            'Tag','ORBITCTRLStaticTextThresholdV');

        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3+5*(ButtonHeight+3)+Offset2 ButtonWidth-32 .8*ButtonHeight], ...
            'String','Fast Orbit Correction (Not implemented)', ...
            'Style','checkbox', ...
            'Value',0,...
            'Visible', 'Off', ...
            'Tag','ORBITCTRLCheckboxFOFB');
        
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3+4.6*(ButtonHeight+3)+Offset2 ButtonWidth-32 .8*ButtonHeight], ...
            'String','Correct RF Frequency', ...
            'Style','checkbox', ...
            'Value',1,...
            'Tag','ORBITCTRLCheckboxRF');
        
          uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[6 3+4*(ButtonHeight+3)+ Offset2 0.5*ButtonWidth-6 .6*ButtonHeight], ...
            'String','Min = ', ...
            'Style','text',...
            'Tag','ORBITCTRLStaticTextMinRF');

             uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'FontSize',10, ...
            'ListboxTop',0, ...
            'Position',[0.5*ButtonWidth+6 3+4*(ButtonHeight+3)+ Offset2 0.5*ButtonWidth-6 .6*ButtonHeight], ...
            'String','Max = ', ...
            'Style','text',...
            'Tag','ORBITCTRLStaticTextMaxRF');

        uicontrol('Parent',h0, ...
            'callback','orbitcontrol(''Feedback'');', ...
            'Enable','on', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[8 3+3*(ButtonHeight+3)+ Offset2 .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','Start FB', ...
            'Value',0, ...
            'Tag','ORBITCTRLPushbuttonStart');
        
        uicontrol('Parent',h0, ...
            'callback','orbitcontrol(''StopOrbitFeedback'');pause(0);', ...
            'Enable','off', ...
            'FontSize',12, ...
            'Interruptible', 'on', ...
            'ListboxTop',0, ...
            'Position',[.5*FigWidth+3 3+3*(ButtonHeight+3)+Offset2 .5*ButtonWidth-6 1.0*ButtonHeight], ...
            'String','Stop FB', ...
            'Value',0, ...
            'Tag','ORBITCTRLPushbuttonStop');
        
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'HorizontalAlignment','left', ...
            'ListboxTop',0, ...
            'Position',[14 3 + 2*(ButtonHeight)+Offset2 ButtonWidth-14 .75*ButtonHeight], ...
            'String','Horizontal RMS = _____ mm', ...
            'Style','text', ...
            'Tag','ORBITCTRLStaticTextHorizontal');
        
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'HorizontalAlignment','left', ...
            'ListboxTop',0, ...
            'Position',[26 3 + 1*(ButtonHeight) + Offset2 ButtonWidth-26 .75*ButtonHeight], ...
            'String','Vertical RMS = _____ mm', ...
            'Style','text', ...
            'Tag','ORBITCTRLStaticTextVertical');
        
        uicontrol('Parent',h0, ...
            'CreateFcn','orbitcontrol(''FeedbackSetup'',1);', ...
            'callback','orbitcontrol(''FeedbackSetup'',0);', ...
            'Enable','on', ...
            'Interruptible', 'off', ...
            'Position',[8 3 + Offset2 ButtonWidth-5 .75*ButtonHeight], ...
            'String','Edit SOFB Setup', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','ORBITCTRLButtonFeedbackSetup');
        
        % Frame Box III
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ListboxTop',0, ...
            'Position',[3 Offset1  ButtonWidth+6 ButtonHeight+12], ...
            'Style','frame');
        
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'HorizontalAlignment','center', ...
            'ListboxTop',0, ...
            'Position',[6 Offset1 + 0.7*ButtonHeight ButtonWidth .7*ButtonHeight], ...
            'String','Experimental Interface', ...
            'Style','text', ...
            'Tag','ORBITCTRLStaticTextHeader');
        
        uicontrol('Parent',h0, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'ForegroundColor','b', ...
            'HorizontalAlignment','center', ...
            'ListboxTop',0, ...
            'Position',[6 3 + Offset1 + .05*ButtonHeight ButtonWidth .7*ButtonHeight], ...
            'String','   Startup', ...
            'Style','text', ...
            'Tag','ORBITCTRLStaticTextInformation');
        
        uicontrol('Parent',h0, ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[26 3 + Offset1 - ButtonHeight ButtonWidth-32 .8*ButtonHeight], ...
            'String','FOFB ready for interaction', ...
            'Style','checkbox', ...
            'Value',0,...
            'Enable','inactive', ...
            'Tag','ORBITCTRLCheckboxFB');
        
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
            'Tag','ORBITCTRLClose');
        
        %setup average data for reading BPMs
        %setfamilydata('gethbpmaverage',BPMxFamily,'Monitor', 'SpecialFunctionGet')
        %setfamilydata('getvbpmaverage',BPMyFamily,'Monitor', 'SpecialFunctionGet')
        
        
        
        %% OrbitCorrectionSetup
    case 'OrbitCorrectionSetup'
        % NOTES setting for SOFB and manual orbit correction are often
        % different
        
        InitFlag = Input2;  % Input #2: if InitFlag, then initialize variables
        
        if InitFlag % just at startup
            
            % Setup orbit correction elements : DEFAULT configuration
            %disp('Orbit correction condition: InitFlag=1 -- debugging message');
            
            % Get list of BPMs et corrector magnets
            [HCMlist VCMlist BPMlist] = getlocallist;
            
            % SVD orbit correction singular values
            %Xivec = 1:57;
            %Yivec = 1:57;
            %modification for additional correctors 
            Xivec = 1:60;
            Yivec = 1:60;
 
            
           % Correction Gain values
            Xgain = 1;
            Ygain = 1;
          
            % Correctors Thresholds
            dhcmStd=0.0003;
            dvcmStd=0.0003;
            
            %RF Thresholds
            deltaRFmax=10e-6;
            deltaRFmin=0.3e-6;

             %DCCT Threshold
            DCCTMIN=0.001;
            
            % initialize RFCorrFlag
            %RFCorrFlag = 'No';
            RFCorrFlag = 'Yes';
            
            % Goal orbit
            Xgoal = getgolden(BPMxFamily, BPMlist, 'numeric');
            Ygoal = getgolden(BPMyFamily, BPMlist, 'numeric');
            
            % BPM weights
            Xweight = ones(size(BPMlist,1), 1);
            Yweight = ones(size(BPMlist,1), 1);
            
            %set weight at 100 for SDL13 BPMS
            [~, idx]  =intersect(BPMlist,[13 1;13 8;13 9;13 2],'rows');
            Xweight(idx) = 100;
            
            [~, idy]  = intersect(BPMlist,[13 1;13 8;13 9;13 2],'rows');
            Yweight(idy) = 100;
                        
            % Correctors weights
            HCMweight = ones(size(HCMlist,1), 1);
            VCMweight = ones(size(VCMlist,1), 1);
            
            % faulty BPM list
            
        else % For orbit correction Configuration
            % Get vector for orbit correction
            FB = get(findobj(gcbf,'Tag','ORBITCTRLButtonOrbitCorrectionSetup'),'Userdata');
            BPMlist = FB.BPMlist;
            HCMlist = FB.HCMlist;
            VCMlist = FB.VCMlist;
            Xivec = FB.Xivec;
            Yivec = FB.Yivec;
            Xgoal = FB.Xgoal;
            Ygoal = FB.Ygoal;
            
            Xgain = FB.Xgain;
            Ygain = FB.Ygain;
          
            dhcmStd=FB.dhcmStd;
            dvcmStd=FB.dvcmStd;
            
            deltaRFmax=FB.deltaRFmax;
            deltaRFmin=FB.deltaRFmin;

            DCCTMIN=FB.DCCTMIN;
            
            RFCorrFlag = FB.RFCorrFlag;
            
            HCMweight = FB.OCSx.CMWeight;
            VCMweight = FB.OCSx.CMWeight;
            Xweight = FB.OCSx.BPMWeight;
            Yweight = FB.OCSy.BPMWeight;
            
            % Add button to change #ivectors, CMs, IDBPMs,
            EditFlag = 0;
            h_fig1 = figure;
            
            while EditFlag ~= 12
                
                % get Sensitivity matrices
                Sx = getrespmat(BPMxFamily, BPMlist, HCMFamily, HCMlist, [], SR_GEV);
                Sy = getrespmat(BPMyFamily, BPMlist, VCMFamily, VCMlist, [], SR_GEV);
                
                % Computes SVD to get singular values
                [Ux, SVx, Vx] = svd(Sx);
                [Uy, SVy, Vy] = svd(Sy);
                
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
                
                EditFlag = menu('Change Parameters?','Singular Values','Correction Gains', 'Correction Thresholds', ...
                    'Horizontal corrector magnet list', 'Horizontal corrector magnet weights', ...
                    'Vertical corrector magnet list', 'Vertical corrector magnet weights',  ...
                    'BPM list', 'BPM weights', 'Golden Orbit value',...
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
                        
                       
                    case 2 % Correction Gain edition

                        % Build up matlab prompt1
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
                            XgainNew = str2num(answer{1});
                            if isempty(XgainNew)
                                disp('   Horizontal gain value cannot be empty.  No change made.');
                            else
                                if (XgainNew<=0)
                                    disp('   Error reading horizontal gain value. No change made.');
                                else
                                    Xgain = XgainNew;
                                    % Display new value on main pannel
                                    set(findobj(gcbf,'Tag','orbitcontrolXgain'),'string',['H-Loop-Gain = ',num2str(Xgain)]);
                                 end
                            end
                            % Vertical plane
                            YgainNew = str2num(answer{2});
                            if isempty(YgainNew)
                                disp('   Vertical gain value cannot be empty.  No change made.');
                            else
                                if (YgainNew<=0) 
                                    disp('   Error reading vertical gain value.  No change made.');
                                else
                                    Ygain = YgainNew;
                                    % Display new value on main pannel
                                    set(findobj(gcbf,'Tag','orbitcontrolgain'),'string',['V-Loop-Gain = ',num2str(Ygain)]);
                                end
                            end
                        end
                        
                    case 3 % Correction Threshold edition

                        % Build up matlab prompt
                        prompt = {'Enter the horizontal corrector threshold value (A):', ...
                            'Enter the vertical corrector threshold value (A):',...
                           'Enter the maximum RF correction value (MHz):', ...
                            'Enter the minimum RF correction value (MHz):',...
                            'Enter the DCCT Threshold value (A):'};
                        % default values
                        def = {sprintf('%d',dhcmStd),sprintf('%d',dvcmStd),sprintf('%d',deltaRFmax),sprintf('%d',deltaRFmin),sprintf('%d',DCCTMIN)};
                        titlestr = 'Change Correction Threshold values';
                        lineNo = 1;

                        answer = inputdlg(prompt,titlestr,lineNo,def);

                        % Answer parsing
                        if ~isempty(answer)
                            % Horizontal plane
                            dhcmStdNew = str2num(answer{1});
                            if isempty(dhcmStdNew)
                                disp('   Horizontal corrector threshold value cannot be empty.  No change made.');
                            else
                                if (dhcmStdNew<=0)
                                    disp('   Error reading horizontalcorrector threshold value. No change made.');
                                else
                                    dhcmStd = dhcmStdNew;
                                end
                            end
                            % Vertical plane
                            dvcmStdNew = str2num(answer{2});
                            if isempty(dvcmStdNew)
                                disp('   Vertical corrector threshold value cannot be empty.  No change made.');
                            else
                                if (dvcmStdNew<=0) 
                                    disp('   Error reading vertical corrector threshold value.  No change made.');
                                else
                                    dvcmStd = dvcmStdNew;
                               end
                            end
                            % RF max
                            deltaRFmaxNew = str2num(answer{3});
                            if isempty( deltaRFmaxNew)
                                disp('   Maximum RF threshold value cannot be empty.  No change made.');
                            else
                                if ( deltaRFmaxNew<=0)
                                    disp('   Error reading Maximum RF threshold value. No change made.');
                                else
                                     deltaRFmax =  deltaRFmaxNew;
                                end
                            end
                           % RF min
                            deltaRFminNew = str2num(answer{4});
                            if isempty( deltaRFminNew)
                                disp('   Minimum RF threshold value cannot be empty.  No change made.');
                            else
                                if ( deltaRFminNew<=0)
                                    disp('   Error reading Minimum RF threshold value. No change made.');
                                else
                                     deltaRFmin =  deltaRFminNew;
                                end
                            end
                          % DCCT min
                            DCCTMINNew = str2num(answer{5});
                            if isempty( DCCTMINNew)
                                disp('   Minimum DCCT threshold value cannot be empty.  No change made.');
                            else
                                if ( DCCTMINNew<=0)
                                    disp('   Error reading Minimum DCCT threshold value. No change made.');
                                else
                                     DCCTMIN =  DCCTMINNew;
                                end
                            end
                          end
                        
                    case 4 % Horizontal corrector list edition
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
                         
                    case 5 % Horizontal corrector weight edition
                        
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
                            fprintf('   Note:  changing the HCM weight for "Orbit Correction" does not change the goal orbit for "Slow Orbit Feedback."\n');
                        end
                        
                    case 6 % Vertical corrector list edition
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
                    case 7 % Vertical corrector weight edition
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
                            fprintf('   Note:  changing the VCM weight for "Orbit Correction" does not change the goal orbit for "Slow Orbit Feedback."\n');
                        end
                        
                    case 8 % BPM list edition
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
                        
                    case 9 % BPM weight edition
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
                            fprintf('   Note:  changing the BPM weight for "Orbit Correction" does not change the goal orbit for "Slow Orbit Feedback."\n');
                        end
                        
                        
                    case 10 % Golden orbit manual edition
                        
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
                        
                    case 11 % RF flag edition
                        RFCorrFlag = questdlg(sprintf('Set RF Frequency during Orbit Correction?'),'RF Frequency','Yes','No', 'No');
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
        OCSx.CM  = getsp(HCMFamily, HCMlist, 'struct','Model');
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
        OCSy.CM  = getsp(VCMFamily, VCMlist, 'struct','Model');
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
        
        % Goal orbit
        FB.Xgoal = OCSx.GoalOrbit;
        FB.Ygoal = OCSy.GoalOrbit;
        
        % Correction Gain
        FB.Xgain = Xgain;
        FB.Ygain = Ygain;
        
        % Correction Thresholds
        FB.dhcmStd = dhcmStd;
        FB.dvcmStd = dvcmStd;
        FB.deltaRFmax=deltaRFmax;
        FB.deltaRFmin=deltaRFmin;       
        FB.DCCTMIN=DCCTMIN;
        
        % RF corrector flag
        FB.RFCorrFlag = RFCorrFlag;
        
        % save FB structure in application
        set(findobj(gcbf,'Tag','ORBITCTRLButtonOrbitCorrectionSetup'),'Userdata',FB);
        
        %% OrbitCorrection
    case 'OrbitCorrection' % Manual Orbit Correction
        
        try
            if strcmp(getmode(BPMxFamily),'Online') && strcmp(getmode(BPMyFamily),'Online')
                %look for already running SOFB
                check4feedbackflag(devLockName, FB.UPDATE_FOFB)
            end
            %setup average data for reading BPMs
            setfamilydata('gethbpmaverage',BPMxFamily,'Monitor', 'SpecialFunctionGet')
            setfamilydata('getvbpmaverage',BPMyFamily,'Monitor', 'SpecialFunctionGet')
            
        catch err
            fprintf('\n  %s \n',err.message);
            fprintf('   %s \n', datestr(clock));
            disp('   ********************************');
            disp('   **  Orbit Correction Aborted  **');
            disp('   ********************************');
            fprintf('\n');
            return
        end
        
        OrbitLoopIter = 4; % a 4 step iteration
        
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
        
        % get Structure for correction
        FB = get(findobj(gcbf,'Tag','ORBITCTRLButtonOrbitCorrectionSetup'),'Userdata');
        DCCTMIN=FB.DCCTMIN;
            
        if getdcct < DCCTMIN    % Don't correct the orbit if the current is too small
            fprintf('   Orbit not corrected due to small current.\n');
            return
        end
        
        
        fprintf('   Starting horizontal and vertical global orbit correction (SVD method).\n');
        
        % Number of steerer magnet correctors
        N_HCM = size(FB.HCMlist,1);
        N_VCM = size(FB.VCMlist,1);
        
        %Compare OrbitCorrection and feedback BPM lists and display a warning if different
        OC_BPMlist = FB.BPMlist
        SOFB = get(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'),'Userdata');
        FB_BPMlist= SOFB.BPMlist;
        if size(OC_BPMlist,1)==size(FB_BPMlist,1)
            for i=1:size(OC_BPMlist,1)
                k = find(OC_BPMlist(i,1) == FB_BPMlist(:,1));
                l = find(OC_BPMlist(i,2) == FB_BPMlist(k,2));
                if isempty(k) || isempty(l)
                   list_comparison(i)=0;
                else
                   list_comparison(i)=1;
                end
            end
            if ~isempty(find(list_comparison==0))
                BPMlist_difference=1;
            else
                BPMlist_difference=0;
            end
        else
            BPMlist_difference=1;
        end
        if BPMlist_difference
            ListFlag = questdlg(sprintf('Manual correction and feedback BPM lists are different.\n Do you want to continue ?'),'Warning','Yes','No','No');
                if strcmp(ListFlag,'No')
                    disp('   ********************************');
                    disp('   **  Orbit Correction Aborted  **');
                    disp('   ********************************');
                    fprintf('\n');
                    return
                else
                   fprintf('** Correction started with different BPM list compared to feedback one** \n'); 
                end
        end

        
        for iloop = 1:OrbitLoopIter,
            try
                %%%%%%%%%%%%%%%%%
                % use the following to get corrector settings in OCS and
                % check everything seems Ok and gives back predicted correction
                %% H-plane checks
                if get(findobj(gcbf,'Tag','ORBITCTRLCheckboxHcorrection'),'Value') == 1
                    HOrbitCorrectionFlag = 1;
                    % Get new corrector values without applying
                    FB.OCSx = setorbit(FB.OCSx,'Nodisplay','Nosetsp');
                    %FB.OCSx = setorbit(FB.OCSx,'Nodisplay','Nosetsp','FitRFHCM0');
                                        
                    HCMSP = getsp(HCMFamily, FB.HCMlist);  % present corrector values
                    HCMSP_next = HCMSP + FB.OCSx.CM.Delta(1:N_HCM); % next corrector values, just slow correctors (no RF)
                    
                    % get max values for the correctors
                    MaxSP = maxsp(HCMFamily,FB.HCMlist);
                    MinSP = minsp(HCMFamily,FB.HCMlist);
                    
                    % Check values
                    if any(MaxSP - HCMSP_next  < 0)
                        HCMnum = find(HCMSP_next > MaxSP);
                        % message to screen
                        fprintf('**One or more of the horizontal correctors is at its maximum positive value!! Stopping orbit feedback. \n');
                        fprintf('%s\n',datestr(now));
                        fprintf('**%s is one of the problem correctors.\n', ...
                            cell2mat(family2tango(HCMFamily,'Setpoint',FB.HCMlist(HCMnum(1),:))));
                        HOrbitCorrectionFlag = 0;
                    end
                    
                    if any(MinSP - HCMSP_next  > 0)
                        HCMnum = find(HCMSP_next < MinSP);
                        % message to screen
                        fprintf('**One or more of the horizontal correctors is at its maximum negative value!! Stopping orbit feedback. \n');
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
                if get(findobj(gcbf,'Tag','ORBITCTRLCheckboxVcorrection'),'Value') ==1
                    FB.OCSy = setorbit(FB.OCSy,'Nodisplay','Nosetsp');
                    VOrbitCorrectionFlag = 1;
                    VCMSP = getsp(VCMFamily,FB.VCMlist); % Get corrector values before correction
                    VCMSP_next = VCMSP + FB.OCSy.CM.Delta(1:N_VCM); % New corrector values to be set in
                    
                    MaxSP = maxsp(VCMFamily,FB.VCMlist);
                    MinSP = minsp(VCMFamily,FB.VCMlist);
                    
                    if any(MaxSP - VCMSP_next  < 0)
                        VCMnum = find(VCMSP_next > MaxSP);
                        % message to screen
                        fprintf('**One or more of the vertical correctors is at its maximum positive value!! Stopping orbit feedback. \n');
                        fprintf('%s\n',datestr(now));
                        fprintf('**%s is one of the problem correctors.\n', ...
                            cell2mat(family2tango(VCMFamily,'Setpoint',FB.VCMlist(VCMnum(1),:))));
                    end
                    
                    if any(MinSP - VCMSP_next  > 0)
                        VCMnum = find(VCMSP_next < MinSP);
                        % message to screen
                        fprintf('**One or more of the vertical correctors is at its maximum negative value!! Stopping orbit feedback. \n');
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
                
                %                 if FB.UPDATE_FOFB && 1
                %                     figure;
                %                     subplot(2,1,1)
                %                     plot(getspos('BPMx', FB.OCSx.BPM.DeviceList),  FB.OCSx.BPM.PredictedOrbitDelta)
                %                     grid on;
                %                     ylabel('Delta X (mm)');
                %                     title(sprintf('%s RMS', max(abs(FB.OCSx.CM.Delta))));
                %
                %                     subplot(2,1,2)
                %                     plot(getspos('BPMz', FB.OCSy.BPM.DeviceList),  FB.OCSy.BPM.PredictedOrbitDelta)
                %                     grid on;
                %                     xlabel('S-position (m)')
                %                     ylabel('Delta Z (mm)');
                %                     title(sprintf('%s RMS', max(abs(FB.OCSy.CM.Delta))));
                %                     suptitle('Orbit Predicted')
                %                 end
                
                %% manual correction and interaction with FOFB
                if FB.UPDATE_FOFB
                    %% update reference orbit for FOFB
                    xRefFOFB = getx(FB.OCSx.BPM.DeviceList) + FB.OCSx.BPM.PredictedOrbitDelta;
                    tango_write_attribute2(devFOFBManager, 'xRefOrbit', xRefFOFB');
                    tango_command_inout2(devFOFBManager, 'StartStep04LoadXRefOrbit');
                    fprintf(' New X-Reference orbit updated for FOFB \n')
                    
                    zRefFOFB = getz(FB.OCSy.BPM.DeviceList) + FB.OCSy.BPM.PredictedOrbitDelta;
                    tango_write_attribute2(devFOFBManager, 'zRefOrbit', zRefFOFB');
                    tango_command_inout2(devFOFBManager, 'StartStep05LoadZRefOrbit');
                    fprintf(' New Z-Reference orbit updated for FOFB \n')
                end
                
                
                if (get(findobj(gcbf,'Tag','ORBITCTRLCheckboxHcorrection'),'Value') == 1) && HOrbitCorrectionFlag
                    % Correct horizontal orbit
                    FB.OCSx = setorbit(FB.OCSx,'NoDisplay');
                    %FB.OCSx = setorbit(FB.OCSx,'NoDisplay', 'FitRFHCM0');
                end
                
                if (get(findobj(gcbf,'Tag','ORBITCTRLCheckboxVcorrection'),'Value') == 1) && VOrbitCorrectionFlag
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
                
                % compute new Delta of closed orbit
                x = FB.OCSx.GoalOrbit - Horbit;
                y = FB.OCSy.GoalOrbit - Vorbit;
                
                fprintf('   %d. Horizontal RMS = %.3f mm (absolute %.3f mm)\n', iloop, std(x), std(Horbit));
                fprintf('   %d.   Vertical RMS = %.3f mm (absolute %.3f mm)\n', iloop, std(y), std(Vorbit));
                
                pause(2);
                
            catch err
                if ~isempty(strfind(err.message, 'too large DeltaRF'))
                    fprintf(' use steprf or RF IHM to correct for frequency \n\n');
                    fprintf('line %d:   %s \n',err.stack(end).line, err.message);
                end
                fprintf('   Orbit correction failed due to error condition!\n  Fix the problem, reload the lattice (refreshthering), and try again.  \n\n');
                return
            end
        end
        
        fprintf('   %s \n', datestr(clock));
        fprintf('   *********************************\n');
        fprintf('   **  Orbit Correction Complete  **\n');
        fprintf('   *********************************\n\n');
        
        %setup manager data for reading BPMs
        setfamilydata('gethbpmgroup',BPMxFamily,'Monitor', 'SpecialFunctionGet')
        setfamilydata('getvbpmgroup',BPMyFamily,'Monitor', 'SpecialFunctionGet')
        
        %% FeedbackSetup
    case 'FeedbackSetup' % Slow orbit Feedback (SOFB)
        
        InitFlag = Input2;           % Input #2: if InitFlag, then initialize variables
        
        if InitFlag % Used only at startup
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Edit the following lists to change default configuration of Orbit Correction %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % WARNING CAN BE DIFFERENT FROM THE ORBIT CORRECTION
            % To start with same correctors and Bpms are used as in manual
            % correction
            % Corrector magnets
            
            
            if 1 || FB.UPDATE_FOFB
                [HCMlist VCMlist BPMlist FHCMlist FVCMlist] = getlocallist;
            else
                [HCMlist VCMlist BPMlist] = getlocallist;
            end
            
            % Singular value number
            Xivec = 1:57;
            Yivec = 1:57;
            %modification for additional correctors 
            %Xivec = 1:60;
            %Yivec = 1:60;

            % Correction Gain values
            Xgain = 1;
            Ygain = 1;
            % Display default value on main pannel
            set(findobj(gcbf,'Tag','ORBITCTRLStaticTextGainH'),'string',['Gain = ',num2str(Xgain)]);
            set(findobj(gcbf,'Tag','ORBITCTRLStaticTextGainV'),'string',['Gain = ',num2str(Ygain)]);
          
            % Correctors Thresholds
            dhcmStd=0.0003;
            dvcmStd=0.0003;
            % Display default value on main pannel
            set(findobj(gcbf,'Tag','ORBITCTRLStaticTextThresholdH'),'string',['Min = ',num2str(dhcmStd),' A']);
            set(findobj(gcbf,'Tag','ORBITCTRLStaticTextThresholdV'),'string',['Min = ',num2str(dvcmStd),' A']);
          
            %RF Thresholds
            deltaRFmax=10e-6;
            deltaRFmin=0.3e-6;
            % Display new value on main pannel
            set(findobj(gcbf,'Tag','ORBITCTRLStaticTextMinRF'),'string',['Min = ',num2str(deltaRFmin),' MHz']);
            set(findobj(gcbf,'Tag','ORBITCTRLStaticTextMaxRF'),'string',['Min = ',num2str(deltaRFmax),' MHz']);
            
            %DCCT threshold
            DCCTMIN=0.001;
            % Display new value on main pannel
            set(findobj(gcbf,'Tag','ORBITCTRLStaticTextDCCT'),'string',['Min Current to Start = ',num2str(DCCTMIN),' A']);
           
            % Get goal orbit for SOFB
            Xgoal = getgolden(BPMxFamily, BPMlist);
            Ygoal = getgolden(BPMyFamily, BPMlist);
            
            % BPM weights
            Xweight = ones(size(BPMlist,1), 1);
            Yweight = ones(size(BPMlist,1), 1);
            
            %set weight at 100 for SDL13 BPMS
            [~, idx]  =intersect(BPMlist,[13 1;13 8;13 9;13 2],'rows');
            Xweight(idx) = 100;
            
            [~, idy]  = intersect(BPMlist,[13 1;13 8;13 9;13 2],'rows');
            Yweight(idy) = 100;
             
            % Correctors weights
            HCMweight = ones(size(HCMlist,1), 1);
            VCMweight = ones(size(VCMlist,1), 1);
            
            if 1 || FB.UPDATE_FOFB
                set(findobj(gcbf,'Tag','ORBITCTRLCheckboxFB'), 'BackgroundColor', [0 1 0], 'Value', 1);
            else
                set(findobj(gcbf,'Tag','ORBITCTRLCheckboxFB'), 'BackgroundColor', [0 0 0], 'Value', 0);
            end
            
            if 1 || FB.UPDATE_FOFB
                % Read configuration of FOFB sotred into a file by FOFB gui
                FOFBstruct = makeFOFBstruct;
            end
            
        else % use for SOFB Edition
            
            % Get FB structure
            FB = get(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'),'Userdata');
            
            BPMlist = FB.BPMlist;
            HCMlist = FB.HCMlist;
            VCMlist = FB.VCMlist;
            
            Xivec = FB.Xivec;
            Yivec = FB.Yivec;
            
            Xgoal = FB.Xgoal;
            Ygoal = FB.Ygoal;
          
            Xgain = FB.Xgain;
            Ygain = FB.Ygain;
          
            dhcmStd=FB.dhcmStd;
            dvcmStd=FB.dvcmStd;
            
            deltaRFmax=FB.deltaRFmax;
            deltaRFmin=FB.deltaRFmin;
            
            DCCTMIN=FB.DCCTMIN;
            
            HCMweight = FB.OCSx.CMWeight;
            VCMweight = FB.OCSy.CMWeight;
            Xweight = FB.OCSx.BPMWeight;
            Yweight = FB.OCSy.BPMWeight;
            
            % Add button to change #ivectors, cm
            EditFlag = 0;
            h_fig1 = figure;
            
            while EditFlag ~= 11
                
                % get Sensitivity matrices
                Sx = getrespmat(BPMxFamily, BPMlist, HCMFamily, HCMlist, [], SR_GEV);
                Sy = getrespmat(BPMyFamily, BPMlist, VCMFamily, VCMlist, [], SR_GEV);
                
                % Compute SVD
                [Ux, SVx, Vx] = svd(Sx);
                [Uy, SVy, Vy] = svd(Sy);
                
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
                EditFlag = menu('Change Parameters?','Singular Values',...
                    'Correction Gains', 'Correction Thresholds',...
                    'HCM List', 'HCM weight', ...
                    'VCM List', 'VCM weight', ...
                    'BPM List', 'BPM weight', 'Change the Goal Orbit', 'Return');
                
                % Begin SOFB edition switchyard
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
                        
                        
                    case 2 % Correction Gain edition

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
                            XgainNew = str2num(answer{1});
                            if isempty(XgainNew)
                                disp('   Horizontal gain value cannot be empty.  No change made.');
                            else
                                if (XgainNew<=0)
                                    disp('   Error reading horizontal gain value. No change made.');
                                else
                                    Xgain = XgainNew;
                                    % Display new value on main pannel
                                    set(findobj(gcbf,'Tag','ORBITCTRLStaticTextGainH'),'string',['Gain = ',num2str(Xgain)]);
                                 end
                            end
                            % Vertical plane
                            YgainNew = str2num(answer{2});
                            if isempty(YgainNew)
                                disp('   Vertical gain value cannot be empty.  No change made.');
                            else
                                if (YgainNew<=0) 
                                    disp('   Error reading vertical gain value.  No change made.');
                                else
                                    Ygain = YgainNew;
                                    % Display new value on main pannel
                                    set(findobj(gcbf,'Tag','ORBITCTRLStaticTextGainV'),'string',['Gain = ',num2str(Ygain)]);
                                end
                            end
                        end
                        
                    case 3 % Correction Threshold edition

                        % Build up matlab prompt
                        prompt = {'Enter the horizontal corrector threshold value (A):', ...
                            'Enter the vertical corrector threshold value (A):',...
                           'Enter the maximum RF correction value (MHz):', ...
                            'Enter the minimum RF correction value (MHz):',...
                            'Enter the DCCT threshold value (mA):'};
                        % default values
                        def = {sprintf('%d',dhcmStd),sprintf('%d',dvcmStd),sprintf('%d',deltaRFmax),sprintf('%d',deltaRFmin),sprintf('%d',DCCTMIN)};
                        titlestr = 'Change Correction Threshold values';
                        lineNo = 1;

                        answer = inputdlg(prompt,titlestr,lineNo,def);

                        % Answer parsing
                        if ~isempty(answer)
                            % Horizontal plane
                            dhcmStdNew = str2num(answer{1});
                            if isempty(dhcmStdNew)
                                disp('   Horizontal corrector threshold value cannot be empty.  No change made.');
                            else
                                if (dhcmStdNew<=0)
                                    disp('   Error reading horizontalcorrector threshold value. No change made.');
                                else
                                    dhcmStd = dhcmStdNew;
                                    % Display new value on main pannel
                                    set(findobj(gcbf,'Tag','ORBITCTRLStaticTextThresholdH'),'string',['Min = ',num2str(dhcmStd),' A']);
                                 end
                            end
                            % Vertical plane
                            dvcmStdNew = str2num(answer{2});
                            if isempty(dvcmStdNew)
                                disp('   Vertical corrector threshold value cannot be empty.  No change made.');
                            else
                                if (dvcmStdNew<=0) 
                                    disp('   Error reading vertical corrector threshold value.  No change made.');
                                else
                                    dvcmStd = dvcmStdNew;
                                     % Display new value on main pannel
                                    set(findobj(gcbf,'Tag','ORBITCTRLStaticTextThresholdV'),'string',['Min = ',num2str(dvcmStd),' A']);
                              end
                            end
                            % RF max
                            deltaRFmaxNew = str2num(answer{3});
                            if isempty( deltaRFmaxNew)
                                disp('   Maximum RF threshold value cannot be empty.  No change made.');
                            else
                                if ( deltaRFmaxNew<=0)
                                    disp('   Error reading Maximum RF threshold value. No change made.');
                                else
                                     deltaRFmax =  deltaRFmaxNew;
                                     % Display new value on main pannel
                                    set(findobj(gcbf,'Tag','ORBITCTRLStaticTextMaxRF'),'string',['Max = ',num2str(deltaRFmax),' MHz']);
                               end
                            end
                           % RF min
                            deltaRFminNew = str2num(answer{4});
                            if isempty( deltaRFminNew)
                                disp('   Minimum RF threshold value cannot be empty.  No change made.');
                            else
                                if ( deltaRFminNew<=0)
                                    disp('   Error reading Minimum RF threshold value. No change made.');
                                else
                                     deltaRFmin =  deltaRFminNew;
                                    % Display new value on main pannel
                                    set(findobj(gcbf,'Tag','ORBITCTRLStaticTextMinRF'),'string',['Min = ',num2str(deltaRFmin),' MHz']);
                                 end
                            end
                            % DCCT min
                            DCCTMINNew = str2num(answer{5});
                            if isempty( DCCTMINNew)
                                disp('   Minimum DCCT threshold value cannot be empty.  No change made.');
                            else
                                if ( DCCTMINNew<=0)
                                    disp('   Error reading Minimum DCCT threshold value. No change made.');
                                else
                                     DCCTMIN =  DCCTMINNew;
                                     % Display new value on main pannel
                                    set(findobj(gcbf,'Tag','ORBITCTRLStaticTextDCCT'),'string',['Min Current to Start = ',num2str(DCCTMIN),' mA']);
                                end
                            end
    
                        end
                        
                    case 4 % Horizontal corrector list edition
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
                        
                    case 5 % Horizontal corrector weight edition
                        
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
                        
                    case 6 % Vertical corrector list edition
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
                        
                    case 7 % Vertical corrector weight edition
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
                        
                    case 8 % BPM List edition
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
                        
                        % User edition of the BPM list
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
                        
                    case 9 % BPM weight edition
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
                        
                    case 10 % Goal orbit edition
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
        
        % End of SOFB edition switchyard
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %         Build up SOFB Structures       %
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
        OCSx.CM =  getsp(HCMFamily, HCMlist, 'struct');
        OCSx.GoalOrbit = Xgoal;
        OCSx.NIter = 2;
        OCSx.SVDIndex = Xivec;
        OCSx.IncrementalFlag = 'No';
        OCSx.CMWeight  = HCMweight;
        OCSx.BPMWeight = Xweight;
        OCSx.FitRF = 0;
        
        OCSy.BPM = getz(BPMlist, 'struct');
        OCSy.CM = getsp(VCMFamily, VCMlist, 'struct');
        OCSy.GoalOrbit = Ygoal;
        OCSy.NIter = 2;
        OCSy.SVDIndex = Yivec;
        OCSy.IncrementalFlag = 'No';
        OCSy.CMWeight  = VCMweight;
        OCSy.BPMWeight = Yweight;
        OCSy.FitRF = 0;
        
        % Save SOFB strucutre
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
        
        % Correction Gain
        FB.Xgain = Xgain;
        FB.Ygain = Ygain;
        
        % Correction Thresholds
        FB.dhcmStd = dhcmStd;
        FB.dvcmStd = dvcmStd;
        FB.deltaRFmax=deltaRFmax;
        FB.deltaRFmin=deltaRFmin;
        
        FB.DCCTMIN=DCCTMIN;
        
        % save Feedback struture
        set(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'),'Userdata',FB);
        
        % save configuration data for FOFB into a file!
        DirName = getfamilydata('Directory', 'FOFBdata');
        save(fullfile(DirName, 'SOFBconfiguration'), 'FB');
        
        % Construction of the data set for FOFB part
        %         if FB.UPDATE_FOFB
        %             %FOFBstruct.BPMlist = FBPMlist;
        %             %FOFBstruct.HCMlist = HCMlist;
        %             %FOFBstruct.VCMlist= VCMlist;
        %             %FOFBstruct.Xivec = FXivec;
        %             %FOFBstruct.Yivec = FYivec;
        %             set(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'),'FOFB',FOFB);
        %         end
        %
        
        %% Feedback
    case 'Feedback'
        %FBloopIter = 3; % number of iterations for each loop
        
        FEEDBACK_STOP_FLAG = 0;
        
        % Warning Flag for stale correctors
        HWarnNum = 0;
        VWarnNum = 0;
        
        % Feedback loop setup
        LoopDelay = 10.0;    % Period of feedback loop [seconds], make sure the BPM averaging is correct
       
        FB=get(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'),'Userdata');
        
        % Percentage of correction to apply at each iteration
        %Xgain  = 0.8;
        %Ygain  = 0.8;
        %Xgain  = 1.0;
        %Ygain  = 1.0;
        Xgain = FB.Xgain;  
        Ygain = FB.Ygain; 
  
        % Minimum corrector strength for applying correction
        %dhcmStd = 0.0015/4;
        %dvcmStd = 0.0005/2;
        
        % thresholds for multibunch filling pattern
        %dhcmStd = 0.0001;
        %dvcmStd = 0.0001;
        
        % thresholds for multibunch filling pattern FOFB
        %dhcmStd = 0.0003;
        %dvcmStd = 0.0003;
        dhcmStd = FB.dhcmStd;  
        dvcmStd = FB.dvcmStd; 
  
        
        % thresholds for 8 bunch filling pattern
        %dhcmStd = 0.00; %15/15/10;
        %dvcmStd = 0.00; % 05/5/10;
        
        % Maximum allowed frequency shift during a single correction
        %deltaRFmax = 10e-6; % MHz
        %deltaRFmin = 0.3e-6; % MHz ie 0.1 Hz
        deltaRFmax = FB.deltaRFmax;
        deltaRFmin = FB.deltaRFmin; 
        
        DCCTMIN=FB.DCCTMIN;
        
        % Load lattice set for tune feed forward
        
        set(0,'showhiddenhandles','on');
        BPMxfullList = family2dev('BPMx',0); % included status 0
        BPMyfullList = family2dev('BPMz',0);
        
        try
            
            %setup average data for reading BPMs
            setfamilydata('gethbpmaverage',BPMxFamily,'Monitor', 'SpecialFunctionGet')
            setfamilydata('getvbpmaverage',BPMyFamily,'Monitor', 'SpecialFunctionGet')
            
            fprintf('\n');
            fprintf('   *******************************\n');
            fprintf('   **  Starting Orbit Feedback  **\n');
            fprintf('   *******************************\n');
            fprintf('   %s \n', datestr(clock));
            fprintf('   Note: the Matlab command window will be used to display status information.\n');
            fprintf('         It cannot be used to enter commands during slow orbit feedback.\n');
            
            % Get SOFB Structure
            FB = get(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'),'Userdata');
            if get(findobj(gcbf,'Tag','ORBITCTRLCheckboxRF'),'Value') == 1
                FB.OCSx.FitRF = 1;
            else
                FB.OCSx.FitRF = 0;
            end
            
            % look for already running SOFB
            if strcmp(getmode(BPMxFamily),'Online') && strcmp(getmode(BPMyFamily),'Online')
                check4feedbackflag(devLockName, FB.UPDATE_FOFB);
            end
        catch err
            fprintf('\n  %s \n',err.message);
            fprintf('   %s \n', datestr(clock));
            fprintf('   *************************************************************\n');
            fprintf('   **  Orbit feedback could not start due to error condition  **\n');
            fprintf('   *************************************************************\n\n');
            warndlg('Orbit feedback could not start due to error condition');
            set(0,'showhiddenhandles','off');
            pause(0);
            return
        end
        
        %Compare OrbitCorrection and feedback BPM lists and display a warning if different
        FB_BPMlist = FB.BPMlist
        OC = get(findobj(gcbf,'Tag','ORBITCTRLButtonOrbitCorrectionSetup'),'Userdata');
        OC_BPMlist= OC.BPMlist;
        if size(OC_BPMlist,1)==size(FB_BPMlist,1)
            for i=1:size(OC_BPMlist,1)
                k = find(OC_BPMlist(i,1) == FB_BPMlist(:,1));
                l = find(OC_BPMlist(i,2) == FB_BPMlist(k,2));
                if isempty(k) || isempty(l)
                   list_comparison(i)=0;
                else
                   list_comparison(i)=1;
                end
            end
            if ~isempty(find(list_comparison==0))
                BPMlist_difference=1;
            else
                BPMlist_difference=0;
            end
        else
            BPMlist_difference=1;
        end
        if BPMlist_difference
            ListFlag = questdlg(sprintf('Manual correction and feedback BPM lists are different.\n Do you want to continue ?'),'Warning','Yes','No','No');
                if strcmp(ListFlag,'No')
                    disp('   ********************************');
                    disp('   **  Orbit Correction Aborted  **');
                    disp('   ********************************');
                    fprintf('\n');
                    return
                else
                   fprintf('** Correction started with different BPM list compared to manualorbit correction one** \n'); 
                end
        end

        
        % Confirmation dialogbox
        StartFlag = questdlg('Start orbit feedback?', 'Orbit Feedback','Yes','No','No');
        set(findobj(gcbf,'Tag','ORBITCTRLStaticTextInformation'),'String','SOFB Started');
        
        % Retrieve FOFB Data
        if FB.UPDATE_FOFB
            %FOFBstruct = getappdata(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'), 'FOFBstruct');
            FOFBstruct = makeFOFBstruct;
            % test if same BPM in SOFB and FOFB
            % if not. For now error message
            % Later if necessary, set to zero the orbit coming from the reconstruction of FOFB steerer values
            BPMError = 0;
            [iFound iNotFound] = findrowindex(FOFBstruct.BPMlist,FB.BPMlist);
            if isempty(iNotFound)
                [iFound iNotFound] = findrowindex(FB.BPMlist, FOFBstruct.BPMlist);
                if ~isempty(iNotFound)
                    for ik=1:length(iNotFound),
                        fprintf('BPM [%2d %2d] missing in FOFB\n', FB.BPMlist(iNotFound(ik),:))
                    end
                    BPMError = 1;
                end
            else
                for ik=1:length(iNotFound),
                    fprintf('BPM [%2d %2d] missing in SOFB\n', FOFBstruct.BPMlist(iNotFound(ik),:))
                end
                BPMError = 1;
            end
            
            if BPMError
                fprintf('Not same BPM in SOFB anf FOFB. Check configuration first\n');
                fprintf('SOFB not started\n');
                StartFlag = 'No';
            end
            if FOFBstruct.SOFBandFOFB == 0
                fprintf('FOFB not set properly\n');
                fprintf('SOFB not started\n');
                StartFlag = 'No';
            end
        end
        
        if strcmp(StartFlag,'No')
            fprintf('   %s \n', datestr(clock));
            fprintf('   ***************************\n');
            fprintf('   **  Orbit Feedback Exit  **\n');
            fprintf('   ***************************\n\n');
            pause(0);
            return
        end
        
        set(0,'showhiddenhandles','on');
        
        % Display information
        
        if get(findobj(gcbf,'Tag','ORBITCTRLCheckboxHSOFB'),'Value') == 1
            fprintf('   Using %d singular values horizontally.\n', length(FB.Xivec));
        end
        if get(findobj(gcbf,'Tag','ORBITCTRLCheckboxVSOFB'),'Value') == 1
            fprintf('   Using %d singular values vertically.\n',   length(FB.Yivec));
        end
        fprintf('   Starting slow orbit correction every %.1f seconds.\n', LoopDelay);
        
        try
            % Compute residual closed orbit
            x = FB.Xgoal - getx(FB.BPMlist);
            y = FB.Ygoal - getz(FB.BPMlist);
            
            %STDx = norm(x)/sqrt(length(x));
            %STDy = norm(y)/sqrt(length(y));
            STDx = std(x);
            STDy = std(y);
            
            set(findobj(gcbf,'Tag','ORBITCTRLStaticTextHorizontal'),'String', ...
                sprintf('Horizontal RMS = %.4f mm',STDx),'ForegroundColor',[0 0 0]);
            set(findobj(gcbf,'Tag','ORBITCTRLStaticTextVertical'),'String', ...
                sprintf('Vertical RMS = %.4f mm',STDy),'ForegroundColor',[0 0 0]);
            
            if strcmp(getmode(BPMxFamily),'Online') && strcmp(getmode(BPMyFamily),'Online')
                % Lock  SOFB service
                Locktag  = tango_command_inout2(devLockName,'Lock', 'sofb');
            end
            pause(0);
        catch err
            
            fprintf('\n  %s \n', err.message);
            
            fprintf('   %s \n', datestr(clock));
            fprintf('   *************************************************************\n');
            fprintf('   **  Orbit feedback could not start due to error condition  **\n');
            fprintf('   *************************************************************\n\n');
            warndlg(' Orbit feedback could not start due to error condition ');
            set(0,'showhiddenhandles','off');
            pause(0);
            return
        end
        
        
        % Disable buttons in GUI
        set(0,'showhiddenhandles','on');
        set(findobj(gcbf,'Tag','ORBITCTRLPushbuttonStart'),'Enable','off');
        set(findobj(gcbf,'Tag','ORBITCTRLPushbuttonStop'),'Enable','on');
        set(findobj(gcbf,'Tag','ORBITCTRLButtonOrbitCorrection'),'Enable','off');
        set(findobj(gcbf,'Tag','ORBITCTRLButtonOrbitCorrectionSetup'),'Enable','off');
        set(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'),'Enable','off');
        set(findobj(gcbf,'Tag','ORBITCTRLClose'),'Enable','off');
        set(findobj(gcbf,'Tag','ORBITCTRLCheckboxHSOFB'),'Enable','off');
        set(findobj(gcbf,'Tag','ORBITCTRLCheckboxVSOFB'),'Enable','off');
        set(findobj(gcbf,'Tag','ORBITCTRLCheckboxHcorrection'),'Enable','off');
        set(findobj(gcbf,'Tag','ORBITCTRLCheckboxVcorrection'),'Enable','off');
        set(findobj(gcbf,'Tag','ORBITCTRLCheckboxRF'),'Enable','off');
        set(findobj(gcbf,'Tag','ORBITCTRLCheckboxFOFB'),'Enable','off')
        set(findobj(gcbf,'Tag','ORBITCTRLCheckboxInteractionMode'),'Enable','off')
        pause(0);
        
        
        % Initialize feedback loop
        StartTime = gettime;
        StartErrorTime = gettime;
        
        % Get orbit before SOFB startup
        Xold = getx(FB.BPMlist);
        Yold = getz(FB.BPMlist);
        % For avoiding stall message for BPM: make a pause
        pause(0.2);
        % Stale number
        RF_frequency_stalenum = 0;
        
        % Number of steerer magnet corrector
        N_HCM = size(FB.HCMlist,1);
        N_VCM = size(FB.VCMlist,1);
        
        % Number of RF actuator
        N_RFMO = 1;
        
        %%%%%%%%%%%%%%%%%%%%%%%
        % Start feedback loop %
        %%%%%%%%%%%%%%%%%%%%%%%
        
        setappdata(findobj(gcbf,'Tag','ORBITCTRLFig1'),'FEEDBACK_STOP_FLAG',0);
        
        %first time
        %         if FB.UPDATE_FOFB
        %             %% update reference orbit for FOFB
        %             tempx = getx(FB.OCSx.BPM.DeviceList);
        %             tempz = getz(FB.OCSy.BPM.DeviceList);
        %             xRefFOFB = tempx - OffsetSA_FA.X_offset;
        %             zRefFOFB = tempz - OffsetSA_FA.Z_offset;
        %             % load reference orbit in TANGO
        %             tango_write_attribute2(devFOFBManager, 'xRefOrbit', xRefFOFB');
        %             tango_write_attribute2(devFOFBManager, 'zRefOrbit', zRefFOFB');
        %             % update Libera
        %             tango_command_inout2(devFOFBManager, 'StartStep04LoadXRefOrbit');
        %             tango_command_inout2(devFOFBManager, 'StartStep05LoadZRefOrbit');
        %             fprintf(' A startup Golden orbit updated for FOFB \n')
        %         end
 
 % add an incremental flag to know iteration number
 iteration=1;
        
        while FEEDBACK_STOP_FLAG == 0 % infinite loop
            try
                t00 = gettime;
                fprintf('\nIteration time %s\n',datestr(clock));
                
                % Check if GUI has been closed
                if isempty(gcbf)
                    FEEDBACK_STOP_FLAG = 1;
                    lasterr('SRCONTROL GUI DISAPPEARED!');
                    error('SRCONTROL GUI DISAPPEARED!');
                end
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Horizontal plane "feedback" %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                % Get orbit and check that the BPMs are different from the last update
                Xnew = getx(FB.BPMlist);
                
                if any(isnan(Xnew))
                    FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         Orbit feedback stopped due to bad BPMs\n',datestr(now));
                    BadBPMName = family2tangodev(BPMxFamily, FB.BPMlist(isnan(Xnew),:));
                    for k=1:size(BadBPMName,1),
                        fprintf('Bad Horizontal BPM (Nan) %s\n',BadBPMName{k});
                    end
                    if strcmp(getmode(BPMxFamily),'Online')
                        strgMessage = 'Arret de la correction d''orbite : problème BPM';
                        tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    end
                    warndlg(' Arret de la correction d''orbite : problème BPM ');
                    break;
                end
                
                if getdcct < DCCTMIN     % Don't feedback if the current is too small
                    FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         Orbit feedback stopped due to low beam current (<%d mA)\n',datestr(now), DCCTMIN);
                    if strcmp(getmode(BPMxFamily),'Online')
                        strgMessage = 'Arret de la correction d''orbite : courant trop bas';
                        tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    end
                    warndlg(' Arret de la correction d''orbite : courant trop bas ');
                    break;
                end
                
                x = FB.Xgoal - Xnew;
                STDx = std(x);
                
                if get(findobj(gcbf,'Tag','ORBITCTRLCheckboxHSOFB'),'Value') == 1
                    if any(Xold == Xnew)
                        N_Stale_Data_Points = find((Xold==Xnew)==1);
                        for i = N_Stale_Data_Points'
                            fprintf('   Stale data: BPMx(%2d,%d), feedback step skipped (%s). \n', ...
                                FB.BPMlist(i,1), FB.BPMlist(i,2), datestr(clock));
                        end
                    else
                        if FB.UPDATE_FOFB
                            % recontruction of the orbit from DC part of fast correctors
                            %dxFOFB = gethorbitFOFB;
                            % TODO select only valid BPM and correctors
                            FHCM = getpv('FHCOR' ,'SetpointMean', FOFBstruct.HCMlist);
                            fprintf('Reading FHCOR I = %4.2f A RMS   I = %4.2f A PEAK   I = %4.2f A PEAK\n', ...
                                std(FHCM), mean(FHCM), max(abs(FHCM)));
                            
                            % building orbit from steerer value
                            % Alternative use singular values (to be done if required)
                            FOFBstruct.OCSx.dx = FOFBstruct.OCSx.Rmat*FHCM; % Rmat has only valid BPM and CM
                            
                            % Update Goal orbit  by subtracting the rebuild orbit from FOFB steerers
                            FB.OCSx.GoalOrbit = FB.Xgoal + FOFBstruct.OCSx.dx;
                        end
                        
                        % Computes correction only
                        FB.OCSx = setorbit(FB.OCSx,'Nodisplay','Nosetsp');

                        %case Device Stopped LSN
%                         % if a device is off, NaN is return
%                         if any(isnan(FB.OCSx.CM.Data))
%                             FEEDBACK_STOP_FLAG = 1;
%                             fprintf('A least on horizontal corrector does not work\n');
%                         end
                        %case Device Off
                        % to be continue
                        
                        X = Xgain .* FB.OCSx.CM.Delta;
                        
                        % check for corrector values and next step values, warn or stop FB as necessary
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        HCMSP = getsp(HCMFamily, FB.HCMlist);  % present corrector values
                        HCMSP_next = HCMSP + X(1:N_HCM);       % next corrector values, just slow correctors (no RF)
                        
                        MaxSP = maxsp(HCMFamily,FB.HCMlist);
                        MinSP = minsp(HCMFamily,FB.HCMlist);
                        
                        if any(MaxSP - HCMSP_next  < 0)
                            HCMnum = find(HCMSP_next > MaxSP);
                            % message to screen
                            fprintf('**One or more of the horizontal correctors is at its maximum positive value!! Stopping orbit feedback. \n');
                            fprintf('%s\n',datestr(now));
                            fprintf('**%s is one of the problem correctors.\n', ...
                                cell2mat(family2tango(HCMFamily,'Setpoint',FB.HCMlist(HCMnum(1),:))));
                            if strcmp(getmode(BPMxFamily),'Online')
                                strgMessage = 'Problème de la correction d''orbite';
                                tango_giveInformationMessage(devSpeakerName,  strgMessage);
                            end
                            FEEDBACK_STOP_FLAG = 1;
                        end
                        
                        if any(MinSP - HCMSP_next  > 0)
                            HCMnum = find(HCMSP_next < MinSP);
                            % message to screen
                            fprintf('**One or more of the horizontal correctors is at its maximum negative value!! Stopping orbit feedback. \n');
                            fprintf('%s\n',datestr(now));
                            fprintf('**%s is one of the problem correctors.\n', ...
                                cell2mat(family2tango(HCMFamily,'Setpoint',FB.HCMlist(HCMnum(1),:))));
                            FEEDBACK_STOP_FLAG = 1;
                            if strcmp(getmode(BPMxFamily),'Online')
                                strgMessage = 'Problème de la correction d''orbite';
                                tango_giveInformationMessage(devSpeakerName,  strgMessage);
                            end
                            warndlg('One or more of the horizontal correctors is at its maximum negative value!! Stopping orbit feedback.')
                        end
                        
                        pause(0);
                        
                        if any(HCMSP_next > MaxSP - 1)
                            HCMnum = find(HCMSP_next > MaxSP - 1);
                            for ik = 1:length(HCMnum)
                                HWarnNum = HWarnNum+1;
                                fprintf('**Horizontal correctors %s is above %f! \n', ...
                                    cell2mat(family2tango(HCMFamily,'Setpoint',FB.HCMlist(HCMnum(ik),:))), ...
                                    MaxSP(HCMnum(ik)) - 1);
                            end
                            fprintf('%s\n',datestr(now));
                            fprintf('**The orbit feedback is still working but this problem should be investigated. \n');
                            if strcmp(getmode(BPMxFamily),'Online')
                                strgMessage = 'Problème de la correction d''orbite';
                                tango_giveInformationMessage(devSpeakerName,  strgMessage);
                            end
                        end
                        
                        if any(HCMSP_next < MinSP + 1)
                            HCMnum = find(HCMSP_next < MinSP + 1);
                            for ik = 1:length(HCMnum)
                                HWarnNum = HWarnNum+1;
                                fprintf('**Horizontal correctors %s is below %f! \n', ...
                                    cell2mat(family2tango(HCMFamily,'Setpoint',FB.HCMlist(HCMnum(ik),:))), ...
                                    MinSP(HCMnum(ik)) + 1);
                            end
                            fprintf('%s\n',datestr(now));
                            fprintf('**The orbit feedback is still working but this problem should be investigated. \n');
                            if strcmp(getmode(BPMxFamily),'Online')
                                strgMessage = 'Problème de la correction d''orbite';
                                tango_giveInformationMessage(devSpeakerName,  strgMessage);
                            end
                        end
                        
                        if getdcct < DCCTMIN     % Don't feedback if the current is too small
                            FEEDBACK_STOP_FLAG = 1;
                            fprintf('%s         Orbit feedback stopped due to low beam current (<%d mA)\n',datestr(now), DCCTMIN);
                            if strcmp(getmode(BPMxFamily),'Online')
                                strgMessage = 'Arret de la correction d''orbite : courant trop bas';
                                tango_giveInformationMessage(devSpeakerName,  strgMessage);
                            end
                            warndlg(sprintf('%s         Orbit feedback stopped due to low beam current (<%d mA)\n',datestr(now), DCCTMIN))
                            break;
                        end
                        
                        
                        %% interaction with FOFB
                        % Warning Reference orbit for all BPMs has to be updated
                        if FB.UPDATE_FOFB
                            try
                                isxFOFBRunning = readattribute([devFOFBManager '/xFofbRunning']);
                                FOFBManagerState = readattribute([devFOFBManager, '/State']);
                                %FOFBManagerState = 0 if no error and Feedback running at least in one plane
                            catch err
                                fprintf('UPDATEFOFB  SOFB stopped (H-plane).\n');
                                if strcmp(getmode(BPMxFamily),'Online')
                                    strgMessage = 'Arret de la correction d''orbite : problème TANGO';
                                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                                end
                                FEEDBACK_STOP_FLAG = 1;
                                break;
                            end
                            
                            if isxFOFBRunning && ~FOFBManagerState
                                %% update reference orbit for FOFB
                                tempx = getx(FB.OCSx.BPM.DeviceList) + FB.OCSx.BPM.PredictedOrbitDelta - FOFBstruct.OCSx.dx;
                                
                                
                                alternativeRefOrbitFlag=0;
                                
                                % figure;
                                %  plot(getspos('BPMx'), FB.OCSx.BPM.PredictedOrbitDelta); hold on;
                                % plot(getspos('BPMx'), FOFBstruct.OCSx.dx, 'r')
                                
                                % Keep allvalue for BPM not in the loop
                                FOFBstruct.OCSx.XRefOrbit = tango_read_attribute2(devFOFBManager, 'xRefOrbit');
                                FOFBstruct.OCSx.XRefOrbit = FOFBstruct.OCSx.XRefOrbit.value;
                                
                                % Check out all BPMs in the loop
                                BPMxIdx = findrowindex(FOFBstruct.BPMlist, BPMxfullList);
                                
                                %alternative computation for FOFB ref orbit
                                switch alternativeRefOrbitFlag
                                    case 1
                                        disp('methode 1 de calcul orbite de ref du FOFB')
                                        if iteration>2     
                                            disp('iteration >2 methode 1')
                                            tempx=FOFBstruct.OCSx.XRefOrbit(BPMxIdx)'+FB.OCSx.BPM.PredictedOrbitDelta;
                                        end
                                    case 2
                                         disp('methode 2 de calcul orbite de ref du FOFB')
                                       tempx = FB.OCSx.BPM.Data + FB.OCSx.BPM.PredictedOrbitDelta - FOFBstruct.OCSx.dx; 
                                    otherwise
                                end
                               
                                % Retrieve offsets between FOFB and SOFB
                                FOFBstruct.OCSx.XRefOrbit(BPMxIdx) = tempx;
                                
                                % Chexk delta RF as it is a condition for
                                % FOFB reference update
                                if FB.OCSx.FitRF
                                    deltaRF = Xgain .* FB.OCSx.DeltaRF;
                                else
                                    deltaRF=0;
                                end
                                % update either RF or corrector correction
                                % is required
                                %isupdateFOFB = (N_HCM > 0 && std(X(1:N_HCM)) > dhcmStd) || (FB.OCSx.FitRF && N_RFMO > 0 &&  abs(deltaRF) > deltaRFmin);
                                %isupdateFOFB = (N_HCM > 0 && std(X(1:N_HCM)) > dhcmStd);
                                isupdateFOFB = ((N_HCM > 0) && (std(X(1:N_HCM)) > dhcmStd))  || ((FB.OCSx.FitRF && N_RFMO > 0) &&  (abs(deltaRF) > deltaRFmin));
                                if isupdateFOFB
                                    if strcmp(getmode(BPMxFamily),'Online')
                                        % Update reference orbit in TANGO device server
                                        tango_write_attribute2(devFOFBManager, 'xRefOrbit', FOFBstruct.OCSx.XRefOrbit);
                                        
                                        % load reference orbit on all Liberas
                                        tango_command_inout2(devFOFBManager, 'StartStep04LoadXRefOrbit');
                                        
                                        fprintf(' New X-Reference orbit updated for FOFB \n')
%                                        fprintf(' N_HCM=%f  std=%f   FB.OCSx.FitRF=%f  N_RFMO=%f   deltaRF=%f \n',N_HCM,std(X(1:N_HCM)),FB.OCSx.FitRF,N_RFMO,abs(deltaRF));
                                    end
                                else
                                    fprintf(' No X-Reference update for FOFB \n')
                                end
                                
                            else
                                fprintf('UPDATEFOFB         Orbit feedback stopped. FOFB stopped in H-plane \n');
                                fprintf('FOFBmanagerstate is %d (should be O) H-plane is %d (should be 1: running 0: stopped)\n',FOFBManagerState, isxFOFBRunning);
                                if strcmp(getmode(BPMxFamily),'Online')
                                    strgMessage = 'Arret de la correction d''orbite : plan horizontal';
                                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                                end
                                FEEDBACK_STOP_FLAG = 1;
                                break;
                            end
                        else
                            isupdateFOFB=0;
                        end
                        
                        
                        % Apply new corrector values
 %                       if N_HCM > 0 && std(X(1:N_HCM)) > dhcmStd                     
                        if ((N_HCM > 0 && std(X(1:N_HCM)) > dhcmStd) || isupdateFOFB)
                            fprintf('iteration %f\n', iteration)
                            fprintf('HCOR: I= %5.4f A RMS I = %5.4f A MEAN I = %5.4f A PEAK\n', std(X(1:N_HCM)), mean(X(1:N_HCM)), max(abs((X(1:N_HCM)))));
                            if strcmp(getmode(HCMFamily),'Online')
                                 profibus_sync(HCMFamily); pause(0.2);
                             end
                            stepsp(HCMFamily, X(1:N_HCM), FB.HCMlist, 0);
                             if strcmp(getmode(HCMFamily),'Online')
                                 profibus_unsyncall(HCMFamily);
                             end
                        else
                            fprintf('No horizontal correction  applied, std corrector = %5.4f mA rms < threshold = %5.4f \n', ...
                                std(X(1:N_HCM)),dhcmStd);
                        end
                        
                        % Apply RF correction
                        
                        if FB.OCSx.FitRF
                            deltaRF = Xgain .* FB.OCSx.DeltaRF;
                            if N_RFMO > 0
                                RFfrequency_last = getrf('Retry');
                                
                                % 2012-09-24 force maintain lock
                                % Try RF was once too long during RUN5
                                if strcmp(getmode(BPMxFamily),'Online')
                                    % Maintain lock on SOFB service
                                    argin.svalue={'sofb'};
                                    argin.lvalue=int32(Locktag);
                                    tango_command_inout2(devLockName,'MaintainLock', argin);
                                end
                                % end modif 2012-09-24
                                
                                fprintf('RF frequency shift computed is %5.2f Hz \n', hw2physics('RF','Setpoint', deltaRF));

                                %if abs(deltaRF) > deltaRFmin % MHz
                                if ((abs(deltaRF) > deltaRFmin) || isupdateFOFB) % MHz
                                    if abs(deltaRF) < deltaRFmax % For avoiding too large RF step on orbit
                                        ErrorFlag = steprf(deltaRF, 'Retry'); % Masterclock locked, Retry 3 times
                                        fprintf('RF change applied by %5.2f Hz\n', hw2physics('RF','Setpoint', deltaRF));
                                    else % Apply deltaRFmax only
                                        % In this case, FOFB ref orbit is
                                        % updated according to the full RF
                                        % value -> to be corrected?
                                        warning('RF change too large: %5.1f Hz (max is %5.1f Hz)', ...
                                            hw2physics('RF','Setpoint', deltaRF), hw2physics('RF','Setpoint', deltaRFmax));
                                        ErrorFlag = steprf(deltaRFmax*sign(deltaRF), 'Retry');
                                        fprintf('RF change changed by %5.1f Hz\n', hw2physics('RF','Setpoint', deltaRFmax*sign(deltaRF)));
                                        
                                    end
                                    %affichage du delta X créé par la
                                    %variation de RF
                                    dispOrbitfromDeltaRF=0;
                                    if dispOrbitfromDeltaRF
                                        dispersion = getdisp('BPMx', 'Hardware', 'Struct');
                                        RFCorrIdx=size(FB.OCSx.Smat,2);
                                        dispOrbit=deltaRF.*FB.OCSx.Smat(:,RFCorrIdx);
                                        figure(299)
                                        plot(getspos('BPMx'),dispOrbit);
                                        xlabel('S pos (m)');
                                        ylabel('amplitude(mm)');
                                        title(FB.OCSx.Smat.TimseStamp)
                                    end
                                        
                                    % TEST LAURENT MASTERCLOCK KO, SOFB
                                    % does not stop. This is not normal. To
                                    % be tested with BEAM
                                    if (ErrorFlag == -1)  && strcmp(getmode(BPMxFamily),'Online')
                                        strgMessage = 'Arret de la correction d''orbite : problème RF';
                                        tango_giveInformationMessage(devSpeakerName,  strgMessage);
                                        break;
                                    end
                                    
                                    RFfrequency_now = getrf('Retry');
                                    
                                    % Check for stale RF feedback
                                    
                                    if (RFfrequency_last == RFfrequency_now)
                                        RF_frequency_stalenum = RF_frequency_stalenum + 1;
                                        if RF_frequency_stalenum == 30 % - warn and message if stale for 30 secs
                                            fprintf('**The RF is not responding to orbit feedback changes! \n');
                                            fprintf('%s\n',datestr(now));
                                            fprintf('**The orbit feedback is still working but this problem should be investigated. \n');
                                        end
                                        if rem(RF_frequency_stalenum,120)==0 % - message to screen every 2 minutes
                                            fprintf('**The RF is not responding to orbit feedback changes! (%s)\n',datestr(now));
                                        end
                                    else
                                        RF_frequency_stalenum = 0;
                                    end
                                    
                                    fprintf('RF Done: time = %f \n', gettime-t00);
                                else
                                    fprintf('RF correction skipped\n');
                                end
                            end
                        end
                    end
                    
                    Xold = Xnew;
                end % End horizontal correction
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Vertical plane "feedback" %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                % Get orbit and check that the BPMs are different from the last update
                Ynew = getz(FB.BPMlist);
                
                if any(isnan(Ynew))
                    FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         Orbit feedback stopped due to bad BPMs\n',datestr(now));
                    BadBPMName = family2tangodev(BPMxFamily, FB.BPMlist(isnan(Xnew),:));
                    for k=1:size(BadBPMName,1),
                        fprintf('Bad Vertical BPM %s\n',BadBPMName{k});
                    end
                    if strcmp(getmode(BPMxFamily),'Online')
                        strgMessage = 'Arret de la correction d''orbite : problème BPM';
                        tango_giveInformationMessage(devSpeakerName,  strgMessage);   
                    end
                    break;
                end
                
                if getdcct < DCCTMIN     % Don't feedback if the current is too small
                    FEEDBACK_STOP_FLAG = 1;
                    fprintf('%s         Orbit feedback stopped due to low beam current (< %d mA)\n', datestr(now), DCCTMIN);
                    if strcmp(getmode(BPMxFamily),'Online')
                        strgMessage = 'Arret de la correction d''orbite : courant trop bas';
                        tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    end
                    break;
                end
                
                y = FB.Ygoal - Ynew;
                STDy = norm(y)/sqrt(length(y));
                
                
                if get(findobj(gcbf,'Tag','ORBITCTRLCheckboxVSOFB'),'Value') == 1
                    
                    if any(Yold == Ynew)
                        fprintf('Info: Stale vertical BPM data, feedback step skipped (%s). \n', datestr(clock));
                        N_Stale_Data_Points = find((Yold==Ynew)==1);
                        for i = N_Stale_Data_Points'
                            fprintf('   Stale data: BPMz(%2d,%d), feedback step skipped (%s). \n', ...
                                FB.BPMlist(i,1), FB.BPMlist(i,2), datestr(clock));
                        end
                        
                    else
                        if FB.UPDATE_FOFB
                            %reconstruction of the orbit from DC part of fast correctors
                            %dxFOFB = gethorbitFOFB;
                            % TODO select only valid BPM and correctors
                            FVCM = getpv('FVCOR','SetpointMean', FOFBstruct.VCMlist, 'Online');
                            fprintf('FVCOR I = %4.2f A RMS   I = %4.2f A MEAN   I = %4.2f A PEAK\n', ...
                                std(FVCM), mean(FVCM), max(abs(FVCM)));
                            
                            % building orbit from steerer value
                            % Alternative use singular values (to be done if required)
                            FOFBstruct.OCSy.dz = FOFBstruct.OCSy.Rmat*FVCM; % Rmat has only valid BPM and CM
                            
                            % Update GoalOrbot by sustracting the rebuild orbit from FOFB steerers
                            % SOFB correction
                            FB.OCSy.GoalOrbit =  FB.Ygoal + FOFBstruct.OCSy.dz;
                           
                        end
                        
                        % Compute correction only
                        FB.OCSy = setorbit(FB.OCSy,'Nodisplay','Nosetsp');
                        % set to gains for correction
                        Y = Ygain .* FB.OCSy.CM.Delta;
                        
                        % check for trim values+next step values, warn or stop FB as necessary
                        
                        VCMSP = getsp(VCMFamily,FB.VCMlist); % Get corrector values before correction
                        VCMSP_next = VCMSP + Y(1:N_VCM); % New corrector values to be set in
                        
                        pause(0);
                        
                        if getdcct < DCCTMIN     % Don't feedback if the current is too small
                            fprintf('%s         Orbit feedback stopped due to low beam current (<%d mA)\n',datestr(now), DCCTMIN);
                            if strcmp(getmode(BPMxFamily),'Online')
                                strgMessage = 'Arret de la correction d''orbite : courant trop bas';
                                tango_giveInformationMessage(devSpeakerName,  strgMessage);
                            end
                            FEEDBACK_STOP_FLAG = 1;
                            break;
                        end
                        
                        MaxSP = maxsp(VCMFamily,FB.VCMlist);
                        MinSP = minsp(VCMFamily,FB.VCMlist);
                        
                        if any(MaxSP - VCMSP_next  < 0)
                            VCMnum = find(VCMSP_next > MaxSP);
                            % message to screen
                            fprintf('**One or more of the vertical correctors is at its maximum positive value!! Stopping orbit feedback. \n');
                            fprintf('%s\n',datestr(now));
                            fprintf('**%s is one of the problem correctors.\n', ...
                                cell2mat(family2tango(VCMFamily,'Setpoint',FB.VCMlist(VCMnum(1),:))));
                            FEEDBACK_STOP_FLAG = 1;
                        end
                        
                        if any(MinSP - VCMSP_next  > 0)
                            VCMnum = find(VCMSP_next < MinSP);
                            % message to screen
                            fprintf('**One or more of the vertical correctors is at its maximum negative value!! Stopping orbit feedback. \n');
                            fprintf('%s\n',datestr(now));
                            fprintf('**%s is one of the problem correctors.\n', ...
                                cell2mat(family2tango(VCMFamily,'Setpoint',FB.VCMlist(VCMnum(1),:))));
                            FEEDBACK_STOP_FLAG = 1;
                        end
                        
                        pause(0);
                        
                        if any(VCMSP_next > MaxSP - 1)
                            VCMnum = find(VCMSP_next > MaxSP - 1);
                            for ik = 1:length(VCMnum)
                                VWarnNum = VWarnNum+1;
                                fprintf('**Vertical correctors %s is above %f! \n', ...
                                    cell2mat(family2tango(VCMFamily,'Setpoint',FB.VCMlist(VCMnum(ik),:))), ...
                                    MaxSP(VCMnum(ik)) - 1);
                            end
                            fprintf('%s\n',datestr(now));
                            fprintf('**The orbit feedback is still working but this problem should be investigated. \n');
                        end
                        
                        if any(VCMSP_next < MinSP + 1)
                            VCMnum = find(VCMSP_next < MinSP + 1);
                            for ik = 1:length(VCMnum)
                                VWarnNum = VWarnNum+1;
                                fprintf('**Vertical correctors %s is below %f! \n', ...
                                    cell2mat(family2tango(VCMFamily,'Setpoint',FB.VCMlist(VCMnum(ik),:))), ...
                                    MinSP(VCMnum(ik)) + 1);
                            end
                            fprintf('%s\n',datestr(now));
                            fprintf('**The orbit feedback is still working but this problem should be investigated. \n');
                        end
                        
                        % Apply vertical correction
                        
                        %% interaction with FOFB
                        % Warning Reference orbit for all BPMs has to be updated
                        if FB.UPDATE_FOFB
                            try
                                iszFOFBRunning = readattribute([devFOFBManager '/zFofbRunning']);
                                FOFBManagerState = readattribute([devFOFBManager, '/State']);
                            catch err
                                fprintf('UPDATEFOFB      SOFB stopped.\n');
                                if strcmp(getmode(BPMxFamily),'Online')
                                    strgMessage = 'Arret de la correction d''orbite : problème TANGO';
                                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                                end
                                FEEDBACK_STOP_FLAG = 1;
                                break;
                            end
                            
                            if iszFOFBRunning && ~FOFBManagerState
                                %% update reference orbit for FOFB
                                tempz = getz(FB.OCSy.BPM.DeviceList) + FB.OCSy.BPM.PredictedOrbitDelta - FOFBstruct.OCSy.dz;
                                
                                % figure;
                                %  plot(getspos('BPMz'), FB.OCSy.BPM.PredictedOrbitDelta); hold on;
                                % plot(getspos('BPMz'), FOFBstruct.OCSy.dz, 'r')
                                
                                % Keep allvalue for BPM not in the loop
                                FOFBstruct.OCSy.ZRefOrbit = tango_read_attribute2(devFOFBManager, 'zRefOrbit');
                                FOFBstruct.OCSy.ZRefOrbit = FOFBstruct.OCSy.ZRefOrbit.value;
                                
                                % Change all BPM in the loop
                                BPMyIdx = findrowindex(FOFBstruct.BPMlist, BPMyfullList);
                                
                                % Retrieve offsets between FOFB and SOFB
                                % 21 November Offset disapeared !!!!
                                FOFBstruct.OCSy.ZRefOrbit(BPMyIdx) = tempz;
                                
                                if N_VCM > 0 && std(Y(1:N_VCM)) > dvcmStd
                                    if strcmp(getmode(BPMxFamily),'Online')
                                        fprintf('VCOR: I= %5.4f A RMS I = %5.4f A MEAN I = %5.4f A PEAK\n', ...
                                            std(Y(1:N_VCM)), mean(Y(1:N_VCM)), max(abs((Y(1:N_VCM)))));
                                        
                                        % Update reference orbit in TANGO device server
                                        tango_write_attribute2(devFOFBManager, 'zRefOrbit', FOFBstruct.OCSy.ZRefOrbit);
                                        
                                        % load reference orbit on all Liberas
                                        tango_command_inout2(devFOFBManager, 'StartStep05LoadZRefOrbit');
                                        
                                        fprintf(' New Z-Reference orbit updated for FOFB \n');
                                    end
                                else
                                    fprintf('No Z-Reference update for FOFB \n');
                                end
                                
                            else
                                fprintf('UPDATEFOFB         Orbit feedback stopped. FOFB stopped in V-plane \n');
                                fprintf('FOFBmanagerstate is %d (should be O) V-plane is %d (should be 1: running 0: stopped)\n',FOFBManagerState, iszFOFBRunning);
                                if strcmp(getmode(BPMxFamily),'Online')
                                    strgMessage = 'Arret de la correction d''orbite : plan vertical';
                                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                                end
                                FEEDBACK_STOP_FLAG = 1;
                                break;
                            end
                        end
                        
                        if N_VCM > 0 && std(Y(1:N_VCM)) > dvcmStd
                            fprintf('VCOR: I= %5.4f A RMS I = %5.4f A MEAN I = %5.4f A PEAK\n', std(Y(1:N_VCM)), mean(Y(1:N_VCM)), max(abs((Y(1:N_VCM)))));
                            if strcmp(getmode(VCMFamily),'Online')
                                profibus_sync(VCMFamily); pause(0.2);
                            end
                            stepsp(VCMFamily, Y(1:N_VCM), FB.VCMlist, 0);
                            if strcmp(getmode(VCMFamily),'Online')
                                profibus_unsyncall(VCMFamily);
                            end
                        else
                            fprintf('No vertical correction  applied, std corrector = %5.4f mA rms < threshold = %5.4f \n', ...
                                std(Y(1:N_VCM)),dvcmStd);
                        end
                    end
                end
                
                Yold = Ynew;
                
                % Output info to screen
                set(findobj(gcbf,'Tag','ORBITCTRLStaticTextHorizontal'), ...
                    'String',sprintf('Horizontal RMS = %.4f mm',STDx), ...
                    'ForegroundColor',[0 0 0]);
                set(findobj(gcbf,'Tag','ORBITCTRLStaticTextVertical'), ...
                    'String',sprintf('Vertical RMS = %.4f mm',STDy),...
                    'ForegroundColor',[0 0 0]);
                pause(0);
                
                % Wait for next update time or stop request
                while FEEDBACK_STOP_FLAG == 0 && (gettime-t00) < LoopDelay
                    pause(.1);
                    % Check if GUI has been closed
                    if isempty(gcbf)
                        FEEDBACK_STOP_FLAG = 1;
                        lasterr('SRCONTROL GUI DISAPPEARED!');
                        error('SRCONTROL GUI DISAPPEARED!');
                    end
                    if FEEDBACK_STOP_FLAG == 0
                        FEEDBACK_STOP_FLAG = getappdata(findobj(gcbf,'Tag','ORBITCTRLFig1'),'FEEDBACK_STOP_FLAG');
                    end
                end
                
                StartErrorTime = gettime;
                
                if strcmp(getmode(BPMxFamily),'Online')
                    % Maintain lock on SOFB service
                    argin.svalue={'sofb'};
                    argin.lvalue=int32(Locktag);
                    tango_command_inout2(devLockName,'MaintainLock', argin);
                end
            catch err
                fprintf('\n  %s \n',err.message);
                FEEDBACK_STOP_FLAG = 1;
                if strcmp(getmode(BPMxFamily),'Online')
                    strgMessage = 'Arret de la correction d''orbite : ATTENTION';
                    tango_giveInformationMessage(devSpeakerName,  strgMessage);
                    profibus_unsyncall(HCMFamily); % to be sure that correctors are controllable
                    profibus_unsyncall(VCMFamily); % to be sure that correctors are controllable
                end
            end
            
            % Check whether user asked for stopping SOFB
            if FEEDBACK_STOP_FLAG == 0
                FEEDBACK_STOP_FLAG = getappdata(findobj(gcbf,'Tag','ORBITCTRLFig1'),'FEEDBACK_STOP_FLAG');
            end
            
            iteration=iteration+1;
            
        end  % End of feedback loop
        
        
        % End feedback, reset all parameters
        try
            
            % Enable buttons
            set(findobj(gcbf,'Tag','ORBITCTRLPushbuttonStart'),'Enable','on');
            set(findobj(gcbf,'Tag','ORBITCTRLPushbuttonStop'),'Enable','off');
            set(findobj(gcbf,'Tag','ORBITCTRLButtonOrbitCorrection'),'Enable','on');
            set(findobj(gcbf,'Tag','ORBITCTRLButtonOrbitCorrectionSetup'),'Enable','on');
            set(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'),'Enable','on');
            set(findobj(gcbf,'Tag','ORBITCTRLClose'),'Enable','on');
            set(findobj(gcbf,'Tag','ORBITCTRLCheckboxHSOFB'),'Enable','on');
            set(findobj(gcbf,'Tag','ORBITCTRLCheckboxVSOFB'),'Enable','on');
            set(findobj(gcbf,'Tag','ORBITCTRLCheckboxHcorrection'),'Enable','on');
            set(findobj(gcbf,'Tag','ORBITCTRLCheckboxVcorrection'),'Enable','on');
            set(findobj(gcbf,'Tag','ORBITCTRLCheckboxRF'),'Enable','on');
            set(findobj(gcbf,'Tag','ORBITCTRLCheckboxFOFB'),'Enable','on')
            set(findobj(gcbf,'Tag','ORBITCTRLCheckboxInteractionMode'),'Enable','on')
            set(findobj(gcbf,'Tag','ORBITCTRLStaticTextHorizontal'),'String',sprintf('Horizontal RMS = _____ mm'),'ForegroundColor',[0 0 0]);
            set(findobj(gcbf,'Tag','ORBITCTRLStaticTextVertical'),'String',sprintf('Vertical RMS = _____ mm'),'ForegroundColor',[0 0 0]);
            pause(0);
            
        catch err
            
            % GUI must have been closed
            
        end
        
        fprintf('   %s \n', datestr(clock));
        fprintf('   ******************************\n');
        fprintf('   **  Orbit Feedback Stopped  **\n');
        fprintf('   ******************************\n\n');
        set(0,'showhiddenhandles','off');
        pause(0);
        
        if strcmp(getmode(BPMxFamily),'Online') && strcmp(getmode(BPMyFamily),'Online')
            % Unlock SOFB service
            argin.svalue={'sofb'};
            argin.lvalue=int32(Locktag);
            tango_command_inout2(devLockName,'Unlock', argin);
            %setup average data for reading BPMs
            setfamilydata('gethbpmgroup',BPMxFamily,'Monitor', 'SpecialFunctionGet')
            setfamilydata('getvbpmgroup',BPMyFamily,'Monitor', 'SpecialFunctionGet')
        end
        
        %% InteractionMode
    case 'InteractionMode'
        
        val = get(findobj(gcbf,'Tag','ORBITCTRLCheckboxInteractionMode'),'Value');
        
        FOFBstruct = makeFOFBstruct;
  
%         % Check if both SOFB and FOFB are with or without XBPMs
%         if xor(strcmp(BPMyFamily,'PBPMz'),FOFBstruct.FOFBversionWithXBPM)
%             val = 0;
%             set(findobj(gcbf,'Tag','ORBITCTRLCheckboxInteractionMode'),'Value', val);
%             fprintf('FOFB and SOFB GUI versions are not compatible (XBPM related). Action aborted\n');
%         end
%                
        if FOFBstruct.SOFBandFOFB == 0
            val = 0;
            set(findobj(gcbf,'Tag','ORBITCTRLCheckboxInteractionMode'),'Value', val);
            fprintf('FOFB not set properly. Action aborted\n');
        end
        
        set(findobj(gcbf,'Tag','ORBITCTRLCheckboxFB'), 'Value', FOFBstruct.SOFBandFOFB)
        
        if val % Interaction between feedbacks
            set(findobj(gcbf,'Tag','ORBITCTRLFig1'),'Color', [0.84 0 0.89]);
        else
            set(findobj(gcbf,'Tag','ORBITCTRLFig1'),'Color', [0.1 0.1 1]);
        end
        
        % Load feedback structure
        FB = get(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'),'Userdata');
        
        % Set interaction flag
        FB.UPDATE_FOFB = val;
        
        % Save feedback structure
        set(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'),'Userdata',FB);

        %% SOFB H Selected
    case 'SOFBHSelected'
        %disable RF correction if plane H is not selected
         if get(findobj(gcbf,'Tag','ORBITCTRLCheckboxHSOFB'), 'Value')
            set(findobj(gcbf,'Tag','ORBITCTRLCheckboxRF'),'Enable','on'); 
            set(findobj(gcbf,'Tag','ORBITCTRLCheckboxRF'), 'Value', 1)
        else
           set(findobj(gcbf,'Tag','ORBITCTRLCheckboxRF'),'Enable','off');  
           set(findobj(gcbf,'Tag','ORBITCTRLCheckboxRF'), 'Value', 0)
         end
         
    otherwise
        fprintf('   Unknown action name: %s.\n', action);
        
end

%% getlocallist
function [HCMlist, VCMlist, BPMlist, FHCMlist, FVCMlist] = getlocallist

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit the following lists to change default configuration of Orbit Correction %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%TODO:full list and just remove specific device cf LOCO

%HCMlist = family2dev('HCOR');

HCMlist = [
         1     1
     1     4
     1     7
     2     1
     2     4
     2     5
     2     8
     3     1
     3     4
     3     5
     3     8
     4     1
     4     4
     4     7
     5     1
     5     4
     5     7
     6     1
     6     4
     6     5
     6     8
     7     1
     7     4
     7     5
     7     8
     8     1
     8     4
     8     7
     9     1
     9     4
     9     7
    10     1
    10     4
    10     5
    10     8
    11     1
    11     4
    11     5
    11     8
    12     1
    12     4
    12     6
    12     7
    13     8
    13     9
    13     1
    13     2
    13     4
    13     7
    14     1
    14     4
    14     5
    14     8
    15     1
    15     4
    15     5
    15     8
    16     1
    16     3
    16     7
    ];

VCMlist = family2dev('VCOR');

FHCMlist = family2dev('FHCOR');
FVCMlist = family2dev('FVCOR');

% BPMlist = [
%     1     2
%     1     3
%     1     4
%     1     5
%     1     6
%     1     7
%     2     1
%     2     2
%     2     3
%     2     4
%     2     5
%     2     6
%     2     7
%     2     8
%     3     1
%     3     2
%     3     3
%     3     4
%     3     5
%     3     6
%     3     7
%     3     8
%     4     1
%     4     2
%     4     3
%     4     4
%     4     5
%     4     6
%     4     7
%     5     1
%     5     2
%     5     3
%     5     4
%     5     5
%     5     6
%     5     7
%     6     1
%     6     2
%     6     3
%     6     4
%     6     5
%     6     6
%     6     7
%     6     8
%     7     1
%     7     2
%     7     3
%     7     4
%     7     5
%     7     6
%     7     7
%     7     8
%     8     1
%     8     2
%     8     3
%     8     4
%     8     5
%     8     6
%     8     7
%     9     1
%     9     2
%     9     3
%     9     4
%     9     5
%     9     6
%     9     7
%     10     1
%     10     2
%     10     3
%     10     4
%     10     5
%     10     6
%     10     7
%     10     8
%     11     1
%     11     2
%     11     3
%     11     4
%     11     5
%     11     6
%     11     7
%     11     8
%     12     1
%     12     2
%     12     3
%     12     4
%     12     5
%     12     6
%     12     7
%     13     1
%     13     2
%     13     3
%     13     4
%     13     5
%     13     6
%     13     7
%     14     1
%     14     2
%     14     3
%     14     4
%     14     5
%     14     6
%     14     7
%     14     8
%     15     1
%     15     2
%     15     3
%     15     4
%     15     5
%     15     6
%     15     7
%     15     8
%     16     1
%     16     2
%     16     3
%     16     4
%     16     5
%     16     6
%     16     7
%     1     1
%     ];

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function check4feedbackflag(devLockName,UPDATE_FOFB)

BPMxFamily = 'BPMx';
BPMyFamily = 'BPMz';
devFOFBManager = 'ANS/DG/FOFB-MANAGER';
devRFFBManager = 'ANS/DG/RFFB-MANAGER';

if strcmp(getmode(BPMxFamily),'Online') && strcmp(getmode(BPMyFamily),'Online')
    
    if ~UPDATE_FOFB
        %look for already running FOFB
        xval = readattribute([devFOFBManager '/xFofbRunning']);
        zval = readattribute([devFOFBManager '/zFofbRunning']);
        if xval == 1 || zval == 1
            error('FOFB already running. Stop other application first!')
        end
    end
    
    val = readattribute([devLockName '/rffb']);
    rfval = readattribute([devRFFBManager '/isRunning']);
    if val == 1 || rfval == 1
        error('RF FB already running. Stop other application first!')
    end
    val = readattribute([devLockName '/sofb']);
    if val == 1
        error('SOFB already running. Stop other application first!')
    end
    val = readattribute([devLockName '/dcfb']);
    if val == 1
        error('DC FB already running. Stop other application first!')
    end
end

% make FOFB strucutre
function FOFBstruct = makeFOFBstruct

% Read FOFB configuration from a file
DirName  = getfamilydata('Directory', 'FOFBdata');
FileName = fullfile(DirName, 'FOFBconfiguration');
temp = load(FileName, 'FB');
FOFBstruct = temp.FB;

% Compute Response matrix
RmatFOFB           = getbpmresp('BPMx', FOFBstruct.BPMlist, 'BPMz', FOFBstruct.BPMlist, 'FHCOR', FOFBstruct.OCSx.CM.DeviceList, 'FVCOR', FOFBstruct.OCSy.CM.DeviceList,  [getfamilydata('Directory','OpsData') getfamilydata('OpsData', 'BPMResp4FOFBFile')], 'Struct');

FOFBstruct.OCSx.Rmat     = RmatFOFB(1,1).Data;
FOFBstruct.OCSy.Rmat     = RmatFOFB(2,2).Data;

% Offsets from FA and SA sources
% OffsetSA_FA        = load('/home/operateur/GrpDiagnostics/matlab/FOFB/GUI/golden/offsetSA_FA_02_fevrier_09.mat');
% 
% FOFBstruct.OCSx.OffsetSA_FA = OffsetSA_FA.X_offset; %Becareful need all BPM for FPGA
% FOFBstruct.OCSy.OffsetSA_FA = OffsetSA_FA.Z_offset; %Becareful need all BPM for FPGA

%setappdata(findobj(gcbf,'Tag','ORBITCTRLButtonFeedbackSetup'), 'FOFBstruct',FOFBstruct);
