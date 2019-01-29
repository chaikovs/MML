function InjectionKickerBumpTuningGui
%SRSETUP - GUI for doing storage ring setup
% GUI for doing storage ring setup
%
% Written by Laurent S. Nadolski

checkforao;
createInterface

function gui = createInterface
% Create the user interface for the applicdata.ATion and return a
% structure of handles for global use.

orbfig = findobj(allchild(0),'Name','Tuning Kicker Bump Control Room');

% if already open, then close it
if ~isempty(orbfig)
    close(orbfig); % IHM already exists
end

gui = struct();
% Open a window and add some menus
gui.Window = figure( ...
    'Name', 'Tuning Kicker Bump Control Room', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'none', ...
    'Toolbar', 'none', ...
    'HandleVisibility', 'off',...
    'Position', [70 500 200 200]);

% Set default panel color
uiextras.set(gui.Window, 'DefaultBoxPanelTitleColor', [0.7 1.0 0.7] );

%PanelLayout = uiextras.TabPanel( 'Parent', gui.Window);

% Arrange the main interface
main = uiextras.VBox( 'Parent', gui.Window, 'Spacing', 5);

%%-------------------------------------------------------
% + For Orbit



uicontrol('Parent',main,  'Callback', @showhelp, 'String','Aide',...
    'BackgroundColor','y', 'TooltipString', 'Procedure pour la mesure');
uicontrol('Parent',main, 'Callback','set_kicker_eventto5; mesure_bump_quart; set_kicker_eventto3;', ...
    'String','Qualité Fermeture Kincker Injection', 'BackgroundColor','g', ...
    'TooltipString', 'Mesure automatique');
uicontrol('Parent',main, 'String','Commandes individuelles','BackgroundColor','y', ...
    'Enable', 'Inactive');
uicontrol('Parent',main, 'Callback','set_kicker_eventto5', 'String','Event 5 (Kickers  seuls)', ...
    'TooltipString', 'Injection interdite');
uicontrol('Parent',main, 'Callback','mesure_bump_quart', 'String','mesure_bump_quart');
uicontrol('Parent',main, 'Callback','set_kicker_eventto3', 'String','Event 3 (inj)', ...
    'TooltipString', 'Injection de nouveau autorisee');

function showhelp(hObject,eventdata)

prompt={'Mesure de la fermeture des bump des 4 kickers: seuls le plan H est ajustable au moyen des 4 tensions des kickers et des 4 retards', ... 
        '', ...
        'Programme expert: Kicker_bump_rapide', ...
        '', ...
        'A bas courant: injecter dans 1/4 et faire la mesure x3 (bouton vert)', ...
        '', ...
        'A fort courant: en 3/4 ou 4/4, les mesures entre quart sont quasiment identiques' };
name='Aide : fermeture bump injection';
helpdlg(prompt,name);


return;

