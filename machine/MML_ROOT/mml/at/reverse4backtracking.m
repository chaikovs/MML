function invertedLattice = reverse4backtracking(lattice)
%  REVERSE4BACKTRACKING - Invert a lattice for backtracking
%
%  INPUTS
%  1. lattice : structure to backtracked
%
%  OUPUTS
%  1. invertedLattice : inverted lattice
%
%  NOTES
%  1. Inversion of time for elements with a none zero length
%     Inverse bn and an polynomes for zero lenth elements
%  2. For backtracking with large angle, be aware that the standard AT
%  model may not be suitable. Consider tracking directly in the field map
%  of a magnet
%  3. For dipole works only is both FringeBendEntrance and FringeBendExit
%  are set to 2
%
%  See also reverse

%
%% Written by Laurent S. Nadolski

invertedLattice = reverse(lattice);
for k=1:length(invertedLattice)
    if isfield(invertedLattice{k},'Length')
        %inverse time equivalent to negative length for symmetric
        %integrators
        invertedLattice{k}.Length = -invertedLattice{k}.Length;
        if invertedLattice{k}.Length == 0
            % Multipole as thin lenses
            if isfield(invertedLattice{k},'PolynomA')
                invertedLattice{k}.PolynomB = invertedLattice{k}.PolynomB*-1;
                invertedLattice{k}.PolynomA = invertedLattice{k}.PolynomA*-1;
                if isfield(invertedLattice{k},'K')
                    invertedLattice{k}.K = -invertedLattice{k}.K;
                end
            end
        end
                
        if ~isfield(invertedLattice{k},'Class')
            invertedLattice{k}.Class = atguessclass(invertedLattice{k}, 'UseClass');
        end
        
         if isfield(invertedLattice{k},'BendingAngle')      
            % Inverse main field
            invertedLattice{k}.BendingAngle = -invertedLattice{k}.BendingAngle;
         end
        
        if strcmpi(invertedLattice{k}.Class, 'Bend')
            
            if isfield(invertedLattice{k},'EntranceAngle')  & ~isfield(invertedLattice{k},'ExitAngle')
                invertedLattice{k}.ExitAngle = 0;
            end
            
            if ~isfield(invertedLattice{k},'EntranceAngle')  & isfield(invertedLattice{k},'ExitAngle')
                invertedLattice{k}.EntranceAngle = 0;
            end
            
            if isfield(invertedLattice{k},'EntranceAngle')
                tmp = invertedLattice{k}.EntranceAngle;
                invertedLattice{k}.EntranceAngle = -invertedLattice{k}.ExitAngle;
                invertedLattice{k}.ExitAngle = -tmp;
            end

            
        end
        
        % dipole case
        if isfield(invertedLattice{k},'FullGap')
            % swap entrance and exit angle
            % Inverse flatticee field
            invertedLattice{k}.FullGap = -invertedLattice{k}.FullGap;
        end
        
        if isfield(invertedLattice{k},'FringeQuadEntrance')  & ~isfield(invertedLattice{k},'FringeQuadExit')
            invertedLattice{k}.FringeQuadExit = 0;
        end
        if ~isfield(invertedLattice{k},'FringeQuadEntrance')  & isfield(invertedLattice{k},'FringeQuadExit')
            invertedLattice{k}.FringeQuadEntrance = 0;
        end
        if isfield(invertedLattice{k},'FringeQuadEntrance')
            tmp = invertedLattice{k}.FringeQuadEntrance;
            invertedLattice{k}.FringeQuadEntrance = -invertedLattice{k}.FringeQuadExit;
            invertedLattice{k}.FringeQuadExit = -tmp;
        end
    end
       
end
