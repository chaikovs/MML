function scan_mode_degrade_synchro
%SET_70MEV Summary of this function goes here
%   Detailed explanation goes here
% linac fired 5 ms before (70 MeV versus 110 MeV)

% Get initial 110 MeV value
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjTimeDelay');
TInj0=temp.value(1);
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'ExtractionOffsetTimeValue');
TExt0=temp.value(1);
save 'initial110MeV.mat'  TInj0  TExt0
return

% Step by delai Tinj and Text of central
load 'initial110MeV.mat'  TInj0  TExt0

delai=-5000; % in µs
TInj=TInj0 + delai;
tango_write_attribute2('ANS/SY/CENTRAL', 'TInjTimeDelay',TInj);

%TExt=TExt0 + delai;
%tango_write_attribute2('ANS/SY/CENTRAL', 'TSprTimeDelay',TExt);