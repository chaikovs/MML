function varargout = quitdlg(varargin)
% QUITDLG Application M-file for quitdlg.fig
%    FIG = QUITDLG launch quitdlg GUI.
%    QUITDLG('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.0 02-Jan-2004 19:12:07

if nargin == 0  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

  % Use system color scheme for figure:
  set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

	% Use system color scheme for figure:
	set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
    handles.yesno = 'no';
    set(handles.figure1,'HandleVisibility','on');
	guidata(fig, handles);
	pos =get(fig,'Position');
	set(fig,'Position',[pos(1),pos(2),50,8.5]);
    quitdlg_OpeningFcn(handles.figure1,[],handles,varargin);
    
    if nargout > 0
		varargout{1} = quitdlg_OutputFcn(handles.figure1,[],handles);
	else 
		delete(handles.figure1);
	end


elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK
%disp(varargin{1})
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

function quitdlg_OpeningFcn(h,eventdata,handles,varargin)
%
    %set(handles.figure1,'WindowStyle','modal');
    disp('waiting')
    uiwait(handles.figure1);
    disp('wait end')

function varargout = quitdlg_OutputFcn(h,eventdata,handles,varargin)
%
handles = guidata(handles.figure1);
varargout{1} = handles.yesno;
delete(handles.figure1);
% --------------------------------------------------------------------
function varargout = pushbutton_yes_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton1.
handles.yesno = 'yes';
disp('yes')
guidata(handles.figure1,handles);

uiresume;


% --------------------------------------------------------------------
function varargout = pushbutton_no_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_no.

disp('no')
%delete(handles.figure1);
uiresume;