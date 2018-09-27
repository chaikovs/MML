
X=getx('struct');
XG=getgolden('BPMx');

Z=getz('struct');
ZG=getgolden('BPMz');

DiffX=abs(X.Data-XG);
DiffZ=abs(Z.Data-ZG);
disp('---------------------');
for i=1:size(XG)
    if DiffX(i)>0.05
        disp(strcat('BPMx_',num2str(X.DeviceList(i,1)),'_',num2str(X.DeviceList(i,2)),'_:_', num2str(DiffX(i)*1000),'µm'));
    end
end    
disp('---------------------');
for i=1:size(ZG)
    if DiffZ(i)>0.05
        disp(strcat('BPMZ_',num2str(Z.DeviceList(i,1)),'_',num2str(Z.DeviceList(i,2)),'_:_', num2str(DiffZ(i)*1000),'µm'));
    end
end    