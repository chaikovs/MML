ATIndex = family2atindex('QP1', [1 1]);
[PhiQx,  PhiQy] = modeltwiss('Phase', 'All');
i = findrowindex(ATIndex, (1:length(PhiQx))');
PhiQx = (PhiQx(i) + PhiQx(i+1))/2;

[PhiX,   PhiY]  = modeltwiss('Phase', 'BPMx', [1 1]);
PhaseAdvance = PhiX - PhiQx



%%
QUADFamily = 'QP1';
QUADDev = [1 12];

[BPMFamilyOutput, BPMDevOutput, DeltaSpos, PhaseAdvance] = quad2bpm(QUADFamily, QUADDev)

%  for k=1:6,
%             n = n+1;            
%             % set up for QP1, QP2, QP3, QP4
%             ifam = ['QP' num2str(k)];
%             %set up for QP31, QP41
%             if (k==5)    ifam = 'QP31'; end;
%             if (k==6)    ifam = 'QP41'; end;
%                      
% end
phd = rad2deg(PhaseAdvance/(2*pi))
%%

% BPMFamily = 'BPMx';
% BPMDev = [1 1];

%[QUADFamilyOutput, QUADDevOutput, DeltaSpos, PhaseAdvance] = bpm2quad(BPMFamily, BPMDev)


for k=1:12
    
    [QUADFamilyOutput, QUADDevOutput, DeltaSpos, PhaseAdvance] = bpm2quad('BPMx', [1 k])
    
    str{k}.QUADFamilyOutput = QUADFamilyOutput;
     str{k}.QUADDevOutput = QUADDevOutput;
      str{k}.DeltaSpos = DeltaSpos;
       str{k}.PhaseAdvance = PhaseAdvance;
       phaseadv(k,1) = DeltaSpos;
        phaseadv(k,2) = PhaseAdvance;
        phaseadv(k,3) = rad2deg(PhaseAdvance);
        
end
