function ndata = icapreprocess(data, st,wid,tao,preprocess)
%data = icapreprocess(data, preprocess)
%


switch preprocess 
case 'zero mean'
	filter_b = [];
	ndata = data(:,st:(st+wid+max(tao)-1));
	[ndata,avg]=selfsubtract(ndata,size(ndata,2));
	return
	
% case '+ avg 5'
% 	data = widfilter('high',data,5);
% case '+ avg 10'
% 	data = widfilter('high',data,10);	
% case '-  avg 5'
% 	data = widfilter('low',data,5);	
% case '-  avg 10'
% 	data = widfilter('low',data,10);	
% case '-  avg 20'
% 	data = widfilter('low',data,20);
case 'lo 10 c0.1'
	filter_b = FIRdesign('lowpass',10,0.1);
	nst = max(1,st-10);
case 'lo 40 c0.1'
	filter_b = FIRdesign('lowpass',40,0.1);	
		nst = max(1,st-40);
case 'hi 10 c0.1'
	filter_b = FIRdesign('highpass',10,0.1);
		nst = max(1,st-10);
case 'hi 40 c0.1'
	filter_b = FIRdesign('highpass',40,0.1);	
		nst = max(1,st-40);
otherwise
	%disp('raw data applied directly');
end
tdata = data(:,nst:(st+wid+max(tao)-1));
[tdata,avg]=selfsubtract(tdata,size(tdata,2));

tdata = FIRfilter(tdata,filter_b');
ndata = tdata(:,(st-nst+1):(st-nst+wid+max(tao)));

function [data,avg]=selfsubtract(data,span)
%subtract the average of data in every period of span
avg=[];
navg = 0;
st = 1;
ed = st + span -1;
while ed<=size(data,2)
    navg = navg + 1;
    for i=1:size(data,1)
        avg(navg,i) = mean(data(i,st:ed));
        data(i,st:ed) = data(i,st:ed) - avg(navg,i);
    end
    st = ed+1;
    ed = st + span -1;
end

if mod(size(data,2),span)~=0
    disp(sprintf('warning -- span does not suit data size: %d / %d',size(data,2),span));
end
