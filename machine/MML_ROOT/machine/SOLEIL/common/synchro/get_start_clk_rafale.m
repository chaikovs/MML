function [clk1,clk2]=get_start_clk_rafale


n=1;
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprStepDelay');
clk1=temp.value(n);
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay');
clk2=temp.value(n);



