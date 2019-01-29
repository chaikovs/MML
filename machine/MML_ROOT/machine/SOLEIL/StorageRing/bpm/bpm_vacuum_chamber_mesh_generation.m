function [AM, tout, DataTime, ErrorFlag] = bpm_vacuum_chamber_mesh_generation( varargin )
% BPM_VACUUM_CHAMBER_MESH_GENERATION Generates G matrix corresponding to
% the dimensions of boundary elements chosen.
%==========================================================================
%
%  [AM, tout, DataTime, ErrorFlag] = bpm_vacuum_chamber_mesh_generation( 'HorizontalMesh',65, 'VerticalMesh',30, 'ObliqueMesh',5 , 'Echo', 'Display' )
%
%  INPUTS
%  1. HorizontalMesh is the number of nodes on Horizontal sections of BPM boundary
%  2. VerticalMesh is the number of nodes on Vertical sections of BPM boundary
%  3. ObliqueMesh is the number of nodes on Oblique sections of BPM boundary
%  4. Display generates figure to show the result of meshing.
%  5. Echo is used do print an echo of parameters used.
%
%  OUTPUTS
%  1. AM = structure containing mesh information (G matrix, position of segments, ...)
%  2. tout  (see help getpv)
%  3. DataTime  (see help getpv)
%  4. ErrorFlag  (see help getpv)
%
%  NOTE
%  1. All parameters are optional
%
%
% USE :
% -----
%
% This function will compute the matrices generates G matrix used for the
% numeric Boundary Element Method (BEM). G only depends on the geometry of
% the vacuum chamber (which is defined by the BPM) and the mesh used.
%
%
%
% SYNTAX(general form) :
% -----------------------
%
% AM = bpm_vacuum_chamber_mesh_generation(...
%                     'HorizontalMesh', 100,...
%                     'VerticalMesh', 30,...
%                     'ObliqueMesh',50,...
%                     'Display'   // 'NoDisplay',...
%                     'Echo'      // 'NoEcho')
%
% Next parameter after 'HorizontalMesh', 'VerticalMesh', 'ObliqueMesh',
% has be the corresponding value.
%
%
%
% DEFAULT VALUES :
% ................
%
%   - HorizontalMesh = 65;
%   - ObliqueMesh = 30;
%   - VerticalMesh = 5;
%   - 'NoDisplay'
%   - 'NoEcho'
%
%
%==========================================================================
%
% See also get_bpm_nonlinear_response, get_bpm_nonlinear_response_expert,
% bpm_compute_nonlinear_response get_bpm_co_rebuilt,
% get_bpm_rebuilt_position_expert, bpm_rebuild_position

% Written by  B. Beranger, Master 2013


%% Start time

t0 = clock; % starting time for getting data


%% Check input arguments

% --- Default values and flags ---
HorizontalMesh = 65;
ObliqueMesh = 30;
VerticalMesh = 5;
ProblemDetectionFlag = 0;
DisplayFlag = 0;
EchoFlag = 0;


% --- Checking varargin ---
for i = length(varargin):-1:1
    
    % --- Display ---
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
        
        % --- NoDisplay ---
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
        
        % --- HorizontalMesh ---
    elseif strcmpi(varargin{i},'HorizontalMesh')
        if length(varargin) > i
            % Look for the file name as the next input
            if isscalar(varargin{i+1}) && varargin{i+1}>0 && varargin{i+1} == round(varargin{i+1})
                HorizontalMesh = varargin{i+1};
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Patameter must be a positive integer.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- VerticalMesh ---
    elseif strcmpi(varargin{i},'VerticalMesh')
        if length(varargin) > i
            % Look for the file name as the next input
            if isscalar(varargin{i+1}) && varargin{i+1}>0 && varargin{i+1} == round(varargin{i+1})
                VerticalMesh = varargin{i+1};
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Patameter must be a positive integer.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- ObliqueMesh ---
    elseif strcmpi(varargin{i},'ObliqueMesh')
        if length(varargin) > i
            % Look for the file name as the next input
            if isscalar(varargin{i+1}) && varargin{i+1}>0 && varargin{i+1} == round(varargin{i+1})
                ObliqueMesh = varargin{i+1};
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Patameter must be a positive integer.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
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
        
    end
    
end

% --- If unidentified paramter(s) remain(s) ---
if ~isempty(varargin)
    fprintf('\nIn %s, parameter(s) not recognised : \n',mfilename)
    for p = 1:length(varargin)
        disp(varargin(p))
    end
    warning('Unknown:Parameter','Unknown parameter(s) detected')
end


%% Echo of all parameters used (used as control in the Command Window)

if EchoFlag
    
    % --- Echo for parameters used ---
    fprintf('\n ===== bpm_vacuum_chamber_mesh_generation Start ===== \n');
    
    % --- Echo for no problem detected ---
    if ProblemDetectionFlag == 0;
        fprintf('No parameter problem detected \n');
    end
    
    % --- Echo for the HorizontalMesh ---
    fprintf(' - HorizontalMesh : %d \n',HorizontalMesh);
    
    % --- Echo for the VerticalMesh ---
    fprintf(' - VerticalMesh   : %d \n',VerticalMesh);
    
    % --- Echo for the ObliqueMesh ---
    fprintf(' - ObliqueMesh    : %d \n',ObliqueMesh);
    
    % ---  Echo for display parameters ---
    if DisplayFlag == 0
        DisplayText = 'Off';
    else
        DisplayText = 'On';
    end
    fprintf(' - Display        : %s \n', DisplayText);
    
end


%% Generation of the mesh

coeff = 1;

% WARINING : X_boundary and Z_boundary are specific to the geometry of BPMs
% Here, it is BPMs geometry from SOLEIL storage ring.

X_boundary = [linespace(42,42,VerticalMesh) ...
    linespace(42,15,ObliqueMesh) ...
    linespace(15,12.43,round((2.57/30)*HorizontalMesh))...
    linespace(12.43,3.57,round(coeff*(8.86/30)*HorizontalMesh))...
    linespace(3.57,-3.57,round((7.14/30)*HorizontalMesh))...
    linespace(-3.57,-12.43,round(coeff*(8.86/30)*HorizontalMesh))...
    linespace(-12.43,-15,round((2.57/30)*HorizontalMesh))...
    linespace(-15,-42,ObliqueMesh) ...
    linespace(-42,-42,VerticalMesh) ...
    linespace(-42,-15,ObliqueMesh) ...
    linespace(-15,-12.43,round((2.57/30)*HorizontalMesh))...
    linespace(-12.43,-3.57,round(coeff*(8.86/30)*HorizontalMesh))...
    linespace(-3.57,3.57,round((7.14/30)*HorizontalMesh))...
    linespace(3.57,12.43,round(coeff*(8.86/30)*HorizontalMesh))...
    linespace(12.43,15,round((2.57/30)*HorizontalMesh))...
    linspace(15,42,ObliqueMesh+2) ...
    ]';
Z_boundary = [linespace(-2.6241,2.6241,VerticalMesh) ...
    linespace(2.6241,12.5,ObliqueMesh) ...
    linespace(12.5,12.5,round((2.57/30)*HorizontalMesh))...
    linespace(12.5,12.5,round(coeff*(8.86/30)*HorizontalMesh))...
    linespace(12.5,12.5,round((7.14/30)*HorizontalMesh))...
    linespace(12.5,12.5,round(coeff*(8.86/30)*HorizontalMesh))...
    linespace(12.5,12.5,round((2.57/30)*HorizontalMesh))...
    linespace(12.5,+2.6241,ObliqueMesh) ...
    linespace(+2.6241,-2.6241,VerticalMesh) ...
    linespace(-2.6241,-12.5,ObliqueMesh) ...
    linespace(-12.5,-12.5,round((2.57/30)*HorizontalMesh))...
    linespace(-12.5,-12.5,round(coeff*(8.86/30)*HorizontalMesh))...
    linespace(-12.5,-12.5,round((7.14/30)*HorizontalMesh))...
    linespace(-12.5,-12.5,round(coeff*(8.86/30)*HorizontalMesh))...
    linespace(-12.5,-12.5,round((2.57/30)*HorizontalMesh))...
    linspace(-12.5,-2.6241,ObliqueMesh+2) ...
    ]';


% X_boundary = [linespace(42,42,VerticalMesh) ...
%     linespace(42,15,ObliqueMesh) ...
%     linespace(15,-15,HorizontalMesh)...
%     linespace(-15,-42,ObliqueMesh) ...
%     linespace(-42,-42,VerticalMesh) ...
%     linespace(-42,-15,ObliqueMesh) ...
%     linespace(-15,15,HorizontalMesh)...
%     linspace(15,42,ObliqueMesh+2) ...
%     ]';
% Z_boundary = [linespace(-2.6241,2.6241,VerticalMesh) ...
%     linespace(2.6241,12.5,ObliqueMesh) ...
%     linespace(12.5,12.5,HorizontalMesh)...
%     linespace(12.5,+2.6241,ObliqueMesh) ...
%     linespace(+2.6241,-2.6241,VerticalMesh) ...
%     linespace(-2.6241,-12.5,ObliqueMesh) ...
%     linespace(-12.5,-12.5,HorizontalMesh)...
%     linspace(-12.5,-2.6241,ObliqueMesh+2) ...
%     ]';

%% Middle of segments of the mesh

% --- Number of segments ( = number of middles ) ---
N = length(X_boundary)-1;
if EchoFlag
    fprintf(' Number of segments / middles = %d \n',N);
end

% --- Position of the middles ---
X_middle_boundary = ( X_boundary(1:N) + X_boundary(2:N+1) )/2;
Z_middle_boundary = ( Z_boundary(1:N) + Z_boundary(2:N+1) )/2;


%% Button electrode position

ButtonDiameter = 8.86; % mm (Electrode diameter in SOLEIL)
ButtonDistance = 16; % mm (distance between the button electrode middles in SOLEIL)

ButtonOutside = ButtonDistance/2 + ButtonDiameter/2; % Always outside border of button
ButtonInside = ButtonDistance/2 - ButtonDiameter/2; % Always inside border of button

IndexA = find( and ( X_middle_boundary(1:N/2)<ButtonOutside , X_middle_boundary(1:N/2)>ButtonInside ) ); % Index of position button electrode A
IndexB = find( and ( X_middle_boundary(1:N/2)<-ButtonInside , X_middle_boundary(1:N/2)>-ButtonOutside ) ); % Index of position button electrode B
IndexC = find( and ( X_middle_boundary(N/2:N)<-ButtonInside , X_middle_boundary(N/2:N)>-ButtonOutside ) ) + N/2-1 ; % Index of position button electrode C
IndexD = find( and ( X_middle_boundary(N/2:N)<ButtonOutside , X_middle_boundary(N/2:N)>ButtonInside ) ) + N/2-1 ; % Index of position button electrode D


%% Generating G matrix

G=zeros(N,N);
SegmentLength = zeros(N,1);

% --- Computing segment length ---
for j = 1:N
    SegmentLength(j) = sqrt( ( X_boundary(j+1) - X_boundary(j) )^2 + ( Z_boundary(j+1) - Z_boundary(j) )^2 );
end

% --- Computing G matrix ---
for i = 1:N
    for j = 1:N
        if i~=j
            G(i,j) = -0.5 * log( ( X_middle_boundary(j) - X_middle_boundary(i) )^2 + ( Z_middle_boundary(j) - Z_middle_boundary(i) )^2 ) * SegmentLength(j);
        else
            G(i,j) = 2*SegmentLength(j)*( 1 - log(SegmentLength(j)) );
        end
    end
end

iG = inv(G);


%% Definition of varargout

DataTime = now;

AM = struct;
AM.DataDescriptor = 'BPM inner boundary mesh informations';
AM.CreatedBy = mfilename;
AM.TimeStampe = datestr(DataTime);
AM.X_boundary = X_boundary;
AM.Z_boundary = Z_boundary;
AM.X_middle_boundary = X_middle_boundary;
AM.Z_middle_boundary = Z_middle_boundary;
AM.IndexA = IndexA;
AM.IndexB = IndexB;
AM.IndexC = IndexC;
AM.IndexD = IndexD;
AM.G = G;
AM.iG = iG;


ErrorFlag = 0;
tout = etime(clock, t0);

%% Display

if DisplayFlag
    
    ButtonElectrodeColor = 'blackhexagram';
    
    % --- Display Vacuum chamber mesh ---
    figure('Name',sprintf('Vacuum chamber boundary mesh where : \n VerticalMesh = %d \n ObliqueMesh = %d \n HorizontalMesh = %d ',VerticalMesh,ObliqueMesh,HorizontalMesh),...
        'NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    hold all
    
    title(sprintf('Vacuum chamber boundary mesh where : \n VerticalMesh = %d \t\t\t ObliqueMesh = %d \t\t\t HorizontalMesh = %d ',VerticalMesh,ObliqueMesh,HorizontalMesh),'FontSize',20)
    
    plot_contour = plot(X_boundary,Z_boundary,'-black'); % Boundary
    plot_node = plot(X_boundary,Z_boundary,'oblue','MarkerSize',6); % Nodes in blue circles
    
    plot_electrode = plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,'MarkerSize',15);
    plot(X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,'MarkerSize',15)
    plot(X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,'MarkerSize',15)
    plot(X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor,'MarkerSize',15)
    
    xlim([-45 45])
    ylim([-15 15])
    set(gca,'XDir','reverse','FontSize',20)
    xlabel('X [mm]','FontSize',20)
    ylabel('Z [mm]','FontSize',20)
    
    % --- Display middles of segments ---
    plot_middle = plot(X_middle_boundary,Z_middle_boundary,'xred','MarkerSize',8); % Middles in red crosses
    
    legend([plot_contour plot_node plot_middle plot_electrode],'Boundary','Node','Middle','Electrode points')
    
    removemarge
    
    axis equal
    
end


%% End of function

if EchoFlag
    fprintf(' ===== VacuumChamberGeneration Done ===== \n\n');
end


end


%%-------------------------------------------------------------------------
%% Other functions

% LINESPACE function creates a vector starting at point a, endind at point
% b-(b-a)/c, and spaced by c points 2-by-2 equideistant.
function MeshVector = linespace(a,b,c)
MeshVector = linspace(a,b,c+2);
MeshVector = MeshVector(1:c+1);
end