function  [RelEOffset, FreqOffset,vectresult]=getCorrectorInducedEnergyShift(varargin)
% Calculating the energy induced by corrector
% 
%
%  INPUTS
%  1. Family (if empty default is HCOR) 
%  2. DeviceList or ElementList (if is empty get allFamily)
%  Optional Flags
%  3. Display - Plot result 
%
%
%  OUTPUTS
%  1. Relative Energy offset 
%  2. Frequency offset (Relative Energy offset*RFfrequency*-mcf/2)
%  3. vectresult (corrector contribution)
%
%  EXAMPLES
%  1.getCorrectorInducedEnergyShift('FVCOR',[1 1;1 2;2 1;2 2]) - FastSteerer and deviceList
%  2.getCorrectorInducedEnergyShift                            - HCOR all corrector with status '1'
%  3 getCorrectorInducedEnergyShift('HCOR', [1 3 5 8])         - elementList
%  4.getCorrectorInducedEnergyShift('VCOR')
%  5.getCorrectorInducedEnergyShift('VCOR','Disp')
%
% See Also modeldisp, getcircumference,getmcf, hw2physics('VCOR','Setpoint',1) , finbdrf

%
% Written by Aurelien Bence

%Initialisation Argout
RelEOffset=0;
FreqOffset=0;
vectresult=[];

% Defaults
Family='HCOR';
% default value if FLAG not set
DispFlag = 0;

varargin2     = {};
%%

AO = getfamilydata(Family);


for i = length(varargin):-1:1    
    if strcmpi(varargin{i},'Disp')
        DispFlag = 1;
        varargin2 = {varargin2{:} varargin{i}};
        varargin(i) = [];
    
    end    
end 

% if empty select all valid Actuator
if isempty(varargin)
    num = 1:length(AO.DeviceName);
    DeviceList = family2dev(Family);
elseif  length(varargin)==1  
    Family = varargin{1};
    %num = 1:length(AO.DeviceName);
    DeviceList = family2dev(Family);
    
else
    Family = varargin{1};
    DeviceList = varargin{2};
    if size(DeviceList,2) == 2 % DeviceList
    %%
    else %% conversion elementList 2 deviceList
        DeviceList = elem2dev(Family,DeviceList);
    end
end

% Status one devices
Status = family2status(Family,DeviceList);
DeviceList = DeviceList(find(Status),:);%% bug

if isempty(DeviceList)
    disp('All Cor not valid')
    AM = -1;
end    

%%
    mcf= getmcf;
    circumf= getcircumference;
    dispelem=modeldisp(Family,DeviceList);
    anglelem=getam(Family,DeviceList,'Physics');        
    vectresult = -(dispelem.*anglelem)/circumf/mcf;
    RelEOffset=sum(vectresult);
    FreqOffset=-RelEOffset*getrf*mcf/2;
    if DispFlag
        Xpos = getspos(Family, DeviceList);
        plot(Xpos,vectresult);
    end
end