function varargout = axesdlg(varargin)
% AXESDLG Application M-file for axesdlg.fig
%    FIG = AXESDLG launch axesdlg GUI.
%    AXESDLG('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.0 09-Jan-2004 14:01:53

if nargin == 1  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

	% Use system color scheme for figure:
	set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
    ha = varargin{1};
    handles.ha = ha;
    
    axesdata = get(ha);
    handles.axes = axesdata;
    handles.axes.XLabelStr = get(axesdata.XLabel,'String');
    handles.axes.YLabelStr = get(axesdata.YLabel,'String');
   % tmp1 = axesdata.XTick;
   % tmp = num2str(axesdata.XTick);

    set(handles.edit_xtick,'String',['[',num2str(axesdata.XTick,'%2.1f '),']']);
    set(handles.edit_ytick,'String',['[',num2str(axesdata.YTick,'%2.1f '),']']);
    set(handles.edit_xlim,'String',['[',num2str(axesdata.XLim),']']);
    set(handles.edit_ylim,'String',['[',num2str(axesdata.YLim),']']);    
    set(handles.edit_xlabel,'String',get(axesdata.XLabel,'String'));    
    set(handles.edit_ylabel,'String',get(axesdata.YLabel,'String'));
    set(handles.checkbox_grid,'Value',strcmp(axesdata.XGrid,'on'));
    set(fig,'WindowStyle','modal');
	
	pos =get(fig,'Position');
	set(fig,'Position',[pos(1),pos(2),67,12.5]);
    set(fig,'Visible','on');
    
    guidata(fig, handles);
    uiwait(fig);
    
    handles = guidata(fig);
	if nargout > 0
		    varargout{1} = fig;        
	end
    if strcmp(handles.yesno,'yes')

            set(ha,'XTick',handles.axes.XTick);
            set(ha,'YTick',handles.axes.YTick);
            set(ha,'XLim',handles.axes.XLim);
            set(ha,'YLim',handles.axes.YLim);
            set(handles.axes.XLabel,'String',handles.axes.XLabelStr);
            set(handles.axes.YLabel,'String',handles.axes.YLabelStr);
            set(ha,'XGrid',handles.axes.XGrid);
            set(ha,'YGrid',handles.axes.YGrid);
     end
    delete(fig);
elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
	catch
		disp(lasterr);
	end

end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.



% --------------------------------------------------------------------
function varargout = edit_xtick_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_xtick.
str = get(h,'String');
handles.axes.XTick = eval(str);
guidata(handles.figure1,handles);

% --------------------------------------------------------------------
function varargout = edit_ytick_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_ytick.
str = get(h,'String');
handles.axes.YTick = eval(str);
guidata(handles.figure1,handles);

% --------------------------------------------------------------------
function varargout = edit_xlabel_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_xlabel.
str = get(h,'String');
handles.axes.XLabelStr = str;
guidata(handles.figure1,handles);

% --------------------------------------------------------------------
function varargout = edit_ylabel_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_ylabel.
str = get(h,'String');
handles.axes.YLabelStr = str;
guidata(handles.figure1,handles);


% --------------------------------------------------------------------
function varargout = edit_xlim_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_xlim.
str = get(h,'String');
handles.axes.XLim = eval(str);
guidata(handles.figure1,handles);


% --------------------------------------------------------------------
function varargout = edit_ylim_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_ylim.
str = get(h,'String');
handles.axes.YLim = eval(str);
guidata(handles.figure1,handles);


% --------------------------------------------------------------------
function varargout = pushbutton_ok_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_ok.
handles.yesno = 'yes';
guidata(handles.figure1,handles);
uiresume(handles.figure1);


% --------------------------------------------------------------------
function varargout = pushbutton_cancel_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_cancel.
handles.yesno = 'no';
guidata(handles.figure1,handles);
uiresume(handles.figure1);



% --------------------------------------------------------------------
function varargout = checkbox_grid_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.checkbox_grid.
val = get(h,'Value')
if val==1
    handles.axes.XGrid = 'on';
    handles.axes.YGrid = 'on';
else
    handles.axes.XGrid = 'off';
    handles.axes.YGrid = 'off';
end
guidata(handles.figure1,handles);
