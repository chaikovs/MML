function [xynew xylu itern] = bpm_linearize(BPMdata, S,  Xoffs, Zoffs)
% INPUTS
% 1. idata = indice de mesure
% 2.  iBPM = indice du BPM
% 3. sens 'H'  ou 'V'
% 4. Filename - Datafile

% 1. xy1 = position reconstruite
% 2 guess = position lue

tol = 1e-3;% convergence tolerance (in normalized button units)
DisplayFlag = 0;
                
maxit = 0;
tic

maxiter = 100; % nombre maximum iterations
ndata = size(BPMdata.Va, 1);
itern = zeros(ndata,1);
xylu = zeros(ndata,2, 1);
xynew = zeros(ndata,2, 1);

% boucle sur le nombre de mesures
for ik=1:ndata,
    [Xlu Zlu abcd] = bpm_normalizedbuttonsignals(BPMdata, ik, S, Xoffs, Zoffs);
        guess = [ Xlu; Zlu] ;
        xy1 = guess;
        
        for it = 1:maxiter,
            last = xy1;
            % abcd = [ Vam ; Vbm; Vcm; Vdm]
            % tmp = position reconstruire
            %fprintf('%d %d %d %d\n', jk, ik, iBPM, it);
            xy1 = buttons_newton_step(xy1, abcd', S);  % method de Newton
            if norm(last - xy1) < tol % test de convergence
                break
            end
        end
        
        maxit = max(it, maxit);
        
        itern(ik) = maxit;
        xylu(ik,:)  = guess; % valeurs lues
        xynew(ik, :) = xy1;   % valeurs reconstruites
end



sens = 'H';        
%%
switch sens
    case 'H'
        plane = 1;
        str = 'H-plane';
    case 'V'
        plane = 2;
        str = 'V-plane';
end

if DisplayFlag
    for k=1:nBPM,
        figure;
        subplot(2,1,1)
        plot(xylu(:,plane, k),'k'); hold on
        plot(xynew(:,plane, k),'g');
        legend('Valeur lue', 'Valeur reconstruite','Location', 'Best')
        grid on;
        title(sprintf('%s: BPM [%2d %2d]', str, deviceList(k,:)))
        xlabel('Data #');
        ylabel('Amplitude (mm)');
        
        subplot(2,1,2)
        plot(xynew(:,plane),xylu(:,plane),'k'); hold on
        grid on
        xlabel('Rebuild data')
        ylabel('Libera Data')
    end
end



end


function newxy = buttons_newton_step(xy, abcd0, S)
% newton step for BPM buttons
% newtons method x(n+1) = x(n) - f(x(n)) / f'(x(n))
% here f(xy) = buttons(xy) / sum(buttons(xy)) - abcd0

% xy point de depart
% abcd0

abcd = buttons(xy, S);

u = abcd ;
v = sum(abcd);

f = u / v - abcd0;
%calcul de Jacobien%plot(xylu(:,1))

d_f = jacobian (xy, abcd, S);

newxy = xy - (f.' / d_f).';

end

function abcd = buttons(xy, S)
% return button signal at x, y
B    = -log(sqrt((xy(1)-S.xm).^2+(xy(2)-S.ym).^2)); % reverse at diamond
abcd =  S.bmat * B.';
end


function [d_f] = jacobian (xy, abcd, S)

% calcul les potentiels pour la position estidata�e
u = abcd;
v = sum(abcd);

% partial derivatives of the nonlinear function B
den = (xy(1)-S.xm).^2 + (xy(2)-S.ym).^2; % common term

% elements de vecteur B ( Gi0 )
Bx  = -(xy(1)-S.xm) ./ den;
By  = -(xy(2)-S.ym) ./ den;

% jacobian matrix of u
d_u = (S.bmat * [Bx; By].').';
% v' = sum(u)' = sum(u')
d_v = sum(d_u, 2);

% (u / v)' = (u'v - v'u) / v^2
d_f = (d_u .* v - d_v * u.') ./ v.^2;
end