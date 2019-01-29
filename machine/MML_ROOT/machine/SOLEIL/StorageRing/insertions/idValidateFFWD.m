function res=idValidateFFWD(idName)
%% Written by F. Briquez
% 28/03/2016
% moves gap and phase to display in a trend (to be created before)
    % Gap max
    % Phase zero
    % FB ON
    % FB OFF
    % SaveOrbit sur BPM Manager
    % Gap min
    % phase min
    % phase max
    % phase min
    % phase max
    % phase 0
    % Gap max
%%
    Tolerance=0.001;
    PauseBetweenSteps=2;
    NbPhaseIterations=2;

    res=-1;
    DirectoryName = getfamilydata('Directory',idName);
    if isempty(DirectoryName)
        fprintf ('Wrong ID\n')
        return
    end
    [DServName, StandByStr, CorCurAttr] = idGetUndDServer(idName);

    st=tango_read_attribute2(DServName, 'minValueGap');
    MinGap=st.value(1);
    st=tango_read_attribute2(DServName, 'maxValueGap');
    MaxGap=st.value(1);
    st=tango_read_attribute2(DServName, 'minValuePhase');
    MinPhase=st.value(1);
    st=tango_read_attribute2(DServName, 'maxValuePhase');
    MaxPhase=st.value(1);
    st=tango_read_attribute2(DServName, 'hasUserControlledPhase');
    ControlPhase=st.value(1);
    
    % Open gap
    fprintf ('Opening gap...\n')
    res=idSetUndParam(idName, 'gap', MaxGap, Tolerance);
    if (res~=0)
        fprintf ('Could not open gap\n')
        return
    end

    % Go to phase zero
    fprintf ('Setting phase zero...\n')
    res=idSetUndParam(idName, 'phase', 0, Tolerance);
    if (res~=0)
        fprintf ('Could not reach phase zero\n')
        return
    end
    
    % Correct orbit : to be done by the user
    Continue=questdlg('Please manually correct orbit and click ''Yes'' when it is done', 'Orbit correction', 'Yes', 'Cancel', 'Yes');
    
    if strcmpi(Continue, 'Cancel')
        return
    end
    
    % Save orbit in BPM Manager
    res=tango_command_inout('ans/dg/bpm-manager', 'SaveCurrentOrbit');
    if (res~=0)
        fprintf ('Could not save current orbit\n')
        return
    end
    pause(PauseBetweenSteps);
    
    % Close gap
    fprintf ('Closing gap...\n')
    res=idSetUndParam(idName, 'gap', MinGap, Tolerance);
    if (res~=0)
        fprintf ('Could not close gap\n')
        return
    end
    pause(PauseBetweenSteps);

    if (ControlPhase)
        for phaseIteration=1:NbPhaseIterations
            % Go to min phase
            fprintf ('Setting phase %g (iteration n°%g/%g)...\n', MinPhase, phaseIteration, NbPhaseIterations)
            res=idSetUndParam(idName, 'phase', MinPhase, Tolerance);
            if (res~=0)
                fprintf ('Could not reach min phase (iteration n°%g/%g)\n', phaseIteration, NbPhaseIterations)
                return
            end
            pause(PauseBetweenSteps);

            % Go to max phase
            fprintf ('Setting phase %g (iteration n°%g/%g)...\n', MaxPhase, phaseIteration, NbPhaseIterations)
            res=idSetUndParam(idName, 'phase', MaxPhase, Tolerance);
            if (res~=0)
                fprintf ('Could not reach max phase (iteration n°%g/%g)\n', phaseIteration, NbPhaseIterations)
                return
            end
            pause(PauseBetweenSteps);
        end
        
        % Go to phase zero
        fprintf ('Setting phase zero...\n')
        res=idSetUndParam(idName, 'phase', 0, Tolerance);
        if (res~=0)
            fprintf ('Could not reach phase zero\n')
            return
        end
    
    end
    
    % Open gap
    fprintf ('Opening gap...\n')
    res=idSetUndParam(idName, 'gap', MaxGap, Tolerance);
    if (res~=0)
        fprintf ('Could not open gap\n')
        return
    end
    fprintf ('Finished\n')
    res=0;
    return


