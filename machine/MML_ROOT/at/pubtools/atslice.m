function slicedring = atslice(ring,npts)
%ATSLICE Splits ring elements in short slices for plotting

% 2013-11-13. splitdipole. Fringefield taken into account

totlength=findspos(ring,length(ring)+1);
elmlength=totlength/npts;
slicedring={};
for i=1:length(ring)
    elem=ring{i};
    if isfield(elem,'EntranceAngle')
        newelems=splitdipole(elem,elmlength);
    elseif elem.Length > 0
        nslices=ceil(elem.Length/elmlength);
        elem.Length=elem.Length/nslices;
        elt={elem};
        newelems=elt(ones(nslices,1));
    else
        newelems={elem};
    end
    slicedring=[slicedring;newelems]; %#ok<AGROW>
end

%   Special treatment of dipoles
    function newelems=splitdipole(elem,elmlength)
        nsl=ceil(elem.Length/elmlength);
        ena=elem.EntranceAngle;
        exa=elem.ExitAngle;
        if isfield(elem, 'FringeInt1'),
            FringeInt1 = elem.FringeInt1;
        end
        if isfield(elem, 'FringeInt2'),
            FringeInt2 = elem.FringeInt2;
        end
        if isfield(elem, 'FullGap'),
            FullGap = elem.FullGap;
        end
        elem.Length=elem.Length/nsl;
        elem.BendingAngle=elem.BendingAngle/nsl;
        elem.EntranceAngle=0;
        elem.ExitAngle=0;
        elem.FringeInt1=0;
        elem.FringeInt2=0;
        elem.FullGap=0;
        el={elem};
        newelems=el(ones(nsl,1));
        newelems{1}.EntranceAngle=ena;
        newelems{end}.ExitAngle=exa;
        if isfield(newelems, 'FringeInt1'),
            newelems{1}.FringeInt1=FringeInt1;
        end
        if isfield(newelems, 'FullGap'),
            newelems{1}.FullGap=FullGap;
            newelems{end}.FullGap=FullGap;
        end
        if isfield(newelems, 'FringeInt2'),            
            newelems{end}.FringeInt2=FringeInt2;
        end
    end
end

