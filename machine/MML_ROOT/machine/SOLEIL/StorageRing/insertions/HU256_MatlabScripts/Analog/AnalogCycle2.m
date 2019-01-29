function Result=AnalogCycle2(PointNumber, PowerSuppliesNumber, AllValuesAtOnce, Polarisation)
% PointNumber i a number (point n° of currents matrix), a 1xN vector (several points n° of currents matrix) or NaN (all
% currents values)
% PowerSuppliesNumber i a number, a 1xN vector or NaN (the same as PointNumber)
% AllValuesAtOnce : Vector with N values given to the SAO if 1, N Vectors with 1 value each if 0

Result=-1;
global ANALOG_SAO_DevServ;
global ANALOG_SAI_DevServ;
global ANALOG_CPT_DevServ;
global ANALOG_TimeToWait;
if (isempty(ANALOG_SAO_DevServ)==1||isempty(ANALOG_SAI_DevServ)==1||isempty(ANALOG_CPT_DevServ)==1||isempty(ANALOG_TimeToWait)==1)
    fprintf('AnalogCycle : You should intialise the SAO Card with AnalogInitSAO function\n')
    return
end

% ----Configuration---- %
DifferentValues=0;   % [i, i] if 0, [i, i+1] if 1
Debug=0;
UseProfibus=1;
CurrentInPowerSupplies=1;
TimeToWait=ANALOG_TimeToWait; % [s]
LimitVoltageValues=[-9.99 9.99];
currentAbsTol=0.1; % [A] for Profibus mode
% ----End Of Configuration---- %

if (strcmp(Polarisation, 'LH'))
% Table LH
% BZP,CVE,CHE,CVS,CHS																																								
%     BZPCurrents= [+000.000	-020.000	-040.000	-060.000	-080.000	-100.000	-120.000	-140.000	-160.000	-180.000	-200.000	-180.000	-160.000	-140.000	-120.000	-100.000	-080.000	-060.000	-040.000	-020.000	+000.000	+020.000	+040.000	+060.000	+080.000	+100.000	+120.000	+140.000	+160.000	+180.000	+200.000	+180.000	+160.000	+140.000	+120.000	+100.000	+080.000	+060.000	+040.000	+020.000	+000.000];
%     CVECurrents= [+000.000	+000.010	+000.030	+000.040	+000.050	+000.060	+000.070	+000.080	+000.100	+000.120	+000.140	+000.110	+000.090	+000.070	+000.050	+000.030	+000.030	+000.010	+000.000	-000.020	-000.040	-000.050	-000.070	-000.070	-000.080	-000.090	-000.090	-000.090	-000.090	-000.090	-000.090	-000.090	-000.080	-000.080	-000.080	-000.080	-000.080	-000.070	-000.060	-000.050	+000.000];
%     CHECurrents= [+000.000	-000.030	-000.050	-000.070	-000.100	-000.130	-000.160	-000.200	-000.230	-000.270	-000.330	-000.270	-000.230	-000.190	-000.150	-000.100	-000.070	-000.030	+000.000	+000.020	+000.040	+000.070	+000.080	+000.110	+000.140	+000.170	+000.200	+000.240	+000.280	+000.320	+000.370	+000.320	+000.280	+000.240	+000.190	+000.140	+000.100	+000.070	+000.040	+000.010	+000.000];
%     CVSCurrents= [+000.000	+000.020	+000.030	+000.050	+000.070	+000.090	+000.110	+000.140	+000.170	+000.200	+000.230	+000.200	+000.160	+000.130	+000.110	+000.090	+000.070	+000.050	+000.030	+000.010	+000.000	-000.020	-000.030	-000.040	-000.040	-000.050	-000.050	-000.050	-000.050	-000.050	-000.050	-000.050	-000.050	-000.040	-000.040	-000.040	-000.040	-000.030	-000.020	-000.010	+000.000];
%     CHSCurrents= [+000.000	-000.020	-000.040	-000.060	-000.080	-000.100	-000.130	-000.150	-000.180	-000.220	-000.260	-000.200	-000.170	-000.150	-000.110	-000.080	-000.050	-000.020	+000.010	+000.030	+000.050	+000.060	+000.080	+000.100	+000.120	+000.150	+000.170	+000.200	+000.230	+000.260	+000.300	+000.250	+000.220	+000.190	+000.160	+000.120	+000.090	+000.060	+000.040	+000.010	+000.000];

    [BZPCurrents, CVECurrents, CHECurrents, CVSCurrents, CHSCurrents]=TempInterpLH();

elseif (strcmp(Polarisation, 'LV'))
% Table LV ()
    BX1Currents= [+000.000	+025.000	+050.000	+075.000	+100.000	+125.000	+150.000	+175.000	+200.000	+225.000	+250.000	+275.000	+250.000	+225.000	+200.000	+175.000	+150.000	+125.000	+100.000	+075.000	+050.000	+025.000	+000.000];
    BX2Currents= [+000.000	+025.000	+050.000	+075.000	+100.000	+125.000	+150.000	+175.000	+200.000	+225.000	+250.000	+275.000	+250.000	+225.000	+200.000	+175.000	+150.000	+125.000	+100.000	+075.000	+050.000	+025.000	+000.000];
    CVECurrents= [-000.000	+000.043	+000.089	+000.097	+000.107	+000.128	+000.164	+000.205	+000.244	+000.262	+000.252	+000.064	+000.232	+000.219	+000.227	+000.225	+000.204	+000.167	+000.122	+000.075	+000.026	-000.015	-000.000];
    CHECurrents= [-000.000	-000.012	-000.030	-000.044	-000.049	-000.048	-000.053	-000.062	-000.074	-000.087	-000.099	-000.107	-000.102	-000.085	-000.059	-000.035	-000.017	-000.005	+000.002	+000.007	+000.010	+000.014	-000.000];
    CVSCurrents= [-000.000	-000.042	+000.036	+000.152	+000.267	+000.380	+000.492	+000.598	+000.710	+000.821	+000.945	+001.171	+000.985	+000.895	+000.760	+000.626	+000.507	+000.401	+000.305	+000.214	+000.125	+000.043	-000.000];
    CHSCurrents= [-000.000	-000.010	-000.021	-000.031	-000.032	-000.031	-000.033	-000.038	-000.044	-000.050	-000.054	-000.056	-000.060	-000.057	-000.044	-000.030	-000.022	-000.018	-000.017	-000.018	-000.019	-000.019	-000.000];
else
    fprintf('AnalogCycle2 : Polarisation must be ''LH'' or ''LV''\n')
    return
end

% Channels
BZP_AO_Channel=2;
BX1_AO_Channel=0;
BX2_AO_Channel=1;
CVE_AO_Channel=4;
CHE_AO_Channel=5;
CVS_AO_Channel=6;
CHS_AO_Channel=7;

BZP_AI_Channel=0;   % Not correct
CVE_AI_Channel=1;   % Not correct
CHE_AI_Channel=2;   % Not correct
CVS_AI_Channel=3;   % Not correct
CHS_AI_Channel=0;   % Not correct

% Ratios
BZP_Ratio=20;   % 1V => 20A  20
BX1_Ratio=27.5 ;11.34; %66.5; %27.5;
BX2_Ratio=27.5 ; %%27.5;
CVE_Ratio=1;
CHE_Ratio=1;
CVS_Ratio=1;
CHS_Ratio=1;

% DeviceServers for Profibus mode
BZP_DeviceServer='ans-c15/ei/m-hu256.2_bzp/current';
BX1_DeviceServer='ans-c15/ei/m-hu256.2_BX1/Current';
BX2_DeviceServer='ans-c15/ei/m-hu256.2_BX2/Current';
CVE_DeviceServer='ans-c15/ei/m-hu256.2_shim.2/current1';
CHE_DeviceServer='ans-c15/ei/m-hu256.2_shim.1/current1';
CVS_DeviceServer='ans-c15/ei/m-hu256.2_shim.2/current4';
CHS_DeviceServer='ans-c15/ei/m-hu256.2_shim.1/current4';

if (strcmp(Polarisation, 'LH'))
    Ratios=[BZP_Ratio CVE_Ratio CHE_Ratio CVS_Ratio CHS_Ratio];
    Currents=[BZPCurrents; CVECurrents; CHECurrents; CVSCurrents; CHSCurrents];
    AO_Channels= [BZP_AO_Channel CVE_AO_Channel CHE_AO_Channel CVS_AO_Channel CHS_AO_Channel];
    AI_Channels= [BZP_AI_Channel CVE_AI_Channel CHE_AI_Channel CVS_AI_Channel CHS_AI_Channel];
    DeviceServers=cell(5,1);
    DeviceServers{1}=BZP_DeviceServer;
    DeviceServers{2}=CVE_DeviceServer;
    DeviceServers{3}=CHE_DeviceServer;
    DeviceServers{4}=CVS_DeviceServer;
    DeviceServers{5}=CHS_DeviceServer;
else
    Ratios=[BX1_Ratio BX2_Ratio CVE_Ratio CHE_Ratio CVS_Ratio CHS_Ratio];
    Currents=[BX1Currents; BX2Currents; CVECurrents; CHECurrents; CVSCurrents; CHSCurrents];
    AO_Channels= [BX1_AO_Channel BX2_AO_Channel CVE_AO_Channel CHE_AO_Channel CVS_AO_Channel CHS_AO_Channel];
%     AI_Channels= [BX1_AI_Channel BX2_AI_Channel CVE_AI_Channel CHE_AI_Channel CVS_AI_Channel CHS_AI_Channel];    
    DeviceServers=cell(6,1);
    DeviceServers{1}=BX1_DeviceServer;
    DeviceServers{2}=BX2_DeviceServer;
    DeviceServers{3}=CVE_DeviceServer;
    DeviceServers{4}=CHE_DeviceServer;
    DeviceServers{5}=CVS_DeviceServer;
    DeviceServers{6}=CHS_DeviceServer;
end
if (Debug)
    fprintf('*******Begin of AnalogCycle*******\n')
end

NumberOfPowerSupplies=size(Currents, 1);
NumberOfCurrentPoints=size(Currents, 2);
if (Debug)
    fprintf('AnalogCycle : NumberOfPowerSupplies=%1.0f ; NumberOfCurrentPoints=%1.0f\n', NumberOfPowerSupplies, NumberOfCurrentPoints)
end

if (isnan(PointNumber)==1)
%     AllValuesAtOnce=1;   % [i, i+1, i+2, etc...] if 1
    PointsVector=1:NumberOfCurrentPoints; %:NumberOfCurrentPoints;
else
    if (size(PointNumber, 1)~=1)
        fprintf('AnalogCycle : PointNumber must be a 1x1 or a 1xN vector, or NaN\n')
        return
    end
    if (size(PointNumber, 2)==1&&PointNumber==0)
       fprintf('AnalogCycle : PointNumber as a scalar must be equal or greater than one\n')
        return
    end
    PointsVector=PointNumber;
end

if (AllValuesAtOnce==0)
   Iterations=PointsVector;
else
    Iterations=1;
end

if (isnan(PowerSuppliesNumber)==1)
    PowerSuppliesVector=1:NumberOfPowerSupplies;
else % PowerSuppliesNumber is not NaN
    if (size(PowerSuppliesNumber, 1)~=1)
        fprintf('AnalogCycle : PowerSuppliesNumber must be a 1x1 or a 1xN vector, or NaN\n')
        return
    end
    if (size(PowerSuppliesNumber, 2)==1&&PowerSuppliesNumber==0)
        fprintf('AnalogCycle : PowerSuppliesNumber as a scalar must be at least equal to one\n')
        return
    end
    PowerSuppliesVector=PowerSuppliesNumber;
    if (Debug)
        fprintf('AnalogCycle Debug : PointsVector\n')
        disp(PointsVector)
        fprintf('AnalogCycle Debug : PowerSuppliesVector\n')
        disp(PowerSuppliesVector)
        fprintf('AnalogCycle Debug : AllValuesAtOnce=%1.0f\n', AllValuesAtOnce)
    end
end

for i=PowerSuppliesVector  % PowerSupply
    for j=Iterations
        if (AllValuesAtOnce==0)
            if (DifferentValues==0)
                FLValues=[Currents(i, j)./Ratios(i) Currents(i, j)./Ratios(i)];
            else %DifferentValues==1
                FLValues=[Currents(i, j)./Ratios(i) Currents(i, j+1)./Ratios(i)];
%                 AnalogSetCurrents(AO_Channels(i), [Currents(j, i)./Ratios(i) Currents(j+1, i)./Ratios(i)]);
            end
        else %AllValuesAtOnce==1
            %FLValues=[Currents(i, j)./Ratios(i) Currents(i, j)./Ratios(i)];
            FLValues=[Currents(i, PointsVector)./Ratios(i)]; % Currents(i, :)./Ratios(i)];
        end
        if (Debug==1)
            fprintf('AnalogCycle Debug : i=%1.0f ; j=%1.0f\n', i, j)
            fprintf('AnalogCycle Debug : AO_Channels(i)=')
            disp(AO_Channels(i))
%             fprintf('\n')
            fprintf('AnalogCycle Debug : FLValues=')
            disp (FLValues)
%             fprintf('\n')
        end
        BufferStruct=tango_get_property(ANALOG_SAO_DevServ, 'BufferDepth');
        Buffer=str2num(BufferStruct.value{1});
        if (Buffer~=size(FLValues, 2)) %NumberOfCurrentPoints)
            fprintf('AnalogCycle : You should change the SAO buffer size. Please type ''AnalogInitSAO(%1.0f)''\n', size(FLValues, 2)) %NumberOfCurrentPoints)
            return
        end
        for k=1:size(FLValues, 2)
            if (FLValues(k)<LimitVoltageValues(1))
                FLValues(k)=LimitVoltageValues(1);
            end
            if (FLValues(k)>LimitVoltageValues(2))
                FLValues(k)=LimitVoltageValues(2);
            end
        end
        if (CurrentInPowerSupplies)
            if (UseProfibus)
%                 idSetCurrentSync(DeviceServers{i}, FLValues(size(FLValues,2)), currentAbsTol);
%                 writeattribute(DeviceServers{i}, FLValues(size(FLValues,2)));
                writeattribute(DeviceServers{i}, Currents(i, j));
                
            else
                pause(0.5);
                AnalogSetCurrents(AO_Channels(i), FLValues, Debug);
            end
        else
            if (UseProfibus)
%                 idSetCurrentSync(DeviceServers{i}, 0, currentAbsTol);
                writeattribute(DeviceServers{i}, 0);
            else
                AnalogSetCurrents(AO_Channels(i), zeros(Buffer), Debug);
            end
        end
        
    end
    
end
%tango_command_inout2(ANALOG_CPT_DevServ, 'State')
pause(0.5);
tango_command_inout2(ANALOG_SAO_DevServ, 'Start');
pause(0.5);
tango_command_inout2(ANALOG_CPT_DevServ, 'Stop');
pause(0.5);
tango_command_inout2(ANALOG_CPT_DevServ, 'Start');
pause (TimeToWait);    
   
%     BufferStruct=tango_get_property(ANALOG_SAO_DevServ, 'BufferDepth');
%     Buffer=str2num(BufferStruct.value{1});
%     if (Buffer~=size(FLValues, 2)) %NumberOfCurrentPoints)
%         fprintf('AnalogCycle : You should change the SAO buffer size. Please type ''AnalogInitSAO(%1.0f)''\n', size(FLValues, 2)) %NumberOfCurrentPoints)
%         return
%     end
%         AnalogSetCurrents(AO_Channels(i), (Currents(:, i))'./Ratios(i));


% if (CurrentInPowerSupplies)
%     if (UseProfibus==0)
%         tango_command_inout2(ANALOG_CPT_DevServ, 'Stop');
%         pause (1);
%         tango_command_inout2(ANALOG_CPT_DevServ, 'Start');
%     end
%     pause (TimeToWait);
% end

if (Debug)
    fprintf('*******End of AnalogCycle*******\n')
end
Result=1;