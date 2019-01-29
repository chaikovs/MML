function [Xt,Zt] = bpm_complete_vacuum_chamber(varargin)
% COMPLETEVACUUMCHAMBER This function creates the true position in the vacuum
% chamber.
%==========================================================================
%
%
% USE :
% -----
%
% [Xt,Zt] (output) is the true position in the vacuum chamber,
% depending on :
% - Space : distance between the 1st point and the vacuum chamber border.
% - VerticalStepSize : vertical distance between two successive points.
% - HorizontalStepSize : horizontal distance between two successive points.
%
%
% SYNTAX(general form) :
% -----------------------
%
% [Xt,Zt] = bpm_complete_vacuum_chamber(...
%               'Space', 1e-1 ,...
%               'VerticalStepSize', 1e-1 ,...
%               'HorizontalStepSize',1e-1 ,...
%               'Display' //  'NoDisplay' ,...
%               'Echo'    // 'NoEcho')
%
% Next parameter after 'Space', 'VerticalStepSize', 'HorizontalStepSize',
% has be the corresponding value.
%
%
%
% DEFAULT VALUES :
% ................
%
%   - Space = 1;
%   - VerticalStepSize = 1;
%   - HorizontalStepSize = 1;
%   - 'NoDisplay'
%   - 'Echo'
%
%==========================================================================
%
% See also get_bpm_nonlinear_response_expert, get_bpm_rebuilt_position_expert

% Adapted by B. Beranger, Master 2013, from Laurent S. Nadolski script

%% Check input arguments

% --- Default values and flags ---
Space = 1; % mm
VerticalStepSize = 1; % mm
HorizontalStepSize = 1; % mm

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
        
        % --- HorizontaleMesh ---
    elseif strcmpi(varargin{i},'Space')
        if length(varargin) > i
            % Look for the file name as the neXt input
            if isscalar(varargin{i+1}) && varargin{i+1}>0 && isnumeric(varargin{i+1})
                Space = varargin{i+1};
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Parameter must be positive.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- VerticaleMesh ---
    elseif strcmpi(varargin{i},'VerticalStepSize')
        if length(varargin) > i
            % Look for the file name as the neXt input
            if isscalar(varargin{i+1}) && varargin{i+1}>0 && isnumeric(varargin{i+1})
                VerticalStepSize = varargin{i+1};
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Parameter must be positive.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- ObliqueMesh ---
    elseif strcmpi(varargin{i},'HorizontalStepSize')
        if length(varargin) > i
            % Look for the file name as the neXt input
            if isscalar(varargin{i+1}) && varargin{i+1}>0 && isnumeric(varargin{i+1})
                HorizontalStepSize = varargin{i+1};
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Parameter must be positive.\n',varargin{i});
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
    disp('Parameter(s) not recognised :')
    for p = 1:length(varargin)
        disp(varargin(p))
    end
    warning('bpm_complete_vacuum_chamber:UnknownParameters','Unknown parameter(s) detected')
end


%% Echo of all parameters used (used as control in the Command Window)

if EchoFlag
    
    % --- Echo for parameters used ---
    fprintf('\n===== bpm_complete_vacuum_chamber Start ===== \n');
    
    % --- Echo for no problem detected ---
    if ProblemDetectionFlag == 0;
        fprintf('No parameter problem detected \n');
    end
    
    % --- Echo for the HorizontaleMesh ---
    fprintf(' - Space             : %g \n',Space);
    
    % --- Echo for the VerticaleMesh ---
    fprintf(' - VerticalStepSize    : %g \n',VerticalStepSize);
    
    % --- Echo for the ObliqueMesh ---
    fprintf(' - HorizontalStepSize  : %g \n',HorizontalStepSize);
    
    % ---  Echo for display parameters ---
    if DisplayFlag == 0
        DisplayTeXt = 'Off';
    else
        DisplayTeXt = 'On';
    end
    fprintf(' - Display              : %s \n', DisplayTeXt);
    
end

%% Dimension 1/4 chambre � vide

Xmax = 42 - Space; % mm
Zmax = 12.5 - Space; % mm

a =(Zmax - 2.6241)/(15 - Xmax);
b = Zmax - a*15;

X0=HorizontalStepSize:HorizontalStepSize:Xmax; % X0 gives horizontal position
Z0=VerticalStepSize:VerticalStepSize:Zmax; % Z0 gives vertival position
[Xs,Zs] = meshgrid(X0, Z0); % Mesh generated by the X0 and Z0 dimensions

iz2 = find(Zs>(a*Xs+b)); % Index of elements outside of the vacuum chamber
% Each element outside of the chamber is assigned to Not A number NaN
Xs(iz2) = NaN;
Zs(iz2) = NaN;

% Part A of the chamber
Xa=flipud(Xs);
Za=flipud(Zs);
% Part B of the chamber
Xb=-fliplr(Xa);
Zb= fliplr(Za);
% Part C of the chamber
Xc=-fliplr(Xs);
Zc=-fliplr(Zs);
% Part D of the chamber
Xd= Xs;
Zd=-Zs;

Xtop=[Xb, zeros(size(Xa,1),1), Xa];
Xbottom = [Xc, zeros(size(Xa,1),1), Xd];
Xt = [Xtop; Xtop(end,:); Xbottom];

Zdroit = [Za;zeros(1,size(Za,2));  Zd];
Zleft = [Zb;zeros(1,size(Za,2));  Zc];
Zt=[Zleft, Zleft(:,end), Zdroit];

%% Display

if DisplayFlag
    
    figure('Name',sprintf('Complete vacuum chamber where : \n Space = %g [mm]\n VerticalStepSize = %g [mm]\n HorizontalStepSize = %g [mm]',Space,VerticalStepSize,HorizontalStepSize),...
        'NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97]);
    hold on;
    
    title(sprintf('Complete vacuum chamber where : \n Space = %g [mm]\n VerticalStepSize = %g [mm]\n HorizontalStepSize = %g [mm]',Space,VerticalStepSize,HorizontalStepSize),'FontSize',20)
    
    % --- Display the border of vacuum chamber ---
    X = [42 42 15 -15 -42 -42 -15 15 42];
    Z = [-2.6241 2.6241 12.5 12.5 2.6241 -2.6241 -12.5 -12.5 -2.6241];
    plot(X,Z,'-k');
    
    % --- Display Vacuum chamber as a mesh ---
    mesh(Xt,Zt,ones(size(Xt)));
    %shading interp
    %     view(2);
    xlim([-45 45])
    ylim([-15 15])
    xlabel('X [mm]','FontSize',20)
    ylabel('Z [mm]','FontSize',20)
    set(gca,'XDir','reverse','FontSize',20) % invert h-aXis
    
%     removemarge
    axis equal
    
end


%% End of function

if EchoFlag
    
    fprintf(' ===== bpm_complete_vacuum_chamber Done ===== \n\n');
    
end

end
