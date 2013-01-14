%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% OstiCancerC - Code to reproduce results of "Patel et al. (2001) A 
% Cellular Automaton Model of Early Tumor Growth and Invasion*: The 
% Effects of Native Tissue Vascularity and Increased Anaerobic
% Tumor Metabolism" simulating cancer growth using a hybrid cellular 
% automaton model.
%
% Copyright (C) 2013  Jackie Ang, Jonny Brook-Bartlett, Alexander Erlich,
% James Mbewu and Robert Ross.
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ growthRate ] = calculateGrowthRate( cancervariable )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

generations = cancervariable.noofogenerations-9:cancervariable.noofogenerations;
generations = generations';
radiusOfGyration = cancervariable.radiusOfGyration(generations);


p = polyfit(generations,radiusOfGyration,1);

yfit =  p(1) * generations + p(2);
yresid = radiusOfGyration - yfit;
SSresid = sum(yresid.^2);
SStotal = (length(radiusOfGyration)-1) * var(radiusOfGyration);
growthRate = p(1);
growthRateError = 1 - SSresid/SStotal;


end

