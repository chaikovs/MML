function [previous_LT_Lib,LT_lib_mean,LT_lib_by_quarter,N_lib_valid,N_lib_valid_first_sort,N_lib_valid_second_sort,LT_DCCT,index_seuil_1,index_seuil_2,Time_history,DCCT_history]=...
            get_LT(bpm_group,BPM_index,N_samples,previous_LT_Lib,LT_lib_mean,LT_lib_by_quarter,N_lib_valid,...
            N_lib_valid_first_sort,N_lib_valid_second_sort,LT_DCCT,seuil_1,seuil_2,NLib2valid,Time_history,DCCT_history)

historic_size=size(LT_lib_mean,2);
N_BPM=tango_group_size(bpm_group);

tic
h=now;
fprintf('*********  %s ***********\n',datestr(h))
attr_list={'current','lifeTime'};
result_DCCT=tango_read_attributes2('ANS/DG/DCCT-CTRL',attr_list);

[LT_lib,is_valid,valid_samples]=duree_vie(bpm_group,N_samples); 
valid_Nb=size(find(is_valid),2);
fprintf('%d Libera have long enough buffer, averaged size is %1.0f\n',valid_Nb,mean(valid_samples))
N_lib_valid=circshift(N_lib_valid',-1)';
N_lib_valid(historic_size)=valid_Nb;


%first sort
for j=1:N_BPM
    if is_valid(j)
        LT_Lib_valid(j)=LT_lib(j);
    else
        LT_Lib_valid(j)=previous_LT_Lib(j);
        %LT_Lib_valid(j)=0;
    end
end
previous_LT_Lib=LT_Lib_valid;
ma1=mean(LT_Lib_valid);
seuil_1_high=(1+seuil_1)*ma1;
seuil_1_low=(1-seuil_1)*ma1;
fover=find(LT_Lib_valid>seuil_1_high);
funder=find(LT_Lib_valid<seuil_1_low);    
f=[fover,funder];fs=sort(f);    
for j=1:length(fs)
    rido=fs(j);
    LT_Lib_valid(rido-j+1)=[];
end;
fprintf('%d Libera remaining after first sort\n',size(LT_Lib_valid,2))
N_lib_valid_first_sort=circshift(N_lib_valid_first_sort',-1)';    
N_lib_valid_first_sort(historic_size)=size(LT_Lib_valid,2);

%second sort
ma2=mean(LT_Lib_valid);
seuil_2_high=(1+seuil_2)*ma2;
seuil_2_low=(1-seuil_2)*ma2;
fover=find(LT_Lib_valid>seuil_2_high);
funder=find(LT_Lib_valid<seuil_2_low);
f=[fover,funder];fs=sort(f);
for j=1:length(fs)
    rido=fs(j);
    LT_Lib_valid(rido-j+1)=[];
end;
fprintf('%d Libera remaining after second sort\n',size(LT_Lib_valid,2))
fprintf('LT with Libera= %d \n',mean(LT_Lib_valid))
N_lib_valid_second_sort=circshift(N_lib_valid_second_sort',-1)';    
N_lib_valid_second_sort(historic_size)=size(LT_Lib_valid,2);
LT_lib_mean=circshift(LT_lib_mean',-1)';
for i=1:4
    LT_lib_by_quarter(i,:)=circshift(LT_lib_by_quarter(i,:)',-1)';
end

if size(LT_Lib_valid,2)<NLib2valid
    LT_lib_mean(historic_size)=LT_lib_mean(historic_size-1); 
    LT_lib_by_quarter(:,historic_size)=LT_lib_by_quarter(:,historic_size-1);
else
    LT_lib_mean(historic_size)=mean(LT_Lib_valid);
    quarter_size=floor(N_lib_valid_second_sort(historic_size)/4);
    for i=1:4
    LT_lib_by_quarter(i,historic_size)=mean(LT_Lib_valid(quarter_size*(i-1)+1:quarter_size*(i)));
    end
end

LT_DCCT=circshift(LT_DCCT',-1)';
LT_DCCT(historic_size)=result_DCCT(2).value;

DCCT_history=circshift(DCCT_history',-1)';
DCCT_history(historic_size)=result_DCCT(1).value;

Time_history=circshift(Time_history',-1)';
Time_history(historic_size)=h;


index_over=find(previous_LT_Lib>seuil_2_high);
index_under=find(previous_LT_Lib<seuil_2_low);
index_seuil_2=[index_over index_under];
index_over=find(previous_LT_Lib>seuil_1_high);
index_under=find(previous_LT_Lib<seuil_1_low);
index_seuil_1=[index_over index_under];



%figure(2)

% subplot(3,1,1)
% plot(LT_lib,'bo','LineWidth',2)
% xlabel('BPM Number')
% ylabel('Hours')
% title('Last LT measurment for each Libera')
% hold on
% ma1(1:N_BPM)=ma1;
% plot(BPM_index,ma1,'r')
% index_over=find(LT_lib>seuil_2_high);
% index_under=find(LT_lib<seuil_2_low);
% index_seuil2=[index_over index_under];
% plot(index_seuil2,LT_lib(index_seuil2),'gx','LineWidth',3,'MarkerSize',20)
% ma2(1:N_BPM)=ma2;
% plot(BPM_index,ma2,'g')
% index_over=find(LT_lib>seuil_1_high);
% index_under=find(LT_lib<seuil_1_low);
% index_seuil_1=[index_over index_under];
% plot(index_seuil_1,LT_lib(index_seuil_1),'rx','LineWidth',3,'MarkerSize',20)
% plot(BPM_index,LT_lib_mean(historic_size),'b');
% hold off
% [Y,I]=sort(LT_lib(index_seuil_1));
% for k=1:1:size(index_seuil_1,2)    
%     %fprintf('%s: %3.1f hours\n',dev_list{index(I(k))},Y(k));
% end
% subplot(3,1,2)
% plot(N_lib_valid,'b')
% hold on
% plot(N_lib_valid_first_sort,'r')
% plot(N_lib_valid_second_sort,'g')
% hold off
% legend('valid buffer length','first sort','second sort')
% title('History of valid Libera measurments number')
% subplot(3,1,3)
% plot(LT_lib_mean)
% hold on
% % plot(LT_Lib_by_quarter(:,1),'c--')
% % plot(LT_Lib_by_quarter(:,2),'m--')
% % plot(LT_Lib_by_quarter(:,3),'y--')
% % plot(LT_Lib_by_quarter(:,4),'k--')
% 
% % plot(LT_DCCT_instant,'r')
% plot(LT_DCCT,'c')
% hold off
% grid on
% %legend('Libera all','Libera quart 1','Libera quart 2','Libera quart 3','Libera quart 4','DCCT')
% legend('Libera all','DCCT')
% ylabel('Hours')
% title('Lifetime History')
% t=toc;
% fprintf('processing time = %2.1f s\n',t)


