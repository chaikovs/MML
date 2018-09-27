function [LT,is_valid,valid_samples]=duree_vie(bpm_group,N_samples)
fSA=9.8428;
attr_list={'SumSAHistory'};


result=tango_group_read_attributes2(bpm_group,attr_list);
N_bpm=size(result.dev_replies,2);
LT(N_bpm)=0;
for j=1:1:N_bpm
    stop_scan=0;
    buffer_length=size(result.dev_replies(j).attr_values.value,2);
    index=buffer_length;
    while stop_scan==0
%        if result.dev_replies(j).attr_values.value(index)>1.0003*result.dev_replies(j).attr_values.value(index-1)
        if result.dev_replies(j).attr_values.value(index)>1.003*result.dev_replies(j).attr_values.value(index-1)
            start=index+5;
            stop_scan=1;
%            fprintf('scan stopped at sample %d for bpm %d \n', index,j)
        else
            index=index-1;
        end
        if index==buffer_length-N_samples
            stop_scan=1;
            start=buffer_length-N_samples;
        end
    end
    new_sum=result.dev_replies(j).attr_values.value(start:buffer_length);
     valid_samples(j)=buffer_length-start;
    if(valid_samples(j)<70)
        is_valid(j)=0;
        LT(j)=NaN;
    else
        is_valid(j)=1;
        LT(j)=-((0-double(int16(valid_samples(j)/2)))/(3600*fSA))/(log(mean(new_sum(1:double(uint16(valid_samples(j)/2))))/(mean(new_sum(double(uint16(valid_samples(j)/2)+1):valid_samples(j))))));
    end


end
% figure(1)
% plot(LT)