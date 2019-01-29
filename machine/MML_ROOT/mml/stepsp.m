function ErrorFlag = stepsp(Family, varargin)
%STEPSP - Step the setpoint for family 
%  If using family name, device list method,
%  ErrorFlag = stepsp(Family, DeltaSP, DeviceList, WaitFlag)
%
%  If using a data structure,
%  ErrorFlag = steppv(DataStructure, WaitFlag)
%  Note: DataStructure.Data is now the DeltaSP!
%
%  If using common name method,
%  ErrorFlag = stepsp(Family, DeltaSP, CommonNames, WaitFlag)
%
%  If using channel name method,
%  ErrorFlag = stepsp(ChannelName, DeltaSP)
%
%  If using Tango name method,
%  ErrorFlag = stepsp(TangoName, DeltaSP)
%
% See setsp for details on each input/output
%
% See also getam, getsp, setsp, getpv, setpv

%
% Written by Gregory J. Portmann

%ErrorFlag = setpv('Inc', varargin{:});

if nargin == 0
    error('Must have at least one input (Family, Data Structure or Channel or Tango Name).');
end


if iscell(Family)
    ErrorFlag = setpv('Inc', Family, 'Setpoint', varargin{:});
else
    [FamilyIndex, AO] = isfamily(Family);

    if FamilyIndex
        % Family name method
        ErrorFlag = setpv('Inc', AO, 'Setpoint', varargin{:});
    else
        % ChannelName or TangoName method
        ErrorFlag = setpv('Inc', Family, '', varargin{:});
    end
end



