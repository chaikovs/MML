function [Comm_delay,Link_partners]=fofb_read_LP_Delay(groupe)



CC_status=768*4;
LP1=CC_status+2*4

read_array=int32([CC_status,4,256]);

result=(tango_group_command_inout2(groupe,'ReadFAData',1,read_array));
for i=1:1:120
    BPM_index(i)=i;
    Delay(i)=result.replies(mod(i,120)+1).data(29);
    involved(i)=result.replies(mod(i,120)+1).data(30);
    for j=1:1:3        
        LP_array(i,j)=result.replies(mod(i,120)+1).data(j+2);
    end
end

Full_array=[BPM_index' Delay' involved' LP_array];
sorted_array=sortrows(Full_array,2);

disp('BPMindex  seen    Com_dly        LP1        LP2        LP3')
disp(sorted_array)
