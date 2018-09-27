function [BPMFamilyOutput, BPMDevOutput, DeltaSpos, PhaseAdvance] = quad2bpm(QUADFamily, QUADDev, LocationFlag)
%QUAD2BPM - Return the nearest BPM to the specified quadrupole
%  [BPMFamily, BPMDeviceList, DeltaSpos, PhaseAdvance] = quad2bpm(QUADFamily, QUADDev, LocationFlag)
%
%  INPUTS
%  1. QUADFamily - Quadrupole family (1 family only (row string))
%  2. QUADDeviceList - Quadrupole device list
%  3. LocationFlag - Only search BPM positions that are 'UpStream' or 'DownStream' {Default for transport lines} 
%                    of the quadrupole.  Else no location preference is used {Default for rings}.
%
%  OUTPUTS
%  1. BPMFamily
%  2. BPMDeviceList
%  3. DeltaSpos - Distance from the Quad to the BPM   
%  4. PhaseAdvance - Phase advance from the quadrupole to the BPM (using the model) [radians]
%
%  NOTES
%  1. ThickQuadFlag takes into account quadrupole length since AT give
%  element position at entrance
%  2. At SOLEIL, for Q10, the BPM used is not the closest one but the
%  second closest one. The code is patched for this BBA purpose
%  3. Patch for BPM [13 8] and [13 9] of Nanoscopium
%
%  See Also bpm2quad

%
%  Written by Gregory J. Portmann
%  Modified by Laurent S. Nadolski

ThickQuadFlag = 1; % If thick quad, if 1 s-position is true center, else entrance of element

if nargin < 1
    QUADFamily = '';
end

% default quad family is the first one
if isempty(QUADFamily)
    QUADFamily = findmemberof('QUAD');
    QUADFamily = QUADFamily{1};
end

if nargin < 2
    QUADDev = [];
end

% Default device list is the first one
if isempty(QUADDev)
    QUADDev = family2dev(QUADFamily);
    QUADDev = QUADDev(1,:);
end

if nargin < 3
    LocationFlag = '';
end

% Location Flag: can be Downstream for lines and any for rings
if isempty(LocationFlag)
    if any(strcmpi(getfamilydata('MachineType'), {'Transport','Transportline','Linac'}))
        LocationFlag = 'DownStream';
    else
        LocationFlag = 'Any';
    end
end


% Get all the BPM families
BPMFamilyList = getfamilylist;
[tmp, i] = ismemberof(BPMFamilyList, 'BPM');
% if empty takes first one
if ~isempty(i)
    BPMFamilyList = BPMFamilyList(i,:);
else
    BPMFamilyList = [gethbpmfamily,getvbpmfamily];
end


% Find the BPM next to the Quad
BPMFamilyOutput = [];
for k = 1:size(QUADDev,1)
    % get quadrupole s-positions 
    % (AT gives position at entrance of element)
    if ThickQuadFlag % then add half of the quad length
        QUADspos = getspos(QUADFamily, QUADDev(k,:));
        QUADspos = QUADspos + getleff(QUADFamily, QUADDev(k,:))/2;
    else
        QUADspos = getspos(QUADFamily, QUADDev(k,:));
    end
    
    % if asked, compute phase advance at the middle of the quad
    % The phase is just (phase_entrance+phase_exit)/2
    if nargout >= 4
        ATIndex = family2atindex(QUADFamily, QUADDev(k,:));
        [PhiQx,  PhiQy] = modeltwiss('Phase', 'All');
        i = findrowindex(ATIndex, (1:length(PhiQx))');
        PhiQx = (PhiQx(i) + PhiQx(i+1))/2;
    end

    % search for closest BPM to specified quad
    Del = inf;
    for j = 1:size(BPMFamilyList,1)
        % get BPM s-positions
        Family = deblank(BPMFamilyList(j,:));
        BPMDevList = family2dev(Family);
        BPMspos    = getspos(Family);
        
        if strcmpi(LocationFlag, 'DownStream')
            i = find(abs(BPMspos-QUADspos)==min(abs(BPMspos-QUADspos)) & BPMspos>QUADspos);
        elseif strcmpi(LocationFlag, 'UpStream')
            i = find(abs(BPMspos-QUADspos)==min(abs(BPMspos-QUADspos)) & BPMspos<QUADspos);
        else
            i = find(abs(BPMspos-QUADspos)==min(abs(BPMspos-QUADspos)));
        end

        if strcmpi(QUADFamily, 'Q10')
            % take the second closest BPM
            tmpBPMspos = BPMspos;
            tmpBPMspos(i) = Inf;
            i = find(abs(tmpBPMspos-QUADspos)==min(abs(tmpBPMspos-QUADspos)));
        end              
        
        BPMDev{j} = BPMDevList(i,:);
        
        if abs(BPMspos(i)-QUADspos) < Del
            BPMFamilyMin = Family;
            BPMDevMin = BPMDev{j};        
            Del = abs(BPMspos(i)-QUADspos);
            DelwithSign = BPMspos(i)-QUADspos;
        end
    end
    
    BPMFamilyOutput = strvcat(BPMFamilyOutput, BPMFamilyMin);
    BPMDevOutput(k,:) = BPMDevMin;        
    DeltaSpos(k,1) = DelwithSign;
    
    % If asked
    % Get the phase advance between the BPM and Quad in the model
    if nargout >= 4
        [PhiX,   PhiY]  = modeltwiss('Phase', BPMFamilyOutput, BPMDevOutput(k,:));
        PhaseAdvance = PhiX - PhiQx;
    end
end
