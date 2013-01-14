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

function [ col ] = colAboveOfVessel( C, K, B, N )
%COLCONSTRUCT Constructs C-th column of D matrix WITHOUT the inclusion of
%boundary conditions (for which colCorrect() is responsible). 

qG = 1;
Gs = 1;
delta = 1;
DG = 1;

[I J] = IJfromC(C, N);

Iup     = adjustBoundary(I-1,N);
Jright   = adjustBoundary(J-1,N);
Jleft  = adjustBoundary(J+1,N);

col = zeros(1,N^2);

col(CfromIJ(Iup, J, N)) = 1/(delta^2);
col(CfromIJ(I, Jright, N)) = 1/(delta^2);
col(CfromIJ(I, Jleft, N)) = 1/(delta^2);

col(C) = - 3 -(delta^2 * K(C) - qG*delta)/DG;


end

