function calctuneTFB(action)
% CALCTUNEFBT
% T=timer('TimerFcn',@gettune_FBT, 'Period', 1.0);
%%

StartFlag = 0;
%setappdata(h,'FEEDBACK_STOP_FLAG',0)

% Devicelock configuration
devLockName = 'ANS/CA/SERVICE-LOCKER';
argin.svalue={'tunemeas'};

% Arguments
if nargin < 1
    action = 'Initialize';
end

switch action
    case 'Initialize'
        val = readattribute([devLockName '/' argin.svalue{:}]);

        if val == 1
            fprintf('Tune measurement already running. Stop other application first!\n')
            return;
        end

        ButtonHeight = 50;
        ButtonWidth=50;
        offset = 100;

        h=figure('Tag', 'TuneFig');
        uicontrol('Parent',h, ...
            'callback','calctuneTFB(''Start'');', ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[2 offset+2*(ButtonHeight+1) ButtonWidth 0.8*ButtonHeight], ...
            'String','Start', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','Start');

        uicontrol('Parent',h, ...
            'callback','calctuneTFB(''Stop'');', ...
            'Enable','on', ...
            'Interruptible', 'on', ...
            'Position',[2 offset+1*(ButtonHeight+1) ButtonWidth 0.8*ButtonHeight], ...
            'String','Stop', ...
            'Style','PushButton', ...
            'Value',0,...
            'Tag','Stop');

        %%
        % Locktag  = tango_command_inout2(devLockName,'Lock', argin.svalue{:});
        % argin.lvalue = int32(Locktag);

        % Get data
        [idx1 idx2 idx3 idx4 dataFFT1 dataFFT2] = local_gettune_FBT;

        len1= length(dataFFT1);
        len2= length(dataFFT2);

        subplot(2,1,1);
        xdata1 = (0:len1-1)/len1;
        setappdata(h,'xdata1', xdata1);

        H1 = num2str(xdata1(idx1-1+5),'%6.4f');
        %H1_var = xdata1(idx1-1+5);
        V1 = num2str(xdata1(idx2-1+floor(len1/4)),'%6.4f');
        f1 = semilogy(xdata1, dataFFT1, 'Tag', 'ydata1');
        title ('FBT1');
        xlim([0 0.5])
        setappdata(h,'yaxis1', f1);

        subplot(2,1,2);
        xdata2 = (0:len2-1)/len2;
        setappdata(h,'xdata2', xdata2);
        H2 =  num2str(xdata2(idx3-1+5),'%6.4f');
        V2 =  xdata2(idx4-1+floor(len2/4));
        f2 = semilogy(xdata2, (dataFFT2),'Tag', 'ydata1');
        title ('FBT2');
        xlim([0 0.5])
        setappdata(h,'yaxis2', f2);

        anno1 = annotation('textbox',...
            'Position',[0.14 0.83 0.12 0.08],...
            'FitHeightToText','off',...
            'String',{H1}, 'Tag', 'box1');
        setappdata(h,'anno1', anno1);

        anno2 = annotation('textbox',...
            'Position',[0.14 0.35 0.12 0.08],...
            'FitHeightToText','off',...
            'String',{H2}, 'Tag', 'box2');
        setappdata(h,'anno2', anno2);

    case 'Start'
        setappdata(findobj(gcbf,'Tag','TuneFig'),'FEEDBACK_STOP_FLAG',0);
        Locktag  = tango_command_inout2(devLockName,'Lock', argin.svalue{:});
        argin.lvalue = int32(Locktag);
        setappdata(findobj(gcbf,'Tag','TuneFig'),'Locktag',Locktag);

        % loop
        while ~getappdata(findobj(gcbf,'Tag','TuneFig'),'FEEDBACK_STOP_FLAG')

            [idx1 idx2 idx3 idx4 dataFFT1 dataFFT2] = local_gettune_FBT;
            xdata1 = getappdata(findobj(gcbf,'Tag','TuneFig'),'xdata1');
            xdata2 = getappdata(findobj(gcbf,'Tag','TuneFig'),'xdata2');
            len1 = length(xdata1);
            len2 = length(xdata2);

            if idx1 ~= -1
                tunex1 = xdata1(idx1-1+5);
                tunez1 = xdata1(idx2-1+floor(len1/4));
                set(getappdata(findobj(gcbf,'Tag','TuneFig'),'anno1'),'String',' ');
                set(getappdata(findobj(gcbf,'Tag','TuneFig'),'anno1'),'String', ...
                    sprintf('H = %5.4f \nV = %5.4f', tunex1, tunez1))
                set(getappdata(findobj(gcbf,'Tag','TuneFig'),'yaxis1'), 'Ydata', dataFFT1)
                tango_write_attribute2('ANS/DG/PUB-TUNE','tunex',tunex1);
                tango_write_attribute2('ANS/DG/PUB-TUNE','tunez',tunez1);
            end
            if idx2 ~= -1
                tunex2 = xdata2(idx3-1+5);
                tunez2 = xdata2(idx4-1+floor(len2/4));
                set(getappdata(findobj(gcbf,'Tag','TuneFig'),'anno2'),'String',' ');
                set(getappdata(findobj(gcbf,'Tag','TuneFig'),'anno2'), ...
                    'String',sprintf('H = %5.4f \nV = %5.4f', tunex2, tunez2))
                set(getappdata(findobj(gcbf,'Tag','TuneFig'),'yaxis2'), 'Ydata', dataFFT2)
                tango_write_attribute2('ANS/DG/PUB-TUNE','tunex2',tunex2);
                tango_write_attribute2('ANS/DG/PUB-TUNE','tunez2',tunez2);
            end
            pause(0.5);
            % Maintain lock on SOFB service
            tango_command_inout2(devLockName,'MaintainLock', argin);
        end

    case 'Stop'
        % Unlock SOFB service
        Locktag = getappdata(findobj(gcbf,'Tag','TuneFig'),'Locktag');
        argin.lvalue=int32(Locktag);
        tango_command_inout2(devLockName,'Unlock', argin);
        setappdata(findobj(gcbf,'Tag','TuneFig'),'FEEDBACK_STOP_FLAG', 1);
end


% while(1)
%     [idx1 idx2 idx3 idx4 dataFFT1 dataFFT2] = local_gettune_FBT;
%     if idx1 ~= -1
%         tunex1 = xdata1(idx1-1+5);
%         tunez1 = xdata1(idx2-1+floor(len1/4));
%         set(anno1,'String',' ');
%         set(anno1,'String',sprintf('H = %5.4f \nV = %5.4f', tunex1, tunez1))
%         set(f1, 'Ydata', dataFFT1)
%         tango_write_attribute2('ANS/DG/PUB-TUNE','tunex',tunex1);
%         tango_write_attribute2('ANS/DG/PUB-TUNE','tunez',tunez1);
%     end
%     if idx2 ~= -1
%         tunex2 = xdata2(idx3-1+5);
%         tunez2 = xdata2(idx4-1+floor(len2/4));
%         set(anno2,'String',' ');
%         set(anno2,'String',sprintf('H = %5.4f \nV = %5.4f', tunex2, tunez2))
%         set(f2, 'Ydata', dataFFT2)
%         tango_write_attribute2('ANS/DG/PUB-TUNE','tunex2',tunex2);
%         tango_write_attribute2('ANS/DG/PUB-TUNE','tunez2',tunez2);
%     end
%     pause(0.5);
%     % Maintain lock on SOFB service
%     tango_command_inout2(devLockName,'MaintainLock', argin);
% end


%subfunctions

function [idx1 idx2 idx3 idx4 dataFFT1 dataFFT2] = local_gettune_FBT

rep1 = tango_read_attribute2('ANS/RF/BBFDataViewer.1', 'excitedBunchData');
if ~isstruct(rep1) && rep1 == -1
    pause(1)
    rep1 = tango_read_attribute2('ANS/RF/BBFDataViewer.1', 'excitedBunchData');
    if ~isstruct(rep1) && rep1 == -1
        pause(2)
        rep1 = tango_read_attribute2('ANS/RF/BBFDataViewer.1', 'excitedBunchData');
    else
        rep1 = -1;
    end
end

rep2 = tango_read_attribute2('ANS/RF/BBFDataViewer.1', 'selectedBunchData');
%rep2 = tango_read_attribute2('ANS/RF/BBFDataViewer.2', 'excitedBunchData');
if ~isstruct(rep2) && rep2 == -1
    pause(1)
    rep2 = tango_read_attribute2('ANS/RF/BBFDataViewer.1', 'selectedBunchData');
    %rep2 = tango_read_attribute2('ANS/RF/BBFDataViewer.2', 'excitedBunchData');
    if ~isstruct(rep2) && rep2 == -1

        pause(2)
        rep2 = tango_read_attribute2('ANS/RF/BBFDataViewer.1', 'selectedBunchData');
        %rep2 = tango_read_attribute2('ANS/RF/BBFDataViewer.2', 'excitedBunchData');
    else
        rep2 = -1;
    end
end

if isstruct(rep1)
    data1 = double(rep1.value);
    dataFFT1 = abs(fft(data1));
    len1 = length(dataFFT1);
    [MNO1_h,idx1] = max (dataFFT1(5:floor(len1/4)));
    [MNO1_v,idx2] = max (dataFFT1(floor(len1/4):floor(len1/2)));
else
    idx1 = -1;
    idx2 = -1;
    dataFFT1 = 0;
end

if isstruct(rep2)
    data2 = double(rep2.value);
    dataFFT2 = abs(fft(data2));

    len2 = length(dataFFT2);
    [MNO2_h,idx3] = max (dataFFT2(5:floor(len2/4)));
    [MNO2_v,idx4] = max (dataFFT2(floor(len2/4):floor(len2/2)));
else
    idx3 = -1;
    idx4 = -1;
    dataFFT2 = 0;
end
