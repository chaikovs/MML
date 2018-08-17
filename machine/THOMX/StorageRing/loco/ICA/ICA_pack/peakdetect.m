function    [peak_v,peak_pos,peak_width] = peakdetect(data, st,ed,K)
%     
%[peak_v, peak_pos,peak_width]=peakdetect(data,st,ed,K)
%1D positive data, detect peaks in data(st:ed)
%A flat, uniform background (with noise) is assumed
% > bk + K*sigma,   K=8
%K=8;

makeplot = 0;
if makeplot
    subplot(1,1,1);
    plot(st:ed,data(st:ed),'b',st:ed,data(st:ed),'b.');
    hold on
end
n = (ed-st+1)/5;
if n < 40
    n = min([40, ed-st+1]);
end

a = data(st + floor( rand(1,n)*(ed-st+1) ));
b = sort(a);
n = floor(n*0.8);
bk = mean(b(1:n));
sig = std(b(1:n));

n=0;
peak_v=[];
peak_pos=[];
peak_width=[];
i=st;
while i<ed
    if data(i) <= bk + K*sig
        i = i+1;
        continue;
    end
    if makeplot
        plot(i,abs(data(i)),'r.');
    end
    a=[];
    ct = 0;
    ma = data(i);
    while (i<=ed) & (data(i) > bk+K*sig )  & (data(i) > bk+(ma-bk) * 0.5)
        a = [a,data(i)];
        ma = max(ma,data(i));
        ct = ct+1;
        if makeplot
           plot(i,abs(data(i)),'mo'); 
        end
        i=i+1;
    end
    n=n+1;
    [ma,j] = max(a);
    if (length(a)<=3) | (j==1) | (j==length(a))
        peak_v(n) = ma;
        peak_pos(n)  = (i-ct) +j - 1;
        peak_width(n) = 1;
    else
        jj=1;
        while (j + jj <= length(a) ) & (j-jj >=1) 
            if (a(j+jj)> bk+(ma-bk) * 0.5) & (a(j-jj) > bk+(ma-bk) * 0.5)
                jj = jj+1;
            else
                break
            end %if
        end %while
        if (j + jj <= length(a) ) & (j-jj >=1) 
            b = a((j-jj):(j+jj));
        else
            jj = jj-1;
            b = a((j-jj):(j+jj));
        end
        peak_v(n) = ma;
        peak_pos(n)  = i-ct +j -1 +mean([(-jj):jj].*b)/sum(b); 
        peak_width(n) = jj;
        
    end %if 
    if makeplot
        plot(peak_pos(n),abs(peak_v(n)),'*');    
    end
    %move on to leave this peak
    while (i<=ed) & (data(i) > bk+K*sig )  & (data(i) < bk+(ma-bk) * 0.5)
        i = i+1;
    end
        
end %if while
