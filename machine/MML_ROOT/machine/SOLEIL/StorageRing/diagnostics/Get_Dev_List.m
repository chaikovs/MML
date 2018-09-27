function Dev_List=Get_Dev_List(n)    

 Dev_List=0;
 switch n


     case 'LT2'
         for i=1:1:3
             dev_name(i,:)=['LT2/DG/BPM.',num2str(i)];
         end

     case 'LT1'
         for i=1:1:1
             dev_name(i,:)=['LT1/DG/BPM'];
         end

     case 'Tune_BPM'
         dev_name(1,:)='ANS-C09/DG/BPM.NOD';
    
     case 'test'
         dev_name(1,:)='ANS-C07/DG/BPMtest.01';
        dev_name(2,:)='ANS-C07/DG/BPMtest.02';
        dev_name(3,:)='ANS-C07/DG/BPMtest.03';
        dev_name(4,:)='ANS-C07/DG/BPMtest.04';
        dev_name(5,:)='ANS-C07/DG/BPMtest.05';
        dev_name(6,:)='ANS-C07/DG/BPMtest.06';
        dev_name(7,:)='ANS-C07/DG/BPMtest.07';
        dev_name(8,:)='ANS-C07/DG/BPMtest.08';
        dev_name(9,:)='ANS-C07/DG/BPMtest.09';
        dev_name(10,:)='ANS-C07/DG/BPMtest.10';
        
     case 'Booster'
     dev_name(1,:)='BOO-C01/DG/BPM.01';
     dev_name(2,:)='BOO-C03/DG/BPM.02';
     dev_name(3,:)='BOO-C03/DG/BPM.03';
     dev_name(4,:)='BOO-C05/DG/BPM.04';
     dev_name(5,:)='BOO-C05/DG/BPM.05';
     dev_name(6,:)='BOO-C06/DG/BPM.06';
     dev_name(7,:)='BOO-C07/DG/BPM.07';
     dev_name(8,:)='BOO-C08/DG/BPM.08';
     dev_name(9,:)='BOO-C09/DG/BPM.09';
     dev_name(10,:)='BOO-C10/DG/BPM.10';
     dev_name(11,:)='BOO-C11/DG/BPM.11';
     dev_name(12,:)='BOO-C12/DG/BPM.12';
     dev_name(13,:)='BOO-C14/DG/BPM.13';
     dev_name(14,:)='BOO-C14/DG/BPM.14';
     dev_name(15,:)='BOO-C16/DG/BPM.15';
     dev_name(16,:)='BOO-C16/DG/BPM.16';
     dev_name(17,:)='BOO-C17/DG/BPM.17';
     dev_name(18,:)='BOO-C18/DG/BPM.18';
     dev_name(19,:)='BOO-C19/DG/BPM.19';
     dev_name(20,:)='BOO-C20/DG/BPM.20';
     dev_name(21,:)='BOO-C21/DG/BPM.21';
     dev_name(22,:)='BOO-C22/DG/BPM.22';
     
     case 'ANS'
          list=dev2tangodev('BPMx',family2dev('BPMx'));
         for i=1:size(list,1)
             dev_name(i,:)=list{i};
         end

     otherwise
         list=dev2tangodev('BPMx',family2devcell('BPMx',str2num(n)));
         for i=1:size(list,1)
             dev_name(i,:)=list{i};
         end
         
%          text1='ANS-C';
%          text3='/DG/BPM.';
%           if str2num(n)<10
%             text2=['0',n];
%          else text2=n;
%          end 
%          switch n
%              
%             case {'1', '4', '5', '8', '9', '12', '13', '16'}
%                 for j=1:1:7
%                 text4=num2str(j); 
%                 dev_name(j,:)=[text1,text2,text3,text4]  ;   
%                 end
%             case {'2', '3', '6', '7', '10', '11', '14', '15'}
%                 for j=1:1:8
%                 text4=num2str(j); 
%                 dev_name(j,:)=[text1,text2,text3,text4]  ;   
%                 end
%               otherwise
%                 
%           end
 end
         
  Dev_List=dev_name;
 
    
