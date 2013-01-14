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

function [ radiusOfGyration ] = radiusOfGyration( cancervariable )
%radiusOfGyration Summary of this function goes here
%   Calculates radius of gyration of cancerous region

length = cancervariable.spacestep;
centroid = zeros(2,1);
Jlocal = length^4/12;
count = 0;
for i=1:cancervariable.matrixrownumber
    for j=1:cancervariable.matrixcolnumber
        
        if (cancervariable.statematrix(i,j) == 4 ...
            || cancervariable.statematrix(i,j) == 5 ...
            || cancervariable.statematrix(i,j) == 7 )
            centroid(1) = centroid(1) + (i-1)*length + length/2;
            centroid(2) = centroid(2) + (j-1)*length + length/2;
            
            count = count + 1;
        end
    end
end

centroid = centroid/count;

area = cancervariable.spacestep*cancervariable.spacestep;
%calculate second moment
radius = 0;
for i=1:cancervariable.matrixrownumber
    for j=1:cancervariable.matrixcolnumber
        
        if (cancervariable.statematrix(i,j) == 4 ...
            || cancervariable.statematrix(i,j) == 5 ...
            || cancervariable.statematrix(i,j) == 7)
            radius = radius + Jlocal + area * ((j-1)*cancervariable.spacestep + length/2 - centroid(2))^2;
        end
    end
end

secondMoment = radius;
%secondMomentAdjusted = radius + area*count*centroid(2)^2;
%radius = radius*area;% + count*area*(distance^2);
radiusOfGyration = sqrt(radius/(area*count));







end

