function [DServName, StandByStr, CorCurAttr] = idGetUndDServer(idName)
%Alias of idGetParamForUndSOLEIL;

DServName = '';
StandByStr = ''; %String to search in the return of "Status" command of DServer
CorCurAttr = {};

res=idGetParamForUndSOLEIL(idName);
DServName = res.DServName;
StandByStr =res.StandByStr; %String to search in the return of "Status" command of DServer
CorCurAttr = res.CorCurAttr;



