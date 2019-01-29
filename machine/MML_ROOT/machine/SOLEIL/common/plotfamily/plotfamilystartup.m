function handles = plotfamilystartup(handles)
% plotfamilystartup - Additional plotfamily menu for SOLEIL

%% Laurent Nadolski
% Adapted form Gregory Portmann

% Disable setpoint GUI
set(handles.DisabledSetpointChanges, 'Checked', 'On');

Sectors = 16; % number of sectors
Straights = 24; % numberof straight sections
StraigthPosition = [0; getspos('BPMx', getidbpmlist)];
% is it the best place for these definitions? soleilinit
IDName = ...
    family2common('BeamLine',[ 1 1; 2 1; 2 3; 3 1; 3 3; 4 1;
    5 1; 6 1; 6 2; 7 1; 7 2; 8 1;
    9 1;10 1;10 2;11 1;11 2;12 1;
    13 1;14 1;14 2;15 1;15 2;16 1;
    ]);
StraigthName = {['SDL01 (' IDName{1} ')'], ['SDM02 (' IDName{2} ')'],['SDC02 (' IDName{3} ')'], ...
    ['SDM03 (' IDName{4} ')'], ['SDC03 (' IDName{5} ')'], ['SDM04 (' IDName{6} ')'], ...
    ['SDL05 (' IDName{7} ')'], ['SDM06 (' IDName{8} ')'], ['SDC06 (' IDName{9} ')'], ...
    ['SDM07 (' IDName{10} ')'], ['SDC07 (' IDName{11} ')'], ['SDM08 (' IDName{12} ')'], ...
    ['SDL09 (' IDName{13} ')'], ['SDM10 (' IDName{14} ')'], ['SDC10 (' IDName{15} ')'], ...
    ['SDM11 (' IDName{16} ')'], ['SDC11 (' IDName{17} ')'], ['SDM12 (' IDName{18} ')'], ...
    ['SDL13 ( ATX NANO )'], ['SDM14 (' IDName{20} ')'], ['SDC14 (' IDName{21} ')'], ...
    ['SDM15 (' IDName{22} ')'], ['SDC15 (' IDName{23} ')'], ['SDM16 (' IDName{24} ')'], ...
    };

Superperiods = 4; % number of superperiods

L = getfamilydata('Circumference');
if ~isempty(L)
    % Add a sector menu
    % Using a [Arc Straight] nomenclature
    Menu0 = uimenu(handles.figure1, 'Label', 'Sectors');
    set(Menu0, 'Position', 3);
    set(Menu0, 'Separator', 'On');
    
    % Arc sections
    Extra = 5;  % meters
    i = 1;
    Menu1 = uimenu(Menu0, 'Label', sprintf('Arc Sector %d',i));
    set(Menu1,'Callback', ['plotfamily(''HorizontalAxisSector_Callback'',gcbo,[', sprintf('%f %f',[0 Extra+L/Sectors]+(i-1)*L/Sectors),'],guidata(gcbo))']);
    for i = 2:Sectors-1
        Menu1 = uimenu(Menu0, 'Label', sprintf('Arc Sector %d',i));
        set(Menu1,'Callback', ['plotfamily(''HorizontalAxisSector_Callback'',gcbo,[', sprintf('%f %f',[0-Extra Extra+L/Sectors]+(i-1)*L/Sectors),'],guidata(gcbo))']);
    end
    i = Sectors;
    Menu1 = uimenu(Menu0, 'Label', sprintf('Arc Sector %d',i));
    set(Menu1,'Callback', ['plotfamily(''HorizontalAxisSector_Callback'',gcbo,[', sprintf('%f %f',[L-L/Sectors-Extra L]),'],guidata(gcbo))']);
    
    % Add Straight section menu
    Menu0 = uimenu(handles.figure1, 'Label', 'Straights');
    set(Menu0, 'Position', 4);
    set(Menu0, 'Separator', 'On');
    % Straight sections
    Extra = 10;  % meters
    for i = 1:Straights-1
        Menu1 = uimenu(Menu0, 'Label', sprintf('%s',StraigthName{i}));
        set(Menu1,'Callback', ['plotfamily(''HorizontalAxisSector_Callback'',gcbo,[', sprintf('%f %f',[-Extra+StraigthPosition(2*i-1) Extra+StraigthPosition(2*i)]),'],guidata(gcbo))']);
    end
    Menu1 = uimenu(Menu0, 'Label', sprintf('%s',StraigthName{end}));
    set(Menu1,'Callback', ['plotfamily(''HorizontalAxisSector_Callback'',gcbo,[', sprintf('%f %f',[-Extra+StraigthPosition(end-1) Extra+StraigthPosition(end)]),'],guidata(gcbo))']);
    
    
    %not elegant method for getmode of machine
    [~, WHO] = system('whoami');
    % system gives back an visible character: carriage return!
    % so comparison on the number of caracters
    if strncmp(WHO, 'operateur',9),
        % Edit menu to put GetArchingDataFile
%         f0 = uimenu('Label','Archiving');
%         uimenu(f0,'Label','Get archived data (average 1 min) and stored in FileDataBuffer ','Callback',{@get_Data_Archived,handles});
%         uimenu(f0,'Label','Save archived data in file ','Callback',{@Save_Data_Archived,handles});
        f0 = uimenu('Label','Extra');
        uimenu(f0,'Label','Get archived data (average 1 min) and stored in FileDataBuffer ','Callback',{@get_Data_Archived,handles});
        uimenu(f0,'Label','Save archived data in file ','Callback',{@Save_Data_Archived,handles}); 
        uimenu(f0,'Label','Persistence for Trace1','Separator','on','Enable','on','Callback',{@ActivatePersistence,handles,1});
        uimenu(f0,'Label','Get RefOrbit of FOFB in FileDataBuffer','Separator','on','Callback',{@get_RefOrbit_FOFB,handles});
        uicontrol(gcf,'Style','checkbox','Tag','ChkB_Snap','String','Snapshot 7-15-23','Units','normalized','Position',[.80 .96 .12 .05],'UserData',0);
        pb = uicontrol(gcf,'Style','pushbutton','String','Snapshot','Units','normalized','Position',[.95 .95 .05 .05],'BackgroundColor','g','Callback',{@Snapshot_Elog,handles,0});

        % does not work with menu see http://www.mathworks.fr/matlabcentral/answers/15058-possible-to-set-a-tooltip-for-each-option-of-a-popupmenu
        %set(f1,'TooltipString', 'Average HDB data over 1 min for the selected family');
    end
    %Callback menu to Draw or UnDraw some elements of lattice Like RFCavity
    f3 = uimenu('Label','Draw');
    handles.DrawRF = uimenu(f3,'Label','DrawRF');
    handles.DrawID = uimenu(f3,'Label','DrawID');
    handles.ID_Name = uimenu(f3,'Label','ID_Name');
    handles.BeamLineName = uimenu(f3,'Label','BeamLineName');
    handles.clearDraw = uimenu(f3,'Label','ClearDraw');
    
    % just at the end to assure that handles is well known
    set(handles.DrawRF,'Callback', {@RefreshLAxes,handles,'DrawRFcav'});
    set(handles.DrawID,'Callback', {@RefreshLAxes,handles,'DrawID'});
    set(handles.ID_Name,'Callback', {@RefreshLAxes,handles,'ID_Name'});
    set(handles.BeamLineName,'Callback', {@RefreshLAxes,handles,'BeamLine_Name'});
    set(handles.clearDraw,'Callback', {@RefreshLAxes,handles,'ClearDraw'});
    
    % Add Superperiod menu
    Menu0 = uimenu(handles.figure1, 'Label', 'Superperiod');
    set(Menu0, 'Position', 5);
    set(Menu0, 'Separator', 'On');
    
    handles.all = uimenu(Menu0, 'Label', sprintf('Whole ring'));
    set(handles.all,'Checked', 'On');
    
    handles.superperiod1 = uimenu(Menu0, 'Label', 'Superperiod 1');
    
    handles.superperiod2 = uimenu(Menu0, 'Label', 'Superperiod 2');
    
    handles.superperiod3 = uimenu(Menu0, 'Label', 'Superperiod 3');
    
    handles.superperiod4 = uimenu(Menu0, 'Label', 'Superperiod 4');
    
    % just at the end to assure that handles is well known
    set(handles.all,'Callback', ['plotfamily(''HorizontalAxisSector_Callback'',gcbo,[', sprintf('%f %f',[0 L]),'],guidata(gcbo))']);
    set(handles.superperiod1,'Callback', ['plotfamily(''HorizontalAxisSector_Callback'',gcbo,[', sprintf('%f %f',[0 L/Superperiods]),'],guidata(gcbo))']);
    set(handles.superperiod2,'Callback', ['plotfamily(''HorizontalAxisSector_Callback'',gcbo,[', sprintf('%f %f',[L/Superperiods 2*L/Superperiods]),'],guidata(gcbo))']);
    set(handles.superperiod3,'Callback', ['plotfamily(''HorizontalAxisSector_Callback'',gcbo,[', sprintf('%f %f',[2*L/Superperiods 3*L/Superperiods]),'],guidata(gcbo))']);
    set(handles.superperiod4,'Callback', ['plotfamily(''HorizontalAxisSector_Callback'',gcbo,[', sprintf('%f %f',[3*L/Superperiods L]),'],guidata(gcbo))']);
    
    set(handles.DrawRF, 'Checked', 'On');
    set(handles.DrawID, 'Checked', 'On');
end
function ActivatePersistence(hObject,callbackdata,handles,Menu)
 if Menu
     HPersTrc1=findobj('Label','Persistence for Trace1');
     val=get(HPersTrc1,'UserData');    
            if isempty(val)
                set(HPersTrc1, 'Checked', 'On');
                val=struct('activate',1,'Graph1DataMax',[],'Graph2DataMax',[]);
                set(hObject,'UserData',val);
            else
                gh = get(handles.Graph1,'Children');
                if val.activate
                    set(HPersTrc1, 'Checked', 'Off');
                    val=struct('activate',not(val.activate),'Graph1DataMax',[],'Graph2DataMax',[]);
                    delete(gh(3));
                    delete(gh(4));
                else
                    set(HPersTrc1, 'Checked', 'On');
                    val=struct('activate',not(val.activate),'Graph1DataMax',[],'Graph2DataMax',[]);
                end    
                
                set(hObject,'UserData',val);
            end
 else           
    HPersTrc1=findobj('Label','Persistence for Trace1');
    if ~isempty(HPersTrc1)
        val=get(HPersTrc1,'UserData');
        gh = get(handles.Graph1,'Children');
        Data1=get(gh(1),'YData');
        Data3=get(gh(2),'YData');
        sx=get(gh(2),'XData');
        if val.activate
           if (length(val.Graph1DataMax) == length(Data1))
              
              val.Graph1DataMax=sign(Data1)*max(abs(val.Graph1DataMax),abs(Data1));
              
              val.Graph2DataMax=sign(Data3)*max(abs(val.Graph2DataMax),abs(Data3));
           else
              
               val.Graph1DataMax=Data1;
               
               val.Graph2DataMax=Data3;
           end
           set(HPersTrc1,'UserData',val);
           %gh = get(handles.Graph1,'Children');
           if length(gh)==2
                %plot(handles.Graph1,sx,val.Graph2DataMin,'color','g','*');
                axes(handles.Graph1);
                hold on
                plot(handles.Graph1,sx,val.Graph1DataMax,sx,val.Graph2DataMax);
                hold off
                
                %plot(handles.Graph1,sx,val.Graph2DataMax,':y*');
           else
                set(gh(3), 'XData', sx, 'YData', val.Graph1DataMax,'Color','red');
                set(gh(4), 'XData', sx, 'YData', val.Graph2DataMax,'Color','green');
                
           end    
        end    
    end    
    %plot(handles.Graph1,sx,Data1,'color','g');
            
    end
 end
end
