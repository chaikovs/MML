function Res=idOperateBumpBySteps(VectorOfActualPositions, VectorOfTargetPositions, Plane, ToleranceOnBumpPosition_Or_NaN, MaxxStep, MatrixOfBPMsInStraightSection , NumberOfCorrectorsToUseOnEachSide, FitRF, PauseAfterBump, Debug)
%% Sub function to operate bump by steps of MaxxStep

% Inputs : 
%   - VectorOfActualPositions : 1x2 vector containing positions. Usued to
%   print results on screen. NOT used if feedback is activated.
%   - VectorOfTargetPositions : 1x2 vector containing target positions. 
%       Usued to print results on screen. Also used for feedback if activated.
%   - Plane : 'H' or 'V'.
%   - ToleranceOnBumpPosition_Or_NaN : 
%       - NaN => no feedback is done. 
%           Bumps of MaxxStep (or less) are done until
%           VectorOfTargetPositions is reached from VectorOfActualPositions
%       - a number => feedback is performed. VectorOfActualPositions is 
%           not used, but read from BPMs contained in VectorOfBPMsInStraightSection
%           Bumps of MaxxStep (or less) are done until VectorOfTargetPositions is
%           reached.
%   - MaxxStep : Scalar. Maximum displacement to perform at once in order
%       to avoid too large RF steps.
%   - MatrixOfBPMsInStraightSection : 2x2 array 
%       [Cell UpstreamBPM; Cell DownstreamBPM]
%   - NumberOfCorrectorsToUseOnEachSide : Number. Number of Correctors to
%       use before Upstream BPM and after Downstream BPM.
%   - FitRF : 0 or 1. To define if RF is adjusted.
%   - PauseAfterBump : Number. Time in seconds to wait for after bump is
%       performed.
%   - Debug : 0 or 1. if 1, no bump is performed but values of
%       displacements are written on screen.

% Written by F. Briquez 17/02/2013

    Res=0;

    if ~isnan(ToleranceOnBumpPosition_Or_NaN)
        Feedback=1;
    else
        Feedback=0;
    end
    if strcmpi(Plane, 'h')
        BPMFamily='BPMx';
        Coordinate='x';
    elseif strcmpi(Plane, 'v')
        BPMFamily='BPMz';
        Coordinate='z';
    else
        fprintf ('idOperateBumpBySteps : Plane should be ''H'' or ''V''\n')
        return
    end
        
    UpstreamBPM = MatrixOfBPMsInStraightSection(1, :);
    DownstreamBPM = MatrixOfBPMsInStraightSection(2, :);
    UpstreamBPMTangoName=dev2tango(BPMFamily,'Monitor', UpstreamBPM);
    DownstreamBPMTangoName=dev2tango(BPMFamily,'Monitor', DownstreamBPM);
    
    VectorOfCorrectors=[-NumberOfCorrectorsToUseOnEachSide:-1, 1:NumberOfCorrectorsToUseOnEachSide];
    
    if Feedback && Debug
        VectorOfDeltas=VectorOfTargetPositions-VectorOfActualPositions;
        fprintf ('Debug : BUMP from %s = [%g %g] mm to [%g %g] mm (delta of [%g %g]) using feed back\n', Coordinate, VectorOfActualPositions(1), VectorOfActualPositions(2), VectorOfTargetPositions(1), VectorOfTargetPositions(2), VectorOfDeltas(1), VectorOfDeltas(2))
        Res=1;
        return
    else
        Continue=1;
        while (Continue)
            if Feedback
                UpstreamPosition=readattribute(UpstreamBPMTangoName);
                DownstreamPosition=readattribute(DownstreamBPMTangoName);
                VectorOfActualPositions=[UpstreamPosition DownstreamPosition];
            else
                UpstreamPosition=VectorOfActualPositions(1);
                DownstreamPosition=VectorOfActualPositions(2);
            end
            
            UpstreamDeltaToTarget=VectorOfTargetPositions(1)-UpstreamPosition;
            DownstreamDeltaToTarget=VectorOfTargetPositions(2)-DownstreamPosition;
            
            if Feedback
                Continue=abs(UpstreamDeltaToTarget)>ToleranceOnBumpPosition_Or_NaN||abs(DownstreamDeltaToTarget)>ToleranceOnBumpPosition_Or_NaN;
            else
                Continue=UpstreamDeltaToTarget~=0||DownstreamDeltaToTarget~=0;
            end
            if Continue
                if abs(UpstreamDeltaToTarget)>MaxxStep
                    UpstreamDisplacement=sign(UpstreamDeltaToTarget)*abs(MaxxStep);
                else
                    UpstreamDisplacement=UpstreamDeltaToTarget;
                end
                if abs(DownstreamDeltaToTarget)>MaxxStep
                    DownstreamDisplacement=sign(DownstreamDeltaToTarget)*MaxxStep;
                else
                    DownstreamDisplacement=DownstreamDeltaToTarget;
                end
                VectorOfDisplacements=[UpstreamDisplacement DownstreamDisplacement];

%                     Res=OperateBump(VectorOfActualPositions, VectorOfDisplacements, Debug, BPMFamily, VectorOfBPMsInStraightSection , CorrectorFamily, VectorOfCorrectors, FitRF, PauseAfterBump);
                Res=idOperateBump(VectorOfActualPositions, VectorOfDisplacements, Plane, MatrixOfBPMsInStraightSection , VectorOfCorrectors, FitRF, PauseAfterBump, Debug);
                if Res==0
                    return
                end
                if ~Feedback
                    VectorOfActualPositions=VectorOfActualPositions+VectorOfDisplacements;
                end
            end
        end
    end
    return
end
        
%     else % No feedback
%         
%         Continue=1;
%         while (Continue)
%             UpstreamPosition=VectorOfActualPositions(1);
%             DownstreamPosition=VectorOfActualPositions(2);
%             UpstreamDeltaToTarget=VectorOfTargetPositions(1)-UpstreamPosition;
%             DownstreamDeltaToTarget=VectorOfTargetPositions(2)-DownstreamPosition;
%             Continue=UpstreamDeltaToTarget~=0||DownstreamDeltaToTarget~=0;
% 
%             if Continue
%                 if abs(UpstreamDeltaToTarget)>MaxxStep
%                     UpstreamDisplacement=sign(UpstreamDeltaToTarget)*abs(MaxxStep);
%                 else
%                     UpstreamDisplacement=UpstreamDeltaToTarget;
%                 end
%                 if abs(DownstreamDeltaToTarget)>MaxxStep
%                     DownstreamDisplacement=sign(DownstreamDeltaToTarget)*abs(MaxxStep);
%                 else
%                     DownstreamDisplacement=DownstreamDeltaToTarget;
%                 end
%                 VectorOfDisplacements=[UpstreamDisplacement DownstreamDisplacement];
% 
% %                 Res=OperateBump(VectorOfActualPositions, VectorOfDisplacements, Debug, BPMFamily, VectorOfBPMsInStraightSection , CorrectorFamily, VectorOfCorrectors, FitRF, PauseAfterBump);
%                 Res=idOperateBump(VectorOfActualPositions, VectorOfDisplacements, Plane, Debug, MatrixOfBPMsInStraightSection , VectorOfCorrectors, FitRF, PauseAfterBump);
%                 if Res==0
%                     return
%                 end
%                 VectorOfActualPositions=VectorOfActualPositions+VectorOfDisplacements;
%             end
%         end
%         return
%     end


%% Sub function to operate bump
% - allows possibility of debug mode => no bump is done but a message is printed instead
% - possibility of using FitRF or not
% - returns 0 if it doesn't work, another number if succeeded (number of iterations of bumps. Should be 1)
    function Res=idOperateBump(VectorOfPositionsForInformation, VectorOfDisplacements, Plane, MatrixOfBPMsInStraightSection , VectorOfCorrectors, FitRF, PauseAfterBump, Debug)
        Res=0;
        if strcmpi(Plane, 'h')
            BPMFamily='BPMx';
            CorrectorFamily='HCOR';
            Coordinate='x';
        elseif strcmpi(Plane, 'v')
            BPMFamily='BPMz';
            CorrectorFamily='VCOR';
            Coordinate='z';
        else
            fprintf ('idOperateBump : Plane should be ''H'' or ''V''\n')
            return
        end
        
        VectorOfNewPositions=VectorOfPositionsForInformation+VectorOfDisplacements;
        if Debug
           fprintf ('Debug: BUMP from %s = [%g %g] mm to [%g %g] mm (delta of [%g  %g])\n', Coordinate, VectorOfPositionsForInformation(1), VectorOfPositionsForInformation(2), VectorOfNewPositions(1), VectorOfNewPositions(2), VectorOfDisplacements(1), VectorOfDisplacements(2))
           Res=1;
         else
            if FitRF
                 Res = setorbitbump(BPMFamily, MatrixOfBPMsInStraightSection , VectorOfDisplacements, CorrectorFamily, VectorOfCorrectors, 3 , 'FitRF');
            else
                 Res = setorbitbump(BPMFamily, MatrixOfBPMsInStraightSection , VectorOfDisplacements, CorrectorFamily, VectorOfCorrectors);
            end
            Res=Res.NCorrections;
            if Res==0
                fprintf ('Bump FAILED from %s = [%g %g] mm to [%g %g] (delta of [%g %g])!\n', Coordinate, VectorOfPositionsForInformation(1), VectorOfPositionsForInformation(2), VectorOfNewPositions(1), VectorOfNewPositions(2), VectorOfDisplacements(1), VectorOfDisplacements(2))
            else
                fprintf ('Bump succeeded from %s = [%g %g] mm to [%g %g] mm (delta of [%g %g])\n', Coordinate, VectorOfPositionsForInformation(1), VectorOfPositionsForInformation(2), VectorOfNewPositions(1), VectorOfNewPositions(2), VectorOfDisplacements(1), VectorOfDisplacements(2))
            end
        end
        pause(PauseAfterBump);
        return
    end