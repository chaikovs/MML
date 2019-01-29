function ErrorFlag = switch2sim(Family, DisplayFlag)
%SWITCH2SIM - Switch family to simulator mode if the family is in online mode.
%             If the family is in manual or special mode no change is made.
%
%   ErrorFlag = switch2sim(Family)
%
%  INPUTS
%  1. Family - Family name string 
%            Matrix of family name strings
%            Cell array of family name strings
%            {Default: All families}
%  2. DisplayFlag - 0 No Display
%                   1 Display {default}
%
%  OUTPUTS
%  1. ErrorFlag - Number of errors that occurred
%
%  See Also switch2online, switch2manual

%
%   Written by Gregory J. Portmann

ErrorFlag = 0;

if nargin == 0
    Family = '';
end
if isempty(Family)
    Family = getfamilylist;
end
if nargin < 2
    DisplayFlag = 1;
end


if ischar(Family)
    for i = 1:size(Family,1)
        FamilyNameCell(i) = {deblank(Family(i,:))};
    end
elseif iscell(Family)
    FamilyNameCell = Family;
else
    error('Familyname input must be empty, a string matrix, or a cell array of strings');
end


for i = 1:length(FamilyNameCell)
    AOFamily = getfamilydata(FamilyNameCell{i});
    try
        AllFields = fieldnames(AOFamily);
        for j = 1:length(AllFields)
            if isfield(AOFamily.(AllFields{j}),'Mode')
                %if strcmpi(AOFamily.(AllFields{j}).Mode,'Online') | strcmpi(AOFamily.(AllFields{j}).Mode,'Special')
                setfamilydata('Simulator', AOFamily.FamilyName, AllFields{j}, 'Mode');
                %end
            end
        end
    catch
        ErrorFlag = ErrorFlag + 1;
        fprintf('   Error switching %s family to simulator, hence ignored (switch2sim)\n', FamilyNameCell{i});        
    end
end


if ~ErrorFlag
    if length(FamilyNameCell) == 1
        if DisplayFlag
            fprintf('   Switched %s family to simulator mode (%s)\n', FamilyNameCell{1}, datestr(clock,0));
        end
    else
        if DisplayFlag
            fprintf('   Switched %d families to simulator mode (%s)\n', length(FamilyNameCell)-ErrorFlag, datestr(clock,0));
        end
    end
end

if ~isdeployed % add path does not work for deployed applications
    % Personalized prompt
    if exist('setPrompt', 'file') == 2
        % LSN commented for suspicious of memory leak
        % setPrompt(sprintf('-Mode n°%d %s-\nSimulator>>',getfamilydata('ModeNumber'),getfamilydata('SpecialTag')));
        %setPrompt('Simulator>> ');
    end
    
    % Change background color of the command window
    jDesktop = com.mathworks.mde.desk.MLDesktop.getInstance;
    cmdWin=jDesktop.getClient('Command Window');
    jTextarea = cmdWin.getComponent(0).getViewport.getView;
    jTextarea.setBackground(java.awt.Color(1,1,.80));
end