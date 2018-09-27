function BeamLossgui()
%BeamLossgui: user interface for beam losses when RF is switched off
%
%   BeamLossgui() used the GUILayout toolbox.
%
% NOTES:
% Works only with thick sextupoles
% Warning otherwise divergence in sextupoles !!! 

%
%% Written by Laurent S. Nadolski

% Data is shared between all child functions by declaring the variables
% here (they become global to the function). We keep things tidy by putting
% all GUI stuff in one structure and all data stuff in another. As the app
% grows, we might consider making these objects rather than structures.
global THERING;

data = createData();
gui  = createInterface();

% Now update the GUI with the current data
%redrawData();
setradiation('on');
setcavity('off');
onCompute();

%-------------------------------------------------------------------------%
    function data = createData()
        % Create the shared data-structure for this applicdata.ATion
        data.Nturn = 100;
        data.ATi  = atindex;
        data.spos = findspos(THERING,1:length(THERING)+1);        
        
    end % createData

%-------------------------------------------------------------------------%
    function gui = createInterface
        % Create the user interface for the applicdata.ATion and return a
        % structure of handles for global use.
        
        orbfig = findobj(allchild(0),'Name','Beam Loss GUI');
        
        % if already open, then close it
        if ~isempty(orbfig)
            close(orbfig); % IHM already exists
        end
        
        gui = struct();
        % Open a window and add some menus
        gui.Window = figure( ...
            'Name', 'Beam Loss GUI', ...
            'NumberTitle', 'off', ...
            'MenuBar', 'none', ...
            'Toolbar', 'none', ...
            'Toolbar', 'Figure', ...
            'HandleVisibility', 'off' );
        
        % Set default panel color
        uiextras.set( gui.Window, 'DefaultBoxPanelTitleColor', [0.7 1.0 0.7] );
                                
        % + Help menu
        helpMenu = uimenu( gui.Window, 'Label', 'Help' );
        uimenu( helpMenu, 'Label', 'documentation', 'Callback', @onDemoHelp );
        

        % Arrange the main interface
        mainLayout = uiextras.HBoxFlex( 'Parent', gui.Window, 'Spacing', 3 );
        
        % + Create the panels
        
        controlPanel = uiextras.BoxPanel( ...
            'Parent', mainLayout, ...
            'Title', 'Select options:' );

        gui.ViewPanel{1} = uiextras.BoxPanel( ...
            'Parent', mainLayout, ...
            'Title', 'Tracking data', ...
            'HelpFcn', @onDemoHelp );

        % + Adjust the main layout
        set( mainLayout, 'Sizes', [-1,-3]  );

        % + Create the controls
        controlLayout = uiextras.VBox( 'Parent', controlPanel, ...
            'Padding', 3, 'Spacing', 3 );
        
        % + Create panel
        TurnPanel = uiextras.BoxPanel( 'Title', 'Number of turns:', 'Parent', controlLayout );        
        gui.TurnEdit = uicontrol( 'Style', 'edit', ...
            'BackgroundColor', 'w', ...
            'Parent', TurnPanel, ...
            'String', '100', ...
            'Callback', @onTurnEdit);

        % + Create panel
        CoordPanel = uiextras.BoxPanel( 'Title', 'Coordinates @ end', 'Parent', controlLayout );        
        gui.CoordPanel = uicontrol( 'Style', 'text', ...
            'BackgroundColor', 'w', ...
            'Parent', CoordPanel, ...
            'Max', 6, ...
            'FontName', 'FixedWidth', ...
            'String', {'x    =0','px   =0','y    =0','py   =0','delta=0','ctau =0'}, ...
            'Callback', []);

        % + Radiation button
        gui.RadiationCheckBox = uicontrol( 'Style', 'checkbox', ...
            'BackgroundColor', 'w', ...
            'Parent', controlLayout, ...
            'String', 'Radiation', ...
            'Value', 1, ...
            'Callback', @onRadiation);
        
        % + Cavity button
        gui.CavityCheckBox = uicontrol( 'Style', 'checkbox', ...
            'BackgroundColor', 'w', ...
            'Parent', controlLayout, ...
            'String', 'Cavity', ...
            'Value', 0, ...
            'Callback', @onCavity);
        
        % + Reload Button
        gui.ReloadButton = uicontrol( 'Style', 'PushButton', ...
            'Parent', controlLayout, ...
            'String', 'Reload lattice', ...
            'Callback', @onReload );
        
        % + Compute Button
        gui.ComputeButton = uicontrol( 'Style', 'PushButton', ...
            'Parent', controlLayout, ...
            'String', 'Compute', ...
            'Callback', @onCompute );
        
        % + Help Button
        gui.HelpButton = uicontrol( 'Style', 'PushButton', ...
            'Parent', controlLayout, ...
            'String', 'Help', ...
            'Callback', @onDemoHelp );
        set( controlLayout, 'Sizes', [50 3.5*28 28 28 28 28 28] ); % Make the list fill the space
        
        %%%%%%%%%%% 
        PanelLayout = uiextras.TabPanel( 'Parent', gui.ViewPanel{1});

        for k=1:3,
        % + Create the view
        AxesTabPanel{k} = uiextras.VBox( 'Parent', PanelLayout, ...
            'Padding', 40, 'Spacing', 10 );
        
        % + Main axes for draw data
        gui.ViewAxes{k} = axes( 'Parent', AxesTabPanel{k}, ...
            'ActivePositionProperty', 'Position', ...
            'xticklabel', []);        
        
        % + drawlattice
        gui.LatticeAxes{k} = axes( 'Parent', AxesTabPanel{k}, ...
            'ActivePositionProperty', 'Position');
        
        % + Drawlattice Axes
        
        drawlattice(0,1,gui.LatticeAxes{k});
        xlabel(gui.LatticeAxes{k}, 's-position (m)');
        set(gui.LatticeAxes{k},'yticklabel', []);
        %set(gui.LatticeAxes, 'Position', [0.142 0.122 0.751 1])
        xlim(gui.ViewAxes{k}, [0 getcircumference]);
        set(AxesTabPanel{k}, 'Sizes', [-4 -1])
        end
        linkaxes([gui.ViewAxes{:} gui.LatticeAxes{:}],'x')
        set(PanelLayout, 'TabNames', {'x (m)', 'px (rad)', 'delta'}, ...
            'SelectedChild', 1);
    end % createInterface

%-------------------------------------------------------------------------%
    function updateInterface()
        % Update various parts of the interface in response to the demo
        % being changed.
        
        % Update the help button label
        demoName = data.DemoNames{ data.SelectedDemo };
        set( gui.HelpButton, 'String', ['Help for ',demoName] );
    end % updateInterface

%-------------------------------------------------------------------------%
    function redrawData()
        % Draw a demo into the axes provided        
        coord = [1 2 5];
        for k=1:3,
        cla(gui.ViewAxes{k});
        len = size(data.xAllBPMs,2);
        
        % Sampling
        ivect = [(1:10:len) len-1];

        % plot data
        plot(gui.ViewAxes{k}, data.spos, data.xAllBPMs(:,ivect,coord(k)),'k');
        hold(gui.ViewAxes{k},'on');
        ylimits = [-0.040 0.005];
        
        %plot scrapers and mSDC15 if defined
        
        plot(gui.ViewAxes{k},[data.spos(data.ATi.HSCRAP(1)) data.spos(data.ATi.HSCRAP(1))], [0.0 ylimits(1)], 'r-.')
        
        if isfield(data.ATi, 'mSDC15')
            plot(gui.ViewAxes{k},[data.spos(data.ATi.mSDC15) data.spos(data.ATi.mSDC15)], [0.0 ylimits(1)], 'r-.')
        else
            fprintf('mSDC15 marker not defined \n');
        end
        
        ylim(gui.ViewAxes{k}, ylimits);
        set(gui.ViewAxes{k},'xticklabel', []);
        end
        
        if isfield(data.ATi, 'mSDC15')
            xstrTitle = sprintf('Particle lost at turn #%d   H-scraper: %.3f mm SDC15: %.3f mm', ...
                size(data.xAllBPMs,2), data.xAllBPMs(data.ATi.HSCRAP(1), end,1), ...
                data.xAllBPMs(data.ATi.mSDC15, end,1));
        else
            xstrTitle = '';
        end
        
        title(gui.ViewAxes{1}, xstrTitle)
        
        set(gui.CoordPanel, 'String', {...
            sprintf('x     = % .6f', data.xAllBPMs(1,end,1)), ...
            sprintf('px    = % .6f', data.xAllBPMs(1,end,2)), ...
            sprintf('y     = % .6f', data.xAllBPMs(1,end,3)), ...
            sprintf('py    = % .6f', data.xAllBPMs(1,end,4)), ...
            sprintf('delta = % .6f', data.xAllBPMs(1,end,5)), ...
            sprintf('ctau  = % .6f', data.xAllBPMs(1,end,6))});        
    end % redrawData

%-------------------------------------------------------------------------%
    function onTurnEdit(hObj,~)
        % User selected a demo from the list - update "data" and refresh
        data.Nturn = str2double(get( hObj, 'String' ));
        set(hObj, 'BackGroundColor', 'w');
        onCompute();
    end % onTurnEdit

%-------------------------------------------------------------------------%
    function onRadiation( hObj, ~ )
        % User has asked for the documentation
        val = get( hObj, 'Value' );
        if val
            setradiation('on');
        else
            setradiation('off');
        end
    end % onRadiation

%-------------------------------------------------------------------------%
    function onCavity( hObj, ~ )
        % User has asked for the documentation
        val = get( hObj, 'Value' );
        if val
            setcavity('on');
        else
            setcavity('off');
        end
    end % onCavity

%-------------------------------------------------------------------------%
    function onCompute( ~, ~ )
        % Do the tracking
        [data.xAllBPMs, ATindex, data.LostBeam] = getturns([0.0 0 0 0 0.0 0]', data.Nturn, 'All');        
        if ~isempty(data.xAllBPMs)
            redrawData();
        else
            set(gui.TurnEdit, 'BackGroundColor', 'red');
        end        
    end % onCompute

%-------------------------------------------------------------------------%
    function onReload( ~, ~ )
        data.ATi  = atindex;
        data.spos = findspos(THERING,1:length(THERING)+1);
        setradiation('on');
        setcavity('off');
    end % onReload


%-------------------------------------------------------------------------%
    function onDemoHelp( ~, ~ )
        % User wants documentation for the current demo
        help BeamLossgui;
    end % onDemoHelp

%-------------------------------------------------------------------------%
    function onExit( ~, ~ )
        % User wants to quit out of the applicdata.ATion
        delete( gui.Window );
    end % onExit

end % EOF