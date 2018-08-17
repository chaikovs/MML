% to get data structure from LOCO
global LOCOstruct;
%%
% gradient variation
% since we do not have current to gradient conversion
% we have to convert everything around the working point

%[DK1 DK2 DK3 DK4 DK5 DK6 DK7 DK8 DK9 DK10 DK11 DK12] = LOCOstruct.DK

%A = load('160quad.mat');

DK = LOCOstruct.DK;

Mode = 'Model';
%Mode = 'Online';



AO = getao;


%% Index des Quads

% 
IndexQP1 = AO.QP1.ElementList;
IndexQP2 = AO.QP2.ElementList + max(IndexQP1);
IndexQP3 = AO.QP3.ElementList + max(IndexQP2);
IndexQP4 = AO.QP4.ElementList + max(IndexQP3);
IndexQP31 = AO.QP31.ElementList + max(IndexQP4);
IndexQP41 = AO.QP41.ElementList + max(IndexQP31);


LastIndex = max(IndexQP41);


sizeQT = size(find(AO.QT.Status),1);
IndexQT = (1:sizeQT) + LastIndex;



%% getsp Q family
K1i_before=getsp('QP1',Mode,'Physics');
K2i_before=getsp('QP2',Mode,'Physics');
K3i_before=getsp('QP3',Mode,'Physics');
K4i_before=getsp('QP4',Mode,'Physics');
K5i_before=getsp('QP31',Mode,'Physics');
K6i_before=getsp('QP41',Mode,'Physics');


QT0 = getsp('QT', Mode, 'Physics');

tune0=gettune;


%% 
k = 1;
setsp('QP1',k* DK(IndexQP1) + K1i_before, Mode,'Physics');
setsp('QP2',k* DK(IndexQP2) + K2i_before, Mode,'Physics');
setsp('QP3',k* DK(IndexQP3) + K3i_before, Mode,'Physics');
setsp('QP4',k* DK(IndexQP4) + K4i_before, Mode,'Physics');
setsp('QP31',k* DK(IndexQP31) + K5i_before, Mode,'Physics');
setsp('QP41',k* DK(IndexQP41) + K6i_before, Mode,'Physics');

gettune - tune0


%% skew quad -1 for full correction
k =1;
%QT0 = 0;
%setsp('QT',k* DK(IndexQT) + QT0, Mode,'Physics');
setsp('QT',k* DK(1:8), Mode,'Physics');

