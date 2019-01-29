function cavityvoltage = getcavityvoltage
%GETCAVITYVOLTAGE - read the RF cavity voltage in Volts
%  cavityvoltage=getcavityvoltage
%
%  OUTPUT
%  cavityvoltage - RF cavity voltage          [v]
%
%  See also setcavityvoltage, getcavity  

%
%%   Written by Jianfeng Zhang  05/2010



global THERING;

cavityidx = findcells(THERING,'Voltage');
cavityvoltage = THERING{cavityidx}.Voltage;
