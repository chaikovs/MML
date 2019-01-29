function nsls2init(SubMachineName)
%AOINIT - Initialization function for the Matlab Middle Layer for the NSLS-II storage ring
%s setup for nsls2 sr by Xi Yang

ModeNumber =1;
OperationalMode = 'Simulator';
%OperationalMode = 'Online';
setao([]);   %clear previous AcceleratorObjects

% To do:
% 1. Change 'MachineConfig' to 
%    AO.VCM.Setpoint.MemberOf      = {'PlotFamily'; 'Save/Restore'; 'COR'; 'Horizontal'; 'HCM'; 'Magnet'; 'Setpoint'; 'measbpmresp';};
% 2. SQ family should be 30 with two column AT index


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build MML Family Structure %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%
% BPM %
%%%%%%%
AO.BPMx.FamilyName = 'BPMx';
AO.BPMx.MemberOf   = {'PlotFamily'; 'BPM'; 'Diagnostics'; 'BPMx'; 'HBPM'};
AO.BPMx.DeviceList =  [ 30 1; 30 2; 30 3; 30 4; 30 5; 30 6; 1 1; 1 2; 1 3; 1 4; 1 5; 1 6; 2 1; 2 2; 2 3; 2 4; 2 5; 2 6; 3 1; 3 2; 3 3; 3 4; 3 5; 3 6; 4 1; 4 2; 4 3; 4 4; 4 5; 4 6; 5 1; 5 2; 5 3; 5 4; 5 5; 5 6; 6 1; 6 2; 6 3; 6 4; 6 5; 6 6; 7 1; 7 2; 7 3; 7 4; 7 5; 7 6; 8 1; 8 2; 8 3; 8 4; 8 5; 8 6; 9 1; 9 2; 9 3; 9 4; 9 5; 9 6; 10 1; 10 2; 10 3; 10 4; 10 5; 10 6; 11 1; 11 2; 11 3; 11 4; 11 5; 11 6; 12 1; 12 2; 12 3; 12 4; 12 5; 12 6; 13 1; 13 2; 13 3; 13 4; 13 5; 13 6; 14 1; 14 2; 14 3; 14 4; 14 5; 14 6; 15 1; 15 2; 15 3; 15 4; 15 5; 15 6; 16 1; 16 2; 16 3; 16 4; 16 5; 16 6; 17 1; 17 2; 17 3; 17 4; 17 5; 17 6; 18 1; 18 2; 18 3; 18 4; 18 5; 18 6; 19 1; 19 2; 19 3; 19 4; 19 5; 19 6; 20 1; 20 2; 20 3; 20 4; 20 5; 20 6; 21 1; 21 2; 21 3; 21 4; 21 5; 21 6; 22 1; 22 2; 22 3; 22 4; 22 5; 22 6; 23 1; 23 2; 23 3; 23 4; 23 5; 23 6; 24 1; 24 2; 24 3; 24 4; 24 5; 24 6; 25 1; 25 2; 25 3; 25 4; 25 5; 25 6; 26 1; 26 2; 26 3; 26 4; 26 5; 26 6; 27 1; 27 2; 27 3; 27 4; 27 5; 27 6; 28 1; 28 2; 28 3; 28 4; 28 5; 28 6; 29 1; 29 2; 29 3; 29 4; 29 5; 29 6 ];
AO.BPMx.ElementList = (1:size(AO.BPMx.DeviceList,1))';
AO.BPMx.Status = ones(size(AO.BPMx.DeviceList,1),1);
AO.BPMx.CommonNames = [ 'ph1g2c30a'; 'ph2g2c30a'; 'pm1g4c30a'; 'pm1g4c30b'; 'pl2g6c30b'; 'pl1g6c30b'; 'pl1g2c01a'; 'pl2g2c01a'; 'pm1g4c01a'; 'pm1g4c01b'; 'ph2g6c01b'; 'ph1g6c01b'; 'ph1g2c02a'; 'ph2g2c02a'; 'pm1g4c02a'; 'pm1g4c02b'; 'pl2g6c02b'; 'pl1g6c02b'; 'pl1g2c03a'; 'pl2g2c03a'; 'pm1g4c03a'; 'pm1g4c03b'; 'ph2g6c03b'; 'ph1g6c03b'; 'ph1g2c04a'; 'ph2g2c04a'; 'pm1g4c04a'; 'pm1g4c04b'; 'pl2g6c04b'; 'pl1g6c04b'; 'pl1g2c05a'; 'pl2g2c05a'; 'pm1g4c05a'; 'pm1g4c05b'; 'ph2g6c05b'; 'ph1g6c05b'; 'ph1g2c06a'; 'ph2g2c06a'; 'pm1g4c06a'; 'pm1g4c06b'; 'pl2g6c06b'; 'pl1g6c06b'; 'pl1g2c07a'; 'pl2g2c07a'; 'pm1g4c07a'; 'pm1g4c07b'; 'ph2g6c07b'; 'ph1g6c07b'; 'ph1g2c08a'; 'ph2g2c08a'; 'pm1g4c08a'; 'pm1g4c08b'; 'pl2g6c08b'; 'pl1g6c08b'; 'pl1g2c09a'; 'pl2g2c09a'; 'pm1g4c09a'; 'pm1g4c09b'; 'ph2g6c09b'; 'ph1g6c09b'; 'ph1g2c10a'; 'ph2g2c10a'; 'pm1g4c10a'; 'pm1g4c10b'; 'pl2g6c10b'; 'pl1g6c10b'; 'pl1g2c11a'; 'pl2g2c11a'; 'pm1g4c11a'; 'pm1g4c11b'; 'ph2g6c11b'; 'ph1g6c11b'; 'ph1g2c12a'; 'ph2g2c12a'; 'pm1g4c12a'; 'pm1g4c12b'; 'pl2g6c12b'; 'pl1g6c12b'; 'pl1g2c13a'; 'pl2g2c13a'; 'pm1g4c13a'; 'pm1g4c13b'; 'ph2g6c13b'; 'ph1g6c13b'; 'ph1g2c14a'; 'ph2g2c14a'; 'pm1g4c14a'; 'pm1g4c14b'; 'pl2g6c14b'; 'pl1g6c14b'; 'pl1g2c15a'; 'pl2g2c15a'; 'pm1g4c15a'; 'pm1g4c15b'; 'ph2g6c15b'; 'ph1g6c15b'; 'ph1g2c16a'; 'ph2g2c16a'; 'pm1g4c16a'; 'pm1g4c16b'; 'pl2g6c16b'; 'pl1g6c16b'; 'pl1g2c17a'; 'pl2g2c17a'; 'pm1g4c17a'; 'pm1g4c17b'; 'ph2g6c17b'; 'ph1g6c17b'; 'ph1g2c18a'; 'ph2g2c18a'; 'pm1g4c18a'; 'pm1g4c18b'; 'pl2g6c18b'; 'pl1g6c18b'; 'pl1g2c19a'; 'pl2g2c19a'; 'pm1g4c19a'; 'pm1g4c19b'; 'ph2g6c19b'; 'ph1g6c19b'; 'ph1g2c20a'; 'ph2g2c20a'; 'pm1g4c20a'; 'pm1g4c20b'; 'pl2g6c20b'; 'pl1g6c20b'; 'pl1g2c21a'; 'pl2g2c21a'; 'pm1g4c21a'; 'pm1g4c21b'; 'ph2g6c21b'; 'ph1g6c21b'; 'ph1g2c22a'; 'ph2g2c22a'; 'pm1g4c22a'; 'pm1g4c22b'; 'pl2g6c22b'; 'pl1g6c22b'; 'pl1g2c23a'; 'pl2g2c23a'; 'pm1g4c23a'; 'pm1g4c23b'; 'ph2g6c23b'; 'ph1g6c23b'; 'ph1g2c24a'; 'ph2g2c24a'; 'pm1g4c24a'; 'pm1g4c24b'; 'pl2g6c24b'; 'pl1g6c24b'; 'pl1g2c25a'; 'pl2g2c25a'; 'pm1g4c25a'; 'pm1g4c25b'; 'ph2g6c25b'; 'ph1g6c25b'; 'ph1g2c26a'; 'ph2g2c26a'; 'pm1g4c26a'; 'pm1g4c26b'; 'pl2g6c26b'; 'pl1g6c26b'; 'pl1g2c27a'; 'pl2g2c27a'; 'pm1g4c27a'; 'pm1g4c27b'; 'ph2g6c27b'; 'ph1g6c27b'; 'ph1g2c28a'; 'ph2g2c28a'; 'pm1g4c28a'; 'pm1g4c28b'; 'pl2g6c28b'; 'pl1g6c28b'; 'pl1g2c29a'; 'pl2g2c29a'; 'pm1g4c29a'; 'pm1g4c29b'; 'ph2g6c29b'; 'ph1g6c29b' ];

AO.BPMx.Monitor.Mode             = OperationalMode;
AO.BPMx.Monitor.DataType         = 'Scalar';
AO.BPMx.Monitor.ChannelNames     = ['SR:C30-BI{BPM:1}Pos:X-I'; 'SR:C30-BI{BPM:2}Pos:X-I'; 'SR:C30-BI{BPM:3}Pos:X-I'; 'SR:C30-BI{BPM:4}Pos:X-I'; 'SR:C30-BI{BPM:5}Pos:X-I'; 'SR:C30-BI{BPM:6}Pos:X-I'; 'SR:C01-BI{BPM:1}Pos:X-I'; 'SR:C01-BI{BPM:2}Pos:X-I'; 'SR:C01-BI{BPM:3}Pos:X-I'; 'SR:C01-BI{BPM:4}Pos:X-I'; 'SR:C01-BI{BPM:5}Pos:X-I'; 'SR:C01-BI{BPM:6}Pos:X-I'; 'SR:C02-BI{BPM:1}Pos:X-I'; 'SR:C02-BI{BPM:2}Pos:X-I'; 'SR:C02-BI{BPM:3}Pos:X-I'; 'SR:C02-BI{BPM:4}Pos:X-I'; 'SR:C02-BI{BPM:5}Pos:X-I'; 'SR:C02-BI{BPM:6}Pos:X-I'; 'SR:C03-BI{BPM:1}Pos:X-I'; 'SR:C03-BI{BPM:2}Pos:X-I'; 'SR:C03-BI{BPM:3}Pos:X-I'; 'SR:C03-BI{BPM:4}Pos:X-I'; 'SR:C03-BI{BPM:5}Pos:X-I'; 'SR:C03-BI{BPM:6}Pos:X-I'; 'SR:C04-BI{BPM:1}Pos:X-I'; 'SR:C04-BI{BPM:2}Pos:X-I'; 'SR:C04-BI{BPM:3}Pos:X-I'; 'SR:C04-BI{BPM:4}Pos:X-I'; 'SR:C04-BI{BPM:5}Pos:X-I'; 'SR:C04-BI{BPM:6}Pos:X-I'; 'SR:C05-BI{BPM:1}Pos:X-I'; 'SR:C05-BI{BPM:2}Pos:X-I'; 'SR:C05-BI{BPM:3}Pos:X-I'; 'SR:C05-BI{BPM:4}Pos:X-I'; 'SR:C05-BI{BPM:5}Pos:X-I'; 'SR:C05-BI{BPM:6}Pos:X-I'; 'SR:C06-BI{BPM:1}Pos:X-I'; 'SR:C06-BI{BPM:2}Pos:X-I'; 'SR:C06-BI{BPM:3}Pos:X-I'; 'SR:C06-BI{BPM:4}Pos:X-I'; 'SR:C06-BI{BPM:5}Pos:X-I'; 'SR:C06-BI{BPM:6}Pos:X-I'; 'SR:C07-BI{BPM:1}Pos:X-I'; 'SR:C07-BI{BPM:2}Pos:X-I'; 'SR:C07-BI{BPM:3}Pos:X-I'; 'SR:C07-BI{BPM:4}Pos:X-I'; 'SR:C07-BI{BPM:5}Pos:X-I'; 'SR:C07-BI{BPM:6}Pos:X-I'; 'SR:C08-BI{BPM:1}Pos:X-I'; 'SR:C08-BI{BPM:2}Pos:X-I'; 'SR:C08-BI{BPM:3}Pos:X-I'; 'SR:C08-BI{BPM:4}Pos:X-I'; 'SR:C08-BI{BPM:5}Pos:X-I'; 'SR:C08-BI{BPM:6}Pos:X-I'; 'SR:C09-BI{BPM:1}Pos:X-I'; 'SR:C09-BI{BPM:2}Pos:X-I'; 'SR:C09-BI{BPM:3}Pos:X-I'; 'SR:C09-BI{BPM:4}Pos:X-I'; 'SR:C09-BI{BPM:5}Pos:X-I'; 'SR:C09-BI{BPM:6}Pos:X-I'; 'SR:C10-BI{BPM:1}Pos:X-I'; 'SR:C10-BI{BPM:2}Pos:X-I'; 'SR:C10-BI{BPM:3}Pos:X-I'; 'SR:C10-BI{BPM:4}Pos:X-I'; 'SR:C10-BI{BPM:5}Pos:X-I'; 'SR:C10-BI{BPM:6}Pos:X-I'; 'SR:C11-BI{BPM:1}Pos:X-I'; 'SR:C11-BI{BPM:2}Pos:X-I'; 'SR:C11-BI{BPM:3}Pos:X-I'; 'SR:C11-BI{BPM:4}Pos:X-I'; 'SR:C11-BI{BPM:5}Pos:X-I'; 'SR:C11-BI{BPM:6}Pos:X-I'; 'SR:C12-BI{BPM:1}Pos:X-I'; 'SR:C12-BI{BPM:2}Pos:X-I'; 'SR:C12-BI{BPM:3}Pos:X-I'; 'SR:C12-BI{BPM:4}Pos:X-I'; 'SR:C12-BI{BPM:5}Pos:X-I'; 'SR:C12-BI{BPM:6}Pos:X-I'; 'SR:C13-BI{BPM:1}Pos:X-I'; 'SR:C13-BI{BPM:2}Pos:X-I'; 'SR:C13-BI{BPM:3}Pos:X-I'; 'SR:C13-BI{BPM:4}Pos:X-I'; 'SR:C13-BI{BPM:5}Pos:X-I'; 'SR:C13-BI{BPM:6}Pos:X-I'; 'SR:C14-BI{BPM:1}Pos:X-I'; 'SR:C14-BI{BPM:2}Pos:X-I'; 'SR:C14-BI{BPM:3}Pos:X-I'; 'SR:C14-BI{BPM:4}Pos:X-I'; 'SR:C14-BI{BPM:5}Pos:X-I'; 'SR:C14-BI{BPM:6}Pos:X-I'; 'SR:C15-BI{BPM:1}Pos:X-I'; 'SR:C15-BI{BPM:2}Pos:X-I'; 'SR:C15-BI{BPM:3}Pos:X-I'; 'SR:C15-BI{BPM:4}Pos:X-I'; 'SR:C15-BI{BPM:5}Pos:X-I'; 'SR:C15-BI{BPM:6}Pos:X-I'; 'SR:C16-BI{BPM:1}Pos:X-I'; 'SR:C16-BI{BPM:2}Pos:X-I'; 'SR:C16-BI{BPM:3}Pos:X-I'; 'SR:C16-BI{BPM:4}Pos:X-I'; 'SR:C16-BI{BPM:5}Pos:X-I'; 'SR:C16-BI{BPM:6}Pos:X-I'; 'SR:C17-BI{BPM:1}Pos:X-I'; 'SR:C17-BI{BPM:2}Pos:X-I'; 'SR:C17-BI{BPM:3}Pos:X-I'; 'SR:C17-BI{BPM:4}Pos:X-I'; 'SR:C17-BI{BPM:5}Pos:X-I'; 'SR:C17-BI{BPM:6}Pos:X-I'; 'SR:C18-BI{BPM:1}Pos:X-I'; 'SR:C18-BI{BPM:2}Pos:X-I'; 'SR:C18-BI{BPM:3}Pos:X-I'; 'SR:C18-BI{BPM:4}Pos:X-I'; 'SR:C18-BI{BPM:5}Pos:X-I'; 'SR:C18-BI{BPM:6}Pos:X-I'; 'SR:C19-BI{BPM:1}Pos:X-I'; 'SR:C19-BI{BPM:2}Pos:X-I'; 'SR:C19-BI{BPM:3}Pos:X-I'; 'SR:C19-BI{BPM:4}Pos:X-I'; 'SR:C19-BI{BPM:5}Pos:X-I'; 'SR:C19-BI{BPM:6}Pos:X-I'; 'SR:C20-BI{BPM:1}Pos:X-I'; 'SR:C20-BI{BPM:2}Pos:X-I'; 'SR:C20-BI{BPM:3}Pos:X-I'; 'SR:C20-BI{BPM:4}Pos:X-I'; 'SR:C20-BI{BPM:5}Pos:X-I'; 'SR:C20-BI{BPM:6}Pos:X-I'; 'SR:C21-BI{BPM:1}Pos:X-I'; 'SR:C21-BI{BPM:2}Pos:X-I'; 'SR:C21-BI{BPM:3}Pos:X-I'; 'SR:C21-BI{BPM:4}Pos:X-I'; 'SR:C21-BI{BPM:5}Pos:X-I'; 'SR:C21-BI{BPM:6}Pos:X-I'; 'SR:C22-BI{BPM:1}Pos:X-I'; 'SR:C22-BI{BPM:2}Pos:X-I'; 'SR:C22-BI{BPM:3}Pos:X-I'; 'SR:C22-BI{BPM:4}Pos:X-I'; 'SR:C22-BI{BPM:5}Pos:X-I'; 'SR:C22-BI{BPM:6}Pos:X-I'; 'SR:C23-BI{BPM:1}Pos:X-I'; 'SR:C23-BI{BPM:2}Pos:X-I'; 'SR:C23-BI{BPM:3}Pos:X-I'; 'SR:C23-BI{BPM:4}Pos:X-I'; 'SR:C23-BI{BPM:5}Pos:X-I'; 'SR:C23-BI{BPM:6}Pos:X-I'; 'SR:C24-BI{BPM:1}Pos:X-I'; 'SR:C24-BI{BPM:2}Pos:X-I'; 'SR:C24-BI{BPM:3}Pos:X-I'; 'SR:C24-BI{BPM:4}Pos:X-I'; 'SR:C24-BI{BPM:5}Pos:X-I'; 'SR:C24-BI{BPM:6}Pos:X-I'; 'SR:C25-BI{BPM:1}Pos:X-I'; 'SR:C25-BI{BPM:2}Pos:X-I'; 'SR:C25-BI{BPM:3}Pos:X-I'; 'SR:C25-BI{BPM:4}Pos:X-I'; 'SR:C25-BI{BPM:5}Pos:X-I'; 'SR:C25-BI{BPM:6}Pos:X-I'; 'SR:C26-BI{BPM:1}Pos:X-I'; 'SR:C26-BI{BPM:2}Pos:X-I'; 'SR:C26-BI{BPM:3}Pos:X-I'; 'SR:C26-BI{BPM:4}Pos:X-I'; 'SR:C26-BI{BPM:5}Pos:X-I'; 'SR:C26-BI{BPM:6}Pos:X-I'; 'SR:C27-BI{BPM:1}Pos:X-I'; 'SR:C27-BI{BPM:2}Pos:X-I'; 'SR:C27-BI{BPM:3}Pos:X-I'; 'SR:C27-BI{BPM:4}Pos:X-I'; 'SR:C27-BI{BPM:5}Pos:X-I'; 'SR:C27-BI{BPM:6}Pos:X-I'; 'SR:C28-BI{BPM:1}Pos:X-I'; 'SR:C28-BI{BPM:2}Pos:X-I'; 'SR:C28-BI{BPM:3}Pos:X-I'; 'SR:C28-BI{BPM:4}Pos:X-I'; 'SR:C28-BI{BPM:5}Pos:X-I'; 'SR:C28-BI{BPM:6}Pos:X-I'; 'SR:C29-BI{BPM:1}Pos:X-I'; 'SR:C29-BI{BPM:2}Pos:X-I'; 'SR:C29-BI{BPM:3}Pos:X-I'; 'SR:C29-BI{BPM:4}Pos:X-I'; 'SR:C29-BI{BPM:5}Pos:X-I'; 'SR:C29-BI{BPM:6}Pos:X-I'];
AO.BPMx.Monitor.Units            = 'Hardware';
AO.BPMx.Monitor.HWUnits          = 'mm';
AO.BPMx.Monitor.PhysicsUnits     = 'm';
AO.BPMx.Monitor.HW2PhysicsParams = 1e-3;
AO.BPMx.Monitor.Physics2HWParams = 1e+3;

AO.BPMx.TBT.Mode             = OperationalMode;
AO.BPMx.TBT.MemberOf         = {'PlotFamily'; 'BPM'; 'Diagnostics'; 'BPMx'; 'HBPM'};
AO.BPMx.TBT.Mode             = OperationalMode;
AO.BPMx.TBT.DataType         = 'Waveform';
AO.BPMx.TBT.ChannelNames     = ['SR:C30-BI{BPM:1}TBT:Single-X'; 'SR:C30-BI{BPM:2}TBT:Single-X'; 'SR:C30-BI{BPM:3}TBT:Single-X'; 'SR:C30-BI{BPM:4}TBT:Single-X'; 'SR:C30-BI{BPM:5}TBT:Single-X'; 'SR:C30-BI{BPM:6}TBT:Single-X'; 'SR:C01-BI{BPM:1}TBT:Single-X'; 'SR:C01-BI{BPM:2}TBT:Single-X'; 'SR:C01-BI{BPM:3}TBT:Single-X'; 'SR:C01-BI{BPM:4}TBT:Single-X'; 'SR:C01-BI{BPM:5}TBT:Single-X'; 'SR:C01-BI{BPM:6}TBT:Single-X'; 'SR:C02-BI{BPM:1}TBT:Single-X'; 'SR:C02-BI{BPM:2}TBT:Single-X'; 'SR:C02-BI{BPM:3}TBT:Single-X'; 'SR:C02-BI{BPM:4}TBT:Single-X'; 'SR:C02-BI{BPM:5}TBT:Single-X'; 'SR:C02-BI{BPM:6}TBT:Single-X'; 'SR:C03-BI{BPM:1}TBT:Single-X'; 'SR:C03-BI{BPM:2}TBT:Single-X'; 'SR:C03-BI{BPM:3}TBT:Single-X'; 'SR:C03-BI{BPM:4}TBT:Single-X'; 'SR:C03-BI{BPM:5}TBT:Single-X'; 'SR:C03-BI{BPM:6}TBT:Single-X'; 'SR:C04-BI{BPM:1}TBT:Single-X'; 'SR:C04-BI{BPM:2}TBT:Single-X'; 'SR:C04-BI{BPM:3}TBT:Single-X'; 'SR:C04-BI{BPM:4}TBT:Single-X'; 'SR:C04-BI{BPM:5}TBT:Single-X'; 'SR:C04-BI{BPM:6}TBT:Single-X'; 'SR:C05-BI{BPM:1}TBT:Single-X'; 'SR:C05-BI{BPM:2}TBT:Single-X'; 'SR:C05-BI{BPM:3}TBT:Single-X'; 'SR:C05-BI{BPM:4}TBT:Single-X'; 'SR:C05-BI{BPM:5}TBT:Single-X'; 'SR:C05-BI{BPM:6}TBT:Single-X'; 'SR:C06-BI{BPM:1}TBT:Single-X'; 'SR:C06-BI{BPM:2}TBT:Single-X'; 'SR:C06-BI{BPM:3}TBT:Single-X'; 'SR:C06-BI{BPM:4}TBT:Single-X'; 'SR:C06-BI{BPM:5}TBT:Single-X'; 'SR:C06-BI{BPM:6}TBT:Single-X'; 'SR:C07-BI{BPM:1}TBT:Single-X'; 'SR:C07-BI{BPM:2}TBT:Single-X'; 'SR:C07-BI{BPM:3}TBT:Single-X'; 'SR:C07-BI{BPM:4}TBT:Single-X'; 'SR:C07-BI{BPM:5}TBT:Single-X'; 'SR:C07-BI{BPM:6}TBT:Single-X'; 'SR:C08-BI{BPM:1}TBT:Single-X'; 'SR:C08-BI{BPM:2}TBT:Single-X'; 'SR:C08-BI{BPM:3}TBT:Single-X'; 'SR:C08-BI{BPM:4}TBT:Single-X'; 'SR:C08-BI{BPM:5}TBT:Single-X'; 'SR:C08-BI{BPM:6}TBT:Single-X'; 'SR:C09-BI{BPM:1}TBT:Single-X'; 'SR:C09-BI{BPM:2}TBT:Single-X'; 'SR:C09-BI{BPM:3}TBT:Single-X'; 'SR:C09-BI{BPM:4}TBT:Single-X'; 'SR:C09-BI{BPM:5}TBT:Single-X'; 'SR:C09-BI{BPM:6}TBT:Single-X'; 'SR:C10-BI{BPM:1}TBT:Single-X'; 'SR:C10-BI{BPM:2}TBT:Single-X'; 'SR:C10-BI{BPM:3}TBT:Single-X'; 'SR:C10-BI{BPM:4}TBT:Single-X'; 'SR:C10-BI{BPM:5}TBT:Single-X'; 'SR:C10-BI{BPM:6}TBT:Single-X'; 'SR:C11-BI{BPM:1}TBT:Single-X'; 'SR:C11-BI{BPM:2}TBT:Single-X'; 'SR:C11-BI{BPM:3}TBT:Single-X'; 'SR:C11-BI{BPM:4}TBT:Single-X'; 'SR:C11-BI{BPM:5}TBT:Single-X'; 'SR:C11-BI{BPM:6}TBT:Single-X'; 'SR:C12-BI{BPM:1}TBT:Single-X'; 'SR:C12-BI{BPM:2}TBT:Single-X'; 'SR:C12-BI{BPM:3}TBT:Single-X'; 'SR:C12-BI{BPM:4}TBT:Single-X'; 'SR:C12-BI{BPM:5}TBT:Single-X'; 'SR:C12-BI{BPM:6}TBT:Single-X'; 'SR:C13-BI{BPM:1}TBT:Single-X'; 'SR:C13-BI{BPM:2}TBT:Single-X'; 'SR:C13-BI{BPM:3}TBT:Single-X'; 'SR:C13-BI{BPM:4}TBT:Single-X'; 'SR:C13-BI{BPM:5}TBT:Single-X'; 'SR:C13-BI{BPM:6}TBT:Single-X'; 'SR:C14-BI{BPM:1}TBT:Single-X'; 'SR:C14-BI{BPM:2}TBT:Single-X'; 'SR:C14-BI{BPM:3}TBT:Single-X'; 'SR:C14-BI{BPM:4}TBT:Single-X'; 'SR:C14-BI{BPM:5}TBT:Single-X'; 'SR:C14-BI{BPM:6}TBT:Single-X'; 'SR:C15-BI{BPM:1}TBT:Single-X'; 'SR:C15-BI{BPM:2}TBT:Single-X'; 'SR:C15-BI{BPM:3}TBT:Single-X'; 'SR:C15-BI{BPM:4}TBT:Single-X'; 'SR:C15-BI{BPM:5}TBT:Single-X'; 'SR:C15-BI{BPM:6}TBT:Single-X'; 'SR:C16-BI{BPM:1}TBT:Single-X'; 'SR:C16-BI{BPM:2}TBT:Single-X'; 'SR:C16-BI{BPM:3}TBT:Single-X'; 'SR:C16-BI{BPM:4}TBT:Single-X'; 'SR:C16-BI{BPM:5}TBT:Single-X'; 'SR:C16-BI{BPM:6}TBT:Single-X'; 'SR:C17-BI{BPM:1}TBT:Single-X'; 'SR:C17-BI{BPM:2}TBT:Single-X'; 'SR:C17-BI{BPM:3}TBT:Single-X'; 'SR:C17-BI{BPM:4}TBT:Single-X'; 'SR:C17-BI{BPM:5}TBT:Single-X'; 'SR:C17-BI{BPM:6}TBT:Single-X'; 'SR:C18-BI{BPM:1}TBT:Single-X'; 'SR:C18-BI{BPM:2}TBT:Single-X'; 'SR:C18-BI{BPM:3}TBT:Single-X'; 'SR:C18-BI{BPM:4}TBT:Single-X'; 'SR:C18-BI{BPM:5}TBT:Single-X'; 'SR:C18-BI{BPM:6}TBT:Single-X'; 'SR:C19-BI{BPM:1}TBT:Single-X'; 'SR:C19-BI{BPM:2}TBT:Single-X'; 'SR:C19-BI{BPM:3}TBT:Single-X'; 'SR:C19-BI{BPM:4}TBT:Single-X'; 'SR:C19-BI{BPM:5}TBT:Single-X'; 'SR:C19-BI{BPM:6}TBT:Single-X'; 'SR:C20-BI{BPM:1}TBT:Single-X'; 'SR:C20-BI{BPM:2}TBT:Single-X'; 'SR:C20-BI{BPM:3}TBT:Single-X'; 'SR:C20-BI{BPM:4}TBT:Single-X'; 'SR:C20-BI{BPM:5}TBT:Single-X'; 'SR:C20-BI{BPM:6}TBT:Single-X'; 'SR:C21-BI{BPM:1}TBT:Single-X'; 'SR:C21-BI{BPM:2}TBT:Single-X'; 'SR:C21-BI{BPM:3}TBT:Single-X'; 'SR:C21-BI{BPM:4}TBT:Single-X'; 'SR:C21-BI{BPM:5}TBT:Single-X'; 'SR:C21-BI{BPM:6}TBT:Single-X'; 'SR:C22-BI{BPM:1}TBT:Single-X'; 'SR:C22-BI{BPM:2}TBT:Single-X'; 'SR:C22-BI{BPM:3}TBT:Single-X'; 'SR:C22-BI{BPM:4}TBT:Single-X'; 'SR:C22-BI{BPM:5}TBT:Single-X'; 'SR:C22-BI{BPM:6}TBT:Single-X'; 'SR:C23-BI{BPM:1}TBT:Single-X'; 'SR:C23-BI{BPM:2}TBT:Single-X'; 'SR:C23-BI{BPM:3}TBT:Single-X'; 'SR:C23-BI{BPM:4}TBT:Single-X'; 'SR:C23-BI{BPM:5}TBT:Single-X'; 'SR:C23-BI{BPM:6}TBT:Single-X'; 'SR:C24-BI{BPM:1}TBT:Single-X'; 'SR:C24-BI{BPM:2}TBT:Single-X'; 'SR:C24-BI{BPM:3}TBT:Single-X'; 'SR:C24-BI{BPM:4}TBT:Single-X'; 'SR:C24-BI{BPM:5}TBT:Single-X'; 'SR:C24-BI{BPM:6}TBT:Single-X'; 'SR:C25-BI{BPM:1}TBT:Single-X'; 'SR:C25-BI{BPM:2}TBT:Single-X'; 'SR:C25-BI{BPM:3}TBT:Single-X'; 'SR:C25-BI{BPM:4}TBT:Single-X'; 'SR:C25-BI{BPM:5}TBT:Single-X'; 'SR:C25-BI{BPM:6}TBT:Single-X'; 'SR:C26-BI{BPM:1}TBT:Single-X'; 'SR:C26-BI{BPM:2}TBT:Single-X'; 'SR:C26-BI{BPM:3}TBT:Single-X'; 'SR:C26-BI{BPM:4}TBT:Single-X'; 'SR:C26-BI{BPM:5}TBT:Single-X'; 'SR:C26-BI{BPM:6}TBT:Single-X'; 'SR:C27-BI{BPM:1}TBT:Single-X'; 'SR:C27-BI{BPM:2}TBT:Single-X'; 'SR:C27-BI{BPM:3}TBT:Single-X'; 'SR:C27-BI{BPM:4}TBT:Single-X'; 'SR:C27-BI{BPM:5}TBT:Single-X'; 'SR:C27-BI{BPM:6}TBT:Single-X'; 'SR:C28-BI{BPM:1}TBT:Single-X'; 'SR:C28-BI{BPM:2}TBT:Single-X'; 'SR:C28-BI{BPM:3}TBT:Single-X'; 'SR:C28-BI{BPM:4}TBT:Single-X'; 'SR:C28-BI{BPM:5}TBT:Single-X'; 'SR:C28-BI{BPM:6}TBT:Single-X'; 'SR:C29-BI{BPM:1}TBT:Single-X'; 'SR:C29-BI{BPM:2}TBT:Single-X'; 'SR:C29-BI{BPM:3}TBT:Single-X'; 'SR:C29-BI{BPM:4}TBT:Single-X'; 'SR:C29-BI{BPM:5}TBT:Single-X'; 'SR:C29-BI{BPM:6}TBT:Single-X'];
AO.BPMx.TBT.Units            = 'Hardware';
AO.BPMx.TBT.HWUnits          = 'mm';
AO.BPMx.TBT.PhysicsUnits     = 'm';
AO.BPMx.TBT.HW2PhysicsParams = 1e-3;
AO.BPMx.TBT.Physics2HWParams = 1e+3;
AO.BPMx.TBT.SpecialFunctionGet     = @getbpm_nsls2;
%AO.BPMx.TBT.AT.SpecialFunctionGet = @getbpmmodel_nsls2;



AO.BPMy.FamilyName = 'BPMy';
AO.BPMy.MemberOf   = {'PlotFamily'; 'BPM'; 'Diagnostics'; 'BPMy'; 'VBPM'};
AO.BPMy.DeviceList = [ 30 1; 30 2; 30 3; 30 4; 30 5; 30 6; 1 1; 1 2; 1 3; 1 4; 1 5; 1 6; 2 1; 2 2; 2 3; 2 4; 2 5; 2 6; 3 1; 3 2; 3 3; 3 4; 3 5; 3 6; 4 1; 4 2; 4 3; 4 4; 4 5; 4 6; 5 1; 5 2; 5 3; 5 4; 5 5; 5 6; 6 1; 6 2; 6 3; 6 4; 6 5; 6 6; 7 1; 7 2; 7 3; 7 4; 7 5; 7 6; 8 1; 8 2; 8 3; 8 4; 8 5; 8 6; 9 1; 9 2; 9 3; 9 4; 9 5; 9 6; 10 1; 10 2; 10 3; 10 4; 10 5; 10 6; 11 1; 11 2; 11 3; 11 4; 11 5; 11 6; 12 1; 12 2; 12 3; 12 4; 12 5; 12 6; 13 1; 13 2; 13 3; 13 4; 13 5; 13 6; 14 1; 14 2; 14 3; 14 4; 14 5; 14 6; 15 1; 15 2; 15 3; 15 4; 15 5; 15 6; 16 1; 16 2; 16 3; 16 4; 16 5; 16 6; 17 1; 17 2; 17 3; 17 4; 17 5; 17 6; 18 1; 18 2; 18 3; 18 4; 18 5; 18 6; 19 1; 19 2; 19 3; 19 4; 19 5; 19 6; 20 1; 20 2; 20 3; 20 4; 20 5; 20 6; 21 1; 21 2; 21 3; 21 4; 21 5; 21 6; 22 1; 22 2; 22 3; 22 4; 22 5; 22 6; 23 1; 23 2; 23 3; 23 4; 23 5; 23 6; 24 1; 24 2; 24 3; 24 4; 24 5; 24 6; 25 1; 25 2; 25 3; 25 4; 25 5; 25 6; 26 1; 26 2; 26 3; 26 4; 26 5; 26 6; 27 1; 27 2; 27 3; 27 4; 27 5; 27 6; 28 1; 28 2; 28 3; 28 4; 28 5; 28 6; 29 1; 29 2; 29 3; 29 4; 29 5; 29 6 ];
AO.BPMy.ElementList = (1:size(AO.BPMy.DeviceList,1))';
AO.BPMy.Status = ones(size(AO.BPMy.DeviceList,1),1);
%AO.BPMy.CommonNames = [ 'ph1g2c30a'; 'ph2g2c30a'; 'pm1g4c30a'; 'pm1g4c30b'; 'pl2g6c30b'; 'pl1g6c30b'; 'pl1g2c01a'; 'pl2g2c01a'; 'pm1g4c01a'; 'pm1g4c01b'; 'ph2g6c01b'; 'ph1g6c01b'; 'ph1g2c02a'; 'ph2g2c02a'; 'pm1g4c02a'; 'pm1g4c02b'; 'pl2g6c02b'; 'pl1g6c02b'; 'pl1g2c03a'; 'pl2g2c03a'; 'pm1g4c03a'; 'pm1g4c03b'; 'ph2g6c03b'; 'ph1g6c03b'; 'ph1g2c04a'; 'ph2g2c04a'; 'pm1g4c04a'; 'pm1g4c04b'; 'pl2g6c04b'; 'pl1g6c04b'; 'pl1g2c05a'; 'pl2g2c05a'; 'pm1g4c05a'; 'pm1g4c05b'; 'ph2g6c05b'; 'ph1g6c05b'; 'ph1g2c06a'; 'ph2g2c06a'; 'pm1g4c06a'; 'pm1g4c06b'; 'pl2g6c06b'; 'pl1g6c06b'; 'pl1g2c07a'; 'pl2g2c07a'; 'pm1g4c07a'; 'pm1g4c07b'; 'ph2g6c07b'; 'ph1g6c07b'; 'ph1g2c08a'; 'ph2g2c08a'; 'pm1g4c08a'; 'pm1g4c08b'; 'pl2g6c08b'; 'pl1g6c08b'; 'pl1g2c09a'; 'pl2g2c09a'; 'pm1g4c09a'; 'pm1g4c09b'; 'ph2g6c09b'; 'ph1g6c09b'; 'ph1g2c10a'; 'ph2g2c10a'; 'pm1g4c10a'; 'pm1g4c10b'; 'pl2g6c10b'; 'pl1g6c10b'; 'pl1g2c11a'; 'pl2g2c11a'; 'pm1g4c11a'; 'pm1g4c11b'; 'ph2g6c11b'; 'ph1g6c11b'; 'ph1g2c12a'; 'ph2g2c12a'; 'pm1g4c12a'; 'pm1g4c12b'; 'pl2g6c12b'; 'pl1g6c12b'; 'pl1g2c13a'; 'pl2g2c13a'; 'pm1g4c13a'; 'pm1g4c13b'; 'ph2g6c13b'; 'ph1g6c13b'; 'ph1g2c14a'; 'ph2g2c14a'; 'pm1g4c14a'; 'pm1g4c14b'; 'pl2g6c14b'; 'pl1g6c14b'; 'pl1g2c15a'; 'pl2g2c15a'; 'pm1g4c15a'; 'pm1g4c15b'; 'ph2g6c15b'; 'ph1g6c15b'; 'ph1g2c16a'; 'ph2g2c16a'; 'pm1g4c16a'; 'pm1g4c16b'; 'pl2g6c16b'; 'pl1g6c16b'; 'pl1g2c17a'; 'pl2g2c17a'; 'pm1g4c17a'; 'pm1g4c17b'; 'ph2g6c17b'; 'ph1g6c17b'; 'ph1g2c18a'; 'ph2g2c18a'; 'pm1g4c18a'; 'pm1g4c18b'; 'pl2g6c18b'; 'pl1g6c18b'; 'pl1g2c19a'; 'pl2g2c19a'; 'pm1g4c19a'; 'pm1g4c19b'; 'ph2g6c19b'; 'ph1g6c19b'; 'ph1g2c20a'; 'ph2g2c20a'; 'pm1g4c20a'; 'pm1g4c20b'; 'pl2g6c20b'; 'pl1g6c20b'; 'pl1g2c21a'; 'pl2g2c21a'; 'pm1g4c21a'; 'pm1g4c21b'; 'ph2g6c21b'; 'ph1g6c21b'; 'ph1g2c22a'; 'ph2g2c22a'; 'pm1g4c22a'; 'pm1g4c22b'; 'pl2g6c22b'; 'pl1g6c22b'; 'pl1g2c23a'; 'pl2g2c23a'; 'pm1g4c23a'; 'pm1g4c23b'; 'ph2g6c23b'; 'ph1g6c23b'; 'ph1g2c24a'; 'ph2g2c24a'; 'pm1g4c24a'; 'pm1g4c24b'; 'pl2g6c24b'; 'pl1g6c24b'; 'pl1g2c25a'; 'pl2g2c25a'; 'pm1g4c25a'; 'pm1g4c25b'; 'ph2g6c25b'; 'ph1g6c25b'; 'ph1g2c26a'; 'ph2g2c26a'; 'pm1g4c26a'; 'pm1g4c26b'; 'pl2g6c26b'; 'pl1g6c26b'; 'pl1g2c27a'; 'pl2g2c27a'; 'pm1g4c27a'; 'pm1g4c27b'; 'ph2g6c27b'; 'ph1g6c27b'; 'ph1g2c28a'; 'ph2g2c28a'; 'pm1g4c28a'; 'pm1g4c28b'; 'pl2g6c28b'; 'pl1g6c28b'; 'pl1g2c29a'; 'pl2g2c29a'; 'pm1g4c29a'; 'pm1g4c29b'; 'ph2g6c29b'; 'ph1g6c29b' ];

AO.BPMy.Monitor.Mode             = OperationalMode;
AO.BPMy.Monitor.DataType         = 'Scalar';
AO.BPMy.Monitor.ChannelNames     = ['SR:C30-BI{BPM:1}Pos:Y-I'; 'SR:C30-BI{BPM:2}Pos:Y-I'; 'SR:C30-BI{BPM:3}Pos:Y-I'; 'SR:C30-BI{BPM:4}Pos:Y-I'; 'SR:C30-BI{BPM:5}Pos:Y-I'; 'SR:C30-BI{BPM:6}Pos:Y-I'; 'SR:C01-BI{BPM:1}Pos:Y-I'; 'SR:C01-BI{BPM:2}Pos:Y-I'; 'SR:C01-BI{BPM:3}Pos:Y-I'; 'SR:C01-BI{BPM:4}Pos:Y-I'; 'SR:C01-BI{BPM:5}Pos:Y-I'; 'SR:C01-BI{BPM:6}Pos:Y-I'; 'SR:C02-BI{BPM:1}Pos:Y-I'; 'SR:C02-BI{BPM:2}Pos:Y-I'; 'SR:C02-BI{BPM:3}Pos:Y-I'; 'SR:C02-BI{BPM:4}Pos:Y-I'; 'SR:C02-BI{BPM:5}Pos:Y-I'; 'SR:C02-BI{BPM:6}Pos:Y-I'; 'SR:C03-BI{BPM:1}Pos:Y-I'; 'SR:C03-BI{BPM:2}Pos:Y-I'; 'SR:C03-BI{BPM:3}Pos:Y-I'; 'SR:C03-BI{BPM:4}Pos:Y-I'; 'SR:C03-BI{BPM:5}Pos:Y-I'; 'SR:C03-BI{BPM:6}Pos:Y-I'; 'SR:C04-BI{BPM:1}Pos:Y-I'; 'SR:C04-BI{BPM:2}Pos:Y-I'; 'SR:C04-BI{BPM:3}Pos:Y-I'; 'SR:C04-BI{BPM:4}Pos:Y-I'; 'SR:C04-BI{BPM:5}Pos:Y-I'; 'SR:C04-BI{BPM:6}Pos:Y-I'; 'SR:C05-BI{BPM:1}Pos:Y-I'; 'SR:C05-BI{BPM:2}Pos:Y-I'; 'SR:C05-BI{BPM:3}Pos:Y-I'; 'SR:C05-BI{BPM:4}Pos:Y-I'; 'SR:C05-BI{BPM:5}Pos:Y-I'; 'SR:C05-BI{BPM:6}Pos:Y-I'; 'SR:C06-BI{BPM:1}Pos:Y-I'; 'SR:C06-BI{BPM:2}Pos:Y-I'; 'SR:C06-BI{BPM:3}Pos:Y-I'; 'SR:C06-BI{BPM:4}Pos:Y-I'; 'SR:C06-BI{BPM:5}Pos:Y-I'; 'SR:C06-BI{BPM:6}Pos:Y-I'; 'SR:C07-BI{BPM:1}Pos:Y-I'; 'SR:C07-BI{BPM:2}Pos:Y-I'; 'SR:C07-BI{BPM:3}Pos:Y-I'; 'SR:C07-BI{BPM:4}Pos:Y-I'; 'SR:C07-BI{BPM:5}Pos:Y-I'; 'SR:C07-BI{BPM:6}Pos:Y-I'; 'SR:C08-BI{BPM:1}Pos:Y-I'; 'SR:C08-BI{BPM:2}Pos:Y-I'; 'SR:C08-BI{BPM:3}Pos:Y-I'; 'SR:C08-BI{BPM:4}Pos:Y-I'; 'SR:C08-BI{BPM:5}Pos:Y-I'; 'SR:C08-BI{BPM:6}Pos:Y-I'; 'SR:C09-BI{BPM:1}Pos:Y-I'; 'SR:C09-BI{BPM:2}Pos:Y-I'; 'SR:C09-BI{BPM:3}Pos:Y-I'; 'SR:C09-BI{BPM:4}Pos:Y-I'; 'SR:C09-BI{BPM:5}Pos:Y-I'; 'SR:C09-BI{BPM:6}Pos:Y-I'; 'SR:C10-BI{BPM:1}Pos:Y-I'; 'SR:C10-BI{BPM:2}Pos:Y-I'; 'SR:C10-BI{BPM:3}Pos:Y-I'; 'SR:C10-BI{BPM:4}Pos:Y-I'; 'SR:C10-BI{BPM:5}Pos:Y-I'; 'SR:C10-BI{BPM:6}Pos:Y-I'; 'SR:C11-BI{BPM:1}Pos:Y-I'; 'SR:C11-BI{BPM:2}Pos:Y-I'; 'SR:C11-BI{BPM:3}Pos:Y-I'; 'SR:C11-BI{BPM:4}Pos:Y-I'; 'SR:C11-BI{BPM:5}Pos:Y-I'; 'SR:C11-BI{BPM:6}Pos:Y-I'; 'SR:C12-BI{BPM:1}Pos:Y-I'; 'SR:C12-BI{BPM:2}Pos:Y-I'; 'SR:C12-BI{BPM:3}Pos:Y-I'; 'SR:C12-BI{BPM:4}Pos:Y-I'; 'SR:C12-BI{BPM:5}Pos:Y-I'; 'SR:C12-BI{BPM:6}Pos:Y-I'; 'SR:C13-BI{BPM:1}Pos:Y-I'; 'SR:C13-BI{BPM:2}Pos:Y-I'; 'SR:C13-BI{BPM:3}Pos:Y-I'; 'SR:C13-BI{BPM:4}Pos:Y-I'; 'SR:C13-BI{BPM:5}Pos:Y-I'; 'SR:C13-BI{BPM:6}Pos:Y-I'; 'SR:C14-BI{BPM:1}Pos:Y-I'; 'SR:C14-BI{BPM:2}Pos:Y-I'; 'SR:C14-BI{BPM:3}Pos:Y-I'; 'SR:C14-BI{BPM:4}Pos:Y-I'; 'SR:C14-BI{BPM:5}Pos:Y-I'; 'SR:C14-BI{BPM:6}Pos:Y-I'; 'SR:C15-BI{BPM:1}Pos:Y-I'; 'SR:C15-BI{BPM:2}Pos:Y-I'; 'SR:C15-BI{BPM:3}Pos:Y-I'; 'SR:C15-BI{BPM:4}Pos:Y-I'; 'SR:C15-BI{BPM:5}Pos:Y-I'; 'SR:C15-BI{BPM:6}Pos:Y-I'; 'SR:C16-BI{BPM:1}Pos:Y-I'; 'SR:C16-BI{BPM:2}Pos:Y-I'; 'SR:C16-BI{BPM:3}Pos:Y-I'; 'SR:C16-BI{BPM:4}Pos:Y-I'; 'SR:C16-BI{BPM:5}Pos:Y-I'; 'SR:C16-BI{BPM:6}Pos:Y-I'; 'SR:C17-BI{BPM:1}Pos:Y-I'; 'SR:C17-BI{BPM:2}Pos:Y-I'; 'SR:C17-BI{BPM:3}Pos:Y-I'; 'SR:C17-BI{BPM:4}Pos:Y-I'; 'SR:C17-BI{BPM:5}Pos:Y-I'; 'SR:C17-BI{BPM:6}Pos:Y-I'; 'SR:C18-BI{BPM:1}Pos:Y-I'; 'SR:C18-BI{BPM:2}Pos:Y-I'; 'SR:C18-BI{BPM:3}Pos:Y-I'; 'SR:C18-BI{BPM:4}Pos:Y-I'; 'SR:C18-BI{BPM:5}Pos:Y-I'; 'SR:C18-BI{BPM:6}Pos:Y-I'; 'SR:C19-BI{BPM:1}Pos:Y-I'; 'SR:C19-BI{BPM:2}Pos:Y-I'; 'SR:C19-BI{BPM:3}Pos:Y-I'; 'SR:C19-BI{BPM:4}Pos:Y-I'; 'SR:C19-BI{BPM:5}Pos:Y-I'; 'SR:C19-BI{BPM:6}Pos:Y-I'; 'SR:C20-BI{BPM:1}Pos:Y-I'; 'SR:C20-BI{BPM:2}Pos:Y-I'; 'SR:C20-BI{BPM:3}Pos:Y-I'; 'SR:C20-BI{BPM:4}Pos:Y-I'; 'SR:C20-BI{BPM:5}Pos:Y-I'; 'SR:C20-BI{BPM:6}Pos:Y-I'; 'SR:C21-BI{BPM:1}Pos:Y-I'; 'SR:C21-BI{BPM:2}Pos:Y-I'; 'SR:C21-BI{BPM:3}Pos:Y-I'; 'SR:C21-BI{BPM:4}Pos:Y-I'; 'SR:C21-BI{BPM:5}Pos:Y-I'; 'SR:C21-BI{BPM:6}Pos:Y-I'; 'SR:C22-BI{BPM:1}Pos:Y-I'; 'SR:C22-BI{BPM:2}Pos:Y-I'; 'SR:C22-BI{BPM:3}Pos:Y-I'; 'SR:C22-BI{BPM:4}Pos:Y-I'; 'SR:C22-BI{BPM:5}Pos:Y-I'; 'SR:C22-BI{BPM:6}Pos:Y-I'; 'SR:C23-BI{BPM:1}Pos:Y-I'; 'SR:C23-BI{BPM:2}Pos:Y-I'; 'SR:C23-BI{BPM:3}Pos:Y-I'; 'SR:C23-BI{BPM:4}Pos:Y-I'; 'SR:C23-BI{BPM:5}Pos:Y-I'; 'SR:C23-BI{BPM:6}Pos:Y-I'; 'SR:C24-BI{BPM:1}Pos:Y-I'; 'SR:C24-BI{BPM:2}Pos:Y-I'; 'SR:C24-BI{BPM:3}Pos:Y-I'; 'SR:C24-BI{BPM:4}Pos:Y-I'; 'SR:C24-BI{BPM:5}Pos:Y-I'; 'SR:C24-BI{BPM:6}Pos:Y-I'; 'SR:C25-BI{BPM:1}Pos:Y-I'; 'SR:C25-BI{BPM:2}Pos:Y-I'; 'SR:C25-BI{BPM:3}Pos:Y-I'; 'SR:C25-BI{BPM:4}Pos:Y-I'; 'SR:C25-BI{BPM:5}Pos:Y-I'; 'SR:C25-BI{BPM:6}Pos:Y-I'; 'SR:C26-BI{BPM:1}Pos:Y-I'; 'SR:C26-BI{BPM:2}Pos:Y-I'; 'SR:C26-BI{BPM:3}Pos:Y-I'; 'SR:C26-BI{BPM:4}Pos:Y-I'; 'SR:C26-BI{BPM:5}Pos:Y-I'; 'SR:C26-BI{BPM:6}Pos:Y-I'; 'SR:C27-BI{BPM:1}Pos:Y-I'; 'SR:C27-BI{BPM:2}Pos:Y-I'; 'SR:C27-BI{BPM:3}Pos:Y-I'; 'SR:C27-BI{BPM:4}Pos:Y-I'; 'SR:C27-BI{BPM:5}Pos:Y-I'; 'SR:C27-BI{BPM:6}Pos:Y-I'; 'SR:C28-BI{BPM:1}Pos:Y-I'; 'SR:C28-BI{BPM:2}Pos:Y-I'; 'SR:C28-BI{BPM:3}Pos:Y-I'; 'SR:C28-BI{BPM:4}Pos:Y-I'; 'SR:C28-BI{BPM:5}Pos:Y-I'; 'SR:C28-BI{BPM:6}Pos:Y-I'; 'SR:C29-BI{BPM:1}Pos:Y-I'; 'SR:C29-BI{BPM:2}Pos:Y-I'; 'SR:C29-BI{BPM:3}Pos:Y-I'; 'SR:C29-BI{BPM:4}Pos:Y-I'; 'SR:C29-BI{BPM:5}Pos:Y-I'; 'SR:C29-BI{BPM:6}Pos:Y-I'];
AO.BPMy.Monitor.Units            = 'Hardware';
AO.BPMy.Monitor.HWUnits          = 'mm';
AO.BPMy.Monitor.PhysicsUnits     = 'm';
AO.BPMy.Monitor.HW2PhysicsParams = 1e-3;
AO.BPMy.Monitor.Physics2HWParams = 1e+3;

AO.BPMy.TBT.Mode             = OperationalMode;
AO.BPMy.TBT.MemberOf         = {'PlotFamily'; 'BPM'; 'Diagnostics'; 'BPMy'; 'VBPM'};
AO.BPMy.TBT.Mode             = OperationalMode;
AO.BPMy.TBT.DataType         = 'Waveform';
AO.BPMy.TBT.ChannelNames     = ['SR:C30-BI{BPM:1}TBT:Single-Y'; 'SR:C30-BI{BPM:2}TBT:Single-Y'; 'SR:C30-BI{BPM:3}TBT:Single-Y'; 'SR:C30-BI{BPM:4}TBT:Single-Y'; 'SR:C30-BI{BPM:5}TBT:Single-Y'; 'SR:C30-BI{BPM:6}TBT:Single-Y'; 'SR:C01-BI{BPM:1}TBT:Single-Y'; 'SR:C01-BI{BPM:2}TBT:Single-Y'; 'SR:C01-BI{BPM:3}TBT:Single-Y'; 'SR:C01-BI{BPM:4}TBT:Single-Y'; 'SR:C01-BI{BPM:5}TBT:Single-Y'; 'SR:C01-BI{BPM:6}TBT:Single-Y'; 'SR:C02-BI{BPM:1}TBT:Single-Y'; 'SR:C02-BI{BPM:2}TBT:Single-Y'; 'SR:C02-BI{BPM:3}TBT:Single-Y'; 'SR:C02-BI{BPM:4}TBT:Single-Y'; 'SR:C02-BI{BPM:5}TBT:Single-Y'; 'SR:C02-BI{BPM:6}TBT:Single-Y'; 'SR:C03-BI{BPM:1}TBT:Single-Y'; 'SR:C03-BI{BPM:2}TBT:Single-Y'; 'SR:C03-BI{BPM:3}TBT:Single-Y'; 'SR:C03-BI{BPM:4}TBT:Single-Y'; 'SR:C03-BI{BPM:5}TBT:Single-Y'; 'SR:C03-BI{BPM:6}TBT:Single-Y'; 'SR:C04-BI{BPM:1}TBT:Single-Y'; 'SR:C04-BI{BPM:2}TBT:Single-Y'; 'SR:C04-BI{BPM:3}TBT:Single-Y'; 'SR:C04-BI{BPM:4}TBT:Single-Y'; 'SR:C04-BI{BPM:5}TBT:Single-Y'; 'SR:C04-BI{BPM:6}TBT:Single-Y'; 'SR:C05-BI{BPM:1}TBT:Single-Y'; 'SR:C05-BI{BPM:2}TBT:Single-Y'; 'SR:C05-BI{BPM:3}TBT:Single-Y'; 'SR:C05-BI{BPM:4}TBT:Single-Y'; 'SR:C05-BI{BPM:5}TBT:Single-Y'; 'SR:C05-BI{BPM:6}TBT:Single-Y'; 'SR:C06-BI{BPM:1}TBT:Single-Y'; 'SR:C06-BI{BPM:2}TBT:Single-Y'; 'SR:C06-BI{BPM:3}TBT:Single-Y'; 'SR:C06-BI{BPM:4}TBT:Single-Y'; 'SR:C06-BI{BPM:5}TBT:Single-Y'; 'SR:C06-BI{BPM:6}TBT:Single-Y'; 'SR:C07-BI{BPM:1}TBT:Single-Y'; 'SR:C07-BI{BPM:2}TBT:Single-Y'; 'SR:C07-BI{BPM:3}TBT:Single-Y'; 'SR:C07-BI{BPM:4}TBT:Single-Y'; 'SR:C07-BI{BPM:5}TBT:Single-Y'; 'SR:C07-BI{BPM:6}TBT:Single-Y'; 'SR:C08-BI{BPM:1}TBT:Single-Y'; 'SR:C08-BI{BPM:2}TBT:Single-Y'; 'SR:C08-BI{BPM:3}TBT:Single-Y'; 'SR:C08-BI{BPM:4}TBT:Single-Y'; 'SR:C08-BI{BPM:5}TBT:Single-Y'; 'SR:C08-BI{BPM:6}TBT:Single-Y'; 'SR:C09-BI{BPM:1}TBT:Single-Y'; 'SR:C09-BI{BPM:2}TBT:Single-Y'; 'SR:C09-BI{BPM:3}TBT:Single-Y'; 'SR:C09-BI{BPM:4}TBT:Single-Y'; 'SR:C09-BI{BPM:5}TBT:Single-Y'; 'SR:C09-BI{BPM:6}TBT:Single-Y'; 'SR:C10-BI{BPM:1}TBT:Single-Y'; 'SR:C10-BI{BPM:2}TBT:Single-Y'; 'SR:C10-BI{BPM:3}TBT:Single-Y'; 'SR:C10-BI{BPM:4}TBT:Single-Y'; 'SR:C10-BI{BPM:5}TBT:Single-Y'; 'SR:C10-BI{BPM:6}TBT:Single-Y'; 'SR:C11-BI{BPM:1}TBT:Single-Y'; 'SR:C11-BI{BPM:2}TBT:Single-Y'; 'SR:C11-BI{BPM:3}TBT:Single-Y'; 'SR:C11-BI{BPM:4}TBT:Single-Y'; 'SR:C11-BI{BPM:5}TBT:Single-Y'; 'SR:C11-BI{BPM:6}TBT:Single-Y'; 'SR:C12-BI{BPM:1}TBT:Single-Y'; 'SR:C12-BI{BPM:2}TBT:Single-Y'; 'SR:C12-BI{BPM:3}TBT:Single-Y'; 'SR:C12-BI{BPM:4}TBT:Single-Y'; 'SR:C12-BI{BPM:5}TBT:Single-Y'; 'SR:C12-BI{BPM:6}TBT:Single-Y'; 'SR:C13-BI{BPM:1}TBT:Single-Y'; 'SR:C13-BI{BPM:2}TBT:Single-Y'; 'SR:C13-BI{BPM:3}TBT:Single-Y'; 'SR:C13-BI{BPM:4}TBT:Single-Y'; 'SR:C13-BI{BPM:5}TBT:Single-Y'; 'SR:C13-BI{BPM:6}TBT:Single-Y'; 'SR:C14-BI{BPM:1}TBT:Single-Y'; 'SR:C14-BI{BPM:2}TBT:Single-Y'; 'SR:C14-BI{BPM:3}TBT:Single-Y'; 'SR:C14-BI{BPM:4}TBT:Single-Y'; 'SR:C14-BI{BPM:5}TBT:Single-Y'; 'SR:C14-BI{BPM:6}TBT:Single-Y'; 'SR:C15-BI{BPM:1}TBT:Single-Y'; 'SR:C15-BI{BPM:2}TBT:Single-Y'; 'SR:C15-BI{BPM:3}TBT:Single-Y'; 'SR:C15-BI{BPM:4}TBT:Single-Y'; 'SR:C15-BI{BPM:5}TBT:Single-Y'; 'SR:C15-BI{BPM:6}TBT:Single-Y'; 'SR:C16-BI{BPM:1}TBT:Single-Y'; 'SR:C16-BI{BPM:2}TBT:Single-Y'; 'SR:C16-BI{BPM:3}TBT:Single-Y'; 'SR:C16-BI{BPM:4}TBT:Single-Y'; 'SR:C16-BI{BPM:5}TBT:Single-Y'; 'SR:C16-BI{BPM:6}TBT:Single-Y'; 'SR:C17-BI{BPM:1}TBT:Single-Y'; 'SR:C17-BI{BPM:2}TBT:Single-Y'; 'SR:C17-BI{BPM:3}TBT:Single-Y'; 'SR:C17-BI{BPM:4}TBT:Single-Y'; 'SR:C17-BI{BPM:5}TBT:Single-Y'; 'SR:C17-BI{BPM:6}TBT:Single-Y'; 'SR:C18-BI{BPM:1}TBT:Single-Y'; 'SR:C18-BI{BPM:2}TBT:Single-Y'; 'SR:C18-BI{BPM:3}TBT:Single-Y'; 'SR:C18-BI{BPM:4}TBT:Single-Y'; 'SR:C18-BI{BPM:5}TBT:Single-Y'; 'SR:C18-BI{BPM:6}TBT:Single-Y'; 'SR:C19-BI{BPM:1}TBT:Single-Y'; 'SR:C19-BI{BPM:2}TBT:Single-Y'; 'SR:C19-BI{BPM:3}TBT:Single-Y'; 'SR:C19-BI{BPM:4}TBT:Single-Y'; 'SR:C19-BI{BPM:5}TBT:Single-Y'; 'SR:C19-BI{BPM:6}TBT:Single-Y'; 'SR:C20-BI{BPM:1}TBT:Single-Y'; 'SR:C20-BI{BPM:2}TBT:Single-Y'; 'SR:C20-BI{BPM:3}TBT:Single-Y'; 'SR:C20-BI{BPM:4}TBT:Single-Y'; 'SR:C20-BI{BPM:5}TBT:Single-Y'; 'SR:C20-BI{BPM:6}TBT:Single-Y'; 'SR:C21-BI{BPM:1}TBT:Single-Y'; 'SR:C21-BI{BPM:2}TBT:Single-Y'; 'SR:C21-BI{BPM:3}TBT:Single-Y'; 'SR:C21-BI{BPM:4}TBT:Single-Y'; 'SR:C21-BI{BPM:5}TBT:Single-Y'; 'SR:C21-BI{BPM:6}TBT:Single-Y'; 'SR:C22-BI{BPM:1}TBT:Single-Y'; 'SR:C22-BI{BPM:2}TBT:Single-Y'; 'SR:C22-BI{BPM:3}TBT:Single-Y'; 'SR:C22-BI{BPM:4}TBT:Single-Y'; 'SR:C22-BI{BPM:5}TBT:Single-Y'; 'SR:C22-BI{BPM:6}TBT:Single-Y'; 'SR:C23-BI{BPM:1}TBT:Single-Y'; 'SR:C23-BI{BPM:2}TBT:Single-Y'; 'SR:C23-BI{BPM:3}TBT:Single-Y'; 'SR:C23-BI{BPM:4}TBT:Single-Y'; 'SR:C23-BI{BPM:5}TBT:Single-Y'; 'SR:C23-BI{BPM:6}TBT:Single-Y'; 'SR:C24-BI{BPM:1}TBT:Single-Y'; 'SR:C24-BI{BPM:2}TBT:Single-Y'; 'SR:C24-BI{BPM:3}TBT:Single-Y'; 'SR:C24-BI{BPM:4}TBT:Single-Y'; 'SR:C24-BI{BPM:5}TBT:Single-Y'; 'SR:C24-BI{BPM:6}TBT:Single-Y'; 'SR:C25-BI{BPM:1}TBT:Single-Y'; 'SR:C25-BI{BPM:2}TBT:Single-Y'; 'SR:C25-BI{BPM:3}TBT:Single-Y'; 'SR:C25-BI{BPM:4}TBT:Single-Y'; 'SR:C25-BI{BPM:5}TBT:Single-Y'; 'SR:C25-BI{BPM:6}TBT:Single-Y'; 'SR:C26-BI{BPM:1}TBT:Single-Y'; 'SR:C26-BI{BPM:2}TBT:Single-Y'; 'SR:C26-BI{BPM:3}TBT:Single-Y'; 'SR:C26-BI{BPM:4}TBT:Single-Y'; 'SR:C26-BI{BPM:5}TBT:Single-Y'; 'SR:C26-BI{BPM:6}TBT:Single-Y'; 'SR:C27-BI{BPM:1}TBT:Single-Y'; 'SR:C27-BI{BPM:2}TBT:Single-Y'; 'SR:C27-BI{BPM:3}TBT:Single-Y'; 'SR:C27-BI{BPM:4}TBT:Single-Y'; 'SR:C27-BI{BPM:5}TBT:Single-Y'; 'SR:C27-BI{BPM:6}TBT:Single-Y'; 'SR:C28-BI{BPM:1}TBT:Single-Y'; 'SR:C28-BI{BPM:2}TBT:Single-Y'; 'SR:C28-BI{BPM:3}TBT:Single-Y'; 'SR:C28-BI{BPM:4}TBT:Single-Y'; 'SR:C28-BI{BPM:5}TBT:Single-Y'; 'SR:C28-BI{BPM:6}TBT:Single-Y'; 'SR:C29-BI{BPM:1}TBT:Single-Y'; 'SR:C29-BI{BPM:2}TBT:Single-Y'; 'SR:C29-BI{BPM:3}TBT:Single-Y'; 'SR:C29-BI{BPM:4}TBT:Single-Y'; 'SR:C29-BI{BPM:5}TBT:Single-Y'; 'SR:C29-BI{BPM:6}TBT:Single-Y'];
AO.BPMy.TBT.Units            = 'Hardware';
AO.BPMy.TBT.HWUnits          = 'mm';
AO.BPMy.TBT.PhysicsUnits     = 'm';
AO.BPMy.TBT.HW2PhysicsParams = 1e-3;
AO.BPMy.TBT.Physics2HWParams = 1e+3;



%% Correctors %
AO.HCM.FamilyName             = 'HCM';
AO.HCM.MemberOf               = {'MachineConfig'; 'PlotFamily';  'COR'; 'HCM'; 'Magnet'};
AO.HCM.DeviceList =  [ 30 1; 30 2; 30 3; 30 4; 30 5; 30 6; 1 1; 1 2; 1 3; 1 4; 1 5; 1 6; 2 1; 2 2; 2 3; 2 4; 2 5; 2 6; 3 1; 3 2; 3 3; 3 4; 3 5; 3 6; 4 1; 4 2; 4 3; 4 4; 4 5; 4 6; 5 1; 5 2; 5 3; 5 4; 5 5; 5 6; 6 1; 6 2; 6 3; 6 4; 6 5; 6 6; 7 1; 7 2; 7 3; 7 4; 7 5; 7 6; 8 1; 8 2; 8 3; 8 4; 8 5; 8 6; 9 1; 9 2; 9 3; 9 4; 9 5; 9 6; 10 1; 10 2; 10 3; 10 4; 10 5; 10 6; 11 1; 11 2; 11 3; 11 4; 11 5; 11 6; 12 1; 12 2; 12 3; 12 4; 12 5; 12 6; 13 1; 13 2; 13 3; 13 4; 13 5; 13 6; 14 1; 14 2; 14 3; 14 4; 14 5; 14 6; 15 1; 15 2; 15 3; 15 4; 15 5; 15 6; 16 1; 16 2; 16 3; 16 4; 16 5; 16 6; 17 1; 17 2; 17 3; 17 4; 17 5; 17 6; 18 1; 18 2; 18 3; 18 4; 18 5; 18 6; 19 1; 19 2; 19 3; 19 4; 19 5; 19 6; 20 1; 20 2; 20 3; 20 4; 20 5; 20 6; 21 1; 21 2; 21 3; 21 4; 21 5; 21 6; 22 1; 22 2; 22 3; 22 4; 22 5; 22 6; 23 1; 23 2; 23 3; 23 4; 23 5; 23 6; 24 1; 24 2; 24 3; 24 4; 24 5; 24 6; 25 1; 25 2; 25 3; 25 4; 25 5; 25 6; 26 1; 26 2; 26 3; 26 4; 26 5; 26 6; 27 1; 27 2; 27 3; 27 4; 27 5; 27 6; 28 1; 28 2; 28 3; 28 4; 28 5; 28 6; 29 1; 29 2; 29 3; 29 4; 29 5; 29 6 ];
AO.HCM.ElementList = (1:size(AO.HCM.DeviceList,1))';
AO.HCM.Status = ones(size(AO.HCM.DeviceList,1),1);

AO.HCM.Monitor.Mode           = OperationalMode;
AO.HCM.Monitor.DataType       = 'Scalar';
AO.HCM.Monitor.ChannelNames   = [ 'SR:C30-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C30-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C30-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C30-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C30-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C30-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C01-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C01-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C01-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C01-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C01-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C01-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C02-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C02-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C02-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C02-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C02-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C02-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C03-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C03-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C03-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C03-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C03-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C03-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C04-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C04-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C04-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C04-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C04-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C04-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C05-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C05-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C05-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C05-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C05-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C05-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C06-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C06-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C06-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C06-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C06-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C06-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C07-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C07-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C07-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C07-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C07-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C07-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C08-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C08-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C08-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C08-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C08-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C08-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C09-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C09-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C09-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C09-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C09-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C09-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C10-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C10-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C10-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C10-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C10-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C10-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C11-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C11-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C11-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C11-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C11-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C11-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C12-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C12-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C12-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C12-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C12-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C12-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C13-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C13-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C13-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C13-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C13-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C13-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C14-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C14-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C14-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C14-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C14-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C14-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C15-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C15-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C15-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C15-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C15-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C15-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C16-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C16-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C16-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C16-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C16-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C16-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C17-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C17-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C17-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C17-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C17-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C17-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C18-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C18-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C18-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C18-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C18-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C18-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C19-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C19-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C19-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C19-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C19-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C19-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C20-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C20-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C20-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C20-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C20-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C20-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C21-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C21-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C21-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C21-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C21-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C21-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C22-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C22-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C22-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C22-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C22-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C22-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C23-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C23-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C23-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C23-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C23-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C23-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C24-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C24-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C24-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C24-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C24-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C24-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C25-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C25-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C25-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C25-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C25-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C25-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C26-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C26-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C26-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C26-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C26-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C26-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C27-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C27-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C27-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C27-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C27-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C27-MG{PS:CH1B}I:Ps1DCCT1-I';'SR:C28-MG{PS:CH1A}I:Ps1DCCT1-I';'SR:C28-MG{PS:CH2A}I:Ps1DCCT1-I';'SR:C28-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C28-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C28-MG{PS:CL2B}I:Ps1DCCT1-I';'SR:C28-MG{PS:CL1B}I:Ps1DCCT1-I';'SR:C29-MG{PS:CL1A}I:Ps1DCCT1-I';'SR:C29-MG{PS:CL2A}I:Ps1DCCT1-I';'SR:C29-MG{PS:CM1A}I:Ps1DCCT1-I';'SR:C29-MG{PS:CM1B}I:Ps1DCCT1-I';'SR:C29-MG{PS:CH2B}I:Ps1DCCT1-I';'SR:C29-MG{PS:CH1B}I:Ps1DCCT1-I' ];
AO.HCM.Monitor.Units          = 'Hardware';
AO.HCM.Monitor.HWUnits        = 'A';
AO.HCM.Monitor.PhysicsUnits   = 'rad';
% AO.HCM.Monitor.HW2PhysicsFcn  = @amp2k;
% AO.HCM.Monitor.Physics2HWFcn  = @k2amp;
AO.HCM.CommonNames = ['ch1g2c30a'; 'ch2g2c30a'; 'cm1g4c30a'; 'cm1g4c30b'; 'cl2g6c30b'; 'cl1g6c30b'; 'cl1g2c01a'; 'cl2g2c01a'; 'cm1g4c01a'; 'cm1g4c01b'; 'ch2g6c01b'; 'ch1g6c01b'; 'ch1g2c02a'; 'ch2g2c02a'; 'cm1g4c02a'; 'cm1g4c02b'; 'cl2g6c02b'; 'cl1g6c02b';  'cl1g2c03a';  'cl2g2c03a';  'cm1g4c03a';  'cm1g4c03b';  'ch2g6c03b';  'ch1g6c03b';  'ch1g2c04a';  'ch2g2c04a';  'cm1g4c04a';  'cm1g4c04b';  'cl2g6c04b';  'cl1g6c04b';  'cl1g2c05a';  'cl2g2c05a'; 'cm1g4c05a';  'cm1g4c05b';  'ch2g6c05b';  'ch1g6c05b';  'ch1g2c06a';  'ch2g2c06a';  'cm1g4c06a';  'cm1g4c06b';  'cl2g6c06b';  'cl1g6c06b';  'cl1g2c07a'; 'cl2g2c07a'; 'cm1g4c07a';  'cm1g4c07b';  'ch2g6c07b';  'ch1g6c07b';  'ch1g2c08a';  'ch2g2c08a';  'cm1g4c08a';  'cm1g4c08b'; 'cl2g6c08b';  'cl1g6c08b';  'cl1g2c09a';  'cl2g2c09a';  'cm1g4c09a';  'cm1g4c09b';  'ch2g6c09b';  'ch1g6c09b'; 'ch1g2c10a';  'ch2g2c10a';  'cm1g4c10a';  'cm1g4c10b';  'cl2g6c10b';  'cl1g6c10b';  'cl1g2c11a';  'cl2g2c11a'; 'cm1g4c11a';  'cm1g4c11b';  'ch2g6c11b';  'ch1g6c11b';  'ch1g2c12a';  'ch2g2c12a';  'cm1g4c12a';  'cm1g4c12b';  'cl2g6c12b';  'cl1g6c12b';  'cl1g2c13a';  'cl2g2c13a';  'cm1g4c13a';  'cm1g4c13b';  'ch2g6c13b'; 'ch1g6c13b';  'ch1g2c14a';  'ch2g2c14a';  'cm1g4c14a';  'cm1g4c14b';  'cl2g6c14b';  'cl1g6c14b';  'cl1g2c15a';  'cl2g2c15a'; 'cm1g4c15a';  'cm1g4c15b';  'ch2g6c15b'; 'ch1g6c15b';  'ch1g2c16a';  'ch2g2c16a'; 'cm1g4c16a';  'cm1g4c16b';  'cl2g6c16b'; 'cl1g6c16b';  'cl1g2c17a';  'cl2g2c17a'; 'cm1g4c17a';  'cm1g4c17b';  'ch2g6c17b'; 'ch1g6c17b';  'ch1g2c18a';  'ch2g2c18a'; 'cm1g4c18a';  'cm1g4c18b';  'cl2g6c18b'; 'cl1g6c18b';  'cl1g2c19a';  'cl2g2c19a'; 'cm1g4c19a';  'cm1g4c19b';  'ch2g6c19b'; 'ch1g6c19b';  'ch1g2c20a';  'ch2g2c20a'; 'cm1g4c20a';  'cm1g4c20b';  'cl2g6c20b'; 'cl1g6c20b';  'cl1g2c21a';  'cl2g2c21a'; 'cm1g4c21a';  'cm1g4c21b';  'ch2g6c21b'; 'ch1g6c21b';  'ch1g2c22a';  'ch2g2c22a'; 'cm1g4c22a';  'cm1g4c22b';  'cl2g6c22b'; 'cl1g6c22b';  'cl1g2c23a';  'cl2g2c23a'; 'cm1g4c23a';  'cm1g4c23b';  'ch2g6c23b'; 'ch1g6c23b';  'ch1g2c24a';  'ch2g2c24a'; 'cm1g4c24a';  'cm1g4c24b';  'cl2g6c24b'; 'cl1g6c24b';  'cl1g2c25a';  'cl2g2c25a'; 'cm1g4c25a';  'cm1g4c25b';  'ch2g6c25b';  'ch1g6c25b';  'ch1g2c26a';  'ch2g2c26a'; 'cm1g4c26a'; 'cm1g4c26b';  'cl2g6c26b'; 'cl1g6c26b'; 'cl1g2c27a'; 'cl2g2c27a';  'cm1g4c27a';  'cm1g4c27b'; 'ch2g6c27b';  'ch1g6c27b';  'ch1g2c28a';  'ch2g2c28a';  'cm1g4c28a';  'cm1g4c28b';  'cl2g6c28b';  'cl1g6c28b';  'cl1g2c29a';  'cl2g2c29a';  'cm1g4c29a';  'cm1g4c29b';  'ch2g6c29b';  'ch1g6c29b'];  
AO.HCM.Setpoint.MemberOf      = {'PlotFamily'; 'Save/Restore'; 'COR'; 'Horizontal'; 'HCM'; 'Magnet'; 'Setpoint'; 'measbpmresp';};
AO.HCM.Setpoint.Mode          = OperationalMode;
AO.HCM.Setpoint.DataType      = 'Scalar';
AO.HCM.Setpoint.ChannelNames  = [ 'SR:C30-MG{PS:CH1A}I:Sp1-SP';'SR:C30-MG{PS:CH2A}I:Sp1-SP';'SR:C30-MG{PS:CM1A}I:Sp1-SP';'SR:C30-MG{PS:CM1B}I:Sp1-SP';'SR:C30-MG{PS:CL2B}I:Sp1-SP';'SR:C30-MG{PS:CL1B}I:Sp1-SP';'SR:C01-MG{PS:CL1A}I:Sp1-SP';'SR:C01-MG{PS:CL2A}I:Sp1-SP';'SR:C01-MG{PS:CM1A}I:Sp1-SP';'SR:C01-MG{PS:CM1B}I:Sp1-SP';'SR:C01-MG{PS:CH2B}I:Sp1-SP';'SR:C01-MG{PS:CH1B}I:Sp1-SP';'SR:C02-MG{PS:CH1A}I:Sp1-SP';'SR:C02-MG{PS:CH2A}I:Sp1-SP';'SR:C02-MG{PS:CM1A}I:Sp1-SP';'SR:C02-MG{PS:CM1B}I:Sp1-SP';'SR:C02-MG{PS:CL2B}I:Sp1-SP';'SR:C02-MG{PS:CL1B}I:Sp1-SP';'SR:C03-MG{PS:CL1A}I:Sp1-SP';'SR:C03-MG{PS:CL2A}I:Sp1-SP';'SR:C03-MG{PS:CM1A}I:Sp1-SP';'SR:C03-MG{PS:CM1B}I:Sp1-SP';'SR:C03-MG{PS:CH2B}I:Sp1-SP';'SR:C03-MG{PS:CH1B}I:Sp1-SP';'SR:C04-MG{PS:CH1A}I:Sp1-SP';'SR:C04-MG{PS:CH2A}I:Sp1-SP';'SR:C04-MG{PS:CM1A}I:Sp1-SP';'SR:C04-MG{PS:CM1B}I:Sp1-SP';'SR:C04-MG{PS:CL2B}I:Sp1-SP';'SR:C04-MG{PS:CL1B}I:Sp1-SP';'SR:C05-MG{PS:CL1A}I:Sp1-SP';'SR:C05-MG{PS:CL2A}I:Sp1-SP';'SR:C05-MG{PS:CM1A}I:Sp1-SP';'SR:C05-MG{PS:CM1B}I:Sp1-SP';'SR:C05-MG{PS:CH2B}I:Sp1-SP';'SR:C05-MG{PS:CH1B}I:Sp1-SP';'SR:C06-MG{PS:CH1A}I:Sp1-SP';'SR:C06-MG{PS:CH2A}I:Sp1-SP';'SR:C06-MG{PS:CM1A}I:Sp1-SP';'SR:C06-MG{PS:CM1B}I:Sp1-SP';'SR:C06-MG{PS:CL2B}I:Sp1-SP';'SR:C06-MG{PS:CL1B}I:Sp1-SP';'SR:C07-MG{PS:CL1A}I:Sp1-SP';'SR:C07-MG{PS:CL2A}I:Sp1-SP';'SR:C07-MG{PS:CM1A}I:Sp1-SP';'SR:C07-MG{PS:CM1B}I:Sp1-SP';'SR:C07-MG{PS:CH2B}I:Sp1-SP';'SR:C07-MG{PS:CH1B}I:Sp1-SP';'SR:C08-MG{PS:CH1A}I:Sp1-SP';'SR:C08-MG{PS:CH2A}I:Sp1-SP';'SR:C08-MG{PS:CM1A}I:Sp1-SP';'SR:C08-MG{PS:CM1B}I:Sp1-SP';'SR:C08-MG{PS:CL2B}I:Sp1-SP';'SR:C08-MG{PS:CL1B}I:Sp1-SP';'SR:C09-MG{PS:CL1A}I:Sp1-SP';'SR:C09-MG{PS:CL2A}I:Sp1-SP';'SR:C09-MG{PS:CM1A}I:Sp1-SP';'SR:C09-MG{PS:CM1B}I:Sp1-SP';'SR:C09-MG{PS:CH2B}I:Sp1-SP';'SR:C09-MG{PS:CH1B}I:Sp1-SP';'SR:C10-MG{PS:CH1A}I:Sp1-SP';'SR:C10-MG{PS:CH2A}I:Sp1-SP';'SR:C10-MG{PS:CM1A}I:Sp1-SP';'SR:C10-MG{PS:CM1B}I:Sp1-SP';'SR:C10-MG{PS:CL2B}I:Sp1-SP';'SR:C10-MG{PS:CL1B}I:Sp1-SP';'SR:C11-MG{PS:CL1A}I:Sp1-SP';'SR:C11-MG{PS:CL2A}I:Sp1-SP';'SR:C11-MG{PS:CM1A}I:Sp1-SP';'SR:C11-MG{PS:CM1B}I:Sp1-SP';'SR:C11-MG{PS:CH2B}I:Sp1-SP';'SR:C11-MG{PS:CH1B}I:Sp1-SP';'SR:C12-MG{PS:CH1A}I:Sp1-SP';'SR:C12-MG{PS:CH2A}I:Sp1-SP';'SR:C12-MG{PS:CM1A}I:Sp1-SP';'SR:C12-MG{PS:CM1B}I:Sp1-SP';'SR:C12-MG{PS:CL2B}I:Sp1-SP';'SR:C12-MG{PS:CL1B}I:Sp1-SP';'SR:C13-MG{PS:CL1A}I:Sp1-SP';'SR:C13-MG{PS:CL2A}I:Sp1-SP';'SR:C13-MG{PS:CM1A}I:Sp1-SP';'SR:C13-MG{PS:CM1B}I:Sp1-SP';'SR:C13-MG{PS:CH2B}I:Sp1-SP';'SR:C13-MG{PS:CH1B}I:Sp1-SP';'SR:C14-MG{PS:CH1A}I:Sp1-SP';'SR:C14-MG{PS:CH2A}I:Sp1-SP';'SR:C14-MG{PS:CM1A}I:Sp1-SP';'SR:C14-MG{PS:CM1B}I:Sp1-SP';'SR:C14-MG{PS:CL2B}I:Sp1-SP';'SR:C14-MG{PS:CL1B}I:Sp1-SP';'SR:C15-MG{PS:CL1A}I:Sp1-SP';'SR:C15-MG{PS:CL2A}I:Sp1-SP';'SR:C15-MG{PS:CM1A}I:Sp1-SP';'SR:C15-MG{PS:CM1B}I:Sp1-SP';'SR:C15-MG{PS:CH2B}I:Sp1-SP';'SR:C15-MG{PS:CH1B}I:Sp1-SP';'SR:C16-MG{PS:CH1A}I:Sp1-SP';'SR:C16-MG{PS:CH2A}I:Sp1-SP';'SR:C16-MG{PS:CM1A}I:Sp1-SP';'SR:C16-MG{PS:CM1B}I:Sp1-SP';'SR:C16-MG{PS:CL2B}I:Sp1-SP';'SR:C16-MG{PS:CL1B}I:Sp1-SP';'SR:C17-MG{PS:CL1A}I:Sp1-SP';'SR:C17-MG{PS:CL2A}I:Sp1-SP';'SR:C17-MG{PS:CM1A}I:Sp1-SP';'SR:C17-MG{PS:CM1B}I:Sp1-SP';'SR:C17-MG{PS:CH2B}I:Sp1-SP';'SR:C17-MG{PS:CH1B}I:Sp1-SP';'SR:C18-MG{PS:CH1A}I:Sp1-SP';'SR:C18-MG{PS:CH2A}I:Sp1-SP';'SR:C18-MG{PS:CM1A}I:Sp1-SP';'SR:C18-MG{PS:CM1B}I:Sp1-SP';'SR:C18-MG{PS:CL2B}I:Sp1-SP';'SR:C18-MG{PS:CL1B}I:Sp1-SP';'SR:C19-MG{PS:CL1A}I:Sp1-SP';'SR:C19-MG{PS:CL2A}I:Sp1-SP';'SR:C19-MG{PS:CM1A}I:Sp1-SP';'SR:C19-MG{PS:CM1B}I:Sp1-SP';'SR:C19-MG{PS:CH2B}I:Sp1-SP';'SR:C19-MG{PS:CH1B}I:Sp1-SP';'SR:C20-MG{PS:CH1A}I:Sp1-SP';'SR:C20-MG{PS:CH2A}I:Sp1-SP';'SR:C20-MG{PS:CM1A}I:Sp1-SP';'SR:C20-MG{PS:CM1B}I:Sp1-SP';'SR:C20-MG{PS:CL2B}I:Sp1-SP';'SR:C20-MG{PS:CL1B}I:Sp1-SP';'SR:C21-MG{PS:CL1A}I:Sp1-SP';'SR:C21-MG{PS:CL2A}I:Sp1-SP';'SR:C21-MG{PS:CM1A}I:Sp1-SP';'SR:C21-MG{PS:CM1B}I:Sp1-SP';'SR:C21-MG{PS:CH2B}I:Sp1-SP';'SR:C21-MG{PS:CH1B}I:Sp1-SP';'SR:C22-MG{PS:CH1A}I:Sp1-SP';'SR:C22-MG{PS:CH2A}I:Sp1-SP';'SR:C22-MG{PS:CM1A}I:Sp1-SP';'SR:C22-MG{PS:CM1B}I:Sp1-SP';'SR:C22-MG{PS:CL2B}I:Sp1-SP';'SR:C22-MG{PS:CL1B}I:Sp1-SP';'SR:C23-MG{PS:CL1A}I:Sp1-SP';'SR:C23-MG{PS:CL2A}I:Sp1-SP';'SR:C23-MG{PS:CM1A}I:Sp1-SP';'SR:C23-MG{PS:CM1B}I:Sp1-SP';'SR:C23-MG{PS:CH2B}I:Sp1-SP';'SR:C23-MG{PS:CH1B}I:Sp1-SP';'SR:C24-MG{PS:CH1A}I:Sp1-SP';'SR:C24-MG{PS:CH2A}I:Sp1-SP';'SR:C24-MG{PS:CM1A}I:Sp1-SP';'SR:C24-MG{PS:CM1B}I:Sp1-SP';'SR:C24-MG{PS:CL2B}I:Sp1-SP';'SR:C24-MG{PS:CL1B}I:Sp1-SP';'SR:C25-MG{PS:CL1A}I:Sp1-SP';'SR:C25-MG{PS:CL2A}I:Sp1-SP';'SR:C25-MG{PS:CM1A}I:Sp1-SP';'SR:C25-MG{PS:CM1B}I:Sp1-SP';'SR:C25-MG{PS:CH2B}I:Sp1-SP';'SR:C25-MG{PS:CH1B}I:Sp1-SP';'SR:C26-MG{PS:CH1A}I:Sp1-SP';'SR:C26-MG{PS:CH2A}I:Sp1-SP';'SR:C26-MG{PS:CM1A}I:Sp1-SP';'SR:C26-MG{PS:CM1B}I:Sp1-SP';'SR:C26-MG{PS:CL2B}I:Sp1-SP';'SR:C26-MG{PS:CL1B}I:Sp1-SP';'SR:C27-MG{PS:CL1A}I:Sp1-SP';'SR:C27-MG{PS:CL2A}I:Sp1-SP';'SR:C27-MG{PS:CM1A}I:Sp1-SP';'SR:C27-MG{PS:CM1B}I:Sp1-SP';'SR:C27-MG{PS:CH2B}I:Sp1-SP';'SR:C27-MG{PS:CH1B}I:Sp1-SP';'SR:C28-MG{PS:CH1A}I:Sp1-SP';'SR:C28-MG{PS:CH2A}I:Sp1-SP';'SR:C28-MG{PS:CM1A}I:Sp1-SP';'SR:C28-MG{PS:CM1B}I:Sp1-SP';'SR:C28-MG{PS:CL2B}I:Sp1-SP';'SR:C28-MG{PS:CL1B}I:Sp1-SP';'SR:C29-MG{PS:CL1A}I:Sp1-SP';'SR:C29-MG{PS:CL2A}I:Sp1-SP';'SR:C29-MG{PS:CM1A}I:Sp1-SP';'SR:C29-MG{PS:CM1B}I:Sp1-SP';'SR:C29-MG{PS:CH2B}I:Sp1-SP';'SR:C29-MG{PS:CH1B}I:Sp1-SP' ];
AO.HCM.Setpoint.Units         = 'Hardware';
AO.HCM.Setpoint.HWUnits       = 'A';
AO.HCM.Setpoint.PhysicsUnits  = 'rad';
% AO.HCM.Setpoint.HW2PhysicsFcn = @amp2k;
% AO.HCM.Setpoint.Physics2HWFcn = @k2amp;
% HCM kick setpoint
AO.HCM.SPKL.MemberOf   = {'PlotFamily'; 'COR'; 'HCM'; 'Magnet';'Setpoint'};
AO.HCM.SPKL.Mode = OperationalMode;
AO.HCM.SPKL.DataType = 'Scalar';
AO.HCM.SPKL.ChannelNames  = [ 'SR:C30-MG{PS:CH1A}K:Sp1-SP';'SR:C30-MG{PS:CH2A}K:Sp1-SP';'SR:C30-MG{PS:CM1A}K:Sp1-SP';'SR:C30-MG{PS:CM1B}K:Sp1-SP';'SR:C30-MG{PS:CL2B}K:Sp1-SP';'SR:C30-MG{PS:CL1B}K:Sp1-SP';'SR:C01-MG{PS:CL1A}K:Sp1-SP';'SR:C01-MG{PS:CL2A}K:Sp1-SP';'SR:C01-MG{PS:CM1A}K:Sp1-SP';'SR:C01-MG{PS:CM1B}K:Sp1-SP';'SR:C01-MG{PS:CH2B}K:Sp1-SP';'SR:C01-MG{PS:CH1B}K:Sp1-SP';'SR:C02-MG{PS:CH1A}K:Sp1-SP';'SR:C02-MG{PS:CH2A}K:Sp1-SP';'SR:C02-MG{PS:CM1A}K:Sp1-SP';'SR:C02-MG{PS:CM1B}K:Sp1-SP';'SR:C02-MG{PS:CL2B}K:Sp1-SP';'SR:C02-MG{PS:CL1B}K:Sp1-SP';'SR:C03-MG{PS:CL1A}K:Sp1-SP';'SR:C03-MG{PS:CL2A}K:Sp1-SP';'SR:C03-MG{PS:CM1A}K:Sp1-SP';'SR:C03-MG{PS:CM1B}K:Sp1-SP';'SR:C03-MG{PS:CH2B}K:Sp1-SP';'SR:C03-MG{PS:CH1B}K:Sp1-SP';'SR:C04-MG{PS:CH1A}K:Sp1-SP';'SR:C04-MG{PS:CH2A}K:Sp1-SP';'SR:C04-MG{PS:CM1A}K:Sp1-SP';'SR:C04-MG{PS:CM1B}K:Sp1-SP';'SR:C04-MG{PS:CL2B}K:Sp1-SP';'SR:C04-MG{PS:CL1B}K:Sp1-SP';'SR:C05-MG{PS:CL1A}K:Sp1-SP';'SR:C05-MG{PS:CL2A}K:Sp1-SP';'SR:C05-MG{PS:CM1A}K:Sp1-SP';'SR:C05-MG{PS:CM1B}K:Sp1-SP';'SR:C05-MG{PS:CH2B}K:Sp1-SP';'SR:C05-MG{PS:CH1B}K:Sp1-SP';'SR:C06-MG{PS:CH1A}K:Sp1-SP';'SR:C06-MG{PS:CH2A}K:Sp1-SP';'SR:C06-MG{PS:CM1A}K:Sp1-SP';'SR:C06-MG{PS:CM1B}K:Sp1-SP';'SR:C06-MG{PS:CL2B}K:Sp1-SP';'SR:C06-MG{PS:CL1B}K:Sp1-SP';'SR:C07-MG{PS:CL1A}K:Sp1-SP';'SR:C07-MG{PS:CL2A}K:Sp1-SP';'SR:C07-MG{PS:CM1A}K:Sp1-SP';'SR:C07-MG{PS:CM1B}K:Sp1-SP';'SR:C07-MG{PS:CH2B}K:Sp1-SP';'SR:C07-MG{PS:CH1B}K:Sp1-SP';'SR:C08-MG{PS:CH1A}K:Sp1-SP';'SR:C08-MG{PS:CH2A}K:Sp1-SP';'SR:C08-MG{PS:CM1A}K:Sp1-SP';'SR:C08-MG{PS:CM1B}K:Sp1-SP';'SR:C08-MG{PS:CL2B}K:Sp1-SP';'SR:C08-MG{PS:CL1B}K:Sp1-SP';'SR:C09-MG{PS:CL1A}K:Sp1-SP';'SR:C09-MG{PS:CL2A}K:Sp1-SP';'SR:C09-MG{PS:CM1A}K:Sp1-SP';'SR:C09-MG{PS:CM1B}K:Sp1-SP';'SR:C09-MG{PS:CH2B}K:Sp1-SP';'SR:C09-MG{PS:CH1B}K:Sp1-SP';'SR:C10-MG{PS:CH1A}K:Sp1-SP';'SR:C10-MG{PS:CH2A}K:Sp1-SP';'SR:C10-MG{PS:CM1A}K:Sp1-SP';'SR:C10-MG{PS:CM1B}K:Sp1-SP';'SR:C10-MG{PS:CL2B}K:Sp1-SP';'SR:C10-MG{PS:CL1B}K:Sp1-SP';'SR:C11-MG{PS:CL1A}K:Sp1-SP';'SR:C11-MG{PS:CL2A}K:Sp1-SP';'SR:C11-MG{PS:CM1A}K:Sp1-SP';'SR:C11-MG{PS:CM1B}K:Sp1-SP';'SR:C11-MG{PS:CH2B}K:Sp1-SP';'SR:C11-MG{PS:CH1B}K:Sp1-SP';'SR:C12-MG{PS:CH1A}K:Sp1-SP';'SR:C12-MG{PS:CH2A}K:Sp1-SP';'SR:C12-MG{PS:CM1A}K:Sp1-SP';'SR:C12-MG{PS:CM1B}K:Sp1-SP';'SR:C12-MG{PS:CL2B}K:Sp1-SP';'SR:C12-MG{PS:CL1B}K:Sp1-SP';'SR:C13-MG{PS:CL1A}K:Sp1-SP';'SR:C13-MG{PS:CL2A}K:Sp1-SP';'SR:C13-MG{PS:CM1A}K:Sp1-SP';'SR:C13-MG{PS:CM1B}K:Sp1-SP';'SR:C13-MG{PS:CH2B}K:Sp1-SP';'SR:C13-MG{PS:CH1B}K:Sp1-SP';'SR:C14-MG{PS:CH1A}K:Sp1-SP';'SR:C14-MG{PS:CH2A}K:Sp1-SP';'SR:C14-MG{PS:CM1A}K:Sp1-SP';'SR:C14-MG{PS:CM1B}K:Sp1-SP';'SR:C14-MG{PS:CL2B}K:Sp1-SP';'SR:C14-MG{PS:CL1B}K:Sp1-SP';'SR:C15-MG{PS:CL1A}K:Sp1-SP';'SR:C15-MG{PS:CL2A}K:Sp1-SP';'SR:C15-MG{PS:CM1A}K:Sp1-SP';'SR:C15-MG{PS:CM1B}K:Sp1-SP';'SR:C15-MG{PS:CH2B}K:Sp1-SP';'SR:C15-MG{PS:CH1B}K:Sp1-SP';'SR:C16-MG{PS:CH1A}K:Sp1-SP';'SR:C16-MG{PS:CH2A}K:Sp1-SP';'SR:C16-MG{PS:CM1A}K:Sp1-SP';'SR:C16-MG{PS:CM1B}K:Sp1-SP';'SR:C16-MG{PS:CL2B}K:Sp1-SP';'SR:C16-MG{PS:CL1B}K:Sp1-SP';'SR:C17-MG{PS:CL1A}K:Sp1-SP';'SR:C17-MG{PS:CL2A}K:Sp1-SP';'SR:C17-MG{PS:CM1A}K:Sp1-SP';'SR:C17-MG{PS:CM1B}K:Sp1-SP';'SR:C17-MG{PS:CH2B}K:Sp1-SP';'SR:C17-MG{PS:CH1B}K:Sp1-SP';'SR:C18-MG{PS:CH1A}K:Sp1-SP';'SR:C18-MG{PS:CH2A}K:Sp1-SP';'SR:C18-MG{PS:CM1A}K:Sp1-SP';'SR:C18-MG{PS:CM1B}K:Sp1-SP';'SR:C18-MG{PS:CL2B}K:Sp1-SP';'SR:C18-MG{PS:CL1B}K:Sp1-SP';'SR:C19-MG{PS:CL1A}K:Sp1-SP';'SR:C19-MG{PS:CL2A}K:Sp1-SP';'SR:C19-MG{PS:CM1A}K:Sp1-SP';'SR:C19-MG{PS:CM1B}K:Sp1-SP';'SR:C19-MG{PS:CH2B}K:Sp1-SP';'SR:C19-MG{PS:CH1B}K:Sp1-SP';'SR:C20-MG{PS:CH1A}K:Sp1-SP';'SR:C20-MG{PS:CH2A}K:Sp1-SP';'SR:C20-MG{PS:CM1A}K:Sp1-SP';'SR:C20-MG{PS:CM1B}K:Sp1-SP';'SR:C20-MG{PS:CL2B}K:Sp1-SP';'SR:C20-MG{PS:CL1B}K:Sp1-SP';'SR:C21-MG{PS:CL1A}K:Sp1-SP';'SR:C21-MG{PS:CL2A}K:Sp1-SP';'SR:C21-MG{PS:CM1A}K:Sp1-SP';'SR:C21-MG{PS:CM1B}K:Sp1-SP';'SR:C21-MG{PS:CH2B}K:Sp1-SP';'SR:C21-MG{PS:CH1B}K:Sp1-SP';'SR:C22-MG{PS:CH1A}K:Sp1-SP';'SR:C22-MG{PS:CH2A}K:Sp1-SP';'SR:C22-MG{PS:CM1A}K:Sp1-SP';'SR:C22-MG{PS:CM1B}K:Sp1-SP';'SR:C22-MG{PS:CL2B}K:Sp1-SP';'SR:C22-MG{PS:CL1B}K:Sp1-SP';'SR:C23-MG{PS:CL1A}K:Sp1-SP';'SR:C23-MG{PS:CL2A}K:Sp1-SP';'SR:C23-MG{PS:CM1A}K:Sp1-SP';'SR:C23-MG{PS:CM1B}K:Sp1-SP';'SR:C23-MG{PS:CH2B}K:Sp1-SP';'SR:C23-MG{PS:CH1B}K:Sp1-SP';'SR:C24-MG{PS:CH1A}K:Sp1-SP';'SR:C24-MG{PS:CH2A}K:Sp1-SP';'SR:C24-MG{PS:CM1A}K:Sp1-SP';'SR:C24-MG{PS:CM1B}K:Sp1-SP';'SR:C24-MG{PS:CL2B}K:Sp1-SP';'SR:C24-MG{PS:CL1B}K:Sp1-SP';'SR:C25-MG{PS:CL1A}K:Sp1-SP';'SR:C25-MG{PS:CL2A}K:Sp1-SP';'SR:C25-MG{PS:CM1A}K:Sp1-SP';'SR:C25-MG{PS:CM1B}K:Sp1-SP';'SR:C25-MG{PS:CH2B}K:Sp1-SP';'SR:C25-MG{PS:CH1B}K:Sp1-SP';'SR:C26-MG{PS:CH1A}K:Sp1-SP';'SR:C26-MG{PS:CH2A}K:Sp1-SP';'SR:C26-MG{PS:CM1A}K:Sp1-SP';'SR:C26-MG{PS:CM1B}K:Sp1-SP';'SR:C26-MG{PS:CL2B}K:Sp1-SP';'SR:C26-MG{PS:CL1B}K:Sp1-SP';'SR:C27-MG{PS:CL1A}K:Sp1-SP';'SR:C27-MG{PS:CL2A}K:Sp1-SP';'SR:C27-MG{PS:CM1A}K:Sp1-SP';'SR:C27-MG{PS:CM1B}K:Sp1-SP';'SR:C27-MG{PS:CH2B}K:Sp1-SP';'SR:C27-MG{PS:CH1B}K:Sp1-SP';'SR:C28-MG{PS:CH1A}K:Sp1-SP';'SR:C28-MG{PS:CH2A}K:Sp1-SP';'SR:C28-MG{PS:CM1A}K:Sp1-SP';'SR:C28-MG{PS:CM1B}K:Sp1-SP';'SR:C28-MG{PS:CL2B}K:Sp1-SP';'SR:C28-MG{PS:CL1B}K:Sp1-SP';'SR:C29-MG{PS:CL1A}K:Sp1-SP';'SR:C29-MG{PS:CL2A}K:Sp1-SP';'SR:C29-MG{PS:CM1A}K:Sp1-SP';'SR:C29-MG{PS:CM1B}K:Sp1-SP';'SR:C29-MG{PS:CH2B}K:Sp1-SP';'SR:C29-MG{PS:CH1B}K:Sp1-SP' ];
AO.HCM.SPKL.Units = 'Hardware';
AO.HCM.SPKL.HWUnits     = 'rad';
% HCM kick readback
AO.HCM.RBKL.MemberOf   = {'PlotFamily'; 'COR'; 'HCM'; 'Magnet';'Readback'};
AO.HCM.RBKL.Mode = OperationalMode;
AO.HCM.RBKL.DataType = 'Scalar';
AO.HCM.RBKL.ChannelNames  = [ 'SR:C30-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C30-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C30-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C30-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C30-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C30-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C01-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C01-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C01-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C01-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C01-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C01-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C02-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C02-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C02-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C02-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C02-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C02-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C03-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C03-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C03-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C03-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C03-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C03-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C04-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C04-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C04-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C04-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C04-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C04-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C05-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C05-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C05-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C05-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C05-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C05-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C06-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C06-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C06-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C06-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C06-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C06-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C07-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C07-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C07-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C07-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C07-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C07-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C08-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C08-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C08-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C08-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C08-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C08-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C09-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C09-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C09-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C09-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C09-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C09-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C10-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C10-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C10-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C10-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C10-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C10-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C11-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C11-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C11-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C11-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C11-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C11-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C12-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C12-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C12-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C12-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C12-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C12-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C13-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C13-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C13-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C13-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C13-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C13-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C14-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C14-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C14-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C14-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C14-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C14-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C15-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C15-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C15-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C15-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C15-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C15-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C16-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C16-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C16-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C16-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C16-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C16-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C17-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C17-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C17-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C17-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C17-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C17-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C18-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C18-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C18-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C18-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C18-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C18-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C19-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C19-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C19-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C19-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C19-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C19-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C20-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C20-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C20-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C20-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C20-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C20-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C21-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C21-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C21-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C21-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C21-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C21-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C22-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C22-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C22-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C22-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C22-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C22-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C23-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C23-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C23-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C23-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C23-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C23-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C24-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C24-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C24-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C24-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C24-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C24-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C25-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C25-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C25-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C25-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C25-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C25-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C26-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C26-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C26-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C26-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C26-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C26-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C27-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C27-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C27-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C27-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C27-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C27-MG{PS:CH1B}K:Ps1DCCT1-I';'SR:C28-MG{PS:CH1A}K:Ps1DCCT1-I';'SR:C28-MG{PS:CH2A}K:Ps1DCCT1-I';'SR:C28-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C28-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C28-MG{PS:CL2B}K:Ps1DCCT1-I';'SR:C28-MG{PS:CL1B}K:Ps1DCCT1-I';'SR:C29-MG{PS:CL1A}K:Ps1DCCT1-I';'SR:C29-MG{PS:CL2A}K:Ps1DCCT1-I';'SR:C29-MG{PS:CM1A}K:Ps1DCCT1-I';'SR:C29-MG{PS:CM1B}K:Ps1DCCT1-I';'SR:C29-MG{PS:CH2B}K:Ps1DCCT1-I';'SR:C29-MG{PS:CH1B}K:Ps1DCCT1-I' ];
AO.HCM.RBKL.Units = 'Hardware';
AO.HCM.RBKL.HWUnits     = 'rad';

AO.VCM.FamilyName             = 'VCM';
AO.VCM.MemberOf               = {'PlotFamily';  'COR'; 'VCM'; 'Magnet'};
AO.VCM.DeviceList =  [ 30 1; 30 2; 30 3; 30 4; 30 5; 30 6; 1 1; 1 2; 1 3; 1 4; 1 5; 1 6; 2 1; 2 2; 2 3; 2 4; 2 5; 2 6; 3 1; 3 2; 3 3; 3 4; 3 5; 3 6; 4 1; 4 2; 4 3; 4 4; 4 5; 4 6; 5 1; 5 2; 5 3; 5 4; 5 5; 5 6; 6 1; 6 2; 6 3; 6 4; 6 5; 6 6; 7 1; 7 2; 7 3; 7 4; 7 5; 7 6; 8 1; 8 2; 8 3; 8 4; 8 5; 8 6; 9 1; 9 2; 9 3; 9 4; 9 5; 9 6; 10 1; 10 2; 10 3; 10 4; 10 5; 10 6; 11 1; 11 2; 11 3; 11 4; 11 5; 11 6; 12 1; 12 2; 12 3; 12 4; 12 5; 12 6; 13 1; 13 2; 13 3; 13 4; 13 5; 13 6; 14 1; 14 2; 14 3; 14 4; 14 5; 14 6; 15 1; 15 2; 15 3; 15 4; 15 5; 15 6; 16 1; 16 2; 16 3; 16 4; 16 5; 16 6; 17 1; 17 2; 17 3; 17 4; 17 5; 17 6; 18 1; 18 2; 18 3; 18 4; 18 5; 18 6; 19 1; 19 2; 19 3; 19 4; 19 5; 19 6; 20 1; 20 2; 20 3; 20 4; 20 5; 20 6; 21 1; 21 2; 21 3; 21 4; 21 5; 21 6; 22 1; 22 2; 22 3; 22 4; 22 5; 22 6; 23 1; 23 2; 23 3; 23 4; 23 5; 23 6; 24 1; 24 2; 24 3; 24 4; 24 5; 24 6; 25 1; 25 2; 25 3; 25 4; 25 5; 25 6; 26 1; 26 2; 26 3; 26 4; 26 5; 26 6; 27 1; 27 2; 27 3; 27 4; 27 5; 27 6; 28 1; 28 2; 28 3; 28 4; 28 5; 28 6; 29 1; 29 2; 29 3; 29 4; 29 5; 29 6 ];
AO.VCM.ElementList = (1:size(AO.HCM.DeviceList,1))';
AO.VCM.Status = ones(size(AO.HCM.DeviceList,1),1);

AO.VCM.Monitor.Mode           = OperationalMode;
AO.VCM.Monitor.DataType       = 'Scalar';
AO.VCM.Monitor.ChannelNames   = [ 'SR:C30-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C30-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C30-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C30-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C30-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C30-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C01-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C01-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C01-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C01-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C01-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C01-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C02-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C02-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C02-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C02-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C02-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C02-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C03-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C03-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C03-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C03-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C03-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C03-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C04-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C04-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C04-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C04-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C04-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C04-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C05-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C05-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C05-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C05-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C05-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C05-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C06-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C06-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C06-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C06-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C06-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C06-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C07-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C07-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C07-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C07-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C07-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C07-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C08-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C08-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C08-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C08-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C08-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C08-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C09-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C09-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C09-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C09-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C09-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C09-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C10-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C10-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C10-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C10-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C10-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C10-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C11-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C11-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C11-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C11-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C11-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C11-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C12-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C12-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C12-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C12-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C12-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C12-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C13-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C13-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C13-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C13-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C13-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C13-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C14-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C14-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C14-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C14-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C14-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C14-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C15-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C15-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C15-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C15-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C15-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C15-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C16-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C16-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C16-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C16-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C16-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C16-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C17-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C17-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C17-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C17-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C17-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C17-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C18-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C18-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C18-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C18-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C18-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C18-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C19-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C19-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C19-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C19-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C19-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C19-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C20-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C20-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C20-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C20-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C20-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C20-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C21-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C21-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C21-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C21-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C21-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C21-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C22-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C22-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C22-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C22-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C22-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C22-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C23-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C23-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C23-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C23-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C23-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C23-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C24-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C24-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C24-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C24-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C24-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C24-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C25-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C25-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C25-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C25-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C25-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C25-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C26-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C26-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C26-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C26-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C26-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C26-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C27-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C27-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C27-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C27-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C27-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C27-MG{PS:CH1B}I:Ps2DCCT1-I';'SR:C28-MG{PS:CH1A}I:Ps2DCCT1-I';'SR:C28-MG{PS:CH2A}I:Ps2DCCT1-I';'SR:C28-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C28-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C28-MG{PS:CL2B}I:Ps2DCCT1-I';'SR:C28-MG{PS:CL1B}I:Ps2DCCT1-I';'SR:C29-MG{PS:CL1A}I:Ps2DCCT1-I';'SR:C29-MG{PS:CL2A}I:Ps2DCCT1-I';'SR:C29-MG{PS:CM1A}I:Ps2DCCT1-I';'SR:C29-MG{PS:CM1B}I:Ps2DCCT1-I';'SR:C29-MG{PS:CH2B}I:Ps2DCCT1-I';'SR:C29-MG{PS:CH1B}I:Ps2DCCT1-I' ];
AO.VCM.Monitor.Units          = 'Hardware';
AO.VCM.Monitor.HWUnits        = 'A';
AO.VCM.Monitor.PhysicsUnits   = 'rad';
% AO.VCM.Monitor.HW2PhysicsFcn  = @amp2k;
% AO.VCM.Monitor.Physics2HWFcn  = @k2amp;
AO.VCM.CommonNames =  ['ch1g2c30a';  'ch2g2c30a';  'cm1g4c30a';  'cm1g4c30b';  'cl2g6c30b';  'cl1g6c30b';  'cl1g2c01a'; 'cl2g2c01a';  'cm1g4c01a';  'cm1g4c01b';  'ch2g6c01b';  'ch1g6c01b';  'ch1g2c02a';  'ch2g2c02a';  'cm1g4c02a';  'cm1g4c02b';  'cl2g6c02b';  'cl1g6c02b';  'cl1g2c03a';  'cl2g2c03a';  'cm1g4c03a';  'cm1g4c03b';  'ch2g6c03b';  'ch1g6c03b'; 'ch1g2c04a'; 'ch2g2c04a';  'cm1g4c04a';  'cm1g4c04b';  'cl2g6c04b';  'cl1g6c04b';  'cl1g2c05a';  'cl2g2c05a';  'cm1g4c05a';  'cm1g4c05b';  'ch2g6c05b';  'ch1g6c05b';  'ch1g2c06a';  'ch2g2c06a';  'cm1g4c06a';  'cm1g4c06b';  'cl2g6c06b';  'cl1g6c06b';  'cl1g2c07a';  'cl2g2c07a';  'cm1g4c07a';  'cm1g4c07b';  'ch2g6c07b';  'ch1g6c07b';  'ch1g2c08a';  'ch2g2c08a';  'cm1g4c08a';  'cm1g4c08b';  'cl2g6c08b';  'cl1g6c08b';  'cl1g2c09a';  'cl2g2c09a';  'cm1g4c09a';  'cm1g4c09b';  'ch2g6c09b';  'ch1g6c09b';  'ch1g2c10a';  'ch2g2c10a';  'cm1g4c10a';  'cm1g4c10b';  'cl2g6c10b';  'cl1g6c10b';  'cl1g2c11a';  'cl2g2c11a';  'cm1g4c11a';  'cm1g4c11b';  'ch2g6c11b';  'ch1g6c11b';  'ch1g2c12a';  'ch2g2c12a';  'cm1g4c12a';  'cm1g4c12b';  'cl2g6c12b';  'cl1g6c12b';  'cl1g2c13a';  'cl2g2c13a';  'cm1g4c13a';  'cm1g4c13b';  'ch2g6c13b';  'ch1g6c13b';  'ch1g2c14a';  'ch2g2c14a';  'cm1g4c14a';  'cm1g4c14b';  'cl2g6c14b';  'cl1g6c14b';  'cl1g2c15a';  'cl2g2c15a';  'cm1g4c15a';  'cm1g4c15b';  'ch2g6c15b';  'ch1g6c15b';  'ch1g2c16a';  'ch2g2c16a';  'cm1g4c16a';  'cm1g4c16b';  'cl2g6c16b';  'cl1g6c16b';  'cl1g2c17a';  'cl2g2c17a';  'cm1g4c17a';  'cm1g4c17b';  'ch2g6c17b';  'ch1g6c17b';  'ch1g2c18a';  'ch2g2c18a';  'cm1g4c18a'; 'cm1g4c18b'; 'cl2g6c18b'; 'cl1g6c18b'; 'cl1g2c19a'; 'cl2g2c19a'; 'cm1g4c19a'; 'cm1g4c19b'; 'ch2g6c19b'; 'ch1g6c19b'; 'ch1g2c20a'; 'ch2g2c20a'; 'cm1g4c20a'; 'cm1g4c20b'; 'cl2g6c20b'; 'cl1g6c20b'; 'cl1g2c21a'; 'cl2g2c21a'; 'cm1g4c21a'; 'cm1g4c21b'; 'ch2g6c21b'; 'ch1g6c21b'; 'ch1g2c22a'; 'ch2g2c22a'; 'cm1g4c22a'; 'cm1g4c22b'; 'cl2g6c22b'; 'cl1g6c22b'; 'cl1g2c23a'; 'cl2g2c23a'; 'cm1g4c23a'; 'cm1g4c23b'; 'ch2g6c23b'; 'ch1g6c23b'; 'ch1g2c24a'; 'ch2g2c24a'; 'cm1g4c24a'; 'cm1g4c24b'; 'cl2g6c24b'; 'cl1g6c24b'; 'cl1g2c25a'; 'cl2g2c25a'; 'cm1g4c25a'; 'cm1g4c25b'; 'ch2g6c25b'; 'ch1g6c25b'; 'ch1g2c26a'; 'ch2g2c26a'; 'cm1g4c26a'; 'cm1g4c26b'; 'cl2g6c26b'; 'cl1g6c26b'; 'cl1g2c27a'; 'cl2g2c27a'; 'cm1g4c27a'; 'cm1g4c27b'; 'ch2g6c27b'; 'ch1g6c27b'; 'ch1g2c28a'; 'ch2g2c28a'; 'cm1g4c28a'; 'cm1g4c28b'; 'cl2g6c28b'; 'cl1g6c28b'; 'cl1g2c29a'; 'cl2g2c29a'; 'cm1g4c29a'; 'cm1g4c29b'; 'ch2g6c29b'; 'ch1g6c29b'];
AO.VCM.Setpoint.MemberOf      = {'PlotFamily'; 'Save/Restore'; 'COR'; 'Vertical'; 'VCM'; 'Magnet'; 'Setpoint'; 'measbpmresp';};
AO.VCM.Setpoint.Mode          = OperationalMode;
AO.VCM.Setpoint.DataType      = 'Scalar';
AO.VCM.Setpoint.ChannelNames  = ['SR:C30-MG{PS:CH1A}I:Sp2-SP';'SR:C30-MG{PS:CH2A}I:Sp2-SP';'SR:C30-MG{PS:CM1A}I:Sp2-SP';'SR:C30-MG{PS:CM1B}I:Sp2-SP';'SR:C30-MG{PS:CL2B}I:Sp2-SP';'SR:C30-MG{PS:CL1B}I:Sp2-SP';'SR:C01-MG{PS:CL1A}I:Sp2-SP';'SR:C01-MG{PS:CL2A}I:Sp2-SP';'SR:C01-MG{PS:CM1A}I:Sp2-SP';'SR:C01-MG{PS:CM1B}I:Sp2-SP';'SR:C01-MG{PS:CH2B}I:Sp2-SP';'SR:C01-MG{PS:CH1B}I:Sp2-SP';'SR:C02-MG{PS:CH1A}I:Sp2-SP';'SR:C02-MG{PS:CH2A}I:Sp2-SP';'SR:C02-MG{PS:CM1A}I:Sp2-SP';'SR:C02-MG{PS:CM1B}I:Sp2-SP';'SR:C02-MG{PS:CL2B}I:Sp2-SP';'SR:C02-MG{PS:CL1B}I:Sp2-SP';'SR:C03-MG{PS:CL1A}I:Sp2-SP';'SR:C03-MG{PS:CL2A}I:Sp2-SP';'SR:C03-MG{PS:CM1A}I:Sp2-SP';'SR:C03-MG{PS:CM1B}I:Sp2-SP';'SR:C03-MG{PS:CH2B}I:Sp2-SP';'SR:C03-MG{PS:CH1B}I:Sp2-SP';'SR:C04-MG{PS:CH1A}I:Sp2-SP';'SR:C04-MG{PS:CH2A}I:Sp2-SP';'SR:C04-MG{PS:CM1A}I:Sp2-SP';'SR:C04-MG{PS:CM1B}I:Sp2-SP';'SR:C04-MG{PS:CL2B}I:Sp2-SP';'SR:C04-MG{PS:CL1B}I:Sp2-SP';'SR:C05-MG{PS:CL1A}I:Sp2-SP';'SR:C05-MG{PS:CL2A}I:Sp2-SP';'SR:C05-MG{PS:CM1A}I:Sp2-SP';'SR:C05-MG{PS:CM1B}I:Sp2-SP';'SR:C05-MG{PS:CH2B}I:Sp2-SP';'SR:C05-MG{PS:CH1B}I:Sp2-SP';'SR:C06-MG{PS:CH1A}I:Sp2-SP';'SR:C06-MG{PS:CH2A}I:Sp2-SP';'SR:C06-MG{PS:CM1A}I:Sp2-SP';'SR:C06-MG{PS:CM1B}I:Sp2-SP';'SR:C06-MG{PS:CL2B}I:Sp2-SP';'SR:C06-MG{PS:CL1B}I:Sp2-SP';'SR:C07-MG{PS:CL1A}I:Sp2-SP';'SR:C07-MG{PS:CL2A}I:Sp2-SP';'SR:C07-MG{PS:CM1A}I:Sp2-SP';'SR:C07-MG{PS:CM1B}I:Sp2-SP';'SR:C07-MG{PS:CH2B}I:Sp2-SP';'SR:C07-MG{PS:CH1B}I:Sp2-SP';'SR:C08-MG{PS:CH1A}I:Sp2-SP';'SR:C08-MG{PS:CH2A}I:Sp2-SP';'SR:C08-MG{PS:CM1A}I:Sp2-SP';'SR:C08-MG{PS:CM1B}I:Sp2-SP';'SR:C08-MG{PS:CL2B}I:Sp2-SP';'SR:C08-MG{PS:CL1B}I:Sp2-SP';'SR:C09-MG{PS:CL1A}I:Sp2-SP';'SR:C09-MG{PS:CL2A}I:Sp2-SP';'SR:C09-MG{PS:CM1A}I:Sp2-SP';'SR:C09-MG{PS:CM1B}I:Sp2-SP';'SR:C09-MG{PS:CH2B}I:Sp2-SP';'SR:C09-MG{PS:CH1B}I:Sp2-SP';'SR:C10-MG{PS:CH1A}I:Sp2-SP';'SR:C10-MG{PS:CH2A}I:Sp2-SP';'SR:C10-MG{PS:CM1A}I:Sp2-SP';'SR:C10-MG{PS:CM1B}I:Sp2-SP';'SR:C10-MG{PS:CL2B}I:Sp2-SP';'SR:C10-MG{PS:CL1B}I:Sp2-SP';'SR:C11-MG{PS:CL1A}I:Sp2-SP';'SR:C11-MG{PS:CL2A}I:Sp2-SP';'SR:C11-MG{PS:CM1A}I:Sp2-SP';'SR:C11-MG{PS:CM1B}I:Sp2-SP';'SR:C11-MG{PS:CH2B}I:Sp2-SP';'SR:C11-MG{PS:CH1B}I:Sp2-SP';'SR:C12-MG{PS:CH1A}I:Sp2-SP';'SR:C12-MG{PS:CH2A}I:Sp2-SP';'SR:C12-MG{PS:CM1A}I:Sp2-SP';'SR:C12-MG{PS:CM1B}I:Sp2-SP';'SR:C12-MG{PS:CL2B}I:Sp2-SP';'SR:C12-MG{PS:CL1B}I:Sp2-SP';'SR:C13-MG{PS:CL1A}I:Sp2-SP';'SR:C13-MG{PS:CL2A}I:Sp2-SP';'SR:C13-MG{PS:CM1A}I:Sp2-SP';'SR:C13-MG{PS:CM1B}I:Sp2-SP';'SR:C13-MG{PS:CH2B}I:Sp2-SP';'SR:C13-MG{PS:CH1B}I:Sp2-SP';'SR:C14-MG{PS:CH1A}I:Sp2-SP';'SR:C14-MG{PS:CH2A}I:Sp2-SP';'SR:C14-MG{PS:CM1A}I:Sp2-SP';'SR:C14-MG{PS:CM1B}I:Sp2-SP';'SR:C14-MG{PS:CL2B}I:Sp2-SP';'SR:C14-MG{PS:CL1B}I:Sp2-SP';'SR:C15-MG{PS:CL1A}I:Sp2-SP';'SR:C15-MG{PS:CL2A}I:Sp2-SP';'SR:C15-MG{PS:CM1A}I:Sp2-SP';'SR:C15-MG{PS:CM1B}I:Sp2-SP';'SR:C15-MG{PS:CH2B}I:Sp2-SP';'SR:C15-MG{PS:CH1B}I:Sp2-SP';'SR:C16-MG{PS:CH1A}I:Sp2-SP';'SR:C16-MG{PS:CH2A}I:Sp2-SP';'SR:C16-MG{PS:CM1A}I:Sp2-SP';'SR:C16-MG{PS:CM1B}I:Sp2-SP';'SR:C16-MG{PS:CL2B}I:Sp2-SP';'SR:C16-MG{PS:CL1B}I:Sp2-SP';'SR:C17-MG{PS:CL1A}I:Sp2-SP';'SR:C17-MG{PS:CL2A}I:Sp2-SP';'SR:C17-MG{PS:CM1A}I:Sp2-SP';'SR:C17-MG{PS:CM1B}I:Sp2-SP';'SR:C17-MG{PS:CH2B}I:Sp2-SP';'SR:C17-MG{PS:CH1B}I:Sp2-SP';'SR:C18-MG{PS:CH1A}I:Sp2-SP';'SR:C18-MG{PS:CH2A}I:Sp2-SP';'SR:C18-MG{PS:CM1A}I:Sp2-SP';'SR:C18-MG{PS:CM1B}I:Sp2-SP';'SR:C18-MG{PS:CL2B}I:Sp2-SP';'SR:C18-MG{PS:CL1B}I:Sp2-SP';'SR:C19-MG{PS:CL1A}I:Sp2-SP';'SR:C19-MG{PS:CL2A}I:Sp2-SP';'SR:C19-MG{PS:CM1A}I:Sp2-SP';'SR:C19-MG{PS:CM1B}I:Sp2-SP';'SR:C19-MG{PS:CH2B}I:Sp2-SP';'SR:C19-MG{PS:CH1B}I:Sp2-SP';'SR:C20-MG{PS:CH1A}I:Sp2-SP';'SR:C20-MG{PS:CH2A}I:Sp2-SP';'SR:C20-MG{PS:CM1A}I:Sp2-SP';'SR:C20-MG{PS:CM1B}I:Sp2-SP';'SR:C20-MG{PS:CL2B}I:Sp2-SP';'SR:C20-MG{PS:CL1B}I:Sp2-SP';'SR:C21-MG{PS:CL1A}I:Sp2-SP';'SR:C21-MG{PS:CL2A}I:Sp2-SP';'SR:C21-MG{PS:CM1A}I:Sp2-SP';'SR:C21-MG{PS:CM1B}I:Sp2-SP';'SR:C21-MG{PS:CH2B}I:Sp2-SP';'SR:C21-MG{PS:CH1B}I:Sp2-SP';'SR:C22-MG{PS:CH1A}I:Sp2-SP';'SR:C22-MG{PS:CH2A}I:Sp2-SP';'SR:C22-MG{PS:CM1A}I:Sp2-SP';'SR:C22-MG{PS:CM1B}I:Sp2-SP';'SR:C22-MG{PS:CL2B}I:Sp2-SP';'SR:C22-MG{PS:CL1B}I:Sp2-SP';'SR:C23-MG{PS:CL1A}I:Sp2-SP';'SR:C23-MG{PS:CL2A}I:Sp2-SP';'SR:C23-MG{PS:CM1A}I:Sp2-SP';'SR:C23-MG{PS:CM1B}I:Sp2-SP';'SR:C23-MG{PS:CH2B}I:Sp2-SP';'SR:C23-MG{PS:CH1B}I:Sp2-SP';'SR:C24-MG{PS:CH1A}I:Sp2-SP';'SR:C24-MG{PS:CH2A}I:Sp2-SP';'SR:C24-MG{PS:CM1A}I:Sp2-SP';'SR:C24-MG{PS:CM1B}I:Sp2-SP';'SR:C24-MG{PS:CL2B}I:Sp2-SP';'SR:C24-MG{PS:CL1B}I:Sp2-SP';'SR:C25-MG{PS:CL1A}I:Sp2-SP';'SR:C25-MG{PS:CL2A}I:Sp2-SP';'SR:C25-MG{PS:CM1A}I:Sp2-SP';'SR:C25-MG{PS:CM1B}I:Sp2-SP';'SR:C25-MG{PS:CH2B}I:Sp2-SP';'SR:C25-MG{PS:CH1B}I:Sp2-SP';'SR:C26-MG{PS:CH1A}I:Sp2-SP';'SR:C26-MG{PS:CH2A}I:Sp2-SP';'SR:C26-MG{PS:CM1A}I:Sp2-SP';'SR:C26-MG{PS:CM1B}I:Sp2-SP';'SR:C26-MG{PS:CL2B}I:Sp2-SP';'SR:C26-MG{PS:CL1B}I:Sp2-SP';'SR:C27-MG{PS:CL1A}I:Sp2-SP';'SR:C27-MG{PS:CL2A}I:Sp2-SP';'SR:C27-MG{PS:CM1A}I:Sp2-SP';'SR:C27-MG{PS:CM1B}I:Sp2-SP';'SR:C27-MG{PS:CH2B}I:Sp2-SP';'SR:C27-MG{PS:CH1B}I:Sp2-SP';'SR:C28-MG{PS:CH1A}I:Sp2-SP';'SR:C28-MG{PS:CH2A}I:Sp2-SP';'SR:C28-MG{PS:CM1A}I:Sp2-SP';'SR:C28-MG{PS:CM1B}I:Sp2-SP';'SR:C28-MG{PS:CL2B}I:Sp2-SP';'SR:C28-MG{PS:CL1B}I:Sp2-SP';'SR:C29-MG{PS:CL1A}I:Sp2-SP';'SR:C29-MG{PS:CL2A}I:Sp2-SP';'SR:C29-MG{PS:CM1A}I:Sp2-SP';'SR:C29-MG{PS:CM1B}I:Sp2-SP';'SR:C29-MG{PS:CH2B}I:Sp2-SP';'SR:C29-MG{PS:CH1B}I:Sp2-SP' ];
AO.VCM.Setpoint.Units         = 'Hardware';
AO.VCM.Setpoint.HWUnits       = 'A';
AO.VCM.Setpoint.PhysicsUnits  = 'rad';
% AO.VCM.Setpoint.HW2PhysicsFcn = @amp2k;
% AO.VCM.Setpoint.Physics2HWFcn = @k2amp;
% VCM kick setpoint
AO.VCM.SPKL.MemberOf   = {'PlotFamily'; 'COR'; 'VCM'; 'Magnet';'Setpoint'};
AO.VCM.SPKL.Mode = OperationalMode;
AO.VCM.SPKL.DataType = 'Scalar';
AO.VCM.SPKL.ChannelNames  = ['SR:C30-MG{PS:CH1A}K:Sp2-SP';'SR:C30-MG{PS:CH2A}K:Sp2-SP';'SR:C30-MG{PS:CM1A}K:Sp2-SP';'SR:C30-MG{PS:CM1B}K:Sp2-SP';'SR:C30-MG{PS:CL2B}K:Sp2-SP';'SR:C30-MG{PS:CL1B}K:Sp2-SP';'SR:C01-MG{PS:CL1A}K:Sp2-SP';'SR:C01-MG{PS:CL2A}K:Sp2-SP';'SR:C01-MG{PS:CM1A}K:Sp2-SP';'SR:C01-MG{PS:CM1B}K:Sp2-SP';'SR:C01-MG{PS:CH2B}K:Sp2-SP';'SR:C01-MG{PS:CH1B}K:Sp2-SP';'SR:C02-MG{PS:CH1A}K:Sp2-SP';'SR:C02-MG{PS:CH2A}K:Sp2-SP';'SR:C02-MG{PS:CM1A}K:Sp2-SP';'SR:C02-MG{PS:CM1B}K:Sp2-SP';'SR:C02-MG{PS:CL2B}K:Sp2-SP';'SR:C02-MG{PS:CL1B}K:Sp2-SP';'SR:C03-MG{PS:CL1A}K:Sp2-SP';'SR:C03-MG{PS:CL2A}K:Sp2-SP';'SR:C03-MG{PS:CM1A}K:Sp2-SP';'SR:C03-MG{PS:CM1B}K:Sp2-SP';'SR:C03-MG{PS:CH2B}K:Sp2-SP';'SR:C03-MG{PS:CH1B}K:Sp2-SP';'SR:C04-MG{PS:CH1A}K:Sp2-SP';'SR:C04-MG{PS:CH2A}K:Sp2-SP';'SR:C04-MG{PS:CM1A}K:Sp2-SP';'SR:C04-MG{PS:CM1B}K:Sp2-SP';'SR:C04-MG{PS:CL2B}K:Sp2-SP';'SR:C04-MG{PS:CL1B}K:Sp2-SP';'SR:C05-MG{PS:CL1A}K:Sp2-SP';'SR:C05-MG{PS:CL2A}K:Sp2-SP';'SR:C05-MG{PS:CM1A}K:Sp2-SP';'SR:C05-MG{PS:CM1B}K:Sp2-SP';'SR:C05-MG{PS:CH2B}K:Sp2-SP';'SR:C05-MG{PS:CH1B}K:Sp2-SP';'SR:C06-MG{PS:CH1A}K:Sp2-SP';'SR:C06-MG{PS:CH2A}K:Sp2-SP';'SR:C06-MG{PS:CM1A}K:Sp2-SP';'SR:C06-MG{PS:CM1B}K:Sp2-SP';'SR:C06-MG{PS:CL2B}K:Sp2-SP';'SR:C06-MG{PS:CL1B}K:Sp2-SP';'SR:C07-MG{PS:CL1A}K:Sp2-SP';'SR:C07-MG{PS:CL2A}K:Sp2-SP';'SR:C07-MG{PS:CM1A}K:Sp2-SP';'SR:C07-MG{PS:CM1B}K:Sp2-SP';'SR:C07-MG{PS:CH2B}K:Sp2-SP';'SR:C07-MG{PS:CH1B}K:Sp2-SP';'SR:C08-MG{PS:CH1A}K:Sp2-SP';'SR:C08-MG{PS:CH2A}K:Sp2-SP';'SR:C08-MG{PS:CM1A}K:Sp2-SP';'SR:C08-MG{PS:CM1B}K:Sp2-SP';'SR:C08-MG{PS:CL2B}K:Sp2-SP';'SR:C08-MG{PS:CL1B}K:Sp2-SP';'SR:C09-MG{PS:CL1A}K:Sp2-SP';'SR:C09-MG{PS:CL2A}K:Sp2-SP';'SR:C09-MG{PS:CM1A}K:Sp2-SP';'SR:C09-MG{PS:CM1B}K:Sp2-SP';'SR:C09-MG{PS:CH2B}K:Sp2-SP';'SR:C09-MG{PS:CH1B}K:Sp2-SP';'SR:C10-MG{PS:CH1A}K:Sp2-SP';'SR:C10-MG{PS:CH2A}K:Sp2-SP';'SR:C10-MG{PS:CM1A}K:Sp2-SP';'SR:C10-MG{PS:CM1B}K:Sp2-SP';'SR:C10-MG{PS:CL2B}K:Sp2-SP';'SR:C10-MG{PS:CL1B}K:Sp2-SP';'SR:C11-MG{PS:CL1A}K:Sp2-SP';'SR:C11-MG{PS:CL2A}K:Sp2-SP';'SR:C11-MG{PS:CM1A}K:Sp2-SP';'SR:C11-MG{PS:CM1B}K:Sp2-SP';'SR:C11-MG{PS:CH2B}K:Sp2-SP';'SR:C11-MG{PS:CH1B}K:Sp2-SP';'SR:C12-MG{PS:CH1A}K:Sp2-SP';'SR:C12-MG{PS:CH2A}K:Sp2-SP';'SR:C12-MG{PS:CM1A}K:Sp2-SP';'SR:C12-MG{PS:CM1B}K:Sp2-SP';'SR:C12-MG{PS:CL2B}K:Sp2-SP';'SR:C12-MG{PS:CL1B}K:Sp2-SP';'SR:C13-MG{PS:CL1A}K:Sp2-SP';'SR:C13-MG{PS:CL2A}K:Sp2-SP';'SR:C13-MG{PS:CM1A}K:Sp2-SP';'SR:C13-MG{PS:CM1B}K:Sp2-SP';'SR:C13-MG{PS:CH2B}K:Sp2-SP';'SR:C13-MG{PS:CH1B}K:Sp2-SP';'SR:C14-MG{PS:CH1A}K:Sp2-SP';'SR:C14-MG{PS:CH2A}K:Sp2-SP';'SR:C14-MG{PS:CM1A}K:Sp2-SP';'SR:C14-MG{PS:CM1B}K:Sp2-SP';'SR:C14-MG{PS:CL2B}K:Sp2-SP';'SR:C14-MG{PS:CL1B}K:Sp2-SP';'SR:C15-MG{PS:CL1A}K:Sp2-SP';'SR:C15-MG{PS:CL2A}K:Sp2-SP';'SR:C15-MG{PS:CM1A}K:Sp2-SP';'SR:C15-MG{PS:CM1B}K:Sp2-SP';'SR:C15-MG{PS:CH2B}K:Sp2-SP';'SR:C15-MG{PS:CH1B}K:Sp2-SP';'SR:C16-MG{PS:CH1A}K:Sp2-SP';'SR:C16-MG{PS:CH2A}K:Sp2-SP';'SR:C16-MG{PS:CM1A}K:Sp2-SP';'SR:C16-MG{PS:CM1B}K:Sp2-SP';'SR:C16-MG{PS:CL2B}K:Sp2-SP';'SR:C16-MG{PS:CL1B}K:Sp2-SP';'SR:C17-MG{PS:CL1A}K:Sp2-SP';'SR:C17-MG{PS:CL2A}K:Sp2-SP';'SR:C17-MG{PS:CM1A}K:Sp2-SP';'SR:C17-MG{PS:CM1B}K:Sp2-SP';'SR:C17-MG{PS:CH2B}K:Sp2-SP';'SR:C17-MG{PS:CH1B}K:Sp2-SP';'SR:C18-MG{PS:CH1A}K:Sp2-SP';'SR:C18-MG{PS:CH2A}K:Sp2-SP';'SR:C18-MG{PS:CM1A}K:Sp2-SP';'SR:C18-MG{PS:CM1B}K:Sp2-SP';'SR:C18-MG{PS:CL2B}K:Sp2-SP';'SR:C18-MG{PS:CL1B}K:Sp2-SP';'SR:C19-MG{PS:CL1A}K:Sp2-SP';'SR:C19-MG{PS:CL2A}K:Sp2-SP';'SR:C19-MG{PS:CM1A}K:Sp2-SP';'SR:C19-MG{PS:CM1B}K:Sp2-SP';'SR:C19-MG{PS:CH2B}K:Sp2-SP';'SR:C19-MG{PS:CH1B}K:Sp2-SP';'SR:C20-MG{PS:CH1A}K:Sp2-SP';'SR:C20-MG{PS:CH2A}K:Sp2-SP';'SR:C20-MG{PS:CM1A}K:Sp2-SP';'SR:C20-MG{PS:CM1B}K:Sp2-SP';'SR:C20-MG{PS:CL2B}K:Sp2-SP';'SR:C20-MG{PS:CL1B}K:Sp2-SP';'SR:C21-MG{PS:CL1A}K:Sp2-SP';'SR:C21-MG{PS:CL2A}K:Sp2-SP';'SR:C21-MG{PS:CM1A}K:Sp2-SP';'SR:C21-MG{PS:CM1B}K:Sp2-SP';'SR:C21-MG{PS:CH2B}K:Sp2-SP';'SR:C21-MG{PS:CH1B}K:Sp2-SP';'SR:C22-MG{PS:CH1A}K:Sp2-SP';'SR:C22-MG{PS:CH2A}K:Sp2-SP';'SR:C22-MG{PS:CM1A}K:Sp2-SP';'SR:C22-MG{PS:CM1B}K:Sp2-SP';'SR:C22-MG{PS:CL2B}K:Sp2-SP';'SR:C22-MG{PS:CL1B}K:Sp2-SP';'SR:C23-MG{PS:CL1A}K:Sp2-SP';'SR:C23-MG{PS:CL2A}K:Sp2-SP';'SR:C23-MG{PS:CM1A}K:Sp2-SP';'SR:C23-MG{PS:CM1B}K:Sp2-SP';'SR:C23-MG{PS:CH2B}K:Sp2-SP';'SR:C23-MG{PS:CH1B}K:Sp2-SP';'SR:C24-MG{PS:CH1A}K:Sp2-SP';'SR:C24-MG{PS:CH2A}K:Sp2-SP';'SR:C24-MG{PS:CM1A}K:Sp2-SP';'SR:C24-MG{PS:CM1B}K:Sp2-SP';'SR:C24-MG{PS:CL2B}K:Sp2-SP';'SR:C24-MG{PS:CL1B}K:Sp2-SP';'SR:C25-MG{PS:CL1A}K:Sp2-SP';'SR:C25-MG{PS:CL2A}K:Sp2-SP';'SR:C25-MG{PS:CM1A}K:Sp2-SP';'SR:C25-MG{PS:CM1B}K:Sp2-SP';'SR:C25-MG{PS:CH2B}K:Sp2-SP';'SR:C25-MG{PS:CH1B}K:Sp2-SP';'SR:C26-MG{PS:CH1A}K:Sp2-SP';'SR:C26-MG{PS:CH2A}K:Sp2-SP';'SR:C26-MG{PS:CM1A}K:Sp2-SP';'SR:C26-MG{PS:CM1B}K:Sp2-SP';'SR:C26-MG{PS:CL2B}K:Sp2-SP';'SR:C26-MG{PS:CL1B}K:Sp2-SP';'SR:C27-MG{PS:CL1A}K:Sp2-SP';'SR:C27-MG{PS:CL2A}K:Sp2-SP';'SR:C27-MG{PS:CM1A}K:Sp2-SP';'SR:C27-MG{PS:CM1B}K:Sp2-SP';'SR:C27-MG{PS:CH2B}K:Sp2-SP';'SR:C27-MG{PS:CH1B}K:Sp2-SP';'SR:C28-MG{PS:CH1A}K:Sp2-SP';'SR:C28-MG{PS:CH2A}K:Sp2-SP';'SR:C28-MG{PS:CM1A}K:Sp2-SP';'SR:C28-MG{PS:CM1B}K:Sp2-SP';'SR:C28-MG{PS:CL2B}K:Sp2-SP';'SR:C28-MG{PS:CL1B}K:Sp2-SP';'SR:C29-MG{PS:CL1A}K:Sp2-SP';'SR:C29-MG{PS:CL2A}K:Sp2-SP';'SR:C29-MG{PS:CM1A}K:Sp2-SP';'SR:C29-MG{PS:CM1B}K:Sp2-SP';'SR:C29-MG{PS:CH2B}K:Sp2-SP';'SR:C29-MG{PS:CH1B}K:Sp2-SP' ];
AO.VCM.SPKL.Units = 'Hardware';
AO.VCM.SPKL.HWUnits     = 'rad';
% VCM kick readback
AO.VCM.RBKL.MemberOf   = {'PlotFamily'; 'COR'; 'VCM'; 'Magnet';'Readback'};
AO.VCM.RBKL.Mode = OperationalMode;
AO.VCM.RBKL.DataType = 'Scalar';
AO.VCM.RBKL.ChannelNames  = [ 'SR:C30-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C30-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C30-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C30-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C30-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C30-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C01-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C01-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C01-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C01-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C01-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C01-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C02-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C02-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C02-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C02-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C02-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C02-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C03-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C03-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C03-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C03-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C03-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C03-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C04-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C04-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C04-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C04-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C04-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C04-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C05-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C05-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C05-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C05-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C05-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C05-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C06-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C06-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C06-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C06-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C06-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C06-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C07-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C07-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C07-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C07-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C07-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C07-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C08-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C08-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C08-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C08-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C08-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C08-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C09-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C09-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C09-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C09-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C09-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C09-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C10-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C10-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C10-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C10-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C10-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C10-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C11-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C11-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C11-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C11-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C11-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C11-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C12-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C12-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C12-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C12-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C12-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C12-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C13-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C13-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C13-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C13-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C13-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C13-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C14-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C14-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C14-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C14-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C14-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C14-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C15-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C15-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C15-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C15-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C15-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C15-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C16-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C16-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C16-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C16-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C16-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C16-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C17-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C17-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C17-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C17-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C17-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C17-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C18-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C18-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C18-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C18-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C18-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C18-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C19-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C19-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C19-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C19-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C19-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C19-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C20-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C20-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C20-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C20-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C20-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C20-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C21-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C21-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C21-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C21-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C21-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C21-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C22-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C22-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C22-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C22-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C22-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C22-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C23-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C23-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C23-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C23-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C23-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C23-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C24-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C24-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C24-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C24-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C24-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C24-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C25-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C25-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C25-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C25-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C25-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C25-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C26-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C26-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C26-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C26-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C26-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C26-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C27-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C27-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C27-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C27-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C27-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C27-MG{PS:CH1B}K:Ps2DCCT1-I';'SR:C28-MG{PS:CH1A}K:Ps2DCCT1-I';'SR:C28-MG{PS:CH2A}K:Ps2DCCT1-I';'SR:C28-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C28-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C28-MG{PS:CL2B}K:Ps2DCCT1-I';'SR:C28-MG{PS:CL1B}K:Ps2DCCT1-I';'SR:C29-MG{PS:CL1A}K:Ps2DCCT1-I';'SR:C29-MG{PS:CL2A}K:Ps2DCCT1-I';'SR:C29-MG{PS:CM1A}K:Ps2DCCT1-I';'SR:C29-MG{PS:CM1B}K:Ps2DCCT1-I';'SR:C29-MG{PS:CH2B}K:Ps2DCCT1-I';'SR:C29-MG{PS:CH1B}K:Ps2DCCT1-I' ];
AO.VCM.RBKL.Units = 'Hardware';
AO.VCM.RBKL.HWUnits     = 'rad';

CMrange = 18.0;   % [A]
CMHgain  = [4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05,4.55676469706508e-05,5.08638866404853e-05,4.54677179202766e-05,5.43614034035835e-05,5.51608358065773e-05,5.51608358065773e-05,4.54677179202766e-05,4.54677179202766e-05,4.55676469706508e-05,5.43614034035835e-05,5.43614034035835e-05,5.51608358065773e-05;]; 
CMVgain  = [5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05,5.52607648569516e-05,5.43614034035835e-05,5.51608358065773e-05,5.08638866404853e-05,4.54677179202766e-05,4.54677179202766e-05,5.51608358065773e-05,5.51608358065773e-05,5.52607648569516e-05,5.08638866404853e-05,5.08638866404853e-05,4.54677179202766e-05;];
RMkick  = 2*0.5;  % Kick size for orbit response matrix measurement [A]
CMtol   = 0.010;  % Tolerance [A]


for i=1:30 % number of superperiods
    for j=1:6 % six correctors per cell
        k=j+6*(i-1);
        AO.HCM.Setpoint.Range(k,:)            = [-CMrange CMrange];
        AO.VCM.Setpoint.Range(k,:)            = [-CMrange CMrange];
        AO.HCM.Setpoint.Tolerance(k,1)        = CMtol;
        AO.VCM.Setpoint.Tolerance(k,1)        = CMtol;
        AO.HCM.Setpoint.DeltaRespMat(k,1)     = RMkick;
        AO.VCM.Setpoint.DeltaRespMat(k,1)     = RMkick;
        AO.HCM.Monitor.HW2PhysicsParams(k,1)  = CMHgain(k);
        AO.VCM.Monitor.HW2PhysicsParams(k,1)  = CMVgain(k);
        AO.HCM.Monitor.Physics2HWParams(k,1)  = 1/CMHgain(k);
        AO.VCM.Monitor.Physics2HWParams(k,1)  = 1/CMVgain(k);
        AO.HCM.Setpoint.HW2PhysicsParams(k,1) = CMHgain(k);
        AO.VCM.Setpoint.HW2PhysicsParams(k,1) = CMVgain(k);
        AO.HCM.Setpoint.Physics2HWParams(k,1) = 1/CMHgain(k);
        AO.VCM.Setpoint.Physics2HWParams(k,1) = 1/CMVgain(k);
    end
end



%%%%%%%%%%%%%%%
% Quadrupoles %
%%%%%%%%%%%%%%%
% Tune correctors
AO.QH1.FamilyName = 'QH1';
AO.QH1.MemberOf = {'MachineConfig'; 'PlotFamily'; 'QUAD'; 'Magnet'; 'Tune Corrector'};
AO.QH1.DeviceList =  [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];
AO.QH1.ElementList =  (1:size(AO.QH1.DeviceList,1))';
AO.QH1.Status = ones(size(AO.QH1.DeviceList,1),1);
AO.QH1.CommonNames = [ 'qh1g2c30a'; 'qh1g6c01b'; 'qh1g2c02a'; 'qh1g6c03b'; 'qh1g2c04a'; 'qh1g6c05b'; 'qh1g2c06a'; 'qh1g6c07b'; 'qh1g2c08a'; 'qh1g6c09b'; 'qh1g2c10a'; 'qh1g6c11b'; 'qh1g2c12a'; 'qh1g6c13b'; 'qh1g2c14a'; 'qh1g6c15b'; 'qh1g2c16a'; 'qh1g6c17b'; 'qh1g2c18a'; 'qh1g6c19b'; 'qh1g2c20a'; 'qh1g6c21b'; 'qh1g2c22a'; 'qh1g6c23b'; 'qh1g2c24a'; 'qh1g6c25b'; 'qh1g2c26a'; 'qh1g6c27b'; 'qh1g2c28a'; 'qh1g6c29b' ];

AO.QH1.Monitor.Mode           = OperationalMode;
AO.QH1.Monitor.DataType       = 'Scalar';
AO.QH1.Monitor.ChannelNames   = ['SR:C30-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C01-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C02-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C03-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C04-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C05-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C06-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C07-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C08-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C09-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C10-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C11-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C12-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C13-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C14-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C15-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C16-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C17-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C18-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C19-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C20-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C21-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C22-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C23-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C24-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C25-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C26-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C27-MG{PS:QH1B}I:Ps1DCCT1-I';  'SR:C28-MG{PS:QH1A}I:Ps1DCCT1-I';  'SR:C29-MG{PS:QH1B}I:Ps1DCCT1-I'];
AO.QH1.Monitor.Units          = 'Hardware';
AO.QH1.Monitor.HWUnits        = 'A';
AO.QH1.Monitor.PhysicsUnits   = 'm^-2';
AO.QH1.Monitor.HW2PhysicsFcn  = @amp2k;
AO.QH1.Monitor.Physics2HWFcn  = @k2amp;

AO.QH1.Setpoint.Mode          = OperationalMode;
AO.QH1.Setpoint.DataType      = 'Scalar';
AO.QH1.Setpoint.ChannelNames   = ['SR:C30-MG{PS:QH1A}I:Sp1-SP'; 'SR:C01-MG{PS:QH1B}I:Sp1-SP'; 'SR:C02-MG{PS:QH1A}I:Sp1-SP'; 'SR:C03-MG{PS:QH1B}I:Sp1-SP'; 'SR:C04-MG{PS:QH1A}I:Sp1-SP'; 'SR:C05-MG{PS:QH1B}I:Sp1-SP'; 'SR:C06-MG{PS:QH1A}I:Sp1-SP'; 'SR:C07-MG{PS:QH1B}I:Sp1-SP'; 'SR:C08-MG{PS:QH1A}I:Sp1-SP'; 'SR:C09-MG{PS:QH1B}I:Sp1-SP'; 'SR:C10-MG{PS:QH1A}I:Sp1-SP'; 'SR:C11-MG{PS:QH1B}I:Sp1-SP'; 'SR:C12-MG{PS:QH1A}I:Sp1-SP'; 'SR:C13-MG{PS:QH1B}I:Sp1-SP'; 'SR:C14-MG{PS:QH1A}I:Sp1-SP'; 'SR:C15-MG{PS:QH1B}I:Sp1-SP'; 'SR:C16-MG{PS:QH1A}I:Sp1-SP'; 'SR:C17-MG{PS:QH1B}I:Sp1-SP'; 'SR:C18-MG{PS:QH1A}I:Sp1-SP'; 'SR:C19-MG{PS:QH1B}I:Sp1-SP'; 'SR:C20-MG{PS:QH1A}I:Sp1-SP'; 'SR:C21-MG{PS:QH1B}I:Sp1-SP'; 'SR:C22-MG{PS:QH1A}I:Sp1-SP'; 'SR:C23-MG{PS:QH1B}I:Sp1-SP'; 'SR:C24-MG{PS:QH1A}I:Sp1-SP'; 'SR:C25-MG{PS:QH1B}I:Sp1-SP'; 'SR:C26-MG{PS:QH1A}I:Sp1-SP'; 'SR:C27-MG{PS:QH1B}I:Sp1-SP'; 'SR:C28-MG{PS:QH1A}I:Sp1-SP'; 'SR:C29-MG{PS:QH1B}I:Sp1-SP'];

AO.QH1.Setpoint.Units         = 'Hardware';
AO.QH1.Setpoint.HWUnits       = 'A';
AO.QH1.Setpoint.PhysicsUnits  = 'm^-2';
AO.QH1.Setpoint.HW2PhysicsFcn = @amp2k;
AO.QH1.Setpoint.Physics2HWFcn = @k2amp;
AO.QH1.Setpoint.DeltaRespMat  = 0.2;
AO.QH1.Setpoint.Range         = [0 200];

% QH1gain = -10.0e-3;  %  m^-2/A

% AO.QH1.Monitor.HW2PhysicsParams  = QH1gain;
% AO.QH1.Monitor.Physics2HWParams  = 1.0/QH1gain;
% AO.QH1.Setpoint.HW2PhysicsParams = QH1gain;
% AO.QH1.Setpoint.Physics2HWParams = 1.0/QH1gain;

% QH1 KL setpoint
AO.QH1.SPKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Setpoint'};
AO.QH1.SPKL.Mode = OperationalMode;
AO.QH1.SPKL.DataType = 'Scalar';
AO.QH1.SPKL.ChannelNames  = ['SR:C30-MG{PS:QH1A}K:Sp1-SP'; 'SR:C01-MG{PS:QH1B}K:Sp1-SP'; 'SR:C02-MG{PS:QH1A}K:Sp1-SP'; 'SR:C03-MG{PS:QH1B}K:Sp1-SP'; 'SR:C04-MG{PS:QH1A}K:Sp1-SP'; 'SR:C05-MG{PS:QH1B}K:Sp1-SP'; 'SR:C06-MG{PS:QH1A}K:Sp1-SP'; 'SR:C07-MG{PS:QH1B}K:Sp1-SP'; 'SR:C08-MG{PS:QH1A}K:Sp1-SP'; 'SR:C09-MG{PS:QH1B}K:Sp1-SP'; 'SR:C10-MG{PS:QH1A}K:Sp1-SP'; 'SR:C11-MG{PS:QH1B}K:Sp1-SP'; 'SR:C12-MG{PS:QH1A}K:Sp1-SP'; 'SR:C13-MG{PS:QH1B}K:Sp1-SP'; 'SR:C14-MG{PS:QH1A}K:Sp1-SP'; 'SR:C15-MG{PS:QH1B}K:Sp1-SP'; 'SR:C16-MG{PS:QH1A}K:Sp1-SP'; 'SR:C17-MG{PS:QH1B}K:Sp1-SP'; 'SR:C18-MG{PS:QH1A}K:Sp1-SP'; 'SR:C19-MG{PS:QH1B}K:Sp1-SP'; 'SR:C20-MG{PS:QH1A}K:Sp1-SP'; 'SR:C21-MG{PS:QH1B}K:Sp1-SP'; 'SR:C22-MG{PS:QH1A}K:Sp1-SP'; 'SR:C23-MG{PS:QH1B}K:Sp1-SP'; 'SR:C24-MG{PS:QH1A}K:Sp1-SP'; 'SR:C25-MG{PS:QH1B}K:Sp1-SP'; 'SR:C26-MG{PS:QH1A}K:Sp1-SP'; 'SR:C27-MG{PS:QH1B}K:Sp1-SP'; 'SR:C28-MG{PS:QH1A}K:Sp1-SP'; 'SR:C29-MG{PS:QH1B}K:Sp1-SP'];
AO.QH1.SPKL.Units = 'Hardware';
AO.QH1.SPKL.HWUnits     = 'T*m^-1';
% QH1 KL readback
AO.QH1.RBKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Readback'};
AO.QH1.RBKL.Mode = OperationalMode;
AO.QH1.RBKL.DataType = 'Scalar';
AO.QH1.RBKL.ChannelNames  = ['SR:C30-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C01-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C02-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C03-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C04-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C05-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C06-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C07-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C08-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C09-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C10-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C11-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C12-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C13-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C14-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C15-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C16-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C17-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C18-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C19-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C20-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C21-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C22-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C23-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C24-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C25-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C26-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C27-MG{PS:QH1B}K:Ps1DCCT1-I';  'SR:C28-MG{PS:QH1A}K:Ps1DCCT1-I';  'SR:C29-MG{PS:QH1B}K:Ps1DCCT1-I'];
AO.QH1.RBKL.Units = 'Hardware';
AO.QH1.RBKL.HWUnits     = 'T*m^-1';
AO.QH1.KLname=['rot_coil_QDP-9809-0035_000.txt'; 'rot_coil_QDP-9809-0023_000.txt'; 'rot_coil_QDP-9809-0029_000.txt'; 'rot_coil_QDP-9809-0046_000.txt'; 'rot_coil_QDP-9809-0055_000.txt'; 'rot_coil_QDP-9809-0034_000.txt'; 'rot_coil_QDP-9809-0019_000.txt'; 'rot_coil_QDP-9809-0043_000.txt'; 'rot_coil_QDP-9809-0042_000.txt'; 'rot_coil_QDP-9809-0012_000.txt'; 'rot_coil_QDP-9809-0047_000.txt'; 'rot_coil_QDP-9809-0052_000.txt'; 'rot_coil_QDP-9809-0059_000.txt'; 'rot_coil_QDP-9809-0063_000.txt'; 'rot_coil_QDP-9809-0067_000.txt'; 'rot_coil_QDP-9809-0070_000.txt'; 'rot_coil_QDP-9809-0074_000.txt'; 'rot_coil_QDP-9809-0073_000.txt'; 'rot_coil_QDP-9809-0077_000.txt'; 'rot_coil_QDP-9809-0090_000.txt'; 'rot_coil_QDP-9809-0076_000.txt'; 'rot_coil_QDP-9809-0082_000.txt'; 'rot_coil_QDP-9809-0080_000.txt'; 'rot_coil_QDP-9809-0031_000.txt'; 'rot_coil_QDP-9809-0044_000.txt'; 'rot_coil_QDP-9809-0007_000.txt'; 'rot_coil_QDP-9809-0009_000.txt'; 'rot_coil_QDP-9809-0016_000.txt'; 'rot_coil_QDP-9809-0033_000.txt'; 'rot_coil_QDP-9809-0006_000.txt']; 
% for i=1:30 % number of superperiods
%         cef=load(AO.QH1.KLname);
%         AO.QH1.Setpoint.Range(i)            = [-CMrange CMrange];
%         AO.QH1.Monitor.HW2PhysicsFcn  = @amp2k;       %interp1(cef(:,1),cef(:,2),Amps);
%         AO.QH1.Monitor.HW2PhysicsFcn  = CMVgain(k);
%         AO.QH1.Monitor.Physics2HWFcn  = 1/CMHgain(k);
%         AO.QH1.Monitor.Physics2HWFcn  = 1/CMVgain(k);
%         AO.QH1.Setpoint.HW2PhysicsFcn = CMHgain(k);
%         AO.QH1.Setpoint.HW2PhysicsFcn = CMVgain(k);
%         AO.QH1.Setpoint.Physics2HWFcn = 1/CMHgain(k);
%         AO.QH1.Setpoint.Physics2HWFcn = 1/CMVgain(k);
%     end
% end

AO.QH2.FamilyName = 'QH2';
AO.QH2.MemberOf = {'MachineConfig'; 'PlotFamily'; 'QUAD'; 'Magnet'; 'Tune Corrector'};
AO.QH2.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];
AO.QH2.ElementList =  (1:size(AO.QH2.DeviceList,1))';
AO.QH2.Status = ones(size(AO.QH2.DeviceList,1),1);
AO.QH2.CommonNames = ['qh2g2c30a';  'qh2g6c01b';  'qh2g2c02a';  'qh2g6c03b';  'qh2g2c04a';  'qh2g6c05b';  'qh2g2c06a';  'qh2g6c07b';  'qh2g2c08a';  'qh2g6c09b';  'qh2g2c10a';  'qh2g6c11b';  'qh2g2c12a';  'qh2g6c13b';  'qh2g2c14a';  'qh2g6c15b';  'qh2g2c16a';  'qh2g6c17b';  'qh2g2c18a';  'qh2g6c19b';  'qh2g2c20a';  'qh2g6c21b';  'qh2g2c22a';  'qh2g6c23b';  'qh2g2c24a';  'qh2g6c25b';  'qh2g2c26a';  'qh2g6c27b';  'qh2g2c28a';  'qh2g6c29b'];

AO.QH2.Monitor.Mode           = OperationalMode;
AO.QH2.Monitor.DataType       = 'Scalar';
AO.QH2.Monitor.ChannelNames   = ['SR:C30-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C01-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C02-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C03-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C04-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C05-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C06-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C07-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C08-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C09-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C10-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C11-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C12-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C13-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C14-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C15-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C16-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C17-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C18-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C19-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C20-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C21-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C22-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C23-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C24-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C25-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C26-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C27-MG{PS:QH2B}I:Ps1DCCT1-I';'SR:C28-MG{PS:QH2A}I:Ps1DCCT1-I';'SR:C29-MG{PS:QH2B}I:Ps1DCCT1-I'];
AO.QH2.Monitor.Units          = 'Hardware';
AO.QH2.Monitor.HWUnits        = 'A';
AO.QH2.Monitor.PhysicsUnits   = 'm^-2';
AO.QH2.Monitor.HW2PhysicsFcn  = @amp2k;
AO.QH2.Monitor.Physics2HWFcn  = @k2amp;

AO.QH2.Setpoint.Mode          = OperationalMode;
AO.QH2.Setpoint.DataType      = 'Scalar';
AO.QH2.Setpoint.ChannelNames   = ['SR:C30-MG{PS:QH2A}I:Sp1-SP';'SR:C01-MG{PS:QH2B}I:Sp1-SP';'SR:C02-MG{PS:QH2A}I:Sp1-SP';'SR:C03-MG{PS:QH2B}I:Sp1-SP';'SR:C04-MG{PS:QH2A}I:Sp1-SP';'SR:C05-MG{PS:QH2B}I:Sp1-SP';'SR:C06-MG{PS:QH2A}I:Sp1-SP';'SR:C07-MG{PS:QH2B}I:Sp1-SP';'SR:C08-MG{PS:QH2A}I:Sp1-SP';'SR:C09-MG{PS:QH2B}I:Sp1-SP';'SR:C10-MG{PS:QH2A}I:Sp1-SP';'SR:C11-MG{PS:QH2B}I:Sp1-SP';'SR:C12-MG{PS:QH2A}I:Sp1-SP';'SR:C13-MG{PS:QH2B}I:Sp1-SP';'SR:C14-MG{PS:QH2A}I:Sp1-SP';'SR:C15-MG{PS:QH2B}I:Sp1-SP';'SR:C16-MG{PS:QH2A}I:Sp1-SP';'SR:C17-MG{PS:QH2B}I:Sp1-SP';'SR:C18-MG{PS:QH2A}I:Sp1-SP';'SR:C19-MG{PS:QH2B}I:Sp1-SP';'SR:C20-MG{PS:QH2A}I:Sp1-SP';'SR:C21-MG{PS:QH2B}I:Sp1-SP';'SR:C22-MG{PS:QH2A}I:Sp1-SP';'SR:C23-MG{PS:QH2B}I:Sp1-SP';'SR:C24-MG{PS:QH2A}I:Sp1-SP';'SR:C25-MG{PS:QH2B}I:Sp1-SP';'SR:C26-MG{PS:QH2A}I:Sp1-SP';'SR:C27-MG{PS:QH2B}I:Sp1-SP';'SR:C28-MG{PS:QH2A}I:Sp1-SP';'SR:C29-MG{PS:QH2B}I:Sp1-SP'];
AO.QH2.Setpoint.Units         = 'Hardware';
AO.QH2.Setpoint.HWUnits       = 'A';
AO.QH2.Setpoint.PhysicsUnits  = 'm^-2';
AO.QH2.Setpoint.HW2PhysicsFcn = @amp2k;
AO.QH2.Setpoint.Physics2HWFcn = @k2amp;
AO.QH2.Setpoint.DeltaRespMat  = 0.2;
AO.QH2.Setpoint.Range         = [0 200];

%QH2gain = 12.0e-3;  %  m^-2/A

% QH2. KL setpoint
AO.QH2.SPKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Setpoint'};
AO.QH2.SPKL.Mode = OperationalMode;
AO.QH2.SPKL.DataType = 'Scalar';
AO.QH2.SPKL.ChannelNames  = ['SR:C30-MG{PS:QH2A}K:Sp1-SP';'SR:C01-MG{PS:QH2B}K:Sp1-SP';'SR:C02-MG{PS:QH2A}K:Sp1-SP';'SR:C03-MG{PS:QH2B}K:Sp1-SP';'SR:C04-MG{PS:QH2A}K:Sp1-SP';'SR:C05-MG{PS:QH2B}K:Sp1-SP';'SR:C06-MG{PS:QH2A}K:Sp1-SP';'SR:C07-MG{PS:QH2B}K:Sp1-SP';'SR:C08-MG{PS:QH2A}K:Sp1-SP';'SR:C09-MG{PS:QH2B}K:Sp1-SP';'SR:C10-MG{PS:QH2A}K:Sp1-SP';'SR:C11-MG{PS:QH2B}K:Sp1-SP';'SR:C12-MG{PS:QH2A}K:Sp1-SP';'SR:C13-MG{PS:QH2B}K:Sp1-SP';'SR:C14-MG{PS:QH2A}K:Sp1-SP';'SR:C15-MG{PS:QH2B}K:Sp1-SP';'SR:C16-MG{PS:QH2A}K:Sp1-SP';'SR:C17-MG{PS:QH2B}K:Sp1-SP';'SR:C18-MG{PS:QH2A}K:Sp1-SP';'SR:C19-MG{PS:QH2B}K:Sp1-SP';'SR:C20-MG{PS:QH2A}K:Sp1-SP';'SR:C21-MG{PS:QH2B}K:Sp1-SP';'SR:C22-MG{PS:QH2A}K:Sp1-SP';'SR:C23-MG{PS:QH2B}K:Sp1-SP';'SR:C24-MG{PS:QH2A}K:Sp1-SP';'SR:C25-MG{PS:QH2B}K:Sp1-SP';'SR:C26-MG{PS:QH2A}K:Sp1-SP';'SR:C27-MG{PS:QH2B}K:Sp1-SP';'SR:C28-MG{PS:QH2A}K:Sp1-SP';'SR:C29-MG{PS:QH2B}K:Sp1-SP'];
AO.QH2.SPKL.Units = 'Hardware';
AO.QH2.SPKL.HWUnits     = 'T*m^-1';
% QH2 KL readback
AO.QH2.RBKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Readback'};
AO.QH2.RBKL.Mode = OperationalMode;
AO.QH2.RBKL.DataType = 'Scalar';
AO.QH2.RBKL.ChannelNames  = ['SR:C30-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C01-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C02-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C03-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C04-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C05-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C06-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C07-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C08-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C09-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C10-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C11-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C12-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C13-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C14-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C15-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C16-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C17-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C18-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C19-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C20-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C21-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C22-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C23-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C24-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C25-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C26-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C27-MG{PS:QH2B}K:Ps1DCCT1-I';'SR:C28-MG{PS:QH2A}K:Ps1DCCT1-I';'SR:C29-MG{PS:QH2B}K:Ps1DCCT1-I'];
AO.QH2.RBKL.Units = 'Hardware';
AO.QH2.RBKL.HWUnits     = 'T*m^-1';
AO.QH2.KLname=['rot_coil_QDP-9804-0021_000.txt'; 'rot_coil_QDP-9807-0017_000.txt'; 'rot_coil_QDP-9804-0007_000.txt'; 'rot_coil_QDP-9807-0021_000.txt'; 'rot_coil_QDP-9804-0029_000.txt'; 'rot_coil_QDP-9807-0019_000.txt'; 'rot_coil_QDP-9804-0006_000.txt'; 'rot_coil_QDP-9807-0022_000.txt'; 'rot_coil_QDP-9804-0023_000.txt'; 'rot_coil_QDP-9807-0008_000.txt'; 'rot_coil_QDP-9804-0020_000.txt'; 'rot_coil_QDP-9807-0024_000.txt'; 'rot_coil_QDP-9804-0028_000.txt'; 'rot_coil_QDP-9807-0027_000.txt'; 'rot_coil_QDP-9804-0014_000.txt'; 'rot_coil_QDP-9807-0026_000.txt'; 'rot_coil_QDP-9804-0018_000.txt'; 'rot_coil_QDP-9807-0002_000.txt'; 'rot_coil_QDP-9804-0013_000.txt'; 'rot_coil_QDP-9807-0016_000.txt'; 'rot_coil_QDP-9804-0019_000.txt'; 'rot_coil_QDP-9807-0029_000.txt'; 'rot_coil_QDP-9804-0030_000.txt'; 'rot_coil_QDP-9807-0012_000.txt'; 'rot_coil_QDP-9804-0025_000.txt'; 'rot_coil_QDP-9807-0005_000.txt'; 'rot_coil_QDP-9804-0004_000.txt'; 'rot_coil_QDP-9807-0014_000.txt'; 'rot_coil_QDP-9804-0010_000.txt'; 'rot_coil_QDP-9807-0007_000.txt']; 

% AO.QH2.Monitor.HW2PhysicsParams  = QH2gain;
% AO.QH2.Monitor.Physics2HWParams  = 1.0/QH2gain;
% AO.QH2.Setpoint.HW2PhysicsParams = QH2gain;
% AO.QH2.Setpoint.Physics2HWParams = 1.0/QH2gain;

AO.QH3.FamilyName = 'QH3';
AO.QH3.MemberOf = {'MachineConfig'; 'PlotFamily'; 'QUAD'; 'Magnet'; 'Tune Corrector'};
AO.QH3.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];
AO.QH3.ElementList =  (1:size(AO.QH3.DeviceList,1))';
AO.QH3.Status = ones(size(AO.QH3.DeviceList,1),1);
AO.QH3.CommonNames = ['qh3g2c30a';  'qh3g6c01b';  'qh3g2c02a';  'qh3g6c03b';  'qh3g2c04a';  'qh3g6c05b';  'qh3g2c06a';  'qh3g6c07b';  'qh3g2c08a';  'qh3g6c09b';  'qh3g2c10a';  'qh3g6c11b';  'qh3g2c12a';  'qh3g6c13b';  'qh3g2c14a';  'qh3g6c15b';  'qh3g2c16a';  'qh3g6c17b';  'qh3g2c18a';  'qh3g6c19b';  'qh3g2c20a';  'qh3g6c21b';  'qh3g2c22a';  'qh3g6c23b';  'qh3g2c24a';  'qh3g6c25b';  'qh3g2c26a';  'qh3g6c27b';  'qh3g2c28a';  'qh3g6c29b'];

AO.QH3.Monitor.Mode           = OperationalMode;
AO.QH3.Monitor.DataType       = 'Scalar';
AO.QH3.Monitor.ChannelNames   = ['SR:C30-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C01-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C02-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C03-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C04-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C05-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C06-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C07-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C08-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C09-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C10-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C11-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C12-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C13-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C14-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C15-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C16-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C17-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C18-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C19-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C20-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C21-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C22-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C23-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C24-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C25-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C26-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C27-MG{PS:QH3B}I:Ps1DCCT1-I';'SR:C28-MG{PS:QH3A}I:Ps1DCCT1-I';'SR:C29-MG{PS:QH3B}I:Ps1DCCT1-I'];
AO.QH3.Monitor.Units          = 'Hardware';
AO.QH3.Monitor.HWUnits        = 'A';
AO.QH3.Monitor.PhysicsUnits   = 'm^-2';
AO.QH3.Monitor.HW2PhysicsFcn  = @amp2k;
AO.QH3.Monitor.Physics2HWFcn  = @k2amp;

AO.QH3.Setpoint.Mode          = OperationalMode;
AO.QH3.Setpoint.DataType      = 'Scalar';
AO.QH3.Setpoint.ChannelNames   = ['SR:C30-MG{PS:QH3A}I:Sp1-SP';'SR:C01-MG{PS:QH3B}I:Sp1-SP';'SR:C02-MG{PS:QH3A}I:Sp1-SP';'SR:C03-MG{PS:QH3B}I:Sp1-SP';'SR:C04-MG{PS:QH3A}I:Sp1-SP';'SR:C05-MG{PS:QH3B}I:Sp1-SP';'SR:C06-MG{PS:QH3A}I:Sp1-SP';'SR:C07-MG{PS:QH3B}I:Sp1-SP';'SR:C08-MG{PS:QH3A}I:Sp1-SP';'SR:C09-MG{PS:QH3B}I:Sp1-SP';'SR:C10-MG{PS:QH3A}I:Sp1-SP';'SR:C11-MG{PS:QH3B}I:Sp1-SP';'SR:C12-MG{PS:QH3A}I:Sp1-SP';'SR:C13-MG{PS:QH3B}I:Sp1-SP';'SR:C14-MG{PS:QH3A}I:Sp1-SP';'SR:C15-MG{PS:QH3B}I:Sp1-SP';'SR:C16-MG{PS:QH3A}I:Sp1-SP';'SR:C17-MG{PS:QH3B}I:Sp1-SP';'SR:C18-MG{PS:QH3A}I:Sp1-SP';'SR:C19-MG{PS:QH3B}I:Sp1-SP';'SR:C20-MG{PS:QH3A}I:Sp1-SP';'SR:C21-MG{PS:QH3B}I:Sp1-SP';'SR:C22-MG{PS:QH3A}I:Sp1-SP';'SR:C23-MG{PS:QH3B}I:Sp1-SP';'SR:C24-MG{PS:QH3A}I:Sp1-SP';'SR:C25-MG{PS:QH3B}I:Sp1-SP';'SR:C26-MG{PS:QH3A}I:Sp1-SP';'SR:C27-MG{PS:QH3B}I:Sp1-SP';'SR:C28-MG{PS:QH3A}I:Sp1-SP';'SR:C29-MG{PS:QH3B}I:Sp1-SP'];
AO.QH3.Setpoint.Units         = 'Hardware';
AO.QH3.Setpoint.HWUnits       = 'A';
AO.QH3.Setpoint.PhysicsUnits  = 'm^-2';
AO.QH3.Setpoint.HW2PhysicsFcn = @amp2k;
AO.QH3.Setpoint.Physics2HWFcn = @k2amp;
AO.QH3.Setpoint.DeltaRespMat  = 0.2;
AO.QH3.Setpoint.Range         = [0 200];

%QH3gain = -10.0e-3;  %  m^-2/A

% QH3. KL setpoint
AO.QH3.SPKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Setpoint'};
AO.QH3.SPKL.Mode = OperationalMode;
AO.QH3.SPKL.DataType = 'Scalar';
AO.QH3.SPKL.ChannelNames  = ['SR:C30-MG{PS:QH3A}K:Sp1-SP';'SR:C01-MG{PS:QH3B}K:Sp1-SP';'SR:C02-MG{PS:QH3A}K:Sp1-SP';'SR:C03-MG{PS:QH3B}K:Sp1-SP';'SR:C04-MG{PS:QH3A}K:Sp1-SP';'SR:C05-MG{PS:QH3B}K:Sp1-SP';'SR:C06-MG{PS:QH3A}K:Sp1-SP';'SR:C07-MG{PS:QH3B}K:Sp1-SP';'SR:C08-MG{PS:QH3A}K:Sp1-SP';'SR:C09-MG{PS:QH3B}K:Sp1-SP';'SR:C10-MG{PS:QH3A}K:Sp1-SP';'SR:C11-MG{PS:QH3B}K:Sp1-SP';'SR:C12-MG{PS:QH3A}K:Sp1-SP';'SR:C13-MG{PS:QH3B}K:Sp1-SP';'SR:C14-MG{PS:QH3A}K:Sp1-SP';'SR:C15-MG{PS:QH3B}K:Sp1-SP';'SR:C16-MG{PS:QH3A}K:Sp1-SP';'SR:C17-MG{PS:QH3B}K:Sp1-SP';'SR:C18-MG{PS:QH3A}K:Sp1-SP';'SR:C19-MG{PS:QH3B}K:Sp1-SP';'SR:C20-MG{PS:QH3A}K:Sp1-SP';'SR:C21-MG{PS:QH3B}K:Sp1-SP';'SR:C22-MG{PS:QH3A}K:Sp1-SP';'SR:C23-MG{PS:QH3B}K:Sp1-SP';'SR:C24-MG{PS:QH3A}K:Sp1-SP';'SR:C25-MG{PS:QH3B}K:Sp1-SP';'SR:C26-MG{PS:QH3A}K:Sp1-SP';'SR:C27-MG{PS:QH3B}K:Sp1-SP';'SR:C28-MG{PS:QH3A}K:Sp1-SP';'SR:C29-MG{PS:QH3B}K:Sp1-SP'];
AO.QH3.SPKL.Units = 'Hardware';
AO.QH3.SPKL.HWUnits     = 'T*m^-1';
% QH3. KL readback
AO.QH3.RBKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Readback'};
AO.QH3.RBKL.Mode = OperationalMode;
AO.QH3.RBKL.DataType = 'Scalar';
AO.QH3.RBKL.ChannelNames  = ['SR:C30-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C01-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C02-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C03-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C04-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C05-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C06-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C07-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C08-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C09-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C10-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C11-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C12-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C13-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C14-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C15-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C16-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C17-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C18-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C19-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C20-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C21-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C22-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C23-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C24-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C25-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C26-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C27-MG{PS:QH3B}K:Ps1DCCT1-I';'SR:C28-MG{PS:QH3A}K:Ps1DCCT1-I';'SR:C29-MG{PS:QH3B}K:Ps1DCCT1-I'];
AO.QH3.RBKL.Units = 'Hardware';
AO.QH3.RBKL.HWUnits     = 'T*m^-1';
%AO.QH3.Monitor.HW2PhysicsParams  = QH3gain;
%AO.QH3.Monitor.Physics2HWParams  = 1.0/QH3gain;
AO.QH3.KLname=['rot_coil_QDP-9809-0036_000.txt'; 'rot_coil_QDW-9812-0012_000.txt'; 'rot_coil_QDP-9809-0026_000.txt'; 'rot_coil_QDW-9812-0018_000.txt'; 'rot_coil_QDP-9809-0056_000.txt'; 'rot_coil_QDW-9812-0016_000.txt'; 'rot_coil_QDP-9809-0020_000.txt'; 'rot_coil_QDW-9813-0003_000.txt'; 'rot_coil_QDP-9810-0002_000.txt'; 'rot_coil_QDW-9812-0010_000.txt'; 'rot_coil_QDP-9809-0048_000.txt'; 'rot_coil_QDW-9812-0023_001.txt'; 'rot_coil_QDP-9809-0062_000.txt'; 'rot_coil_QDW-9812-0020_000.txt'; 'rot_coil_QDP-9809-0068_000.txt'; 'rot_coil_QDW-9812-0022_001.txt'; 'rot_coil_QDP-9809-0075_000.txt'; 'rot_coil_QDW-9813-0002_000.txt'; 'rot_coil_QDP-9810-0003_000.txt'; 'rot_coil_QDW-9812-0032_000.txt'; 'rot_coil_QDP-9809-0083_000.txt'; 'rot_coil_QDW-9812-0028_000.txt'; 'rot_coil_QDP-9809-0084_000.txt'; 'rot_coil_QDW-9812-0014_000.txt'; 'rot_coil_QDP-9809-0045_000.txt'; 'rot_coil_QDW-9812-0002_000.txt'; 'rot_coil_QDP-9809-0010_000.txt'; 'rot_coil_QDW-9813-0001_000.txt'; 'rot_coil_QDP-9810-0001_000.txt'; 'rot_coil_QDW-9812-0007_000.txt']; 

% AO.QH3.Setpoint.HW2PhysicsParams = QH3gain;
% AO.QH3.Setpoint.Physics2HWParams = 1.0/QH3gain;

AO.QL1.FamilyName = 'QL1';
AO.QL1.MemberOf = {'MachineConfig'; 'PlotFamily'; 'QUAD'; 'Magnet'; 'Tune Corrector'};
AO.QL1.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];
AO.QL1.ElementList =  (1:size(AO.QL1.DeviceList,1))';
AO.QL1.Status = ones(size(AO.QL1.DeviceList,1),1);
AO.QL1.CommonNames = ['ql1g6c30b';  'ql1g2c01a';  'ql1g6c02b';  'ql1g2c03a';  'ql1g6c04b';  'ql1g2c05a';  'ql1g6c06b';  'ql1g2c07a';  'ql1g6c08b';  'ql1g2c09a';  'ql1g6c10b';  'ql1g2c11a';  'ql1g6c12b';  'ql1g2c13a';  'ql1g6c14b';  'ql1g2c15a';  'ql1g6c16b';  'ql1g2c17a';  'ql1g6c18b';  'ql1g2c19a';  'ql1g6c20b';  'ql1g2c21a';  'ql1g6c22b';  'ql1g2c23a';  'ql1g6c24b';  'ql1g2c25a';  'ql1g6c26b';  'ql1g2c27a';  'ql1g6c28b';  'ql1g2c29a'];

AO.QL1.Monitor.Mode           = OperationalMode;
AO.QL1.Monitor.DataType       = 'Scalar';
AO.QL1.Monitor.ChannelNames   = ['SR:C30-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C01-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C02-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C03-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C04-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C05-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C06-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C07-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C08-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C09-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C10-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C11-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C12-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C13-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C14-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C15-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C16-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C17-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C18-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C19-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C20-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C21-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C22-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C23-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C24-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C25-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C26-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C27-MG{PS:QL1A}I:Ps1DCCT1-I';'SR:C28-MG{PS:QL1B}I:Ps1DCCT1-I';'SR:C29-MG{PS:QL1A}I:Ps1DCCT1-I'];
AO.QL1.Monitor.Units          = 'Hardware';
AO.QL1.Monitor.HWUnits        = 'A';
AO.QL1.Monitor.PhysicsUnits   = 'm^-2';
AO.QL1.Monitor.HW2PhysicsFcn  = @amp2k;
AO.QL1.Monitor.Physics2HWFcn  = @k2amp;

AO.QL1.Setpoint.Mode          = OperationalMode;
AO.QL1.Setpoint.DataType      = 'Scalar';
AO.QL1.Setpoint.ChannelNames  = ['SR:C30-MG{PS:QL1B}I:Sp1-SP';'SR:C01-MG{PS:QL1A}I:Sp1-SP';'SR:C02-MG{PS:QL1B}I:Sp1-SP';'SR:C03-MG{PS:QL1A}I:Sp1-SP';'SR:C04-MG{PS:QL1B}I:Sp1-SP';'SR:C05-MG{PS:QL1A}I:Sp1-SP';'SR:C06-MG{PS:QL1B}I:Sp1-SP';'SR:C07-MG{PS:QL1A}I:Sp1-SP';'SR:C08-MG{PS:QL1B}I:Sp1-SP';'SR:C09-MG{PS:QL1A}I:Sp1-SP';'SR:C10-MG{PS:QL1B}I:Sp1-SP';'SR:C11-MG{PS:QL1A}I:Sp1-SP';'SR:C12-MG{PS:QL1B}I:Sp1-SP';'SR:C13-MG{PS:QL1A}I:Sp1-SP';'SR:C14-MG{PS:QL1B}I:Sp1-SP';'SR:C15-MG{PS:QL1A}I:Sp1-SP';'SR:C16-MG{PS:QL1B}I:Sp1-SP';'SR:C17-MG{PS:QL1A}I:Sp1-SP';'SR:C18-MG{PS:QL1B}I:Sp1-SP';'SR:C19-MG{PS:QL1A}I:Sp1-SP';'SR:C20-MG{PS:QL1B}I:Sp1-SP';'SR:C21-MG{PS:QL1A}I:Sp1-SP';'SR:C22-MG{PS:QL1B}I:Sp1-SP';'SR:C23-MG{PS:QL1A}I:Sp1-SP';'SR:C24-MG{PS:QL1B}I:Sp1-SP';'SR:C25-MG{PS:QL1A}I:Sp1-SP';'SR:C26-MG{PS:QL1B}I:Sp1-SP';'SR:C27-MG{PS:QL1A}I:Sp1-SP';'SR:C28-MG{PS:QL1B}I:Sp1-SP';'SR:C29-MG{PS:QL1A}I:Sp1-SP'];
AO.QL1.Setpoint.Units         = 'Hardware';
AO.QL1.Setpoint.HWUnits       = 'A';
AO.QL1.Setpoint.PhysicsUnits  = 'm^-2';
AO.QL1.Setpoint.HW2PhysicsFcn = @amp2k;
AO.QL1.Setpoint.Physics2HWFcn = @k2amp;
AO.QL1.Setpoint.DeltaRespMat  = 0.2;
AO.QL1.Setpoint.Range         = [0 200];

%QL1gain = -10.0e-3;  %  m^-2/A

% QL1. KL setpoint
AO.QL1.SPKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Setpoint'};
AO.QL1.SPKL.Mode = OperationalMode;
AO.QL1.SPKL.DataType = 'Scalar';
AO.QL1.SPKL.ChannelNames  = ['SR:C30-MG{PS:QL1B}K:Sp1-SP';'SR:C01-MG{PS:QL1A}K:Sp1-SP';'SR:C02-MG{PS:QL1B}K:Sp1-SP';'SR:C03-MG{PS:QL1A}K:Sp1-SP';'SR:C04-MG{PS:QL1B}K:Sp1-SP';'SR:C05-MG{PS:QL1A}K:Sp1-SP';'SR:C06-MG{PS:QL1B}K:Sp1-SP';'SR:C07-MG{PS:QL1A}K:Sp1-SP';'SR:C08-MG{PS:QL1B}K:Sp1-SP';'SR:C09-MG{PS:QL1A}K:Sp1-SP';'SR:C10-MG{PS:QL1B}K:Sp1-SP';'SR:C11-MG{PS:QL1A}K:Sp1-SP';'SR:C12-MG{PS:QL1B}K:Sp1-SP';'SR:C13-MG{PS:QL1A}K:Sp1-SP';'SR:C14-MG{PS:QL1B}K:Sp1-SP';'SR:C15-MG{PS:QL1A}K:Sp1-SP';'SR:C16-MG{PS:QL1B}K:Sp1-SP';'SR:C17-MG{PS:QL1A}K:Sp1-SP';'SR:C18-MG{PS:QL1B}K:Sp1-SP';'SR:C19-MG{PS:QL1A}K:Sp1-SP';'SR:C20-MG{PS:QL1B}K:Sp1-SP';'SR:C21-MG{PS:QL1A}K:Sp1-SP';'SR:C22-MG{PS:QL1B}K:Sp1-SP';'SR:C23-MG{PS:QL1A}K:Sp1-SP';'SR:C24-MG{PS:QL1B}K:Sp1-SP';'SR:C25-MG{PS:QL1A}K:Sp1-SP';'SR:C26-MG{PS:QL1B}K:Sp1-SP';'SR:C27-MG{PS:QL1A}K:Sp1-SP';'SR:C28-MG{PS:QL1B}K:Sp1-SP';'SR:C29-MG{PS:QL1A}K:Sp1-SP'];
AO.QL1.SPKL.Units = 'Hardware';
AO.QL1.SPKL.HWUnits     = 'T*m^-1';
% QL1. KL readback
AO.QL1.RBKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Readback'};
AO.QL1.RBKL.Mode = OperationalMode;
AO.QL1.RBKL.DataType = 'Scalar';
AO.QL1.RBKL.ChannelNames  = ['SR:C30-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C01-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C02-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C03-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C04-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C05-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C06-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C07-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C08-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C09-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C10-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C11-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C12-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C13-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C14-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C15-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C16-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C17-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C18-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C19-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C20-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C21-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C22-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C23-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C24-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C25-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C26-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C27-MG{PS:QL1A}K:Ps1DCCT1-I';'SR:C28-MG{PS:QL1B}K:Ps1DCCT1-I';'SR:C29-MG{PS:QL1A}K:Ps1DCCT1-I'];
AO.QL1.RBKL.Units = 'Hardware';
AO.QL1.RBKL.HWUnits     = 'T*m^-1';
% AO.QL1.Monitor.HW2PhysicsParams  = QL1gain;
% AO.QL1.Monitor.Physics2HWParams  = 1.0/QL1gain;
% AO.QL1.Setpoint.HW2PhysicsParams = QL1gain;
% AO.QL1.Setpoint.Physics2HWParams = 1.0/QL1gain;
AO.QL1.KLname=['rot_coil_QDP-9809-0021_000.txt';'rot_coil_QDP-9809-0017_000.txt';'rot_coil_QDP-9809-0024_000.txt';'rot_coil_QDP-9809-0038_000.txt';'rot_coil_QDP-9809-0028_000.txt';'rot_coil_QDP-9809-0057_000.txt';'rot_coil_QDP-9809-0011_000.txt';'rot_coil_QDP-9809-0049_000.txt';'rot_coil_QDP-9809-0039_000.txt';'rot_coil_QDP-9809-0025_000.txt';'rot_coil_QDP-9809-0013_000.txt';'rot_coil_QDP-9809-0054_000.txt';'rot_coil_QDP-9809-0050_000.txt';'rot_coil_QDP-9809-0061_000.txt';'rot_coil_QDP-9809-0060_001.txt';'rot_coil_QDP-9809-0066_000.txt';'rot_coil_QDP-9809-0072_000.txt';'rot_coil_QDP-9809-0079_000.txt';'rot_coil_QDP-9809-0081_000.txt';'rot_coil_QDP-9809-0040_001.txt';'rot_coil_QDP-9809-0085_000.txt';'rot_coil_QDP-9809-0087_000.txt';'rot_coil_QDP-9809-0078_000.txt';'rot_coil_QDP-9809-0032_000.txt';'rot_coil_QDP-9809-0001_001.txt';'rot_coil_QDP-9809-0003_002.txt';'rot_coil_QDP-9809-0005_000.txt';'rot_coil_QDP-9809-0027_000.txt';'rot_coil_QDP-9809-0008_000.txt';'rot_coil_QDP-9809-0014_000.txt'];


AO.QL2.FamilyName = 'QL2';
AO.QL2.MemberOf = {'MachineConfig'; 'PlotFamily'; 'QUAD'; 'Magnet'; 'Tune Corrector'};
AO.QL2.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];
AO.QL2.ElementList =  (1:size(AO.QL2.DeviceList,1))';
AO.QL2.Status = ones(size(AO.QL2.DeviceList,1),1);
AO.QL2.CommonNames = ['ql2g6c30b';  'ql2g2c01a';  'ql2g6c02b';  'ql2g2c03a';  'ql2g6c04b';  'ql2g2c05a';  'ql2g6c06b';  'ql2g2c07a';  'ql2g6c08b';  'ql2g2c09a';  'ql2g6c10b';  'ql2g2c11a';  'ql2g6c12b';  'ql2g2c13a';  'ql2g6c14b';  'ql2g2c15a';  'ql2g6c16b';  'ql2g2c17a';  'ql2g6c18b';  'ql2g2c19a';  'ql2g6c20b';  'ql2g2c21a';  'ql2g6c22b';  'ql2g2c23a';  'ql2g6c24b';  'ql2g2c25a';  'ql2g6c26b';  'ql2g2c27a';  'ql2g6c28b';  'ql2g2c29a'];


AO.QL2.Monitor.Mode           = OperationalMode;
AO.QL2.Monitor.DataType       = 'Scalar';
AO.QL2.Monitor.ChannelNames   = ['SR:C30-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C01-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C02-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C03-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C04-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C05-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C06-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C07-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C08-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C09-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C10-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C11-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C12-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C13-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C14-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C15-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C16-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C17-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C18-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C19-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C20-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C21-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C22-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C23-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C24-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C25-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C26-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C27-MG{PS:QL2A}I:Ps1DCCT1-I';'SR:C28-MG{PS:QL2B}I:Ps1DCCT1-I';'SR:C29-MG{PS:QL2A}I:Ps1DCCT1-I'];
AO.QL2.Monitor.Units          = 'Hardware';
AO.QL2.Monitor.HWUnits        = 'A';
AO.QL2.Monitor.PhysicsUnits   = 'm^-2';
AO.QL2.Monitor.HW2PhysicsFcn  = @amp2k;
AO.QL2.Monitor.Physics2HWFcn  = @k2amp;

AO.QL2.Setpoint.Mode          = OperationalMode;
AO.QL2.Setpoint.DataType      = 'Scalar';
AO.QL2.Setpoint.ChannelNames  = ['SR:C30-MG{PS:QL2B}I:Sp1-SP';'SR:C01-MG{PS:QL2A}I:Sp1-SP';'SR:C02-MG{PS:QL2B}I:Sp1-SP';'SR:C03-MG{PS:QL2A}I:Sp1-SP';'SR:C04-MG{PS:QL2B}I:Sp1-SP';'SR:C05-MG{PS:QL2A}I:Sp1-SP';'SR:C06-MG{PS:QL2B}I:Sp1-SP';'SR:C07-MG{PS:QL2A}I:Sp1-SP';'SR:C08-MG{PS:QL2B}I:Sp1-SP';'SR:C09-MG{PS:QL2A}I:Sp1-SP';'SR:C10-MG{PS:QL2B}I:Sp1-SP';'SR:C11-MG{PS:QL2A}I:Sp1-SP';'SR:C12-MG{PS:QL2B}I:Sp1-SP';'SR:C13-MG{PS:QL2A}I:Sp1-SP';'SR:C14-MG{PS:QL2B}I:Sp1-SP';'SR:C15-MG{PS:QL2A}I:Sp1-SP';'SR:C16-MG{PS:QL2B}I:Sp1-SP';'SR:C17-MG{PS:QL2A}I:Sp1-SP';'SR:C18-MG{PS:QL2B}I:Sp1-SP';'SR:C19-MG{PS:QL2A}I:Sp1-SP';'SR:C20-MG{PS:QL2B}I:Sp1-SP';'SR:C21-MG{PS:QL2A}I:Sp1-SP';'SR:C22-MG{PS:QL2B}I:Sp1-SP';'SR:C23-MG{PS:QL2A}I:Sp1-SP';'SR:C24-MG{PS:QL2B}I:Sp1-SP';'SR:C25-MG{PS:QL2A}I:Sp1-SP';'SR:C26-MG{PS:QL2B}I:Sp1-SP';'SR:C27-MG{PS:QL2A}I:Sp1-SP';'SR:C28-MG{PS:QL2B}I:Sp1-SP';'SR:C29-MG{PS:QL2A}I:Sp1-SP'];
AO.QL2.Setpoint.Units         = 'Hardware';
AO.QL2.Setpoint.HWUnits       = 'A';
AO.QL2.Setpoint.PhysicsUnits  = 'm^-2';
AO.QL2.Setpoint.HW2PhysicsFcn = @amp2k;
AO.QL2.Setpoint.Physics2HWFcn = @k2amp;
AO.QL2.Setpoint.DeltaRespMat  = 0.2;
AO.QL2.Setpoint.Range         = [0 200];

%QL2gain = 12.0e-3;  %  m^-2/A

% QL2. KL setpoint
AO.QL2.SPKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Setpoint'};
AO.QL2.SPKL.Mode = OperationalMode;
AO.QL2.SPKL.DataType = 'Scalar';
AO.QL2.SPKL.ChannelNames  = ['SR:C30-MG{PS:QL2B}K:Sp1-SP';'SR:C01-MG{PS:QL2A}K:Sp1-SP';'SR:C02-MG{PS:QL2B}K:Sp1-SP';'SR:C03-MG{PS:QL2A}K:Sp1-SP';'SR:C04-MG{PS:QL2B}K:Sp1-SP';'SR:C05-MG{PS:QL2A}K:Sp1-SP';'SR:C06-MG{PS:QL2B}K:Sp1-SP';'SR:C07-MG{PS:QL2A}K:Sp1-SP';'SR:C08-MG{PS:QL2B}K:Sp1-SP';'SR:C09-MG{PS:QL2A}K:Sp1-SP';'SR:C10-MG{PS:QL2B}K:Sp1-SP';'SR:C11-MG{PS:QL2A}K:Sp1-SP';'SR:C12-MG{PS:QL2B}K:Sp1-SP';'SR:C13-MG{PS:QL2A}K:Sp1-SP';'SR:C14-MG{PS:QL2B}K:Sp1-SP';'SR:C15-MG{PS:QL2A}K:Sp1-SP';'SR:C16-MG{PS:QL2B}K:Sp1-SP';'SR:C17-MG{PS:QL2A}K:Sp1-SP';'SR:C18-MG{PS:QL2B}K:Sp1-SP';'SR:C19-MG{PS:QL2A}K:Sp1-SP';'SR:C20-MG{PS:QL2B}K:Sp1-SP';'SR:C21-MG{PS:QL2A}K:Sp1-SP';'SR:C22-MG{PS:QL2B}K:Sp1-SP';'SR:C23-MG{PS:QL2A}K:Sp1-SP';'SR:C24-MG{PS:QL2B}K:Sp1-SP';'SR:C25-MG{PS:QL2A}K:Sp1-SP';'SR:C26-MG{PS:QL2B}K:Sp1-SP';'SR:C27-MG{PS:QL2A}K:Sp1-SP';'SR:C28-MG{PS:QL2B}K:Sp1-SP';'SR:C29-MG{PS:QL2A}K:Sp1-SP'];
AO.QL2.SPKL.Units = 'Hardware';
AO.QL2.SPKL.HWUnits     = 'T*m^-1';
% QL2. KL readback
AO.QL2.RBKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Readback'};
AO.QL2.RBKL.Mode = OperationalMode;
AO.QL2.RBKL.DataType = 'Scalar';
AO.QL2.RBKL.ChannelNames  = ['SR:C30-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C01-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C02-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C03-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C04-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C05-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C06-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C07-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C08-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C09-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C10-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C11-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C12-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C13-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C14-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C15-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C16-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C17-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C18-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C19-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C20-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C21-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C22-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C23-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C24-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C25-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C26-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C27-MG{PS:QL2A}K:Ps1DCCT1-I';'SR:C28-MG{PS:QL2B}K:Ps1DCCT1-I';'SR:C29-MG{PS:QL2A}K:Ps1DCCT1-I'];
AO.QL2.RBKL.Units = 'Hardware';
AO.QL2.RBKL.HWUnits     = 'T*m^-1';
% AO.QL2.Monitor.HW2PhysicsParams  = QL2gain;
% AO.QL2.Monitor.Physics2HWParams  = 1.0/QL2gain;
% AO.QL2.Setpoint.HW2PhysicsParams = QL2gain;
% AO.QL2.Setpoint.Physics2HWParams = 1.0/QL2gain;
AO.QL2.KLname=['rot_coil_QDP-9807-0018_000.txt';'rot_coil_QDP-9804-0008_000.txt';'rot_coil_QDP-9807-0015_000.txt';'rot_coil_QDP-9804-0022_000.txt';'rot_coil_QDP-9807-0010_000.txt';'rot_coil_QDP-9804-0027_000.txt';'rot_coil_QDP-9807-0009_000.txt';'rot_coil_QDP-9804-0026_000.txt';'rot_coil_QDP-9807-0020_000.txt';'rot_coil_QDP-9804-0001_001.txt';'rot_coil_QDP-9807-0011_000.txt';'rot_coil_QDP-9804-0009_000.txt';'rot_coil_QDP-9807-0023_000.txt';'rot_coil_QDP-9804-0011_000.txt';'rot_coil_QDP-9807-0025_000.txt';'rot_coil_QDP-9804-0017_000.txt';'rot_coil_QDP-9807-0028_000.txt';'rot_coil_QDP-9804-0012_000.txt';'rot_coil_QDP-9807-0031_000.txt';'rot_coil_QDP-9804-0024_000.txt';'rot_coil_QDP-9807-0030_000.txt';'rot_coil_QDP-9804-0015_000.txt';'rot_coil_QDP-9807-0013_000.txt';'rot_coil_QDP-9804-0016_000.txt';'rot_coil_QDP-9807-0003_001.txt';'rot_coil_QDP-9804-0002_001.txt';'rot_coil_QDP-9807-0004_001.txt';'rot_coil_QDP-9804-0003_001.txt';'rot_coil_QDP-9807-0006_000.txt';'rot_coil_QDP-9804-0005_000.txt'];


AO.QL3.FamilyName = 'QL3';
AO.QL3.MemberOf = {'MachineConfig'; 'PlotFamily'; 'QUAD'; 'Magnet'; 'Tune Corrector'};
AO.QL3.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];
AO.QL3.ElementList =  (1:size(AO.QL3.DeviceList,1))';
AO.QL3.Status = ones(size(AO.QL3.DeviceList,1),1);
AO.QL3.CommonNames = ['ql3g6c30b';  'ql3g2c01a';  'ql3g6c02b';  'ql3g2c03a';  'ql3g6c04b';  'ql3g2c05a';  'ql3g6c06b';  'ql3g2c07a';  'ql3g6c08b';  'ql3g2c09a';  'ql3g6c10b';  'ql3g2c11a';  'ql3g6c12b';  'ql3g2c13a';  'ql3g6c14b';  'ql3g2c15a';  'ql3g6c16b';  'ql3g2c17a';  'ql3g6c18b';  'ql3g2c19a';  'ql3g6c20b';  'ql3g2c21a';  'ql3g6c22b';  'ql3g2c23a';  'ql3g6c24b';  'ql3g2c25a';  'ql3g6c26b';  'ql3g2c27a';  'ql3g6c28b';  'ql3g2c29a'];


AO.QL3.Monitor.Mode           = OperationalMode;
AO.QL3.Monitor.DataType       = 'Scalar';
AO.QL3.Monitor.ChannelNames   = [ 'SR:C30-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C01-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C02-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C03-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C04-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C05-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C06-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C07-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C08-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C09-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C10-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C11-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C12-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C13-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C14-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C15-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C16-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C17-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C18-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C19-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C20-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C21-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C22-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C23-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C24-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C25-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C26-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C27-MG{PS:QL3A}I:Ps1DCCT1-I';'SR:C28-MG{PS:QL3B}I:Ps1DCCT1-I';'SR:C29-MG{PS:QL3A}I:Ps1DCCT1-I' ];
AO.QL3.Monitor.Units          = 'Hardware';
AO.QL3.Monitor.HWUnits        = 'A';
AO.QL3.Monitor.PhysicsUnits   = 'm^-2';
AO.QL3.Monitor.HW2PhysicsFcn  = @amp2k;
AO.QL3.Monitor.Physics2HWFcn  = @k2amp;

AO.QL3.Setpoint.Mode          = OperationalMode;
AO.QL3.Setpoint.DataType      = 'Scalar';
AO.QL3.Setpoint.ChannelNames  = [ 'SR:C30-MG{PS:QL3B}I:Sp1-SP';'SR:C01-MG{PS:QL3A}I:Sp1-SP';'SR:C02-MG{PS:QL3B}I:Sp1-SP';'SR:C03-MG{PS:QL3A}I:Sp1-SP';'SR:C04-MG{PS:QL3B}I:Sp1-SP';'SR:C05-MG{PS:QL3A}I:Sp1-SP';'SR:C06-MG{PS:QL3B}I:Sp1-SP';'SR:C07-MG{PS:QL3A}I:Sp1-SP';'SR:C08-MG{PS:QL3B}I:Sp1-SP';'SR:C09-MG{PS:QL3A}I:Sp1-SP';'SR:C10-MG{PS:QL3B}I:Sp1-SP';'SR:C11-MG{PS:QL3A}I:Sp1-SP';'SR:C12-MG{PS:QL3B}I:Sp1-SP';'SR:C13-MG{PS:QL3A}I:Sp1-SP';'SR:C14-MG{PS:QL3B}I:Sp1-SP';'SR:C15-MG{PS:QL3A}I:Sp1-SP';'SR:C16-MG{PS:QL3B}I:Sp1-SP';'SR:C17-MG{PS:QL3A}I:Sp1-SP';'SR:C18-MG{PS:QL3B}I:Sp1-SP';'SR:C19-MG{PS:QL3A}I:Sp1-SP';'SR:C20-MG{PS:QL3B}I:Sp1-SP';'SR:C21-MG{PS:QL3A}I:Sp1-SP';'SR:C22-MG{PS:QL3B}I:Sp1-SP';'SR:C23-MG{PS:QL3A}I:Sp1-SP';'SR:C24-MG{PS:QL3B}I:Sp1-SP';'SR:C25-MG{PS:QL3A}I:Sp1-SP';'SR:C26-MG{PS:QL3B}I:Sp1-SP';'SR:C27-MG{PS:QL3A}I:Sp1-SP';'SR:C28-MG{PS:QL3B}I:Sp1-SP';'SR:C29-MG{PS:QL3A}I:Sp1-SP' ];
AO.QL3.Setpoint.Units         = 'Hardware';
AO.QL3.Setpoint.HWUnits       = 'A';
AO.QL3.Setpoint.PhysicsUnits  = 'm^-2';
AO.QL3.Setpoint.HW2PhysicsFcn = @amp2k;
AO.QL3.Setpoint.Physics2HWFcn = @k2amp;
AO.QL3.Setpoint.DeltaRespMat  = 0.2;
AO.QL3.Setpoint.Range         = [0 200];

%QL3gain = -10.0e-3;  %  m^-2/A
% QL3. KL setpoint
AO.QL3.SPKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Setpoint'};
AO.QL3.SPKL.Mode = OperationalMode;
AO.QL3.SPKL.DataType = 'Scalar';
AO.QL3.SPKL.ChannelNames  = [ 'SR:C30-MG{PS:QL3B}K:Sp1-SP';'SR:C01-MG{PS:QL3A}K:Sp1-SP';'SR:C02-MG{PS:QL3B}K:Sp1-SP';'SR:C03-MG{PS:QL3A}K:Sp1-SP';'SR:C04-MG{PS:QL3B}K:Sp1-SP';'SR:C05-MG{PS:QL3A}K:Sp1-SP';'SR:C06-MG{PS:QL3B}K:Sp1-SP';'SR:C07-MG{PS:QL3A}K:Sp1-SP';'SR:C08-MG{PS:QL3B}K:Sp1-SP';'SR:C09-MG{PS:QL3A}K:Sp1-SP';'SR:C10-MG{PS:QL3B}K:Sp1-SP';'SR:C11-MG{PS:QL3A}K:Sp1-SP';'SR:C12-MG{PS:QL3B}K:Sp1-SP';'SR:C13-MG{PS:QL3A}K:Sp1-SP';'SR:C14-MG{PS:QL3B}K:Sp1-SP';'SR:C15-MG{PS:QL3A}K:Sp1-SP';'SR:C16-MG{PS:QL3B}K:Sp1-SP';'SR:C17-MG{PS:QL3A}K:Sp1-SP';'SR:C18-MG{PS:QL3B}K:Sp1-SP';'SR:C19-MG{PS:QL3A}K:Sp1-SP';'SR:C20-MG{PS:QL3B}K:Sp1-SP';'SR:C21-MG{PS:QL3A}K:Sp1-SP';'SR:C22-MG{PS:QL3B}K:Sp1-SP';'SR:C23-MG{PS:QL3A}K:Sp1-SP';'SR:C24-MG{PS:QL3B}K:Sp1-SP';'SR:C25-MG{PS:QL3A}K:Sp1-SP';'SR:C26-MG{PS:QL3B}K:Sp1-SP';'SR:C27-MG{PS:QL3A}K:Sp1-SP';'SR:C28-MG{PS:QL3B}K:Sp1-SP';'SR:C29-MG{PS:QL3A}K:Sp1-SP' ];
AO.QL3.SPKL.Units = 'Hardware';
AO.QL3.SPKL.HWUnits     = 'T*m^-1';
% QL3. KL readback
AO.QL3.RBKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Readback'};
AO.QL3.RBKL.Mode = OperationalMode;
AO.QL3.RBKL.DataType = 'Scalar';
AO.QL3.RBKL.ChannelNames  = [ 'SR:C30-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C01-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C02-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C03-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C04-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C05-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C06-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C07-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C08-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C09-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C10-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C11-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C12-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C13-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C14-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C15-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C16-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C17-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C18-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C19-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C20-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C21-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C22-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C23-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C24-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C25-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C26-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C27-MG{PS:QL3A}K:Ps1DCCT1-I';'SR:C28-MG{PS:QL3B}K:Ps1DCCT1-I';'SR:C29-MG{PS:QL3A}K:Ps1DCCT1-I' ];
AO.QL3.RBKL.Units = 'Hardware';
AO.QL3.RBKL.HWUnits     = 'T*m^-1';
% AO.QL3.Monitor.HW2PhysicsParams  = QL3gain;
% AO.QL3.Monitor.Physics2HWParams  = 1.0/QL3gain;
% AO.QL3.Setpoint.HW2PhysicsParams = QL3gain;
% AO.QL3.Setpoint.Physics2HWParams = 1.0/QL3gain;
AO.QL3.KLname=['rot_coil_QDW-9812-0011_000.txt';'rot_coil_QDP-9809-0018_000.txt';'rot_coil_QDW-9812-0015_000.txt';'rot_coil_QDP-9809-0041_000.txt';'rot_coil_QDW-9812-0013_000.txt';'rot_coil_QDP-9809-0058_000.txt';'rot_coil_QDW-9812-0008_000.txt';'rot_coil_QDP-9809-0051_000.txt';'rot_coil_QDW-9812-0017_000.txt';'rot_coil_QDP-9809-0022_000.txt';'rot_coil_QDW-9812-0009_000.txt';'rot_coil_QDP-9809-0071_000.txt';'rot_coil_QDW-9812-0019_000.txt';'rot_coil_QDP-9809-0065_000.txt';'rot_coil_QDW-9812-0021_000.txt';'rot_coil_QDP-9809-0069_000.txt';'rot_coil_QDW-9812-0026_000.txt';'rot_coil_QDP-9809-0064_000.txt';'rot_coil_QDW-9812-0025_000.txt';'rot_coil_QDP-9809-0091_000.txt';'rot_coil_QDW-9812-0024_000.txt';'rot_coil_QDP-9809-0053_000.txt';'rot_coil_QDW-9812-0029_000.txt';'rot_coil_QDP-9809-0037_000.txt';'rot_coil_QDW-9812-0004_001.txt';'rot_coil_QDP-9809-0004_001.txt';'rot_coil_QDW-9812-0005_000.txt';'rot_coil_QDP-9809-0030_000.txt';'rot_coil_QDW-9812-0006_000.txt';'rot_coil_QDP-9809-0015_000.txt'];


% Dispersion correctors
AO.QM1.FamilyName = 'QM1';
AO.QM1.MemberOf = {'MachineConfig'; 'PlotFamily'; 'QUAD'; 'Magnet'; 'Dispersion Corrector'};
AO.QM1.DeviceList = [30 1; 30 2; 1 1; 1 2; 2 1; 2 2; 3 1; 3 2; 4 1; 4 2; 5 1; 5 2; 6 1; 6 2; 7 1; 7 2; 8 1; 8 2; 9 1; 9 2; 10 1; 10 2; 11 1; 11 2; 12 1; 12 2; 13 1; 13 2; 14 1; 14 2; 15 1; 15 2; 16 1; 16 2; 17 1; 17 2; 18 1; 18 2; 19 1; 19 2; 20 1; 20 2; 21 1; 21 2; 22 1; 22 2; 23 1; 23 2; 24 1; 24 2; 25 1; 25 2; 26 1; 26 2; 27 1; 27 2; 28 1; 28 2; 29 1; 29 2];
AO.QM1.ElementList = (1:size(AO.QM1.DeviceList,1))';
AO.QM1.Status = ones(size(AO.QM1.DeviceList,1),1);
AO.QM1.CommonNames = ['qm1g4c30a';  'qm1g4c30b';  'qm1g4c01a';  'qm1g4c01b';  'qm1g4c02a';  'qm1g4c02b';  'qm1g4c03a';  'qm1g4c03b';  'qm1g4c04a';  'qm1g4c04b';  'qm1g4c05a';  'qm1g4c05b';  'qm1g4c06a';  'qm1g4c06b';  'qm1g4c07a';  'qm1g4c07b';  'qm1g4c08a';  'qm1g4c08b';  'qm1g4c09a';  'qm1g4c09b';  'qm1g4c10a';  'qm1g4c10b';  'qm1g4c11a';  'qm1g4c11b';  'qm1g4c12a';  'qm1g4c12b';  'qm1g4c13a';  'qm1g4c13b';  'qm1g4c14a';  'qm1g4c14b';  'qm1g4c15a';  'qm1g4c15b';  'qm1g4c16a';  'qm1g4c16b';  'qm1g4c17a';  'qm1g4c17b';  'qm1g4c18a';  'qm1g4c18b';  'qm1g4c19a';  'qm1g4c19b';  'qm1g4c20a';  'qm1g4c20b';  'qm1g4c21a';  'qm1g4c21b';  'qm1g4c22a';  'qm1g4c22b';  'qm1g4c23a';  'qm1g4c23b';  'qm1g4c24a';  'qm1g4c24b';  'qm1g4c25a';  'qm1g4c25b';  'qm1g4c26a';  'qm1g4c26b';  'qm1g4c27a';  'qm1g4c27b';  'qm1g4c28a';  'qm1g4c28b';  'qm1g4c29a';  'qm1g4c29b'];


AO.QM1.Monitor.Mode           = OperationalMode;
AO.QM1.Monitor.DataType       = 'Scalar';
AO.QM1.Monitor.ChannelNames   = ['SR:C30-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C30-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C01-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C01-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C02-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C02-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C03-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C03-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C04-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C04-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C05-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C05-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C06-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C06-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C07-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C07-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C08-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C08-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C09-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C09-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C10-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C10-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C11-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C11-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C12-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C12-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C13-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C13-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C14-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C14-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C15-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C15-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C16-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C16-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C17-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C17-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C18-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C18-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C19-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C19-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C20-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C20-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C21-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C21-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C22-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C22-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C23-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C23-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C24-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C24-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C25-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C25-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C26-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C26-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C27-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C27-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C28-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C28-MG{PS:QM1B}I:Ps1DCCT1-I';'SR:C29-MG{PS:QM1A}I:Ps1DCCT1-I';'SR:C29-MG{PS:QM1B}I:Ps1DCCT1-I'];
AO.QM1.Monitor.Units          = 'Hardware';
AO.QM1.Monitor.HWUnits        = 'A';
AO.QM1.Monitor.PhysicsUnits   = 'm^-2';
AO.QM1.Monitor.HW2PhysicsFcn  = @amp2k;
AO.QM1.Monitor.Physics2HWFcn  = @k2amp;

AO.QM1.Setpoint.Mode          = OperationalMode;
AO.QM1.Setpoint.DataType      = 'Scalar';
AO.QM1.Setpoint.ChannelNames  = ['SR:C30-MG{PS:QM1A}I:Sp1-SP';'SR:C30-MG{PS:QM1B}I:Sp1-SP';'SR:C01-MG{PS:QM1A}I:Sp1-SP';'SR:C01-MG{PS:QM1B}I:Sp1-SP';'SR:C02-MG{PS:QM1A}I:Sp1-SP';'SR:C02-MG{PS:QM1B}I:Sp1-SP';'SR:C03-MG{PS:QM1A}I:Sp1-SP';'SR:C03-MG{PS:QM1B}I:Sp1-SP';'SR:C04-MG{PS:QM1A}I:Sp1-SP';'SR:C04-MG{PS:QM1B}I:Sp1-SP';'SR:C05-MG{PS:QM1A}I:Sp1-SP';'SR:C05-MG{PS:QM1B}I:Sp1-SP';'SR:C06-MG{PS:QM1A}I:Sp1-SP';'SR:C06-MG{PS:QM1B}I:Sp1-SP';'SR:C07-MG{PS:QM1A}I:Sp1-SP';'SR:C07-MG{PS:QM1B}I:Sp1-SP';'SR:C08-MG{PS:QM1A}I:Sp1-SP';'SR:C08-MG{PS:QM1B}I:Sp1-SP';'SR:C09-MG{PS:QM1A}I:Sp1-SP';'SR:C09-MG{PS:QM1B}I:Sp1-SP';'SR:C10-MG{PS:QM1A}I:Sp1-SP';'SR:C10-MG{PS:QM1B}I:Sp1-SP';'SR:C11-MG{PS:QM1A}I:Sp1-SP';'SR:C11-MG{PS:QM1B}I:Sp1-SP';'SR:C12-MG{PS:QM1A}I:Sp1-SP';'SR:C12-MG{PS:QM1B}I:Sp1-SP';'SR:C13-MG{PS:QM1A}I:Sp1-SP';'SR:C13-MG{PS:QM1B}I:Sp1-SP';'SR:C14-MG{PS:QM1A}I:Sp1-SP';'SR:C14-MG{PS:QM1B}I:Sp1-SP';'SR:C15-MG{PS:QM1A}I:Sp1-SP';'SR:C15-MG{PS:QM1B}I:Sp1-SP';'SR:C16-MG{PS:QM1A}I:Sp1-SP';'SR:C16-MG{PS:QM1B}I:Sp1-SP';'SR:C17-MG{PS:QM1A}I:Sp1-SP';'SR:C17-MG{PS:QM1B}I:Sp1-SP';'SR:C18-MG{PS:QM1A}I:Sp1-SP';'SR:C18-MG{PS:QM1B}I:Sp1-SP';'SR:C19-MG{PS:QM1A}I:Sp1-SP';'SR:C19-MG{PS:QM1B}I:Sp1-SP';'SR:C20-MG{PS:QM1A}I:Sp1-SP';'SR:C20-MG{PS:QM1B}I:Sp1-SP';'SR:C21-MG{PS:QM1A}I:Sp1-SP';'SR:C21-MG{PS:QM1B}I:Sp1-SP';'SR:C22-MG{PS:QM1A}I:Sp1-SP';'SR:C22-MG{PS:QM1B}I:Sp1-SP';'SR:C23-MG{PS:QM1A}I:Sp1-SP';'SR:C23-MG{PS:QM1B}I:Sp1-SP';'SR:C24-MG{PS:QM1A}I:Sp1-SP';'SR:C24-MG{PS:QM1B}I:Sp1-SP';'SR:C25-MG{PS:QM1A}I:Sp1-SP';'SR:C25-MG{PS:QM1B}I:Sp1-SP';'SR:C26-MG{PS:QM1A}I:Sp1-SP';'SR:C26-MG{PS:QM1B}I:Sp1-SP';'SR:C27-MG{PS:QM1A}I:Sp1-SP';'SR:C27-MG{PS:QM1B}I:Sp1-SP';'SR:C28-MG{PS:QM1A}I:Sp1-SP';'SR:C28-MG{PS:QM1B}I:Sp1-SP';'SR:C29-MG{PS:QM1A}I:Sp1-SP';'SR:C29-MG{PS:QM1B}I:Sp1-SP'];
AO.QM1.Setpoint.Units         = 'Hardware';
AO.QM1.Setpoint.HWUnits       = 'A';
AO.QM1.Setpoint.PhysicsUnits  = 'm^-2';
AO.QM1.Setpoint.HW2PhysicsFcn = @amp2k;
AO.QM1.Setpoint.Physics2HWFcn = @k2amp;
AO.QM1.Setpoint.DeltaRespMat  = 0.2;
AO.QM1.Setpoint.Range         = [0 200];

%QM1gain = -10.0e-3;  %  m^-2/A

% QM1. KL setpoint
AO.QM1.SPKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Setpoint'};
AO.QM1.SPKL.Mode = OperationalMode;
AO.QM1.SPKL.DataType = 'Scalar';
AO.QM1.SPKL.ChannelNames  = ['SR:C30-MG{PS:QM1A}K:Sp1-SP';'SR:C30-MG{PS:QM1B}K:Sp1-SP';'SR:C01-MG{PS:QM1A}K:Sp1-SP';'SR:C01-MG{PS:QM1B}K:Sp1-SP';'SR:C02-MG{PS:QM1A}K:Sp1-SP';'SR:C02-MG{PS:QM1B}K:Sp1-SP';'SR:C03-MG{PS:QM1A}K:Sp1-SP';'SR:C03-MG{PS:QM1B}K:Sp1-SP';'SR:C04-MG{PS:QM1A}K:Sp1-SP';'SR:C04-MG{PS:QM1B}K:Sp1-SP';'SR:C05-MG{PS:QM1A}K:Sp1-SP';'SR:C05-MG{PS:QM1B}K:Sp1-SP';'SR:C06-MG{PS:QM1A}K:Sp1-SP';'SR:C06-MG{PS:QM1B}K:Sp1-SP';'SR:C07-MG{PS:QM1A}K:Sp1-SP';'SR:C07-MG{PS:QM1B}K:Sp1-SP';'SR:C08-MG{PS:QM1A}K:Sp1-SP';'SR:C08-MG{PS:QM1B}K:Sp1-SP';'SR:C09-MG{PS:QM1A}K:Sp1-SP';'SR:C09-MG{PS:QM1B}K:Sp1-SP';'SR:C10-MG{PS:QM1A}K:Sp1-SP';'SR:C10-MG{PS:QM1B}K:Sp1-SP';'SR:C11-MG{PS:QM1A}K:Sp1-SP';'SR:C11-MG{PS:QM1B}K:Sp1-SP';'SR:C12-MG{PS:QM1A}K:Sp1-SP';'SR:C12-MG{PS:QM1B}K:Sp1-SP';'SR:C13-MG{PS:QM1A}K:Sp1-SP';'SR:C13-MG{PS:QM1B}K:Sp1-SP';'SR:C14-MG{PS:QM1A}K:Sp1-SP';'SR:C14-MG{PS:QM1B}K:Sp1-SP';'SR:C15-MG{PS:QM1A}K:Sp1-SP';'SR:C15-MG{PS:QM1B}K:Sp1-SP';'SR:C16-MG{PS:QM1A}K:Sp1-SP';'SR:C16-MG{PS:QM1B}K:Sp1-SP';'SR:C17-MG{PS:QM1A}K:Sp1-SP';'SR:C17-MG{PS:QM1B}K:Sp1-SP';'SR:C18-MG{PS:QM1A}K:Sp1-SP';'SR:C18-MG{PS:QM1B}K:Sp1-SP';'SR:C19-MG{PS:QM1A}K:Sp1-SP';'SR:C19-MG{PS:QM1B}K:Sp1-SP';'SR:C20-MG{PS:QM1A}K:Sp1-SP';'SR:C20-MG{PS:QM1B}K:Sp1-SP';'SR:C21-MG{PS:QM1A}K:Sp1-SP';'SR:C21-MG{PS:QM1B}K:Sp1-SP';'SR:C22-MG{PS:QM1A}K:Sp1-SP';'SR:C22-MG{PS:QM1B}K:Sp1-SP';'SR:C23-MG{PS:QM1A}K:Sp1-SP';'SR:C23-MG{PS:QM1B}K:Sp1-SP';'SR:C24-MG{PS:QM1A}K:Sp1-SP';'SR:C24-MG{PS:QM1B}K:Sp1-SP';'SR:C25-MG{PS:QM1A}K:Sp1-SP';'SR:C25-MG{PS:QM1B}K:Sp1-SP';'SR:C26-MG{PS:QM1A}K:Sp1-SP';'SR:C26-MG{PS:QM1B}K:Sp1-SP';'SR:C27-MG{PS:QM1A}K:Sp1-SP';'SR:C27-MG{PS:QM1B}K:Sp1-SP';'SR:C28-MG{PS:QM1A}K:Sp1-SP';'SR:C28-MG{PS:QM1B}K:Sp1-SP';'SR:C29-MG{PS:QM1A}K:Sp1-SP';'SR:C29-MG{PS:QM1B}K:Sp1-SP'];
AO.QM1.SPKL.Units = 'Hardware';
AO.QM1.SPKL.HWUnits     = 'T*m^-1';
% QM1. KL readback
AO.QM1.RBKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Readback'};
AO.QM1.RBKL.Mode = OperationalMode;
AO.QM1.RBKL.DataType = 'Scalar';
AO.QM1.RBKL.ChannelNames  = ['SR:C30-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C30-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C01-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C01-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C02-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C02-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C03-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C03-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C04-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C04-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C05-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C05-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C06-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C06-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C07-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C07-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C08-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C08-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C09-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C09-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C10-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C10-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C11-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C11-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C12-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C12-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C13-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C13-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C14-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C14-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C15-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C15-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C16-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C16-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C17-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C17-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C18-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C18-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C19-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C19-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C20-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C20-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C21-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C21-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C22-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C22-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C23-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C23-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C24-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C24-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C25-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C25-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C26-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C26-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C27-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C27-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C28-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C28-MG{PS:QM1B}K:Ps1DCCT1-I';'SR:C29-MG{PS:QM1A}K:Ps1DCCT1-I';'SR:C29-MG{PS:QM1B}K:Ps1DCCT1-I'];
AO.QM1.RBKL.Units = 'Hardware';
AO.QM1.RBKL.HWUnits     = 'T*m^-1';
% AO.QM1.Monitor.HW2PhysicsParams  = QM1gain;
% AO.QM1.Monitor.Physics2HWParams  = 1.0/QM1gain;
% AO.QM1.Setpoint.HW2PhysicsParams = QM1gain;
% AO.QM1.Setpoint.Physics2HWParams = 1.0/QM1gain;
AO.QM1.KLname=['rot_coil_QDW-9802-0023_000.txt';'rot_coil_QDP-9801-0023_000.txt';'rot_coil_QDW-9802-0028_000.txt';'rot_coil_QDP-9801-0016_000.txt';'rot_coil_QDW-9802-0004_001.txt';'rot_coil_QDP-9801-0009_000.txt';'rot_coil_QDW-9802-0005_001.txt';'rot_coil_QDP-9801-0005_000.txt';'rot_coil_QDW-9802-0009_000.txt';'rot_coil_QDP-9801-0010_000.txt';'rot_coil_QDW-9802-0008_001.txt';'rot_coil_QDP-9801-0008_000.txt';'rot_coil_QDW-9802-0011_000.txt';'rot_coil_QDP-9801-0011_000.txt';'rot_coil_QDW-9802-0019_000.txt';'rot_coil_QDP-9801-0021_000.txt';'rot_coil_QDW-9802-0010_000.txt';'rot_coil_QDP-9801-0007_000.txt';'rot_coil_QDW-9802-0007_000.txt';'rot_coil_QDP-9801-0014_000.txt';'rot_coil_QDW-9802-0020_000.txt';'rot_coil_QDP-9801-0012_000.txt';'rot_coil_QDW-9802-0012_000.txt';'rot_coil_QDP-9801-0015_000.txt';'rot_coil_QDW-9802-0016_000.txt';'rot_coil_QDP-9801-0024_000.txt';'rot_coil_QDW-9802-0021_000.txt';'rot_coil_QDP-9801-0022_000.txt';'rot_coil_QDW-9802-0017_000.txt';'rot_coil_QDP-9801-0013_000.txt';'rot_coil_QDW-9802-0014_000.txt';'rot_coil_QDP-9801-0006_000.txt';'rot_coil_QDW-9802-0022_000.txt';'rot_coil_QDP-9801-0017_000.txt';'rot_coil_QDW-9802-0027_000.txt';'rot_coil_QDP-9801-0029_000.txt';'rot_coil_QDW-9802-0025_000.txt';'rot_coil_QDP-9801-0019_000.txt';'rot_coil_QDW-9802-0030_000.txt';'rot_coil_QDP-9801-0027_000.txt';'rot_coil_QDW-9802-0029_000.txt';'rot_coil_QDP-9801-0025_000.txt';'rot_coil_QDW-9802-0026_000.txt';'rot_coil_QDP-9801-0030_000.txt';'rot_coil_QDW-9802-0013_000.txt';'rot_coil_QDP-9801-0028_000.txt';'rot_coil_QDW-9802-0015_000.txt';'rot_coil_QDP-9801-0018_000.txt';'rot_coil_QDW-9802-0001_001.txt';'rot_coil_QDP-9801-0001_001.txt';'rot_coil_QDW-9802-0002_001.txt';'rot_coil_QDP-9801-0002_001.txt';'rot_coil_QDW-9802-0003_001.txt';'rot_coil_QDP-9801-0003_001.txt';'rot_coil_QDW-9802-0024_000.txt';'rot_coil_QDP-9801-0020_000.txt';'rot_coil_QDW-9802-0018_000.txt';'rot_coil_QDP-9801-0026_000.txt';'rot_coil_QDW-9802-0006_001.txt';'rot_coil_QDP-9801-0004_000.txt'];


AO.QM2.FamilyName = 'QM2';
AO.QM2.MemberOf = {'MachineConfig'; 'PlotFamily'; 'QUAD'; 'Magnet'; 'Dispersion Corrector'};
AO.QM2.DeviceList = [30 1; 30 2; 1 1; 1 2; 2 1; 2 2; 3 1; 3 2; 4 1; 4 2; 5 1; 5 2; 6 1; 6 2; 7 1; 7 2; 8 1; 8 2; 9 1; 9 2; 10 1; 10 2; 11 1; 11 2; 12 1; 12 2; 13 1; 13 2; 14 1; 14 2; 15 1; 15 2; 16 1; 16 2; 17 1; 17 2; 18 1; 18 2; 19 1; 19 2; 20 1; 20 2; 21 1; 21 2; 22 1; 22 2; 23 1; 23 2; 24 1; 24 2; 25 1; 25 2; 26 1; 26 2; 27 1; 27 2; 28 1; 28 2; 29 1; 29 2];
AO.QM2.ElementList =(1:size(AO.QM2.DeviceList,1))';
AO.QM2.Status = ones(size(AO.QM2.DeviceList,1),1);
AO.QM2.CommonNames = ['qm2g4c30a';  'qm2g4c30b';  'qm2g4c01a';  'qm2g4c01b';  'qm2g4c02a';  'qm2g4c02b';  'qm2g4c03a';  'qm2g4c03b';  'qm2g4c04a';  'qm2g4c04b';  'qm2g4c05a';  'qm2g4c05b';  'qm2g4c06a';  'qm2g4c06b';  'qm2g4c07a';  'qm2g4c07b';  'qm2g4c08a';  'qm2g4c08b';  'qm2g4c09a';  'qm2g4c09b';  'qm2g4c10a';  'qm2g4c10b';  'qm2g4c11a';  'qm2g4c11b';  'qm2g4c12a';  'qm2g4c12b';  'qm2g4c13a';  'qm2g4c13b';  'qm2g4c14a';  'qm2g4c14b';  'qm2g4c15a';  'qm2g4c15b';  'qm2g4c16a';  'qm2g4c16b';  'qm2g4c17a';  'qm2g4c17b';  'qm2g4c18a';  'qm2g4c18b';  'qm2g4c19a';  'qm2g4c19b';  'qm2g4c20a';  'qm2g4c20b';  'qm2g4c21a';  'qm2g4c21b';  'qm2g4c22a';  'qm2g4c22b';  'qm2g4c23a';  'qm2g4c23b';  'qm2g4c24a';  'qm2g4c24b';  'qm2g4c25a';  'qm2g4c25b';  'qm2g4c26a';  'qm2g4c26b';  'qm2g4c27a';  'qm2g4c27b';  'qm2g4c28a';  'qm2g4c28b';  'qm2g4c29a';  'qm2g4c29b'];

AO.QM2.Monitor.Mode           = OperationalMode;
AO.QM2.Monitor.DataType       = 'Scalar';
AO.QM2.Monitor.ChannelNames  = [ 'SR:C30-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C30-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C01-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C01-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C02-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C02-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C03-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C03-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C04-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C04-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C05-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C05-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C06-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C06-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C07-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C07-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C08-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C08-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C09-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C09-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C10-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C10-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C11-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C11-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C12-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C12-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C13-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C13-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C14-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C14-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C15-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C15-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C16-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C16-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C17-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C17-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C18-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C18-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C19-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C19-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C20-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C20-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C21-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C21-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C22-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C22-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C23-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C23-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C24-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C24-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C25-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C25-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C26-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C26-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C27-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C27-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C28-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C28-MG{PS:QM2B}I:Ps1DCCT1-I';'SR:C29-MG{PS:QM2A}I:Ps1DCCT1-I';'SR:C29-MG{PS:QM2B}I:Ps1DCCT1-I' ];
AO.QM2.Monitor.Units          = 'Hardware';
AO.QM2.Monitor.HWUnits        = 'A';
AO.QM2.Monitor.PhysicsUnits   = 'm^-2';
AO.QM2.Monitor.HW2PhysicsFcn  = @amp2k;
AO.QM2.Monitor.Physics2HWFcn  = @k2amp;

AO.QM2.Setpoint.Mode          = OperationalMode;
AO.QM2.Setpoint.DataType      = 'Scalar';
AO.QM2.Setpoint.ChannelNames   = [ 'SR:C30-MG{PS:QM2A}I:Sp1-SP';'SR:C30-MG{PS:QM2B}I:Sp1-SP';'SR:C01-MG{PS:QM2A}I:Sp1-SP';'SR:C01-MG{PS:QM2B}I:Sp1-SP';'SR:C02-MG{PS:QM2A}I:Sp1-SP';'SR:C02-MG{PS:QM2B}I:Sp1-SP';'SR:C03-MG{PS:QM2A}I:Sp1-SP';'SR:C03-MG{PS:QM2B}I:Sp1-SP';'SR:C04-MG{PS:QM2A}I:Sp1-SP';'SR:C04-MG{PS:QM2B}I:Sp1-SP';'SR:C05-MG{PS:QM2A}I:Sp1-SP';'SR:C05-MG{PS:QM2B}I:Sp1-SP';'SR:C06-MG{PS:QM2A}I:Sp1-SP';'SR:C06-MG{PS:QM2B}I:Sp1-SP';'SR:C07-MG{PS:QM2A}I:Sp1-SP';'SR:C07-MG{PS:QM2B}I:Sp1-SP';'SR:C08-MG{PS:QM2A}I:Sp1-SP';'SR:C08-MG{PS:QM2B}I:Sp1-SP';'SR:C09-MG{PS:QM2A}I:Sp1-SP';'SR:C09-MG{PS:QM2B}I:Sp1-SP';'SR:C10-MG{PS:QM2A}I:Sp1-SP';'SR:C10-MG{PS:QM2B}I:Sp1-SP';'SR:C11-MG{PS:QM2A}I:Sp1-SP';'SR:C11-MG{PS:QM2B}I:Sp1-SP';'SR:C12-MG{PS:QM2A}I:Sp1-SP';'SR:C12-MG{PS:QM2B}I:Sp1-SP';'SR:C13-MG{PS:QM2A}I:Sp1-SP';'SR:C13-MG{PS:QM2B}I:Sp1-SP';'SR:C14-MG{PS:QM2A}I:Sp1-SP';'SR:C14-MG{PS:QM2B}I:Sp1-SP';'SR:C15-MG{PS:QM2A}I:Sp1-SP';'SR:C15-MG{PS:QM2B}I:Sp1-SP';'SR:C16-MG{PS:QM2A}I:Sp1-SP';'SR:C16-MG{PS:QM2B}I:Sp1-SP';'SR:C17-MG{PS:QM2A}I:Sp1-SP';'SR:C17-MG{PS:QM2B}I:Sp1-SP';'SR:C18-MG{PS:QM2A}I:Sp1-SP';'SR:C18-MG{PS:QM2B}I:Sp1-SP';'SR:C19-MG{PS:QM2A}I:Sp1-SP';'SR:C19-MG{PS:QM2B}I:Sp1-SP';'SR:C20-MG{PS:QM2A}I:Sp1-SP';'SR:C20-MG{PS:QM2B}I:Sp1-SP';'SR:C21-MG{PS:QM2A}I:Sp1-SP';'SR:C21-MG{PS:QM2B}I:Sp1-SP';'SR:C22-MG{PS:QM2A}I:Sp1-SP';'SR:C22-MG{PS:QM2B}I:Sp1-SP';'SR:C23-MG{PS:QM2A}I:Sp1-SP';'SR:C23-MG{PS:QM2B}I:Sp1-SP';'SR:C24-MG{PS:QM2A}I:Sp1-SP';'SR:C24-MG{PS:QM2B}I:Sp1-SP';'SR:C25-MG{PS:QM2A}I:Sp1-SP';'SR:C25-MG{PS:QM2B}I:Sp1-SP';'SR:C26-MG{PS:QM2A}I:Sp1-SP';'SR:C26-MG{PS:QM2B}I:Sp1-SP';'SR:C27-MG{PS:QM2A}I:Sp1-SP';'SR:C27-MG{PS:QM2B}I:Sp1-SP';'SR:C28-MG{PS:QM2A}I:Sp1-SP';'SR:C28-MG{PS:QM2B}I:Sp1-SP';'SR:C29-MG{PS:QM2A}I:Sp1-SP';'SR:C29-MG{PS:QM2B}I:Sp1-SP' ];
AO.QM2.Setpoint.Units         = 'Hardware';
AO.QM2.Setpoint.HWUnits       = 'A';
AO.QM2.Setpoint.PhysicsUnits  = 'm^-2';
AO.QM2.Setpoint.HW2PhysicsFcn = @amp2k;
AO.QM2.Setpoint.Physics2HWFcn = @k2amp;
AO.QM2.Setpoint.DeltaRespMat  = 0.2;
AO.QM2.Setpoint.Range         = [0 200];

%QM2gain = 12.0e-3;  %  m^-2/A

% QM2. KL setpoint
AO.QM2.SPKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Setpoint'};
AO.QM2.SPKL.Mode = OperationalMode;
AO.QM2.SPKL.DataType = 'Scalar';
AO.QM2.SPKL.ChannelNames  = [ 'SR:C30-MG{PS:QM2A}K:Sp1-SP';'SR:C30-MG{PS:QM2B}K:Sp1-SP';'SR:C01-MG{PS:QM2A}K:Sp1-SP';'SR:C01-MG{PS:QM2B}K:Sp1-SP';'SR:C02-MG{PS:QM2A}K:Sp1-SP';'SR:C02-MG{PS:QM2B}K:Sp1-SP';'SR:C03-MG{PS:QM2A}K:Sp1-SP';'SR:C03-MG{PS:QM2B}K:Sp1-SP';'SR:C04-MG{PS:QM2A}K:Sp1-SP';'SR:C04-MG{PS:QM2B}K:Sp1-SP';'SR:C05-MG{PS:QM2A}K:Sp1-SP';'SR:C05-MG{PS:QM2B}K:Sp1-SP';'SR:C06-MG{PS:QM2A}K:Sp1-SP';'SR:C06-MG{PS:QM2B}K:Sp1-SP';'SR:C07-MG{PS:QM2A}K:Sp1-SP';'SR:C07-MG{PS:QM2B}K:Sp1-SP';'SR:C08-MG{PS:QM2A}K:Sp1-SP';'SR:C08-MG{PS:QM2B}K:Sp1-SP';'SR:C09-MG{PS:QM2A}K:Sp1-SP';'SR:C09-MG{PS:QM2B}K:Sp1-SP';'SR:C10-MG{PS:QM2A}K:Sp1-SP';'SR:C10-MG{PS:QM2B}K:Sp1-SP';'SR:C11-MG{PS:QM2A}K:Sp1-SP';'SR:C11-MG{PS:QM2B}K:Sp1-SP';'SR:C12-MG{PS:QM2A}K:Sp1-SP';'SR:C12-MG{PS:QM2B}K:Sp1-SP';'SR:C13-MG{PS:QM2A}K:Sp1-SP';'SR:C13-MG{PS:QM2B}K:Sp1-SP';'SR:C14-MG{PS:QM2A}K:Sp1-SP';'SR:C14-MG{PS:QM2B}K:Sp1-SP';'SR:C15-MG{PS:QM2A}K:Sp1-SP';'SR:C15-MG{PS:QM2B}K:Sp1-SP';'SR:C16-MG{PS:QM2A}K:Sp1-SP';'SR:C16-MG{PS:QM2B}K:Sp1-SP';'SR:C17-MG{PS:QM2A}K:Sp1-SP';'SR:C17-MG{PS:QM2B}K:Sp1-SP';'SR:C18-MG{PS:QM2A}K:Sp1-SP';'SR:C18-MG{PS:QM2B}K:Sp1-SP';'SR:C19-MG{PS:QM2A}K:Sp1-SP';'SR:C19-MG{PS:QM2B}K:Sp1-SP';'SR:C20-MG{PS:QM2A}K:Sp1-SP';'SR:C20-MG{PS:QM2B}K:Sp1-SP';'SR:C21-MG{PS:QM2A}K:Sp1-SP';'SR:C21-MG{PS:QM2B}K:Sp1-SP';'SR:C22-MG{PS:QM2A}K:Sp1-SP';'SR:C22-MG{PS:QM2B}K:Sp1-SP';'SR:C23-MG{PS:QM2A}K:Sp1-SP';'SR:C23-MG{PS:QM2B}K:Sp1-SP';'SR:C24-MG{PS:QM2A}K:Sp1-SP';'SR:C24-MG{PS:QM2B}K:Sp1-SP';'SR:C25-MG{PS:QM2A}K:Sp1-SP';'SR:C25-MG{PS:QM2B}K:Sp1-SP';'SR:C26-MG{PS:QM2A}K:Sp1-SP';'SR:C26-MG{PS:QM2B}K:Sp1-SP';'SR:C27-MG{PS:QM2A}K:Sp1-SP';'SR:C27-MG{PS:QM2B}K:Sp1-SP';'SR:C28-MG{PS:QM2A}K:Sp1-SP';'SR:C28-MG{PS:QM2B}K:Sp1-SP';'SR:C29-MG{PS:QM2A}K:Sp1-SP';'SR:C29-MG{PS:QM2B}K:Sp1-SP' ];
AO.QM2.SPKL.Units = 'Hardware';
AO.QM2.SPKL.HWUnits     = 'T*m^-1';
% QM2. KL readback
AO.QM2.RBKL.MemberOf   = {'PlotFamily'; 'QUAD'; 'Magnet';'Readback'};
AO.QM2.RBKL.Mode = OperationalMode;
AO.QM2.RBKL.DataType = 'Scalar';
AO.QM2.RBKL.ChannelNames  = [ 'SR:C30-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C30-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C01-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C01-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C02-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C02-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C03-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C03-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C04-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C04-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C05-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C05-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C06-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C06-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C07-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C07-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C08-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C08-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C09-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C09-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C10-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C10-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C11-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C11-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C12-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C12-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C13-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C13-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C14-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C14-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C15-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C15-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C16-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C16-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C17-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C17-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C18-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C18-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C19-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C19-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C20-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C20-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C21-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C21-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C22-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C22-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C23-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C23-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C24-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C24-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C25-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C25-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C26-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C26-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C27-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C27-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C28-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C28-MG{PS:QM2B}K:Ps1DCCT1-I';'SR:C29-MG{PS:QM2A}K:Ps1DCCT1-I';'SR:C29-MG{PS:QM2B}K:Ps1DCCT1-I' ];
AO.QM2.RBKL.Units = 'Hardware';
AO.QM2.RBKL.HWUnits     = 'T*m^-1';
% AO.QM2.Monitor.HW2PhysicsParams  = QM2gain;
% AO.QM2.Monitor.Physics2HWParams  = 1.0/QM2gain;
% AO.QM2.Setpoint.HW2PhysicsParams = QM2gain;
% AO.QM2.Setpoint.Physics2HWParams = 1.0/QM2gain;
AO.QM2.KLname=['rot_coil_QDP-9815-0052_000.txt';'rot_coil_QDP-9815-0053_000.txt';'rot_coil_QDP-9815-0019_000.txt';'rot_coil_QDP-9815-0042_000.txt';'rot_coil_QDP-9815-0004_000.txt';'rot_coil_QDP-9815-0006_000.txt';'rot_coil_QDP-9815-0014_000.txt';'rot_coil_QDP-9815-0015_000.txt';'rot_coil_QDP-9815-0020_000.txt';'rot_coil_QDP-9815-0018_000.txt';'rot_coil_QDP-9815-0016_000.txt';'rot_coil_QDP-9815-0017_000.txt';'rot_coil_QDP-9815-0028_000.txt';'rot_coil_QDP-9815-0029_000.txt';'rot_coil_QDP-9815-0043_000.txt';'rot_coil_QDP-9815-0044_000.txt';'rot_coil_QDP-9815-0021_000.txt';'rot_coil_QDP-9815-0038_000.txt';'rot_coil_QDP-9815-0008_000.txt';'rot_coil_QDP-9815-0011_000.txt';'rot_coil_QDP-9815-0036_000.txt';'rot_coil_QDP-9815-0022_000.txt';'rot_coil_QDP-9815-0030_000.txt';'rot_coil_QDP-9815-0031_000.txt';'rot_coil_QDP-9815-0005_000.txt';'rot_coil_QDP-9815-0023_000.txt';'rot_coil_QDP-9815-0024_000.txt';'rot_coil_QDP-9815-0025_000.txt';'rot_coil_QDP-9815-0032_000.txt';'rot_coil_QDP-9815-0033_000.txt';'rot_coil_QDP-9815-0034_000.txt';'rot_coil_QDP-9815-0035_000.txt';'rot_coil_QDP-9815-0039_000.txt';'rot_coil_QDP-9815-0040_000.txt';'rot_coil_QDP-9815-0054_000.txt';'rot_coil_QDP-9815-0055_000.txt';'rot_coil_QDP-9815-0050_000.txt';'rot_coil_QDP-9815-0051_000.txt';'rot_coil_QDP-9815-0056_000.txt';'rot_coil_QDP-9815-0057_000.txt';'rot_coil_QDP-9815-0047_000.txt';'rot_coil_QDP-9815-0060_000.txt';'rot_coil_QDP-9815-0058_000.txt';'rot_coil_QDP-9815-0059_000.txt';'rot_coil_QDP-9815-0048_000.txt';'rot_coil_QDP-9815-0049_000.txt';'rot_coil_QDP-9815-0026_000.txt';'rot_coil_QDP-9815-0027_000.txt';'rot_coil_QDP-9815-0001_001.txt';'rot_coil_QDP-9815-0002_001.txt';'rot_coil_QDP-9815-0003_001.txt';'rot_coil_QDP-9815-0012_001.txt';'rot_coil_QDP-9815-0010_000.txt';'rot_coil_QDP-9815-0013_000.txt';'rot_coil_QDP-9815-0037_000.txt';'rot_coil_QDP-9815-0041_000.txt';'rot_coil_QDP-9815-0045_000.txt';'rot_coil_QDP-9815-0046_000.txt';'rot_coil_QDP-9815-0007_000.txt';'rot_coil_QDP-9815-0009_000.txt'];


%%%%%%%%%%%%%%
% Sextupoles %
%%%%%%%%%%%%%%

% Chromaticity correctors
AO.SM1.FamilyName = 'SM1';
AO.SM1.MemberOf = {'MachineConfig'; 'PlotFamily'; 'SEXT'; 'Magnet'; 'Chromaticity Corrector'};
AO.SM1.DeviceList = [30 1; 30 2; 1 1; 1 2; 2 1; 2 2; 3 1; 3 2; 4 1; 4 2; 5 1; 5 2; 6 1; 6 2; 7 1; 7 2; 8 1; 8 2; 9 1; 9 2; 10 1; 10 2; 11 1; 11 2; 12 1; 12 2; 13 1; 13 2; 14 1; 14 2; 15 1; 15 2; 16 1; 16 2; 17 1; 17 2; 18 1; 18 2; 19 1; 19 2; 20 1; 20 2; 21 1; 21 2; 22 1; 22 2; 23 1; 23 2; 24 1; 24 2; 25 1; 25 2; 26 1; 26 2; 27 1; 27 2; 28 1; 28 2; 29 1; 29 2];
AO.SM1.ElementList = (1:size(AO.SM1.DeviceList,1))';
AO.SM1.Status = ones(size(AO.SM1.DeviceList,1),1);
AO.SM1.CommonNames = ['sm1g4c30a';  'sm1g4c30b';  'sm1g4c01a';  'sm1g4c01b';  'sm1g4c02a';  'sm1g4c02b';  'sm1g4c03a';  'sm1g4c03b';  'sm1g4c04a';  'sm1g4c04b';  'sm1g4c05a';  'sm1g4c05b';  'sm1g4c06a';  'sm1g4c06b';  'sm1g4c07a';  'sm1g4c07b';  'sm1g4c08a';  'sm1g4c08b';  'sm1g4c09a';  'sm1g4c09b';  'sm1g4c10a';  'sm1g4c10b';  'sm1g4c11a';  'sm1g4c11b';  'sm1g4c12a';  'sm1g4c12b';  'sm1g4c13a';  'sm1g4c13b';  'sm1g4c14a';  'sm1g4c14b';  'sm1g4c15a';  'sm1g4c15b';  'sm1g4c16a';  'sm1g4c16b';  'sm1g4c17a';  'sm1g4c17b';  'sm1g4c18a';  'sm1g4c18b';  'sm1g4c19a';  'sm1g4c19b';  'sm1g4c20a';  'sm1g4c20b';  'sm1g4c21a';  'sm1g4c21b';  'sm1g4c22a';  'sm1g4c22b';  'sm1g4c23a';  'sm1g4c23b';  'sm1g4c24a';  'sm1g4c24b';  'sm1g4c25a';  'sm1g4c25b';  'sm1g4c26a';  'sm1g4c26b';  'sm1g4c27a';  'sm1g4c27b';  'sm1g4c28a';  'sm1g4c28b';  'sm1g4c29a';  'sm1g4c29b'];


AO.SM1.Monitor.Mode           = OperationalMode;
AO.SM1.Monitor.DataType       = 'Scalar';
AO.SM1.Monitor.Units          = 'Hardware';
AO.SM1.Monitor.HWUnits        = 'A';
AO.SM1.Monitor.PhysicsUnits   = 'm^-3';
AO.SM1.Monitor.HW2PhysicsFcn  = @amp2k;
AO.SM1.Monitor.Physics2HWFcn  = @k2amp;

AO.SM1.Setpoint.Mode          = OperationalMode;
AO.SM1.Setpoint.DataType      = 'Scalar';
AO.SM1.Setpoint.Units         = 'Hardware';
AO.SM1.Setpoint.HWUnits       = 'A';
AO.SM1.Setpoint.PhysicsUnits  = 'm^-3';
AO.SM1.Setpoint.HW2PhysicsFcn = @amp2k;
AO.SM1.Setpoint.Physics2HWFcn = @k2amp;

% AO.SM1.Monitor.HW2PhysicsParams  = SM1gain;
% AO.SM1.Monitor.Physics2HWParams  = 1.0/SM1gain;
% AO.SM1.Setpoint.HW2PhysicsParams = SM1gain;
% AO.SM1.Setpoint.Physics2HWParams = 1.0/SM1gain;

AO.SM1.Setpoint.ChannelNames  = ['SR:C01-MG{PS:SM1A-P2}I:Sp1-SP'; 'SR:C02-MG{PS:SM1B-P2}I:Sp1-SP'; 'SR:C01-MG{PS:SM1A-P2}I:Sp1-SP'; 'SR:C02-MG{PS:SM1B-P2}I:Sp1-SP'; 'SR:C01-MG{PS:SM1A-P2}I:Sp1-SP'; 'SR:C02-MG{PS:SM1B-P2}I:Sp1-SP'; 'SR:C01-MG{PS:SM1A-P2}I:Sp1-SP'; 'SR:C02-MG{PS:SM1B-P2}I:Sp1-SP'; 'SR:C01-MG{PS:SM1A-P2}I:Sp1-SP'; 'SR:C02-MG{PS:SM1B-P2}I:Sp1-SP'; 'SR:C07-MG{PS:SM1A-P3}I:Sp1-SP'; 'SR:C08-MG{PS:SM1B-P3}I:Sp1-SP'; 'SR:C07-MG{PS:SM1A-P3}I:Sp1-SP'; 'SR:C08-MG{PS:SM1B-P3}I:Sp1-SP'; 'SR:C07-MG{PS:SM1A-P3}I:Sp1-SP'; 'SR:C08-MG{PS:SM1B-P3}I:Sp1-SP'; 'SR:C07-MG{PS:SM1A-P3}I:Sp1-SP'; 'SR:C08-MG{PS:SM1B-P3}I:Sp1-SP'; 'SR:C07-MG{PS:SM1A-P3}I:Sp1-SP'; 'SR:C08-MG{PS:SM1B-P3}I:Sp1-SP'; 'SR:C07-MG{PS:SM1A-P3}I:Sp1-SP'; 'SR:C08-MG{PS:SM1B-P3}I:Sp1-SP'; 'SR:C13-MG{PS:SM1A-P4}I:Sp1-SP'; 'SR:C14-MG{PS:SM1B-P4}I:Sp1-SP'; 'SR:C13-MG{PS:SM1A-P4}I:Sp1-SP'; 'SR:C14-MG{PS:SM1B-P4}I:Sp1-SP'; 'SR:C13-MG{PS:SM1A-P4}I:Sp1-SP'; 'SR:C14-MG{PS:SM1B-P4}I:Sp1-SP'; 'SR:C13-MG{PS:SM1A-P4}I:Sp1-SP'; 'SR:C14-MG{PS:SM1B-P4}I:Sp1-SP'; 'SR:C13-MG{PS:SM1A-P4}I:Sp1-SP'; 'SR:C14-MG{PS:SM1B-P4}I:Sp1-SP'; 'SR:C13-MG{PS:SM1A-P4}I:Sp1-SP'; 'SR:C14-MG{PS:SM1B-P4}I:Sp1-SP'; 'SR:C19-MG{PS:SM1A-P5}I:Sp1-SP'; 'SR:C20-MG{PS:SM1B-P5}I:Sp1-SP'; 'SR:C19-MG{PS:SM1A-P5}I:Sp1-SP'; 'SR:C20-MG{PS:SM1B-P5}I:Sp1-SP'; 'SR:C19-MG{PS:SM1A-P5}I:Sp1-SP'; 'SR:C20-MG{PS:SM1B-P5}I:Sp1-SP'; 'SR:C19-MG{PS:SM1A-P5}I:Sp1-SP'; 'SR:C20-MG{PS:SM1B-P5}I:Sp1-SP'; 'SR:C19-MG{PS:SM1A-P5}I:Sp1-SP'; 'SR:C20-MG{PS:SM1B-P5}I:Sp1-SP'; 'SR:C19-MG{PS:SM1A-P5}I:Sp1-SP'; 'SR:C20-MG{PS:SM1B-P5}I:Sp1-SP'; 'SR:C25-MG{PS:SM1A-P1}I:Sp1-SP'; 'SR:C26-MG{PS:SM1B-P1}I:Sp1-SP'; 'SR:C25-MG{PS:SM1A-P1}I:Sp1-SP'; 'SR:C26-MG{PS:SM1B-P1}I:Sp1-SP'; 'SR:C25-MG{PS:SM1A-P1}I:Sp1-SP'; 'SR:C26-MG{PS:SM1B-P1}I:Sp1-SP'; 'SR:C25-MG{PS:SM1A-P1}I:Sp1-SP'; 'SR:C26-MG{PS:SM1B-P1}I:Sp1-SP'; 'SR:C25-MG{PS:SM1A-P1}I:Sp1-SP'; 'SR:C26-MG{PS:SM1B-P1}I:Sp1-SP'; 'SR:C25-MG{PS:SM1A-P1}I:Sp1-SP'; 'SR:C26-MG{PS:SM1B-P1}I:Sp1-SP'; 'SR:C01-MG{PS:SM1A-P2}I:Sp1-SP'; 'SR:C02-MG{PS:SM1B-P2}I:Sp1-SP'];
AO.SM1.Monitor.ChannelNames = ['SR:C01-MG{PS:SM1A-P2}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SM1B-P2}I:Ps1DCCT1-I'; 'SR:C01-MG{PS:SM1A-P2}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SM1B-P2}I:Ps1DCCT1-I'; 'SR:C01-MG{PS:SM1A-P2}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SM1B-P2}I:Ps1DCCT1-I'; 'SR:C01-MG{PS:SM1A-P2}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SM1B-P2}I:Ps1DCCT1-I'; 'SR:C01-MG{PS:SM1A-P2}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SM1B-P2}I:Ps1DCCT1-I'; 'SR:C07-MG{PS:SM1A-P3}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM1B-P3}I:Ps1DCCT1-I'; 'SR:C07-MG{PS:SM1A-P3}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM1B-P3}I:Ps1DCCT1-I'; 'SR:C07-MG{PS:SM1A-P3}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM1B-P3}I:Ps1DCCT1-I'; 'SR:C07-MG{PS:SM1A-P3}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM1B-P3}I:Ps1DCCT1-I'; 'SR:C07-MG{PS:SM1A-P3}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM1B-P3}I:Ps1DCCT1-I'; 'SR:C07-MG{PS:SM1A-P3}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM1B-P3}I:Ps1DCCT1-I'; 'SR:C13-MG{PS:SM1A-P4}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM1B-P4}I:Ps1DCCT1-I'; 'SR:C13-MG{PS:SM1A-P4}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM1B-P4}I:Ps1DCCT1-I'; 'SR:C13-MG{PS:SM1A-P4}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM1B-P4}I:Ps1DCCT1-I'; 'SR:C13-MG{PS:SM1A-P4}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM1B-P4}I:Ps1DCCT1-I'; 'SR:C13-MG{PS:SM1A-P4}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM1B-P4}I:Ps1DCCT1-I'; 'SR:C13-MG{PS:SM1A-P4}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM1B-P4}I:Ps1DCCT1-I'; 'SR:C19-MG{PS:SM1A-P5}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM1B-P5}I:Ps1DCCT1-I'; 'SR:C19-MG{PS:SM1A-P5}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM1B-P5}I:Ps1DCCT1-I'; 'SR:C19-MG{PS:SM1A-P5}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM1B-P5}I:Ps1DCCT1-I'; 'SR:C19-MG{PS:SM1A-P5}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM1B-P5}I:Ps1DCCT1-I'; 'SR:C19-MG{PS:SM1A-P5}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM1B-P5}I:Ps1DCCT1-I'; 'SR:C19-MG{PS:SM1A-P5}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM1B-P5}I:Ps1DCCT1-I'; 'SR:C25-MG{PS:SM1A-P1}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM1B-P1}I:Ps1DCCT1-I'; 'SR:C25-MG{PS:SM1A-P1}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM1B-P1}I:Ps1DCCT1-I'; 'SR:C25-MG{PS:SM1A-P1}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM1B-P1}I:Ps1DCCT1-I'; 'SR:C25-MG{PS:SM1A-P1}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM1B-P1}I:Ps1DCCT1-I'; 'SR:C25-MG{PS:SM1A-P1}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM1B-P1}I:Ps1DCCT1-I'; 'SR:C25-MG{PS:SM1A-P1}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM1B-P1}I:Ps1DCCT1-I'; 'SR:C01-MG{PS:SM1A-P2}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SM1B-P2}I:Ps1DCCT1-I'];
AO.SM1.CommonNames = ['sm1g4c30a'; 'sm1g4c30b'; 'sm1g4c01a'; 'sm1g4c01b'; 'sm1g4c02a'; 'sm1g4c02b'; 'sm1g4c03a'; 'sm1g4c03b'; 'sm1g4c04a'; 'sm1g4c04b'; 'sm1g4c05a'; 'sm1g4c05b'; 'sm1g4c06a'; 'sm1g4c06b'; 'sm1g4c07a'; 'sm1g4c07b'; 'sm1g4c08a'; 'sm1g4c08b'; 'sm1g4c09a'; 'sm1g4c09b'; 'sm1g4c10a'; 'sm1g4c10b'; 'sm1g4c11a'; 'sm1g4c11b'; 'sm1g4c12a'; 'sm1g4c12b'; 'sm1g4c13a'; 'sm1g4c13b'; 'sm1g4c14a'; 'sm1g4c14b'; 'sm1g4c15a'; 'sm1g4c15b'; 'sm1g4c16a'; 'sm1g4c16b'; 'sm1g4c17a'; 'sm1g4c17b'; 'sm1g4c18a'; 'sm1g4c18b'; 'sm1g4c19a'; 'sm1g4c19b'; 'sm1g4c20a'; 'sm1g4c20b'; 'sm1g4c21a'; 'sm1g4c21b'; 'sm1g4c22a'; 'sm1g4c22b'; 'sm1g4c23a'; 'sm1g4c23b'; 'sm1g4c24a'; 'sm1g4c24b'; 'sm1g4c25a'; 'sm1g4c25b'; 'sm1g4c26a'; 'sm1g4c26b'; 'sm1g4c27a'; 'sm1g4c27b'; 'sm1g4c28a'; 'sm1g4c28b'; 'sm1g4c29a'; 'sm1g4c29b'];

AO.SM1.Setpoint.Tolerance = 0.1;
AO.SM1.Setpoint.DeltaRespMat = 0.01;

SM1range = 200;
for i=1:30
    for j=1:2
        k=j+2*(i-1);
        AO.SM1.Setpoint.Range(k,:)        = [0 SM1range];
        AO.SM1.Setpoint.Tolerance(k)      = 0.1;
        AO.SM1.Setpoint.DeltaRespMat(k,1) = 0.5;
    end
end

% SM1. KL setpoint
AO.SM1.SPKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Setpoint'};
AO.SM1.SPKL.Mode = OperationalMode;
AO.SM1.SPKL.DataType = 'Scalar';
AO.SM1.SPKL.ChannelNames  = ['SR:C30-MG{PS:SM1A-P2}K:Sp1-SP';'SR:C30-MG{PS:SM1B-P2}K:Sp1-SP';'SR:C01-MG{PS:SM1A-P2}K:Sp1-SP';'SR:C01-MG{PS:SM1B-P2}K:Sp1-SP';'SR:C02-MG{PS:SM1A-P2}K:Sp1-SP';'SR:C02-MG{PS:SM1B-P2}K:Sp1-SP';'SR:C03-MG{PS:SM1A-P2}K:Sp1-SP';'SR:C03-MG{PS:SM1B-P2}K:Sp1-SP';'SR:C04-MG{PS:SM1A-P2}K:Sp1-SP';'SR:C04-MG{PS:SM1B-P2}K:Sp1-SP';'SR:C05-MG{PS:SM1A-P3}K:Sp1-SP';'SR:C05-MG{PS:SM1B-P3}K:Sp1-SP';'SR:C06-MG{PS:SM1A-P3}K:Sp1-SP';'SR:C06-MG{PS:SM1B-P3}K:Sp1-SP';'SR:C07-MG{PS:SM1A-P3}K:Sp1-SP';'SR:C07-MG{PS:SM1B-P3}K:Sp1-SP';'SR:C08-MG{PS:SM1A-P3}K:Sp1-SP';'SR:C08-MG{PS:SM1B-P3}K:Sp1-SP';'SR:C09-MG{PS:SM1A-P3}K:Sp1-SP';'SR:C09-MG{PS:SM1B-P3}K:Sp1-SP';'SR:C10-MG{PS:SM1A-P3}K:Sp1-SP';'SR:C10-MG{PS:SM1B-P3}K:Sp1-SP';'SR:C11-MG{PS:SM1A-P4}K:Sp1-SP';'SR:C11-MG{PS:SM1B-P4}K:Sp1-SP';'SR:C12-MG{PS:SM1A-P4}K:Sp1-SP';'SR:C12-MG{PS:SM1B-P4}K:Sp1-SP';'SR:C13-MG{PS:SM1A-P4}K:Sp1-SP';'SR:C13-MG{PS:SM1B-P4}K:Sp1-SP';'SR:C14-MG{PS:SM1A-P4}K:Sp1-SP';'SR:C14-MG{PS:SM1B-P4}K:Sp1-SP';'SR:C15-MG{PS:SM1A-P4}K:Sp1-SP';'SR:C15-MG{PS:SM1B-P4}K:Sp1-SP';'SR:C16-MG{PS:SM1A-P4}K:Sp1-SP';'SR:C16-MG{PS:SM1B-P4}K:Sp1-SP';'SR:C17-MG{PS:SM1A-P5}K:Sp1-SP';'SR:C17-MG{PS:SM1B-P5}K:Sp1-SP';'SR:C18-MG{PS:SM1A-P5}K:Sp1-SP';'SR:C18-MG{PS:SM1B-P5}K:Sp1-SP';'SR:C19-MG{PS:SM1A-P5}K:Sp1-SP';'SR:C19-MG{PS:SM1B-P5}K:Sp1-SP';'SR:C20-MG{PS:SM1A-P5}K:Sp1-SP';'SR:C20-MG{PS:SM1B-P5}K:Sp1-SP';'SR:C21-MG{PS:SM1A-P5}K:Sp1-SP';'SR:C21-MG{PS:SM1B-P5}K:Sp1-SP';'SR:C22-MG{PS:SM1A-P5}K:Sp1-SP';'SR:C22-MG{PS:SM1B-P5}K:Sp1-SP';'SR:C23-MG{PS:SM1A-P1}K:Sp1-SP';'SR:C23-MG{PS:SM1B-P1}K:Sp1-SP';'SR:C24-MG{PS:SM1A-P1}K:Sp1-SP';'SR:C24-MG{PS:SM1B-P1}K:Sp1-SP';'SR:C25-MG{PS:SM1A-P1}K:Sp1-SP';'SR:C25-MG{PS:SM1B-P1}K:Sp1-SP';'SR:C26-MG{PS:SM1A-P1}K:Sp1-SP';'SR:C26-MG{PS:SM1B-P1}K:Sp1-SP';'SR:C27-MG{PS:SM1A-P1}K:Sp1-SP';'SR:C27-MG{PS:SM1B-P1}K:Sp1-SP';'SR:C28-MG{PS:SM1A-P1}K:Sp1-SP';'SR:C28-MG{PS:SM1B-P1}K:Sp1-SP';'SR:C29-MG{PS:SM1A-P2}K:Sp1-SP';'SR:C29-MG{PS:SM1B-P2}K:Sp1-SP'];
AO.SM1.SPKL.Units = 'Hardware';
AO.SM1.SPKL.HWUnits     = 'T*m^-2';
% SM1. KL readback
AO.SM1.RBKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Readback'};
AO.SM1.RBKL.Mode = OperationalMode;
AO.SM1.RBKL.DataType = 'Scalar';
AO.SM1.RBKL.ChannelNames  = ['SR:C30-MG{PS:SM1A-P2}K:Ps1DCCT1-I';'SR:C30-MG{PS:SM1B-P2}K:Ps1DCCT1-I';'SR:C01-MG{PS:SM1A-P2}K:Ps1DCCT1-I';'SR:C01-MG{PS:SM1B-P2}K:Ps1DCCT1-I';'SR:C02-MG{PS:SM1A-P2}K:Ps1DCCT1-I';'SR:C02-MG{PS:SM1B-P2}K:Ps1DCCT1-I';'SR:C03-MG{PS:SM1A-P2}K:Ps1DCCT1-I';'SR:C03-MG{PS:SM1B-P2}K:Ps1DCCT1-I';'SR:C04-MG{PS:SM1A-P2}K:Ps1DCCT1-I';'SR:C04-MG{PS:SM1B-P2}K:Ps1DCCT1-I';'SR:C05-MG{PS:SM1A-P3}K:Ps1DCCT1-I';'SR:C05-MG{PS:SM1B-P3}K:Ps1DCCT1-I';'SR:C06-MG{PS:SM1A-P3}K:Ps1DCCT1-I';'SR:C06-MG{PS:SM1B-P3}K:Ps1DCCT1-I';'SR:C07-MG{PS:SM1A-P3}K:Ps1DCCT1-I';'SR:C07-MG{PS:SM1B-P3}K:Ps1DCCT1-I';'SR:C08-MG{PS:SM1A-P3}K:Ps1DCCT1-I';'SR:C08-MG{PS:SM1B-P3}K:Ps1DCCT1-I';'SR:C09-MG{PS:SM1A-P3}K:Ps1DCCT1-I';'SR:C09-MG{PS:SM1B-P3}K:Ps1DCCT1-I';'SR:C10-MG{PS:SM1A-P3}K:Ps1DCCT1-I';'SR:C10-MG{PS:SM1B-P3}K:Ps1DCCT1-I';'SR:C11-MG{PS:SM1A-P4}K:Ps1DCCT1-I';'SR:C11-MG{PS:SM1B-P4}K:Ps1DCCT1-I';'SR:C12-MG{PS:SM1A-P4}K:Ps1DCCT1-I';'SR:C12-MG{PS:SM1B-P4}K:Ps1DCCT1-I';'SR:C13-MG{PS:SM1A-P4}K:Ps1DCCT1-I';'SR:C13-MG{PS:SM1B-P4}K:Ps1DCCT1-I';'SR:C14-MG{PS:SM1A-P4}K:Ps1DCCT1-I';'SR:C14-MG{PS:SM1B-P4}K:Ps1DCCT1-I';'SR:C15-MG{PS:SM1A-P4}K:Ps1DCCT1-I';'SR:C15-MG{PS:SM1B-P4}K:Ps1DCCT1-I';'SR:C16-MG{PS:SM1A-P4}K:Ps1DCCT1-I';'SR:C16-MG{PS:SM1B-P4}K:Ps1DCCT1-I';'SR:C17-MG{PS:SM1A-P5}K:Ps1DCCT1-I';'SR:C17-MG{PS:SM1B-P5}K:Ps1DCCT1-I';'SR:C18-MG{PS:SM1A-P5}K:Ps1DCCT1-I';'SR:C18-MG{PS:SM1B-P5}K:Ps1DCCT1-I';'SR:C19-MG{PS:SM1A-P5}K:Ps1DCCT1-I';'SR:C19-MG{PS:SM1B-P5}K:Ps1DCCT1-I';'SR:C20-MG{PS:SM1A-P5}K:Ps1DCCT1-I';'SR:C20-MG{PS:SM1B-P5}K:Ps1DCCT1-I';'SR:C21-MG{PS:SM1A-P5}K:Ps1DCCT1-I';'SR:C21-MG{PS:SM1B-P5}K:Ps1DCCT1-I';'SR:C22-MG{PS:SM1A-P5}K:Ps1DCCT1-I';'SR:C22-MG{PS:SM1B-P5}K:Ps1DCCT1-I';'SR:C23-MG{PS:SM1A-P1}K:Ps1DCCT1-I';'SR:C23-MG{PS:SM1B-P1}K:Ps1DCCT1-I';'SR:C24-MG{PS:SM1A-P1}K:Ps1DCCT1-I';'SR:C24-MG{PS:SM1B-P1}K:Ps1DCCT1-I';'SR:C25-MG{PS:SM1A-P1}K:Ps1DCCT1-I';'SR:C25-MG{PS:SM1B-P1}K:Ps1DCCT1-I';'SR:C26-MG{PS:SM1A-P1}K:Ps1DCCT1-I';'SR:C26-MG{PS:SM1B-P1}K:Ps1DCCT1-I';'SR:C27-MG{PS:SM1A-P1}K:Ps1DCCT1-I';'SR:C27-MG{PS:SM1B-P1}K:Ps1DCCT1-I';'SR:C28-MG{PS:SM1A-P1}K:Ps1DCCT1-I';'SR:C28-MG{PS:SM1B-P1}K:Ps1DCCT1-I';'SR:C29-MG{PS:SM1A-P2}K:Ps1DCCT1-I';'SR:C29-MG{PS:SM1B-P2}K:Ps1DCCT1-I'];
AO.SM1.RBKL.Units = 'Hardware';
AO.SM1.RBKL.HWUnits     = 'T*m^-2';
AO.SM1.KLname=['rot_coil_STP-9802-0070_000.txt';'rot_coil_STP-9801-0147_000.txt';'rot_coil_STP-9801-0133_000.txt';'rot_coil_STP-9801-0134_000.txt';'rot_coil_STP-9802-0009_001.txt';'rot_coil_STP-9801-0026_000.txt';'rot_coil_STP-9802-0015_001.txt';'rot_coil_STP-9801-0027_000.txt';'rot_coil_STP-9802-0025_001.txt';'rot_coil_STP-9801-0030_000.txt';'rot_coil_STP-9802-0014_000.txt';'rot_coil_STP-9801-0029_000.txt';'rot_coil_STP-9802-0018_000.txt';'rot_coil_STP-9801-0031_000.txt';'rot_coil_STP-9802-0051_000.txt';'rot_coil_STP-9801-0065_000.txt';'rot_coil_STP-9802-0050_000.txt';'rot_coil_STP-9801-0066_000.txt';'rot_coil_STP-9802-0013_000.txt';'rot_coil_STP-9801-0032_000.txt';'rot_coil_STP-9802-0027_000.txt';'rot_coil_STP-9801-0056_000.txt';'rot_coil_STP-9802-0034_000.txt';'rot_coil_STP-9801-0045_001.txt';'rot_coil_STP-9802-0031_001.txt';'rot_coil_STP-9801-0006_000.txt';'rot_coil_STP-9802-0038_000.txt';'rot_coil_STP-9801-0017_000.txt';'rot_coil_STP-9802-0032_001.txt';'rot_coil_STP-9801-0047_001.txt';'rot_coil_STP-9802-0047_001.txt';'rot_coil_STP-9801-0019_001.txt';'rot_coil_STP-9802-0035_002.txt';'rot_coil_STP-9801-0049_001.txt';'rot_coil_STP-9802-0076_001.txt';'rot_coil_STP-9801-0117_000.txt';'rot_coil_STP-9802-0074_000.txt';'rot_coil_STP-9801-0145_000.txt';'rot_coil_STP-9802-0055_001.txt';'rot_coil_STP-9801-0148_000.txt';'rot_coil_STP-9802-0066_000.txt';'rot_coil_STP-9801-0091_000.txt';'rot_coil_STP-9802-0075_000.txt';'rot_coil_STP-9801-0123_000.txt';'rot_coil_STP-9802-0065_001.txt';'rot_coil_STP-9801-0106_000.txt';'rot_coil_STP-9802-0046_000.txt';'rot_coil_STP-9801-0053_001.txt';'rot_coil_STP-9802-0010_002.txt';'rot_coil_STP-9801-0010_001.txt';'rot_coil_STP-9802-0012_001.txt';'rot_coil_STP-9801-0023_001.txt';'rot_coil_STP-9802-0022_001.txt';'rot_coil_STP-9801-0024_001.txt';'rot_coil_STP-9802-0028_000.txt';'rot_coil_STP-9801-0061_000.txt';'rot_coil_STP-9802-0039_000.txt';'rot_coil_STP-9801-0062_000.txt';'rot_coil_STP-9802-0024_002.txt';'rot_coil_STP-9801-0028_000.txt'];



AO.SM2.FamilyName = 'SM2';
AO.SM2.MemberOf = {'MachineConfig'; 'PlotFamily'; 'SEXT'; 'Magnet'; 'Chromaticity Corrector'};
AO.SM2.CommonNames = ['sm2g4c30b';  'sm2g4c01b';  'sm2g4c02b';  'sm2g4c03b';  'sm2g4c04b';  'sm2g4c05b';  'sm2g4c06b';  'sm2g4c07b';  'sm2g4c08b';  'sm2g4c09b';  'sm2g4c10b';  'sm2g4c11b';  'sm2g4c12b';  'sm2g4c13b';  'sm2g4c14b';  'sm2g4c15b';  'sm2g4c16b';  'sm2g4c17b';  'sm2g4c18b';  'sm2g4c19b';  'sm2g4c20b';  'sm2g4c21b';  'sm2g4c22b';  'sm2g4c23b';  'sm2g4c24b';  'sm2g4c25b';  'sm2g4c26b';  'sm2g4c27b';  'sm2g4c28b';  'sm2g4c29b'];



AO.SM2.Monitor.Mode           = OperationalMode;
AO.SM2.Monitor.DataType       = 'Scalar';
AO.SM2.Monitor.Units          = 'Hardware';
AO.SM2.Monitor.HWUnits        = 'A';
AO.SM2.Monitor.PhysicsUnits   = 'm^-3';
AO.SM2.Monitor.HW2PhysicsFcn  = @amp2k;
AO.SM2.Monitor.Physics2HWFcn  = @k2amp;

AO.SM2.Setpoint.Mode          = OperationalMode;
AO.SM2.Setpoint.DataType      = 'Scalar';
AO.SM2.Setpoint.Units         = 'Hardware';
AO.SM2.Setpoint.HWUnits       = 'A';
AO.SM2.Setpoint.PhysicsUnits  = 'm^-3';
AO.SM2.Setpoint.HW2PhysicsFcn = @amp2k;
AO.SM2.Setpoint.Physics2HWFcn = @k2amp;

SM2range = 200;

% AO.SM2.Monitor.HW2PhysicsParams  = SM2gain;
% AO.SM2.Monitor.Physics2HWParams  = 1.0/SM2gain;
% AO.SM2.Setpoint.HW2PhysicsParams = SM2gain;
% AO.SM2.Setpoint.Physics2HWParams = 1.0/SM2gain;

AO.SM2.Monitor.ChannelNames  = ['SR:C02-MG{PS:SM2B-P2}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SM2B-P2}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SM2B-P2}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SM2B-P2}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SM2B-P2}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM2B-P3}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM2B-P3}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM2B-P3}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM2B-P3}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM2B-P3}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SM2B-P3}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM2B-P4}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM2B-P4}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM2B-P4}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM2B-P4}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM2B-P4}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SM2B-P4}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM2B-P5}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM2B-P5}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM2B-P5}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM2B-P5}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM2B-P5}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SM2B-P5}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM2B-P1}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM2B-P1}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM2B-P1}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM2B-P1}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM2B-P1}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SM2B-P1}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SM2B-P2}I:Ps1DCCT1-I'];
AO.SM2.Setpoint.ChannelNames = ['SR:C02-MG{PS:SM2B-P2}I:Sp1-SP'; 'SR:C02-MG{PS:SM2B-P2}I:Sp1-SP'; 'SR:C02-MG{PS:SM2B-P2}I:Sp1-SP'; 'SR:C02-MG{PS:SM2B-P2}I:Sp1-SP'; 'SR:C02-MG{PS:SM2B-P2}I:Sp1-SP'; 'SR:C08-MG{PS:SM2B-P3}I:Sp1-SP'; 'SR:C08-MG{PS:SM2B-P3}I:Sp1-SP'; 'SR:C08-MG{PS:SM2B-P3}I:Sp1-SP'; 'SR:C08-MG{PS:SM2B-P3}I:Sp1-SP'; 'SR:C08-MG{PS:SM2B-P3}I:Sp1-SP'; 'SR:C08-MG{PS:SM2B-P3}I:Sp1-SP'; 'SR:C14-MG{PS:SM2B-P4}I:Sp1-SP'; 'SR:C14-MG{PS:SM2B-P4}I:Sp1-SP'; 'SR:C14-MG{PS:SM2B-P4}I:Sp1-SP'; 'SR:C14-MG{PS:SM2B-P4}I:Sp1-SP'; 'SR:C14-MG{PS:SM2B-P4}I:Sp1-SP'; 'SR:C14-MG{PS:SM2B-P4}I:Sp1-SP'; 'SR:C20-MG{PS:SM2B-P5}I:Sp1-SP'; 'SR:C20-MG{PS:SM2B-P5}I:Sp1-SP'; 'SR:C20-MG{PS:SM2B-P5}I:Sp1-SP'; 'SR:C20-MG{PS:SM2B-P5}I:Sp1-SP'; 'SR:C20-MG{PS:SM2B-P5}I:Sp1-SP'; 'SR:C20-MG{PS:SM2B-P5}I:Sp1-SP'; 'SR:C26-MG{PS:SM2B-P1}I:Sp1-SP'; 'SR:C26-MG{PS:SM2B-P1}I:Sp1-SP'; 'SR:C26-MG{PS:SM2B-P1}I:Sp1-SP'; 'SR:C26-MG{PS:SM2B-P1}I:Sp1-SP'; 'SR:C26-MG{PS:SM2B-P1}I:Sp1-SP'; 'SR:C26-MG{PS:SM2B-P1}I:Sp1-SP'; 'SR:C02-MG{PS:SM2B-P2}I:Sp1-SP'];
AO.SM2.CommonNames = ['sm2g4c30b'; 'sm2g4c01b'; 'sm2g4c02b'; 'sm2g4c03b'; 'sm2g4c04b'; 'sm2g4c05b'; 'sm2g4c06b'; 'sm2g4c07b'; 'sm2g4c08b'; 'sm2g4c09b'; 'sm2g4c10b'; 'sm2g4c11b'; 'sm2g4c12b'; 'sm2g4c13b'; 'sm2g4c14b'; 'sm2g4c15b'; 'sm2g4c16b'; 'sm2g4c17b'; 'sm2g4c18b'; 'sm2g4c19b'; 'sm2g4c20b'; 'sm2g4c21b'; 'sm2g4c22b'; 'sm2g4c23b'; 'sm2g4c24b'; 'sm2g4c25b'; 'sm2g4c26b'; 'sm2g4c27b'; 'sm2g4c28b'; 'sm2g4c29b'];
AO.SM2.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];
for i=1:30
    AO.SM2.Status(i,1)                = 1;
    AO.SM2.ElementList(i,1)           = i;
    AO.SM2.Setpoint.Range(i,:)        = [0 SM2range];
    AO.SM2.Setpoint.Tolerance(i)      = 0.1;
    AO.SM2.Setpoint.DeltaRespMat(i,1)   = 0.5;
end
% SM2 KL setpoint
AO.SM2.SPKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Setpoint'};
AO.SM2.SPKL.Mode = OperationalMode;
AO.SM2.SPKL.DataType = 'Scalar';
AO.SM2.SPKL.ChannelNames  = ['SR:C30-MG{PS:SM2B-P2}K:Sp1-SP';'SR:C01-MG{PS:SM2B-P2}K:Sp1-SP';'SR:C02-MG{PS:SM2B-P2}K:Sp1-SP';'SR:C03-MG{PS:SM2B-P2}K:Sp1-SP';'SR:C04-MG{PS:SM2B-P2}K:Sp1-SP';'SR:C05-MG{PS:SM2B-P3}K:Sp1-SP';'SR:C06-MG{PS:SM2B-P3}K:Sp1-SP';'SR:C07-MG{PS:SM2B-P3}K:Sp1-SP';'SR:C08-MG{PS:SM2B-P3}K:Sp1-SP';'SR:C09-MG{PS:SM2B-P3}K:Sp1-SP';'SR:C10-MG{PS:SM2B-P3}K:Sp1-SP';'SR:C11-MG{PS:SM2B-P4}K:Sp1-SP';'SR:C12-MG{PS:SM2B-P4}K:Sp1-SP';'SR:C13-MG{PS:SM2B-P4}K:Sp1-SP';'SR:C14-MG{PS:SM2B-P4}K:Sp1-SP';'SR:C15-MG{PS:SM2B-P4}K:Sp1-SP';'SR:C16-MG{PS:SM2B-P4}K:Sp1-SP';'SR:C17-MG{PS:SM2B-P5}K:Sp1-SP';'SR:C18-MG{PS:SM2B-P5}K:Sp1-SP';'SR:C19-MG{PS:SM2B-P5}K:Sp1-SP';'SR:C20-MG{PS:SM2B-P5}K:Sp1-SP';'SR:C21-MG{PS:SM2B-P5}K:Sp1-SP';'SR:C22-MG{PS:SM2B-P5}K:Sp1-SP';'SR:C23-MG{PS:SM2B-P1}K:Sp1-SP';'SR:C24-MG{PS:SM2B-P1}K:Sp1-SP';'SR:C25-MG{PS:SM2B-P1}K:Sp1-SP';'SR:C26-MG{PS:SM2B-P1}K:Sp1-SP';'SR:C27-MG{PS:SM2B-P1}K:Sp1-SP';'SR:C28-MG{PS:SM2B-P1}K:Sp1-SP';'SR:C29-MG{PS:SM2B-P2}K:Sp1-SP'];
AO.SM2.SPKL.Units = 'Hardware';
AO.SM2.SPKL.HWUnits     = 'T*m^-2';
% SM2. KL readback
AO.SM2.RBKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Readback'};
AO.SM2.RBKL.Mode = OperationalMode;
AO.SM2.RBKL.DataType = 'Scalar';
AO.SM2.RBKL.ChannelNames  = ['SR:C30-MG{PS:SM2B-P2}K:Ps1DCCT1-I';'SR:C01-MG{PS:SM2B-P2}K:Ps1DCCT1-I';'SR:C02-MG{PS:SM2B-P2}K:Ps1DCCT1-I';'SR:C03-MG{PS:SM2B-P2}K:Ps1DCCT1-I';'SR:C04-MG{PS:SM2B-P2}K:Ps1DCCT1-I';'SR:C05-MG{PS:SM2B-P3}K:Ps1DCCT1-I';'SR:C06-MG{PS:SM2B-P3}K:Ps1DCCT1-I';'SR:C07-MG{PS:SM2B-P3}K:Ps1DCCT1-I';'SR:C08-MG{PS:SM2B-P3}K:Ps1DCCT1-I';'SR:C09-MG{PS:SM2B-P3}K:Ps1DCCT1-I';'SR:C10-MG{PS:SM2B-P3}K:Ps1DCCT1-I';'SR:C11-MG{PS:SM2B-P4}K:Ps1DCCT1-I';'SR:C12-MG{PS:SM2B-P4}K:Ps1DCCT1-I';'SR:C13-MG{PS:SM2B-P4}K:Ps1DCCT1-I';'SR:C14-MG{PS:SM2B-P4}K:Ps1DCCT1-I';'SR:C15-MG{PS:SM2B-P4}K:Ps1DCCT1-I';'SR:C16-MG{PS:SM2B-P4}K:Ps1DCCT1-I';'SR:C17-MG{PS:SM2B-P5}K:Ps1DCCT1-I';'SR:C18-MG{PS:SM2B-P5}K:Ps1DCCT1-I';'SR:C19-MG{PS:SM2B-P5}K:Ps1DCCT1-I';'SR:C20-MG{PS:SM2B-P5}K:Ps1DCCT1-I';'SR:C21-MG{PS:SM2B-P5}K:Ps1DCCT1-I';'SR:C22-MG{PS:SM2B-P5}K:Ps1DCCT1-I';'SR:C23-MG{PS:SM2B-P1}K:Ps1DCCT1-I';'SR:C24-MG{PS:SM2B-P1}K:Ps1DCCT1-I';'SR:C25-MG{PS:SM2B-P1}K:Ps1DCCT1-I';'SR:C26-MG{PS:SM2B-P1}K:Ps1DCCT1-I';'SR:C27-MG{PS:SM2B-P1}K:Ps1DCCT1-I';'SR:C28-MG{PS:SM2B-P1}K:Ps1DCCT1-I';'SR:C29-MG{PS:SM2B-P2}K:Ps1DCCT1-I'];
AO.SM2.RBKL.Units = 'Hardware';
AO.SM2.RBKL.HWUnits     = 'T*m^-2';
AO.SM2.KLname=['rot_coil_STP-9816-0028_000.txt';'rot_coil_STP-9816-0029_000.txt';'rot_coil_STP-9816-0004_000.txt';'rot_coil_STP-9816-0007_000.txt';'rot_coil_STP-9816-0008_000.txt';'rot_coil_STP-9816-0009_000.txt';'rot_coil_STP-9816-0010_000.txt';'rot_coil_STP-9816-0014_000.txt';'rot_coil_STP-9816-0019_000.txt';'rot_coil_STP-9816-0011_000.txt';'rot_coil_STP-9816-0013_000.txt';'rot_coil_STP-9816-0017_000.txt';'rot_coil_STP-9816-0015_000.txt';'rot_coil_STP-9816-0012_000.txt';'rot_coil_STP-9816-0020_000.txt';'rot_coil_STP-9816-0016_000.txt';'rot_coil_STP-9816-0018_000.txt';'rot_coil_STP-9816-1003_000.txt';'rot_coil_STP-9816-1005_001.txt';'rot_coil_STP-9816-1006_000.txt';'rot_coil_STP-9816-1001_000.txt';'rot_coil_STP-9816-1002_000.txt';'rot_coil_STP-9816-1004_001.txt';'rot_coil_STP-9816-0021_000.txt';'rot_coil_STP-9816-0001_001.txt';'rot_coil_STP-9816-0002_001.txt';'rot_coil_STP-9816-0003_001.txt';'rot_coil_STP-9816-0023_000.txt';'rot_coil_STP-9816-0024_000.txt';'rot_coil_STP-9816-0005_000.txt'];



% Harmonic sextupoles
AO.SH1.FamilyName = 'SH1';
AO.SH1.MemberOf = {'MachineConfig'; 'PlotFamily'; 'SEXT'; 'Magnet'; 'Harmonic Sextupole'};

AO.SH1.Monitor.Mode           = OperationalMode;
AO.SH1.Monitor.DataType       = 'Scalar';
AO.SH1.Monitor.Units          = 'Hardware';
AO.SH1.Monitor.HWUnits        = 'A';
AO.SH1.Monitor.PhysicsUnits   = 'm^-3';
AO.SH1.Monitor.HW2PhysicsFcn  = @amp2k;
AO.SH1.Monitor.Physics2HWFcn  = @k2amp;

AO.SH1.Setpoint.Mode          = OperationalMode;
AO.SH1.Setpoint.DataType      = 'Scalar';
AO.SH1.Setpoint.Units         = 'Hardware';
AO.SH1.Setpoint.HWUnits       = 'A';
AO.SH1.Setpoint.PhysicsUnits  = 'm^-3';
AO.SH1.Setpoint.HW2PhysicsFcn = @amp2k;
AO.SH1.Setpoint.Physics2HWFcn = @k2amp;

SH1range = 200;

% AO.SH1.Monitor.HW2PhysicsParams  = SH1gain;
% AO.SH1.Monitor.Physics2HWParams  = 1.0/SH1gain;
% AO.SH1.Setpoint.HW2PhysicsParams = SH1gain;
% AO.SH1.Setpoint.Physics2HWParams = 1.0/SH1gain;

AO.SH1.Setpoint.ChannelNames  = ['SR:C30-MG{PS:SH1-P2}I:Sp1-SP  '; 'SR:C30-MG{PS:SH1-P2}I:Sp1-SP  '; 'SR:C30-MG{PS:SH1-P2}I:Sp1-SP  '; 'SR:C30-MG{PS:SH1-P2}I:Sp1-SP  '; 'SR:C30-MG{PS:SH1-P2}I:Sp1-SP  '; 'SR:C06-MG{PS:SH1-P3}I:Sp1-SP  '; 'SR:C06-MG{PS:SH1-P3}I:Sp1-SP  '; 'SR:C08-MG{PS:SH1-DW08}I:Sp1-SP'; 'SR:C08-MG{PS:SH1-DW08}I:Sp1-SP'; 'SR:C06-MG{PS:SH1-P3}I:Sp1-SP  '; 'SR:C06-MG{PS:SH1-P3}I:Sp1-SP  '; 'SR:C12-MG{PS:SH1-P4}I:Sp1-SP  '; 'SR:C12-MG{PS:SH1-P4}I:Sp1-SP  '; 'SR:C12-MG{PS:SH1-P4}I:Sp1-SP  '; 'SR:C12-MG{PS:SH1-P4}I:Sp1-SP  '; 'SR:C12-MG{PS:SH1-P4}I:Sp1-SP  '; 'SR:C12-MG{PS:SH1-P4}I:Sp1-SP  '; 'SR:C18-MG{PS:SH1-DW18}I:Sp1-SP'; 'SR:C18-MG{PS:SH1-DW18}I:Sp1-SP'; 'SR:C18-MG{PS:SH1-P5}I:Sp1-SP  '; 'SR:C18-MG{PS:SH1-P5}I:Sp1-SP  '; 'SR:C18-MG{PS:SH1-P5}I:Sp1-SP  '; 'SR:C18-MG{PS:SH1-P5}I:Sp1-SP  '; 'SR:C24-MG{PS:SH1-P1}I:Sp1-SP  '; 'SR:C24-MG{PS:SH1-P1}I:Sp1-SP  '; 'SR:C24-MG{PS:SH1-P1}I:Sp1-SP  '; 'SR:C24-MG{PS:SH1-P1}I:Sp1-SP  '; 'SR:C28-MG{PS:SH1-DW28}I:Sp1-SP'; 'SR:C28-MG{PS:SH1-DW28}I:Sp1-SP'; 'SR:C30-MG{PS:SH1-P2}I:Sp1-SP  '];
AO.SH1.Monitor.ChannelNames = ['SR:C30-MG{PS:SH1-P2}I:Ps1DCCT1-I  '; 'SR:C30-MG{PS:SH1-P2}I:Ps1DCCT1-I  '; 'SR:C30-MG{PS:SH1-P2}I:Ps1DCCT1-I  '; 'SR:C30-MG{PS:SH1-P2}I:Ps1DCCT1-I  '; 'SR:C30-MG{PS:SH1-P2}I:Ps1DCCT1-I  '; 'SR:C06-MG{PS:SH1-P3}I:Ps1DCCT1-I  '; 'SR:C06-MG{PS:SH1-P3}I:Ps1DCCT1-I  '; 'SR:C08-MG{PS:SH1-DW08}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SH1-DW08}I:Ps1DCCT1-I'; 'SR:C06-MG{PS:SH1-P3}I:Ps1DCCT1-I  '; 'SR:C06-MG{PS:SH1-P3}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH1-P4}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH1-P4}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH1-P4}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH1-P4}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH1-P4}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH1-P4}I:Ps1DCCT1-I  '; 'SR:C18-MG{PS:SH1-DW18}I:Ps1DCCT1-I'; 'SR:C18-MG{PS:SH1-DW18}I:Ps1DCCT1-I'; 'SR:C18-MG{PS:SH1-P5}I:Ps1DCCT1-I  '; 'SR:C18-MG{PS:SH1-P5}I:Ps1DCCT1-I  '; 'SR:C18-MG{PS:SH1-P5}I:Ps1DCCT1-I  '; 'SR:C18-MG{PS:SH1-P5}I:Ps1DCCT1-I  '; 'SR:C24-MG{PS:SH1-P1}I:Ps1DCCT1-I  '; 'SR:C24-MG{PS:SH1-P1}I:Ps1DCCT1-I  '; 'SR:C24-MG{PS:SH1-P1}I:Ps1DCCT1-I  '; 'SR:C24-MG{PS:SH1-P1}I:Ps1DCCT1-I  '; 'SR:C28-MG{PS:SH1-DW28}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SH1-DW28}I:Ps1DCCT1-I'; 'SR:C30-MG{PS:SH1-P2}I:Ps1DCCT1-I  '];
AO.SH1.CommonNames = ['sh1g2c30a'; 'sh1g6c01b'; 'sh1g2c02a'; 'sh1g6c03b'; 'sh1g2c04a'; 'sh1g6c05b'; 'sh1g2c06a'; 'sh1g6c07b'; 'sh1g2c08a'; 'sh1g6c09b'; 'sh1g2c10a'; 'sh1g6c11b'; 'sh1g2c12a'; 'sh1g6c13b'; 'sh1g2c14a'; 'sh1g6c15b'; 'sh1g2c16a'; 'sh1g6c17b'; 'sh1g2c18a'; 'sh1g6c19b'; 'sh1g2c20a'; 'sh1g6c21b'; 'sh1g2c22a'; 'sh1g6c23b'; 'sh1g2c24a'; 'sh1g6c25b'; 'sh1g2c26a'; 'sh1g6c27b'; 'sh1g2c28a'; 'sh1g6c29b'];
AO.SH1.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];

for i=1:30
    l=floor(i/6)+1;
    AO.SH1.Status(i,1)                = 1;
    AO.SH1.ElementList(i,1)           = i;
    AO.SH1.Setpoint.Range(i,:)        = [-SH1range SH1range];
    AO.SH1.Setpoint.Tolerance(i)      = 0.1;
    AO.SH1.Setpoint.DeltaRespMat(i,1) = 0.5;
end
% SH1 KL setpoint
AO.SH1.SPKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Setpoint'};
AO.SH1.SPKL.Mode = OperationalMode;
AO.SH1.SPKL.DataType = 'Scalar';
AO.SH1.SPKL.ChannelNames  = ['SR:C30-MG{PS:SH1-P2}K:Sp1-SP  ';'SR:C01-MG{PS:SH1-P2}K:Sp1-SP  ';'SR:C02-MG{PS:SH1-P2}K:Sp1-SP  ';'SR:C03-MG{PS:SH1-P2}K:Sp1-SP  ';'SR:C04-MG{PS:SH1-P2}K:Sp1-SP  ';'SR:C05-MG{PS:SH1-P3}K:Sp1-SP  ';'SR:C06-MG{PS:SH1-P3}K:Sp1-SP  ';'SR:C07-MG{PS:SH1-DW08}K:Sp1-SP';'SR:C08-MG{PS:SH1-DW08}K:Sp1-SP';'SR:C09-MG{PS:SH1-P3}K:Sp1-SP  ';'SR:C10-MG{PS:SH1-P3}K:Sp1-SP  ';'SR:C11-MG{PS:SH1-P4}K:Sp1-SP  ';'SR:C12-MG{PS:SH1-P4}K:Sp1-SP  ';'SR:C13-MG{PS:SH1-P4}K:Sp1-SP  ';'SR:C14-MG{PS:SH1-P4}K:Sp1-SP  ';'SR:C15-MG{PS:SH1-P4}K:Sp1-SP  ';'SR:C16-MG{PS:SH1-P4}K:Sp1-SP  ';'SR:C17-MG{PS:SH1-DW18}K:Sp1-SP';'SR:C18-MG{PS:SH1-DW18}K:Sp1-SP';'SR:C19-MG{PS:SH1-P5}K:Sp1-SP  ';'SR:C20-MG{PS:SH1-P5}K:Sp1-SP  ';'SR:C21-MG{PS:SH1-P5}K:Sp1-SP  ';'SR:C22-MG{PS:SH1-P5}K:Sp1-SP  ';'SR:C23-MG{PS:SH1-P1}K:Sp1-SP  ';'SR:C24-MG{PS:SH1-P1}K:Sp1-SP  ';'SR:C25-MG{PS:SH1-P1}K:Sp1-SP  ';'SR:C26-MG{PS:SH1-P1}K:Sp1-SP  ';'SR:C27-MG{PS:SH1-DW28}K:Sp1-SP';'SR:C28-MG{PS:SH1-DW28}K:Sp1-SP';'SR:C29-MG{PS:SH1-P2}K:Sp1-SP  '];
AO.SH1.SPKL.Units = 'Hardware';
AO.SH1.SPKL.HWUnits     = 'T*m^-2';
% SH1. KL readback
AO.SH1.RBKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Readback'};
AO.SH1.RBKL.Mode = OperationalMode;
AO.SH1.RBKL.DataType = 'Scalar';
AO.SH1.RBKL.ChannelNames  = ['SR:C30-MG{PS:SH1-P2}K:Ps1DCCT1-I  ';'SR:C01-MG{PS:SH1-P2}K:Ps1DCCT1-I  ';'SR:C02-MG{PS:SH1-P2}K:Ps1DCCT1-I  ';'SR:C03-MG{PS:SH1-P2}K:Ps1DCCT1-I  ';'SR:C04-MG{PS:SH1-P2}K:Ps1DCCT1-I  ';'SR:C05-MG{PS:SH1-P3}K:Ps1DCCT1-I  ';'SR:C06-MG{PS:SH1-P3}K:Ps1DCCT1-I  ';'SR:C07-MG{PS:SH1-DW08}K:Ps1DCCT1-I';'SR:C08-MG{PS:SH1-DW08}K:Ps1DCCT1-I';'SR:C09-MG{PS:SH1-P3}K:Ps1DCCT1-I  ';'SR:C10-MG{PS:SH1-P3}K:Ps1DCCT1-I  ';'SR:C11-MG{PS:SH1-P4}K:Ps1DCCT1-I  ';'SR:C12-MG{PS:SH1-P4}K:Ps1DCCT1-I  ';'SR:C13-MG{PS:SH1-P4}K:Ps1DCCT1-I  ';'SR:C14-MG{PS:SH1-P4}K:Ps1DCCT1-I  ';'SR:C15-MG{PS:SH1-P4}K:Ps1DCCT1-I  ';'SR:C16-MG{PS:SH1-P4}K:Ps1DCCT1-I  ';'SR:C17-MG{PS:SH1-DW18}K:Ps1DCCT1-I';'SR:C18-MG{PS:SH1-DW18}K:Ps1DCCT1-I';'SR:C19-MG{PS:SH1-P5}K:Ps1DCCT1-I  ';'SR:C20-MG{PS:SH1-P5}K:Ps1DCCT1-I  ';'SR:C21-MG{PS:SH1-P5}K:Ps1DCCT1-I  ';'SR:C22-MG{PS:SH1-P5}K:Ps1DCCT1-I  ';'SR:C23-MG{PS:SH1-P1}K:Ps1DCCT1-I  ';'SR:C24-MG{PS:SH1-P1}K:Ps1DCCT1-I  ';'SR:C25-MG{PS:SH1-P1}K:Ps1DCCT1-I  ';'SR:C26-MG{PS:SH1-P1}K:Ps1DCCT1-I  ';'SR:C27-MG{PS:SH1-DW28}K:Ps1DCCT1-I';'SR:C28-MG{PS:SH1-DW28}K:Ps1DCCT1-I';'SR:C29-MG{PS:SH1-P2}K:Ps1DCCT1-I  '];
AO.SH1.RBKL.Units = 'Hardware';
AO.SH1.RBKL.HWUnits     = 'T*m^-2';
AO.SH1.KLname=['rot_coil_STP-9801-0079_000.txt';'rot_coil_STP-9801-0018_001.txt';'rot_coil_STP-9801-0067_000.txt';'rot_coil_STP-9801-0136_000.txt';'rot_coil_STP-9801-0135_000.txt';'rot_coil_STP-9801-0100_000.txt';'rot_coil_STP-9801-0046_001.txt';'rot_coil_STP-9801-0092_000.txt';'rot_coil_STP-9801-0016_002.txt';'rot_coil_STP-9801-0048_001.txt';'rot_coil_STP-9801-0142_000.txt';'rot_coil_STP-9801-0120_000.txt';'rot_coil_STP-9801-0124_000.txt';'rot_coil_STP-9801-0154_000.txt';'rot_coil_STP-9801-0126_000.txt';'rot_coil_STP-9801-0132_000.txt';'rot_coil_STP-9801-0113_000.txt';'rot_coil_STP-9801-0159_000.txt';'rot_coil_STP-9801-0129_000.txt';'rot_coil_STP-9801-0158_000.txt';'rot_coil_STP-9801-0167_000.txt';'rot_coil_STP-9801-0093_001.txt';'rot_coil_STP-9801-0015_000.txt';'rot_coil_STP-9801-0101_000.txt';'rot_coil_STP-9801-0139_000.txt';'rot_coil_STP-9801-0050_001.txt';'rot_coil_STP-9801-0033_000.txt';'rot_coil_STP-9801-0007_001.txt';'rot_coil_STP-9801-0070_000.txt';'rot_coil_STP-9801-0036_000.txt'];


% AO.SH2.FamilyName = 'SH2';
% AO.SH2.MemberOf = {'MachineConfig'; 'PlotFamily'; 'SEXT'; 'Magnet'; 'Harmonic Sextupole'};
% AO.SH2.DeviceList = [];
% AO.SH2.ElementList = [];
% AO.SH2.Status = [];
% 
% AO.SH2.Monitor.Mode           = OperationalMode;
% AO.SH2.Monitor.DataType       = 'Scalar';
% AO.SH2.Monitor.Units          = 'Hardware';
% AO.SH2.Monitor.HWUnits        = 'A';
% AO.SH2.Monitor.PhysicsUnits   = 'm^-3';
% %AO.SH2.Monitor.HW2PhysicsFcn  = @amp2k;
% %AO.SH2.Monitor.Physics2HWFcn  = @k2amp;
% 
% AO.SH2.Setpoint.Mode          = OperationalMode;
% AO.SH2.Setpoint.DataType      = 'Scalar';
% AO.SH2.Setpoint.Units         = 'Hardware';
% AO.SH2.Setpoint.HWUnits       = 'A';
% AO.SH2.Setpoint.PhysicsUnits  = 'm^-3';
% %AO.SH2.Setpoint.HW2PhysicsFcn = @amp2k;
% %AO.SH2.Setpoint.Physics2HWFcn = @k2amp;
% 
% SH2range = 200;
% SH2gain = 20.0e-3;  %  m^-3/A
% 
% AO.SH2.Monitor.HW2PhysicsParams  = SH2gain;
% AO.SH2.Monitor.Physics2HWParams  = 1.0/SH2gain;
% AO.SH2.Setpoint.HW2PhysicsParams = SH2gain;
% AO.SH2.Setpoint.Physics2HWParams = 1.0/SH2gain;
% 
% 
% 
% for i=1:30
%     l=floor(i/6)+1;
%     AO.SH2.CommonNames(i,:)           = [ 'r' num2str(i,'%02.2d') 'sh2' ];
%     %sextupoles are fed in series for each pentant
%     AO.SH2.Monitor.ChannelNames(i,:)  = [ 'r' num2str(l,'%01.1d') 'sh2' ':am'];
%     AO.SH2.Setpoint.ChannelNames(i,:) = [ 'r' num2str(l,'%01.1d') 'sh2' ':sp'];
%     AO.SH2.Status(i,1)                = 1;
%     AO.SH2.DeviceList(i,:)            = [ i 1 ];
%     AO.SH2.ElementList(i,1)           = i;
%     AO.SH2.Setpoint.Range(i,:)        = [-SH2range SH2range];
%     AO.SH2.Setpoint.Tolerance(i)      = 0.1;
%     AO.SH2.Setpoint.DeltaRespMat(i,1) = 0.5;
% end



AO.SH3.FamilyName = 'SH3';
AO.SH3.MemberOf = {'MachineConfig'; 'PlotFamily'; 'SEXT'; 'Magnet'; 'Harmonic Sextupole'};
AO.SH3.DeviceList = [];
AO.SH3.ElementList = [];
AO.SH3.Status = [];

AO.SH3.Monitor.Mode           = OperationalMode;
AO.SH3.Monitor.DataType       = 'Scalar';
AO.SH3.Monitor.Units          = 'Hardware';
AO.SH3.Monitor.HWUnits        = 'A';
AO.SH3.Monitor.PhysicsUnits   = 'm^-3';
AO.SH3.Monitor.HW2PhysicsFcn  = @amp2k;
AO.SH3.Monitor.Physics2HWFcn  = @k2amp;

AO.SH3.Setpoint.Mode          = OperationalMode;
AO.SH3.Setpoint.DataType      = 'Scalar';
AO.SH3.Setpoint.Units         = 'Hardware';
AO.SH3.Setpoint.HWUnits       = 'A';
AO.SH3.Setpoint.PhysicsUnits  = 'm^-3';
AO.SH3.Setpoint.HW2PhysicsFcn = @amp2k;
AO.SH3.Setpoint.Physics2HWFcn = @k2amp;

SH3range = 200;

% AO.SH3.Monitor.HW2PhysicsParams  = SH3gain;
% AO.SH3.Monitor.Physics2HWParams  = 1.0/SH3gain;
% AO.SH3.Setpoint.HW2PhysicsParams = SH3gain;
% AO.SH3.Setpoint.Physics2HWParams = 1.0/SH3gain;

AO.SH3.Setpoint.ChannelNames  = ['SR:C30-MG{PS:SH3-P2}I:Sp1-SP  '; 'SR:C30-MG{PS:SH3-P2}I:Sp1-SP  '; 'SR:C30-MG{PS:SH3-P2}I:Sp1-SP  '; 'SR:C30-MG{PS:SH3-P2}I:Sp1-SP  '; 'SR:C30-MG{PS:SH3-P2}I:Sp1-SP  '; 'SR:C06-MG{PS:SH3-P3}I:Sp1-SP  '; 'SR:C06-MG{PS:SH3-P3}I:Sp1-SP  '; 'SR:C08-MG{PS:SH3-DW08}I:Sp1-SP'; 'SR:C08-MG{PS:SH3-DW08}I:Sp1-SP'; 'SR:C06-MG{PS:SH3-P3}I:Sp1-SP  '; 'SR:C06-MG{PS:SH3-P3}I:Sp1-SP  '; 'SR:C12-MG{PS:SH3-P4}I:Sp1-SP  '; 'SR:C12-MG{PS:SH3-P4}I:Sp1-SP  '; 'SR:C12-MG{PS:SH3-P4}I:Sp1-SP  '; 'SR:C12-MG{PS:SH3-P4}I:Sp1-SP  '; 'SR:C12-MG{PS:SH3-P4}I:Sp1-SP  '; 'SR:C12-MG{PS:SH3-P4}I:Sp1-SP  '; 'SR:C18-MG{PS:SH3-DW18}I:Sp1-SP'; 'SR:C18-MG{PS:SH3-DW18}I:Sp1-SP'; 'SR:C18-MG{PS:SH3-P5}I:Sp1-SP  '; 'SR:C18-MG{PS:SH3-P5}I:Sp1-SP  '; 'SR:C18-MG{PS:SH3-P5}I:Sp1-SP  '; 'SR:C18-MG{PS:SH3-P5}I:Sp1-SP  '; 'SR:C24-MG{PS:SH3-P1}I:Sp1-SP  '; 'SR:C24-MG{PS:SH3-P1}I:Sp1-SP  '; 'SR:C24-MG{PS:SH3-P1}I:Sp1-SP  '; 'SR:C24-MG{PS:SH3-P1}I:Sp1-SP  '; 'SR:C28-MG{PS:SH3-DW28}I:Sp1-SP'; 'SR:C28-MG{PS:SH3-DW28}I:Sp1-SP'; 'SR:C30-MG{PS:SH3-P2}I:Sp1-SP  '];
AO.SH3.Monitor.ChannelNames = ['SR:C30-MG{PS:SH3-P2}I:Ps1DCCT1-I  '; 'SR:C30-MG{PS:SH3-P2}I:Ps1DCCT1-I  '; 'SR:C30-MG{PS:SH3-P2}I:Ps1DCCT1-I  '; 'SR:C30-MG{PS:SH3-P2}I:Ps1DCCT1-I  '; 'SR:C30-MG{PS:SH3-P2}I:Ps1DCCT1-I  '; 'SR:C06-MG{PS:SH3-P3}I:Ps1DCCT1-I  '; 'SR:C06-MG{PS:SH3-P3}I:Ps1DCCT1-I  '; 'SR:C08-MG{PS:SH3-DW08}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SH3-DW08}I:Ps1DCCT1-I'; 'SR:C06-MG{PS:SH3-P3}I:Ps1DCCT1-I  '; 'SR:C06-MG{PS:SH3-P3}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH3-P4}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH3-P4}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH3-P4}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH3-P4}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH3-P4}I:Ps1DCCT1-I  '; 'SR:C12-MG{PS:SH3-P4}I:Ps1DCCT1-I  '; 'SR:C18-MG{PS:SH3-DW18}I:Ps1DCCT1-I'; 'SR:C18-MG{PS:SH3-DW18}I:Ps1DCCT1-I'; 'SR:C18-MG{PS:SH3-P5}I:Ps1DCCT1-I  '; 'SR:C18-MG{PS:SH3-P5}I:Ps1DCCT1-I  '; 'SR:C18-MG{PS:SH3-P5}I:Ps1DCCT1-I  '; 'SR:C18-MG{PS:SH3-P5}I:Ps1DCCT1-I  '; 'SR:C24-MG{PS:SH3-P1}I:Ps1DCCT1-I  '; 'SR:C24-MG{PS:SH3-P1}I:Ps1DCCT1-I  '; 'SR:C24-MG{PS:SH3-P1}I:Ps1DCCT1-I  '; 'SR:C24-MG{PS:SH3-P1}I:Ps1DCCT1-I  '; 'SR:C28-MG{PS:SH3-DW28}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SH3-DW28}I:Ps1DCCT1-I'; 'SR:C30-MG{PS:SH3-P2}I:Ps1DCCT1-I  '];
AO.SH3.CommonNames = ['sh3g2c30a'; 'sh3g6c01b'; 'sh3g2c02a'; 'sh3g6c03b'; 'sh3g2c04a'; 'sh3g6c05b'; 'sh3g2c06a'; 'sh3g6c07b'; 'sh3g2c08a'; 'sh3g6c09b'; 'sh3g2c10a'; 'sh3g6c11b'; 'sh3g2c12a'; 'sh3g6c13b'; 'sh3g2c14a'; 'sh3g6c15b'; 'sh3g2c16a'; 'sh3g6c17b'; 'sh3g2c18a'; 'sh3g6c19b'; 'sh3g2c20a'; 'sh3g6c21b'; 'sh3g2c22a'; 'sh3g6c23b'; 'sh3g2c24a'; 'sh3g6c25b'; 'sh3g2c26a'; 'sh3g6c27b'; 'sh3g2c28a'; 'sh3g6c29b'];
AO.SH3.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];

for i=1:30
    AO.SH3.Status(i,1)                = 1;
    AO.SH3.ElementList(i,1)           = i;
    AO.SH3.Setpoint.Range(i,:)        = [-SH3range SH3range];
    AO.SH3.Setpoint.Tolerance(i)      = 0.1;
    AO.SH3.Setpoint.DeltaRespMat(i,1) = 0.5;
end
% SH3 KL setpoint
AO.SH3.SPKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Setpoint'};
AO.SH3.SPKL.Mode = OperationalMode;
AO.SH3.SPKL.DataType = 'Scalar';
AO.SH3.SPKL.ChannelNames  = ['SR:C30-MG{PS:SH3-P2}K:Sp1-SP  ';'SR:C01-MG{PS:SH3-P2}K:Sp1-SP  ';'SR:C02-MG{PS:SH3-P2}K:Sp1-SP  ';'SR:C03-MG{PS:SH3-P2}K:Sp1-SP  ';'SR:C04-MG{PS:SH3-P2}K:Sp1-SP  ';'SR:C05-MG{PS:SH3-P3}K:Sp1-SP  ';'SR:C06-MG{PS:SH3-P3}K:Sp1-SP  ';'SR:C07-MG{PS:SH3-DW08}K:Sp1-SP';'SR:C08-MG{PS:SH3-DW08}K:Sp1-SP';'SR:C09-MG{PS:SH3-P3}K:Sp1-SP  ';'SR:C10-MG{PS:SH3-P3}K:Sp1-SP  ';'SR:C11-MG{PS:SH3-P4}K:Sp1-SP  ';'SR:C12-MG{PS:SH3-P4}K:Sp1-SP  ';'SR:C13-MG{PS:SH3-P4}K:Sp1-SP  ';'SR:C14-MG{PS:SH3-P4}K:Sp1-SP  ';'SR:C15-MG{PS:SH3-P4}K:Sp1-SP  ';'SR:C16-MG{PS:SH3-P4}K:Sp1-SP  ';'SR:C17-MG{PS:SH3-DW18}K:Sp1-SP';'SR:C18-MG{PS:SH3-DW18}K:Sp1-SP';'SR:C19-MG{PS:SH3-P5}K:Sp1-SP  ';'SR:C20-MG{PS:SH3-P5}K:Sp1-SP  ';'SR:C21-MG{PS:SH3-P5}K:Sp1-SP  ';'SR:C22-MG{PS:SH3-P5}K:Sp1-SP  ';'SR:C23-MG{PS:SH3-P1}K:Sp1-SP  ';'SR:C24-MG{PS:SH3-P1}K:Sp1-SP  ';'SR:C25-MG{PS:SH3-P1}K:Sp1-SP  ';'SR:C26-MG{PS:SH3-P1}K:Sp1-SP  ';'SR:C27-MG{PS:SH3-DW28}K:Sp1-SP';'SR:C28-MG{PS:SH3-DW28}K:Sp1-SP';'SR:C29-MG{PS:SH3-P2}K:Sp1-SP  '];
AO.SH3.SPKL.Units = 'Hardware';
AO.SH3.SPKL.HWUnits     = 'T*m^-2';
% SH3. KL readback
AO.SH3.RBKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Readback'};
AO.SH3.RBKL.Mode = OperationalMode;
AO.SH3.RBKL.DataType = 'Scalar';
AO.SH3.RBKL.ChannelNames  = ['SR:C30-MG{PS:SH3-P2}K:Ps1DCCT1-I  ';'SR:C01-MG{PS:SH3-P2}K:Ps1DCCT1-I  ';'SR:C02-MG{PS:SH3-P2}K:Ps1DCCT1-I  ';'SR:C03-MG{PS:SH3-P2}K:Ps1DCCT1-I  ';'SR:C04-MG{PS:SH3-P2}K:Ps1DCCT1-I  ';'SR:C05-MG{PS:SH3-P3}K:Ps1DCCT1-I  ';'SR:C06-MG{PS:SH3-P3}K:Ps1DCCT1-I  ';'SR:C07-MG{PS:SH3-DW08}K:Ps1DCCT1-I';'SR:C08-MG{PS:SH3-DW08}K:Ps1DCCT1-I';'SR:C09-MG{PS:SH3-P3}K:Ps1DCCT1-I  ';'SR:C10-MG{PS:SH3-P3}K:Ps1DCCT1-I  ';'SR:C11-MG{PS:SH3-P4}K:Ps1DCCT1-I  ';'SR:C12-MG{PS:SH3-P4}K:Ps1DCCT1-I  ';'SR:C13-MG{PS:SH3-P4}K:Ps1DCCT1-I  ';'SR:C14-MG{PS:SH3-P4}K:Ps1DCCT1-I  ';'SR:C15-MG{PS:SH3-P4}K:Ps1DCCT1-I  ';'SR:C16-MG{PS:SH3-P4}K:Ps1DCCT1-I  ';'SR:C17-MG{PS:SH3-DW18}K:Ps1DCCT1-I';'SR:C18-MG{PS:SH3-DW18}K:Ps1DCCT1-I';'SR:C19-MG{PS:SH3-P5}K:Ps1DCCT1-I  ';'SR:C20-MG{PS:SH3-P5}K:Ps1DCCT1-I  ';'SR:C21-MG{PS:SH3-P5}K:Ps1DCCT1-I  ';'SR:C22-MG{PS:SH3-P5}K:Ps1DCCT1-I  ';'SR:C23-MG{PS:SH3-P1}K:Ps1DCCT1-I  ';'SR:C24-MG{PS:SH3-P1}K:Ps1DCCT1-I  ';'SR:C25-MG{PS:SH3-P1}K:Ps1DCCT1-I  ';'SR:C26-MG{PS:SH3-P1}K:Ps1DCCT1-I  ';'SR:C27-MG{PS:SH3-DW28}K:Ps1DCCT1-I';'SR:C28-MG{PS:SH3-DW28}K:Ps1DCCT1-I';'SR:C29-MG{PS:SH3-P2}K:Ps1DCCT1-I  '];
AO.SH3.RBKL.Units = 'Hardware';
AO.SH3.RBKL.HWUnits     = 'T*m^-2';
AO.SH3.KLname=['rot_coil_STP-9801-0083_000.txt';'rot_coil_STP-9802-0045_000.txt';'rot_coil_STP-9801-0068_000.txt';'rot_coil_STP-9802-0064_000.txt';'rot_coil_STP-9801-0137_000.txt';'rot_coil_STP-9802-0060_000.txt';'rot_coil_STP-9801-0057_001.txt';'rot_coil_STP-9802-0062_000.txt';'rot_coil_STP-9801-0090_000.txt';'rot_coil_STP-9802-0042_000.txt';'rot_coil_STP-9801-0143_000.txt';'rot_coil_STP-9802-0057_000.txt';'rot_coil_STP-9801-0108_000.txt';'rot_coil_STP-9802-0072_000.txt';'rot_coil_STP-9801-0128_000.txt';'rot_coil_STP-9802-0069_000.txt';'rot_coil_STP-9801-0122_000.txt';'rot_coil_STP-9802-0079_000.txt';'rot_coil_STP-9801-0161_000.txt';'rot_coil_STP-9802-0082_000.txt';'rot_coil_STP-9801-0168_000.txt';'rot_coil_STP-9802-0080_000.txt';'rot_coil_STP-9801-0088_000.txt';'rot_coil_STP-9802-0054_000.txt';'rot_coil_STP-9801-0140_000.txt';'rot_coil_STP-9802-0019_000.txt';'rot_coil_STP-9801-0034_000.txt';'rot_coil_STP-9802-0044_000.txt';'rot_coil_STP-9801-0071_000.txt';'rot_coil_STP-9802-0020_000.txt'];




AO.SH4.FamilyName = 'SH4';
AO.SH4.MemberOf = {'MachineConfig'; 'PlotFamily'; 'SEXT'; 'Magnet'; 'Harmonic Sextupole'};
AO.SH4.DeviceList = [];
AO.SH4.ElementList = [];
AO.SH4.Status = [];

AO.SH4.Monitor.Mode           = OperationalMode;
AO.SH4.Monitor.DataType       = 'Scalar';
AO.SH4.Monitor.Units          = 'Hardware';
AO.SH4.Monitor.HWUnits        = 'A';
AO.SH4.Monitor.PhysicsUnits   = 'm^-3';
AO.SH4.Monitor.HW2PhysicsFcn  = @amp2k;
AO.SH4.Monitor.Physics2HWFcn  = @k2amp;

AO.SH4.Setpoint.Mode          = OperationalMode;
AO.SH4.Setpoint.DataType      = 'Scalar';
AO.SH4.Setpoint.Units         = 'Hardware';
AO.SH4.Setpoint.HWUnits       = 'A';
AO.SH4.Setpoint.PhysicsUnits  = 'm^-3';
AO.SH4.Setpoint.HW2PhysicsFcn = @amp2k;
AO.SH4.Setpoint.Physics2HWFcn = @k2amp;

SH4range = 200;

% AO.SH4.Monitor.HW2PhysicsParams  = SH4gain;
% AO.SH4.Monitor.Physics2HWParams  = 1.0/SH4gain;
% AO.SH4.Setpoint.HW2PhysicsParams = SH4gain;
% AO.SH4.Setpoint.Physics2HWParams = 1.0/SH4gain;

AO.SH4.Setpoint.ChannelNames  = ['SR:C01-MG{PS:SH4-P2}I:Sp1-SP  '; 'SR:C01-MG{PS:SH4-P2}I:Sp1-SP  '; 'SR:C01-MG{PS:SH4-P2}I:Sp1-SP  '; 'SR:C01-MG{PS:SH4-P2}I:Sp1-SP  '; 'SR:C01-MG{PS:SH4-P2}I:Sp1-SP  '; 'SR:C07-MG{PS:SH4-P3}I:Sp1-SP  '; 'SR:C07-MG{PS:SH4-P3}I:Sp1-SP  '; 'SR:C08-MG{PS:SH4-DW08}I:Sp1-SP'; 'SR:C08-MG{PS:SH4-DW08}I:Sp1-SP'; 'SR:C07-MG{PS:SH4-P3}I:Sp1-SP  '; 'SR:C07-MG{PS:SH4-P3}I:Sp1-SP  '; 'SR:C13-MG{PS:SH4-P4}I:Sp1-SP  '; 'SR:C13-MG{PS:SH4-P4}I:Sp1-SP  '; 'SR:C13-MG{PS:SH4-P4}I:Sp1-SP  '; 'SR:C13-MG{PS:SH4-P4}I:Sp1-SP  '; 'SR:C13-MG{PS:SH4-P4}I:Sp1-SP  '; 'SR:C13-MG{PS:SH4-P4}I:Sp1-SP  '; 'SR:C18-MG{PS:SH4-DW18}I:Sp1-SP'; 'SR:C18-MG{PS:SH4-DW18}I:Sp1-SP'; 'SR:C19-MG{PS:SH4-P5}I:Sp1-SP  '; 'SR:C19-MG{PS:SH4-P5}I:Sp1-SP  '; 'SR:C19-MG{PS:SH4-P5}I:Sp1-SP  '; 'SR:C19-MG{PS:SH4-P5}I:Sp1-SP  '; 'SR:C25-MG{PS:SH4-P1}I:Sp1-SP  '; 'SR:C25-MG{PS:SH4-P1}I:Sp1-SP  '; 'SR:C25-MG{PS:SH4-P1}I:Sp1-SP  '; 'SR:C25-MG{PS:SH4-P1}I:Sp1-SP  '; 'SR:C28-MG{PS:SH4-DW28}I:Sp1-SP'; 'SR:C28-MG{PS:SH4-DW28}I:Sp1-SP'; 'SR:C01-MG{PS:SH4-P2}I:Sp1-SP  '];
AO.SH4.Monitor.ChannelNames = ['SR:C01-MG{PS:SH4-P2}I:Ps1DCCT1-I  '; 'SR:C01-MG{PS:SH4-P2}I:Ps1DCCT1-I  '; 'SR:C01-MG{PS:SH4-P2}I:Ps1DCCT1-I  '; 'SR:C01-MG{PS:SH4-P2}I:Ps1DCCT1-I  '; 'SR:C01-MG{PS:SH4-P2}I:Ps1DCCT1-I  '; 'SR:C07-MG{PS:SH4-P3}I:Ps1DCCT1-I  '; 'SR:C07-MG{PS:SH4-P3}I:Ps1DCCT1-I  '; 'SR:C08-MG{PS:SH4-DW08}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SH4-DW08}I:Ps1DCCT1-I'; 'SR:C07-MG{PS:SH4-P3}I:Ps1DCCT1-I  '; 'SR:C07-MG{PS:SH4-P3}I:Ps1DCCT1-I  '; 'SR:C13-MG{PS:SH4-P4}I:Ps1DCCT1-I  '; 'SR:C13-MG{PS:SH4-P4}I:Ps1DCCT1-I  '; 'SR:C13-MG{PS:SH4-P4}I:Ps1DCCT1-I  '; 'SR:C13-MG{PS:SH4-P4}I:Ps1DCCT1-I  '; 'SR:C13-MG{PS:SH4-P4}I:Ps1DCCT1-I  '; 'SR:C13-MG{PS:SH4-P4}I:Ps1DCCT1-I  '; 'SR:C18-MG{PS:SH4-DW18}I:Ps1DCCT1-I'; 'SR:C18-MG{PS:SH4-DW18}I:Ps1DCCT1-I'; 'SR:C19-MG{PS:SH4-P5}I:Ps1DCCT1-I  '; 'SR:C19-MG{PS:SH4-P5}I:Ps1DCCT1-I  '; 'SR:C19-MG{PS:SH4-P5}I:Ps1DCCT1-I  '; 'SR:C19-MG{PS:SH4-P5}I:Ps1DCCT1-I  '; 'SR:C25-MG{PS:SH4-P1}I:Ps1DCCT1-I  '; 'SR:C25-MG{PS:SH4-P1}I:Ps1DCCT1-I  '; 'SR:C25-MG{PS:SH4-P1}I:Ps1DCCT1-I  '; 'SR:C25-MG{PS:SH4-P1}I:Ps1DCCT1-I  '; 'SR:C28-MG{PS:SH4-DW28}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SH4-DW28}I:Ps1DCCT1-I'; 'SR:C01-MG{PS:SH4-P2}I:Ps1DCCT1-I  '];
AO.SH4.CommonNames = ['sh4g2c30a'; 'sh4g6c01b'; 'sh4g2c02a'; 'sh4g6c03b'; 'sh4g2c04a'; 'sh4g6c05b'; 'sh4g2c06a'; 'sh4g6c07b'; 'sh4g2c08a'; 'sh4g6c09b'; 'sh4g2c10a'; 'sh4g6c11b'; 'sh4g2c12a'; 'sh4g6c13b'; 'sh4g2c14a'; 'sh4g6c15b'; 'sh4g2c16a'; 'sh4g6c17b'; 'sh4g2c18a'; 'sh4g6c19b'; 'sh4g2c20a'; 'sh4g6c21b'; 'sh4g2c22a'; 'sh4g6c23b'; 'sh4g2c24a'; 'sh4g6c25b'; 'sh4g2c26a'; 'sh4g6c27b'; 'sh4g2c28a'; 'sh4g6c29b'];
AO.SH4.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];

for i=1:30
    AO.SH4.Status(i,1)                = 1;
    AO.SH4.ElementList(i,1)           = i;
    AO.SH4.Setpoint.Range(i,:)        = [-SH4range SH4range];
    AO.SH4.Setpoint.Tolerance(i)      = 0.1;
    AO.SH4.Setpoint.DeltaRespMat(i,1) = 0.5;
end
% SH4 KL setpoint
AO.SH4.SPKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Setpoint'};
AO.SH4.SPKL.Mode = OperationalMode;
AO.SH4.SPKL.DataType = 'Scalar';
AO.SH4.SPKL.ChannelNames  = ['SR:C30-MG{PS:SH4-P2}K:Sp1-SP  ';'SR:C01-MG{PS:SH4-P2}K:Sp1-SP  ';'SR:C02-MG{PS:SH4-P2}K:Sp1-SP  ';'SR:C03-MG{PS:SH4-P2}K:Sp1-SP  ';'SR:C04-MG{PS:SH4-P2}K:Sp1-SP  ';'SR:C05-MG{PS:SH4-P3}K:Sp1-SP  ';'SR:C06-MG{PS:SH4-P3}K:Sp1-SP  ';'SR:C07-MG{PS:SH4-DW08}K:Sp1-SP';'SR:C08-MG{PS:SH4-DW08}K:Sp1-SP';'SR:C09-MG{PS:SH4-P3}K:Sp1-SP  ';'SR:C10-MG{PS:SH4-P3}K:Sp1-SP  ';'SR:C11-MG{PS:SH4-P4}K:Sp1-SP  ';'SR:C12-MG{PS:SH4-P4}K:Sp1-SP  ';'SR:C13-MG{PS:SH4-P4}K:Sp1-SP  ';'SR:C14-MG{PS:SH4-P4}K:Sp1-SP  ';'SR:C15-MG{PS:SH4-P4}K:Sp1-SP  ';'SR:C16-MG{PS:SH4-P4}K:Sp1-SP  ';'SR:C17-MG{PS:SH4-DW18}K:Sp1-SP';'SR:C18-MG{PS:SH4-DW18}K:Sp1-SP';'SR:C19-MG{PS:SH4-P5}K:Sp1-SP  ';'SR:C20-MG{PS:SH4-P5}K:Sp1-SP  ';'SR:C21-MG{PS:SH4-P5}K:Sp1-SP  ';'SR:C22-MG{PS:SH4-P5}K:Sp1-SP  ';'SR:C23-MG{PS:SH4-P1}K:Sp1-SP  ';'SR:C24-MG{PS:SH4-P1}K:Sp1-SP  ';'SR:C25-MG{PS:SH4-P1}K:Sp1-SP  ';'SR:C26-MG{PS:SH4-P1}K:Sp1-SP  ';'SR:C27-MG{PS:SH4-DW28}K:Sp1-SP';'SR:C28-MG{PS:SH4-DW28}K:Sp1-SP';'SR:C29-MG{PS:SH4-P2}K:Sp1-SP  '];
AO.SH4.SPKL.Units = 'Hardware';
AO.SH4.SPKL.HWUnits     = 'T*m^-2';
% SH4. KL readback
AO.SH4.RBKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Readback'};
AO.SH4.RBKL.Mode = OperationalMode;
AO.SH4.RBKL.DataType = 'Scalar';
AO.SH4.RBKL.ChannelNames  = ['SR:C30-MG{PS:SH4-P2}K:Ps1DCCT1-I  ';'SR:C01-MG{PS:SH4-P2}K:Ps1DCCT1-I  ';'SR:C02-MG{PS:SH4-P2}K:Ps1DCCT1-I  ';'SR:C03-MG{PS:SH4-P2}K:Ps1DCCT1-I  ';'SR:C04-MG{PS:SH4-P2}K:Ps1DCCT1-I  ';'SR:C05-MG{PS:SH4-P3}K:Ps1DCCT1-I  ';'SR:C06-MG{PS:SH4-P3}K:Ps1DCCT1-I  ';'SR:C07-MG{PS:SH4-DW08}K:Ps1DCCT1-I';'SR:C08-MG{PS:SH4-DW08}K:Ps1DCCT1-I';'SR:C09-MG{PS:SH4-P3}K:Ps1DCCT1-I  ';'SR:C10-MG{PS:SH4-P3}K:Ps1DCCT1-I  ';'SR:C11-MG{PS:SH4-P4}K:Ps1DCCT1-I  ';'SR:C12-MG{PS:SH4-P4}K:Ps1DCCT1-I  ';'SR:C13-MG{PS:SH4-P4}K:Ps1DCCT1-I  ';'SR:C14-MG{PS:SH4-P4}K:Ps1DCCT1-I  ';'SR:C15-MG{PS:SH4-P4}K:Ps1DCCT1-I  ';'SR:C16-MG{PS:SH4-P4}K:Ps1DCCT1-I  ';'SR:C17-MG{PS:SH4-DW18}K:Ps1DCCT1-I';'SR:C18-MG{PS:SH4-DW18}K:Ps1DCCT1-I';'SR:C19-MG{PS:SH4-P5}K:Ps1DCCT1-I  ';'SR:C20-MG{PS:SH4-P5}K:Ps1DCCT1-I  ';'SR:C21-MG{PS:SH4-P5}K:Ps1DCCT1-I  ';'SR:C22-MG{PS:SH4-P5}K:Ps1DCCT1-I  ';'SR:C23-MG{PS:SH4-P1}K:Ps1DCCT1-I  ';'SR:C24-MG{PS:SH4-P1}K:Ps1DCCT1-I  ';'SR:C25-MG{PS:SH4-P1}K:Ps1DCCT1-I  ';'SR:C26-MG{PS:SH4-P1}K:Ps1DCCT1-I  ';'SR:C27-MG{PS:SH4-DW28}K:Ps1DCCT1-I';'SR:C28-MG{PS:SH4-DW28}K:Ps1DCCT1-I';'SR:C29-MG{PS:SH4-P2}K:Ps1DCCT1-I  '];
AO.SH4.RBKL.Units = 'Hardware';
AO.SH4.RBKL.HWUnits     = 'T*m^-2';
AO.SH4.KLname=['rot_coil_STP-9801-0085_000.txt';'rot_coil_STP-9802-0030_000.txt';'rot_coil_STP-9801-0069_000.txt';'rot_coil_STP-9802-0063_000.txt';'rot_coil_STP-9801-0138_000.txt';'rot_coil_STP-9802-0059_000.txt';'rot_coil_STP-9801-0058_000.txt';'rot_coil_STP-9802-0058_000.txt';'rot_coil_STP-9801-0097_000.txt';'rot_coil_STP-9802-0040_000.txt';'rot_coil_STP-9801-0144_000.txt';'rot_coil_STP-9802-0061_000.txt';'rot_coil_STP-9801-0109_000.txt';'rot_coil_STP-9802-0071_000.txt';'rot_coil_STP-9801-0131_000.txt';'rot_coil_STP-9802-0068_000.txt';'rot_coil_STP-9801-0160_000.txt';'rot_coil_STP-9802-0078_000.txt';'rot_coil_STP-9801-0164_000.txt';'rot_coil_STP-9802-0041_000.txt';'rot_coil_STP-9801-0169_000.txt';'rot_coil_STP-9802-0026_000.txt';'rot_coil_STP-9801-0150_000.txt';'rot_coil_STP-9802-0053_000.txt';'rot_coil_STP-9801-0141_000.txt';'rot_coil_STP-9802-0023_000.txt';'rot_coil_STP-9801-0035_000.txt';'rot_coil_STP-9802-0043_000.txt';'rot_coil_STP-9801-0072_000.txt';'rot_coil_STP-9802-0033_001.txt'];




AO.SL1.FamilyName = 'SL1';
AO.SL1.MemberOf = {'MachineConfig'; 'PlotFamily'; 'SEXT'; 'Magnet'; 'Harmonic Sextupole'};
AO.SL1.DeviceList = [];
AO.SL1.ElementList = [];
AO.SL1.Status = [];

AO.SL1.Monitor.Mode           = OperationalMode;
AO.SL1.Monitor.DataType       = 'Scalar';
AO.SL1.Monitor.Units          = 'Hardware';
AO.SL1.Monitor.HWUnits        = 'A';
AO.SL1.Monitor.PhysicsUnits   = 'm^-3';
AO.SL1.Monitor.HW2PhysicsFcn  = @amp2k;
AO.SL1.Monitor.Physics2HWFcn  = @k2amp;

AO.SL1.Setpoint.Mode          = OperationalMode;
AO.SL1.Setpoint.DataType      = 'Scalar';
AO.SL1.Setpoint.Units         = 'Hardware';
AO.SL1.Setpoint.HWUnits       = 'A';
AO.SL1.Setpoint.PhysicsUnits  = 'm^-3';
AO.SL1.Setpoint.HW2PhysicsFcn = @amp2k;
AO.SL1.Setpoint.Physics2HWFcn = @k2amp;

SL1range = 200;

% AO.SL1.Monitor.HW2PhysicsParams  = SL1gain;
% AO.SL1.Monitor.Physics2HWParams  = 1.0/SL1gain;
% AO.SL1.Setpoint.HW2PhysicsParams = SL1gain;
% AO.SL1.Setpoint.Physics2HWParams = 1.0/SL1gain;

AO.SL1.Setpoint.ChannelNames  = ['SR:C04-MG{PS:SL1-P2}I:Sp1-SP  '; 'SR:C04-MG{PS:SL1-P2}I:Sp1-SP  '; 'SR:C04-MG{PS:SL1-P2}I:Sp1-SP  '; 'SR:C04-MG{PS:SL1-P2}I:Sp1-SP  '; 'SR:C04-MG{PS:SL1-P2}I:Sp1-SP  '; 'SR:C10-MG{PS:SL1-P3}I:Sp1-SP  '; 'SR:C10-MG{PS:SL1-P3}I:Sp1-SP  '; 'SR:C10-MG{PS:SL1-P3}I:Sp1-SP  '; 'SR:C10-MG{PS:SL1-P3}I:Sp1-SP  '; 'SR:C10-MG{PS:SL1-P3}I:Sp1-SP  '; 'SR:C10-MG{PS:SL1-P3}I:Sp1-SP  '; 'SR:C16-MG{PS:SL1-P4}I:Sp1-SP  '; 'SR:C16-MG{PS:SL1-P4}I:Sp1-SP  '; 'SR:C16-MG{PS:SL1-P4}I:Sp1-SP  '; 'SR:C16-MG{PS:SL1-P4}I:Sp1-SP  '; 'SR:C16-MG{PS:SL1-P4}I:Sp1-SP  '; 'SR:C16-MG{PS:SL1-P4}I:Sp1-SP  '; 'SR:C22-MG{PS:SL1-P5}I:Sp1-SP  '; 'SR:C22-MG{PS:SL1-P5}I:Sp1-SP  '; 'SR:C22-MG{PS:SL1-P5}I:Sp1-SP  '; 'SR:C22-MG{PS:SL1-P5}I:Sp1-SP  '; 'SR:C22-MG{PS:SL1-P5}I:Sp1-SP  '; 'SR:C22-MG{PS:SL1-P5}I:Sp1-SP  '; 'SR:C28-MG{PS:SL1-P1}I:Sp1-SP  '; 'SR:C28-MG{PS:SL1-P1}I:Sp1-SP  '; 'SR:C28-MG{PS:SL1-P1}I:Sp1-SP  '; 'SR:C28-MG{PS:SL1-P1}I:Sp1-SP  '; 'SR:C28-MG{PS:SL1-P1}I:Sp1-SP  '; 'SR:C28-MG{PS:SL1-P1}I:Sp1-SP  '; 'SR:C04-MG{PS:SL1-P2}I:Sp1-SP  '];
AO.SL1.Monitor.ChannelNames = ['SR:C04-MG{PS:SL1-P2}I:Ps1DCCT1-I'; 'SR:C04-MG{PS:SL1-P2}I:Ps1DCCT1-I'; 'SR:C04-MG{PS:SL1-P2}I:Ps1DCCT1-I'; 'SR:C04-MG{PS:SL1-P2}I:Ps1DCCT1-I'; 'SR:C04-MG{PS:SL1-P2}I:Ps1DCCT1-I'; 'SR:C10-MG{PS:SL1-P3}I:Ps1DCCT1-I'; 'SR:C10-MG{PS:SL1-P3}I:Ps1DCCT1-I'; 'SR:C10-MG{PS:SL1-P3}I:Ps1DCCT1-I'; 'SR:C10-MG{PS:SL1-P3}I:Ps1DCCT1-I'; 'SR:C10-MG{PS:SL1-P3}I:Ps1DCCT1-I'; 'SR:C10-MG{PS:SL1-P3}I:Ps1DCCT1-I'; 'SR:C16-MG{PS:SL1-P4}I:Ps1DCCT1-I'; 'SR:C16-MG{PS:SL1-P4}I:Ps1DCCT1-I'; 'SR:C16-MG{PS:SL1-P4}I:Ps1DCCT1-I'; 'SR:C16-MG{PS:SL1-P4}I:Ps1DCCT1-I'; 'SR:C16-MG{PS:SL1-P4}I:Ps1DCCT1-I'; 'SR:C16-MG{PS:SL1-P4}I:Ps1DCCT1-I'; 'SR:C22-MG{PS:SL1-P5}I:Ps1DCCT1-I'; 'SR:C22-MG{PS:SL1-P5}I:Ps1DCCT1-I'; 'SR:C22-MG{PS:SL1-P5}I:Ps1DCCT1-I'; 'SR:C22-MG{PS:SL1-P5}I:Ps1DCCT1-I'; 'SR:C22-MG{PS:SL1-P5}I:Ps1DCCT1-I'; 'SR:C22-MG{PS:SL1-P5}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SL1-P1}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SL1-P1}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SL1-P1}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SL1-P1}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SL1-P1}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SL1-P1}I:Ps1DCCT1-I'; 'SR:C04-MG{PS:SL1-P2}I:Ps1DCCT1-I'];
AO.SL1.CommonNames = ['sl1g6c30b'; 'sl1g2c01a'; 'sl1g6c02b'; 'sl1g2c03a'; 'sl1g6c04b'; 'sl1g2c05a'; 'sl1g6c06b'; 'sl1g2c07a'; 'sl1g6c08b'; 'sl1g2c09a'; 'sl1g6c10b'; 'sl1g2c11a'; 'sl1g6c12b'; 'sl1g2c13a'; 'sl1g6c14b'; 'sl1g2c15a'; 'sl1g6c16b'; 'sl1g2c17a'; 'sl1g6c18b'; 'sl1g2c19a'; 'sl1g6c20b'; 'sl1g2c21a'; 'sl1g6c22b'; 'sl1g2c23a'; 'sl1g6c24b'; 'sl1g2c25a'; 'sl1g6c26b'; 'sl1g2c27a'; 'sl1g6c28b'; 'sl1g2c29a'];
AO.SL1.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];
for i=1:30
    AO.SL1.Status(i,1)                = 1;
    AO.SL1.ElementList(i,1)           = i;
    AO.SL1.Setpoint.Range(i,:)        = [-SL1range SL1range];
    AO.SL1.Setpoint.Tolerance(i)      = 0.1;
    AO.SL1.Setpoint.DeltaRespMat(i,1) = 0.5;
end
% SL1 KL setpoint
AO.SL1.SPKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Setpoint'};
AO.SL1.SPKL.Mode = OperationalMode;
AO.SL1.SPKL.DataType = 'Scalar';
AO.SL1.SPKL.ChannelNames  = ['SR:C30-MG{PS:SL1-P2}K:Sp1-SP';'SR:C01-MG{PS:SL1-P2}K:Sp1-SP';'SR:C02-MG{PS:SL1-P2}K:Sp1-SP';'SR:C03-MG{PS:SL1-P2}K:Sp1-SP';'SR:C04-MG{PS:SL1-P2}K:Sp1-SP';'SR:C05-MG{PS:SL1-P3}K:Sp1-SP';'SR:C06-MG{PS:SL1-P3}K:Sp1-SP';'SR:C07-MG{PS:SL1-P3}K:Sp1-SP';'SR:C08-MG{PS:SL1-P3}K:Sp1-SP';'SR:C09-MG{PS:SL1-P3}K:Sp1-SP';'SR:C10-MG{PS:SL1-P3}K:Sp1-SP';'SR:C11-MG{PS:SL1-P4}K:Sp1-SP';'SR:C12-MG{PS:SL1-P4}K:Sp1-SP';'SR:C13-MG{PS:SL1-P4}K:Sp1-SP';'SR:C14-MG{PS:SL1-P4}K:Sp1-SP';'SR:C15-MG{PS:SL1-P4}K:Sp1-SP';'SR:C16-MG{PS:SL1-P4}K:Sp1-SP';'SR:C17-MG{PS:SL1-P5}K:Sp1-SP';'SR:C18-MG{PS:SL1-P5}K:Sp1-SP';'SR:C19-MG{PS:SL1-P5}K:Sp1-SP';'SR:C20-MG{PS:SL1-P5}K:Sp1-SP';'SR:C21-MG{PS:SL1-P5}K:Sp1-SP';'SR:C22-MG{PS:SL1-P5}K:Sp1-SP';'SR:C23-MG{PS:SL1-P1}K:Sp1-SP';'SR:C24-MG{PS:SL1-P1}K:Sp1-SP';'SR:C25-MG{PS:SL1-P1}K:Sp1-SP';'SR:C26-MG{PS:SL1-P1}K:Sp1-SP';'SR:C27-MG{PS:SL1-P1}K:Sp1-SP';'SR:C28-MG{PS:SL1-P1}K:Sp1-SP';'SR:C29-MG{PS:SL1-P2}K:Sp1-SP'];
AO.SL1.SPKL.Units = 'Hardware';
AO.SL1.SPKL.HWUnits     = 'T*m^-2';
% SL1. KL readback
AO.SL1.RBKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Readback'};
AO.SL1.RBKL.Mode = OperationalMode;
AO.SL1.RBKL.DataType = 'Scalar';
AO.SL1.RBKL.ChannelNames  = ['SR:C30-MG{PS:SL1-P2}K:Ps1DCCT1-I';'SR:C01-MG{PS:SL1-P2}K:Ps1DCCT1-I';'SR:C02-MG{PS:SL1-P2}K:Ps1DCCT1-I';'SR:C03-MG{PS:SL1-P2}K:Ps1DCCT1-I';'SR:C04-MG{PS:SL1-P2}K:Ps1DCCT1-I';'SR:C05-MG{PS:SL1-P3}K:Ps1DCCT1-I';'SR:C06-MG{PS:SL1-P3}K:Ps1DCCT1-I';'SR:C07-MG{PS:SL1-P3}K:Ps1DCCT1-I';'SR:C08-MG{PS:SL1-P3}K:Ps1DCCT1-I';'SR:C09-MG{PS:SL1-P3}K:Ps1DCCT1-I';'SR:C10-MG{PS:SL1-P3}K:Ps1DCCT1-I';'SR:C11-MG{PS:SL1-P4}K:Ps1DCCT1-I';'SR:C12-MG{PS:SL1-P4}K:Ps1DCCT1-I';'SR:C13-MG{PS:SL1-P4}K:Ps1DCCT1-I';'SR:C14-MG{PS:SL1-P4}K:Ps1DCCT1-I';'SR:C15-MG{PS:SL1-P4}K:Ps1DCCT1-I';'SR:C16-MG{PS:SL1-P4}K:Ps1DCCT1-I';'SR:C17-MG{PS:SL1-P5}K:Ps1DCCT1-I';'SR:C18-MG{PS:SL1-P5}K:Ps1DCCT1-I';'SR:C19-MG{PS:SL1-P5}K:Ps1DCCT1-I';'SR:C20-MG{PS:SL1-P5}K:Ps1DCCT1-I';'SR:C21-MG{PS:SL1-P5}K:Ps1DCCT1-I';'SR:C22-MG{PS:SL1-P5}K:Ps1DCCT1-I';'SR:C23-MG{PS:SL1-P1}K:Ps1DCCT1-I';'SR:C24-MG{PS:SL1-P1}K:Ps1DCCT1-I';'SR:C25-MG{PS:SL1-P1}K:Ps1DCCT1-I';'SR:C26-MG{PS:SL1-P1}K:Ps1DCCT1-I';'SR:C27-MG{PS:SL1-P1}K:Ps1DCCT1-I';'SR:C28-MG{PS:SL1-P1}K:Ps1DCCT1-I';'SR:C29-MG{PS:SL1-P2}K:Ps1DCCT1-I'];
AO.SL1.RBKL.Units = 'Hardware';
AO.SL1.RBKL.HWUnits     = 'T*m^-2';
AO.SL1.KLname=['rot_coil_STP-9801-0014_001.txt';'rot_coil_STP-9801-0074_000.txt';'rot_coil_STP-9801-0064_000.txt';'rot_coil_STP-9801-0096_000.txt';'rot_coil_STP-9801-0087_000.txt';'rot_coil_STP-9801-0075_000.txt';'rot_coil_STP-9801-0011_001.txt';'rot_coil_STP-9801-0098_000.txt';'rot_coil_STP-9801-0078_000.txt';'rot_coil_STP-9801-0063_000.txt';'rot_coil_STP-9801-0042_001.txt';'rot_coil_STP-9801-0110_000.txt';'rot_coil_STP-9801-0082_000.txt';'rot_coil_STP-9801-0114_000.txt';'rot_coil_STP-9801-0153_000.txt';'rot_coil_STP-9801-0089_000.txt';'rot_coil_STP-9801-0156_000.txt';'rot_coil_STP-9801-0118_000.txt';'rot_coil_STP-9801-0127_000.txt';'rot_coil_STP-9801-0001_000.txt';'rot_coil_STP-9801-0166_000.txt';'rot_coil_STP-9801-0073_001.txt';'rot_coil_STP-9801-0165_000.txt';'rot_coil_STP-9801-0102_000.txt';'rot_coil_STP-9801-0022_001.txt';'rot_coil_STP-9801-0012_001.txt';'rot_coil_STP-9801-0052_001.txt';'rot_coil_STP-9801-0008_001.txt';'rot_coil_STP-9801-0055_000.txt';'rot_coil_STP-9801-0037_000.txt'];


AO.SL2.FamilyName = 'SL2';
AO.SL2.MemberOf = {'MachineConfig'; 'PlotFamily'; 'SEXT'; 'Magnet'; 'Harmonic Sextupole'};
AO.SL2.DeviceList = [];
AO.SL2.ElementList = [];
AO.SL2.Status = [];

AO.SL2.Monitor.Mode           = OperationalMode;
AO.SL2.Monitor.DataType       = 'Scalar';
AO.SL2.Monitor.Units          = 'Hardware';
AO.SL2.Monitor.HWUnits        = 'A';
AO.SL2.Monitor.PhysicsUnits   = 'm^-3';
AO.SL2.Monitor.HW2PhysicsFcn  = @amp2k;
AO.SL2.Monitor.Physics2HWFcn  = @k2amp;

AO.SL2.Setpoint.Mode          = OperationalMode;
AO.SL2.Setpoint.DataType      = 'Scalar';
AO.SL2.Setpoint.Units         = 'Hardware';
AO.SL2.Setpoint.HWUnits       = 'A';
AO.SL2.Setpoint.PhysicsUnits  = 'm^-3';
AO.SL2.Setpoint.HW2PhysicsFcn = @amp2k;
AO.SL2.Setpoint.Physics2HWFcn = @k2amp;

SL2range = 200;

% AO.SL2.Monitor.HW2PhysicsParams  = SL2gain;
% AO.SL2.Monitor.Physics2HWParams  = 1.0/SL2gain;
% AO.SL2.Setpoint.HW2PhysicsParams = SL2gain;
% AO.SL2.Setpoint.Physics2HWParams = 1.0/SL2gain;

AO.SL2.Setpoint.ChannelNames  = ['SR:C03-MG{PS:SL2-P2}I:Sp1-SP'; 'SR:C03-MG{PS:SL2-P2}I:Sp1-SP'; 'SR:C03-MG{PS:SL2-P2}I:Sp1-SP'; 'SR:C03-MG{PS:SL2-P2}I:Sp1-SP'; 'SR:C03-MG{PS:SL2-P2}I:Sp1-SP'; 'SR:C09-MG{PS:SL2-P3}I:Sp1-SP'; 'SR:C09-MG{PS:SL2-P3}I:Sp1-SP'; 'SR:C09-MG{PS:SL2-P3}I:Sp1-SP'; 'SR:C09-MG{PS:SL2-P3}I:Sp1-SP'; 'SR:C09-MG{PS:SL2-P3}I:Sp1-SP'; 'SR:C09-MG{PS:SL2-P3}I:Sp1-SP'; 'SR:C15-MG{PS:SL2-P4}I:Sp1-SP'; 'SR:C15-MG{PS:SL2-P4}I:Sp1-SP'; 'SR:C15-MG{PS:SL2-P4}I:Sp1-SP'; 'SR:C15-MG{PS:SL2-P4}I:Sp1-SP'; 'SR:C15-MG{PS:SL2-P4}I:Sp1-SP'; 'SR:C15-MG{PS:SL2-P4}I:Sp1-SP'; 'SR:C21-MG{PS:SL2-P5}I:Sp1-SP'; 'SR:C21-MG{PS:SL2-P5}I:Sp1-SP'; 'SR:C21-MG{PS:SL2-P5}I:Sp1-SP'; 'SR:C21-MG{PS:SL2-P5}I:Sp1-SP'; 'SR:C21-MG{PS:SL2-P5}I:Sp1-SP'; 'SR:C21-MG{PS:SL2-P5}I:Sp1-SP'; 'SR:C27-MG{PS:SL2-P1}I:Sp1-SP'; 'SR:C27-MG{PS:SL2-P1}I:Sp1-SP'; 'SR:C27-MG{PS:SL2-P1}I:Sp1-SP'; 'SR:C27-MG{PS:SL2-P1}I:Sp1-SP'; 'SR:C27-MG{PS:SL2-P1}I:Sp1-SP'; 'SR:C27-MG{PS:SL2-P1}I:Sp1-SP'; 'SR:C03-MG{PS:SL2-P2}I:Sp1-SP'];
AO.SL2.Monitor.ChannelNames = ['SR:C03-MG{PS:SL2-P2}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SL2-P2}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SL2-P2}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SL2-P2}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SL2-P2}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL2-P3}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL2-P3}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL2-P3}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL2-P3}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL2-P3}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL2-P3}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL2-P4}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL2-P4}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL2-P4}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL2-P4}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL2-P4}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL2-P4}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL2-P5}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL2-P5}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL2-P5}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL2-P5}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL2-P5}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL2-P5}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL2-P1}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL2-P1}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL2-P1}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL2-P1}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL2-P1}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL2-P1}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SL2-P2}I:Ps1DCCT1-I'];
AO.SL2.CommonNames = ['sl2g6c30b'; 'sl2g2c01a'; 'sl2g6c02b'; 'sl2g2c03a'; 'sl2g6c04b'; 'sl2g2c05a'; 'sl2g6c06b'; 'sl2g2c07a'; 'sl2g6c08b'; 'sl2g2c09a'; 'sl2g6c10b'; 'sl2g2c11a'; 'sl2g6c12b'; 'sl2g2c13a'; 'sl2g6c14b'; 'sl2g2c15a'; 'sl2g6c16b'; 'sl2g2c17a'; 'sl2g6c18b'; 'sl2g2c19a'; 'sl2g6c20b'; 'sl2g2c21a'; 'sl2g6c22b'; 'sl2g2c23a'; 'sl2g6c24b'; 'sl2g2c25a'; 'sl2g6c26b'; 'sl2g2c27a'; 'sl2g6c28b'; 'sl2g2c29a'];
AO.SL2.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];
for i=1:30
    AO.SL2.Status(i,1)                = 1;
    AO.SL2.ElementList(i,1)           = i;
    AO.SL2.Setpoint.Range(i,:)        = [-SL2range SL2range];
    AO.SL2.Setpoint.Tolerance(i)      = 0.1;
    AO.SL2.Setpoint.DeltaRespMat(i,1) = 0.5;
end
% SL2 KL setpoint
AO.SL2.SPKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Setpoint'};
AO.SL2.SPKL.Mode = OperationalMode;
AO.SL2.SPKL.DataType = 'Scalar';
AO.SL2.SPKL.ChannelNames  = ['SR:C30-MG{PS:SL2-P2}K:Sp1-SP';'SR:C01-MG{PS:SL2-P2}K:Sp1-SP';'SR:C02-MG{PS:SL2-P2}K:Sp1-SP';'SR:C03-MG{PS:SL2-P2}K:Sp1-SP';'SR:C04-MG{PS:SL2-P2}K:Sp1-SP';'SR:C05-MG{PS:SL2-P3}K:Sp1-SP';'SR:C06-MG{PS:SL2-P3}K:Sp1-SP';'SR:C07-MG{PS:SL2-P3}K:Sp1-SP';'SR:C08-MG{PS:SL2-P3}K:Sp1-SP';'SR:C09-MG{PS:SL2-P3}K:Sp1-SP';'SR:C10-MG{PS:SL2-P3}K:Sp1-SP';'SR:C11-MG{PS:SL2-P4}K:Sp1-SP';'SR:C12-MG{PS:SL2-P4}K:Sp1-SP';'SR:C13-MG{PS:SL2-P4}K:Sp1-SP';'SR:C14-MG{PS:SL2-P4}K:Sp1-SP';'SR:C15-MG{PS:SL2-P4}K:Sp1-SP';'SR:C16-MG{PS:SL2-P4}K:Sp1-SP';'SR:C17-MG{PS:SL2-P5}K:Sp1-SP';'SR:C18-MG{PS:SL2-P5}K:Sp1-SP';'SR:C19-MG{PS:SL2-P5}K:Sp1-SP';'SR:C20-MG{PS:SL2-P5}K:Sp1-SP';'SR:C21-MG{PS:SL2-P5}K:Sp1-SP';'SR:C22-MG{PS:SL2-P5}K:Sp1-SP';'SR:C23-MG{PS:SL2-P1}K:Sp1-SP';'SR:C24-MG{PS:SL2-P1}K:Sp1-SP';'SR:C25-MG{PS:SL2-P1}K:Sp1-SP';'SR:C26-MG{PS:SL2-P1}K:Sp1-SP';'SR:C27-MG{PS:SL2-P1}K:Sp1-SP';'SR:C28-MG{PS:SL2-P1}K:Sp1-SP';'SR:C29-MG{PS:SL2-P2}K:Sp1-SP'];
AO.SL2.SPKL.Units = 'Hardware';
AO.SL2.SPKL.HWUnits     = 'T*m^-2';
% SL2. KL readback
AO.SL2.RBKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Readback'};
AO.SL2.RBKL.Mode = OperationalMode;
AO.SL2.RBKL.DataType = 'Scalar';
AO.SL2.RBKL.ChannelNames  = ['SR:C30-MG{PS:SL2-P2}K:Ps1DCCT1-I';'SR:C01-MG{PS:SL2-P2}K:Ps1DCCT1-I';'SR:C02-MG{PS:SL2-P2}K:Ps1DCCT1-I';'SR:C03-MG{PS:SL2-P2}K:Ps1DCCT1-I';'SR:C04-MG{PS:SL2-P2}K:Ps1DCCT1-I';'SR:C05-MG{PS:SL2-P3}K:Ps1DCCT1-I';'SR:C06-MG{PS:SL2-P3}K:Ps1DCCT1-I';'SR:C07-MG{PS:SL2-P3}K:Ps1DCCT1-I';'SR:C08-MG{PS:SL2-P3}K:Ps1DCCT1-I';'SR:C09-MG{PS:SL2-P3}K:Ps1DCCT1-I';'SR:C10-MG{PS:SL2-P3}K:Ps1DCCT1-I';'SR:C11-MG{PS:SL2-P4}K:Ps1DCCT1-I';'SR:C12-MG{PS:SL2-P4}K:Ps1DCCT1-I';'SR:C13-MG{PS:SL2-P4}K:Ps1DCCT1-I';'SR:C14-MG{PS:SL2-P4}K:Ps1DCCT1-I';'SR:C15-MG{PS:SL2-P4}K:Ps1DCCT1-I';'SR:C16-MG{PS:SL2-P4}K:Ps1DCCT1-I';'SR:C17-MG{PS:SL2-P5}K:Ps1DCCT1-I';'SR:C18-MG{PS:SL2-P5}K:Ps1DCCT1-I';'SR:C19-MG{PS:SL2-P5}K:Ps1DCCT1-I';'SR:C20-MG{PS:SL2-P5}K:Ps1DCCT1-I';'SR:C21-MG{PS:SL2-P5}K:Ps1DCCT1-I';'SR:C22-MG{PS:SL2-P5}K:Ps1DCCT1-I';'SR:C23-MG{PS:SL2-P1}K:Ps1DCCT1-I';'SR:C24-MG{PS:SL2-P1}K:Ps1DCCT1-I';'SR:C25-MG{PS:SL2-P1}K:Ps1DCCT1-I';'SR:C26-MG{PS:SL2-P1}K:Ps1DCCT1-I';'SR:C27-MG{PS:SL2-P1}K:Ps1DCCT1-I';'SR:C28-MG{PS:SL2-P1}K:Ps1DCCT1-I';'SR:C29-MG{PS:SL2-P2}K:Ps1DCCT1-I'];

AO.SL2.RBKL.Units = 'Hardware';
AO.SL2.RBKL.HWUnits     = 'T*m^-2';
AO.SL2.KLname=['rot_coil_STP-9801-0013_001.txt';'rot_coil_STP-9801-0081_000.txt';'rot_coil_STP-9801-0038_001.txt';'rot_coil_STP-9801-0095_000.txt';'rot_coil_STP-9801-0086_000.txt';'rot_coil_STP-9801-0076_000.txt';'rot_coil_STP-9801-0060_001.txt';'rot_coil_STP-9801-0099_000.txt';'rot_coil_STP-9801-0077_000.txt';'rot_coil_STP-9801-0043_001.txt';'rot_coil_STP-9801-0041_001.txt';'rot_coil_STP-9801-0111_000.txt';'rot_coil_STP-9801-0080_000.txt';'rot_coil_STP-9801-0115_000.txt';'rot_coil_STP-9801-0152_000.txt';'rot_coil_STP-9801-0149_000.txt';'rot_coil_STP-9801-0155_000.txt';'rot_coil_STP-9801-0121_000.txt';'rot_coil_STP-9801-0116_000.txt';'rot_coil_STP-9801-0005_000.txt';'rot_coil_STP-9801-0130_000.txt';'rot_coil_STP-9801-0119_000.txt';'rot_coil_STP-9801-0157_000.txt';'rot_coil_STP-9801-0105_000.txt';'rot_coil_STP-9801-0021_001.txt';'rot_coil_STP-9801-0020_001.txt';'rot_coil_STP-9801-0051_001.txt';'rot_coil_STP-9801-0009_001.txt';'rot_coil_STP-9801-0054_000.txt';'rot_coil_STP-9801-0039_001.txt'];

AO.SL3.FamilyName = 'SL3';
AO.SL3.MemberOf = {'MachineConfig'; 'PlotFamily'; 'SEXT'; 'Magnet'; 'Harmonic Sextupole'};
AO.SL3.DeviceList = [];
AO.SL3.ElementList = [];
AO.SL3.Status = [];

AO.SL3.Monitor.Mode           = OperationalMode;
AO.SL3.Monitor.DataType       = 'Scalar';
AO.SL3.Monitor.Units          = 'Hardware';
AO.SL3.Monitor.HWUnits        = 'A';
AO.SL3.Monitor.PhysicsUnits   = 'm^-3';
AO.SL3.Monitor.HW2PhysicsFcn  = @amp2k;
AO.SL3.Monitor.Physics2HWFcn  = @k2amp;

AO.SL3.Setpoint.Mode          = OperationalMode;
AO.SL3.Setpoint.DataType      = 'Scalar';
AO.SL3.Setpoint.Units         = 'Hardware';
AO.SL3.Setpoint.HWUnits       = 'A';
AO.SL3.Setpoint.PhysicsUnits  = 'm^-3';
AO.SL3.Setpoint.HW2PhysicsFcn = @amp2k;
AO.SL3.Setpoint.Physics2HWFcn = @k2amp;

SL3range = 200;

% AO.SL3.Monitor.HW2PhysicsParams  = SL3gain;
% AO.SL3.Monitor.Physics2HWParams  = 1.0/SL3gain;
% AO.SL3.Setpoint.HW2PhysicsParams = SL3gain;
% AO.SL3.Setpoint.Physics2HWParams = 1.0/SL3gain;

AO.SL3.Setpoint.ChannelNames  = ['SR:C03-MG{PS:SL3-P2}I:Sp1-SP'; 'SR:C03-MG{PS:SL3-P2}I:Sp1-SP'; 'SR:C03-MG{PS:SL3-P2}I:Sp1-SP'; 'SR:C03-MG{PS:SL3-P2}I:Sp1-SP'; 'SR:C03-MG{PS:SL3-P2}I:Sp1-SP'; 'SR:C09-MG{PS:SL3-P3}I:Sp1-SP'; 'SR:C09-MG{PS:SL3-P3}I:Sp1-SP'; 'SR:C09-MG{PS:SL3-P3}I:Sp1-SP'; 'SR:C09-MG{PS:SL3-P3}I:Sp1-SP'; 'SR:C09-MG{PS:SL3-P3}I:Sp1-SP'; 'SR:C09-MG{PS:SL3-P3}I:Sp1-SP'; 'SR:C15-MG{PS:SL3-P4}I:Sp1-SP'; 'SR:C15-MG{PS:SL3-P4}I:Sp1-SP'; 'SR:C15-MG{PS:SL3-P4}I:Sp1-SP'; 'SR:C15-MG{PS:SL3-P4}I:Sp1-SP'; 'SR:C15-MG{PS:SL3-P4}I:Sp1-SP'; 'SR:C15-MG{PS:SL3-P4}I:Sp1-SP'; 'SR:C21-MG{PS:SL3-P5}I:Sp1-SP'; 'SR:C21-MG{PS:SL3-P5}I:Sp1-SP'; 'SR:C21-MG{PS:SL3-P5}I:Sp1-SP'; 'SR:C21-MG{PS:SL3-P5}I:Sp1-SP'; 'SR:C21-MG{PS:SL3-P5}I:Sp1-SP'; 'SR:C21-MG{PS:SL3-P5}I:Sp1-SP'; 'SR:C27-MG{PS:SL3-P1}I:Sp1-SP'; 'SR:C27-MG{PS:SL3-P1}I:Sp1-SP'; 'SR:C27-MG{PS:SL3-P1}I:Sp1-SP'; 'SR:C27-MG{PS:SL3-P1}I:Sp1-SP'; 'SR:C27-MG{PS:SL3-P1}I:Sp1-SP'; 'SR:C27-MG{PS:SL3-P1}I:Sp1-SP'; 'SR:C03-MG{PS:SL3-P2}I:Sp1-SP'];
AO.SL3.Monitor.ChannelNames = ['SR:C03-MG{PS:SL3-P2}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SL3-P2}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SL3-P2}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SL3-P2}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SL3-P2}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL3-P3}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL3-P3}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL3-P3}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL3-P3}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL3-P3}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SL3-P3}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL3-P4}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL3-P4}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL3-P4}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL3-P4}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL3-P4}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SL3-P4}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL3-P5}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL3-P5}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL3-P5}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL3-P5}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL3-P5}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SL3-P5}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL3-P1}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL3-P1}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL3-P1}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL3-P1}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL3-P1}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SL3-P1}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SL3-P2}I:Ps1DCCT1-I'];
AO.SL3.CommonNames = ['sl3g6c30b'; 'sl3g2c01a'; 'sl3g6c02b'; 'sl3g2c03a'; 'sl3g6c04b'; 'sl3g2c05a'; 'sl3g6c06b'; 'sl3g2c07a'; 'sl3g6c08b'; 'sl3g2c09a'; 'sl3g6c10b'; 'sl3g2c11a'; 'sl3g6c12b'; 'sl3g2c13a'; 'sl3g6c14b'; 'sl3g2c15a'; 'sl3g6c16b'; 'sl3g2c17a'; 'sl3g6c18b'; 'sl3g2c19a'; 'sl3g6c20b'; 'sl3g2c21a'; 'sl3g6c22b'; 'sl3g2c23a'; 'sl3g6c24b'; 'sl3g2c25a'; 'sl3g6c26b'; 'sl3g2c27a'; 'sl3g6c28b'; 'sl3g2c29a'];
AO.SL3.DeviceList = [ 30 1; 1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1; 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1; 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1];
for i=1:30
    AO.SL3.Status(i,1)                = 1;
    AO.SL3.ElementList(i,1)           = i;
    AO.SL3.Setpoint.Range(i,:)        = [-SL3range SL3range];
    AO.SL3.Setpoint.Tolerance(i)      = 0.1;
    AO.SL3.Setpoint.DeltaRespMat(i,1) = 0.5;
end
% SL3 KL setpoint
AO.SL3.SPKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Setpoint'};
AO.SL3.SPKL.Mode = OperationalMode;
AO.SL3.SPKL.DataType = 'Scalar';
AO.SL3.SPKL.ChannelNames  = ['SR:C30-MG{PS:SL3-P2}K:Sp1-SP';'SR:C01-MG{PS:SL3-P2}K:Sp1-SP';'SR:C02-MG{PS:SL3-P2}K:Sp1-SP';'SR:C03-MG{PS:SL3-P2}K:Sp1-SP';'SR:C04-MG{PS:SL3-P2}K:Sp1-SP';'SR:C05-MG{PS:SL3-P3}K:Sp1-SP';'SR:C06-MG{PS:SL3-P3}K:Sp1-SP';'SR:C07-MG{PS:SL3-P3}K:Sp1-SP';'SR:C08-MG{PS:SL3-P3}K:Sp1-SP';'SR:C09-MG{PS:SL3-P3}K:Sp1-SP';'SR:C10-MG{PS:SL3-P3}K:Sp1-SP';'SR:C11-MG{PS:SL3-P4}K:Sp1-SP';'SR:C12-MG{PS:SL3-P4}K:Sp1-SP';'SR:C13-MG{PS:SL3-P4}K:Sp1-SP';'SR:C14-MG{PS:SL3-P4}K:Sp1-SP';'SR:C15-MG{PS:SL3-P4}K:Sp1-SP';'SR:C16-MG{PS:SL3-P4}K:Sp1-SP';'SR:C17-MG{PS:SL3-P5}K:Sp1-SP';'SR:C18-MG{PS:SL3-P5}K:Sp1-SP';'SR:C19-MG{PS:SL3-P5}K:Sp1-SP';'SR:C20-MG{PS:SL3-P5}K:Sp1-SP';'SR:C21-MG{PS:SL3-P5}K:Sp1-SP';'SR:C22-MG{PS:SL3-P5}K:Sp1-SP';'SR:C23-MG{PS:SL3-P1}K:Sp1-SP';'SR:C24-MG{PS:SL3-P1}K:Sp1-SP';'SR:C25-MG{PS:SL3-P1}K:Sp1-SP';'SR:C26-MG{PS:SL3-P1}K:Sp1-SP';'SR:C27-MG{PS:SL3-P1}K:Sp1-SP';'SR:C28-MG{PS:SL3-P1}K:Sp1-SP';'SR:C29-MG{PS:SL3-P2}K:Sp1-SP'];
AO.SL3.SPKL.Units = 'Hardware';
AO.SL3.SPKL.HWUnits     = 'T*m^-2';
% SL3. KL readback
AO.SL3.RBKL.MemberOf   = {'PlotFamily'; 'SEXT'; 'Magnet';'Readback'};
AO.SL3.RBKL.Mode = OperationalMode;
AO.SL3.RBKL.DataType = 'Scalar';
AO.SL3.RBKL.ChannelNames  = ['SR:C30-MG{PS:SL3-P2}K:Ps1DCCT1-I';'SR:C01-MG{PS:SL3-P2}K:Ps1DCCT1-I';'SR:C02-MG{PS:SL3-P2}K:Ps1DCCT1-I';'SR:C03-MG{PS:SL3-P2}K:Ps1DCCT1-I';'SR:C04-MG{PS:SL3-P2}K:Ps1DCCT1-I';'SR:C05-MG{PS:SL3-P3}K:Ps1DCCT1-I';'SR:C06-MG{PS:SL3-P3}K:Ps1DCCT1-I';'SR:C07-MG{PS:SL3-P3}K:Ps1DCCT1-I';'SR:C08-MG{PS:SL3-P3}K:Ps1DCCT1-I';'SR:C09-MG{PS:SL3-P3}K:Ps1DCCT1-I';'SR:C10-MG{PS:SL3-P3}K:Ps1DCCT1-I';'SR:C11-MG{PS:SL3-P4}K:Ps1DCCT1-I';'SR:C12-MG{PS:SL3-P4}K:Ps1DCCT1-I';'SR:C13-MG{PS:SL3-P4}K:Ps1DCCT1-I';'SR:C14-MG{PS:SL3-P4}K:Ps1DCCT1-I';'SR:C15-MG{PS:SL3-P4}K:Ps1DCCT1-I';'SR:C16-MG{PS:SL3-P4}K:Ps1DCCT1-I';'SR:C17-MG{PS:SL3-P5}K:Ps1DCCT1-I';'SR:C18-MG{PS:SL3-P5}K:Ps1DCCT1-I';'SR:C19-MG{PS:SL3-P5}K:Ps1DCCT1-I';'SR:C20-MG{PS:SL3-P5}K:Ps1DCCT1-I';'SR:C21-MG{PS:SL3-P5}K:Ps1DCCT1-I';'SR:C22-MG{PS:SL3-P5}K:Ps1DCCT1-I';'SR:C23-MG{PS:SL3-P1}K:Ps1DCCT1-I';'SR:C24-MG{PS:SL3-P1}K:Ps1DCCT1-I';'SR:C25-MG{PS:SL3-P1}K:Ps1DCCT1-I';'SR:C26-MG{PS:SL3-P1}K:Ps1DCCT1-I';'SR:C27-MG{PS:SL3-P1}K:Ps1DCCT1-I';'SR:C28-MG{PS:SL3-P1}K:Ps1DCCT1-I';'SR:C29-MG{PS:SL3-P2}K:Ps1DCCT1-I'];
AO.SL3.RBKL.Units = 'Hardware';
AO.SL3.RBKL.HWUnits     = 'T*m^-2';
AO.SL3.KLname=['rot_coil_STP-9802-0049_000.txt';'rot_coil_STP-9801-0084_000.txt';'rot_coil_STP-9802-0036_000.txt';'rot_coil_STP-9801-0094_000.txt';'rot_coil_STP-9802-0052_000.txt';'rot_coil_STP-9801-0104_000.txt';'rot_coil_STP-9802-0029_000.txt';'rot_coil_STP-9801-0103_000.txt';'rot_coil_STP-9802-0056_000.txt';'rot_coil_STP-9801-0044_001.txt';'rot_coil_STP-9802-0048_000.txt';'rot_coil_STP-9801-0112_000.txt';'rot_coil_STP-9802-0037_000.txt';'rot_coil_STP-9801-0146_000.txt';'rot_coil_STP-9802-0073_000.txt';'rot_coil_STP-9801-0151_000.txt';'rot_coil_STP-9802-0081_000.txt';'rot_coil_STP-9801-0162_000.txt';'rot_coil_STP-9802-0083_000.txt';'rot_coil_STP-9801-0163_000.txt';'rot_coil_STP-9802-0017_001.txt';'rot_coil_STP-9801-0125_000.txt';'rot_coil_STP-9802-0077_000.txt';'rot_coil_STP-9801-0107_000.txt';'rot_coil_STP-9802-0011_001.txt';'rot_coil_STP-9801-0025_001.txt';'rot_coil_STP-9802-0021_002.txt';'rot_coil_STP-9801-0059_000.txt';'rot_coil_STP-9802-0016_000.txt';'rot_coil_STP-9801-0040_001.txt'];


% Skew Quadrupoles
AO.SQ.FamilyName             = 'SQ';
AO.SQ.MemberOf               = {'MachineConfig'; 'PlotFamily';  'SKEWQUAD'; 'Magnet'}; %'SKEWQUAD';
AO.SQ.DeviceList = [];
AO.SQ.ElementList = [];
AO.SQ.Status = [];

AO.SQ.Monitor.Mode           = OperationalMode;
AO.SQ.Monitor.DataType       = 'Scalar';
AO.SQ.Monitor.Units          = 'Hardware';
AO.SQ.Monitor.HWUnits        = 'A';
AO.SQ.Monitor.PhysicsUnits   = 'm^-1';
%AO.SQ.Monitor.HW2PhysicsFcn  = @amp2k;
%AO.Sq.Monitor.Physics2HWFcn  = @k2amp;
AO.SQ.Setpoint.Mode          = OperationalMode;
AO.SQ.Setpoint.DataType      = 'Scalar';
AO.SQ.Setpoint.Units         = 'Hardware';
AO.SQ.Setpoint.HWUnits       = 'A';
AO.SQ.Setpoint.PhysicsUnits  = 'rad';
%AO.SQ.Setpoint.HW2PhysicsFcn = @amp2k;
%AO.SQ.Setpoint.Physics2HWFcn = @k2amp;

SQrange = 10.0;   % [A]
SQgain  = 0.8e-4; % [m^-1/A]
SQtol   = 0.010;  % Tolerance [A]

AO.SQ.Setpoint.ChannelNames  = ['SR:C30-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C30-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C01-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C01-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C02-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C02-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C03-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C03-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C04-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C04-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C05-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C05-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C06-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C06-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C07-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C07-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C08-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C08-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C09-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C09-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C10-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C10-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C11-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C11-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C12-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C12-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C13-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C13-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C14-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C14-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C15-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C15-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C16-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C16-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C17-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C17-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C18-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C18-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C19-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C19-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C20-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C20-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C21-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C21-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C22-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C22-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C23-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C23-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C24-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C24-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C25-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C25-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C26-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C26-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C27-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C27-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C28-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C28-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C29-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C29-MG{PS:SQKM1A}I:Sp1-SP'];

%['SR:C30-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C01-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C02-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C03-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C04-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C05-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C06-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C07-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C08-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C09-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C10-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C11-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C12-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C13-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C14-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C15-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C16-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C17-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C18-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C19-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C20-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C21-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C22-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C23-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C24-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C25-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C26-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C27-MG{PS:SQKM1A}I:Sp1-SP'; 'SR:C28-MG{PS:SQKH1A}I:Sp1-SP'; 'SR:C29-MG{PS:SQKM1A}I:Sp1-SP'];
AO.SQ.Monitor.ChannelNames = ['SR:C30-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C30-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C01-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C01-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C04-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C04-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C05-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C05-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C06-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C06-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C07-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C07-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C10-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C10-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C11-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C11-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C12-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C12-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C13-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C13-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C16-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C16-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C17-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C17-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C18-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C18-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C19-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C19-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C22-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C22-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C23-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C23-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C24-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C24-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C25-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C25-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C29-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C29-MG{PS:SQKM1A}I:Ps1DCCT1-I'];
%['SR:C30-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C01-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C02-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C03-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C04-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C05-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C06-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C07-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C08-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C09-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C10-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C11-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C12-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C13-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C14-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C15-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C16-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C17-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C18-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C19-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C20-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C21-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C22-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C23-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C24-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C25-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C26-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C27-MG{PS:SQKM1A}I:Ps1DCCT1-I'; 'SR:C28-MG{PS:SQKH1A}I:Ps1DCCT1-I'; 'SR:C29-MG{PS:SQKM1A}I:Ps1DCCT1-I'];
AO.SQ.CommonNames = ['sqhhg2c30a'; 'sqhhg2c30a'; 'sqmhg4c01a'; 'sqmhg4c01a'; 'sqhhg2c02a'; 'sqhhg2c02a'; 'sqmhg4c03a'; 'sqmhg4c03a'; 'sqhhg2c04a'; 'sqhhg2c04a'; 'sqmhg4c05a'; 'sqmhg4c05a'; 'sqhhg2c06a'; 'sqhhg2c06a'; 'sqmhg4c07a'; 'sqmhg4c07a'; 'sqhhg2c08a'; 'sqhhg2c08a'; 'sqmhg4c09a'; 'sqmhg4c09a'; 'sqhhg2c10a'; 'sqhhg2c10a'; 'sqmhg4c11a'; 'sqmhg4c11a'; 'sqhhg2c12a'; 'sqhhg2c12a'; 'sqmhg4c13a'; 'sqmhg4c13a'; 'sqhhg2c14a'; 'sqhhg2c14a'; 'sqmhg4c15a'; 'sqmhg4c15a'; 'sqhhg2c16a'; 'sqhhg2c16a'; 'sqmhg4c17a'; 'sqmhg4c17a'; 'sqhhg2c18a'; 'sqhhg2c18a'; 'sqmhg4c19a'; 'sqmhg4c19a'; 'sqhhg2c20a'; 'sqhhg2c20a'; 'sqmhg4c21a'; 'sqmhg4c21a'; 'sqhhg2c22a'; 'sqhhg2c22a'; 'sqmhg4c23a'; 'sqmhg4c23a'; 'sqhhg2c24a'; 'sqhhg2c24a'; 'sqmhg4c25a'; 'sqmhg4c25a'; 'sqhhg2c26a'; 'sqhhg2c26a'; 'sqmhg4c27a'; 'sqmhg4c27a'; 'sqhhg2c28a'; 'sqhhg2c28a'; 'sqmhg4c29a'; 'sqmhg4c29a'];
%['sqhhg2c30a'; 'sqmhg4c01a'; 'sqhhg2c02a'; 'sqmhg4c03a'; 'sqhhg2c04a'; 'sqmhg4c05a'; 'sqhhg2c06a'; 'sqmhg4c07a'; 'sqhhg2c08a'; 'sqmhg4c09a'; 'sqhhg2c10a'; 'sqmhg4c11a'; 'sqhhg2c12a'; 'sqmhg4c13a'; 'sqhhg2c14a'; 'sqmhg4c15a'; 'sqhhg2c16a'; 'sqmhg4c17a'; 'sqhhg2c18a'; 'sqmhg4c19a'; 'sqhhg2c20a'; 'sqmhg4c21a'; 'sqhhg2c22a'; 'sqmhg4c23a'; 'sqhhg2c24a'; 'sqmhg4c25a'; 'sqhhg2c26a'; 'sqmhg4c27a'; 'sqhhg2c28a'; 'sqmhg4c29a'];
AO.SQ.DeviceList = [30 1; 30 2; 1 1; 1 2; 2 1; 2 2; 3 1; 3 2; 4 1; 4 2; 5 1; 5 2; 6 1; 6 2; 7 1; 7 2; 8 1; 8 2; 9 1; 9 2; 10 1; 10 2; 11 1; 11 2; 12 1; 12 2; 13 1; 13 2; 14 1; 14 2; 15 1; 15 2; 16 1; 16 2; 17 1; 17 2; 18 1; 18 2; 19 1; 19 2; 20 1; 20 2; 21 1; 21 2; 22 1; 22 2; 23 1; 23 2; 24 1; 24 2; 25 1; 25 2; 26 1; 26 2; 27 1; 27 2; 28 1; 28 2; 29 1; 29 2];
for k=1:60 % skew quadrupoles are only in high beta sections
    AO.SQ.Status(k,1) = 1;
    AO.SQ.ElementList(k,1)               = k;
    AO.SQ.Setpoint.Range(k,:)            = [-SQrange SQrange];
    AO.SQ.Setpoint.Tolerance(k,1)        = SQtol;
    AO.SQ.Monitor.HW2PhysicsParams(k,1)  = SQgain;
    AO.SQ.Monitor.Physics2HWParams(k,1)  = 1/SQgain;
    AO.SQ.Setpoint.HW2PhysicsParams(k,1) = SQgain;
    AO.SQ.Setpoint.Physics2HWParams(k,1) = 1/SQgain;
end


% Dipoles
AO.BEND.FamilyName = 'BEND';
AO.BEND.MemberOf = {'MachineConfig'; 'BEND'; 'PlotFamily'; 'Magnet';};
AO.BEND.DeviceList = [];
AO.BEND.ElementList = [];
AO.BEND.Status = [];

AO.BEND.Monitor.Mode           = OperationalMode;
AO.BEND.Monitor.DataType       = 'Scalar';
AO.BEND.Monitor.Units          = 'Hardware';
AO.BEND.Monitor.HWUnits        = 'A';
AO.BEND.Monitor.PhysicsUnits   = 'rad';
%AO.BEND.Monitor.HW2PhysicsFcn  = @amp2k;
%AO.BEND.Monitor.Physics2HWFcn  = @k2amp;

AO.BEND.Setpoint.Mode          = OperationalMode;
AO.BEND.Setpoint.DataType      = 'Scalar';
AO.BEND.Setpoint.Units         = 'Hardware';
AO.BEND.Setpoint.HWUnits       = 'A';
AO.BEND.Setpoint.PhysicsUnits  = 'rad';
%AO.BEND.Setpoint.HW2PhysicsFcn = @amp2k;
%AO.BEND.Setpoint.Physics2HWFcn = @k2amp;

BENDGain = [0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000289,0.000289,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000289,0.000289,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000289,0.000289,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284,0.000289,0.000284,0.000284,0.000284,0.000284,0.000284,0.000284];  %  rad/A
% BENDGain = 2*pi/60/950;  %  rad/A
% AO.BEND.Monitor.HW2PhysicsParams  = BENDGain;
% AO.BEND.Monitor.Physics2HWParams  = 1.0/BENDGain;
% AO.BEND.Setpoint.HW2PhysicsParams = BENDGain;
% AO.BEND.Setpoint.Physics2HWParams = 1.0/BENDGain;
AO.BEND.Setpoint.Range        = [0 1000];
AO.BEND.Setpoint.Tolerance    = 0.05;
AO.BEND.Setpoint.DeltaRespMat = 0.1;

AO.BEND.Setpoint.ChannelNames = ['SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'; 'SR:C03-MG{PS:D-SP}I:Sp1-SP'];
AO.BEND.Monitor.ChannelNames = ['SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'; 'SR:C03-MG{PS:D-SP}I:Readback-I'];
AO.BEND.CommonNames = ['b1g3c30a'; 'b1g5c30b'; 'b1g3c01a'; 'b1g5c01b'; 'b1g3c02a'; 'b1g5c02b'; 'b2g3c03a'; 'b2g5c03b'; 'b1g3c04a'; 'b1g5c04b'; 'b1g3c05a'; 'b1g5c05b'; 'b1g3c06a'; 'b1g5c06b'; 'b1g3c07a'; 'b1g5c07b'; 'b1g3c08a'; 'b1g5c08b'; 'b1g3c09a'; 'b1g5c09b'; 'b1g3c10a'; 'b1g5c10b'; 'b1g3c11a'; 'b1g5c11b'; 'b1g3c12a'; 'b1g5c12b'; 'b2g3c13a'; 'b2g5c13b'; 'b1g3c14a'; 'b1g5c14b'; 'b1g3c15a'; 'b1g5c15b'; 'b1g3c16a'; 'b1g5c16b'; 'b1g3c17a'; 'b1g5c17b'; 'b1g3c18a'; 'b1g5c18b'; 'b1g3c19a'; 'b1g5c19b'; 'b1g3c20a'; 'b1g5c20b'; 'b1g3c21a'; 'b1g5c21b'; 'b1g3c22a'; 'b1g5c22b'; 'b2g3c23a'; 'b2g5c23b'; 'b1g3c24a'; 'b1g5c24b'; 'b1g3c25a'; 'b1g5c25b'; 'b1g3c26a'; 'b1g5c26b'; 'b1g3c27a'; 'b1g5c27b'; 'b1g3c28a'; 'b1g5c28b'; 'b1g3c29a'; 'b1g5c29b'];
AO.BEND.DeviceList = [30 1; 30 2; 1 1; 1 2; 2 1; 2 2; 3 1; 3 2; 4 1; 4 2; 5 1; 5 2; 6 1; 6 2; 7 1; 7 2; 8 1; 8 2; 9 1; 9 2; 10 1; 10 2; 11 1; 11 2; 12 1; 12 2; 13 1; 13 2; 14 1; 14 2; 15 1; 15 2; 16 1; 16 2; 17 1; 17 2; 18 1; 18 2; 19 1; 19 2; 20 1; 20 2; 21 1; 21 2; 22 1; 22 2; 23 1; 23 2; 24 1; 24 2; 25 1; 25 2; 26 1; 26 2; 27 1; 27 2; 28 1; 28 2; 29 1; 29 2];

for i=1:30
    for j=1:2
        k=j+2*(i-1);
        AO.BEND.Status(k,1)                = 1;
        AO.BEND.ElementList(k,1)           = k;
        AO.BEND.Monitor.HW2PhysicsParams(k,1)  = BENDGain(k);
        AO.BEND.Monitor.Physics2HWParams(k,1)  = 1/BENDGain(k);
        AO.BEND.Setpoint.HW2PhysicsParams(k,1) = BENDGain(k);
        AO.BEND.Setpoint.Physics2HWParams(k,1) = 1/BENDGain(k);       
    end
end

% RF
AO.RF.FamilyName = 'RF';
AO.RF.MemberOf   = {'MachineConfig'; 'RF'};
AO.RF.DeviceList = [1 1];
AO.RF.ElementList = 1;
AO.RF.Status = 1;
AO.RF.Position = 0;

AO.RF.Monitor.Mode = 'Simulator';
AO.RF.Monitor.DataType = 'Scalar';
AO.RF.Monitor.ChannelNames = 'RF{Osc:1}Freq:I';
AO.RF.Monitor.HW2PhysicsParams = 1e6;
AO.RF.Monitor.Physics2HWParams = 1/1e6;
AO.RF.Monitor.Units = 'Hardware';
AO.RF.Monitor.HWUnits       = 'MHz';
AO.RF.Monitor.PhysicsUnits  = 'Hz';

AO.RF.Setpoint.Mode = OperationalMode;
AO.RF.Setpoint.DataType = 'Scalar';
AO.RF.Setpoint.ChannelNames = 'RF{Osc:1}Freq:SP';
AO.RF.Setpoint.HW2PhysicsParams = 1e6;
AO.RF.Setpoint.Physics2HWParams = 1/1e6;
AO.RF.Setpoint.Units = 'Hardware';
AO.RF.Setpoint.HWUnits      = 'MHz';
AO.RF.Setpoint.PhysicsUnits = 'Hz';
AO.RF.Setpoint.Range = [499 501];
AO.RF.Setpoint.Tolerance = eps;


% Tune
AO.TUNE.FamilyName = 'TUNE';
AO.TUNE.MemberOf   = {'TUNE'};
AO.TUNE.DeviceList = [1 1;1 2;1 3];
AO.TUNE.ElementList = [1;2;3];
AO.TUNE.Status = [1;1;0];
AO.TUNE.Position = 0;

AO.TUNE.Monitor.Mode = OperationalMode;
AO.TUNE.Monitor.DataType = 'Scalar';
AO.TUNE.Monitor.ChannelNames =[ 'SR:C16-BI{TuneNA}Freq:Vx-I';'SR:C16-BI{TuneNA}Freq:Vy-I'];
AO.TUNE.Monitor.HW2PhysicsParams = 1;
AO.TUNE.Monitor.Physics2HWParams = 1;
AO.TUNE.Monitor.Units = 'Hardware';
AO.TUNE.Monitor.HWUnits = 'Tune';
AO.TUNE.Monitor.PhysicsUnits = 'Tune';


% DCCT
AO.DCCT.FamilyName = 'DCCT';
AO.DCCT.MemberOf = {'DCCT'; 'Diagnostics'};
AO.DCCT.DeviceList = [1 1];
AO.DCCT.ElementList = 1;
AO.DCCT.Status = 1;
AO.DCCT.Position = 0;

AO.DCCT.Monitor.Mode = OperationalMode;
AO.DCCT.Monitor.DataType = 'Scalar';
AO.DCCT.Monitor.ChannelNames = ['SR:C03-BI{DCCT:1}AveI-I    ';...
                                'SR:C03-BI{DCCT:1}Lifetime-I';...
                                'SR:C03-BI{DCCT:1}I:Total-I '];
AO.DCCT.Monitor.HW2PhysicsParams = 0.001;
AO.DCCT.Monitor.Physics2HWParams = 1000;
AO.DCCT.Monitor.Units = 'Hardware';
AO.DCCT.Monitor.HWUnits = 'mA';
AO.DCCT.Monitor.PhysicsUnits = 'A';


% The operational mode sets the path, filenames, and other important parameters
% Run setoperationalmode after most of the AO is built so that the Units and Mode fields
% can be set in setoperationalmode
setao(AO);
setoperationalmode(ModeNumber);
%AO = getao;

