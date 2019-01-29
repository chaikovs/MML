function ErrorFlag = switch2manual(Family)
%SWITCH2MANUAL - Switch family to manual mode.
%
%   ErrorFlag = switch2manual(Family)
%
%   Family - Family name string 
%            Matrix of family name strings
%            Cell array of family name strings
%            {Default: All families}
%
%   ErrorFlag - Number of errors that occurred
%
% See also switch2sim, switch2online

%
%   Written by Gregory J. Portmann


ErrorFlag = 0;

if nargin == 0
    Family = getfamilylist;
end
if isempty(Family)
    Family = getfamilylist;
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
                setfamilydata('Manual', AOFamily.FamilyName, AllFields{j}, 'Mode');
            end
        end
    catch
        ErrorFlag = ErrorFlag + 1;
        fprintf('   Error switching %s family to manual mode, hence ignored (switch2manual)\n', FamilyNameCell{i});        
    end
end


if ~ErrorFlag
    if length(FamilyNameCell) == 1
        fprintf('   Switched %s family to manual mode (%s)\n', FamilyNameCell{1}, datestr(clock,0));
    else
        fprintf('   Switched %d families to manual mode (%s)\n', length(FamilyNameCell)-ErrorFlag, datestr(clock,0));
    end
end


if ~isdeployed % add path does not work for deployed applications
    % Personalized prompt
    if exist('setPrompt', 'file') == 2
         % LSN commented for suspicious of memory leak
         %setPrompt('Manual>> ');
    end
    
    % Change background color of the command window
    jDesktop = com.mathworks.mde.desk.MLDesktop.getInstance;
    cmdWin=jDesktop.getClient('Command Window');
    jTextarea = cmdWin.getComponent(0).getViewport.getView;
    jTextarea.setBackground(java.awt.Color(1,1,.80));
end