function varargout = WigTablePass(varargin)
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
        %Drift
        NormL = Ldrift./(1+R(5,:));
        R(1,:) = R(1,:) + R(2,:).*NormL;
        R(3,:) = R(3,:) + R(4,:).*NormL;
        R(6,:) = R(6,:) + NormL.*(R(2,:).*R(2,:) + R(4,:).*R(4,:))./(1+R(5,:))/2;
        %kick
        deltaxp = (1/Nslice)*interp2(xtable,ytable,xkicktable,R(1,:),R(3,:),'*linear')./(1+R(5,:)).^2;  %The kick from IDs varies quadratically, not linearly, with energy.
        deltayp = (1/Nslice)*interp2(xtable,ytable,ykicktable,R(1,:),R(3,:),'*linear')./(1+R(5,:)).^2;
        R(2,:) = R(2,:) + deltaxp.*(1+R(5,:));
        R(4,:) = R(4,:) + deltayp.*(1+R(5,:));
        %Drift
        NormL = Ldrift./(1+R(5,:));
        R(1,:) = R(1,:) + R(2,:).*NormL;
        R(3,:) = R(3,:) + R(4,:).*NormL;
        R(6,:) = R(6,:) + NormL.*(R(2,:).*R(2,:) + R(4,:).*R(4,:))./(1+R(5,:))/2;
    end
    varargout{1} = R;

end
