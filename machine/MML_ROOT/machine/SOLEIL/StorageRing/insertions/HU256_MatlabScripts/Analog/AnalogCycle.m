function Result=AnalogCycle(PointNumber, PowerSuppliesNumber, AllValuesAtOnce)
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
Debug=1;
UseProfibus=0;
CurrentInPowerSupplies=1;
% ----End Of Configuration---- %

% Table LH
% BZP,CVE,CHE,CVS,CHS																																								
BZPCurrents= [+000.000	-020.000	-040.000	-060.000	-080.000	-100.000	-120.000	-140.000	-160.000	-180.000	-200.000	-180.000	-160.000	-140.000	-120.000	-100.000	-080.000	-060.000	-040.000	-020.000	+000.000	+020.000	+040.000	+060.000	+080.000	+100.000	+120.000	+140.000	+160.000	+180.000	+200.000	+180.000	+160.000	+140.000	+120.000	+100.000	+080.000	+060.000	+040.000	+020.000	+000.000];
CVECurrents= [+000.000	+000.010	+000.030	+000.040	+000.050	+000.060	+000.070	+000.080	+000.100	+000.120	+000.140	+000.110	+000.090	+000.070	+000.050	+000.030	+000.030	+000.010	+000.000	-000.020	-000.040	-000.050	-000.070	-000.070	-000.080	-000.090	-000.090	-000.090	-000.090	-000.090	-000.090	-000.090	-000.080	-000.080	-000.080	-000.080	-000.080	-000.070	-000.060	-000.050	+000.000];
CHECurrents= [+000.000	-000.030	-000.050	-000.070	-000.100	-000.130	-000.160	-000.200	-000.230	-000.270	-000.330	-000.270	-000.230	-000.190	-000.150	-000.100	-000.070	-000.030	+000.000	+000.020	+000.040	+000.070	+000.080	+000.110	+000.140	+000.170	+000.200	+000.240	+000.280	+000.320	+000.370	+000.320	+000.280	+000.240	+000.190	+000.140	+000.100	+000.070	+000.040	+000.010	+000.000];
CVSCurrents= [+000.000	+000.020	+000.030	+000.050	+000.070	+000.090	+000.110	+000.140	+000.170	+000.200	+000.230	+000.200	+000.160	+000.130	+000.110	+000.090	+000.070	+000.050	+000.030	+000.010	+000.000	-000.020	-000.030	-000.040	-000.040	-000.050	-000.050	-000.050	-000.050	-000.050	-000.050	-000.050	-000.050	-000.040	-000.040	-000.040	-000.040	-000.030	-000.020	-000.010	+000.000];
CHSCurrents= [+000.000	-000.020	-000.040	-000.060	-000.080	-000.100	-000.130	-000.150	-000.180	-000.220	-000.260	-000.200	-000.170	-000.150	-000.110	-000.080	-000.050	-000.020	+000.010	+000.030	+000.050	+000.060	+000.080	+000.100	+000.120	+000.150	+000.170	+000.200	+000.230	+000.260	+000.300	+000.250	+000.220	+000.190	+000.160	+000.120	+000.090	+000.060	+000.040	+000.010	+000.000];


% Channels
BZP_AO_Channel=2;
CVE_AO_Channel=4;
CHE_AO_Channel=5;
CVS_AO_Channel=6;
CHS_AO_Channel=7;

BZP_AI_Channel=0;
CVE_AI_Channel=1;
CHE_AI_Channel=2;
CVS_AI_Channel=3;
CHS_AI_Channel=0;

% BZP_AI_Card=

% Ratios
BZP_Ratio=20;   % 1V => 20A  20
CVE_Ratio=1;
CHE_Ratio=1;
CVS_Ratio=1;
CHS_Ratio=1;

% TimeToWait
TimeToWait=ANALOG_TimeToWait; % [s]

Ratios=[BZP_Ratio CVE_Ratio CHE_Ratio CVS_Ratio CHS_Ratio];
Currents=[BZPCurrents; CVECurrents; CHECurrents; CVSCurrents; CHSCurrents];
AO_Channels= [BZP_AO_Channel CVE_AO_Channel CHE_AO_Channel CVS_AO_Channel CHS_AO_Channel];
AI_Channels= [BZP_AI_Channel CVE_AI_Channel CHE_AI_Channel CVS_AI_Channel CHS_AI_Channel];

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
        AnalogSetCurrents(AO_Channels(i), FLValues, Debug);
    end
   
%     BufferStruct=tango_get_property(ANALOG_SAO_DevServ, 'BufferDepth');
%     Buffer=str2num(BufferStruct.value{1});
%     if (Buffer~=size(FLValues, 2)) %NumberOfCurrentPoints)
%         fprintf('AnalogCycle : You should change the SAO buffer size. Please type ''AnalogInitSAO(%1.0f)''\n', size(FLValues, 2)) %NumberOfCurrentPoints)
%         return
%     end
%         AnalogSetCurrents(AO_Channels(i), (Currents(:, i))'./Ratios(i));

end
if (CurrentInPowerSupplies)
    if(UseProfibus==0)
        tango_command_inout2(ANALOG_CPT_DevServ, 'Stop');
        pause(0.5);
        tango_command_inout2(ANALOG_CPT_DevServ, 'Start');
    end
    pause (TimeToWait);
end

if (Debug)
    fprintf('*******End of AnalogCycle*******\n')
end
Result=1;