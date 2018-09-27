function [Quadstruct] = bpm2quad4bba(BPMFamily, BPMDev, LocationFlag)
%BPM2QUAD - Returns the nearest quadrupole to the specified BPM
%  [QUADFamily, QUADDeviceList, DeltaSpos, PhaseAdvance] = bpm2quad(BPMFamily, BPMDeviceList, LocationFlag)
%
%  INPUTS
%  1. BPMFamily - BPM family (1 family only (row string))
%  2. BPMDeviceList - BPM device list
%  3. LocationFlag - Only search quadrupole positions that are 'UpStream' or 'DownStream' {Default for transport lines} 
%                    of the BPM.  Else no location preference is used {Default for rings}.
%
%  OUTPUTS
%  1. QUADFamily
%  2. QUADDeviceList
%  3. DeltaSpos - Distance from the BPM to the Quad  
%
%  See Also quad2bpm

%
%  Written by Laurent S. Nadolski

% List device list of BBA BPM sharing same quad

BPM4Q4Q5DevList=[
    1 4
    4 4
    5 4
    8 4
    9 4
    12 4
    13 4
    16 4
    ];

BPM4Q10DevList =[
   2 4
   2 7
   3 4
   3 7
   6 4
   6 7
   7 4
   7 7
  10 4
  10 7
  11 4
  11 7
  14 4
  14 7
  15 4 
  15 7
  ];

BPM4Q12DevList =[
  13 8
  13 9
  ];

if nargin < 1
    BPMFamily = [];
end
if isempty(BPMFamily)
    BPMFamily = gethbpmfamily;
end

if nargin < 2
    BPMDev = [];
end
if isempty(BPMFamily)
    BPMDev = family2dev(BPMFamily);
    BPMDev = BPMDev(1,:);
end

if nargin < 3
    LocationFlag = '';
end
if isempty(LocationFlag)
    if any(strcmpi(getfamilydata('MachineType'), {'Transport','Transportline','Linac'}))
        LocationFlag = 'UpStream';
    else
        LocationFlag = 'Any';
    end
end


% Get all the quad families
QUADFamilyList = getfamilylist;
[tmp, i] = ismemberof(QUADFamilyList, 'QUAD');
if ~isempty(i)
    QUADFamilyList = QUADFamilyList(i,:);
else
    QUADFamilyList = ['QF','QD'];
end


% Find the Quad next to the BPM

% BPMdev  Quad1Fam Quad1dev Quad2 Quad2dev
% Question: Special field to add to SOLEILinit?
%  Example: BPM.BBA

Idx = dev2elem('BPMx', BPMDev);

varlist = {
    [ 1 2] 'Q1 ' [ 1 1] ''    []
    [ 1 3] 'Q2 ' [ 1 1] 'Q3 ' [1 1]
    [ 1 4] 'Q4 ' [ 1 1] 'Q5 ' [1 1]
    [ 1 5] 'Q5 ' [ 1 2] '' []
    [ 1 6] 'Q4 ' [ 1 2] '' []
    [ 1 7] 'Q6 ' [ 1 1] 'Q7' [1 1]
    [ 2 1] 'Q8 ' [ 1 1] '' []
    [ 2 2] 'Q8 ' [ 2 1] '' []
    [ 2 3] 'Q7 ' [ 2 1] 'Q6' [2 1]
    [ 2 4] 'Q9 ' [ 2 1] '' []
    [ 2 5] 'Q10' [ 2 1] '' []
    [ 2 6] 'Q10' [ 2 2] '' []
    [ 2 7] 'Q9 ' [ 2 2] '' []
    [ 2 8] 'Q6 ' [ 2 2] 'Q7' [2 2]
    [ 3 1] 'Q8 ' [ 2 2] '' []
    [ 3 2] 'Q8 ' [ 3 1] '' []
    [ 3 3] 'Q7 ' [ 3 1] 'Q6' [3 1]
    [ 3 4] 'Q9 ' [ 3 1] '' []
    [ 3 5] 'Q10' [ 3 1] '' []
    [ 3 6] 'Q10' [ 3 2] '' []
    [ 3 7] 'Q9 ' [ 3 2] '' []
    [ 3 8] 'Q6 ' [ 3 2] 'Q7' [3 2]
    [ 4 1] 'Q8 ' [ 3 2] ''    []
    [ 4 2] 'Q8 ' [ 4 1] ''    []
    [ 4 3] 'Q7 ' [ 4 1] 'Q6 ' [4 1]
    [ 4 4] 'Q4 ' [ 4 1] 'Q5 ' [4 1]
    [ 4 5] 'Q5 ' [ 4 2] '' []
    [ 4 6] 'Q4 ' [ 4 2] '' []
    [ 4 7] 'Q3 ' [ 4 1] 'Q2' [4 1]    
    [ 5 1] 'Q1 ' [ 4 1] ''    []
    [ 5 2] 'Q1 ' [ 5 1] ''    []
    [ 5 3] 'Q2 ' [ 5 1] 'Q3 ' [5 1]
    [ 5 4] 'Q4 ' [ 5 1] 'Q5 ' [5 1]
    [ 5 5] 'Q5 ' [ 5 2] '' []
    [ 5 6] 'Q4 ' [ 5 2] '' []
    [ 5 7] 'Q6 ' [ 5 1] 'Q7' [5 1]
    [ 6 1] 'Q8 ' [ 5 1] '' []
    [ 6 2] 'Q8 ' [ 6 1] '' []
    [ 6 3] 'Q7 ' [ 6 1] 'Q6' [6 1]
    [ 6 4] 'Q9 ' [ 6 1] '' []
    [ 6 5] 'Q10' [ 6 1] '' []
    [ 6 6] 'Q10' [ 6 2] '' []
    [ 6 7] 'Q9 ' [ 6 2] '' []
    [ 6 8] 'Q6 ' [ 6 2] 'Q7' [6 2]
    [ 7 1] 'Q8 ' [ 6 2] '' []
    [ 7 2] 'Q8 ' [ 7 1] '' []
    [ 7 3] 'Q7 ' [ 7 1] 'Q6' [7 1]
    [ 7 4] 'Q9 ' [ 7 1] '' []
    [ 7 5] 'Q10' [ 7 1] '' []
    [ 7 6] 'Q10' [ 7 2] '' []
    [ 7 7] 'Q9 ' [ 7 2] '' []
    [ 7 8] 'Q6 ' [ 7 2] 'Q7' [7 2]
    [ 8 1] 'Q8 ' [ 7 2] ''    []
    [ 8 2] 'Q8 ' [ 8 1] ''    []
    [ 8 3] 'Q7 ' [ 8 1] 'Q6 ' [8 1]
    [ 8 4] 'Q4 ' [ 8 1] 'Q5 ' [8 1]
    [ 8 5] 'Q5 ' [ 8 2] '' []
    [ 8 6] 'Q4 ' [ 8 2] '' []
    [ 8 7] 'Q3 ' [ 8 1] 'Q2' [8 1]    
    [ 9 1] 'Q1 ' [ 8 1] ''    []
    [ 9 2] 'Q1 ' [ 9 1] ''    []
    [ 9 3] 'Q2 ' [ 9 1] 'Q3 ' [9 1]
    [ 9 4] 'Q4 ' [ 9 1] 'Q5 ' [9 1]
    [ 9 5] 'Q5 ' [ 9 2] '' []
    [ 9 6] 'Q4 ' [ 9 2] '' []
    [ 9 7] 'Q6 ' [ 9 1] 'Q7' [9 1]
    [10 1] 'Q8 ' [ 9 1] '' []
    [10 2] 'Q8 ' [10 1] '' []
    [10 3] 'Q7 ' [10 1] 'Q6' [10 1]
    [10 4] 'Q9 ' [10 1] '' []
    [10 5] 'Q10' [10 1] '' []
    [10 6] 'Q10' [10 2] '' []
    [10 7] 'Q9 ' [10 2] '' []
    [10 8] 'Q6 ' [10 2] 'Q7' [10 2]
    [11 1] 'Q8 ' [10 2] '' []
    [11 2] 'Q8 ' [11 1] '' []
    [11 3] 'Q7 ' [11 1] 'Q6' [11 1]
    [11 4] 'Q9 ' [11 1] '' []
    [11 5] 'Q10' [11 1] '' []
    [11 6] 'Q10' [11 2] '' []
    [11 7] 'Q9 ' [11 2] '' []
    [11 8] 'Q6 ' [11 2] 'Q7' [11 2]
    [12 1] 'Q8 ' [11 2] ''    []
    [12 2] 'Q8 ' [12 1] ''    []
    [12 3] 'Q7 ' [12 1] 'Q6 ' [12 1]
    [12 4] 'Q4 ' [12 1] 'Q5 ' [12 1]
    [12 5] 'Q5 ' [12 2] '' []
    [12 6] 'Q4 ' [12 2] '' []
    [12 7] 'Q3 ' [12 1] 'Q2' [12 1]    
    [13 1] 'Q1 ' [12 1] ''    []
    [13 8] 'Q11' [13 1] ''    []
    [13 9] 'Q12' [13 1] 'Q11' [13 2]
    [13 2] 'Q1 ' [13 1] ''    []
    [13 3] 'Q2 ' [13 1] 'Q3 ' [13 1]
    [13 4] 'Q4 ' [13 1] 'Q5 ' [13 1]
    [13 5] 'Q5 ' [13 2] '' []
    [13 6] 'Q4 ' [13 2] '' []
    [13 7] 'Q6 ' [13 1] 'Q7' [13 1]
    [14 1] 'Q8 ' [13 1] '' []
    [14 2] 'Q8 ' [14 1] '' []
    [14 3] 'Q7 ' [14 1] 'Q6' [14 1]
    [14 4] 'Q9 ' [14 1] '' []
    [14 5] 'Q10' [14 1] '' []
    [14 6] 'Q10' [14 2] '' []
    [14 7] 'Q9 ' [14 2] '' []
    [14 8] 'Q6 ' [14 2] 'Q7' [14 2]
    [15 1] 'Q8 ' [14 2] '' []
    [15 2] 'Q8 ' [15 1] '' []
    [15 3] 'Q7 ' [15 1] 'Q6' [15 1]
    [15 4] 'Q9 ' [15 1] '' []
    [15 5] 'Q10' [15 1] '' []
    [15 6] 'Q10' [15 2] '' []
    [15 7] 'Q9 ' [15 2] '' []
    [15 8] 'Q6 ' [15 2] 'Q7' [15 2]
    [16 1] 'Q8 ' [15 2] ''    []
    [16 2] 'Q8 ' [16 1] ''    []
    [16 3] 'Q7 ' [16 1] 'Q6 ' [16 1]
    [16 4] 'Q4 ' [16 1] 'Q5 ' [16 1]
    [16 5] 'Q5 ' [16 2] '' []
    [16 6] 'Q4 ' [16 2] '' []
    [16 7] 'Q3 ' [16 1] 'Q2' [16 1]    
    [ 1 1] 'Q1 ' [16 1] ''    []
    };

% rechecher avec findrowindex
% idem dan getbpmbycell
Idx = findrowindex(BPMDev, reshape([varlist{:,1}],[2,length([varlist{:,1}])/2])');
for k = 1:size(Idx,1)
    if isempty(varlist{Idx(k),4})
        fprintf('BPM(%2d,%2d)   %s(%2d,%2d)\n', varlist{Idx(k),1}, varlist{Idx(k),2}, varlist{Idx(k),3});
    else
        fprintf('BPM(%2d,%2d)   %s(%2d,%2d)   %s(%2d,%2d)\n', varlist{Idx(k),1}, varlist{Idx(k),2}, varlist{Idx(k),3}, varlist{Idx(k),4}, varlist{Idx(k),5});
    end  
        Quadstruct(k).Family1 = deblank(varlist{Idx(k),2});
        Quadstruct(k).DevList1    = varlist{Idx(k),3};
        Quadstruct(k).Family2 = deblank(varlist{Idx(k),4});
        Quadstruct(k).DevList2    = varlist{Idx(k),5};
end
 
%function contructOutput(1)