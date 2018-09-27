function idAuxCommonVector(Vector1, Vector2)
% NOT FINISHED!!!!
N1=length(Vector1);
N2=length(Vector2);
    
for i=1:N1-1
    if (Vector1(i)>Vector1(i+1))
        fprintf ('Error in ''idAuxCommonVector'' : Vector1 must be increasing monotonic\n');
        return
    end
end
for i=1:N2-1
    if (Vector2(i)>Vector2(i+1))
        fprintf ('Error in ''idAuxCommonVector'' : Vector2 must be increasing monotonic\n');
        return
    end
end
if (Vector1(1)<Vector2(1)
    