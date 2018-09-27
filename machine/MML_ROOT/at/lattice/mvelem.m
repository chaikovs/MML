function mvelem(ELEMPOS, DIST)
%MVELEM(ELEMPOS, DIST) moves an element  located at ELEMPOS in THERING
% surrounded by two DRIFT spaces
%
%  0   < DIST  < LD move downstream
% -LU  < DIST  < 0  move upstream
%  where LU and LD - lenths of
%  upstream and downstrem drift drifts BEFORE!!! the move
%
% Number of elements in THERING and total length remain the same
%
% See also: SPLITDRIFT, MERGEDRIFT

%
% Modifications Laurent S. Nadolski
% Add Vectorial form

global THERING

nb = length(ELEMPOS); % number of elements

if nb == 1
    L0 = THERING{ELEMPOS-1}.Length + THERING{ELEMPOS}.Length + THERING{ELEMPOS+1}.Length;
    if DIST > THERING{ELEMPOS+1}.Length
        error('Cannot move downstream more than the length of downstream drift');
    elseif -DIST > THERING{ELEMPOS-1}.Length
        error('Cannot move upstream more than the length of upstream drift');
    else
        THERING{ELEMPOS+1}.Length = THERING{ELEMPOS+1}.Length - DIST;
        THERING{ELEMPOS-1}.Length = THERING{ELEMPOS-1}.Length + DIST;
    end
elseif nb > 1
    for ik = 1:nb
        L0 = THERING{ELEMPOS(ik)-1}.Length + THERING{ELEMPOS(ik)}.Length + THERING{ELEMPOS(ik)+1}.Length;
        if DIST(ik) > THERING{ELEMPOS(ik)+1}.Length
            error('Cannot move downstream more than the length of downstream drift');
        elseif -DIST(ik) > THERING{ELEMPOS(ik)-1}.Length
            error('Cannot move upstream more than the length of upstream drift');
        else
            THERING{ELEMPOS(ik)+1}.Length = THERING{ELEMPOS(ik)+1}.Length - DIST(ik);
            THERING{ELEMPOS(ik)-1}.Length = THERING{ELEMPOS(ik)-1}.Length + DIST(ik);
        end
    end
else % Error
    error('Wrong arguments');
end