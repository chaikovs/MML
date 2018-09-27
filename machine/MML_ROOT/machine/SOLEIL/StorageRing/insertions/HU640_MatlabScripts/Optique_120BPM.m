function Optique_120BPM(YesNo)
if (YesNo==1)
setfamilydata(0,'BPMx', 'Status', [13 8; 13 9]);
setfamilydata(0,'BPMz', 'Status', [13 8; 13 9]);
end
if (YesNo==0)
setfamilydata(1,'BPMx', 'Status', [13 8; 13 9]);
setfamilydata(1,'BPMz', 'Status', [13 8; 13 9]);
end
fprintf('%d BPMx avec BPMx [13 8] status %d BPMx [13 9] status %d\n', ...
size(getx,1), family2status('BPMx', [13 8; 13 9])); 
fprintf('%d BPMz avec BPMz [13 8] status %d BPMz [13 9] status %d\n', ...
size(getz,1), family2status('BPMz', [13 8; 13 9])); 
end