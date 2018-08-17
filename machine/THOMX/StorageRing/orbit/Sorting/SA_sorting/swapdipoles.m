function [s,in] = swapdipoles(inputdip, ind, n)
% swapdipoles
% s = swapdipoles(inputdip,n) returns a set of m dipoles where n dipoles
% are randomly swaped. 
% 

% v = 1:14;
% C = nchoosek(v,8);
% s = inputdip(randperm(14,8));

s = inputdip;
in = ind;

%randperm(3)
for i = 1 : n
    %dipo_1 = round(length(inputdip)*rand(1))
    dipo_1 = floor(length(s)*rand(1))+1;
    if dipo_1 < 1 
        dipo_1 = 1;
    end
    %dipo_2 = round(length(inputdip)*rand(1));
    dipo_2 = floor(length(s)*rand(1))+1;
    if dipo_2 < 1
        dipo_2 = 1;
    end
    temp = s(:,dipo_1);
    tempIN = in(:,dipo_1);
    s(:,dipo_1) = s(:,dipo_2);
    s(:,dipo_2) = temp;
    in(:,dipo_1) = in(:,dipo_2);
    in(:,dipo_2) = tempIN;
end