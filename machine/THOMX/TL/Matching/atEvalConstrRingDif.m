function Val=atEvalConstrRingDif(R,v,c,d)


%[R]=atApplyVariation(R,v,d);

for var_indx=1:length(v)
oldvalue = ...
                getfield(R{v{var_indx}.PERTURBINDX},...
                v{var_indx}.('FIELD'),...
                v{var_indx}.('IndxInField')...
                );
            
            R{v{var_indx}.PERTURBINDX} = ...
                setfield(R{v{var_indx}.PERTURBINDX},...
                v{var_indx}.('FIELD'),...
                v{var_indx}.('IndxInField'),...
                oldvalue+d(var_indx));
end

CstrVal=feval(c{1}.('Fun'),R) ;
ConstVal=CstrVal.*c{1}.('Weight');
constgoal=c{1}.('Min').*c{1}.('Weight'); % bolean vector
%         
%Val=abs(sign(ConstVal).*ConstVal.^2-sign(constgoal).*constgoal.^2);

Val=(ConstVal-constgoal);

return