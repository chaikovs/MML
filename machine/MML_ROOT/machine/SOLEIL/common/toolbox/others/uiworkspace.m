function varargout = uiworkspace(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',          mfilename, ...
                   'gui_Singleton',     gui_Singleton, ...
                   'gui_OpeningFcn',    @uiworkspace_OpeningFcn, ...
                   'gui_OutputFcn',     @uiworkspace_OutputFcn, ...
                   'gui_LayoutFcn',     [], ...
                   'gui_Callback',      []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

function uiworkspace_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<*INUSL>

handles.output = hObject;

handles.InputStructureFlag = 0;
handles.FilterStructureFlag = 0;

guidata(hObject, handles);

vars = evalin('base','who');
set(handles.listbox_WorkspaceVariables,'String',vars)

function varargout = uiworkspace_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


function pushbutton_UpdateListbox_Callback(hObject, eventdata, handles, varargin) %#ok<*DEFNU>

vars = evalin('base','who');
set(handles.listbox_WorkspaceVariables,'String',vars)

guidata(hObject, handles);


function pushbutton_InputStructure_Callback(hObject, eventdata, handles, varargin)

list_entries = get(handles.listbox_WorkspaceVariables,'String');
index_selected = get(handles.listbox_WorkspaceVariables,'Value');

evalin('base',['InputStructure = ' list_entries{index_selected} ';']);
assignin('base', 'InputName', list_entries{index_selected});
handles.InputStructureFlag = 1;

guidata(hObject, handles);




function pushbutton_FilterStructure_Callback(hObject, eventdata, handles, varargin)

list_entries = get(handles.listbox_WorkspaceVariables,'String');
index_selected = get(handles.listbox_WorkspaceVariables,'Value');

evalin('base',['FilterStructure = ' list_entries{index_selected} ';']);
assignin('base', 'FilterName', list_entries{index_selected});
handles.FilterStructureFlag = 1;

guidata(hObject, handles);


function listbox_WorkspaceVariables_CreateFcn(hObject, eventdata, handles) %#ok<*INUSD>
usewhitebg = ispc;
if usewhitebg
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function figure_uiworkspace_CloseRequestFcn(hObject, eventdata, handles)

if handles.InputStructureFlag == 0;
    assignin('base','InputStructureFlag', 0)
else
    assignin('base','InputStructureFlag', 1)
end

if handles.FilterStructureFlag == 0;
    assignin('base','FilterStructureFlag', 0)
else
    assignin('base','FilterStructureFlag', 1)
end

delete(hObject);
