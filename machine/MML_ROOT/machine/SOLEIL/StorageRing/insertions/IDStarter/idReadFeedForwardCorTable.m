function [oldTableWithArg] = idReadFeedForwardCorTable(idName, tabName)

[DServName, StandByStr] = idGetUndDServer(idName);

%Reading existing cor. table
rep = tango_read_attribute2(DServName, tabName);
oldTableWithArg = rep.value;
