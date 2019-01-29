function [X Z Sum]=getbpmsum(varargin)
%GETBPMSUM - Get Sum vector for BPM and display it
%
%
%
%  See Also getbpmrawdata

%
%% Written by Laurent S. Nadolski
%% Modified by Aurelien BENCE

%% UGLY PATCH 122 by HAND

DisplayFlag = 1;
FreezeFlag = 0;
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    end
end

xdeb=0;
xfin=getcircumference;

xmax=10;
%xfin=getcircumference;

function [spos maxSum BPMlist idx]=GetBPMData
% BPM avec status = 1
indexBPMStatusTo1 = family2status('BPMx') & family2status('BPMz');

% Filtre sur l'index des BPMs (ElementList) avec status = 1  
BPMlist = getfamilydata('BPMx','ElementList');
BPMlist = BPMlist(indexBPMStatusTo1);

% Filtre sur le nom des BPMs (DeviceList) avec status = 1
BPMDlist = getfamilydata('BPMx','DeviceList');
BPMDlist = BPMDlist(indexBPMStatusTo1,:);

spos = getspos('BPMx');
Vect = getbpmrawdata(BPMDlist,'Nodisplay','Struct');

Sum = Vect.Data.Sum;
X = Vect.Data.X;
Z = Vect.Data.Z;
[maxSum idx] = max(Sum');

%idx2 = sub2ind(size(AM.Data.Sum), xpos, idx+ishift)

% figure
% mesh(Vect.Data.Sum)
end
function [hfig h1 h2 h3 Hlbl]=figcreate


%&Ã©"idx(1) = 7;
hfig=figure(205);
set(hfig,'units','normalized','Position',[.9 .9 .9 .9]);
h1 = subplot(7,1,[1 2]); 
h2 = subplot(7,1,[3 4]);
h3 = subplot(7,1,[5 6]);

h4 = subplot(7,1,7);
drawlattice 
set(h4,'YTick',[])
xaxis([xdeb xfin]);

grid on
xlabel('s [mm]');

linkaxes([h1 h2 h3 h4],'x')
set([h1 h2 h3 h4],'XGrid','On','YGrid','On');
%xaxis([0 100])

Hlbl=addlabel(1,0,datestr(clock));
uicontrol('Style','pushbutton','String','Refresh','units','normalized','Position',[.45 .03 .05 .025],'Callback',{@RefreshPlot});
uicontrol('Style','pushbutton','String','Freeze','units','normalized','Position',[.5 .03 .05 .025],'Callback',@setFreeze);

end
function plotBPMsum
    axes(h1);
    if FreezeFlag
        prop=get(h1)
        if size(prop.Children)==1
            set(prop.Children,'Color','g')
            hold on
            plot(spos,maxSum,'.-b');
            hold off
        else
            set(prop.Children(2),'XData',maxSum)
        end    
    else
        plot(spos,maxSum,'.-b');
    end
    ylabel('Sum Signal Amplitude (u.a.)');
    xaxis([xdeb xfin]);yaxis([0 15e08]);

    axes(h2);
    if FreezeFlag
        prop=get(h2)
        if size(prop.Children)==1
            set(prop.Children,'Color','g')
            hold on
            plot(spos,maxSum,'.-b');
            hold off
        else
            set(prop.Children(2),'XData',maxSum)
        end    
    else
        plot(spos,X(BPMlist,idx(1)),'.-b');
    end
    % hold on
    % plot(spos,X(1:120,idx(1)+1),'.-r');
    % hold off
    ylabel('X Amplitude (mm)');
    yaxis([-xmax xmax]);xaxis([xdeb xfin]);

    axes(h3);
    if FreezeFlag
        prop=get(h3)
        if size(prop.Children)==1
            set(prop.Children,'Color','g')
            hold on
            plot(spos,maxSum,'.-b');
            hold off
        else
            set(prop.Children(2),'XData',maxSum)
        end    
    else
    plot(spos,Z(BPMlist,idx(1)),'.-b');
    end
    % hold on
    % plot(spos,Z(1:120,idx(1))+1,'.-r');
    % hold off
    ylabel('Z Amplitude (mm)');
    yaxis([-xmax xmax]);xaxis([xdeb xfin]);
    set(Hlbl,'String',datestr(clock));
end

[spos maxSum BPMlist idx]=GetBPMData;
if DisplayFlag
    [fig h1 h2 h3 Hlbl]=figcreate;
    plotBPMsum 
end

function RefreshPlot(hObject,evt)
       [spos maxSum BPMlist idx]=GetBPMData;
       plotBPMsum;
end
function setFreeze(hObject,evt)
    if FreezeFlag
        FreezeFlag = 0;
        set(hObject,'String','Freeze','Backgroundcolor',[0.5 0.5 0.5])
    else
        FreezeFlag = 1;
        set(hObject,'String','UnFreeze','Backgroundcolor','g')
    end
    RefreshPlot(hObject,evt);
end
% Output data
X    = X(BPMlist,idx(1));
Z    = Z(BPMlist,idx(1));
Sum  = Sum(BPMlist,idx(1));
end

