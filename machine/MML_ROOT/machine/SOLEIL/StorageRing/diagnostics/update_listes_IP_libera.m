path='/home/operateur/GrpDiagnostics/BPM/Upgrade/Liste_IP_Libera/'
fid_sr=fopen([path,'liste-IP-libera-SR.txt'],'wt');
for j=1:1:16
    if j<10
        n=['0',num2str(j)];
    else n=num2str(j);
    end     
    liste=Get_Dev_List(num2str(j))
    fid=fopen([path,'liste-IP-libera-cellule',n,'.txt'],'wt');
    for i=1:1:size(liste)
        IP=tango_get_property2(liste(i,:),'LiberaIpAddr');
        IP.value{1}
        fprintf(fid,[num2str(IP.value{1}),'\n']);
        fprintf(fid_sr,[num2str(IP.value{1}),'\n']);    
    end
    fclose(fid)
end
fclose(fid_sr)

 liste=Get_Dev_List('LT2')
    fid=fopen([path,'liste-IP-libera-LT2.txt'],'wt');
    for i=1:1:size(liste)
        IP=tango_get_property2(liste(i,:),'LiberaIpAddr');
        IP.value{1}
        fprintf(fid,[num2str(IP.value{1}),'\n']);
    end
    fclose(fid)
    
 liste=Get_Dev_List('Booster')
    fid=fopen([path,'liste-IP-libera-Booster.txt'],'wt');
    for i=1:1:size(liste)
        IP=tango_get_property2(liste(i,:),'LiberaIpAddr');
        IP.value{1}
        fprintf(fid,[num2str(IP.value{1}),'\n']);
    end
    fclose(fid)
    
    
fid_dev_fofb=fopen([path,'liste-dev-libera-fofb.txt'],'r')
fid_dev_com=fopen([path,'liste-dev-libera-com.txt'],'r')
fid_IP_fofb=fopen([path,'liste-IP-libera-fofb.txt'],'wt')
fid_IP_com=fopen([path,'liste-IP-libera-com.txt'],'wt')

dev=fgetl(fid_dev_com)
while (dev~=-1)
    IP=tango_get_property2(dev,'LiberaIpAddr');
    fprintf(fid_IP_com,[num2str(IP.value{1}),'\n']);
    dev=fgetl(fid_dev_com)
end
dev=fgetl(fid_dev_fofb)
while (dev~=-1)
    IP=tango_get_property2(dev,'LiberaIpAddr');
    fprintf(fid_IP_fofb,[num2str(IP.value{1}),'\n']);
    dev=fgetl(fid_dev_fofb)
end
fclose(fid_dev_fofb)
fclose(fid_dev_com)
fclose(fid_IP_fofb)
fclose(fid_IP_com)

    
