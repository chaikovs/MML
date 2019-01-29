function [X Z Sum]=getbpmsum(varargin)
%GETBPMSUM - Get Sum vector for BPM and display it
%
%
%
%  See Also getbpmrawdata

%
%% Written by Laurent S. Nadolski

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
function [BPMlist idx]=plot_BPM(hObject,evt,hldon)
if ~exist('hldon')
    hldon=0;
end    
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

xdeb=0;
xfin=350;

xmax=10;
%xfin=getcircumference;

    if hldon
        hold on
        set(get(h1,'Children'),'Color','cyan');
        set(get(h2,'Children'),'Color','cyan');
        set(get(h3,'Children'),'Color','cyan');
    else
        hold off 
        cla(h1)
        cla(h2)
        cla(h3)
    end    
    axes(h1);
    plot(spos,maxSum,'.-');
    ylabel('Sum Signal Amplitude (u.a.)');
    xaxis([xdeb xfin]);yaxis([0 2*5e08]);

    axes(h2);
    plot(spos,X(BPMlist,idx(1)),'.-b');
    % hold on
    % plot(spos,X(1:120,idx(1)+1),'.-r');
    % hold off
    ylabel('X Amplitude (mm)');
    yaxis([-xmax xmax]);xaxis([xdeb xfin]);

    axes(h3);
    plot(spos,Z(BPMlist,idx(1)),'.-b');
    % hold on
    % plot(spos,Z(1:120,idx(1))+1,'.-r');
    % hold off
    ylabel('Z Amplitude (mm)');
    yaxis([-xmax xmax]);xaxis([xdeb xfin]);

    axes(h4);
    drawlattice 
    set(h4,'YTick',[])
    xaxis([xdeb xfin]);

    grid on
    xlabel('s [mm]');

    linkaxes([h1 h2 h3 h4],'x')
    set([h1 h2 h3 h4],'XGrid','On','YGrid','On');
    %xaxis([0 100])

    addlabel(1,0,datestr(clock));

end
function freeze(hObject,evt)
    if FreezeFlag
        FreezeFlag = 0;
        set(hObject,'String','Freeze','Backgroundcolor',[0.5 0.5 0.5])
    else
        FreezeFlag = 1;
        set(hObject,'String','UnFreeze','Backgroundcolor','g')
    end    
end
if DisplayFlag
    %&é"idx(1) = 7;
    hfig=figure(205);
    set(hfig,'units','normalized','Position',[.9 .9 .9 .9]);

    uicontrol('Style','pushbutton','String','Refresh','units','normalized','Position',[.45 .03 .05 .025],'Callback',@plot_BPM);
    uicontrol('Style','pushbutton','String','Freeze','units','normalized','Position',[.5 .03 .05 .025],'Callback',@freeze);

    h1 = subplot(7,1,[1 2]);
    h2 = subplot(7,1,[3 4]);
    h3 = subplot(7,1,[5 6]);
    h4 = subplot(7,1,7);
    [BPMlist idx]=plot_BPM;
end



% Output data
X    = X(BPMlist,idx(1));
Z    = Z(BPMlist,idx(1));
Sum  = Sum(BPMlist,idx(1));
end

