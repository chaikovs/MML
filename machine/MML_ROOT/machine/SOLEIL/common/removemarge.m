function [] = removemarge()
TI = get(gca,'TightInSet');
OP = get(gca,'OuterPosition');
Pos = OP + [ TI(1:2), -TI(1:2)-TI(3:4) ];
set( gca,'Position',Pos);
end