function OutputVector=idAuxLargestIntersectionOfVectors(Vector1, Vector2)
%% Written by F.Briquez     25/04/2011
% Returns the outter limits of the vector included in both Vector1 and
% Vector2
% 1) Inputs :   Vector1 : (1xN1) array. Must be increasing monotonic!
%               Vector2 : (1xN2) array. Must be increasing monotonic!
% 2) Output :   Vector (1x2) = [lower limit, upper limit]
% 3) Returns empty array [] if failed

%%
OutputVector=[];

N1=length(Vector1);
N2=length(Vector2);
    
for i=1:N1-1
    if (Vector1(i)>Vector1(i+1))
        fprintf ('Error in ''idAuxLargestIntersectionOfVectors'' : Vector1 must be increasing monotonic\n');
        return
    end
end
for i=1:N2-1
    if (Vector2(i)>Vector2(i+1))
        fprintf ('Error in ''idAuxLargestIntersectionOfVectors'' : Vector2 must be increasing monotonic\n');
        return
    end
end
ResultStart=max(Vector1(1), Vector2(1));
ResultEnd=min(Vector1(length(Vector1)), Vector2(length(Vector2)));
OutputVector=[ResultStart, ResultEnd];