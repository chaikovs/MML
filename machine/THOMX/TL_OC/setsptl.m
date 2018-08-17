function ErrorFlag = setsptl(Family, varargin)
%SETSP - Makes an absolute setpoint change to the 'Setpoint' field
%  If using family name, device list method,
%  ErrorFlag = setsp(Family, newSP, DeviceList, WaitFlag)
%  ErrorFlag = setsp(DataStructure, WaitFlag)
%
%  If using common name method,
%  ErrorFlag = setsp(Family, newSP, CommonNames, WaitFlag)
%
%  If using channel name method,
%  ErrorFlag = setsp('ChannelName', newSP)
%
% INPUTS
% 1. Family = Family Name 
%             Data Structure
%             Channel Name
%             Accelerator Object
%             For CommonNames Family=[], searches all families
%             (or a Cell Array of inputs)
% 2. ChannelName = Channel access channnel name (scalar or vector inputs)
%                  Matrix of channel names (scalar inputs only)
%                  Cell array of channel names
% 3. CommonName = Common name (scalar or vector inputs), 
%                 Matrix of common names (scalar inputs only)
%                 Cell array of common names
% 4. newSP  = new setpoints or cell array of new setpoints
%    DeviceList ([Sector Device #] or [element #]) {default or empty list: whole family}
% 5. WaitFlag = 0    -> return immediately
%              > 0  -> wait until ramping is done then adds an extra delay equal to WaitFlag 
%              = -1 -> wait until ramping is done {SLAC default}
%              = -2 -> wait until ramping is done then adds an extra delay for fresh data from the BPMs  {ALS default}
%              else -> wait until ramping is done
%              Note: change WaitFlag default and BPM delay in setpv.m
%
%  NOTE
%  1. The number of colomns of newSP and DeviceList must be equal,
%     or newSP must be a scalar.  If newSP is a scalar, then all
%     devices in DeviceList will be set to the same value. 
%  
%  2. For data structure inputs:
%     Family     = DataStructure.FamilyName
%     Field      = DataStructure.Field
%     DeviceList = DataStructure.DeviceList
%
%  2. When using cell array all inputs must be the same size cell array
%     and the output will also be a cell array. 
%
%  3. For families and accelerator data structures unknown devices or elements are ignored.
%     A warning message will be printed to the screen. 
%
%  4. Channel name method is always Online!
%
%  5. For cell array inputs: 
%     a. Input 1 defines the maximum size of all cells
%     b. The cell array size must be 1 or equal to the number of cell in input #1
%     c. WaitFlag can be a cell but it doesn't have to be
%
%  EXAMPLES
%  1. setsp(HCOR',1.23)  sets the entire HCOR family to 1.23
%  2. setsp({'HCOR','VCOR'},{10.4,5.3})  sets the entire HCOR family to 10.4 and VCOR family to 5.3
%  3. setsp(AccData, 1.5, [1 2]) if AccData is a properly formated Accelerator Data Structure
%                                 then the 1st sector, 2nd element is set to 1.5
%
%  See also stepsp, getam, getsp, getpv, setpv, steppv

%
% Written by Gregory J. Portmann
% Modified by Laurent S. Nadolski

if nargin == 0
    error('Must have at least one input (Family, Data Structure or Channel Name).');
end


if iscell(Family)
    ErrorFlag = setpvtl(Family, 'Setpoint', varargin{:});
else
    FamilyIndex = isfamily(Family);

    if FamilyIndex
        % Family name method
        % Cannot send the AO because the AO method needs the setpoint on the input line
        ErrorFlag = setpvtl(Family, 'Setpoint', varargin{:});
    else
        % ChannelName method
        ErrorFlag = setpvtl(Family, '', varargin{:});
    end
end

