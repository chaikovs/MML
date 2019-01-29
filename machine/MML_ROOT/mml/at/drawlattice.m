function drawlattice(varargin)
%DRAWLATTICE - Draws the AT lattice to a figure
%
%  INPUTS
%  1. Offset
%  2. Scaling
%  3. hAxes
%
%  Optional input arguments
%  4. DrawID   --Add representation of insertion devices base on idGetGeomParamForUndSoleil.m
%  5. ID_Name  --Add Names of insertion device
%  6. BeamLine_Name  -- Add Names of BeamLines
%  7. DrawRFcav --Add representation of RF Cavity base on getRF_CAV_Infos.m
%
%  EXAMPLES
%  1. standard 
%      drawlattice;
%  2. for add representation of insertion devices
%      drawlattice('DrawID');
%
%  drawlattice(Offset {0}, Scaling {1}, hAxes {gca})
%
%  NOTES
%  The AT index is stored in the Userdata of each symbol.
%
%  See Also drawlattice2d, getRF_CAV_Infos, idGetGeomParamForUndSOLEIL


%
%  Written by Greg Portmann
%  Modified by A. Bence
%
%
% default value if FLAG not set
% need to be set to zero for compatibility with booster, LT1,...
DrawIDFLAG        = 1; 
ID_NameFLAG       = 0;
BeamLine_NameFLAG = 0;
DrawRFcavFLAG     = 1;

if ~strcmp(getsubmachinename,'StorageRing')
    DrawIDFLAG        = 0; 
    ID_NameFLAG       = 0;
    BeamLine_NameFLAG = 0;
    DrawRFcavFLAG     = 0;
end
varargin2     = {};

global THERING

%flatten cellarray if you give all argins in one variable
for i = length(varargin):-1:1    
    if iscell(varargin{i})
        varargin=[varargin{:}];
    end    
end    


for i = length(varargin):-1:1    
    if strcmpi(varargin{i},'DrawID')
        DrawIDFLAG = 1;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NO_DrawID')
        DrawIDFLAG = 0;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];    
    elseif strcmpi(varargin{i},'ID_Name')
        ID_NameFLAG = 1;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NO_ID_Name')
        ID_NameFLAG = 0;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];    
    elseif strcmpi(varargin{i},'BeamLine_Name')
        BeamLine_NameFLAG = 1;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NO_BeamLine_Name')
        BeamLine_NameFLAG = 0;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];     
    elseif strcmpi(varargin{i},'DrawRFcav')
        DrawRFcavFLAG = 1;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NO_DrawRFcav')
        DrawRFcavFLAG = 0;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];        
    end    
end 


if isempty(varargin)
    Offset = 0;
    Scaling = 1;
    hAxes = gca;
else
    Offset = varargin{1};
    if (nargin < 2)
        Scaling = 1;
    else
        Scaling = varargin{2};
    end
    if (nargin < 3)
        hAxes = gca;
    else
        hAxes = varargin{3};
    end
end    



% Minimum icon width in meters
MinIconWidth = .09;

SPositions = findspos(THERING, 1:length(THERING)+1);
L = SPositions(end);
plot(hAxes, [0 L], [0 0]+Offset, 'k');

% Remember the hold state then turn hold on
HoldState = ishold(hAxes);
hold(hAxes, 'on');


ATIndexHCM = family2atindex(gethcmfamily);
ATIndexVCM = family2atindex(getvcmfamily);


% Make default icons for elements of different physical types
for i = 1:length(THERING)
    NumberOfFinds = 0;
    
    SPos = SPositions(i);
    if isfield(THERING{i},'BendingAngle') && THERING{i}.BendingAngle
        % make icons for bending magnets
        NumberOfFinds = NumberOfFinds + 1;
        IconHeight = .3;
        IconColor = [1 1 0];
        IconWidth = THERING{i}.Length;
        if IconWidth < MinIconWidth % meters
            IconWidth = MinIconWidth;
            SPos = SPos - IconWidth/2 + THERING{i}.Length/2;
        end
        vx = [SPos SPos+IconWidth SPos+IconWidth SPos];
        vy = [IconHeight IconHeight -IconHeight -IconHeight];
        h = patch(vx, Scaling*vy+Offset, IconColor,'LineStyle','-', 'Parent',hAxes);
        set(h, 'UserData', i);

        %if IconWidth < .1 % meters
        %    set(h, 'EdgeColor', IconColor);
        %end

    elseif isfield(THERING{i},'K') && THERING{i}.K
        % Quadrupole
        NumberOfFinds = NumberOfFinds + 1;
       if THERING{i}.K >= 0
            % Focusing quadrupole           
            IconHeight = .8;
            IconColor = [1 0 0];
            IconWidth = THERING{i}.Length;
            if IconWidth < MinIconWidth % meters
                IconWidth = MinIconWidth;
                SPos = SPos - IconWidth/2 + THERING{i}.Length/2;
            end
            vx = [SPos SPos+IconWidth/2  SPos+IconWidth SPos+IconWidth/2 SPos];
            vy = [0          IconHeight               0      -IconHeight    0];
        else
            % Defocusing quadrupole
            IconHeight = .7;
            IconColor = [0 0 1];
            IconWidth = THERING{i}.Length;
            if IconWidth < MinIconWidth % meters
                % Center about starting point
                IconWidth = MinIconWidth;
                SPos = SPos - IconWidth/2 + THERING{i}.Length/2;
            end
            vx = [SPos+.4*IconWidth    SPos    SPos+IconWidth  SPos+.6*IconWidth  SPos+IconWidth    SPos      SPos+.4*IconWidth];
            vy = [     0            IconHeight   IconHeight          0              -IconHeight  -IconHeight    0];
        end
        h = patch(vx, Scaling*vy+Offset, IconColor,'LineStyle','-', 'Parent',hAxes);
        set(h, 'UserData', i);
        %if IconWidth < .1 % meters
        %    set(h, 'EdgeColor', IconColor);
        %end

    elseif isfield(THERING{i},'PolynomB') && length(THERING{i}.PolynomB)>2 && (THERING{i}.PolynomB(3) || any(strcmpi(THERING{i}.FamName,{'SF','SFF','SD','SDD'})))
        % Sextupole
        NumberOfFinds = NumberOfFinds + 1;
        if THERING{i}.PolynomB(3)>0 || any(strcmpi(THERING{i}.FamName,{'SF','SFF'}))
            % Focusing sextupole
            IconHeight = .6;
            IconColor = [1 0 1];
            IconWidth = THERING{i}.Length;
            if IconWidth < MinIconWidth % meters
                IconWidth = MinIconWidth;
                SPos = SPos - IconWidth/2 + THERING{i}.Length/2;
            end
            vx = [SPos          SPos+.33*IconWidth  SPos+.66*IconWidth  SPos+IconWidth   SPos+IconWidth   SPos+.66*IconWidth  SPos+.33*IconWidth      SPos          SPos];
            vy = [IconHeight/3      IconHeight          IconHeight        IconHeight/3    -IconHeight/3      -IconHeight          -IconHeight     -IconHeight/3  IconHeight/3];
        else
            % Defocusing sextupole
            IconHeight = .6;
            IconColor = [0 1 0];
            IconWidth = THERING{i}.Length;
            if IconWidth < MinIconWidth % meters
                IconWidth = MinIconWidth;
                SPos = SPos - IconWidth/2 + THERING{i}.Length/2;
            end
            vx = [SPos          SPos+.33*IconWidth  SPos+.66*IconWidth  SPos+IconWidth   SPos+IconWidth   SPos+.66*IconWidth  SPos+.33*IconWidth      SPos          SPos];
            vy = [IconHeight/3      IconHeight          IconHeight        IconHeight/3    -IconHeight/3      -IconHeight          -IconHeight     -IconHeight/3  IconHeight/3];
        end
        h = patch(vx, Scaling*vy+Offset, IconColor,'LineStyle','-', 'Parent',hAxes);
        set(h, 'UserData', i);
        %if IconWidth < .1 % meters
        %    set(h, 'EdgeColor', IconColor);
        %end

    elseif isfield(THERING{i},'Frequency') && isfield(THERING{i},'Voltage')
        % RF cavity
        NumberOfFinds = NumberOfFinds + 1;
        IconColor = [1 0.5 0];
        IconHeight = .6;
      
        %IconWidth = THERING{i}.Length;
        IconWidth=3;
        SPos=SPos-IconWidth/2;
            if IconWidth < MinIconWidth % meters
                IconWidth = MinIconWidth;
                SPos = SPos - IconWidth/2 + THERING{i}.Length/2;
            end
        vx = [SPos SPos+IconWidth SPos+IconWidth SPos];
        vy = [IconHeight IconHeight -IconHeight -IconHeight];
        %h = patch(vx, Scaling*vy+Offset, IconColor,'LineStyle','-', 'Parent',hAxes);
        %set(h, 'UserData', i);
%         h = plot(hAxes, SPos, 0+Offset, 'o', 'MarkerFaceColor', IconColor, 'Color', IconColor, 'MarkerSize', 4);
%         set(h, 'UserData', i);

    elseif strcmpi(THERING{i}.FamName,'BPM')
        % BPM
        NumberOfFinds = NumberOfFinds + 1;
        IconColor = 'k';
        h = plot(hAxes, SPos, 0+Offset, '.', 'Color', IconColor);
        %h = plot(hAxes, SPos, 0, 'o', 'MarkerFaceColor', IconColor, 'Color', IconColor, 'MarkerSize', 1.5)
        set(h, 'UserData', i);
        
    elseif strcmpi(THERING{i}.FamName,'TV')
        % TV screen
        NumberOfFinds = NumberOfFinds + 1;
        IconHeight = .7;
        IconColor = [.5 0 0];  %'k';
        %h = plot(hAxes, SPos, 0+Offset, 'x', 'Color', IconColor);
        h = plot(hAxes, SPos, Scaling*IconHeight+Offset, 'Marker','Square', 'MarkerFaceColor', IconColor, 'Color', IconColor, 'MarkerSize', 3.5);
        set(h, 'UserData', i);
    end
    
    % Since correctors could be a combined function magnet, test separately
    if any(strcmpi(THERING{i}.FamName,{'COR','XCOR','YCOR','HCOR','VCOR'})) || isfield(THERING{i},'KickAngle')
        % Corrector
        NumberOfFinds = NumberOfFinds + 1;
        
        if NumberOfFinds > 1
            IconWidth = 0;
        else
            IconWidth = THERING{i}.Length;
        end
        IconHeight = 1.0;  % was .8
        vx = [SPos   SPos];

        % Draw a line above for a HCM and below for a VCM
        % If it's not in the ML, then draw a line above and below
        CMFound = 1;
        if any(i == ATIndexVCM)
            IconColor = [0 0 0];
            vy = [-IconHeight 0];
            if IconWidth < MinIconWidth
                h = plot(hAxes, vx, Scaling*vy+Offset, 'Color', IconColor);
            else
                IconWidth = THERING{i}.Length;
                vx = [SPos SPos+IconWidth SPos+IconWidth SPos];
                vy = [0 0 -IconHeight -IconHeight];
                %vy = [IconHeight IconHeight -IconHeight -IconHeight];
                h = patch(vx, Scaling*vy+Offset, IconColor, 'LineStyle', '-', 'Parent',hAxes);
                if IconWidth < MinIconWidth*2 % meters
                    set(h, 'EdgeColor', IconColor);
                end
            end
            set(h, 'UserData', i);
            CMFound = 0;
        end

        if any(i == ATIndexHCM)
            IconColor = [0 0 0];
            vy = [0 IconHeight];
            if IconWidth < MinIconWidth
                h = plot(hAxes, vx, Scaling*vy+Offset, 'Color', IconColor);
            else
                IconWidth = THERING{i}.Length;
                vx = [SPos SPos+IconWidth SPos+IconWidth SPos];
                vy = [IconHeight IconHeight 0 0];
                %vy = [IconHeight IconHeight -IconHeight -IconHeight];
                h = patch(vx, Scaling*vy+Offset, IconColor, 'LineStyle', '-', 'Parent',hAxes);
                if IconWidth < MinIconWidth*2 % meters
                    set(h, 'EdgeColor', IconColor);
                end
            end
            set(h, 'UserData', i);
            CMFound = 0;
        end
        
        if CMFound
            IconColor = [0 0 0];
            vy = [-IconHeight IconHeight];
            if IconWidth < MinIconWidth
                h = plot(hAxes, vx, Scaling*vy+Offset, 'Color', IconColor);
            else
                IconWidth = THERING{i}.Length;
                vx = [SPos SPos+IconWidth SPos+IconWidth SPos];
                vy = [IconHeight IconHeight -IconHeight -IconHeight];
                h = patch(vx, Scaling*vy+Offset, IconColor, 'LineStyle', '-', 'Parent',hAxes);
                if IconWidth < MinIconWidth*2 % meters
                    set(h, 'EdgeColor', IconColor);
                end
            end
            set(h, 'UserData', i);
            CMFound = 0;
        end
    end
end

%%to PLOT beamLines Name
% 
if (BeamLine_NameFLAG==1)
    BL=getfamilydata('BeamLine');
    BLName = BL.CommonNames;
    BLPos = BL.Position;
    sprintf('%s',BLName{1});
    for i=1:length(BLName)
        %h=text2vect(BLName{i},BLPos(i),0.1,0.1)
        h = text(BLPos(i), Scaling*0.9+Offset , BLName{i}, 'Color', IconColor, 'Parent',hAxes);%,'FontSize',8);
        set(h, 'UserData', i);
    end         
end


%%to_PLOT_Insertions
if ((DrawIDFLAG == 1) || (ID_NameFLAG == 1))
    %resp = idGetListOfInsertionDevices('all');
    resp = idGetParamForUndSOLEIL('all');
    %IDlist = {resp{:,1}}';
    IDlist = {resp.name}';
%     IDlist= { ...
%     'U20_PROXIMA1', ...
%     'U20_SWING', ... 
%     'U20_CRISTAL',...
%     'U20_SIXS',...
%     'U20_GALAXIES',...
%     'U24_PROXIMA2-A',... 
%     'HU80_TEMPO',...
%     'HU80_PLEIADES',... 
%     'HU80_SEXTANTS',... 
%     'HU52_DEIMOS',... 
%     'HU52_LUCIA',... 
%     'HU44_MICROFOC',... 
%     'HU36_SIRIUS',... 
%     'HU42_HERMES',... 
%     'HU60_CASSIOPEE',... 
%     'HU60_ANTARES',... 
%     'HU256_CASSIOPEE',... 
%     'HU256_PLEIADES',... 
%     'HU256_ANTARES',... 
%     'HU640_DESIRS',... 
%     'U18_TOMO',... 
%     'U20_NANO',... 
%     'HU65_DEIMOS',...
%     'W164_PUMA',...
%     };
    for i=1:length(IDlist)
        % get IDinformations         
        %IDlist{i} = 'U18_NANOSCOPIUM';
        IDinfos=resp(i);
        %define upstream edge position of ID:
        PosBPM1=getspos('BPMx',IDinfos.indRelBPMs(1,:));
        %PosBPM2=getspos('BPMx',IDinfos.indRelBPMs(2,:));
        %LenStraight=PosBPM2-PosBPM1;
        LenStraight=IDinfos.sectLenBwBPMs;
        if strcmpi(IDlist{i}, 'U18_NANOSCOPIUM')
            PosBPM1=getspos('BPMx',[13 1]);
            LenStraight=diff(getspos('BPMx',[13 1;13 2]));
        elseif strcmpi(IDlist{i}, 'U20_ANATOMIX')
           
            LenStraight=diff(getspos('BPMx',[13 1;13 2]));
            
        end
        SPos = PosBPM1+ (LenStraight/2)+IDinfos.idCenPos-(IDinfos.idLen/2) ;
        IconHeight = .3;
        IconWidth = IDinfos.idLen;
        if strncmp(IDlist{i}, 'HU256', 5)
            IconColor = [0.8, 0.2 0.8]; %Purple
        elseif strncmp(IDlist{i}, 'HU640', 5)      
             IconColor = [0.2, 0.2 1]; %Blue
        elseif strncmp(IDlist{i}, 'HU', 2)      
             IconColor = [1, 0.8 0.4]; %Orange
        else
             IconColor = [0.2, 0.8 0.2]; %Green
        end
        %?? why %
        %     if IconWidth < MinIconWidth % meters
        %         IconWidth = MinIconWidth;
        %         SPos = SPos - IconWidth/2 + IDinfos.idLen;
        %     end
        if (DrawIDFLAG == 1)
            vx = [SPos       SPos+IconWidth/3 SPos+IconWidth/3 SPos+IconWidth*2/3 SPos+IconWidth*2/3 SPos+IconWidth SPos+IconWidth SPos];
            vy = [IconHeight IconHeight      -IconHeight/2       -IconHeight/2       IconHeight         IconHeight     -IconHeight    -IconHeight];
            h = patch(vx, Scaling*vy+Offset, IconColor,'LineStyle','-', 'Parent',hAxes);
            set(h, 'UserData', i);            
        end
        if(ID_NameFLAG == 1)
            h = text(SPos, Scaling*-0.9+Offset,strrep(IDlist{i},'_','.'), 'Color', IconColor, 'Parent',hAxes);%,'FontSize',8);
            set(h, 'UserData', i);
        end    

    end
end
%%to_PLOT_RF_Cavity
if (DrawRFcavFLAG == 1)
        % get IDinformations 
        CAVinfos=getRF_CAV_Infos;
        for i=1:length(CAVinfos)
            %define upstream edge position of ID: 
            SPos = getspos('BPMx',CAVinfos(i).indRelBPMs(1,:))+ CAVinfos(i).sectLenBwBPMs/2+CAVinfos(i).cavCenPos-CAVinfos(i).cavLen/2 ;
            IconHeight = .2;
            IconWidth = CAVinfos(i).cavLen;
            IconColor = [1 0 0.5]; 
            vx = [SPos SPos+IconWidth/3 SPos+IconWidth*2/3 SPos+IconWidth SPos+IconWidth*2/3 SPos+IconWidth/3 SPos];
            vy = [0 IconHeight IconHeight 0 -IconHeight -IconHeight 0];
            h = patch(vx, Scaling*vy+Offset, IconColor,'LineStyle','-', 'Parent',hAxes);
            set(h, 'UserData', i);
        end            
end
% Leave the hold state as it was at the start
if ~HoldState
    hold(hAxes, 'off');
end

a = axis(hAxes);
axis(hAxes, [0 L a(3:4)]);
