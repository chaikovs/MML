function ErrorFlag = setam(Family, varargin)
%SETAM - Sets analog monitor value
% If using family name, device list method,
% ErrorFlag = setam(Family, newAM, DeviceList)
%
% If using common name method,
% ErrorFlag = setam(Family, newAM, CommonNames, WaitFlag)
%
% If using channel name method,
% ErrorFlag = setam('ChannelName', newAM)
%
% Inputs:  Family = Family Name 
%                   Accelerator Object
%                   Cell Array of Accelerator Objects or Family Names
%                   For CommonNames Family=[], searches all families
%          ChannelName = Channel access channnel name (scalar or vector inputs)
%                        Matrix of channel names (scalar inputs only)
%                        Cell array of channel names
%          CommonName = Common name (scalar or vector inputs), 
%                       Matrix of common names (scalar inputs only)
%                       Cell array of common names
%          newAM  = new "monitor" or cell array of new "monitors"
%          DeviceList ([Sector Device #] or [element #]) {default or empty list: whole family}
%          WaitFlag = 0    -> return immediately
%                     1    -> wait until ramping is done + BPM delay {default}
%                     else -> wait until ramping is done
%                      
% Note #1: The number of colomns of newSP and DeviceList must be equal,
%          or newSP must be a scalar.  If newSP is a scalar, then all
%          devices in DeviceList will be set to the same value. 
% Note #2: When using cell array all inputs must be the same size cell array
%          and the output will also be a cell array. 
% Note #3: For families and accelerator data structures unknown devices or elements are ignored.
%          A warning message will be printed to the screen. 
% Note #4: Channel name method is always Online!
% Note #5: setam is an odd thing to do but it's here incase you want it.
%
% Ex., setam(HCM',1.23)  sets the entire HCM family to 1.23
%      setam({'HCM','VCM'},{10.4,5.3})  sets the entire HCM family to 10.4 and VCM family to 5.3
%      setam(AccData, 1.5, [1 2])  if AccData is a properly formated Accelerator Data Structure
%                                  then the 1st sector, 2nd element is set to 1.5
%
% See also getam, getsp, setsp, getpv, setpv

%
% Written by Gregory J. Portmann


%          ErrorFlag = 0 -> OK
%                     -1 -> SCA error
%                     -2 -> SP-AM warning (only if WaitFlag=1)

if nargin < 2
    error('Must have at least 2 inputs (Family or Channel Name and newSP).');
end

[ErrorFlag] = setpv(Family, 'Monitor', varargin{:});


