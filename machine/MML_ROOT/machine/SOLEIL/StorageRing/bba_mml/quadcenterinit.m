function QMS = quadcenterinit(QuadFamily, QuadDev, QuadPlane)
% QMS = quadcenterinit(Family, Device, QuadPlane)
%
% QuadFamily = Quadrupole family
% QuadDev    = Quadrupole device 
% QuadPlane  = Plane (1=horizontal {default}, 2=vertical)
%
% QMS structure contains fields:
% QMS.QuadFamily
% QMS.QuadDev
% QMS.QuadDelta
% QMS.QuadPlane
% QMS.BPMFamily
% QMS.BPMDev
% QMS.BPMDevList
% QMS.CorrFamily
% QMS.CorrDevList             % Often one magnet but bumps or anything else is fine
% QMS.CorrDelta               % Scale factor for each magnet in CorrDevList
% QMS.DataDirectory           % From AD or '.'
% QMS.QuadraticFit = 1;       % 1=quadratic fit, else linear fit
% QMS.OutlierFactor = 1;      % if abs(data - fit) > OutlierFactor * BPMstd, then remove that BPM [mm]
% QMS.NumberOfPoints = 3;
% QMS.ModulationMethod = 'bipolar'
% QMS.CorrectOrbit 'yes' or 'no'
% QMS.CreatedBy
%
%  NOTES
%  1. Quad variations are directly put in this file (not lattice
%  independant)
%  2. Added Flags for nanoscopium
%     Step 1 Center of quadrupole upstream of BPM.8 and downstream of BPM.9
%     Step 2 Center of quadrupole of the triplets. Strategy to be discussed 
%
% See Also quadcenter, quad2bpm

% 
% This file is machine specific
% Written by Laurent S. Nadolski (adapted from ALS)
% July 2011, add nanoscopium Q11 and Q12 families

if nargin < 1
    FamilyList = getfamilylist;
    [tmp,i] = ismemberof(FamilyList,'QUAD');
    if ~isempty(i)
        FamilyList = FamilyList(i,:);
    end
    [i,ok] = listdlg('PromptString', 'Select a quadrupole family:', ...
        'SelectionMode', 'single', ...
        'ListString', FamilyList);
    drawnow;
    if ok == 0
        return
    else
        QuadFamily = deblank(FamilyList(i,:));
    end
end
if ~isfamily(QuadFamily)
    error(sprintf('Quadrupole family %s does not exist.  Make sure the middle layer had been initialized properly.', ...
        QuadFamily));
end
if nargin < 2
    QuadDev = editlist(family2dev(QuadFamily),QuadFamily,zeros(length(family2dev(QuadFamily)),1));
end
if nargin < 3
    %QuadPlane = 1;  % Horizontal default
    ButtonNumber = menu('Which Plane?', 'Horizontal','Vertical','Cancel');  
    drawnow;
    switch ButtonNumber
        case 1
            QuadPlane = 1;
        case 2
            QuadPlane = 2;
        otherwise
            fprintf('   quadcenterinit cancelled');
            return
    end
end

% Initialize the QMS structure
QMS.QuadPlane  = QuadPlane;
QMS.QuadFamily = QuadFamily;
QMS.QuadDev    = QuadDev;
QMS.OutlierFactor = 8;       % BPM Outlier: abs(fit - measured data) > OutlierFactor * std(BPM) 
QMS.CorrectOrbit  = 'no';    % 'yes' or 'no';  % Only do it if the orbit is reasonably close to the offset orbit 
if strcmpi(family2mode('BPMx'), 'Online')
    QMS.ExtraDelay    =  1.5; %s
else
    QMS.ExtraDelay    =  0; %s
end
%QMS.CorrectOrbit = 'Yes';    % 'yes' or 'no';  % Only do it if the orbit is reasonably close to the offset orbit 


% Note: DataDirectory must start with the root of the tree and end with filesep or be '.'
QMSDirectory = getfamilydata('Directory','BBAcurrent');
if isempty(QMSDirectory)
    QMS.DataDirectory = '.';
else
    QMS.DataDirectory = QMSDirectory;
end

if QMS.QuadPlane==1        
    % Horizontal

    CorrMethod = 'MEC';
    %CorrMethod = 'LocalBump';
    %CorrMethod = 'Fixed';

    QMS.BPMFamily  = 'BPMx';
    QMS.CorrFamily = 'HCOR';
    QMS.NumberOfPoints = 5;
    QMS.QuadraticFit = 0;       % 0 = linear fit, else quadratic fit
       
    % Use all BPMs in the minimization
    QMS.BPMDevList = family2dev(QMS.BPMFamily);    

    % Find the BPM closest to the quadrupole
    [TmpFamily, QMS.BPMDev] = quad2bpm(QMS.QuadFamily, QMS.QuadDev);

    % Pick the quadrupole and corrector delta
    QMS.ModulationMethod = 'bipolar';
    
    switch QMS.QuadFamily
        case 'Q1'
            QMS.QuadDelta = 2.0;
            QMS.CorrDelta = 0.1;
        case 'Q2' 
            QMS.QuadDelta = 1.0;
            QMS.CorrDelta = 0.1;
        case 'Q3' 
            QMS.QuadDelta = 2.0;
            QMS.CorrDelta = 0.1;
        case 'Q4' 
            QMS.QuadDelta = 4.0/2;
            QMS.CorrDelta = 0.1;
        case 'Q5' 
            QMS.QuadDelta = 2.0;
            QMS.CorrDelta = 0.1;
        case 'Q6' 
            QMS.QuadDelta = 2.0;
            QMS.CorrDelta = 0.2;
        case 'Q7' 
            QMS.QuadDelta = 3.0/2/2;
            QMS.CorrDelta = 0.1;
        case 'Q8' 
            QMS.QuadDelta = 4.0/2;
            QMS.CorrDelta = 0.1;
        case 'Q9' 
            QMS.QuadDelta = 4.0/2;
            QMS.CorrDelta = 0.1;
        case 'Q10' 
            QMS.QuadDelta = 2.0;
            QMS.CorrDelta = 0.1;
        case 'Q11' % to be tested 
            QMS.QuadDelta = 2.0;
            QMS.CorrDelta = 0.1;
        case 'Q12' % to be tested
            QMS.QuadDelta = 2.0;
            QMS.CorrDelta = 0.1;
        otherwise
            error('Unknown quad');
    end
    
    % Find corrector the bump the beam in the quadrupole
    switch CorrMethod        
        case 'MEC' % Most effective corrector
            % Pick the corrector based on the most effective corrector in the response matrix
            R = getbpmresp('Struct');
            [i, iNotFound] = findrowindex(QMS.BPMDev, R(1,1).Monitor.DeviceList);
            m = R(1,1).Data(i,:);
            [MaxValue, j] = max(abs(m));
            QMS.CorrDevList = R(1,1).Actuator.DeviceList(j,:);
        case 'LocalBump'
            % Local bump corrector method
            [OCS, RF, OCS0] = setorbitbump('BPMx',QMS.BPMDev,[.1],'HCOR',[-2 -1 1 2], 'NoSetSP');
            QMS.CorrDelta = OCS.CM.Data - OCS0.CM.Data;
            QMS.CorrDevList = OCS.CM.DeviceList;
        otherwise
            error('Corrector method unknown.');
    end

elseif QMS.QuadPlane==2
    % Vertical

    CorrMethod = 'MEC';
    %CorrMethod = 'LocalBump';
    %CorrMethod = 'Fixed';

    QMS.BPMFamily  = 'BPMz';
    QMS.CorrFamily = 'VCOR';
    QMS.NumberOfPoints = 5;
    QMS.QuadraticFit = 0;       % 0 = linear fit, else quadratic fit
    QMS.ExtraDelay = 2;

    % Use all BPMs in the minimization
    QMS.BPMDevList = family2dev(QMS.BPMFamily);

    % Find the BPM closest to the quadrupole
    [TmpFamily, QMS.BPMDev] = quad2bpm(QMS.QuadFamily, QMS.QuadDev);

    % Pick the quadrupole and corrector delta
    QMS.ModulationMethod = 'bipolar';
    switch QMS.QuadFamily
        case 'Q1'
            QMS.QuadDelta = 2.0;
            QMS.CorrDelta = 0.3;
        case 'Q2' 
            QMS.QuadDelta = 4.0/4;
            QMS.CorrDelta = 0.2*2;
        case 'Q3' 
            QMS.QuadDelta = 3.0;
            QMS.CorrDelta = 0.3;
        case 'Q4' 
            QMS.QuadDelta = 2.0;
            QMS.CorrDelta = 0.3;
        case 'Q5' 
            QMS.QuadDelta = 5.0/2;
            QMS.CorrDelta = 0.3;
        case 'Q6' 
            QMS.QuadDelta = 3.0;
            QMS.CorrDelta = 0.3;
        case 'Q7' 
            QMS.QuadDelta = 4.0/2;
            QMS.CorrDelta = 0.3*2;
        case 'Q8' 
            QMS.QuadDelta = 4.0;
            QMS.CorrDelta = 0.3;
        case 'Q9' 
            QMS.QuadDelta = 3.0*0+2.0;
            QMS.CorrDelta = 0.3;
        case 'Q10' 
            QMS.QuadDelta = 1.5;
            QMS.CorrDelta = 0.5*2;
        case 'Q11' % to be tested
            QMS.QuadDelta = 1.5;
            QMS.CorrDelta = 0.5*2;
        case 'Q12' % to be tested
            QMS.QuadDelta = 1.5;
            QMS.CorrDelta = 0.5*2;
        otherwise
            error('Unknown quad');
    end

    % Find corrector the bump the beam in the quadrupole
    switch CorrMethod 
        case 'MEC'
            % Pick the corrector based on the most effective corrector in the response matrix
            R = getbpmresp('Struct','Physics');
            [i, iNotFound] = findrowindex(QMS.BPMDev, R(2,2).Monitor.DeviceList);
            m = R(2,2).Data(i,:);
            [MaxValue, j] = max(abs(m));
            QMS.CorrDevList = R(2,2).Actuator.DeviceList(j,:);
        case 'LocalBump'
            % Local bump corrector method
            %[OCS, RF, OCS0] = setorbitbump('BPMz',QMS.BPMDev,[1/4],'HCOR',[-2 -1 1 2], 'NoSetSP');
            %QMS.CorrDelta = OCS.CM.Data - OCS0.CM.Data;
            [OCS, RF, OCS0] = setorbitbump('BPMz',QMS.BPMDev,[1/4],'VCOR',[-2 -1 1 2], 'Display');
            setsp(OCS0.CM);
            QMS.CorrDelta = OCS.CM.Data - OCS0.CM.Data;
            QMS.CorrDevList = OCS.CM.DeviceList;
        otherwise
            error('Corrector method unknown.');
    end

else
    error('QMS.QuadPlane must be 1 or 2');
end


QMS.CreatedBy = 'quadcenterinit';
QMS = orderfields(QMS);
