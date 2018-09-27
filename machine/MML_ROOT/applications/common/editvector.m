function newList = editvector(List, ListName, VectorValue)
%EDITvector - Edits a vector
% newList = editvector(List)
% newList = editvector(List, InfoString)
% newList = editvector(List, InfoString, VectorValue)
%
% Allows one to easily edit a vector values
%
%  INPUTS
%  1. List       - List to edit (matrix of numbers or strings)
%  2. InfoString - Informational string {optional}
%  3. VectorValue  - By default it's [0...]
%
%  NOTE
%  1. Closing the window will result in no change to the list
% 
%
%
%  EXAMPLE
%  1. Edit the Vector value given in Argin
%      VectnewList = editvector(family2dev('BPMx'), 'BPMx', getx);


% Written by A.Bence

if nargin < 1 
    error('At least 1 input is required.')
end

if strcmpi(List,'GetNewList101010101') %to get newlistvalue when you press done
    Index = [];
    %hh = get(gcf);
    %jh=get(gco,'userdata');
    gg=get(get(gco,'userdata'));
    h = get(gco,'userdata');
    l=[];m=1;
    for i = 1:length(h);
        %if get(h(i),'Value') == 1
            %couincouin = get(h(i),'userdata');
            newList(m,:) = str2num(get(h(i),'String'));
            m=m+1;
            Index = [Index; i]; 
        %end;
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
    VectorValue = zeros(size(List,1),1);
end
if ~ischar(ListName)
    VectorValue = ListName;   
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


if length(VectorValue) ~= size(List,1)
    VectorValue = VectorValue * zeros(max(size(List)),1);
end
if length(VectorValue) ~= size(List,1)
    error('List and VectorValue must have the same max(size).');
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


n = size(List,1)*2;
col = ceil(n/40);
row = ceil(n/col);


FigWidth = (col+1)*ButtonWidth + (col-1)*3 + 0;
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
    'Name',['Edit ', ListName, ' Vector'], ...
    'NumberTitle','Off', ...
    'Units','pixels', ...   
    'Position',[30 p(4)-FigHeight-40 FigWidth FigHeight], ...
    'Resize','on', ...
    'Userdata', [], ...
    'Tag','editvectorFigure');

k = 1;
for j = 1:2:col
    for i = 1:row
        
        if ischar(List)
            liststring = [ListName, List(k,:)];
        elseif size(List,2) == 2
            liststring = sprintf('%s(%d,%d)', ListName, List(k,1), List(k,2));
        else
            liststring = sprintf('%s(%d)', ListName, List(k,1));
        end
        
        if VectorValue(k)
            EnableFlag = 1;
        else
            EnableFlag = 0;
        end
        
        h(k) = uicontrol('Parent',h0, ...
            'Callback','', ...
            'Enable','On', ...
            'FontName', 'MS Sans Serif', ...
            'FontSize', 10, ...
            'FontUnits', 'points', ...
            'Interruptible','Off', ...
            'Position',[6+(j-1)*(ButtonWidth+3) 3+(row-i+1)*ButtonHeight ButtonWidth-6 ButtonHeight], ...
            'Style','edit', ...
            'String',num2str(VectorValue(k)), ...
            'Userdata',num2str(VectorValue(k)), ...
            'Tag','Edit1');
        h2(k) = uicontrol('Parent',h0, ...
            'Callback','', ...
            'Enable','On', ...
            'BackgroundColor',[0.3 0.5 0.7], ...
            'FontName', 'MS Sans Serif', ...
            'FontSize', 10, ...
            'FontUnits', 'points', ...
            'Interruptible','Off', ...
            'Position',[6+(j)*(ButtonWidth+3) 3+(row-i+1)*ButtonHeight ButtonWidth-6 ButtonHeight], ...
            'Style','text', ...
            'String',liststring, ...
            'Tag','text1');
        k = k + 1;
        if k > n/2
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
%    'Tag','editvectorClose');

h1 = uicontrol(...
    'Parent',h0, ...
    'Callback','editvector(''GetNewList101010101'');', ...
    'Enable','On', ...
    'Interruptible','Off', ...
    'Position',[3 3+0*ButtonHeight FigWidth-6 ButtonHeight], ...
    'String','Done', ...
    'userdata', h, ...
    'Tag','editvectorClose');


waitfor(gcf,'userdata');
tmpcell = get(gco,'userdata');

if isempty(tmpcell)
    % Return the old list (figure got closed)
    if CellInputFlag
        i = find(VectorValue);
        newList = ListCell(i,:);
        Index = (1:size(newList,1))';
    else
        i = find(VectorValue);
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
%     i = find(VectorValue);
%     newList = List(i,:);
%     Index = (1:size(newList,1))';
end

if RowVectorFlag
    newList = newList';
end










