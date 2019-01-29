% fa_zoomer([server])
%
% Investigate and zoom into archive data for the last day.  The server argument
% can be a server name or one of SR, BR, or TS.

% Copyright (c) 2011 Michael Abbott, Diamond Light Source Ltd.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
%
% Contact:
%      Dr. Michael Abbott,
%      Diamond Light Source Ltd,
%      Diamond House,
%      Chilton,
%      Didcot,
%      Oxfordshire,
%      OX11 0DE
%      michael.abbott@diamond.ac.uk
function fa_zoomer(varargin)
    % h is used to store all persistent state that is not part of the generated
    % data.
    h = {};

    if nargin == 0
        h.server_name = 'ac14b719-srvsniffer1';
    else
        %h.server_name = fa_find_server(varargin{:});
        h.server_name = varargin
    end
    %h.server_name = fa_find_server(varargin{:});

    % Create figure with the standard toolbar but no menubar
    fig = figure('MenuBar', 'none', 'Toolbar', 'figure', ...
        'Position', [0 0 900 600]);
    global fa_data;
    fa_data = {};

    % Figure out sensible starting point for initial display.
    initial_id = 4;
    ids = sort(fa_getids(h.server_name, 'stored', 'missing'));
    id_ix = strmatch(fa_id2name(initial_id, h.server_name), ids, 'exact');
    if isempty(id_ix)
        id_ix = 1;
        initial_id = fa_name2id(ids(id_ix), h.server_name, 'missing');
    else
        id_ix = id_ix(1);
    end

    % Create the controls.
    global h_pos v_pos;
    h_pos = 10; v_pos = 10;
    h.bpm_list = control('edit', initial_id, 60, 'List of BPM FA ids');
    h.bpm_name_list = control('popup', ...
        dev2tangodev('BPMx',family2dev('BPMx')), 130, ...
        'Choose decimated data type to display', 'Value', 1, ...
        'Callback', protect(@bpm_name_callback));
    control('pushbutton', 'Back', 40, 'Return to previous zoom', ...
        'Callback', protect(@back_callback));
    control('pushbutton', 'Full', 40, 'View entire archive history', ...
        'Callback', protect(@full_archive_callback));
    control('pushbutton', '24h', 40, 'View last 24 hours', ...
        'Callback', protect(@last_day_callback));
    control('pushbutton', 'Zoom', 60, 'Update zoomed area from archive', ...
        'Callback', protect(@zoom_in_callback));
    control('pushbutton', 'Spectrogram', 100, 'Show as spectrogram', ...
        'Callback', protect(@spectrogram_callback));
    h.message = control('text', '', 150, ...
        'Error message or [bpm count] samples/decimation');
    h.maxpts = control('edit', num2str(1e6), 80, ...
        'Maximum number of sample points');
    h.ylim = control('popup', {'Zoomed', 'Auto', 'Scaled', 'Centre'}, 70, ...
        'Control limits of vertical scale', 'Value', 2, ...
        'Callback', protect(@reload_plot));
    h.data_type = control('popup', {'min/max', 'std', 'mean'}, 90, ...
        'Choose decimated data type to display', 'Value', 1, ...
        'Callback', protect(@reload_plot));
    control('pushbutton', 'Save', 40, 'Save data to file', ...
        'Callback', protect(@save_data));
    control('pushbutton', 'Legend', 60, 'Show legend', ...
        'Callback', protect(@show_legend));

    % Some extra controls on the line above
    %h_pos = 10; v_pos = v_pos + 30;
    %control('popup', ids, 150, ...
    %    'Valid BPM names', 'Value', id_ix, 'Callback', protect(@set_bpm_list));

    h_pos = 10; v_pos = 30;
    control('popup', {'ac14b719-srvsniffer1','ac7b727-pc1'}, 150, ...
        'Choose archiver', 'Value', id_ix, 'Callback', protect(@set_archiver));

    clear global h_pos v_pos;
    h.history = cell(0, 2);

    % Hang onto the controls we need to reference later
    guidata(fig, h);

    full_archive_callback(fig, 0);
end


% Places control with specified style, value, width  and tooltip.
function result = control(style, value, width, tooltip, varargin)
    global h_pos v_pos;
    position = [h_pos v_pos width 20];
    h_pos = h_pos + width + 5;
    result = uicontrol( ...
        'Style', style, 'String', value, 'Position', position, ...
        'TooltipString', tooltip, varargin{:});
end


function prot = protect(func)
    function protected(fig, event)
        try
            func(fig, event)
        catch
            message('Error: see console')
            rethrow(lasterror)
        end
    end
    prot = @protected;
end


% function set_bpm_list(fig, event)
%     h = guidata(fig);
%     names = get(fig, 'String');
%     index = get(fig, 'Value');
%     name = names{index};
%     id = fa_name2id(name, h.server_name, 'missing');
%     set(h.bpm_list, 'String', id)
% end

function set_archiver(fig, event)
    h = guidata(fig);
    names = get(fig, 'String');
    index = get(fig, 'Value');
    name = names{index};
    h.server_name = name;
    % disp(h.server_name);
    guidata(fig, h);
    full_archive_callback(fig)
end

function back_callback(fig, event)
    h = guidata(fig);
    if size(h.history, 1) > 1
        h.history = h.history(1:end-1, :);
        range = h.history{end, 1};
        type  = h.history{end, 2};
        guidata(fig, h)
        load_data(fig, range, type, false);
    end
end


function full_archive_callback(fig, event)
    load_data(fig, [now-2000 now], 'D', true);    % Go back as far as possible!
end


% Loads data for the last 24 hours
function last_day_callback(fig, event)
    load_data(fig, [now-1 now], 'D', true);
end


% Loads data enclosed by the current zoom selection, returned by xlim.
function zoom_in_callback(fig, event)
    h = guidata(fig);
    global fa_data;

    maxdata = str2num(get(h.maxpts,   'String'));
    pvs     = str2num(get(h.bpm_list, 'String'));
    points = diff(xlim) * 24 * 3600 * 10072 * length(pvs);

    type = 'F';
    if points > maxdata
        type = 'd';
        points = points / 64;
        if points > maxdata
            type = 'D';
        end
    end

    load_data(fig, xlim + h.ts_offset, type, true);
end


function reload_plot(fig, event)
    global fa_data;
    plotfa(fig, fa_data);
end


% Loads the requested range of data.
function load_data(fig, range, type, save)
    h = guidata(fig);
    if save
        h.history(end+1, :) = {range, type};
        guidata(fig, h)
    end

    pvs = str2num(get(h.bpm_list, 'String'));

    busy;

    global fa_data;
    fa_data = fa_load(range, pvs, type, h.server_name);
    plotfa(fig, fa_data);

    describe;
end


% Saves data to file
function save_data(fig, event)
    global fa_data;
    [file, path] = uiputfile('*.mat', 'Save archive data');
    if ~isequal(file, 0) & ~isequal(path, 0)
        save(fullfile(path, file), '-struct', 'fa_data');
    end
end


% Hann window for improved spectral resolution.
function a = hannwin(n, m)
    t = linspace(0, 2*pi, n+1);
    t = t(1:n);
    a = 0.5 * (1 - cos(t)).';
    if nargin == 2
        a = repmat(a, 1, m);
    end
end


% Plot spectrogram
function spectrogram_callback(fig, event)
    h = guidata(fig);
    global fa_data;
    len = 1024;

    xy_names = axis_names(h, fa_data);
    scale = 1e-3 * sqrt(2 / (len * fa_data.f_s));
    if length(size(fa_data.data)) == 3
        busy;
        for n = 1:2
        subplot(2, 1, n)
            e = squeeze(fa_data.data(n, 1, :));
            cols = floor(length(e)/len);
            sg = log10(scale * abs(fft( ...
                reshape(e(1:(len*cols)), len, cols) .* hannwin(len, cols))));
            imagesc(fa_data.t, [0 fa_data.f_s/2], sg(1:(round(len/2)), :));

            set(gca, 'Ydir', 'normal');
            colorbar
            label_axis(h, n, xy_names, 'Hz', 'Spectrogram')
        end
        describe;
    else
        message('Decimated data');
    end
end


% Fudge the data to a common scale (kind of freaky to be honest!).  The data is
% either data(xy, id, t) or data(ix, id, seln, t); in the first case we can
% treat all dimensions equally, but in the latter case we have to take careful
% account of seln, which is one of: 1 - mean, 2 - min, 3 - max, 4 - std.
function [data, scaled] = scale_data(data)
    s = size(data);
    time_ix = length(s);
    if s(time_ix - 1) > 1
        low  = min(data, [], time_ix);
        high = max(data, [], time_ix);

        % Special fudge for min & max data, ensure data ranges set together
        if time_ix == 4
            low (:, 3, :) = low (:, 2, :);      % low(max) = low(min)
            high(:, 2, :) = high(:, 3, :);      % high(min) = high(max)
        end

        range = high - low;
        range(find(range == 0)) = 0;    % Avoid division by zero
        low   = repmat(low,   [ones(1, time_ix-1) s(time_ix)]);
        range = repmat(range, [ones(1, time_ix-1) s(time_ix)]);
        data = 1e3 * (data - low) ./ range;
        scaled = true;
    else
        scaled = false;
    end
end


% Fudge the data by subtracting a common centre from both data sets
function data = centre_data(data)
    s = size(data);
    time_ix = length(s);
    middle = mean(data, time_ix);

    % For min and max data need to centre on common mean, and mean subtraction
    % for std data is just silly
    if time_ix == 4
        middle(:, 2, :) = mean(middle(:, 2:3, :), 2);
        middle(:, 3, :) = middle(:, 2, :);
        middle(:, 4, :) = 0;
    end

    data = data - repmat(middle, [ones(1, time_ix-1) s(time_ix)]);
end


function hold_on
    try
        % From matlab 2014b hold on has changed its behaviour, and we need
        % to explicitly reset the colour order.  Unfortunately this is a
        % new property, so this fails on older versions of matlab!
        set(gca, 'ColorOrderIndex', 1)
    end
    hold on
end


function plotfa(fig, d)
    h = guidata(fig);
    data = d.data;
    data_type = get(h.data_type, 'Value');

    set_ylim = [];
    annotation = '';
    units = '\mu m';
    scaled = false;
    switch get(h.ylim, 'Value')
        case 1
            % Fixed Y axes
            if length(size(data)) == 4
                switch data_type
                    case 1;     set_ylim = [-100 100];
                    case 2;     set_ylim = [0 10];
                    case 3;     set_ylim = [-10 10];
                end
            else
                set_ylim = [-100 100];
            end
        case 2
            % No action needed
        case 3
            [data, scaled] = scale_data(data);
            if scaled
                annotation = '(Common vertical scale)';
                units = 'a.u.';
            end
        case 4
            data = centre_data(data);
            if data_type ~= 2 && length(size(data)) == 4
                annotation = '(Mean subtracted)';
            end
    end

    xy_names = axis_names(h, d);
    if diff(d.t([1 end])) >= 1
        ts = d.t + d.day;
        h.ts_offset = 0;
    else
        ts = d.t;
        h.ts_offset = d.day;
    end
    guidata(fig, h)

    for n = 1:2
        subplot(2, 1, n)
        if length(size(data)) == 4
            switch data_type
                case 1
                    plot(ts, 1e-3 * squeeze(data(n, 2, :, :))); hold_on
                    plot(ts, 1e-3 * squeeze(data(n, 3, :, :))); hold off
                case 2
                    plot(ts, 1e-3 * squeeze(data(n, 4, :, :)));
                case 3
                    plot(ts, 1e-3 * squeeze(data(n, 1, :, :)));
            end
        else
            plot(ts, 1e-3 * squeeze(data(n, :, :)))
        end

        xlim([ts(1) ts(end)]);
        if isempty(set_ylim)
            % Stretch ylim by 10% to avoid hitting upper and lower limits
            ylim(ylim + [-0.1 0.1] * diff(ylim));
        else
            ylim(set_ylim);
        end
        label_axis(h, n, xy_names, units, annotation);
        if scaled; set(gca, 'YTick', []); end
        zoom reset;
    end


    % Called when zooming is done: refresh the display
    function refresh_ticks(obj, event_obj)
        label_axis(h, 1, xy_names, units, annotation);
        label_axis(h, 2, xy_names, units, annotation);
    end

    z = zoom(gcf);
    set(z, 'Enable', 'on');
    set(z, 'ActionPostCallback', @refresh_ticks);
end


% Compute sensible axis names for the data to plot.
function xy_names = axis_names(h, d)
    [names, x_names, y_names] = fa_id2name(d.ids, h.server_name);
    if length(d.ids) == 1
        % Easy case
        xy_names = { ...
            sprintf('%s %s', names, x_names);
            sprintf('%s %s', names, y_names) };
    else
        % In the mixed case only return our best stab at unique axis names
        xy_names = { ...
            if_unique(x_names, '(mixed)');
            if_unique(y_names, '(mixed)') };
    end
end


% If all values in cells are the same returns the unique value, otherwise
% returns the mixed value
function result = if_unique(cells, mixed)
    result = cells{1};
    for c = cells(2:end)
        if ~strcmp(c, result)
            result = mixed;
            return
        end
    end
end


% Label axes
function label_axis(h, n, axes, yname, annotation)
    global fa_data;
    ylabel(gca, yname);

    msecs_per_day = 1e3 * 24 * 3600;
    range = xlim;
    ms_interval = diff(range) * msecs_per_day;

    start = range(1) + h.ts_offset;
    format = 'ddd yyyy-mm-dd';
    if ms_interval <= 5000
        % If the data spans less than a handful of seconds we need to get cute
        % and smart about computing ticks.  The placement Matlab has done for us
        % really isn't good enough.

        % Start by figuring out a tick interval we're going to be happy with.
        tick_intervals = [1 2 5 10 20 50 100 200 500 1000];
        ix = find(ms_interval ./ tick_intervals < 8);
        tick_interval = tick_intervals(ix(1));

        % Compute the corresponding tick positions and their labels.
        start_tick = ceil(range(1) * msecs_per_day / tick_interval);
        end_tick = floor(range(2) * msecs_per_day / tick_interval);
        ticks_ms = tick_interval * (start_tick:end_tick);

        % Label the computed ticks in seconds and milliseconds into the current
        % minute.
        minute = 1e3 * 60 * floor(range(1) * 24 * 60);
        set(gca, 'XTick', ticks_ms / msecs_per_day);
        set(gca, 'XTickLabel', num2str(1e-3 * (ticks_ms - minute)', '%.3f'));

        format = [format ' HH:MM:SS'];
    else
        % For ranges in the order of days show the days label in a sensible
        % form, otherwise rely on datetick's automatic choices.
        if diff(range) >= 3
            datetick('x', 'dd/mm', 'keeplimits')
        else
            datetick('keeplimits')
        end
        start = floor(start);
    end

    title_string = [datestr(start, format) ' - ' axes{n}];
    if annotation;
        title_string = [title_string ' ' annotation];
    end
    title(title_string)
end


function show_legend(fig, event)
    h = guidata(fig);
    global fa_data;
    for n = 1:2
        subplot(2, 1, n)
        legend(fa_id2name(fa_data.ids, h.server_name, 'missing'));
    end
end


function message(msg)
    h = guidata(gcf);
    set(h.message, 'String', msg);
end

function busy
    message('Busy');
    drawnow;
end

% Prints description of currently plotted data
function describe
    global fa_data;
    message(sprintf('[%d] %d/%d', ...
        length(fa_data.ids), length(fa_data.data), fa_data.decimation))
end

% Gives id from selected BPM Name
function bpm_name_callback(fig, event)
    h = guidata(gcf);
    index = get(h.bpm_name_list, 'Value');
    set(h.bpm_list, 'String', num2str(index));
end

