function realTime = tango_shift_time(tangoTime)
%TANGO_SHIFT_TIME - TANGO time is GMT - Convert to real time (East European
%Time)
%
%  INPUTS
%  1. tangoTime
%  2. realTime - true time = tango time shifted by 1 or 2 hours depending
%  on the month (winter/summer time)
%
%  NOTES
%  1. This function is global but has to be modified twice a year
%     BINDING BUG: add an hour or two

%
% Written by Laurent S. Nadolski

IsWinter = 1;

if IsWinter
    realTime = tangoTime + 1*0.04166666666667;
else
    realTime = tangoTime + 2*0.04166666666667;
end