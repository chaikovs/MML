function disablebpm
% disablebpm - disable in Tango group BPM with status 0
%


% Laurent S. Nadolski

%%
familyName = 'BPMx';

GroupId = getfamilydata(familyName, 'GroupId');
% Full list
DeviceListFull = family2dev(familyName,0);
% List with Status 1
DeviceList = family2dev(familyName);
% % Find device list with Status 0
% [iFound, iNotFound] = findrowindex(DeviceListFull, DeviceList);
%tango_group_disable_device2(GroupID, family2tangodev('BPMx', DeviceListFull(iNotFound,:))',0)
tango_group_disable_device2(GroupId, dev2tangodev(familyName, DeviceListFull));
tango_group_enable_device2(GroupId, dev2tangodev(familyName, DeviceList));

size(gethbpmgroup)
