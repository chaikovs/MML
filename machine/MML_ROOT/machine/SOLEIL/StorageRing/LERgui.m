function LERgui
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
            'Name', 'Expert Menu Control Room', ...
            'NumberTitle', 'off', ...
            'MenuBar', 'none', ...
            'Toolbar', 'none', ...
            'HandleVisibility', 'off' );
        
        % Set default panel color
        uiextras.set(gui.Window, 'DefaultBoxPanelTitleColor', [0.7 1.0 0.7] );
        
        PanelLayout = uiextras.TabPanel( 'Parent', gui.Window);
        
        % Arrange the main interface
        % + MML based functions
        atLayout = uiextras.HBox( 'Parent', PanelLayout, 'Spacing', 3);
        % + Genuine AT functions
        ATLayout  = uiextras.HBox( 'Parent', PanelLayout, 'Spacing', 3);
        
        set(PanelLayout,'TabNames', {'AT (ESRF)', 'Optimize'}, 'SelectedChild', 1);
        % + Make bigger Tabs
        set(PanelLayout,'TabSize', 100)
        % Colors tab and top bar
        set(PanelLayout,'BackgroundColor', [ 0.7 0.7 1])
        
        % + Create the panels
        
        mmlColumn(1) = uiextras.BoxPanel( ...
            'Parent', atLayout, ...
            'Title', 'Atplot:' );
        mmlColumn(2) = uiextras.BoxPanel( ...
            'Parent', atLayout, ...
            'Title', 'BPM/orbit functions:' );
        mmlColumn(3) = uiextras.BoxPanel( ...
            'Parent', atLayout, ...
            'Title', 'Select options:' );
        mmlColumn(4) = uiextras.BoxPanel( ...
            'Parent', atLayout, ...
            'Title', 'Select options:' );
        
        % + Adjust the main layout
        %set( mmlLayout, 'Sizes', ones(1,4)*-1);
        
        % + Create Layout for First mmlColumn
        atColumnLayout{1} = uiextras.VBox( 'Parent', mmlColumn(1), ...
            'Padding', 3, 'Spacing', 3 );
        uicontrol('Parent',atColumnLayout{1}, 'Callback',{@atplot_, 'beta0'}, 'String','beta/eta - Sextu off');
        uicontrol('Parent',atColumnLayout{1}, 'Callback',{@atplot_, 'phase'}, 'String','beta/eta/phase');
        uicontrol('Parent',atColumnLayout{1}, 'Callback',{@atplot_, 'sqrtbetadispcurlyh'}, 'String','sqrtbetadispcurlyh');
        uicontrol('Parent',atColumnLayout{1}, 'Callback',{@atplot_, 'betadispcurlyh'}, 'String','betadispcurlyh');
        uicontrol('Parent',atColumnLayout{1}, 'Callback',{@atplot_, 'SigmaSigmap'}, 'String','SigmaSigmap');
        uicontrol('Parent',atColumnLayout{1}, 'Callback',{@atplot_, 'EmitContrib'}, 'String','EmitContrib');
        uicontrol('Parent',atColumnLayout{1}, 'Callback',{@atplot_, 'WdispP'}, 'String','WdispP');
        uicontrol('Parent',atColumnLayout{1}, 'Callback',{@atplot_, 'PolynomBSxtOct'}, 'String','PolynomBSxtOct');
        uicontrol('Parent',atColumnLayout{1}, 'Callback',{@atplot_, 'envelope'}, 'String','envelope');
        uicontrol('Parent',atColumnLayout{1}, 'Callback',{@atplot_, 'plxi'}, 'String','xi function');
        
        % + Create Layout for Second mmlColumn
        %%-------------------------------------------------------
        atColumnLayout{2} = uiextras.VBox( 'Parent', mmlColumn(2), ...
            'Padding', 3, 'Spacing', 3 );
        %%-------------------------------------------------------
        uicontrol('Parent',atColumnLayout{2}, 'Callback',@(src,event)plotDA_atplot_(src, event,0), 'String','Dynamic aperture');
        uicontrol('Parent',atColumnLayout{2}, 'Callback',@(src,event)plotDA_atplot_(src, event,0, 'Short'), 'String','DA (SHort)');
        uicontrol('Parent',atColumnLayout{2}, 'Callback',@(src,event)plotDA_atplot_(src, event,0.01), 'String','Dynamic aperture @ 1%');
        uicontrol('Parent',atColumnLayout{2}, 'Callback',@(src,event)plotDA_atplot_(src, event,-0.01), 'String','Dynamic aperture @ -1%');
        uicontrol('Parent',atColumnLayout{2}, 'Callback',@(src,event)plothklmn_(src, event,'H1'), 'String','1st order Driving terms');
        uicontrol('Parent',atColumnLayout{2}, 'Callback',@(src,event)plothklmn_(src, event,'H2'), 'String','2nd order Driving terms');
        %        RING_matched2 = matchchro(RING_matched2);
        %%-------------------------------------------------------
        atColumnLayout{3} = uiextras.VBox( 'Parent', mmlColumn(3), ...
            'Padding', 3, 'Spacing', 3 );
        %%-------------------------------------------------------
        uicontrol('Parent',atColumnLayout{3}, 'Callback',@(src,event)ataddmagnetnamestoplot_(src, event), 'String','Label');
        uicontrol('Parent',atColumnLayout{3}, 'Callback',@(src,event)magnetStrength_(src, event,'Bend'), 'String','Dipole');
        uicontrol('Parent',atColumnLayout{3}, 'Callback',@(src,event)magnetStrength_(src, event,'Quadrupole'), 'String','Quadrupole');
        uicontrol('Parent',atColumnLayout{3}, 'Callback',@(src,event)magnetStrength_(src, event,'Sextupole'), 'String','Sextupole');
        
        %%-------------------------------------------------------
        atColumnLayout{4} = uiextras.VBox( 'Parent', mmlColumn(4), ...
            'Padding', 3, 'Spacing', 3 );
        %%-------------------------------------------------------
        uicontrol('Parent',atColumnLayout{4}, 'Callback','close all', 'String','Close figure');
        uicontrol('Parent',atColumnLayout{4}, 'Callback','figure', 'String','New figure');
        
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
        uicontrol('Parent',ATColumnLayout{3}, 'Callback','close all', 'String','Close figure');
        
        
    end
return;
    function atplot_(hObj,event,stype) %#ok<INUSL>
        
        RING = evalin('base', 'RING_matched2');
        
        switch stype
            case 'beta0'
                atplot(atsextuoff(RING));
            case 'beta'
                atplot(RING)
            case 'sqrtbetadispcurlyh'
                atplot(RING,@plotsqrtbetadispcurlyh)
            case 'betadispcurlyh'
                atplot(RING,@plotbetadispcurlyh)
            case 'SigmaSigmap'
                atplot(RING,@plSigmaSigmap)
            case 'EmitContrib'
                atplot(RING,@plEmitContrib);
            case 'WdispP'
                atplot(RING,@plotWdispP);
            case 'PolynomBSxtOct'
                atplot(RING,@plPolynomBSxtOct);
            case 'envelope'
                atplot(RING,@plenvelope);
            case 'phase'
                atplot(RING,@plphase);
            otherwise
                error('unkown option')
        end
        
    end

    function plotDA_atplot_(hObj,event,dp,varargin)
        %%
        RING = evalin('base', 'RING_matched2');
        normalizedFlag = 1;
        [xx,zz]=atdynap(RING,500,varargin{:});
        
        if isempty(varargin) || ~strcmpi('Short', varargin{:})
        if normalizedFlag 
            xxn = xx/sqrt(betx(RING,1))*1e3;
            zzn = zz/sqrt(betx(RING,2))*1e3;
            
            figure ; 
            subplot(1,2,1)
            plot(xxn,zzn);
            xlabel('H-amplitude');
            ylabel('V-amplitude');
            title('Normalized Dynamic aperture')
            subplot(1,2,2)
            plot(xx*1e3,zz)*1e3;
            xlabel('H-amplitude (mm)');
            ylabel('V-amplitude (mm)');
            title('Dynamic aperture')
        else            
            figure ; plot(xx*1e3,zz*1e3);
            xlabel('H-amplitude (mm)');
            ylabel('V-amplitude (mm)');
            title('Dynamic aperture')
        end
        end
    end

    function plothklmn_(hObj,event, Type)
        RING = evalin('base', 'RING_matched2');
        indsxt = findcells(RING,'Class','Sextupole')
        [l,t,c]=atlinopt(RING,0,indsxt);
        H = RDTSext2nd(RING,indsxt,l,t, 'Display', Type);
    end

    function magnetStrength_(hObj,event, classType)
        RING_matched2 = evalin('base', 'RING_matched2');
        global GLOBVAL;
            try
                E0=r{1}.Energy;
            catch
                try
                    E0=GLOBVAL.E0;
                catch
                    warning('no energy defined set  E0=0.')
                    E0=0;
                end
            end
        
        Brho=3.3356*E0/1e9;

        %%
        idx = findcells(RING_matched2, 'Class', classType);
        
        switch classType
            case 'Bend'
                
                ik =1:8;
                for k = ik,
                    angle(k) = RING_matched2{idx(k)}.BendingAngle;
                    len(k) = RING_matched2{idx(k)}.Length;
                end
                
                figure;
                subplot(2,1,1)
                plot(angle(ik)*Brho./len(ik))
                ylabel('B (T)')
                xlabel('Bending slice number')
                title('Dipole 1')
                
                ik = 9:16;
                for k = 9:16,
                    angle(k) = RING_matched2{idx(k)}.BendingAngle;
                    len(k) = RING_matched2{idx(k)}.Length;
                end
                
                subplot(2,1,2)
                plot(angle(ik)*Brho./len(ik))
                ylabel('B (T)')
                xlabel('Bending slice number')
                title('Dipole 2')
                
            case 'Quadrupole'
                
                for k = 1:length(idx),
                    quad(k)  = RING_matched2{idx(k)}.PolynomB(2);
                    quadL(k) = RING_matched2{idx(k)}.PolynomB(2)*Brho;
                end
                
                
                figure
                bar(quadL)
                title('Quadrupole')
                ylabel('Strength T/m')
                
                
            case 'Sextupole'
                for k = 1:length(idx),
                    K(k) = RING_matched2{idx(k)}.PolynomB(3)*Brho;
                end
                
                figure
                bar(K)
                title('Sextupole standard length: 0.1 m long')
                ylabel('Strength T/m2')
                
        end
    end
    function ataddmagnetnamestoplot_(hObj,event, classType)
            RING_matched2 = evalin('base', 'RING_matched2');
        ataddmagnetnamestoplot(gcf, RING_matched2)
    end
end
