function mml_cc_appli(ApplicationName)
%MM_CC_APPLI - Compile a standalone MML/AT application
%
%  NOTES:
%  Each compiled programme is stored in a directory with the date of the day
%  Then a symbolic link has to be done to point on the new application
%  A shortcut to the application is done in the mouse menu
%  Available applications: plotfamily and SOFB

%
%% Written by Laurent S. Nadolski

ConfigFlag = 0;
%
% if nargin == 0
%     ApplicationName = questdlg('Choose programme to compile or deploy as a standalone application', ...
%         'Compilation dialog box', ...
%         'Plotfamily','SOFB', 'TuneFB', 'default');
%     if isempty(ApplicationName)
%         error('Abort: Unknown answer')
%     end
% end

% For interface creation only
if nargin == 0
    ApplicationName = '';
    createInterface;
elseif strcmpi(ApplicationName, 'Help'),
    Helpmessage = sprintf('Pour compiler une application et la déployer\n Cliquez sur le nom de l''application\n');
    helpdlg(Helpmessage)
else
    
    % save current directory
    CurrentDir = pwd;
    
    % Directory to store application
    DirName = getfamilydata('Directory', 'Standalone');
    
%     ApplicationName = lower(ApplicationName);
%     
%     switch ApplicationName
%         case 'plotfamily'
%             ApplicationName = 'plotfamily';
%         case 'sofb'
%             ApplicationName = 'orbitcontrol';
%         case 'fofb'
%             ApplicationName = 'FOFBguiTango';
%         case 'tunefb'
%             ApplicationName = 'tuneFBgui';
%         otherwise
%             error('Unknown application name %s', ApplicationName);
%     end
    
    % check development directory name
    
    if ~isdir(DirName)
        fprintf('Abort: directory %s does not exist!\n', DirName);
        return;
    end
    
    % Create and go to the directory
    DirName = fullfile(DirName, ApplicationName);
    gotodirectory(DirName);
    
        DirDevName = [ApplicationName '_standalone_' datestr(date,29)];
        
        fullName = [DirName filesep DirDevName];
        if exist(fullName, 'dir') == 7
            answer = questdlg('Directory exists already!','Compilation dialog box','Continue','Abort','Default');
            switch answer
                case 'Continue'
                    fprintf('Data will be erased\n')
                case 'Abort'
                    fprintf('Application stopped on user request\n')
                    return;
                otherwise
                    fprintf('Application stopped on user request\n')
                    return;
            end
        end
        
        gotodirectory(fullName);
        
        % Compilation part
        if strcmpi(ApplicationName,'synchro')
            % Does not work as it should yet
            %         eval(['mcc -mv -a AperturePass -a BndMPoleSymplectic4Pass -a BndMPoleSymplectic4RadPass ' ...
            %             '-a CavityPass -a CorrectorPass -a DriftPass -a EAperturePass -a IdentityPass ' ...
            %             '-a Matrix66Pass -a QuadLinearPass -a SolenoidLinearPass -a StrMPoleSymplectic4Pass ' ...
            %             '-a StrMPoleSymplectic4RadPass -a ThinMPolePass -a findmpoleraddiffmatrix ' ...
            %             '-a IdentityPass -a BendLinearPass ', 'synchro_injecteur7_rafale']);
        else
            % Add files in StorageRing (*.txt), AT, MML (wave files)
            eval(['mcc -mv  -a AperturePass -a BndMPoleSymplectic4Pass -a BndMPoleSymplectic4RadPass ' ...
                '-a CavityPass -a CorrectorPass -a DriftPass -a EAperturePass -a IdentityPass ' ...
                '-a Matrix66Pass -a QuadLinearPass -a SolenoidLinearPass -a StrMPoleSymplectic4Pass ' ...
                '-a StrMPoleSymplectic4RadPass -a ThinMPolePass -a findmpoleraddiffmatrix ' ...
                '-a IdentityPass -a BendLinearPass ', ApplicationName]);
        end
        
        
        [pathstr, name, ext, versn] = fileparts(DirName);
        fprintf('\nApplication %s compiled and saved in directory: %s\n', name, DirName)
        fprintf('Directory name is: %s\n\n', DirDevName);
        ConfigFlag = 1;
   if ConfigFlag
    % Deploy programme
        cd(DirName);
        VersionName = uigetdir(DirName, 'Select version to deploy');
        if isempty(VersionName)
            cd(CurrentDir);
            error('Abort: Unknown answer')
        end
        [tmp Appli2deploy] = fileparts(VersionName);
        system(sprintf('rm -v %s', ApplicationName));
        system(sprintf('ln -s -v %s %s', Appli2deploy, ApplicationName));
    end
    
    cd(CurrentDir);
end
end

function gui = createInterface
% Create the user interface for the applicdata.ATion and return a
% structure of handles for global use.

orbfig = findobj(allchild(0),'Name','Kicker Bump Control Room');

% if already open, then close it
if ~isempty(orbfig)
    close(orbfig); % IHM already exists
end

gui = struct();
% Open a window and add some menus
gui.Window = figure( ...
    'Name', 'MML Compilation', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'none', ...
    'Toolbar', 'none', ...
    'HandleVisibility', 'off',...
    'Position', [70 500 400 200]);

% Set default panel color
uiextras.set(gui.Window, 'DefaultBoxPanelTitleColor', [0.7 1.0 0.7] );

%PanelLayout = uiextras.TabPanel( 'Parent', gui.Window);

% Arrange the main interface
main = uiextras.VBox( 'Parent', gui.Window, 'Spacing', 6);
%%-------------------------------------------------------
% + For Application for compilation
uicontrol('Parent',main, 'Callback','mml_cc_appli(''help'')', 'String','Aide','BackgroundColor','y');
uicontrol('Parent',main, 'Callback','mml_cc_appli(''plotfamily'')', 'String','plotfamily');
uicontrol('Parent',main, 'Callback','mml_cc_appli(''orbitcontrol'')', 'String','orbitcontrol');
uicontrol('Parent',main, 'Callback','mml_cc_appli(''tuneFBgui'')', 'String','tuneFBgui');
uicontrol('Parent',main, 'Callback','mml_cc_appli(''couplingFBgui'')', 'String','couplingFBgui');
uicontrol('Parent',main, 'Callback','mml_cc_appli(''configgui'')', 'String','Fichiers de Consignes');
end
