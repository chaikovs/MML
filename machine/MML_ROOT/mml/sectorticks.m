function [Sector, Nsectors, Ndevices] = sectorticks(List)
%SECTORTICKS - Returns sector tick number for plotting purpose
%
%  INPUTS
%  1. List - device list
%
%  OUPUTS
%  1. Sector - Sector tick number
%  2. Nsector - Sector number
%  3. Ndevices - Element number in sector

%
% Written by Gregory J. Portmann

Nsectors = max(List(:,1));
Ndevices = max(List(:,2));
Sector = List(:,1) + List(:,2)/Ndevices - 1/Ndevices/2;
