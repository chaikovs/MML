function setcavityvoltage(voltage)
%SETCAVITYVOLTAGE - set the RF vavity voltage in Volts
%  setcavityvoltage(vol)
%
%  INPUT   
%  voltage -  RF cavity voltage    [V]
%
%  See also  getcavityvoltage, setcavity

%
%%  Written by Jianfeng Zhang  05/2010


global THERING;

cavityidx = findcells(THERING,'Voltage');
THERING{cavityidx}.Voltage = voltage;

