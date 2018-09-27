function [energy, current, lifetime] = getringparams
%GETRINGPARAMS - Fonction reading the storage ring current, beamlifetime, energy
%
% OUTPUTS
%1. energy   = ring energy
%2. current  = current sored int the ring (DCCT)
%3. lifetime = actual ring lifetime
%
% NOTES
%1. TODO
%
% See also getenergy

%
% Written by Laurent S. Nadolski

energy   = getenergy;
current  = getdcct; %mA
lifetime = 10; %getlifetime;  %hours
