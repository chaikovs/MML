function [AM, tout, DataTime, ErrorFlag] = getzwithXBPM(varargin)
% GETZWITHXBPM - Read Vertical orbit from BPM and XBPMs
%
%  INPUTS
%  1. DeviceList or Element list
%  2.
%
%  OUTPUTS
%  1. AM - horizontal beam position
%
%  See Also getphotonbpm

% TODO
% 1. Simulator part is not generic :  using getdipolesourcepoint, could be set in setoperational mode
% 2. Full integration of XBPM in MML as a new family
% 3. Position of XBPM with respect to the center of the straight section
%    should be in soleilinit
% 4. Does not work in simulation mode and controlroom - Not used today
%    A special function should be only online following the MML philosophy
%    The mode option is not supported

Mode = 'Online';

if ~iscontrolroom
    Mode = family2mode('PBPMz');
end

Units = family2units('PBPMz');
tout = 0;
DataTime =0;
ErrorFlag =0;

% Cooking ... model do not follow MML standards

if ~isempty(varargin)
    if ischar(varargin{1})
        if isfamily(varargin{1})
            varargin(1) = [];
        end
    end
end

if ~isempty(varargin)
    if ischar(varargin{1})
        if strcmpi(varargin{1}, 'Monitor') || strcmpi(varargin{1}, 'Setpoint')
            varargin(1) = [];
        end
        if strcmpi(varargin{1}, 'Online') || strcmpi(varargin{1}, 'Simulator') || strcmpi(varargin{1}, 'Model')
            varargin(1) = [];
            warning('Mode not supported: should be online only')
        end
    end
end

varargin2 = varargin;
% Switchyard factory
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Model')
        Mode = 'Model';
        varargin2(i) = [];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Online')
        Mode = 'Online';
        varargin(i) = [];
        varargin2(i) = [];
    elseif strcmpi(varargin{i},'Simulator')
        Mode = 'Simulator';
        varargin2(i) = [];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Physics')
        Unit = 'Physics';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Hardware')
        Unit = 'Hardware';
        varargin(i) = [];
    end
end


if length(varargin) >= 1
    DeviceList = varargin{1};
    if size(DeviceList,2) == 1
        DeviceList =  elem2dev('PBPMz', DeviceList);
    end;
else
    DeviceList = family2dev('PBPMz');
end

% remove XBPM from dipole based BLs
iXBPM=find(getfamilydata('PBPMz', 'Type',DeviceList)==0);
%[iXBPM iNotFound] = findrowindex([1 8; 5 8; 9 8; 13 10], DeviceList);
BPMDeviceList = DeviceList;
BPMDeviceList(iXBPM,:) = [];
%Get BPM index
[iBPM iNotFound] = findrowindex(BPMDeviceList, DeviceList);
XBPMDeviceList = DeviceList(iXBPM,:);

%vararingBPM = {'BPMz'
%vararingXBPM = {' '};

% Model for XBPM
if ~isempty(XBPMDeviceList),
    if strcmpi(Mode,'Model')
        global THERING
        ATi = atindex;
        %findspos(THERING, ATi.PXBPM);
        
        %%
        Orbit = findorbit6(THERING, ATi.PXBPM);
        
        % Position of XBPM with respect to the center of the straight section
        d=4.700; % m
        
        positionZ = Orbit(3,:);
        angleZ    = Orbit(4,:);
        
        if strcmpi(Units, 'Physics')
            zXBPM = (d*tan(angleZ)+positionZ)'; % m
        else
            zXBPM = (d*tan(angleZ)+positionZ)'*1e3; % mm
        end
        
    elseif strcmpi(Mode,'Simulator')
        % Not generic. To be improved later
        % using getdipolesourcepoint, could be set in setoperational mode
        Zup   = getz([1 6; 5 6; 9 6; 13 6],'Model');
        Zdown = getz([1 7; 5 7; 9 7; 13 7],'Model');
        positionZ = (+869.328613*Zup+486.101909*Zdown)*1e-6; %m
        angleZ    = (-331.968978*Zup+360.098626*Zdown)*1e-6; %m
        %[positionZ1 angleZ1 ] = getdipolesourcepoint('ODE', 'METRO', 'SAMBA', 'DIFFABS','Table')
        d=4.700; % mm
        
        if strcmpi(Units, 'Physics')
            zXBPM = (d*tan(angleZ)+positionZ); % m
        else
            zXBPM = (d*tan(angleZ)+positionZ)*1e3; % mm
        end
        
    elseif strcmpi(Mode,'Online')% online
        zXBPM = getphotonbpm(varargin2{:}); % Hardware units mandatory
    end
end

%% Sort out BPMs and XBPMs

if ~isempty(BPMDeviceList),
    if strcmpi(Mode,'Online')
        % normal call to BPM, if configured call special function for BPMz
        AM(iBPM) = getpv('BPMz', 'Monitor', BPMDeviceList, 'Hardware', 'Online');
    else
        AM(iBPM) = getz(BPMDeviceList, 'Hardware');
    end
end

% look in XBPM list
FullDeviceList = family2dev('PBPMz',0); % get full list status 1 or 0
% get XBPM status 1 or 0
FullDeviceListXBPM = FullDeviceList(getfamilydata('PBPMz', 'Type',FullDeviceList)==0,:); % get device list XBPM status 1 or 0
[kXBPM iNotFound] = findrowindex(XBPMDeviceList, FullDeviceListXBPM); % get index of BPM used

% add XBPM readings to BPMs
if  ~isempty(XBPMDeviceList),
    AM(iXBPM)= zXBPM(kXBPM);
end
AM = AM';
