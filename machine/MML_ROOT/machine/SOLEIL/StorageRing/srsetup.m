function srsetup
%SRSETUP - GUI for doing storage ring setup
% GUI for doing storage ring setup
%
% Written by Laurent S. Nadolski

checkforao;
createInterface

function gui = createInterface
% Create the user interface for the applicdata.ATion and return a
% structure of handles for global use.

orbfig = findobj(allchild(0),'Name','Expert Menu Control Room');

% if already open, then close it
if ~isempty(orbfig)
    close(orbfig); % IHM already exists
end

gui = struct();
% Open a window and add some menus
gui.Window = figure( ...
    'Name', 'Expert Menu Control Room (srsetup)', ...
    'NumberTitle', 'off', ...
    'MenuBar', 'none', ...
    'Toolbar', 'none', ...
    'HandleVisibility', 'off' );

% Set default panel color
uiextras.set(gui.Window, 'DefaultBoxPanelTitleColor', [0.7 1.0 0.7] );

PanelLayout = uiextras.TabPanel( 'Parent', gui.Window);

% Arrange the main interface
% + MML based functions
mmlLayout = uiextras.HBox( 'Parent', PanelLayout, 'Spacing', 3);
% + Genuine AT functions
ATLayout  = uiextras.HBox( 'Parent', PanelLayout, 'Spacing', 3);
% + Tests functions
TestLayout  = uiextras.HBox( 'Parent', PanelLayout, 'Spacing', 3);

set(PanelLayout,'TabNames', {'SDC', 'Model', 'Test functions'}, 'SelectedChild', 1);
% + Make bigger Tabs
set(PanelLayout,'TabSize', 100)
% Colors tab and top bar
set(PanelLayout,'BackgroundColor', [ 0.7 0.7 1])

% + Create the panels

mmlColumn(1) = uiextras.BoxPanel( ...
    'Parent', mmlLayout, ...
    'Title', 'Select options:' );
mmlColumn(2) = uiextras.BoxPanel( ...
    'Parent', mmlLayout, ...
    'Title', 'BPM/orbit functions:' );
mmlColumn(3) = uiextras.BoxPanel( ...
    'Parent', mmlLayout, ...
    'Title', 'Select options:' );
mmlColumn(4) = uiextras.BoxPanel( ...
    'Parent', mmlLayout, ...
    'Title', 'Select options:' );

% + Adjust the main layout
%set( mmlLayout, 'Sizes', ones(1,4)*-1);

% + Create Layout for First mmlColumn
mmlColumnLayout{1} = uiextras.VBox( 'Parent', mmlColumn(1), ...
    'Padding', 3, 'Spacing', 3 );
uicontrol('Parent',mmlColumnLayout{1}, 'Callback','setpathsoleil(''StorageRing'');', 'String','Soleilinit','BackgroundColor','g');
uicontrol('Parent',mmlColumnLayout{1}, 'Callback','refreshthering', 'String','Recharger la maille');
%uicontrol('Parent',mmlColumnLayout{1}, 'Callback','plotfamily', 'String','Plotfamily');
%uicontrol('Parent',mmlColumnLayout{1}, 'Callback','disp([''   Fichiers de Consignes;'']); configgui;;', 'String','Fichiers de Consignes');
uicontrol('Parent',mmlColumnLayout{1}, 'Callback','InjectionKickerBumpTuningGui', 'String','Qualité Fermeture KInj', 'BackgroundColor','c');
uicontrol('Parent',mmlColumnLayout{1}, 'Callback','kicker_scaling', 'String', 'Kicker scaling', 'BackgroundColor','c');
uicontrol('Parent',mmlColumnLayout{1}, 'Callback','showkicker','String','Print Injection Kicker', 'BackgroundColor','c');
uicontrol('Parent',mmlColumnLayout{1}, 'Callback','steerette', 'String','Steerette', 'BackgroundColor','y');
uicontrol('Parent',mmlColumnLayout{1}, 'Callback','energytunette', 'String', 'Energytunette', 'BackgroundColor','y');
uicontrol('Parent',mmlColumnLayout{1}, 'Callback','fourturnalgorithm', 'String', '<html> Nombres d onde <br/><br> Algo 4 tours');
uicontrol('Parent',mmlColumnLayout{1}, 'Callback','getnus', 'String', 'Synchrotron tune');
uicontrol('Parent',mmlColumnLayout{1}, 'Callback','plot_synchrotron_tune_scan', 'String', 'Scan Synch. tune');

% + Create Layout for Second mmlColumn
%%-------------------------------------------------------
mmlColumnLayout{2} = uiextras.VBox( 'Parent', mmlColumn(2), ...
    'Padding', 3, 'Spacing', 3 );
%%-------------------------------------------------------
uicontrol('Parent',mmlColumnLayout{2}, 'Callback','figure;plotorbit;', 'String','Plotorbit');
uicontrol('Parent',mmlColumnLayout{2},  'Callback','solorbit', 'String','solorbit');
uicontrol('Parent',mmlColumnLayout{2},  'Callback','figure; disp([''   setorbit;'']); setorbit(''Display'');', 'String','Correction d''orbite');
uicontrol('Parent',mmlColumnLayout{2},  'Callback','figure; disp([''   setorbitbumpgui;'']); setorbitbumpgui;', 'String','Bump d''orbite (IHM)');
%uicontrol('Parent',mmlColumnLayout{2},  'Callback','disp([''   measbpmresp;'']); measbpmresp;', 'String','Generate BPM Response Matrix');
%uicontrol('Parent',mmlColumnLayout{2},  'Callback','figure; disp([''   rmdisp;'']); rmdisp(''BPMx'',''Display'');', 'String','Find New RF Frequency (LS Fit)');
%uicontrol('Parent',mmlColumnLayout{2},  'Callback','figure; disp([''   findrf;'']); findrf;', 'String','Find New RF Frequency (Dot Product)');
%uicontrol('Parent',mmlColumnLayout{2},  'Callback','disp([''   gettune;'']); gettune(''Display'');', 'String','Get Tunes');
%uicontrol('Parent',mmlColumnLayout{2},  'Callback','disp([''   settune;'']); settune;', 'String','Set Tunes');
uicontrol('Parent',mmlColumnLayout{2},  'Callback','getbpmsum;', 'String','Signal Somme (1er tour)', 'BackgroundColor','c');
uicontrol('Parent',mmlColumnLayout{2},  'Callback','nombre_onde_ans;', 'String','FFT Tour par Tour');
uicontrol('Parent',mmlColumnLayout{2},  'Callback','bpmconfigurator;', 'String','Configuration BPM', 'BackgroundColor','r');
uicontrol('Parent',mmlColumnLayout{2}, 'Callback','getbpmagcgain', 'String','BPM gain AGC');
uicontrol('Parent',mmlColumnLayout{2}, 'Callback','getbpmBBAoffsets', 'String','Offset BBA');
uicontrol('Parent',mmlColumnLayout{2}, 'Callback','printSourcePoint', 'String','Source points','BackgroundColor','g')
uicontrol('Parent',mmlColumnLayout{2}, 'Callback','getatxnanosourcepoint', 'String','SourcePoint: ATX Nano','BackgroundColor','g')

%%-------------------------------------------------------
mmlColumnLayout{3} = uiextras.VBox( 'Parent', mmlColumn(3), ...
    'Padding', 3, 'Spacing', 3 );
%%-------------------------------------------------------
uicontrol('Parent',mmlColumnLayout{3}, 'Callback','tango_staticdb_config', 'String','DBT config','BackgroundColor','r');
uicontrol('Parent',mmlColumnLayout{3}, 'Callback','tango_archiving_config', 'String','Archivage');
uicontrol('Parent',mmlColumnLayout{3}, 'Callback','disp([''   meastuneresp;'']); meastuneresp;', 'String','<html>Generate Tune <br/><br>Response Matrix');
%uicontrol('Parent',mmlColumnLayout{3}, 'Callback','figure; disp([''   measdisp;'']); measdisp;', 'String','Measure Dispersion');
%uicontrol('Parent',mmlColumnLayout{3}, 'Callback','figure; disp([''   measchro;'']); measchro(''Physics'');', 'String','Measure The Chromaticity');
%uicontrol('Parent',mmlColumnLayout{3}, 'Callback','disp([''   stepchro;'']); stepchro(''Physics'');', 'String','Step The Chromaticity');
uicontrol('Parent',mmlColumnLayout{3}, 'Callback','mml_cc_appli', 'String','<html>Compile MML  <br/><br>applications','BackgroundColor','r');

uicontrol('Parent',mmlColumnLayout{3}, 'Callback','disp([''   getmachineconfig;'']); getmachineconfig(''Archive'');', 'String','Save Lattice');
uicontrol('Parent',mmlColumnLayout{3}, 'Callback','disp([''   setmachineconfig;'']); setmachineconfig;', 'String','Load Lattice');

%%-------------------------------------------------------
mmlColumnLayout{4} = uiextras.VBox( 'Parent', mmlColumn(4), ...
    'Padding', 3, 'Spacing', 3 );
%%-------------------------------------------------------
%uicontrol('Parent',mmlColumnLayout{4}, 'Callback','couplage_2012', 'String','Couplage 2012 (MAT)','BackgroundColor','c');
uicontrol('Parent',mmlColumnLayout{4}, 'Callback','geophonegui', 'String','Geophones','BackgroundColor','c');
uicontrol('Parent',mmlColumnLayout{4}, 'Callback','plotquad;', 'String','Etat QUAD');
% Trick to write label on 2 lines (sprintf does not work) : use html see UndocumentedMAtlab.com and MAtlab Forum
uicontrol('Parent',mmlColumnLayout{4}, 'Callback','bpmrespmatgui;', 'String','<html>LOCO Interface <br/><br>Matrice réponse','BackgroundColor','c');
uicontrol('Parent',mmlColumnLayout{4}, 'Callback','BeamLossgui;', 'String','Beam Loss w/o RF');
uicontrol('Parent',mmlColumnLayout{4}, 'Callback','showcavitystatus;', 'String','RF cavity parameters');
uicontrol('Parent',mmlColumnLayout{4}, 'Callback','idGetPowerForUndSoleil(''Display'')', 'String','<html>Puissance rayonnée<br/><br>Insertions');

%% to be modified
uicontrol('Parent',mmlColumnLayout{4}, 'Callback','cd(''/home/data/matlab/data4mml/measdata/SOLEIL/StorageRingdata/KickerEM''); measFMA_gui', 'String','Interface FMA', 'BackgroundColor','c');

% + Create the panels
%%-------------------------------------------------------
ATColumn(1) = uiextras.BoxPanel( ...
    'Parent', ATLayout, ...
    'Title', 'AT functions:', ...
    'HelpFcn', 'doc(''at'')' );
ATColumn(2) = uiextras.BoxPanel( ...
    'Parent', ATLayout, ...
    'Title', 'MML functions:', ...
    'HelpFcn', 'doc(''at'')' );
ATColumn(3) = uiextras.BoxPanel( ...
    'Parent', ATLayout, ...
    'Title', 'Simulation', ...
    'HelpFcn', 'doc(''at'')' );

for ik=1:length(ATColumn),
    ATColumnLayout{ik} = uiextras.VBox( 'Parent', ATColumn(ik), ...
        'Padding', 3, 'Spacing', 3 );
end
%%-------------------------------------------------------
% + For control room
uicontrol('Parent',ATColumnLayout{1}, 'Callback','plotbeta', 'String','Beta function');
uicontrol('Parent',ATColumnLayout{1}, 'Callback','plotcod', 'String','Cod function');
uicontrol('Parent',ATColumnLayout{1}, 'Callback','intlat', 'String','Synoptics');

%+ For model
uicontrol('Parent',ATColumnLayout{2}, 'Callback','modelalpha', 'String','Alpha function');
uicontrol('Parent',ATColumnLayout{2}, 'Callback','modelbeamsize', 'String','Beam sizesfunction');
uicontrol('Parent',ATColumnLayout{2}, 'Callback','modelbeta', 'String','Beta function');
uicontrol('Parent',ATColumnLayout{2}, 'Callback','modeldisp', 'String','Dispersion function');
uicontrol('Parent',ATColumnLayout{2}, 'Callback','modeletaprime', 'String','Dispersion'' function');
uicontrol('Parent',ATColumnLayout{2}, 'Callback','modelemit', 'String','Emittance');
uicontrol('Parent',ATColumnLayout{2}, 'Callback','modelcurlh', 'String','H-function');
uicontrol('Parent',ATColumnLayout{2}, 'Callback','modelphase', 'String','Phase function');

%+ For simulation (Office, Hyperion, etc.. )
uicontrol('Parent',ATColumnLayout{3}, 'Callback','naffgui', 'String','Naff plotting (Tracy)');
uicontrol('Parent',ATColumnLayout{3}, 'Callback','resongui', 'String','Resonance plot');
uicontrol('Parent',ATColumnLayout{3}, 'Callback','RadiaMapGui', 'String','Radia maps');
uicontrol('Parent',ATColumnLayout{3}, 'Callback','mosteffectivecorrectorgui', 'String','MostEffective Corrector');

% + Create the panels
%%-------------------------------------------------------
TestColumn(1) = uiextras.BoxPanel( ...
    'Parent', TestLayout, ...
    'Title', 'Not validated functions:', ...
    'HelpFcn', 'doc(''at'')' );
TestColumnLayout{1} = uiextras.VBox( 'Parent', TestColumn(1), ...
    'Padding', 3, 'Spacing', 3 );
uicontrol('Parent',TestColumnLayout{1}, 'Callback','plotBPMturns', 'String','PLot BPM TbT Data');
uicontrol('Parent',TestColumnLayout{1}, 'Callback','KEMgui', 'String','KEM gui');
uicontrol('Parent',TestColumnLayout{1}, 'Callback','TbT_PSBgui', 'String','PSB gui');
uicontrol('Parent',TestColumnLayout{1}, 'Callback','TbTgui', 'String','Interface Tour par tour', 'BackgroundColor','c');

return;

