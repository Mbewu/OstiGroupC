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

N = 10;
Dmat = zeros(N^2,N^2);
K = rand(N^2,1)>0.95; % relatively few vessels
%K = ones(N^2,1);
B = zeros(N^2,1);
for C=1:(N^2)
    Dmat(C, :) = colConstruct(C,K, N);
end
Dmat;


qG = 1;
Gs = 1;
delta = 1;
DG = 1;

% G = Dmat\ones(N^2,1)

for C=1:(N^2)
   if(K(C) == 1)
      [I J] = IJfromC(C,N);

      % left, right, above, below the vessel
      

      
      Itemp = I; Jtemp = adjustBoundary(J-1, N);
      Dmat(CfromIJ(Itemp, Jtemp, N), :) = colLeftOfVessel(CfromIJ(Itemp, Jtemp, N), K, B, N);
      B(CfromIJ(Itemp, Jtemp, N)) = -qG*delta*Gs/DG;
      
      Itemp = I; Jtemp = adjustBoundary(J+1, N);
      Dmat(CfromIJ(Itemp, Jtemp, N), :) = colRightOfVessel(CfromIJ(Itemp, Jtemp, N), K, B, N);
      B(CfromIJ(Itemp, Jtemp, N)) = -qG*delta*Gs/DG;

      Itemp = adjustBoundary(I+1, N); Jtemp = J;
      Dmat(CfromIJ(Itemp, Jtemp, N), :) = colBelowOfVessel(CfromIJ(Itemp, Jtemp, N), K, B, N);
      B(CfromIJ(Itemp, Jtemp, N)) = -qG*delta*Gs/DG;
      
      Itemp = adjustBoundary(I-1, N); Jtemp = J;
      Dmat(CfromIJ(Itemp, Jtemp, N), :) = colAboveOfVessel(CfromIJ(Itemp, Jtemp, N), K, B, N);
      B(CfromIJ(Itemp, Jtemp, N)) = -qG*delta*Gs/DG;
      
      Dmat(C,:) = zeros(N^2,1);
      Dmat(C,C) = 1;
      B(C) = 1;

   end
    
end


% inversion and plot
G = Dmat \ B;
Gmat = zeros(N,N);

for C=1:(N^2)
   [I, J] = IJfromC(C, N);
   Gmat(I,J) = G(C);
end

pcolor(Gmat);
colorbar;