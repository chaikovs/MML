function [THERINGout,penalty,dmin]=atmatch(...
    THERING,Variables,Constraints,Tolerance,Calls,algo,verbose)
% this functions modifies the Variables (parameters in THERING) to obtain
% a new THERING with the Constraints verified
%
% Variables   : a cell array of structures of parameters to vary with step size.
% Constraints : a cell array of structures
%
% Variables:   struct('PERTURBINDX',indx,
%                     'PVALUE',stepsize,
%                     'Fam',1,...      % 1=change PERTURBINDX all equal
%                                        0=change PERTURBINDX all different
%                     'LowLim',[],...  % only for lsqnonlin
%                     'HighLim',[],... % only for lsqnonlin
%                     'FIELD',fieldtochange, 
%                     'IndxInField',{{M,N,...}}) 
%
% Variables:   struct('FUN',@(ring,varVAL)functname(ring,varVAL,...),
%                     'PVALUE',stepsize,
%                     'FIELD','macro', 
%                     'StartVALUE',valstart, % size of varVAL  
%                     'IndxInField',{{M,N,...}}) 
% 
% Constraints: struct('Fun',@(ring)functname(ring,...),
%                     'Min',min,
%                     'Max',max,
%                     'Weight',1)
%
% verbose (boolean) to print out end results. 
% 
% Variables are changed within the range min<res<max with a Tolerance Given
% by Tolerance
%
% using least square.
%
%

%
% created : 27-8-2012
% updated : 28-8-2012 constraints 'Fun' may output vectors
% updated : 17-9-2012 output dmin
% updated : 6-11-2012 added simulated annealing (annealing) 
%                     and simplex-simulated-annealing (simpsa)
%                     for global minimum search.
% updated : 21-02-2013 TipicalX included in  
% updated (major) : 11-03-2013 
%                   function named 'atmatch'.
%                   anonimous functions constraints and variable
%                   Variable limits in variable.
%


% get length of variations and higher and lower limits
[~,delta_0,~,Blow,Bhigh]=atApplyVariation(THERING,Variables);


% tolfun is te precisin of the minimum value tolx the accuracy of the
% parameters (delta_0)
% tipicalx is the value of tipical change of a variable 
% (useful if varibles have different ranges)
if isempty(findcells(Variables,'FIELD','macro'))
    tipx=ones(size(delta_0));
    initval=atGetVariableValue(THERING,Variables,0); % get intial variable values
    for ivar=1:length(initval)
        a=initval{ivar};
        if a.Val(1)~=0
            tipx(ivar)=a.Val(1);
        end
    end
    
else
    tipx=ones(size(delta_0)); % the default
end


options = optimset(...
    'Display','iter',...% 
    'MaxFunEvals',Calls*100,...
    'MaxIter',Calls,...
...   'TypicalX',tipx,...
    'TolFun',Tolerance,...);%,...'Algorithm',{''},...
    'TolX',Tolerance);%,...  %                         
     %'Algorithm',{'levenberg-marquardt',1e-6}

   
switch algo
    case 'lsqnonlin'
        % Difference between Target constraints and actual value.
        f = @(d)atEvalConstrRingDif(THERING,Variables,Constraints,d); % vector
    case {'fminsearch','annealing'}
        fs = @(d)atEvalConstrRingDifS(THERING,Variables,Constraints,d); % scalar (sum of squares of f)
    case 'simpsa'
        fs = @(d)atEvalConstrRingDifSimpsa(d,THERING,Variables,Constraints); % scalar (sum of squares of f)
       
    case 'LMFnlsq'
       
        f = @(d)atEvalConstrRingDif(THERING,Variables,Constraints,d); % vector
        
end

[~,penalty]=atGetPenaltyDif(THERING,Constraints);

disp(['f²: ' num2str(penalty.^2)]);
disp(['Sum of f²: ' num2str(sum(penalty.^2))]);

%% Least Squares
if sum(penalty)>Tolerance
    % minimize sum(f_i²)
    switch algo
        case 'lsqnonlin'
            
            dmin=lsqnonlin(f,delta_0,Blow,Bhigh,options);
            % dmin=lsqnonlin(f,delta_0,[],[],options);
        
        case 'fminsearch'
            %options = optimset('OutputFcn', @stopFminsearchAtTOL);
            
            dmin = fminsearch(fs,delta_0,options); % wants  a scalar
        
        case 'annealing'
%          28 Aug 2008 	Joachim Vandekerckhove
%       Yes, for an erratic function like that, you'd need to change
%       the options a bit. I would expect that you need a lot of exploring
%       in the beginning (set InitTemp to 100),
%       slow cooling (set CoolSched to @(T).95*T),
%       and probably you want steps in multiple directions simultaneously
%       (set Generator to @(x)x+randn(1,2)/10).
%       Those setting always find the GO (although after many steps).
            
            
            clear options

            options.('Verbosity')=2;
            options.('Generator')=@(x) (x+(randperm(length(x))==length(x))*randn/100);%@(x) (x+randn(1,length(x))/10);%  this is the default may use also: %@(x) (x+rand(length(x),1));% @(x) (rand(3,1)): Picks a random point in the unit cube; @(x) (ceil([9 5].*rand(2,1))): Picks a point in a 9-by-5
            options.('InitTemp')=1;% 1
            options.('StopTemp')=Tolerance;%1e-8;% % tollerance
            options.('StopVal')=Tolerance*sum(penalty.^2);% if tollerance is 1e-2 the algorithm will stop at 1/100 of the intial value  % -Inf
            options.('CoolSched')=@(T) (.95*T);% 0.8*
            options.('MaxConsRej')=1000;% number of iterations
            options.('MaxTries')=300;%  
            options.('MaxSuccess')=20;%
            
            dmin= anneal(fs,delta_0,options);
            
        case 'simpsa'
           
            dmin=SIMPSA('EvalConstrRingDifSimpsa',delta_0,Blow,Bhigh,[],...
                THERING,Variables,Constraints); 
            
        case 'LMFnlsq'
           disp('Not working yet. Sorry.')
           dmin=delta_0;
            % dmin=LMFnlsq(f,delta_0);
    end
else
    dmin=delta_0;
end
%%

THERINGout=atApplyVariation(THERING,Variables,dmin);
[~,penalty]=atGetPenaltyDif(THERINGout,Constraints);

if verbose
disp('-----oooooo----oooooo----oooooo----')
disp('   ')
disp(['f²: ' num2str(penalty.^2)]);
disp(['Sum of f²: ' num2str(sum(penalty.^2))]);
disp('   ')
disp('-----oooooo----oooooo----oooooo----')
disp('   ')
disp('Final constraints values:')
disp('   ')
disp('Name          lat_indx      before         after           low            high       min dif before    min dif after  ')
atDisplayConstraintsChange(THERING,THERINGout,Constraints);
disp('   ')
disp('-----oooooo----oooooo----oooooo----')
disp('    ')
disp('Final variable values:')
disp('   ')
disp('Name      field      before    after   variation')
atDisplayVaribleChange(THERING,THERINGout,Variables);
disp('   ')
disp('-----oooooo----oooooo----oooooo----')
disp('   ')
end

%atGetVariableValue(THERINGout,Variables,1);
%format long
%disp(dmin')

return