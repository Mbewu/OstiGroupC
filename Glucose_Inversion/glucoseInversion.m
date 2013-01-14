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


% An inversion algorithm for obtaining the glucose matrix from the state
% matrix. It requires no loops or if statements whatsoever and is intended
% to be very fast. 
%
% Run simply >> glucoseInversion

delta = 0.002;
qG = 3e-5;
Gs = 5;
DG = 9.1e-5;
kN = 1e-4;
kT = 1e-3;

% dimension of problem

N = 100;

% We want to solve the problem D gvec = bvec <=> gvec = D \ bvec. 
Dmat = zeros(N^2,N^2); 
Dmat = sparse(Dmat);
bvec = zeros(N^2,1);

%%  constructing the k matrix
%   by forming tensor product of a one-dimensional Gaussian, 
%   then filtering values.

X = linspace(-3,3,N);
Y = exp(-X.*X);
K = Y'*Y;

temp = K;
K(temp>0.5) = kT;
K(temp<=0.5) = kN;

% putting in the vessels
V = rand(N);
K(V>0.5) =  0;

% at this point a plot is instructive:
figure(1);
imagesc(K);
title('K matrix with tumor cells, healthy cells and vessels');
colorbar;

K = reshape(K,N^2,1);

%% constructing columns WITHOUT boundary conditions (these will come later)
 

C = (1:N^2)';

[I J] = IJfromC(C,N); % I, J pairs for all N^2 entries of gvec, bvec. 

% constructing new indices CUp, CDown, CLeft, CRight to account for eqn.
% (8) in the original paper. No boundary conditions or vessels considered 
% here. 

CUp = CfromIJ(adjustBoundary(I-1, N), J, N); % 4 neighbors in normal directions
CDown = CfromIJ(adjustBoundary(I+1, N), J, N);
CLeft = CfromIJ(I,  adjustBoundary(J-1, N), N);
CRight = CfromIJ(I,  adjustBoundary(J+1, N), N);

construct = tic; % timing the D matrix construction

% This bit is very tricky but very fast.
% reusing CfromIJ but this time applying to N^2 dim instead of N dim
% Essentially, going through all rows (C) and filling each row with zeros
% except for a 1 at position CUp, CDown, CLeft or CRight respectively. 

% subdiagonals
Dmat(CfromIJ(C,CUp,N^2)) = 1/delta^2;
Dmat(CfromIJ(C,CDown,N^2)) = 1/delta^2;
Dmat(CfromIJ(C,CLeft,N^2)) = 1/delta^2;
Dmat(CfromIJ(C,CRight,N^2)) = 1/delta^2;

% diagonal
Dmat(CfromIJ(C,C,N^2)) = -4/(delta^2)-K/DG;

% right hand side vectors remain zero, so do nothing here. 

%% Treating vessels.

Cstar = find(K==0); % indices of vessels in K

% the diagonal elements for vessels are overridden. 
Dmat(CfromIJ(Cstar,Cstar,N^2)) = 1;

% right hand side vector
bvec(Cstar) = Gs;

%% above of vessel.
% now treating boundary conditions!

% creating temporary indices for the above neighbor of the vessel. These
% cells obviously can go to all normal directions but DOWN (i.e. to I+1). 
Itemp = adjustBoundary(I(Cstar)-1, N); Jtemp = J(Cstar);
Ctemp = CfromIJ(Itemp, Jtemp, N);

% same as above but DOWN direction is forbidden. 

% subdiagonal elements. 
CUp = CfromIJ(adjustBoundary(Itemp-1, N), Jtemp, N);
CLeft = CfromIJ(Itemp,  adjustBoundary(Jtemp-1, N), N);
CRight = CfromIJ(Itemp,  adjustBoundary(Jtemp+1, N), N);
Dmat(CfromIJ(Cstar,CUp,N^2)) = 1/delta^2;
Dmat(CfromIJ(Cstar,CLeft,N^2)) = 1/delta^2;
Dmat(CfromIJ(Cstar,CRight,N^2)) = 1/delta^2;

% diagonal elements. 
Dmat(CfromIJ(Ctemp,Ctemp,N^2)) =  -(3 + ((delta^2)*K(Ctemp) + qG*delta)/DG)/delta^2;

% right hand side vector
bvec(Ctemp) = -qG * delta * Gs / (DG*delta^2);

%% below of vessel
% Same as above but this time the UP direction is forbidden. 

Itemp = adjustBoundary(I(Cstar)+1, N); Jtemp = J(Cstar);
Ctemp = CfromIJ(Itemp, Jtemp, N);

CDown = CfromIJ(adjustBoundary(Itemp+1, N), Jtemp, N);
CLeft = CfromIJ(Itemp,  adjustBoundary(Jtemp-1, N), N);
CRight = CfromIJ(Itemp,  adjustBoundary(Jtemp+1, N), N);
Dmat(CfromIJ(Cstar,CDown,N^2)) = 1/delta^2;
Dmat(CfromIJ(Cstar,CLeft,N^2)) = 1/delta^2;
Dmat(CfromIJ(Cstar,CRight,N^2)) = 1/delta^2;

Dmat(CfromIJ(Ctemp,Ctemp,N^2)) =  -(3 + ((delta^2)*K(Ctemp) + qG*delta)/DG)/delta^2;
bvec(Ctemp) = -qG * delta * Gs / (DG*delta^2);
 
%% left of vessel
% Same as above but this time the RIGHT direction is forbidden. 
  
 Itemp = I(Cstar); Jtemp = adjustBoundary(J(Cstar)-1, N);
 Ctemp = CfromIJ(Itemp, Jtemp, N);

CUp = CfromIJ(adjustBoundary(Itemp-1, N), Jtemp, N);
CDown = CfromIJ(adjustBoundary(Itemp+1, N), Jtemp, N);
CLeft = CfromIJ(Itemp,  adjustBoundary(Jtemp-1, N), N);
Dmat(CfromIJ(Cstar,CUp,N^2)) = 1/delta^2;
Dmat(CfromIJ(Cstar,CDown,N^2)) = 1/delta^2;
Dmat(CfromIJ(Cstar,CLeft,N^2)) = 1/delta^2;

Dmat(CfromIJ(Ctemp,Ctemp,N^2)) =  -(3 + ((delta^2)*K(Ctemp) + qG*delta)/DG)/delta^2;
bvec(Ctemp) = -qG * delta * Gs / (DG*delta^2);

 %% right of vessel
 % Same as above but this time the LEFT direction is forbidden. 

Itemp = I(Cstar); Jtemp = adjustBoundary(J(Cstar)+1, N);
Ctemp = CfromIJ(Itemp, Jtemp, N);

CUp = CfromIJ(adjustBoundary(Itemp-1, N), Jtemp, N);
CDown = CfromIJ(adjustBoundary(Itemp+1, N), Jtemp, N);
CRight = CfromIJ(Itemp,  adjustBoundary(Jtemp+1, N), N);
Dmat(CfromIJ(Cstar,CUp,N^2)) = 1/delta^2;
Dmat(CfromIJ(Cstar,CDown,N^2)) = 1/delta^2;
Dmat(CfromIJ(Cstar,CRight,N^2)) = 1/delta^2; 

Dmat(CfromIJ(Ctemp,Ctemp,N^2)) =  -(3 + ((delta^2)*K(Ctemp) + qG*delta)/DG)/delta^2;
bvec(Ctemp) = -qG * delta * Gs / (DG*delta^2);

toc(construct) % timing D matrix construction

invert = tic; % timing D matrix inversion
G = Dmat\bvec;
G = reshape(G, N, N);
K = reshape(K, N, N);
toc(construct) % timing D matrix inversion

%% Glucose Concentration

% The glucose concentration is obviously flawed. I just cannot find the
% mistake, checked the numerical values a million times. 
% This is a pity because the algorithm is super fast. 100 x 100 problem
% inverted in less than 3 sec on my i5 Quad Core. 
figure(2);
imagesc(G);
title('Glucose concentration.');
colorbar;