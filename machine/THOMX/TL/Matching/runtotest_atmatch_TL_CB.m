% macro match lattice beta functions and dispersion using quadrupoles.


%%  VARIABLES
listVariab={'QP1L','QP2L','QP3L','QP4L','QP5L','QP6L','QP7L'}

for vi=1:length(listVariab)
    Variab{vi}=struct('PERTURBINDX',[findcells(THERING,'FamName',listVariab{vi})],...
    'PVALUE',0,...
    'Fam',1,...
    'LowLim',[],...
    'HighLim',[],...
    'FIELD','PolynomB',...
    'IndxInField',{{1,2}}); % the double braces {{}} are necessary in orded 
end                         % to avoid the creation of multiple structures.

%%  CONSTRAINTS
Crt_list={'betx' 'bety' 'alfx' 'alfy' 'dispx','disppx'};
loc_list={findcells(THERING,'FamName','FIN') findcells(THERING,'FamName','FIN') findcells(THERING,'FamName','FIN') findcells(THERING,'FamName','FIN')  findcells(THERING,'FamName','SD32L') findcells(THERING,'FamName','SD32L')};
Valuemin_list = {3.6679 1.8369 0.0840 -0.1309 0.0 0.0};
Valuemax_list = Valuemin_list
Weight_list={1 1 1 1 1 1}


%% MATCHING

%% Param�tres MATCHING %%%%%%%%%%%%%
dpp=0.00;
Tolerance=10^-25;
calls=1000;
algo='lsqnonlin' %%%Possible 'fminsearch' (marche pas encore bien), 'lsqnonlin'
Print=1;% 0 to print, 1 to hide
%%%%%%%%%%%%%%%

clear c;

c{1}.Fun=@(r)atfuntofitoptics(r,dpp,Crt_list,loc_list,Valuemin_list,Valuemax_list,Weight_list);
c{1}.Min=cell2mat(Valuemin_list);
c{1}.Max=c{1}.Min;
c{1}.Weight=cell2mat(Weight_list);

options = optimset(...
    'Display','iter',...% 
    'MaxFunEvals',calls*100,...
    'MaxIter',calls,...
    'TolFun',Tolerance,...);%,...'Algorithm',{''},...
    'TolX',Tolerance,...;%,...  %                         
    'Algorithm',{'levenberg-marquardt',1e-6});

 f = @(d)atEvalConstrRingDif(THERING,Variab,c,d);
% 
% penalty=feval(c{1}.Fun,THERING);
% disp(['f²: ' num2str(penalty.^2)]);
% disp(['Sum of f²: ' num2str(sum(penalty.^2))]);

%% Least Squares
    delta_0 = zeros(size(listVariab)); %point de d�part moindre carr�
    Blow=[];
    Bhigh=[];
   % [~,delta_0,~,Blow,Bhigh]=atApplyVariation(THERING,Variab);

    dmin = lsqnonlin(f,delta_0,Blow,Bhigh,options); %% Blow, Bhigh matrice vide comme stipul� dans le help de lsqnonlin

%% Resultats

delta_0=dmin;
THERINGout=THERING;
for i=1:length(Variab)
oldvalue = ...
                getfield(THERING{Variab{i}.PERTURBINDX},...
                Variab{i}.('FIELD'),...
                Variab{i}.('IndxInField')...
                );
            
            
            THERINGout{Variab{i}.PERTURBINDX} = ...
                setfield(THERINGout{Variab{i}.PERTURBINDX},...
                Variab{i}.('FIELD'),...
                Variab{i}.('IndxInField'),...
                oldvalue+dmin(i));
end


%    penalty=feval(c{1}.Fun,THERINGout);
%% Print modif

for i=1:length(Variab)
varname(i)=getcellstruct(THERING,'FamName',Variab{i}.PERTURBINDX);
    
    valueold(i) = ...
        getfield(THERING{Variab{i}.PERTURBINDX},...
        Variab{i}.('FIELD'),...
        Variab{i}.('IndxInField')...
        );
    
    valueoptim(i) = ...
        getfield(THERINGout{Variab{i}.PERTURBINDX},...
        Variab{i}.('FIELD'),...
        Variab{i}.('IndxInField')...
        );
   
 end   
    disp([varname '    ' num2str(valueold) '    ' num2str(valueoptim) ]);

if Print==1 
disp('----------------------------------           ----')
disp(['Constraint                     ', Crt_list])
disp(['Initial constraints values:    ',num2str(feval(c{1}.Fun,THERING))])
disp(['Final constraints values:      ',num2str(feval(c{1}.Fun,THERINGout))])
disp(['goal constraints values:       ',Valuemin_list])
%disp('   ')
disp('Final constraints values:')
%disp('   ')
c{1}.Min
disp('--------------------------------------')
disp('Final variable values:')
disp(['QP name                 ',varname])
disp(['field before matching   ',num2str(valueold)])
disp(['field after matching    ',num2str(valueoptim)])
disp('--------------------------------------')
end

%% Plot des fonction optique avant et apr�s matching %%%%%%
figure;
TD1=twissline(THERING,0,twissin,1:length(THERING)+1,'chrom');
S1=cat(1,TD1.SPos);
BETA=cat(1,TD1.beta);
%plot(S1,BETA);
ALPHA=cat(1,TD1.alpha);
plot(S1,ALPHA);
figure;
[lindata]=twissline(THERINGout,0.0,twissin,1:length(THERING)+1,'chrom'); %#ok<NASGU,ASGLU>
beta=cat(1,lindata.beta);
s=cat(1,lindata.SPos);
%plot(s,beta);
alpha=cat(1,lindata.alpha);
plot(s,alpha);

%% Modifcation des Qpoles de la ligne de transfert 


