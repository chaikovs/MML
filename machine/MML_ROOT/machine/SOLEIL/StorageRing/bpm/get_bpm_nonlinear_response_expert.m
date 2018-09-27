function [ varargout ] = get_bpm_nonlinear_response_expert( varargin )
% GET_BPM_NONLINEAR_RESPONSE_EXPERT Uses the output structure of
% bpm_vacuum_chamber_mesh_generation function to solve Poisson problem.
%==========================================================================
%
%
% USE :
% -----
%
% This function uses the geometry of vacuum chamber defined in
% bpm_vacuum_chamber_mesh_generation.m function and the input beam position. Then,
% solving Poisson equation with Boundary Elements Method, the function
% computes the position read by BPM.
%
%
% SYNTAX(general form) :
% -----------------------
%
% [ varargout ] = get_bpm_nonlinear_response_expert(...
%                     'MeshStructure', bpm_vacuum_chamber_mesh_generation_OutputStructure,...
%                     'BeamPosition', X_beam, Z_beam // 'BeamPosition', {'Epsilon', 0.001 ,'VerticalStepSize', 0.5,'HorizontalStepSize', 0.5},...
%                     'Display'                      // 'NoDisplay',...
%                     'Echo'                         // 'NoEcho')
%
% Next parameter after 'MeshStructure' has be the corresponding
% value.
%
% After 'BeamPosition', X_beam anf Y0 will be used to generate a meshgrid as :
% [ X_beam , Z_beam ] = meshgrid( X_beam , Z_beam )
% OR
% {'Epsilon', 0.001 ,'VerticalStepSize', 0.5,'HorizontalStepSize', 0.5}
% use the whole vacuum chamber defined in bpm_complete_vacuum_chamber.m
%
%
% EXAMPLES :
% ..........
%
% 1. get_bpm_nonlinear_response_expert_OutputStructure = get_bpm_nonlinear_response_expert(...
%     'MeshStructure',bpm_vacuum_chamber_mesh_generation_OutputStructure,...
%     'BeamPosition', -25:25, -5:5,...
%     'NoEcho');
% Here, the beam position will be a grid generated by vectors X_beam =
% -25:25 and Z_beam = -5:5 . (No echo in command window)
%
% 2. get_bpm_nonlinear_response_expert_OutputStructure = get_bpm_nonlinear_response_expert(...
%     'MeshStructure',bpm_vacuum_chamber_mesh_generation_OutputStructure,...
%     'BeamPosition', -10:10, 10,...
%     'Display');
% Here, the beam position will be a vector defined by vector as X_beam =
% -10:10 at Z_beam = 10 . (And display of results in figures)
%
% 3. get_bpm_nonlinear_response_expert_OutputStructure = get_bpm_nonlinear_response_expert(...
%     'MeshStructure',bpm_vacuum_chamber_mesh_generation_OutputStructure,...
%     'BeamPosition', -25, 8);
% Here, the beam position will be a point defined as X_beam = -25 and
% Z_beam = 8 . In the case if computing 1 point, display options are
% adapted : plot the path of iterations.
%
% 4. get_bpm_nonlinear_response_expert_OutputStructure = get_bpm_nonlinear_response_expert(...
%     'MeshStructure',bpm_vacuum_chamber_mesh_generation_OutputStructure,...
%     'BeamPosition', {'Epsilon', 1 ,'VerticalStepSize', 0.5,'HorizontalStepSize', 0.5},...
%     'Display');
% Here, the beam position will be the whole vacuum chamber except the area
% large of 'Epsilon' next to the boundary, and grid resolution is defined
% by 'VerticalStepSize' and 'HorizontalStepSize' . (coming from
% bpm_complete_vacuum_chamber.m function)
% IMPORTANT : After 'BeamPosition', is must be cell containing the
% parameters of bpm_complete_vacuum_chamber.m function.
%
%
% DEFAULT VALUES :
% ................
%
%   - MeshStructure = bpm_vacuum_chamber_mesh_generation()
%   - 'BeamPosition' : [ X_beam , Z_beam ] = [ -10:10 , -2:2 ]
%   - 'NoDisplay'
%   - 'NoEcho'
%
%
%==========================================================================
%
% See also bpm_vacuum_chamber_mesh_generation, bpm_complete_vacuum_chamber,
% get_bpm_rebuilt_position_expert

% Written by  B. Beranger, Master 2013

%% Check input arguments

% --- Default values and flags ---
ProblemDetectionFlag = 0;
DisplayFlag = 0;
MeshStructureFlag = 0;
X_beam = -10:10;
Z_beam = -2:2;
VacuumChamberDefinitionFlag = 0;
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
        
        % --- MeshStructure ---
    elseif strcmpi(varargin{i},'MeshStructure')
        if length(varargin) > i
            % Look for the file name as the next input
            if isstruct(varargin{i+1})
                MeshStructure = varargin{i+1};
                MeshStructureFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Patameter must be structure.\n',varargin{i});
            end
        else
            ProblemDetectionFlag = 1;
            fprintf('# Problem detected after the field ''%s'' : No parameter detected. Default value will be used.\n',varargin{i});
        end
        varargin(i) = [];
        
        % --- BeamPosition ---
    elseif strcmpi(varargin{i},'BeamPosition')
        if length(varargin) > i
            % Look for the file name as the next input
            if length(varargin) > i+1
                if isnumeric(varargin{i+1}) && isnumeric(varargin{i+2}) && isvector(varargin{i+1}) && isvector(varargin{i+2})
                    X_beam = varargin{i+1};
                    Z_beam = varargin{i+2};
                    varargin(i+2) = [];
                    varargin(i+1) = [];
                else
                    ProblemDetectionFlag = 1;
                    fprintf('# Problem detected after the field ''%s'' : The two parameter must be numeric vectors.\n',varargin{i});
                end
            elseif iscell(varargin{i+1})
                VacuumChamberDefinition = varargin{i+1};
                VacuumChamberDefinitionFlag = 1;
                varargin(i+1) = [];
            else
                ProblemDetectionFlag = 1;
                fprintf('# Problem detected after the field ''%s'' : Patameter must be cell.\n',varargin{i});
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

if ~MeshStructureFlag
    MeshStructure = bpm_vacuum_chamber_mesh_generation();
end


%% Echo of all parameters used (used as control in the Command Window)

if EchoFlag
    
    % --- Echo for parameters used ---
    fprintf('\n ===== get_bpm_nonlinear_response_expert Start ===== \n');
    
    % --- Echo for no problem detected ---
    if ProblemDetectionFlag == 0;
        fprintf('No parameter problem detected \n');
    end
    
    % --- Echo for the MeshStructure ---
    if MeshStructureFlag
        fprintf(' - MeshStructure : Parameter of function \n');
    else
        fprintf(' - MeshStructure : default value bpm_vacuum_chamber_mesh_generation() \n');
    end
    
    % --- Echo for the BeamPosition ---
    if ~VacuumChamberDefinitionFlag
        fprintf(' - BeamPosition  : Parameter of function \n');
    else
        fprintf(' - BeamPosition  : bpm_complete_vacuum_chamber ( Parameter of function ) \n');
    end
    
    % ---  Echo for display parameters ---
    if DisplayFlag == 0
        DisplayText = 'Off';
    else
        DisplayText = 'On';
    end
    fprintf(' - Display       : %s \n', DisplayText);
    
end

%% Shortcuts definition

X_boundary = MeshStructure.X_boundary;
Z_boundary = MeshStructure.Z_boundary;
IndexA = MeshStructure.IndexA;
IndexB = MeshStructure.IndexB;
IndexC = MeshStructure.IndexC;
IndexD = MeshStructure.IndexD;
X_middle_boundary = MeshStructure.X_middle_boundary;
Z_middle_boundary = MeshStructure.Z_middle_boundary;


%% Computation of B, Sigma, Q(i), X_readead and Z_readead

if VacuumChamberDefinitionFlag
    [X_beam,Z_beam] = bpm_complete_vacuum_chamber(VacuumChamberDefinition{:}); % Grid of points in the whole vacuum chamber
else
    [X_beam,Z_beam] = meshgrid(X_beam,Z_beam); % Grid of points generaed by the vectors X_beam and Z_beam
end

bpm_compute_nonlinear_response_OutputStructure = bpm_compute_nonlinear_response( X_beam , Z_beam , MeshStructure );

Qa = bpm_compute_nonlinear_response_OutputStructure.Qa;
Qb = bpm_compute_nonlinear_response_OutputStructure.Qb;
Qc = bpm_compute_nonlinear_response_OutputStructure.Qc;
Qd = bpm_compute_nonlinear_response_OutputStructure.Qd;
Kx = bpm_compute_nonlinear_response_OutputStructure.Kx;
Kz = bpm_compute_nonlinear_response_OutputStructure.Kz;
X_read = bpm_compute_nonlinear_response_OutputStructure.X_read;
Z_read = bpm_compute_nonlinear_response_OutputStructure.Z_read;
PoissonError = bpm_compute_nonlinear_response_OutputStructure.PoissonError;
NormalisedPoissonError = bpm_compute_nonlinear_response_OutputStructure.NormalisedPoissonError;


%% Saving results

varargout{1} = struct;
varargout{1}.MeshStructure = MeshStructure;
varargout{1}.X_beam = X_beam;
varargout{1}.Z_beam = Z_beam;
varargout{1}.Qa = Qa;
varargout{1}.Qb = Qb;
varargout{1}.Qc = Qc;
varargout{1}.Qd = Qd;
varargout{1}.Kx = Kx;
varargout{1}.Kz = Kz;
varargout{1}.X_read = X_read;
varargout{1}.Z_read = Z_read;
varargout{1}.PoissonError = PoissonError;
varargout{1}.NormalisedPoissonError = NormalisedPoissonError;


%% Display

if DisplayFlag
    
    ButtonElectrodeColor = 'blackhexagram';
    FontSize = 20;
    
    % Figure representing the whole vacuum chamber with BeamPosition [X_beam,Z_beam] and ReadPosition [X_read,Z_read].
    figure('NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    hold all
    plot_boundary = plot(X_boundary,Z_boundary,'-black');
    plot_electrode = plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor);
    plot(X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor)
    plot(X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor)
    plot(X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
    plot_beam = plot(X_beam,Z_beam,'+blue','MarkerSize',2);
    plot_read = plot(X_read,Z_read,'*green','MarkerSize',6);
    legend([plot_boundary plot_electrode plot_beam(1) plot_read(1)],'Boundary','Electrode points','Beam position','Read position')
    if size(X_beam,1) == 1 && size(X_beam,2) ~= 1
        set(gcf,'Name',sprintf('Response of BPM for Z_beam = %8.3f mm',Z_beam(1)))
        title(sprintf('Position Read by BPM depending on Beam positon for Z_b_e_a_m = %8.3f mm',Z_beam(1)),'FontSize',FontSize)
    elseif size(X_beam,2) == 1 && size(X_beam,1) ~= 1
        title(sprintf('Position Read by BPM depending on Beam positon for X_b_e_a_m = %8.3f mm',X_beam(1)),'FontSize',FontSize)
        set(gcf,'Name',sprintf('Response of BPM for X_beam = %8.3f mm',X_beam(1)))
    elseif isscalar(X_beam)
        title(sprintf('Position Read by BPM depending on Beam positon \n [ X_b_e_a_m , Z_b_e_a_m ] = [ %8.3f , %8.3f ] \n [ X_r_e_a_d , Z_r_e_a_d] = [ %8.3f , %8.3f ]',X_beam,Z_beam,X_read,Z_read),'FontSize',FontSize)
        set(gcf,'Name','Response of BPM')
    else
        title(sprintf('Position Read by BPM depending on Beam positon'),'FontSize',FontSize)
        set(gcf,'Name','Response of BPM')
    end
    xlim([-45 45])
    ylim([-15 15])
    set(gca,'XDir','reverse','FontSize',FontSize)
    xlabel('X [mm]','FontSize',FontSize)
    ylabel('Z [mm]','FontSize',FontSize)
    removemarge
    axis equal
    
    % --- Case : 1 point is computed ---
    if (isscalar(X_beam) && isscalar(Z_beam))
        if EchoFlag
            display(PoissonError)
            display(NormalisedPoissonError)
        end
        
        % --- Case : 1 vector is computed ---
    elseif (isvector(X_beam) || isvector(Z_beam))
        
        % Figure representing X plot
        figure('NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        hold all
        grid on
        if size(X_beam,1) == 1
            set(gcf,'Name',sprintf('X variation for Z_beam = %8.3f mm',Z_beam(1)))
            plot(X_beam,X_beam,'*blue','MarkerSize',2)
            plot(X_beam,X_read,'*green','MarkerSize',4)
            xlabel('X vacuum chamber [mm]','FontSize',FontSize)
            title(sprintf('Position Read by BPM depending on Beam positon for Z_b_e_a_m = %8.3f mm',Z_beam(1)),'FontSize',FontSize)
        elseif size(X_beam,2) == 1
            set(gcf,'Name',sprintf('X variation for X_beam = %8.3f mm',X_beam(1)))
            plot(Z_beam,X_beam,'*blue','MarkerSize',2)
            plot(Z_beam,X_read,'*green','MarkerSize',4)
            xlabel('Z vacuum chamber [mm]','FontSize',FontSize)
            title(sprintf('Position Read by BPM depending on Beam positon for X_b_e_a_m = %8.3f mm',X_beam(1)),'FontSize',FontSize)
        end
        set(gca,'XDir','reverse','FontSize',FontSize)
        ylabel('X [mm]','FontSize',FontSize)
        legend('Beam position','Read position')
        removemarge
        
        axis equal
        
        % Figure representing Z plot
        figure('NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        hold all
        grid on
        if size(X_beam,1) == 1
            set(gcf,'Name',sprintf('Z variation for Z_beam = %8.3f',Z_beam(1)))
            plot(X_beam,Z_beam,'*blue','MarkerSize',2)
            plot(X_beam,Z_read,'*green','MarkerSize',4)
            xlabel('X vacuum chamber [mm]','FontSize',FontSize)
            title(sprintf('Position Read by BPM depending on Beam positon for Z_b_e_a_m = %8.3f mm',Z_beam(1)),'FontSize',FontSize)
        elseif size(X_beam,2) == 1
            set(gcf,'Name',sprintf('Z variation for X_beam = %8.3f',X_beam(1)))
            plot(Z_beam,Z_beam,'*blue','MarkerSize',2)
            plot(Z_beam,Z_read,'*green','MarkerSize',4)
            xlabel('Z vacuum chamber [mm]','FontSize',FontSize)
            title(sprintf('Position Read by BPM depending on Beam positon for X_b_e_a_m = %8.3f mm',X_beam(1)),'FontSize',FontSize)
        end
        set(gca,'FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        legend('Beam position','Read position')
        removemarge
        axis equal
        
        
        % --- Case : a grid of beam position is computed ---
    elseif ~((size(X_beam,1) == 1) || (size(X_beam,2) == 1) || (size(Z_beam,1) == 1) || (size(Z_beam,2) == 1))
        
        % Figure representing the error inside the whole vacuum chamber
        figure('Name','Error between Beam position and position Read by BPM in millimeter [mm]','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        title('Error between Beam position and position Read by BPM in millimeter [mm]','FontSize',FontSize)
        hold all
        plot(X_boundary,Z_boundary,'-black')
        plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
            X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
            X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
            X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        surf( X_beam, Z_beam, PoissonError, 'LineStyle', 'None')
        xlim([-45 45])
        ylim([-15 15])
        set(gca,'XDir','reverse','FontSize',FontSize)
        xlabel('X [mm]','FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        removemarge
        colorbar('FontSize',FontSize)
        axis equal
        
        % Figure representing the normalised error inside the whole vacuum chamber
        figure('Name','Normalized error between Beam position and position Read by BPM in percent (%)','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        title('Normalized error between Beam position and position Read by BPM in percent (%)','FontSize',FontSize)
        hold all
        plot(X_boundary,Z_boundary,'-black')
        plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
            X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
            X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
            X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        surf( X_beam, Z_beam, NormalisedPoissonError, 'LineStyle', 'None');
        xlim([-45 45])
        ylim([-15 15])
        set(gca,'XDir','reverse','FontSize',FontSize)
        xlabel('X [mm]','FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        removemarge
        colorbar('FontSize',FontSize)
        axis equal
        
        % Abacus of the error inside the whole vacuum chamber
        figure('Name','Abacus of Error between Beam position and position Read by BPM in millimeter [mm]','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        title('Abacus of Error between Beam position and position Read by BPM in millimeter [mm]','FontSize',FontSize)
        hold all
        plot(X_boundary,Z_boundary,'-black')
        plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
            X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
            X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
            X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        [C1,h1] = contour( X_beam, Z_beam, PoissonError,[1e-3 1e-2 1e-1 0.5 1:5],'LineWidth',2);
        %         [C1,h1] = contour( X_beam, Z_beam, PoissonError,'LineWidth',2);
        clabel(C1,h1,'LabelSpacing',500);
        xlim([-45 45])
        ylim([-15 15])
        set(gca,'XDir','reverse','FontSize',FontSize)
        xlabel('X [mm]','FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        removemarge
        axis equal
        
        % Abacus the normalised error inside the whole vacuum chamber
        figure('Name','Abacus of Normalized error between Beam position and position Read by BPM in percent (%)','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        title('Abacus of Normalized error between Beam position and position Read by BPM in percent (%)','FontSize',FontSize)
        hold all
        plot(X_boundary,Z_boundary,'-black')
        plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
            X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
            X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
            X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        [C2,h2] = contour( X_beam, Z_beam, NormalisedPoissonError,[0.001 0.1 1 2 5 10:10:50],'LineWidth',2);
        %         [C2,h2] = contour( X_beam, Z_beam, NormalisedPoissonError,'LineWidth',2);
        clabel(C2,h2,'LabelSpacing',500);
        xlim([-45 45])
        ylim([-15 15])
        set(gca,'XDir','reverse','FontSize',FontSize)
        xlabel('X [mm]','FontSize',FontSize)
        ylabel('Z [mm]','FontSize',FontSize)
        removemarge
        axis equal
        
        
        %         X_read = X_read/Kx;
        %         Z_read = Z_read/Kz;
        %         varargout{1}.K_x = diff(X_beam,1,2)./diff(X_read,1,2);
        %         varargout{1}.K_z = diff(Z_beam,1,1)./diff(Z_read,1,1);
        
        %         % Kx
        %         figure('Name','Kx','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        %         hold all
        %         surfc(  , 'LineStyle', 'None')
        %         set(gca,'XDir','reverse')
        %         xlabel('X [mm]')
        %         ylabel('Z [mm]')
        %         removemarge
        %         colorbar('FontSize',FontSize)
        %         axis equal
        %
        %         % Kz
        %         figure('Name','Kz','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        %         hold all
        %         surfc(  , 'LineStyle', 'None')
        %         set(gca,'XDir','reverse')
        %         xlabel('X [mm]')
        %         ylabel('Z [mm]')
        %         removemarge
        %         colorbar('FontSize',FontSize)
        %         axis equal
        
        
        
        %         % Figure representing the normalised error inside the whole vacuum chamber
        %         figure('Name','Normalized error between Beam position and position Read by BPM in percent (%)','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        %         title('Normalized error between Beam position and position Read by BPM in percent (%)','FontSize',FontSize)
        %         hold all
        %         plot(X_boundary,Z_boundary,'-black')
        %         plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        %         surf( X_beam, Z_beam, Qa./(Qa + Qb + Qc + Qd), 'LineStyle', 'None');
        %         %         [C2,h2] = contourf( X_beam, Z_beam, NormalisedPoissonError,[1 2 5 10 20],'-w');
        %         %         clabel(C2,h2,'Color','w','Rotation',0,'Edgecolor','w');
        %         xlim([-45 45])
        %         ylim([-15 15])
        %         set(gca,'XDir','reverse','FontSize',FontSize)
        %         xlabel('X [mm]','FontSize',FontSize)
        %         ylabel('Z [mm]','FontSize',FontSize)
        %         removemarge
        %         colorbar('FontSize',FontSize)
        %         axis equal
        %
        %         % Figure representing the normalised error inside the whole vacuum chamber
        %         figure('Name','Normalized error between Beam position and position Read by BPM in percent (%)','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        %         title('Normalized error between Beam position and position Read by BPM in percent (%)','FontSize',FontSize)
        %         hold all
        %         plot(X_boundary,Z_boundary,'-black')
        %         plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        %         surf( X_beam, Z_beam, (Qa+Qd)./(Qa + Qb + Qc + Qd), 'LineStyle', 'None');
        %         %         [C2,h2] = contourf( X_beam, Z_beam, NormalisedPoissonError,[1 2 5 10 20],'-w');
        %         %         clabel(C2,h2,'Color','w','Rotation',0,'Edgecolor','w');
        %         xlim([-45 45])
        %         ylim([-15 15])
        %         set(gca,'XDir','reverse','FontSize',FontSize)
        %         xlabel('X [mm]','FontSize',FontSize)
        %         ylabel('Z [mm]','FontSize',FontSize)
        %         removemarge
        %         colorbar('FontSize',FontSize)
        %         axis equal
        %
        %         % Figure representing the normalised error inside the whole vacuum chamber
        %         figure('Name','Normalized error between Beam position and position Read by BPM in percent (%)','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        %         title('Normalized error between Beam position and position Read by BPM in percent (%)','FontSize',FontSize)
        %         hold all
        %         plot(X_boundary,Z_boundary,'-black')
        %         plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        %         surf( X_beam, Z_beam, (Qa-Qd)./(Qa + Qb + Qc + Qd), 'LineStyle', 'None');
        %         %         [C2,h2] = contourf( X_beam, Z_beam, NormalisedPoissonError,[1 2 5 10 20],'-w');
        %         %         clabel(C2,h2,'Color','w','Rotation',0,'Edgecolor','w');
        %         xlim([-45 45])
        %         ylim([-15 15])
        %         set(gca,'XDir','reverse','FontSize',FontSize)
        %         xlabel('X [mm]','FontSize',FontSize)
        %         ylabel('Z [mm]','FontSize',FontSize)
        %         removemarge
        %         colorbar('FontSize',FontSize)
        %         axis equal
        %
        %         % Figure representing the normalised error inside the whole vacuum chamber
        %         figure('Name','Normalized error between Beam position and position Read by BPM in percent (%)','NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
        %         title('Normalized error between Beam position and position Read by BPM in percent (%)','FontSize',FontSize)
        %         hold all
        %         plot(X_boundary,Z_boundary,'-black')
        %         plot(X_middle_boundary(IndexA),Z_middle_boundary(IndexA),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexB),Z_middle_boundary(IndexB),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexC),Z_middle_boundary(IndexC),ButtonElectrodeColor,...
        %             X_middle_boundary(IndexD),Z_middle_boundary(IndexD),ButtonElectrodeColor)
        %         surf( X_beam, Z_beam, (Qa+Qb)./(Qc+Qd), 'LineStyle', 'None');
        %         %         [C2,h2] = contourf( X_beam, Z_beam, NormalisedPoissonError,[1 2 5 10 20],'-w');
        %         %         clabel(C2,h2,'Color','w','Rotation',0,'Edgecolor','w');
        %         xlim([-45 45])
        %         ylim([-15 15])
        %         set(gca,'XDir','reverse','FontSize',FontSize)
        %         xlabel('X [mm]','FontSize',FontSize)
        %         ylabel('Z [mm]','FontSize',FontSize)
        %         removemarge
        %         colorbar('FontSize',FontSize)
        %         axis equal
        
        %         Tranche = find(...
        %             and(...
        %             (Qa+Qb)./(Qc+Qd)<1.1...
        %             ,(Qa+Qb)./(Qc+Qd)>0.9));
        
        
        
    end
    
end



%% End of function

if EchoFlag
    fprintf(' ===== get_bpm_nonlinear_response_expert Done ===== \n\n');
end


end