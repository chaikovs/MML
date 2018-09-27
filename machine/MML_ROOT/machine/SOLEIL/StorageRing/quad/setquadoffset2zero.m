function setquadoffset2zero            
% setquadoffset2zero - Set offsets values to zeros for Q1 to 10 quadrupole magnets
%

% 22nd July 2010
%% Written by Laurent S. Nadolski

AO = getao;

tango_group_command_inout2(AO.Q1.GroupId, 'SetOffsetsToZero');
tango_group_command_inout2(AO.Q2.GroupId, 'SetOffsetsToZero');
tango_group_command_inout2(AO.Q3.GroupId, 'SetOffsetsToZero');
tango_group_command_inout2(AO.Q4.GroupId, 'SetOffsetsToZero');
tango_group_command_inout2(AO.Q5.GroupId, 'SetOffsetsToZero');
tango_group_command_inout2(AO.Q6.GroupId, 'SetOffsetsToZero');
tango_group_command_inout2(AO.Q7.GroupId, 'SetOffsetsToZero');
tango_group_command_inout2(AO.Q8.GroupId, 'SetOffsetsToZero');
tango_group_command_inout2(AO.Q9.GroupId, 'SetOffsetsToZero');
tango_group_command_inout2(AO.Q10.GroupId, 'SetOffsetsToZero');
tango_group_command_inout2(AO.Q11.GroupId, 'SetOffsetsToZero');
tango_group_command_inout2(AO.Q12.GroupId, 'SetOffsetsToZero');

% %%
% tango_group_write_attribute2(AO.Q1.GroupId,'currentOffset1',-0.1);
% tango_group_write_attribute2(AO.Q2.GroupId,'currentOffset1',-0.2);
% tango_group_write_attribute2(AO.Q3.GroupId,'currentOffset1',-0.3);
% tango_group_write_attribute2(AO.Q4.GroupId,'currentOffset1',-0.4);
% tango_group_write_attribute2(AO.Q5.GroupId,'currentOffset1',-0.5);
% tango_group_write_attribute2(AO.Q6.GroupId,'currentOffset1',-0.6);
% tango_group_write_attribute2(AO.Q7.GroupId,'currentOffset1',-0.7);
% tango_group_write_attribute2(AO.Q8.GroupId,'currentOffset1',-0.8);
% tango_group_write_attribute2(AO.Q9.GroupId,'currentOffset1',-0.9);
% tango_group_write_attribute2(AO.Q10.GroupId,'currentOffset1',-1);
% 
% %%
% tango_group_read_attribute2(AO.Q1.GroupId,'currentOffset1')
% tango_group_read_attribute2(AO.Q2.GroupId,'currentOffset1')
% tango_group_read_attribute2(AO.Q3.GroupId,'currentOffset1')
% tango_group_read_attribute2(AO.Q4.GroupId,'currentOffset1')
% tango_group_read_attribute2(AO.Q5.GroupId,'currentOffset1')
% tango_group_read_attribute2(AO.Q6.GroupId,'currentOffset1')
% tango_group_read_attribute2(AO.Q7.GroupId,'currentOffset1')
% tango_group_read_attribute2(AO.Q8.GroupId,'currentOffset1')
% tango_group_read_attribute2(AO.Q9.GroupId,'currentOffset1')
% tango_group_read_attribute2(AO.Q10.GroupId,'currentOffset1')

