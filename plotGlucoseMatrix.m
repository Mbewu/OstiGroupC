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

function [ ] = plotGlucoseMatrix( cancervariable )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%find max that is less than G_S



max = 0;
for i=1:cancervariable.matrixrownumber
    for j = 1:cancervariable.matrixcolnumber
        if(cancervariable.glucosematrix(i,j)>max && cancervariable.glucosematrix(i,j)<cancervariable.G_S)
            max = cancervariable.glucosematrix(i,j);
        end
    end
end

imagesc(cancervariable.glucosematrix);
 if(max ~= 0)
     caxis([min(min(cancervariable.glucosematrix)) max]);
 end
colorbar
title(['Glucose Concentration(mM) at Generation ' num2str(cancervariable.currentgeneration)]);


end

