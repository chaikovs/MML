function Mode = switchmode(varargin)
%SWITCHMODE - Change the mode field for all families in the MML
%  Mode = switchmode(Command)
%
%  KEYWORDS
%  1. 'Online' - Switches to online 
%  2. 'Simulator' - Switches to simulator 
%  3. 'Model' - Switches to model 
%  4. 'Manual' - Switches manual mode
%
%  OUTPUTS
%  1. Mode - Mode selected
%
%  See Also switch2sim, switch2online, switch2manual, switch2model

%
%  Written by Gregory J. Portmann

Mode = '';

if isempty(varargin)
    ButtonName = questdlg('Matlab MiddleLayer Mode?','Middle Layer','Online', 'Simulator', 'Online');
    switch ButtonName
        case 'Online'
            switch2online;
            Mode = 'Online';
        case 'Simulator'
            switch2sim;
            Mode = 'Simulator';
    end
else
    if strcmpi(varargin{1},'online')
        switch2online;
        Mode = 'Online';
    elseif strcmpi(varargin{1},'simulator') | strcmpi(varargin{1},'model')
        switch2sim;
        Mode = 'Simulator';
    elseif strcmpi(varargin{1},'manual')
        switch2manual;
        Mode = 'Manual';
    else
        error('Mode type unknown.');
    end
end
