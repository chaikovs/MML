function mml2edm_mps(Directory)

% Setup = {
%     'Setpoint',       'Setpoint',    70
%     'Monitor',        'Monitor',     70
%     'Voltage',        'Voltage',     70
%     'BulkVoltage',    'B-Voltage',   70
%    %'RampRate',       'RampRate',    70
%    %'Ready',          'Rdy',         30
%     'On',             'On',          30
%     'OnControl',      'OnControl',   70 
%     'BulkOn',         'BOn',         30
%     'BulkControl',    'BulkControl', 80 
%    %'Reset',          'Reset',       65
%     'RelatedDisplay', 'More Info',   80
%    };
% 
% Fields       = Setup(:,1);
% ColumnLabels = Setup(:,2);
% ColumnWidth  = Setup(:,3);



DirStart = pwd;

if nargin < 1
    if ispc
        cd \\Als-filer\physbase\hlc\BR
    else
        cd /home/als/physbase/hlc/BR
    end
else
    cd(Directory);
end


WindowLocation = [120 60];
FileName = 'MML2EDM_BR_MPS.edl';
TitleBar = 'BR Magnet Power Supplies';
GoldenSetpoints = 'On';
MotifWidget = 'Off';
SP_AM = 'On';
ChannelLabelWidth = 70;
BG = 4;  % LTB=, BR=, BTS=62, SR=4  (Note: TextControl BG=0)

ColumnLabels = {'Setpoint', 'Monitor', 'Rate', 'SP-AM', 'Ready', 'On', 'OnCtrl',       'TM'              'TrigMode',    'Arm',       'Arm',    'Act',       'En',           'Enable', 'Trig1 on Rise', 'Trig2 on Rise', 'Trig1 on Fall', 'Trig2 on Fall'};
Fields       = {'Setpoint', 'Monitor', 'RampRate',      'Ready', 'On', 'OnControl', 'AWGTrigModeRBV', 'AWGTrigMode', 'AWGArmRBV', 'AWGArm', 'AWGActive', 'AWGEnableRBV', 'AWGEnable', 'AWGInt1Rise',   'AWGInt2Rise',   'AWGInt1Fall',   'AWGInt2Fall'};

[x11, y11]= mml2edm('HCM', ...
    'FileName', FileName, ...
    'MoreButton', 'On', ...
    'Fields', Fields, ...
    'ColumnLabels', ColumnLabels, ...
    'xStart', 3, ...
    'yStart', 0, ...
    'SP-AM', SP_AM, ...
    'SP_BackgroundColor', BG-1, ...
    'Precision', 4, ...
    'WindowLocation', [120 60], ...
    'GoldenSetpoints', GoldenSetpoints, ...
    'MotifWidget', MotifWidget, ...
    'ChannelLabelWidth', ChannelLabelWidth, ...
    'BCButtonType', 'Choice', ...   % Reset or Choice, Double???
    'TableTitle', 'Horizontal Correctors', ...
    'TitleBar', TitleBar);


[x21, y21]= mml2edm('VCM', ...
    'FileName', FileName, ...
    'MoreButton', 'On', ...
    'Fields', Fields, ...
    'ColumnLabels', ColumnLabels, ...
    'Append', ...
    'xStart', 3, ...
    'yStart', y11+10, ...
    'SP-AM', SP_AM, ...
    'SP_BackgroundColor', BG-1, ...
    'Precision', 4, ...
    'WindowLocation', [120 60], ...
    'GoldenSetpoints', GoldenSetpoints, ...
    'MotifWidget', MotifWidget, ...
    'ChannelLabelWidth', ChannelLabelWidth, ...
    'TableTitle', 'Vertical Correctors', ...
    'TitleBar', TitleBar);

[x31, y31]= mml2edm('SF_IRM', ...
    'FileName', FileName, ...
    'MoreButton', 'On', ...
    'Fields', Fields, ...
    'ColumnLabels', ColumnLabels, ...
    'Append', ...
    'xStart', 3, ...
    'yStart', y21+10, ...
    'SP-AM', SP_AM, ...
    'SP_BackgroundColor', BG-1, ...
    'Precision', 4, ...
    'WindowLocation', [120 60], ...
    'GoldenSetpoints', GoldenSetpoints, ...
    'MotifWidget', MotifWidget, ...
    'ChannelLabelWidth', ChannelLabelWidth, ...
    'TableTitle', 'SF', ...
    'TitleBar', TitleBar);

[x41, y41]= mml2edm('SD_IRM', ...
    'FileName', FileName, ...
    'MoreButton', 'On', ...
    'Fields', Fields, ...
    'ColumnLabels', ColumnLabels, ...
    'Append', ...
    'xStart', 3, ...
    'yStart', y31+10, ...
    'SP-AM', SP_AM, ...
    'SP_BackgroundColor', BG-1, ...
    'Precision', 4, ...
    'WindowLocation', [120 60], ...
    'GoldenSetpoints', GoldenSetpoints, ...
    'MotifWidget', MotifWidget, ...
    'ChannelLabelWidth', ChannelLabelWidth, ...
    'TableTitle', 'SD', ...
    'TitleBar', TitleBar);
                   
% Add push buttons for other applications
%edm_addinjectorbuttons(0, y21+20, FileName);


xmax = max([x11 x21 x31 x41]);
ymax = max([y11 y21 y31 y41]);
% if  ymax > 1200 %  I'm not sure when the slider appears
%     % To account for a window slider
%     Width  = xmax+30;
%     Height = 1220;
% else
     Width  = xmax + 10;
     Height = ymax + 20+40;
% end

%EDMExitButton(xmax-68, 3, 'FileName', FileName, 'ExitProgram');

Header = EDMHeader('FileName', FileName, 'TitleBar', TitleBar, 'WindowLocation', WindowLocation, 'Width', Width, 'Height', Height, 'BackgroundColor', BG);



cd(DirStart);




function WriteEDMFile(FileName, Header)

AppendFlag = 1;

if AppendFlag
    fid = fopen(FileName, 'r+', 'b');
    status = fseek(fid, 0, 'eof');
else
    fid = fopen(FileName, 'w', 'b');
    WriteEDMFile(fid, Header);
end

for i = 1:length(Header)
    fprintf(fid, '%s\n', Header{i});
end
fprintf(fid, '\n');
fclose(fid);


