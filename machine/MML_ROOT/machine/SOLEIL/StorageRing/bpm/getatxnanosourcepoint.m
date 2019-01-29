function getatxnanosourcepoint
%% getatxnanosourcepoint --  get source point from TANGO of Nanoscopium et
%% ATX beamlines


% fprintf('\n---------------- REFERENCE 2014 ------------\n');
% fprintf('ANATOMIX SDL13 upstream\n')
% fprintf('H-Position = %+8.3f um H-angle %+6.2f µrad\n', ...
%     -0.507, +0.00);
% fprintf('V-Position = %+8.3f um V-angle %+6.2f µrad \n', ...
%     -18.02, -8.39);
% 
% fprintf('NANOSCOPIUM SDL13 downstream \n')
% fprintf('H-Position = %+8.3f um H-angle %+6.2f µrad\n', ...
%     -13.012, +1.58);
% fprintf('V-Position = %+8.3f um V-angle %+6.2f µrad \n', ...
%     -102.475, -37.51);
% fprintf('---------------------------------------------\n\n');
% 
TimeStamp = datestr(clock) ;
fprintf('\n---------------- MEASURE %s (Reference 2014)--------------\n', TimeStamp);
cprintf('blue', 'ANATOMIX SDL13 upstream\n')
fprintf('H-Position = %+8.3f (%+8.3f) µm H-angle %+6.2f (%+8.3f) µrad\n', ...
    getpv('BeamLine', 'Positionx', [13 1]), -0.507, getpv('BeamLine', 'Anglex', [13 1]), +0.00);
fprintf('V-Position = %+8.3f (%+8.3f) µm V-angle %+6.2f (%+8.3f) µrad \n', ...
    getpv('BeamLine', 'Positionz', [13 1]), -18.02, getpv('BeamLine', 'Anglez', [13 1]), -8.39);

cprintf('blue', 'NANOSCOPIUM SDL13 downstream \n')
fprintf('H-Position = %+8.3f (%+8.3f) µm H-angle %+6.2f (%+8.3f) µrad\n', ...
    getpv('BeamLine', 'Positionx', [13 2]), -13.012, getpv('BeamLine', 'Anglex', [13 2]), +1.58);
fprintf('V-Position = %+8.3f (%+8.3f) µm V-angle %+6.2f (%+8.3f) µrad \n', ...
    getpv('BeamLine', 'Positionz', [13 2]), -102.475, getpv('BeamLine', 'Anglez', [13 2]), -37.51);

