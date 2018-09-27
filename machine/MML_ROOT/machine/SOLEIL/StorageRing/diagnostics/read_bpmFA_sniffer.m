function [bpm_selection bufferX bufferZ]=read_bpmFA_sniffer(sniffer_id,buffer_length,bpm_selection)

switch sniffer_id
    case 'sniffer1'
        dev='ANS/DG/fofb-sniffer.1';
        sniffer_type=0; %CPCI sniffer 
    case 'sniffer2'
        dev='ANS/DG/fofb-sniffer.2';
        sniffer_type=0; %CPCI sniffer 
    case'sniffer_arch1'
        dev='ANS/DG/fofb-sniffer.2'; 
        sniffer_type=1;% sniffer archiver 
    case'sniffer_arch2'
        dev='ac14b719-srvsniffer1';
        sniffer_type=1;% sniffer archiver 
    otherwise
        dev='ANS/DG/fofb-sniffer.2';
        sniffer_type=0; %CPCI sniffer 
end

fech=10079;

Nbpm=size(bpm_selection,2);

switch sniffer_type
    case 0        
        h1=waitbar(0,'please wait...');
        tango_write_attribute2(dev,'recordLengthInSecs',buffer_length) %writing buffer length start a new measurement
        pause(1)
        record_length=tango_read_attribute2(dev,'recordLengthInSecs');
        for i=1:buffer_length+2
            pause(1)
            waitbar(i/buffer_length,h1);
        end
        close(h1)
       h2=waitbar(0,'please wait...');
        for j=1:1:Nbpm % read data 
            bufferX(j,:)=(tango_command_inout2(dev,'GetXPosData',uint16(bpm_selection(j))));
            bufferZ(j,:)=(tango_command_inout2(dev,'GetZPosData',uint16(bpm_selection(j))));
            waitbar(j/Nbpm,h2)
        end
        close(h2)
    case 1
        Nsamples=buffer_length*fech;
        data=fa_load(Nsamples,bpm_selection,'C',dev,true);  
        for j=1:1:Nbpm % read data 
            bufferX(j,:)=squeeze(data.data(1,j,:))';
            bufferZ(j,:)=squeeze(data.data(2,j,:))';
        end



end
