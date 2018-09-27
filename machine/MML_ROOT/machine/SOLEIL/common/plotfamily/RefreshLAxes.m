function  RefreshLAxes(hObject,callbackdata,handles,argin)
% REFRESHLAXES Summary of this function goes here
%   Detailed explanation goes here

%
%% Written by A. Bence

argin2={0,1.1,handles.LatticeAxes}';
%%
switch argin
    case 'DrawRFcav'
        if strcmpi(get(handles.DrawRF,'Checked'),'On')
            set(handles.DrawRF, 'Checked', 'Off');
        else
            set(handles.DrawRF, 'Checked', 'On');
            set(handles.clearDraw, 'Checked', 'Off');
       end
    case 'DrawID'
        if strcmpi(get(handles.DrawID,'Checked'),'On')
            set(handles.DrawID, 'Checked', 'Off');
        else
            set(handles.DrawID, 'Checked', 'On');
            set(handles.clearDraw, 'Checked', 'Off');
       end
    case 'ID_Name'
        if strcmpi(get(handles.ID_Name,'Checked'),'On')
            set(handles.ID_Name, 'Checked', 'Off');
        else
            set(handles.ID_Name, 'Checked', 'On');
            set(handles.clearDraw, 'Checked', 'Off');
        end
    case 'BeamLine_Name'
       if strcmpi(get(handles.BeamLineName,'Checked'),'On')
            set(handles.BeamLineName, 'Checked', 'Off');
        else
            set(handles.BeamLineName, 'Checked', 'On');
            set(handles.clearDraw, 'Checked', 'Off');
       end
    case 'ClearDraw'
        set(handles.DrawRF, 'Checked', 'Off');
        set(handles.DrawID, 'Checked', 'Off');
        set(handles.ID_Name, 'Checked', 'Off');
        set(handles.BeamLineName, 'Checked', 'Off');
        set(handles.clearDraw, 'Checked', 'On');
end

% Drawing factory
if strcmpi(get(handles.DrawRF,'Checked'),'On')
    argin2=[argin2;{'DrawRFcav'}];
end
if strcmpi(get(handles.DrawID,'Checked'),'On')
    argin2=[argin2;{'DrawID'}];
end
if strcmpi(get(handles.ID_Name,'Checked'),'On')
    argin2=[argin2;{'ID_Name'}];
end
if strcmpi(get(handles.BeamLineName,'Checked'),'On')
    argin2=[argin2;{'BeamLine_Name'}];
end

if strcmpi(get(handles.DrawRF,'Checked'),'Off')
    argin2=[argin2;{'NO_DrawRFcav'}];
end
if strcmpi(get(handles.DrawID,'Checked'),'Off')
    argin2=[argin2;{'NO_DrawID'}];
end
if strcmpi(get(handles.ID_Name,'Checked'),'Off')
    argin2=[argin2;{'NO_ID_Name'}];
end
if strcmpi(get(handles.BeamLineName,'Checked'),'Off')
    argin2=[argin2;{'NO_BeamLine_Name'}];
end
XL=get(handles.LatticeAxes,'XLim'); %get Length for XAxis            
drawlattice(argin2);
set(handles.LatticeAxes,'Visible','Off');
set(handles.LatticeAxes,'Color','None');
set(handles.LatticeAxes,'XMinorTick','Off');
set(handles.LatticeAxes,'XMinorGrid','Off');
set(handles.LatticeAxes,'YMinorTick','Off');
set(handles.LatticeAxes,'YMinorGrid','Off');
set(handles.LatticeAxes,'XTickLabel',[]);
set(handles.LatticeAxes,'YTickLabel',[]);
set(handles.LatticeAxes,'YLim', [-1.5 1.5]);
set(handles.LatticeAxes,'XLim', XL); % if XAxis is different of all superperiod you need to set the previous length 
       