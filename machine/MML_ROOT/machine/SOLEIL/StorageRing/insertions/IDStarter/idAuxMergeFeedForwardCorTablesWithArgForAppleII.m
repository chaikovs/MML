function [mCHE_with_arg, mCVE_with_arg, mCHS_with_arg, mCVS_with_arg] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHE, mCVE, mCHS, mCVS, undParams)
%expected undulator parameters: undParams = {{'phase', vPhase}, {'gap', vGap}}

numUndParam = length(undParams);
if(numUndParam < 2)
	fprintf('Two undulator parameters (gap, phase) are expected. Aborting.\n');
	return;
end

vGap = undParams{1}{2};
vPhase = undParams{2}{2};
if(strcmp(undParams{1}{1}, 'phase') || strcmp(undParams{1}{1}, 'PHASE') || strcmp(undParams{1}{1}, 'Phase'))
	if(strcmp(undParams{2}{1}, 'gap') || strcmp(undParams{2}{1}, 'GAP') || strcmp(undParams{2}{1}, 'Gap'))
        vGap = undParams{2}{2};
        vPhase = undParams{1}{2};
	end
end
mCHE_with_arg = idAuxMergeCorTableWithArg2D(vGap, vPhase, mCHE);
mCVE_with_arg = idAuxMergeCorTableWithArg2D(vGap, vPhase, mCVE);
mCHS_with_arg = idAuxMergeCorTableWithArg2D(vGap, vPhase, mCHS);
mCVS_with_arg = idAuxMergeCorTableWithArg2D(vGap, vPhase, mCVS);
