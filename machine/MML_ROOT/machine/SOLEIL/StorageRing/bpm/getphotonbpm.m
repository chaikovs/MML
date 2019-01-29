function [AM] = getphotonbpm(varargin)
%GETPHOTONBPM - Returns the vertical position measured on bending magnet beamline first XBPM
%  
%  INPUTS
%  1. devicelist of XBPM
%
%  OUTPUTS
%  1. AM = position vector array
%  
%
%  NOTE
%  1. Each DIPOLE XBPM provides 2 vertical measurements Z1 and Z2
%  2. Device list not taken into account ON PURPOSE !!!
%
%  EXAMPLE
%  
%  See Also getphotonbpmaerage

%
% XBPMGolden = [ % 430 mA 3/4 15/04/13
% 1   8   -0.008766    0.3578  % XBPM ODE
% 5   8   -0.038019    0.0042 % XBPM METRO 
% 9   8   -0.031512   -0.0153 % XBPM SAMBA
% 13   10   0.001385  -0.0594 %BPM DIFFABS
% ];
%


%
%%  Written by Nicolas HUBERT

if length(varargin) >= 1,
    DeviceList = varargin{1};
else
    temp = family2dev('PBPMz');
    DeviceList = temp(getfamilydata('PBPMz', 'Type', temp)==0,:);
end

% To force reading on all BPM
%XBPM_Dip_list = family2tangodev('PBPMz', DeviceList)';

XBPM_Dip_list={ ...
    'TDL-D01-1/DG/XBPM_LIB.1',...
    'TDL-D05-1/DG/XBPM_LIB.1',...
    'TDL-D09-1/DG/XBPM_LIB.1',...
    'TDL-D13-1/DG/XBPM_LIB.1'};

%Creation du groupe
group=tango_group_create2('XBPM_Dip');
for i=1:size(XBPM_Dip_list,2)
    tango_group_add(group,XBPM_Dip_list{i});
end
attr_list={'XPosSA','ZPosSA'};

paire=2;

[result ErrorFlag] = tango_group_read_attributes2(group, attr_list,1);

tango_group_kill(group);

%% Error handling
XBPM_zPos(1:size(XBPM_Dip_list,2)) = NaN;
if ErrorFlag == 0,
    for i=1:size(XBPM_Dip_list,2)
        if paire == 1
            XBPM_zPos(i)=result.dev_replies(i).attr_values(1).value;
        else
            XBPM_zPos(i)=result.dev_replies(i).attr_values(2).value;
        end
    end
end

AM=XBPM_zPos';