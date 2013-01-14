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

function [ G ] = findGlucoseMatrix( cancervariable )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here



Delta = cancervariable.spacestep; %(centimetres)
D_G = cancervariable.D_G; %(centimetres^2 / s)
kr = cancervariable.kr;
q_G = cancervariable.q_G; %(centimetres / s)
G_S = cancervariable.G_S; % (mM)

N = cancervariable.matrixrownumber;
M = cancervariable.matrixcolnumber;

noVessels = sum(sum(cancervariable.statematrix==1));

G = ones(N,M);
Gvec = zeros(N*M-noVessels,1);

systemMatrix = zeros(N*M-noVessels,N*M-noVessels);
rhs = zeros(N*M-noVessels,1);

%set up matrix id to vector id map
%if vessel then id = 0, otherwise numbered rowwise
m2v = zeros(N,M);
v2m = zeros(N*M-noVessels,2);
count = 1;
for i=1:N
    for j=1:M
        if (cancervariable.statematrix(i,j) == 1)
            m2v(i,j) = 0;
        else
            m2v(i,j) = count;
            v2m(count,:) = [i j];
            count = count + 1;
        end
    end
end

Delta2 = Delta*Delta; %delta squared to be reused
for i = 1:N
    for j = 1:M
        k = m2v(i,j); %row to be filled in
        % vessel above, to the right, below and to the left
        if(m2v(i,j) == 0)
          %do nothing except give boundary value
          G(i,j) = G_S;
        elseif(m2v(coord(i-1,N),coord(j,M)) == 0)
            kij = kr(cancervariable.statematrix(i,j));
            systemMatrix(k,m2v(coord(i+1,N),coord(j,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j+1,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j-1,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j,M))) = - 3 - (kij*Delta2+q_G*Delta)/D_G;
        
            rhs(k) = - q_G*Delta*G_S/D_G;
        elseif(m2v(coord(i,N),coord(j+1,M)) == 0)
            kij = kr(cancervariable.statematrix(i,j));
            systemMatrix(k,m2v(coord(i+1,N),coord(j,M))) = 1;
            systemMatrix(k,m2v(coord(i-1,N),coord(j,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j-1,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j,M))) = - 3 - (kij*Delta2+q_G*Delta)/D_G;
        
            
            rhs(k) = - q_G*Delta*G_S/D_G;
        elseif(m2v(coord(i+1,N),coord(j,M)) == 0)
            kij = kr(cancervariable.statematrix(i,j));
            systemMatrix(k,m2v(coord(i-1,N),coord(j,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j+1,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j-1,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j,M))) = - 3 - (kij*Delta2+q_G*Delta)/D_G;
        
            rhs(k) = - q_G*Delta*G_S/D_G;
        elseif(m2v(coord(i,N),coord(j-1,M)) == 0)
            kij = kr(cancervariable.statematrix(i,j));
            systemMatrix(k,m2v(coord(i+1,N),coord(j,M))) = 1;
            systemMatrix(k,m2v(coord(i-1,N),coord(j,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j+1,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j,M))) = - 3 - (kij*Delta2+q_G*Delta)/D_G;
        
            rhs(k) = - q_G*Delta*G_S/D_G;
        else
            kij = kr(cancervariable.statematrix(i,j));        
            systemMatrix(k,m2v(coord(i+1,N),coord(j,M))) = 1;
            systemMatrix(k,m2v(coord(i-1,N),coord(j,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j+1,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j-1,M))) = 1;
            systemMatrix(k,m2v(coord(i,N),coord(j,M))) = - 4 - kij*Delta2/D_G;
        
            rhs(k) = 0;
        end
    end
end

systemMatrix= sparse(systemMatrix);
Gvec = systemMatrix\rhs;


for k = 1:length(Gvec)
    i = v2m(k,1);
    j = v2m(k,2);
    G(i,j) = Gvec(k);
end


end

