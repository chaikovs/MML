function newList = editlist(List, ListName, CheckList)
%EDITLIST - Edits a list
% newList = editlist(List)
% newList = editlist(List, InfoString)
% newList = editlist(List, InfoString, CheckList)
%
% Allows one to easily edit a element or device list 
%
%  INPUTS
%  1. List       - List to edit (matrix of numbers or strings)
%  2. InfoString - Informational string {optional}
%  3. CheckList  - Starting check box setting (0 - don't check, else check)
%
%  NOTE
%  1. Closing the window will result in no change to the list
%  2. List can have 1 or 2 columns or be a list of strings or cell array of strings. 
%
%
%  EXAMPLE
%  1. Edit the device list for the BPMx family
%     newList = editlist(family2dev('BPMx'), 'BPMx', family2status('BPMx'));
%
% Written by Gregory J. Portmann

if nargin < 1 
    error('At least 1 input is required.')
end

if strcmpi(List,'GetNewList101010101')
    Index = [];
    h = get(gco,'userdata');
    l=[];m=1;
    for i = 1:length(h);
        if get(h(i),'Value') == 1
            newList(m,:) = get(h(i),'userdata');
            m=m+1;
            Index = [Index; i]; 
        end;
    end;
    
    CellInputFlag = getappdata(gcf, 'CellInputFlag');
    
    if exist('newList', 'var')
        if CellInputFlag
            for i = 1:size(newList,1)
                newListCell{i,1} = deblank(newList(i,:));
            end
            newList = newListCell;
        end
    else
        if CellInputFlag
            newList = {};
        else
            newList = [];
        end
        Index = [];
    end
    
    set(gco,'userdata', {newList, Index});   % Store the data
    set(gcf,'userdata',1);   % So that waitfor executes
    drawnow;
    pause(0);    
    return
end


if nargin < 2
    ListName = '';
end

% if isstr(List)
%    error('First input cannot be a string');
%    return
% end

if nargin < 3
    CheckList = ones(size(List,1),1);
end
if ~ischar(ListName)
    CheckList = ListName;   
    ListName = '';
end


if iscell(List)
    ListCell = List;
    List = [];
    for i = 1:length(ListCell)
        List = strvcat(List, ListCell{i});
    end
    CellInputFlag = 1;
else
    CellInputFlag = 0;
end


if length(CheckList) ~= size(List,1)
    CheckList = CheckList * ones(max(size(List)),1);
end
if length(CheckList) ~= size(List,1)
    error('List and CheckList must have the same max(size).');
end


if isunix
    ScaleFactor = 8;
    ButtonHeight  = 20;
    Offset = 6;
else
    ScaleFactor = 8; %6.5;
    ButtonHeight  = 16;
    Offset = 6;
end


if ischar(List)
    % String matrix
    RowVectorFlag = 0;
    ButtonWidth = round(ScaleFactor*(size(List,2)+size(ListName,2))+Offset);
elseif size(List,2) == 2
    % Column vector
    RowVectorFlag = 0;
    ButtonWidth = round(ScaleFactor*length(sprintf('%s(%d,%d)', ListName, max(List(:,1)), max(List(:,1))))+Offset);
elseif size(List,1) == 1
    % Row vector
    List = List';
    RowVectorFlag = 1;
    ButtonWidth = 1.15*round(ScaleFactor*length(sprintf('%s(%d)', ListName, max(List)))+Offset);
    if max(List) > 99
        ButtonWidth = 1.15*ButtonWidth;
    end
elseif size(List,2) == 1
    % Column vector
    RowVectorFlag = 0;
    ButtonWidth = 1.3*round(ScaleFactor*length(sprintf('%s(%d)', ListName, max(List)))+Offset);
    if max(List) > 99
        ButtonWidth = 1.15*ButtonWidth;
    end
elseif size(List,2) > 2
    if ~ischar(List)
        % More than 2 columns is a problem
        error('Input list must be 1 or 2 columns.')
    end
end

if ButtonWidth < 90
    ButtonWidth = 90;
end


n = size(List,1);
col = ceil(n/40);
row = ceil(n/col);


FigWidth = col*ButtonWidth + (col-1)*3 + 0;
%if col > 2
%    FigWidth = FigWidth + .2*FigWidth;
%end
FigHeight  = 3+(row+1)*ButtonHeight;


% Change figure position
set(0,'Units','pixels');
p=get(0,'screensize');

h0 = figure( ...
    'Color',[0.8 0.8 0.8], ...
    'HandleVisibility','On', ...
    'Interruptible', 'on', ...
    'MenuBar','none', ...
    'Name',['Edit ', ListName, ' List'], ...
    'NumberTitle','Off', ...
    'Units','pixels', ...   
    'Position',[30 p(4)-FigHeight-40 FigWidth FigHeight], ...
    'Resize','on', ...
    'Userdata', [], ...
    'Tag','EditListFigure');

k = 1;
for j = 1:col
    for i = 1:row
        
        if ischar(List)
            liststring = [ListName, List(k,:)];
        elseif size(List,2) == 2
            liststring = sprintf('%s(%d,%d)', ListName, List(k,1), List(k,2));
        else
            liststring = sprintf('%s(%d)', ListName, List(k,1));
        end
        
        if CheckList(k)
            EnableFlag = 1;
        else
            EnableFlag = 0;
        end
        
        h(k) = uicontrol('Parent',h0, ...
            'Callback','', ...
            'Enable','On', ...
            'FontName', 'MS Sans Serif', ...
            'FontSize', 8, ...
            'FontUnits', 'points', ...
            'Interruptible','Off', ...
            'Position',[6+(j-1)*(ButtonWidth+3) 3+(row-i+1)*ButtonHeight ButtonWidth-6 ButtonHeight], ...
            'Style','radio', ...
            'String',liststring, ...
            'Value',EnableFlag, ...
            'Userdata',List(k,:), ...
            'Tag','Radio1');
        k = k + 1;
        if k > n
            break
        end    
    end
end

setappdata(h0, 'CellInputFlag', CellInputFlag);

% h1 = uicontrol(...
%    'Parent',h0, ...
%    'Callback',[...
%       'h = get(gco,''userdata'');', ...
%       'l=[];m=1;', ...
%       'for i = 1:length(h);', ...
%       '   if get(h(i),''Value'') == 1', ...
%       '      l(m,:) = get(h(i),''userdata'');', ...
%       '      m=m+1;', ...
%       '   end;', ...
%       'end;', ...
%       'set(gco,''userdata'',l);', ...
%       'set(gcf,''userdata'',1);'], ...
%    'Enable','On', ...
%    'Interruptible','Off', ...
%    'Position',[3 3+0*ButtonHeight FigWidth-6 ButtonHeight], ...
%    'String','Change List', ...
%    'userdata', h, ...
%    'Tag','EditListClose');

h1 = uicontrol(...
    'Parent',h0, ...
    'Callback','editlist(''GetNewList101010101'');', ...
    'Enable','On', ...
    'Interruptible','Off', ...
    'Position',[3 3+0*ButtonHeight FigWidth-6 ButtonHeight], ...
    'String','Done', ...
    'userdata', h, ...
    'Tag','EditListClose');


waitfor(gcf,'userdata');
tmpcell = get(gco,'userdata');

if isempty(tmpcell)
    % Return the old list (figure got closed)
    if CellInputFlag
        i = find(CheckList);
        newList = ListCell(i,:);
        Index = (1:size(newList,1))';
    else
        i = find(CheckList);
        newList = List(i,:);
        Index = (1:size(newList,1))';
    end

    if RowVectorFlag
        newList = newList';
    end
    return;
end


newList = tmpcell{1};
Index = tmpcell{2};

if gcf == h0
    close(h0);
% else
%     % If the figure is closed (not changed) return the old list
%     i = find(CheckList);
%     newList = List(i,:);
%     Index = (1:size(newList,1))';
end

if RowVectorFlag
    newList = newList';
end










