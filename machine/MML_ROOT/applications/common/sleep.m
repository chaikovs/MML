function sleep(Delay)
%SLEEP - Same as pause
% sleep(Delay [sec])
% 
%  Notes
%  1. Sleep is more accurate than pause w/o memory leak

%
% Written by Greg Portmann


if Delay > 0 && ~isempty(Delay)
    java.lang.Thread.sleep(Delay*1000);
end