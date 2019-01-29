function [offsets_X,offsets_Z, DeviceList] = getbpmBBAoffsets(varargin)
%GETBPMBBAOFFSETS- Reads the current BBA offset stored int the TANGO static database
%
%  OUTPUTS
%  1. offsets_X - Horizontal BPM BBA offsets
%  2. offsets_Z - Vertical BPM BBA offsets

%
%% Written by N. Hubert
%  Modified June 2009, Add plot Laurent S. Nadolski

% TODO
% WARNING if BPM added not working. Need to define device list !!!


DisplayFlag = 1;
ReportFlag = 0;

% Switchyard
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Report')
        ReportFlag = 1;
        varargin(i) = [];
    end
end

if ~isempty(varargin)
    AskedDevList = varargin{1};
    DisplayFlag = 0;
end

X_offset_BBA=0;
Z_offset_BBA=0;

increment=1;
Correspondance=tango_get_db_property('BPM','DeviceParameters');
block_table=tango_get_db_property('BPM','BlockParameters');

for i=1:1:size(Correspondance,2)
    index=regexpi(Correspondance{i},'ANS-C');
    if ~isempty(index)
        BPM_name=Correspondance{i}(index:index+15);
        block_name=Correspondance{i}(index+17:index+24);
        for j=1:1:size(block_table,2)
            index3=regexpi(block_table{j},[block_name,':']);
            if ~isempty(index3)
                separator=regexpi(block_table{j},':');
                X_offset_BBA(increment) = str2num(block_table{j}(separator(8)+1:separator(9)-1));
                Z_offset_BBA(increment) = str2num(block_table{j}(separator(10)+1:separator(11)-1));
                BPM(increment,:)=BPM_name;
                DeviceList(increment,:) = tangodev2dev(BPM_name); % Build up device list
                increment = increment+1;
            end
        end
    end
end


% 3 lines to be removes if calling programmes use the device list
offsets_X = [X_offset_BBA(2:end) X_offset_BBA(1)]';
offsets_Z = [Z_offset_BBA(2:end) Z_offset_BBA(1)]';
DeviceList = [DeviceList(2:end,:); DeviceList(1,:)];

if exist('AskedDevList', 'var')
   Idx = findrowindex(AskedDevList, DeviceList);
   offsets_X  = offsets_X(Idx);
   offsets_Z  = offsets_Z(Idx);
   DeviceList = DeviceList(Idx,:);
end


if DisplayFlag
    figure
    spos = getspos('BPMx');
    h1 = subplot(5,1,[1 2]);
    plot(spos, offsets_X, '.-')
    ylabel('X BBA Offsets (mm)')
    grid on;
    h2 = subplot(5,1,3);
    drawlattice
    h3 = subplot(5,1,[4 5]);
    plot(spos, offsets_Z, '.-')
    ylabel('Z BBA Offsets (mm)')
    grid on;
    linkaxes([h1 h2 h3], 'x')
    addlabel(1,0,sprintf('%s', datestr(clock,0)));
end

if ReportFlag
       % output result in text format
    fileName = tempname;
    fid = fopen(fileName, 'wt');
    fprintf(fid, '*************************************************\n');
    fprintf(fid, '** BBA Full Offset:  %s **\n', datestr(now) );
    fprintf(fid, '*************************************************\n');
    fprintf(fid, '* BPM        x(mm)  z(mm)   \n\n');
    if ~isempty(offsets_X)
        for ih = 1:size(offsets_X,1)
            fprintf(fid, 'BPM [%2d %1d] % .3f % .3f\n', DeviceList(ih,:), offsets_X(ih), offsets_Z(ih));
        end
    end
    fclose(fid);
    %system(['nedit ' fileName '&']);
    edit(fileName);
end