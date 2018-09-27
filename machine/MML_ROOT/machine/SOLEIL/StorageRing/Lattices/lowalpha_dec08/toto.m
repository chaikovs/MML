function run15decembre08

%% DEFINITION DES VALEURS DE COURANT Q ET S

% alphaby10

IQ10 = [  -82.9650  148.9879 -114.2645 -119.1887  201.2604 -175.5612  121.0107   81.7758 -154.9695  217.9303 ];

IS10 = [  24.4811  -99.0941 -229.7569  266.4587 -133.3639  144.5484 -116.8993  132.9682 -218.2526  260.3938];

% alphaby20

IQ20 = [  -84.4498  149.0530 -111.5045 -118.4300  201.4291 -172.7899  107.6342  100.7885 -153.4449  218.3537  ];

IS20 = [  24.4811  -99.0941 -229.7569  266.4587 -133.3639  144.5484 -116.8993  132.9682 -218.2526  260.3938];

% alphaby30

IQ30 = [ -83.8828  149.2383 -113.4019 -118.4225  201.5454 -170.4938  101.9189  108.1872 -153.6022  218.5726 ];

IS30 = [  28.5769  -99.0941 -223.7643  266.4587 -127.4202  140.1915 -116.8993  126.6359 -217.7679  260.3938 ];

% alphaby40

IQ40 = [  -84.5960  149.5563 -113.2614 -118.1814  201.5609 -169.6577   98.8093  112.1658 -153.2026  218.6095 ];

IS40 = [ 31.7265  -99.0941 -223.9622  266.4587 -129.2957  141.8893 -116.8993  125.8615 -214.4666  260.3938 ];

% alphaby50

IQ50 = [ -84.7413  149.6209 -113.2523 -118.0724  201.5714 -169.1231   97.0450  114.3854 -153.0419  218.6456 ];

IS50 = [ 29.3099  -99.0941 -227.1668  266.4587 -133.0502  142.4918 -116.8993  127.7213 -212.5219  260.3938 ];

% alphaby60

IQ60 = [ -84.6258  149.5861 -113.3963 -117.9293  201.5579 -168.7408   95.7023  116.0748 -152.8836  218.6629 ];

IS60 = [ 27.7293  -99.0941 -227.7373  266.4587 -133.5530  142.9736 -116.8993  129.2884 -212.7773  260.3938 ];

QuadMat  = [IQ10; IQ20; IQ30; IQ50; IQ60];
SextuMat = [IS10; IS20; IS30; IS50; IS60];

%% ACTION

% appliquer_Q(IQ10)
% appliquer_S(IS10)

%% Scaling with respect to line iLine
iLine = 2;
Quad_dRoR  = (QuadMat - repmat(QuadMat(iLine,:),size(QuadMat,1),1))./repmat(QuadMat(iLine,:),size(QuadMat,1),1);
Sextu_dRoR = (SextuMat - repmat(SextuMat(iLine,:),size(SextuMat,1),1))./repmat(SextuMat(iLine,:),size(SextuMat,1),1);

%Mode and unit selection
Mode  = 'Online';
%Mode  = 'Model';
Units = 'Hardware';
%Units = 'Physics';

% starting point: this is the reference for the scaling factor.
% All the quads
K1i_before  = getsp('Q1',Mode, Units);
K2i_before  = getsp('Q2',Mode, Units);
K3i_before  = getsp('Q3',Mode, Units);
K4i_before  = getsp('Q4',Mode, Units);
K5i_before  = getsp('Q5',Mode, Units);
K6i_before  = getsp('Q6',Mode, Units);
K7i_before  = getsp('Q7',Mode, Units);
K8i_before  = getsp('Q8',Mode, Units);
K9i_before  = getsp('Q9',Mode, Units);
K10i_before = getsp('Q10',Mode, Units);

% All the sextupoles
S1i_before  = getsp('S1',Mode, Units);
S2i_before  = getsp('S2',Mode, Units);
S3i_before  = getsp('S3',Mode, Units);
S4i_before  = getsp('S4',Mode, Units);
S5i_before  = getsp('S5',Mode, Units);
S6i_before  = getsp('S6',Mode, Units);
S7i_before  = getsp('S7',Mode, Units);
S8i_before  = getsp('S8',Mode, Units);
S9i_before  = getsp('S9',Mode, Units);
S10i_before = getsp('S10',Mode, Units);

%% Selection for the scaling from reference point

k = 1; % scaling factor factor
Quad_DK = Quad_dRoR(5,:);

setsp('Q1' ,(k* Quad_DK(1)  + 1)*K1i_before, Mode, Units);
setsp('Q2' ,(k* Quad_DK(2)  + 1)*K2i_before, Mode, Units);
setsp('Q3' ,(k* Quad_DK(3)  + 1)*K3i_before, Mode, Units);
setsp('Q4' ,(k* Quad_DK(4)  + 1)*K4i_before, Mode, Units);
setsp('Q5' ,(k* Quad_DK(5)  + 1)*K5i_before, Mode, Units);
setsp('Q6' ,(k* Quad_DK(6)  + 1)*K6i_before, Mode, Units);
setsp('Q7' ,(k* Quad_DK(7)  + 1)*K7i_before, Mode, Units);
setsp('Q8' ,(k* Quad_DK(8)  + 1)*K8i_before, Mode, Units);
setsp('Q9' ,(k* Quad_DK(9)  + 1)*K9i_before, Mode, Units);
setsp('Q10',(k* Quad_DK(10) + 1)*K10i_before, Mode, Units);

%%
Sextu_DK = Sextu_dRoR(5,:);
setsp('S1' ,(k* Sextu_DK(1)  + 1)*S1i_before, Mode, Units);
setsp('S2' ,(k* Sextu_DK(2)  + 1)*S2i_before, Mode, Units);
setsp('S3' ,(k* Sextu_DK(3)  + 1)*S3i_before, Mode, Units);
setsp('S4' ,(k* Sextu_DK(4)  + 1)*S4i_before, Mode, Units);
setsp('S5' ,(k* Sextu_DK(5)  + 1)*S5i_before, Mode, Units);
setsp('S6' ,(k* Sextu_DK(6)  + 1)*S6i_before, Mode, Units);
setsp('S7' ,(k* Sextu_DK(7)  + 1)*S7i_before, Mode, Units);
setsp('S8' ,(k* Sextu_DK(8)  + 1)*S8i_before, Mode, Units);
setsp('S9' ,(k* Sextu_DK(9)  + 1)*S9i_before, Mode, Units);
setsp('S10',(k* Sextu_DK(10) + 1)*S10i_before, Mode, Units);


%% function sauvegarde
function IQ_depart = sauvegarde_Q
for iQ = 1:10
    Name = ['Q' num2str(iQ)];
    A = getam((Name),'Online');
    IQ(iQ) = A(1);
end
IQ

IQ_depart = IQ;

function IS_depart = sauvegarde_S
for iS = 1:10
    Name = ['S' num2str(iS)];
    A = getam((Name));
    IS(iS) = A(1);
end

IS_depart = IS;

%% fonction appliquer
function appliquer_Q(IQ)
for iQ = 1:10
    iQ
    Name = ['Q' num2str(iQ)];
    A = IQ(iQ);
    %s = getfamilydata((Name));
    %B = A * ones(length(s.DeviceList),1);
    setsp((Name),A);
end

function appliquer_S(IS)
for iS = 1:10
    iS
    Name = ['S' num2str(iS)];
    A = IS(iS);
    %s = getfamilydata((Name));
    %B = A * ones(length(s.DeviceList),1);
    setsp((Name),A);
end

%% V�rification des tendances de variation en courant
% figure(100);
% 
% hold on ; plot(IQ10./IQ10,'Color',nxtcolor)
% hold on ; plot(IQ20./IQ10,'Color',nxtcolor)
% hold on ; plot(IQ30./IQ10,'Color',nxtcolor)
% hold on ; plot(IQ40./IQ10,'Color',nxtcolor)
% hold on ; plot(IQ50./IQ10,'Color',nxtcolor)
% hold on ; plot(IQ60./IQ10,'Color',nxtcolor)
% 
% figure(200);
% 
% hold on ; plot(IS10./IS10,'Color',nxtcolor)
% hold on ; plot(IS20./IS10,'Color',nxtcolor)
% hold on ; plot(IS30./IS10,'Color',nxtcolor)
% hold on ; plot(IS40./IS10,'Color',nxtcolor)
% hold on ; plot(IS50./IS10,'Color',nxtcolor)
% hold on ; plot(IS60./IS10,'Color',nxtcolor)


