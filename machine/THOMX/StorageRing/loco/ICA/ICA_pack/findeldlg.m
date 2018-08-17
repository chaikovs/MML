function varargout = findeldlg(varargin)
% FINDELDLG Application M-file for findeldlg.fig
%    FIG = FINDELDLG launch findeldlg GUI.
%    FINDELDLG('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.0 02-Jan-2004 16:31:44

if nargin == 2  % LAUNCH GUI
    d = varargin{1};
    u = varargin{2};
    if length(d) ~= size(u,2)
        disp('dimensions of d,u must agree')
        return
    end
    if isempty(d)
        disp('d,u must not be empty')
        return
    end

	fig = openfig(mfilename,'reuse');

	% Use system color scheme for figure:
	set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
    handles.data.d = d;
    handles.data.u = u;
    handles.nmode = length(d);
    handles.icom = 1;
    
    set(handles.figure1,'HandleVisibility','on');
    set(handles.figure1,'WindowStyle','modal');
	pos =get(fig,'Position');
	set(fig,'Position',[pos(1),pos(2),76,28.5]);
    set(fig,'Visible','on');
    guidata(fig, handles);
    splotmode(handles);
    uiwait(handles.figure1);
    
    handles = guidata(handles.figure1);
	if nargout > 0
		varargout{1} = handles.output;
	end
    delete(handles.figure1);
    
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
function varargout = pushbutton_next_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton1.
handles.icom = mod(handles.icom, handles.nmode) + 1;
guidata(handles.figure1,handles);
splotmode(handles);

% --------------------------------------------------------------------
function varargout = pushbutton_next_f_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_next_f.
handles.icom = mod(handles.icom + 4, handles.nmode) + 1;
guidata(handles.figure1,handles);
splotmode(handles);

% --------------------------------------------------------------------
function varargout = pushbutton_prev_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_prev.
handles.icom = mod(handles.icom-2, handles.nmode) + 1;
guidata(handles.figure1,handles);
splotmode(handles);



% --------------------------------------------------------------------
function varargout = pushbutton_prev_f_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_prev_f.
handles.icom = mod(handles.icom-6, handles.nmode) + 1;
guidata(handles.figure1,handles);
splotmode(handles);



% --------------------------------------------------------------------
function varargout = pushbutton_ok_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_ok.
handles.output = handles.data.d(handles.icom);
guidata(handles.figure1,handles);
uiresume;

function splotmode(handles)
%
d = handles.data.d;
u = handles.data.u;

set(handles.text_mode,'String',sprintf('%d of %d',handles.icom,handles.nmode));
set(handles.text_sv,'String',sprintf('%f',d(handles.icom)));

axes(handles.axes1);
n = 1:length(d);
plot(n,d,'bo',handles.icom,d(handles.icom),'r*');
title('Singular Values');

axes(handles.axes2);
t = 1:size(u,1);
hl = plot(t,u(:,handles.icom),'b');
mh = max(max(abs(u)));
axis([1,size(u,1),-mh,mh]);
    
set(hl,'LineWidth',1.5);
title('temporal pattern');
