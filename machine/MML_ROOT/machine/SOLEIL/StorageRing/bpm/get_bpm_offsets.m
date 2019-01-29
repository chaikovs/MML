function [OffsetStructure]=get_bpm_offsets(dev)
%get_bpm_offsets - get all offset defined in TANGO for the Libera
%
%  INPUTS
%  1. dev = device list as family2dev('BPMx')
%  or dev = element list as family2elem('BPMx')
%
%  OUTPUTS
%  1. OffsetStructure - Structure with all offsets read in TANGO/Libera
%          DeviceList: [122x2 double]
%           BBA_offset: [122x2 double]
%        survey_offset: [122x2 double]
%         block_offset: [122x6 double]
%     libera_RF_offset: [122x6 double]
%
%  NOTES
%  1. If dev is [] or is absent, all offsets will be found
%
%  See Also getbpmrawdata

% Modified by B. Béranger, Master 2013

X_offset_BBA=0;
Z_offset_BBA=0;
libera_RF_offset=0;
block_offset=0;
survey_offset=0;
increment=1;
Correspondance=tango_get_db_property('BPM','DeviceParameters');
block_table=tango_get_db_property('BPM','BlockParameters');
libera_table=tango_get_db_property('BPM','HwParameters');


% if empty select all valid BPM
if nargin ==0
    dev = [];
end

if isempty(dev)
    DeviceList = family2dev('BPMx');
else
    DeviceList = dev;
    if size(DeviceList,2) == 2 % DeviceList
        
    else %% Element list
        DeviceList = elem2dev('BPMx',DeviceList);
    end
end

% Status one devices
Status     = family2status('BPMx',DeviceList);
DeviceList = DeviceList(find(Status),:);

if isempty(DeviceList)
    disp('All BPM not valid')
    AM = -1;
    return;
end

DeviceName = family2tangodev('BPMx',DeviceList);

OffsetStructure = struct();
OffsetStructure.DeviceName = DeviceName;
OffsetStructure.DeviceList = DeviceList;

for DeviceNumber = 1:length(DeviceName)
    for i=1:1:size(Correspondance,2)
        index=regexpi(Correspondance{i},DeviceName{DeviceNumber});
        if isempty(index)==0
            separator=regexpi(Correspondance{i},':');
            BPM_name=Correspondance{i}(1:separator(1)-1);
            block_name=Correspondance{i}(separator(1)+1:separator(2)-1);
            libera_name=Correspondance{i}(separator(2)+1:size(Correspondance{i},2));
            for j=1:1:size(block_table,2)
                index_block=regexpi(block_table{j},[block_name,':']);
                if isempty(index_block)==0
                    separator=regexpi(block_table{j},':');
                    Block_Ka=str2num(block_table{j}(separator(3)+1:separator(4)-1));
                    Block_Kb=str2num(block_table{j}(separator(4)+1:separator(5)-1));
                    Block_Kc=str2num(block_table{j}(separator(5)+1:separator(6)-1));
                    Block_Kd=str2num(block_table{j}(separator(6)+1:separator(7)-1));
                    
                    X_survey_offset=str2num(block_table{j}(separator(7)+1:separator(8)-1));
                    Z_survey_offset=str2num(block_table{j}(separator(9)+1:separator(10)-1));
                    X_offset_BBA=str2num(block_table{j}(separator(8)+1:separator(9)-1));
                    Z_offset_BBA=str2num(block_table{j}(separator(10)+1:separator(11)-1));
                    BPM=BPM_name;
                end
            end
            for j=1:1:size(libera_table,2)
                index_libera=regexpi(libera_table{j},[libera_name,':']);
                if isempty(index_libera)==0
                    separator=regexpi(libera_table{j},':');
                    libera_Ka=str2num(libera_table{j}(separator(2)+1:separator(3)-1));
                    libera_Kb=str2num(libera_table{j}(separator(3)+1:separator(4)-1));
                    libera_Kc=str2num(libera_table{j}(separator(4)+1:separator(5)-1));
                    libera_Kd=str2num(libera_table{j}(separator(5)+1:separator(6)-1));
                    
                end
            end
        end
    end
    K=11.4;
    OffsetStructure.BBA_offset(DeviceNumber,1)=X_offset_BBA;
    OffsetStructure.BBA_offset(DeviceNumber,2)=Z_offset_BBA;
    OffsetStructure.survey_offset(DeviceNumber,1)=X_survey_offset;
    OffsetStructure.survey_offset(DeviceNumber,2)=Z_survey_offset;
    OffsetStructure.block_offset(DeviceNumber,1)=K*(1/Block_Ka+1/Block_Kd-1/Block_Kb-1/Block_Kc)/(1/Block_Ka+1/Block_Kb+1/Block_Kc+1/Block_Kd);
    OffsetStructure.block_offset(DeviceNumber,2)=K*(1/Block_Ka+1/Block_Kb-1/Block_Kc-1/Block_Kd)/(1/Block_Ka+1/Block_Kb+1/Block_Kc+1/Block_Kd);
    OffsetStructure.block_offset(DeviceNumber,3)=Block_Ka;
    OffsetStructure.block_offset(DeviceNumber,4)=Block_Kb;
    OffsetStructure.block_offset(DeviceNumber,5)=Block_Kc;
    OffsetStructure.block_offset(DeviceNumber,6)=Block_Kd;
    OffsetStructure.libera_RF_offset(DeviceNumber,1)=K*(1/libera_Ka+1/libera_Kd-1/libera_Kb-1/libera_Kc)/(1/libera_Ka+1/libera_Kb+1/libera_Kc+1/libera_Kd);
    OffsetStructure.libera_RF_offset(DeviceNumber,2)=K*(1/libera_Ka+1/libera_Kb-1/libera_Kc-1/libera_Kd)/(1/libera_Ka+1/libera_Kb+1/libera_Kc+1/libera_Kd);
    OffsetStructure.libera_RF_offset(DeviceNumber,3)=libera_Ka;
    OffsetStructure.libera_RF_offset(DeviceNumber,4)=libera_Kb;
    OffsetStructure.libera_RF_offset(DeviceNumber,5)=libera_Kc;
    OffsetStructure.libera_RF_offset(DeviceNumber,6)=libera_Kd;
    
    % block_offset(1)=K*(Block_Ka+Block_Kc-Block_Kb-Block_Kd)/(Block_Ka+Block_Kb+Block_Kc+Block_Kd);
    % block_offset(2)=K*(Block_Ka+Block_Kb-Block_Kc-Block_Kd)/(Block_Ka+Block_Kb+Block_Kc+Block_Kd);
    % libera_RF_offset(1)=K*(libera_Ka+libera_Kc-libera_Kb-libera_Kd)/(libera_Ka+libera_Kb+libera_Kc+libera_Kd);
    % libera_RF_offset(2)=K*(libera_Ka+libera_Kb-libera_Kc-libera_Kd)/(libera_Ka+libera_Kb+libera_Kc+libera_Kd);
    %end
    % switch dev
    %     case 'all'
    %  for i=1:1:size(Correspondance,2)
    %      index=regexpi(Correspondance{i},'ANS-C');
    %     if isempty(index)==0
    %         BPM_name=Correspondance{i}(index:index+15);
    %         block_name=Correspondance{i}(index+17:index+24);
    %   for j=1:1:size(block_table,2)
    %    index=regexpi(block_table{j},[block_name,':']);
    %    if isempty(index)==0
    %         separator=regexpi(block_table{j},':');
    %         X_offset_BBA(increment)=str2num(block_table{j}(separator(8)+1:separator(9)-1));
    %         Z_offset_BBA(increment)=str2num(block_table{j}(separator(10)+1:separator(11)-1));
    %         BPM(increment,:)=BPM_name;
    %         increment=increment+1;
    %    end
    %   end
    %
    %   otherwise
    
    %     offsets_X = [X_offset_BBA(2:end) X_offset_BBA(1)]';
    %     offsets_Z = [Z_offset_BBA(2:end) Z_offset_BBA(1)]';
    %
    %
    %     X_offset=block_offset(1)+BBA_offset(1)+survey_offset(1);
    %     Z_offset=block_offset(2)+BBA_offset(2)+survey_offset(2);
end

OffsetStructure.DataDescriptor = 'Offsets defined in TANGO for the Libera';
OffsetStructure.CreatedBy = mfilename;
OffsetStructure.TimeStamp = datestr(now);

end
