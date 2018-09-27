function [Xm,Zm] = getboobpm(nbpmx,iend,istart)
% GETBOOBPM - Get average orbit

% iHs = [1 8 9];  % BPM HS
% iHs = [1 8 9 5]; % BPM8 and 8  HS 16 December 2010
iHs = [ 12 13 14];
%iHs= [0];
for i=1:nbpmx
    i
    xm = 0;
    zm = 0;
    if any(iHs == i)       % cas de BPM HS
        Xm(i) = 0;Zm(i) = 0;  
    else
        
        a = getbpmrawdata(i,'nodisplay','struct','NoGroup');
        Xm(i) = mean(a.Data.X(istart:iend)); % mm
        Zm(i) = mean(a.Data.Z(istart:iend)); % mm
    end
end
