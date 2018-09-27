function result=create_bpm_group(device_list)
groupe=tango_group_create2('BPMs_ans');
device_list
for i=1:1:size(device_list,1)
dev_list(i,:)=device_list{i};
tango_group_add(groupe,dev_list(i,:));
end

tango_group_dump(groupe)
%  attr_list={'DDBufferSize','DDTriggerCounter'}
%  result=tango_group_write_attribute(groupe,'DDBufferSize',1,int32(100))
result=groupe;

