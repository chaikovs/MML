%return;

% to get data structure from LOCO
global LOCOstruct;

% gradient variation
% since we do not have current to gradient conversion
% we have to convert everything around the working point

%[DK1 DK2 DK3 DK4 DK5 DK6 DK7 DK8 DK9 DK10 DK11 DK12] = LOCOstruct.DK

%A = load('160quad.mat');

DK = LOCOstruct.DK;

%Mode = 'Model';
Mode = 'Online';


% Récupérer AO
AO = getao;


%% Index des Qpôles

% Création des IndeX Q1 à Q10
IndexQ1 = AO.Q1.ElementList;
IndexQ2 = AO.Q2.ElementList + max(IndexQ1);
IndexQ3 = AO.Q3.ElementList + max(IndexQ2);
IndexQ4 = AO.Q4.ElementList + max(IndexQ3);
IndexQ5 = AO.Q5.ElementList + max(IndexQ4);
IndexQ6 = AO.Q6.ElementList + max(IndexQ5);
IndexQ7 = AO.Q7.ElementList + max(IndexQ6);
IndexQ8 = AO.Q8.ElementList + max(IndexQ7);
IndexQ9 = AO.Q9.ElementList + max(IndexQ8);
IndexQ10 = AO.Q10.ElementList + max(IndexQ9);

LastIndex = max(IndexQ10);

% Création de l'Index Q11 si Status = 1
if AO.Q11.Status == 1
    IndexQ11 = AO.Q11.ElementList + LastIndex;
    LastIndex = max(IndexQ11);
end

% Création de l'Index Q12 si Status = 1
if AO.Q12.Status == 1
    IndexQ12 = AO.Q12.ElementList + LastIndex;
    LastIndex = max(IndexQ12);
end

% Création de l'Index QT des QT avec status = 1
sizeQT = size(find(AO.QT.Status),1);
IndexQT = (1:sizeQT) + LastIndex;



%% getsp Q famille
K1i_before=getsp('Q1',Mode,'Physics');
K2i_before=getsp('Q2',Mode,'Physics');
K3i_before=getsp('Q3',Mode,'Physics');
K4i_before=getsp('Q4',Mode,'Physics');
K5i_before=getsp('Q5',Mode,'Physics');
K6i_before=getsp('Q6',Mode,'Physics');
K7i_before=getsp('Q7',Mode,'Physics');
K8i_before=getsp('Q8',Mode,'Physics');
K9i_before=getsp('Q9',Mode,'Physics');
K10i_before=getsp('Q10',Mode,'Physics');
K11i_before=getsp('Q11',Mode,'Physics');
K12i_before=getsp('Q12',Mode,'Physics');

QT0 = getsp('QT', Mode, 'Physics');

tune0=gettune;

%% 160 quad % -1 full correctionveDK
k = -1;
setsp('Q1',k* DK(IndexQ1) + K1i_before, Mode,'Physics');
setsp('Q2',k* DK(IndexQ2) + K2i_before, Mode,'Physics');
setsp('Q3',k* DK(IndexQ3) + K3i_before, Mode,'Physics');
setsp('Q4',k* DK(IndexQ4) + K4i_before, Mode,'Physics');
setsp('Q5',k* DK(IndexQ5) + K5i_before, Mode,'Physics');
setsp('Q6',k* DK(IndexQ6) + K6i_before, Mode,'Physics');
setsp('Q7',k* DK(IndexQ7) + K7i_before, Mode,'Physics');
setsp('Q8',k* DK(IndexQ8) + K8i_before, Mode,'Physics');
setsp('Q9',k* DK(IndexQ9) + K9i_before, Mode,'Physics');
setsp('Q10',k* DK(IndexQ10) + K10i_before, Mode,'Physics');

if AO.Q11.Status == 1
    setsp('Q11',k* DK(IndexQ11) + K11i_before, Mode,'Physics');
end

if AO.Q12.Status == 1
    setsp('Q12',k* DK(IndexQ12) + K12i_before, Mode,'Physics');
end

pause(2)
gettune - tune0


%% skew quad -1 for full correction
k =-1;
%QT0 = 0;
setsp('QT',k* DK(IndexQT) + QT0, Mode,'Physics');
