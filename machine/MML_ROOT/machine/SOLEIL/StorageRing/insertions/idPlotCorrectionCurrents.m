function res=idPlotCorrectionCurrents(FFWDTableStructure, idName, CorrectorName, idMode, FixedParameter, FixedValue, Format, NewPlot)
% Written by F. Briquez 03/11/2010.
% Modified 22/07/2011 => Uses FFWD table structure
%                        Allows 1D plot in addition to 2D plot
% Modified 13/09/2011 => possibility to enter directly FFWDTableStructure
% (then doesnt't take into account idName, CorrectorName and idMode)

% 18/10/2011 : It doesn't work anymore!!!!
    res=-1;

    if (isempty(FFWDTableStructure))
        FFWDTableStructure=idDownloadFFWDTableStructureOfOneCorrectorFromDevice(idName, CorrectorName, idMode);
    end
    Table=FFWDTableStructure.Table;
    vGaps=FFWDTableStructure.vGaps;
    vPhases=FFWDTableStructure.vPhases;
    
    vPhases=transpose(vPhases);
    vGaps=transpose(vGaps);
    
    if (NewPlot~=0)
        figure(NewPlot);
        clf
    end
    hold on;
    
    if isempty(FixedParameter)
        vPhases=transpose(vPhases);
        [vPhases, vGaps]=meshgrid(vPhases, vGaps);
        surfl(vGaps, vPhases, Table);
        LegendText=CorrectorName;

    else
        if strcmpi(FixedParameter, 'phase')&&~isempty(FixedValue)
            PhaseIndex=idAuxFindClosestElemInd(FixedValue, vPhases);
            if (PhaseIndex==-1)
                fprintf ('Wrong FixedValue input\n');
                return
            end
            FixedValue=vPhases(PhaseIndex);
            vX=vGaps;
            vY=Table(:, PhaseIndex);
        elseif strcmpi(FixedParameter, 'gap')&&~isempty(FixedValue)
            GapIndex= idAuxFindClosestElemInd(FixedValue, vGaps);
            if (GapIndex==-1)
               fprintf ('Wrong FixedValue input\n');
               return
            end
            FixedValue=vGaps(GapIndex);
            vX=vPhases;
            vY=Table(GapIndex, :);
        else
            fprintf ('Wrong attributes\n');
            return
        end
        LegendText=[CorrectorName '@ ' FixedParameter '=' num2str(FixedValue) ' mm'];
        if isempty(Format)
            plot (vX, vY)
        else
            plot (vX, vY, Format)
        end
    end
    legend (LegendText);
    hold off
    res=1;
    return
end

