function [BPM_list bufferX bufferZ pxfftaff_all pzfftaff_all Xintegrale_all Zintegrale_all f_bpm]=Compute_FFT_on_FA_data(buffer_length,fmin,fmax,save2xls)

clk=clock;
year=num2str(clk(1));
month=num2str(clk(2),'%.2d');
day=num2str(clk(3),'%.2d');
hour=[num2str(clk(4),'%.2d'),'h'];
min=[num2str(clk(5),'%.2d'),'mn'];
date=['_',year,'_',month,'_',day,'_',hour,'_',min];
pathname= getfamilydata('Directory', 'DG')
filename=[getfamilydata('Directory', 'DG') '/Enregistrement',date,'.mat'];


%sniffer_id='sniffer2';
sniffer_id='sniffer_arch2';
fech=10079;
fmin_display=fmin;
fmax_display=fmax;
fmax_record=2000;

[selection ok]=listdlg('liststring',family2tangodev('BPMx'),'Name','Select BPM(s)')
if ok
    Nbpm=size(selection,2);
    
    [BPM_list bufferX bufferZ]=read_bpmFA_sniffer(sniffer_id,buffer_length,selection);
    
    Nsamples=size(bufferX,2);
    [pxfftaff,pzfftaff,Xintegrale_bpm,Zintegrale_bpm,f_bpm]=fft_and_noise_calcul_group(bufferX(:,1:Nsamples),bufferZ(:,1:Nsamples),fech);
    pxfftaff_all=pxfftaff;
    pzfftaff_all=pzfftaff;
    Xintegrale_all(:,1:Nsamples)=Xintegrale_bpm;
    Zintegrale_all(:,1:Nsamples)=Zintegrale_bpm;

%     answer=questdlg(['Display FFT and noise for ',num2str(Nbpm),' BPMs?']);
%     switch answer
%         case 'Yes'
%            for j=1:1:Nbpm
%                 figure
%                 
%                 subplot(2,2,1)
%                 semilogy(f_bpm,pxfftaff_all(j,2:Nsamples));
%                 xlim([fmin_display fmax_display]);
%                 ylim([10^-3 10^2]);
%                 xlabel('frequency (Hz)')
%                 ylabel('µm/sqrt(Hz)')
%                 title(family2tangodev('BPMx',selection(j)));
%                 legend('fft plan H');
%                 grid on;
% 
%                 subplot(2,2,2)
%                 semilogy(f_bpm,pzfftaff_all(j,2:Nsamples));
%                 xlim([fmin_display fmax_display]);
%                 ylim([10^-3 10^1]);
%                 xlabel('frequency (Hz)')
%                 ylabel('µm/sqrt(Hz)')
%                 title(family2tangodev('BPMx',selection(j)));
%                 legend('fft plan V');
%                 grid on;
% 
%                 subplot(2,2,3)
%                 plot(f_bpm,Xintegrale_all(j,2:Nsamples));
%                 xlim([fmin_display fmax_display]);
%                 xlabel('frequence (Hz)');
%                 ylabel('µm');
%                 legend('bruit integré plan H');
%                 grid on;
% 
%                 subplot(2,2,4)
%                 plot(f_bpm,Zintegrale_all(j,2:Nsamples))
%                 xlim([fmin_display fmax_display]);
%                 xlabel('frequence (Hz)');
%                 ylabel('µm');
%                 legend('bruit integré plan V');
%                 grid on;
% 
%            end
%         otherwise
%     end
            
    BPM_list=family2tangodev('BPMx',selection(:));
    %uisave({'BPM_list','bufferX','bufferZ','pxfftaff_all','pzfftaff_all','Xintegrale_all','Zintegrale_all','f_bpm'},filename)
    uisave({'BPM_list','bufferX','bufferZ'},filename)
    if save2xls
        filename_xls={['Enregistrement',date]};
        answer = inputdlg('Filename:','Save results in an exel file?',1,filename_xls,'on');
        if isempty(answer)
        else
            index=max(find(f_bpm<fmax_record));

            for i=1:1:Nbpm
                bpm_name=BPM_list{i};
                bpm_name(8)='_';
                bpm_name(11)='_';
                bpm_name(15)='_'

                filename=[answer{1},'_',bpm_name,'.xls'];
                fid=fopen(filename,'w');
                first_line='frequence:Spectre_X:Spectre_Z\n';
                fprintf(fid,first_line);
                for j=1:1:index-1
                    fprintf(fid,'%d:%d:%d\n',f_bpm(j),pxfftaff_all(i,j+1),pzfftaff_all(i,j+1));
                end
                fclose(fid)
                fprintf('Le fichier %s est bien enregistré\n',filename);
            end
        end
    end
end













