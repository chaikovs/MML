function varargout = wigtablepass(varargin);
% WIGTABLEPASS - The tracking table is described in 
% P. Elleaume, "A new approach to the electron beam dynamics in undulators
% and wigglers", EPAC92.


if nargin == 0
    varargout{1} = {'Length'};
    if nargout > 1
        varargout{2} = {};
    end

elseif nargin == 2
    WigTableStruct = varargin{1};
    xkicktable = WigTableStruct.xkick;
    ykicktable = WigTableStruct.ykick;
    xtable = WigTableStruct.xtable;
    ytable = WigTableStruct.ytable;
    Nslice = WigTableStruct.Nslice;
    R = varargin{2};
    Ldrift = WigTableStruct.Length/(2*Nslice);
    for ns = 1:Nslice
        
        
        aliveindex = find(~any(isnan(R)));
        
        %Drift
        NormL = Ldrift./(1+R(5,aliveindex));
        R(1,aliveindex) = R(1,aliveindex) + R(2,aliveindex).*NormL;
        R(3,aliveindex) = R(3,aliveindex) + R(4,aliveindex).*NormL;
        R(6,aliveindex) = R(6,aliveindex) + NormL.*(R(2,aliveindex).*R(2,aliveindex) + R(4,aliveindex).*R(4,aliveindex))./(1+R(5,aliveindex))/2;
        %kick
        
        deltaxp = (1/Nslice)*interp2(xtable,ytable,xkicktable,R(1,aliveindex),R(3,aliveindex),'*cubic')./(1+R(5,aliveindex)).^2;  %The kick from IDs varies quadratically, not linearly, with energy.
        deltayp = (1/Nslice)*interp2(xtable,ytable,ykicktable,R(1,aliveindex),R(3,aliveindex),'*cubic')./(1+R(5,aliveindex)).^2;
        R(2,aliveindex) = R(2,aliveindex) + deltaxp.*(1+R(5,aliveindex));
        R(4,aliveindex) = R(4,aliveindex) + deltayp.*(1+R(5,aliveindex));
        
        %Drift
        NormL = Ldrift./(1+R(5,aliveindex));
        R(1,aliveindex) = R(1,aliveindex) + R(2,aliveindex).*NormL;
        R(3,aliveindex) = R(3,aliveindex) + R(4,aliveindex).*NormL;
        R(6,aliveindex) = R(6,aliveindex) + NormL.*(R(2,aliveindex).*R(2,aliveindex) + R(4,aliveindex).*R(4,aliveindex))./(1+R(5,aliveindex))/2;
    end
    varargout{1} = R;

end
