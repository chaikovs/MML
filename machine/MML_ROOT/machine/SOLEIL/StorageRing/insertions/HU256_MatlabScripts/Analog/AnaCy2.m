function OutPut=AnaCy2(Mode)
    OutPut=-1;
    if (strmatch(Mode, 'LH'))
        N=83 %41;
    elseif (strmatch('LV'))
        N=23;
    else
        fprintf('Error in AnaCy2 : Mode should be ''LH'' or ''LV''\n')
        return
    end
    for i=1:N
        AnalogCycle2(i, nan, 0, Mode)
        fprintf('%1.0f\n', i);
        pause (1)
    end
    OutPut=1;
%     for i=1:23  %1:23   % LV 1:41 LH
%         AnalogCycle2(i, nan, 0, 'LV')
% %         AnalogCycle2(i, nan, 0, 'LH');
% %         AnalogCycle(i, nan, 0);
%         fprintf('%1.0f\n', i);
%         pause (1)
%     end
return
end

function SuperAnaCy()
    toto=0;
    toto=AnaCy2();
    while(toto~=1)
        toto=0;
        pause(1);
    end
end