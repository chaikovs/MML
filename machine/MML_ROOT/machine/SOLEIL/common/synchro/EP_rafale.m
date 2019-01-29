% mode rafale test EP
% 
burst=5 ;     % nb de coup rafale
boucle=1 ;  % nb de rafale
delai=3 ;      % delai entre rafale (s)

% Set table to one value
bunch=[1];
[dtour,dpaquet]=bucketnumber(bunch);
table=int32([length(bunch) dtour dpaquet]);
tango_command_inout('ANS/SY/CENTRAL','SetTables',table);


% Profondeur rafale
tango_write_attribute2('ANS/SY/CENTRAL', 'burstSize',int32(burst));



% boucle
for i=1:boucle
    i
    tango_command_inout2('ANS/SY/CENTRAL','FireBurstEvent');
    pause(delai)
end


    
    