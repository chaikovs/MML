function varargout = viewbpm(varargin)
% VIEWBPM Application M-file for viewbpm.fig
%    FIG = VIEWBPM launch viewbpm GUI.
%    VIEWBPM('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.0 11-Jan-2004 23:21:29

if nargin == 1  % LAUNCH GUI

  fig = openfig(mfilename,'reuse');

  % Use system color scheme for figure:
  set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

  % Generate a structure of handles to pass to callbacks, and store it. 
  handles = guihandles(fig);
  handles.data = varargin{1};
  
  if isempty(handles.data)
      disp('no data');
      delete(fig);
	  return
  end
  if ~isfield(handles.data,'s')
	  handles.x = handles.data;
	  handles.index = 1;
  else	  
  	try
  		handles.x = handles.data.A * handles.data.s;
  		handles.index = 1;
  	catch
		disp('wrong data')
        delete(fig);
		return
  	end
   end
  handles.nbpm = size(handles.x,1);
  for i=1:size(handles.x,1)
	  str{i} = int2str(i);
  end
  set(handles.popupmenu_bpm,'String',str,'Value',1);
  set(handles.figure1,'HandleVisibility','on');
  plotbpmtbt([handles.axes1,handles.axes2],handles.x(handles.index,:),8);
  
  guidata(fig, handles);

  if nargout > 0
    varargout{1} = fig;
  end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

  try
    [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
  catch
    disp(lasterr);
  end

end
% ------------------------- end viewbpm ------------------------------


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| SUBFUNCTION_NAME(H, EVENTDATA, HANDLES, VARARGIN)
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
%| VIEWBPM('SUBFUNCTION_NAME', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.


function varargout = axes1_ButtondownFcn(h, eventdata, handles, varargin)
% Stub for ButtondownFcn of the axes handles.axes1.
disp('axes1 ButtondownFcn not implemented yet.')
% ------------------- end axes1_ButtondownFcn ------------------------


function varargout = axes2_ButtondownFcn(h, eventdata, handles, varargin)
% Stub for ButtondownFcn of the axes handles.axes2.
disp('axes2 ButtondownFcn not implemented yet.')
% ------------------- end axes2_ButtondownFcn ------------------------


function varargout = popupmenu_bpm_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.popupmenu_bpm.
handles.index = get(h,'Value');
set(handles.text_bpm,'String',int2str(handles.index));

plotbpmtbt([handles.axes1,handles.axes2],handles.x(handles.index,:),8);
guidata(handles.figure1,handles);



function varargout = pushbutton_next_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_next.
handles.index = mod(handles.index, handles.nbpm) + 1;
set(handles.text_bpm,'String',int2str(handles.index));

plotbpmtbt([handles.axes1,handles.axes2],handles.x(handles.index,:),8);
guidata(handles.figure1,handles);


function varargout = pushbutton_next_f_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_next_f.
handles.index = mod(handles.index+4, handles.nbpm) + 1;
set(handles.text_bpm,'String',int2str(handles.index));

plotbpmtbt([handles.axes1,handles.axes2],handles.x(handles.index,:),8);
guidata(handles.figure1,handles);


function varargout = pushbutton_prev_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_prev.
handles.index = mod(handles.index-2, handles.nbpm) + 1;
set(handles.text_bpm,'String',int2str(handles.index));

plotbpmtbt([handles.axes1,handles.axes2],handles.x(handles.index,:),8);
guidata(handles.figure1,handles);



function varargout = pushbutton_prev_f_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_prev_f.
handles.index = mod(handles.index-6, handles.nbpm) + 1;
set(handles.text_bpm,'String',int2str(handles.index));

plotbpmtbt([handles.axes1,handles.axes2],handles.x(handles.index,:),8);
guidata(handles.figure1,handles);


function varargout = plotbpmtbt(ha,vx,pdK)
%
axes(ha(1));
n=1:length(vx);
plot(n,vx); grid

splotfft(ha(2),vx,pdK);



function splotfft(ha,vx,pdK)
%
        axes(ha);
		fq = fft(vx);
		len = floor(size(vx,2)/2);
   		h = plot(1.-(1:len)/len/2.,abs(fq(1:len)),'b');hold on
        set(h,'LineWidth',1);
        title('FFT of temporal pattern');
       % axis([0.5,1.0,0.,150.]);
    	[peak_v,peak_pos,peak_width] = peakdetect(abs(fq), 1,len,pdK);
		if length(peak_v) > 6
			[speak_v, speak_indx]=sort(peak_v);
			peakindx= speak_indx(1:length(peak_v)-6) ;
			peak_v(peakindx) = [];
			peak_pos(peakindx) = [];
			peak_width(peakindx) = [];
		end
    	plot(1.-peak_pos/len/2.,peak_v,'ro');hold off
		tune = [];
    	for i=length(peak_v):-1:1
       	 	tune = [tune,'  ',num2str(1.-peak_pos(i)/len/2)];
        end
    	xlabel(tune);grid

function varargout = pushbutton_quit_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_quit.
delete(handles.figure1);
% ----------------- end pushbutton_quit_Callback ---------------------
