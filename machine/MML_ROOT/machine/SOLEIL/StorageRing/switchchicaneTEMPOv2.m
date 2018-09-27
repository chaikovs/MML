function Error = switchchicaneTEMPOv2(valTarget, varargin)
% GETBPMRAWDATA - Get turn by turn data for  BPM
%
%  INPUTS
%  1. valTarget - triplet of current values
%
%  Optional input arguments
%  2. Optional display {Default}
%     'Display'     - Plot BPM data X,Z, Sum, Q
%     {'NoDisplay'} - No plotting
%  3. 'NoArchive' - No file archive {Default}
%     'Archive'   - Save a BPM data structure to \<Directory.BPMData>\<DispArchiveFile><Date><Time>.mat
%                   To change the filename, included the filename after the 'Archive', '' to browse
%                   Structure output  is forced
%
%  OUTPUTS
%
%  EXAMPLES

%% Chicane TEMPO
tic;

SimFlag = 1; % simulator , no TANGO interaction
scalingFlag = 0;
OnlineFlag = 0;
SynUnSyncFlag =1;

SwitchFlag = -1; % desactivated

% Flag factory
for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Sim')
        OnlineFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Online')
        OnlineFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoSim')
        SimFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'SwitchON')
        SwitchFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'SwitchOFF')
        SwitchFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'ProfibusSyncOFF')
        SynUnSyncFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'ProfibusSyncON')
        SynUnSyncFlag = 1;
        varargin(i) = [];
    end
end




%%% OPTIMIZED TRIPLET VALUE for 19.6 MeV

% magnetic meas.
valOptimized(1) = 7.63;
valOptimized(2) =-9.42;
valOptimized(3) = 1.79;

% deltaCHI./val'
%
% ans =
%
%    -0.0073
%    -0.0100
%     0.0155
%optimized 11 April 2016
valOptimized(1) = 7.5742;
valOptimized(2) =-9.3261;
valOptimized(3) = 1.8177;

%err = [1.0257    1.0319    1.0466];
%Ajusted with Rmat 26 August 2016
%val =[ 7.9512 -9.8106 1.8873];
%val_max=[8.7426 -10.7002 2.0562]';

%% Hysteresis � ajouter
%% Intelligence : sur descente des aimants ne pas cycler
%% Sur monter repasser par le cyclage

valOptimized = valOptimized';
stepsize = 0.1; % A
imax = 10.9;% A maximum value is 11 A


if length(valTarget) ~= 3
    error('Triplet of current values expected')
end

if any(abs(valTarget) > imax)
    fprintf('Target values #1 %+8.4f A #2 A %+8.4f A #3 %+8.4f A\n', valTarget);
    error('magnet current too large (max: %+8.4f A)', imax)
end

val_starting = getsp('TEMPOC');

if valTarget(2) <= val_starting(2)
    CyclingFlag = 0; % apply direclty stepwise
else
    CyclingFlag = 1; % cycle and apply
end


fprintf('\n\n######################################################### \n')
fprintf('Setting chicane: %s \n', datestr(now))


switch SwitchFlag
    case 0 % chicane switched off
        %%
    case 1 % chicane switch off
        
    otherwise
        switch CyclingFlag
            case 0 % apply directly
                % set to Target value on the upper hysteris branch
                [nstep2reachTarget, stepsizev] = computeStepsize(valTarget, stepsize);
                % set chicane
                valGoal = valTarget;
                setchicane(valGoal, stepsizev, stepsize, nstep2reachTarget, OnlineFlag, SynUnSyncFlag);
                
            case 1 % cycle
                % compute number of step to go to magnetic zero (hysterisis loop)
                % on upper hysteresis branch
                fprintf('Going down the upper hysteresis branch\n')
                valGoal = valOptimized*imax/abs(valOptimized(2));
                [nstep2reachTarget, stepsizev] = computeStepsize(valGoal, stepsize);
                % set chicane
                setchicane(valGoal, stepsizev, stepsize, nstep2reachTarget, OnlineFlag, SynUnSyncFlag);
                
                % set the chicane got go up the lower hysteris branch
                fprintf('Going up the lower hysteresis branch\n')
                valGoal = -valOptimized/30;
                [nstep2reachTarget, stepsizev] = computeStepsize(valGoal, stepsize);
                % set chicane
                setchicane(valGoal, stepsizev, stepsize, nstep2reachTarget, OnlineFlag, SynUnSyncFlag);
                
                % set to Target value on the upper hysteris branch
                fprintf('Going down the upper hysteresis branch\n')
                valGoal = valTarget;
                [nstep2reachTarget, stepsizev] = computeStepsize(valGoal, stepsize);
                % set chicane
                setchicane(valGoal, stepsizev, stepsize, nstep2reachTarget, OnlineFlag, SynUnSyncFlag);
        end
end

Error = getsp('TEMPOC') - valTarget;

fprintf('\nChicane ready: %s \n', datestr(now))
fprintf('Target value #1 %+8.4f A #2 A %+8.4f A #3 %+8.4f A\n', valTarget);
fprintf('Chicane      #1 %+8.4f A #2 A %+8.4f A #3 %+8.4f A\n', getam('TEMPOC'));
fprintf('\n\n######################################################### \n')

%        valGoal = -valOptimized/30;


%CHICANEFLAG = ON;
%nstep = 50;




%% information
switch SwitchFlag
    case SwitchFlag == 1
        msg = 'Chicane praite';
    case SwitchFlag == 0
        msg = 'Chicane arraitai';
    otherwise
        msg = 'Chicane praitteu';
end

if OnlineFlag && iscontrolroom,
    tango_giveInformationMessage(msg)
else
    fprintf('%s\n', msg);
end

toc
end

function [nstep2reachTarget stepsizev] = computeStepsize(valTarget, stepsize)


% compute number of step of stepsize
deltaCurrent = max(abs(getsp('TEMPOC')-valTarget));
nstep2reachTarget = fix(deltaCurrent/stepsize);
if nstep2reachTarget > 0
    stepsizev = -(getsp('TEMPOC')-valTarget)./nstep2reachTarget;
    % normalize to stepsize for the last step
    stepsizev = stepsizev*stepsize/abs(stepsizev(2));
else
    nstep2reachTarget = 0;
    stepsizev = zeros(3,1);
end
end

function setchicane(valTarget, stepsizev, stepsize, nstep, OnlineFlag, SynUnSyncFlag)
%
%INPUTS
% 1. valTarget
% 2. stepsize
% 3. nstep

% maxvalue
if nstep > 0,
    for ik=1:nstep,
        if SynUnSyncFlag && OnlineFlag
            profibus_sync('TEMPOC');
            pause(0.1)
        end
        
        if OnlineFlag
            stepsp('TEMPOC', stepsizev);
            fprintf('iter %d/%d: Current %+8.4f %+8.4f %+8.4f\n', ik, nstep, stepsizev);
        else
            fprintf('iter %d/%d: Current %+8.4f %+8.4f %+8.4f\n', ik, nstep, stepsizev);
        end
        
        if SynUnSyncFlag && OnlineFlag
            pause(1)
            profibus_unsyncall('TEMPOC');
            pause(0.5)
        else
            pause(0.1)
        end
        fprintf('iter %d/%d: Current %+8.4f %+8.4f %+8.4f\n', ik, nstep, getam('TEMPOC'));
        
    end
end

% applying the final requested current

if OnlineFlag
    finalstep = -(getsp('TEMPOC')-valTarget);
else
    finalstep = -((getsp('TEMPOC') + nstep*stepsizev)-valTarget);
end


if max(abs(finalstep)) > stepsize,
    error('Step in current too large %+8.4f > %+8.4f', max(abs(finalstep)), stepsize)
end

if SynUnSyncFlag && OnlineFlag,
    profibus_sync('TEMPOC');
    pause(0.1)
end

if OnlineFlag
    stepsp('TEMPOC', finalstep);
    fprintf('finalstep: Current %+8.4f %+8.4f %+8.4f\n', finalstep);
else
    fprintf('finalstep: Current %+8.4f %+8.4f %+8.4f\n', finalstep);
end

if SynUnSyncFlag && OnlineFlag
    pause(1)
    profibus_unsyncall('TEMPOC');
end

if SynUnSyncFlag && OnlineFlag
    pause(0.1)
else
    pause(0.5)
end

fprintf('Final iter: Current %+8.4f %+8.4f %+8.4f\n', getam('TEMPOC'));

end

function error = checkchicane

sp = getsp('TEMPOC');
am = getam('TEMPOC');

errorVal = 1e-2; %A
if max(sp-am) > errorVal
    warning('Chicane not Ready')
    error = 1;
end



end