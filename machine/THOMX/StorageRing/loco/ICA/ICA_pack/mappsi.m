function  newpsi = mappsi(psi)
%newpsi = mappsi(psi)
%	map psi to newpsi, such that newpsi start with zero and increases properly
%	psi 	is result of atan2, subject to any shift of 2PI
%	newpsi, the resulting adjusted psi, newpsi(1) = 0., newpsi(i) > newpsi(i-1)
%	Assumptions: phase advance between two adjacent locations is less than 2*pi/3
%
tmp = diff(psi); 
n = length(find(tmp>0));
if n < length(psi)/3.	%assume phase jumps over 2*pi for less than 1/3 locations
	psi = -psi;   % make sure psi increases
end

kadd = 0;
newpsi = zeros(size(psi));
newpsi(1) = psi(1);
for i=2:length(psi)
	if psi(i) < psi(i-1) - pi/3.
		kadd = kadd + 1;
	end
	newpsi(i) = psi(i) + kadd*2.*pi;
end

newpsi = newpsi - psi(1);
