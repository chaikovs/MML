function [Tl,contributionsTL, idx_]=TouschekPiwinskiLifeTime_tracy(dpp, E0, emitx0, kappa, sigp, sigs, Ib,varargin)
% function [Tl,contributionsTL]=TouschekPiwinskiLifeTime_tracy(r,dpp,Ib)
%
% evaluates Touschek Lifetime using Piwinski formula
%
% TouschekPiwinskiLifeTime(latticeATring,momentumaperturecolumnvector,0.002)
%  or
% TouschekPiwinskiLifeTime(
%  latticeATring,
%  momentumaperturecolumnvector,  % column array (size of r or positions)
%  current per bunch in A,                 % scalar
%  positions where to evaluate,  %(default all elements with length>0 )  column array
%  emittancex, %(default atx modemittance(1))   scalar
%  emittancey, %(default 10 pm)		       scalar
%  integration method,  % (default quad, may be: 'integral', 'quad', 'trapz', 'elegantLike', 'Approximate')
%  energy spread,	% scalar
%  bunch length,        % scalar
%			   )
%
%  contributionsTL 1/T contribution at each element
%
%  Tl  Lifetime in seconds 1/Tl=sum(contributionsTL.*L)/sum(L);
%
%
% "The Touscheck Effect in strong focusing storage rings"
% A.Piwinski, DESY 98-179, November 1998
%
% "Touscheck Effect calculation and its applications to a transport line"
%  A.Xiao M. Borland, Proceedings of PAC07, Albuquerque, New Mexico, USA
%
%  EXAMPLES
%  1. % one sided momentum aperture.
%      TL=TouschekPiwinskiLifeTime(RING,dppM,Ib)/3600;
%  2. TL=TouschekPiwinskiLifeTime(RING,[dppM dppP],Ib)/3600;
%      disp('two sided momentum aperture: 1/Ttot=1/2(1/Tup+1/Tdown) :')  
%
%  NOTE: work only on nonzero length elements. So the returned data maybe
%  of smaller size
 
%
%
% created 31-10-2012
% updated 22-01-2013 corrected and compared with elegant


linlat = 'linlat.out';
% Reading Twiss function
% name     spos    alphax  betax   nux   etax   etapx  alphay  betay   nuy   etay   etapy
%         [m]            [m]           [m]                   [m]           [m]
try
    [dummy spos ax bx mux etax etaxp az bz muz etaz etazp] = ...
        textread(linlat,'%s %f %f %f %f %f %f %f %f %f %f %f','headerlines',4);
catch errorRecord
    if strfind(errorRecord.message, 'File not found.');
        fprintf('Input fileName %s not found \n Abort \n',linlat);
    else
        fprintf('Unknown error %s \n', errorRecord.message)
    end
    return;
end


e0 = PhysConstant.electron_volt.value; %Coulomb
r0 = PhysConstant.classical_electron_radius.value; %m %  classical electron radius
spl= PhysConstant.speed_of_light_in_vacuum.value; % speed of ligth

naddvar=length(varargin);

%% overloading AT informations

% index
idx_ = nan;

if naddvar>=1
    positions=varargin{1};
else
    %    positions=1:length(r);    
    % reducing the data
    % positions default= non zero length elements
    positions=spos;
    dL=diff(spos); % get length of element
    dL = [dL;0]; % add last element which is a marker
    idx_ = find(dL>0);
    positions=positions(dL>0);
    
    if size(dpp, 2) == 1       
        try 
            dppinput = dpp(dL>0);
        catch ME
            disp('lattice file and Ma file do not have the same number of lines')
            report = getReport(ME);
            return;
        end
    else
        for ik=1:size(dpp, 2),
            dppinput(:,ik) = dpp(dL>0,ik);
        end
    end
end

emitx=emitx0/(1+kappa);
emity=emitx0.*kappa/(1+kappa);
integrationmethod='quad';
%integrationmethod='elegantLike'; %KO
%integrationmethod='Approximate'; %KO
%integrationmethod='trapz';

    
if naddvar==2
    positions=varargin{1};
    emitx=varargin{2};
    
    disp([' set defaults: ey=ex/2'])
    disp([' integration method is quad,'])
    disp([' energy spread, bunch length from ATX'])
    
elseif naddvar==3
    positions=varargin{1};
    emitx=varargin{2};
    emity=varargin{3};
    disp([' set defaults: '])
    disp([' integration method is quad,'])
    disp([' energy spread, bunch length from ATX'])
    
elseif naddvar==4
    positions=varargin{1};
    emitx=varargin{2};
    emity=varargin{3};
    integrationmethod=varargin{4};
    disp([' set defaults: '])
    disp([' energy spread, bunch length from ATX'])
    
elseif naddvar==5
    positions=varargin{1};
    emitx=varargin{2};
    emity=varargin{3};
    integrationmethod=varargin{4};
    sigp=varargin{5};
    disp(['set defaults: '])
    disp(['bunch length from ATX'])
    
elseif naddvar==6
    positions=varargin{1};
    emitx=varargin{2};
    emity=varargin{3};
    integrationmethod=varargin{4};
    sigp=varargin{5};
    sigs=varargin{6};
    
else
    %     disp(['set defaults: ey=ex/2'])
    %     disp([' integration method is quad,'])
    %     disp([' energy spread, bunch length, x emittance from ATX'])
    %     disp([' evaluation at all points with non zero length'])
    disp('Pinvinski');
end

%%%%%%%%%%


%%%%%%%%%%
% if dpp is a scalar assume constant momentum aperture.
if numel(dpp)==1
    dpp = dpp*ones(size(positions'));
    dppinput = dpp;
end

Tlcol=zeros(1,size(dppinput,2));

for dppcolnum = 1:size(dppinput,2)
    
    dpp = dppinput(:,dppcolnum);
    %dpp = dpp(dL>0);

    
    %Circumference = findspos(r_,length(r_)+1);
    Circumference = spos(end);
    
    Nb = Ib/(spl/Circumference)/e0; %Number of particles per bunch.
    
    relgamma = E0/PhysConstant.electron_mass_energy_equivalent_in_MeV.value*1e-6;
    relbeta=sqrt(1-1./relgamma.^2);
    
    if dppcolnum == 1
        aaa = [ax(dL>0), az(dL>0)];
        bbb = [bx(dL>0), bz(dL>0)];
        ddd = [etax(dL>0), etaxp(dL>0), etazp(dL>0), etazp(dL>0)];
        
        % Twiss parameters and optical function
        bx=bbb(:,1); % betax
        by=bbb(:,2); % betay
        Dx=ddd(:,1); % etax
        Dy=ddd(:,3); % etay
        
        ax=aaa(:,1); % alphax
        ay=aaa(:,2); % alphay
        Dpx=ddd(:,2); %etax'
        Dpy=ddd(:,4); %etay'
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%
    %%%%%%%% From here calculation takes place.
    %%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    sigxb=sqrt(emitx.*bx);
    sigyb=sqrt(emity.*by);
    
    sigx=sqrt(emitx.*bx+sigp.^2.*Dx.^2);
    sigy=sqrt(emity.*by+sigp.^2.*Dy.^2); %%%  was mistaken! it was Dx!!!!!!
    
    
    Dtx=Dx.*ax+Dpx.*bx;%  % alpha=-b'/2
    Dty=Dy.*ay+Dpy.*by;%
    
    sigtx=sqrt(sigx.^2+sigp.^2.*Dtx.^2);
    sigty=sqrt(sigy.^2+sigp.^2.*Dty.^2);
    
    sigtx2=sigx.^2+sigp.^2.*Dtx.^2;
    sigty2=sigy.^2+sigp.^2.*Dty.^2;
    
    sigp2=sigp.^2;
    Dx2=Dx.^2;
    Dy2=Dy.^2;
    Dtx2=Dtx.^2;
    Dty2=Dty.^2;
    sigxb2=sigxb.^2;
    sigyb2=sigyb.^2;
    
    
    sighinv2=1./(sigp2) +(Dx2+Dtx2)./(sigxb2) + (Dy2+Dty2)./(sigyb2);
    
    sigh=sqrt(1./sighinv2);
    
    um=relbeta.^2*dpp.^2;
    
    B1=1./(2.*(relbeta.^2).*(relgamma.^2)).*( (bx.^2./(sigxb.^2)).*(1-(sigh.^2.*Dtx.^2./(sigxb.^2))) + (by.^2./(sigyb.^2)).*(1-(sigh.^2.*Dty.^2./(sigyb.^2))));
    
    B2sq=1./(4.*(relbeta.^4).*(relgamma.^4)).*((bx.^2./(sigxb.^2)).*(1-(sigh.^2.*Dtx.^2./(sigxb.^2)))-(by.^2./(sigyb.^2)).*(1-(sigh.^2.*Dty.^2./(sigyb.^2)))).^2+(sigh.^4.*bx.^2.*by.^2.*Dtx.^2.*Dty.^2)./((relbeta.^4).*(relgamma.^4).*sigxb.^4.*sigyb.^4);
    
    B2=sqrt(B2sq);
    
    em=bx.^2.*sigx.^2./(relbeta.^2.*relgamma.^2.*sigxb.^2.*sigtx2).*um;
    
    val=zeros(size(B1));
    
    km=atan(sqrt(um));
    
    FpiWfact=sqrt(pi.*(B1.^2-B2.^2)).*um;
    
    for ii=1:length(positions),
        
        % choose integration method
        switch integrationmethod
            
            case 'infiniteintegral'
                
                val(ii)= integral(@(u)TLT_IntPiw(u,um(ii),B1(ii),B2(ii)),um(ii),Inf); %,...um(ii)*1e4
                
            case 'integral'
                
                val(ii) = integral(@(k)TLT_IntPiw_k(k,km(ii),B1(ii),B2(ii)),km(ii),pi/2); %,...,'Waypoints',evalpoints um(ii)*1e4
                
            case 'quad'
            
                val(ii)= quad(@(k)TLT_IntPiw_k(k,km(ii),B1(ii),B2(ii)),km(ii),pi/2); %,...,'Waypoints',evalpoints um(ii)*1e4
       
            case 'trapz'
                                
                k=linspace(km(ii),pi/2,10000);
                val(ii)= trapz(k,TLT_IntPiw_k(k,km(ii),B1(ii),B2(ii))); %,...,'Waypoints',evalpoints um(ii)*1e4
                
            case 'elegantLike'
                
                val(ii)=IntegrateLikeElegant(km(ii),B1(ii),B2(ii));
                
            case 'Approximate'
                
                val(ii)=integral(@(e)Cfun(e,em(ii)),em(ii),Inf);
                
            otherwise % use default method quad (backward compatible)
                                
                val(ii)=quad(@(k)TLT_IntPiw_k(k,km(ii),B1(ii),B2(ii)),km(ii),pi/2); %,...,'Waypoints',evalpoints um(ii)*1e4
                
        end
    end
    
    
    
    switch integrationmethod
        case 'infiniteintegral'
            frontfact=(r0.^2.*spl.*Nb)./(8.*pi.*(relgamma.^2).*sigs.*sqrt(...
                (sigx.^2).*(sigy.^2)-sigp.^4.*Dx.^2.*Dy.^2).*um).*FpiWfact;
            
        case {'integral' 'quad' } %'elegantLike'
            
            frontfact=(r0.^2.*spl.*Nb)./(8.*pi.*(relgamma.^2).*sigs.*sqrt(...
                (sigx.^2).*(sigy.^2)-sigp.^4.*Dx.^2.*Dy.^2).*um).*2.*FpiWfact;
        case {'trapz' 'elegantLike'}
            
            frontfact=(r0.^2.*spl.*Nb.*sigh.*bx.*by)./(4.*sqrt(pi).*(relbeta.^2).*(relgamma.^4).*sigxb.^2.*sigyb.^2.*sigs.*sigp);
            
        case 'Approximate'
            
            frontfact=(r0.^2.*spl.*Nb.*bx)./(...
                8.*pi.*(relbeta.^3).*(relgamma.^3).*...
                sigxb.*sigyb.*sigs.*sqrt(sigtx2).*dpp.^2 ...
                ).*em;
            
        otherwise
            
            frontfact=(r0.^2.*spl.*Nb)./(8.*pi.*(relgamma.^2).*sigs.*sqrt(...
                (sigx.^2).*(sigy.^2)-sigp.^4.*Dx.^2.*Dy.^2).*um).*2.*FpiWfact;
            
    end
    contributionsTL=frontfact.*val;
    
    
    %L=getcellstruct(r_,'Length',positions);
    %L = Circumference;
    L__ = dL(dL>0);
    Tlcol(dppcolnum)=1/(1/sum(L__)*sum(contributionsTL.*L__));
    
end

Tl=length(Tlcol)/(sum(1./Tlcol));

return



