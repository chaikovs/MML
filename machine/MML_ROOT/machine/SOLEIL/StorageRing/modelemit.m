function [emit sigmas DP DL] = modelemit
%MODELEMIT - Returns emittance using Ohmi's enveloppe formalism
%
%  INPUTS
%  1. Display/NoDisplay
%
%  OUPUTS
%  1. emit - emittance vector in nm.rad
%  2. sigmas - Sigma dimension around the ring
%  3. DP - energy spread
%  4. DL - bunch length in ps

[Tilt, Eta, Ratio, ENV, DP, DL, emit] = calccoupling('NoDisplay');
sigmas = cat(2,ENV.Sigma);
emit = emit*1e9;
DL = DL/PhysConstant.speed_of_light_in_vacuum.value*1e12;