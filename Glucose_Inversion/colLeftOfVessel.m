function [ col] = colLeftOfVessel( C, K, B, N, delta, DG, qG, Gs)
%COLCONSTRUCT Constructs C-th column of D matrix WITHOUT the inclusion of
%boundary conditions (for which colCorrect() is responsible). 

qG = 1;
Gs = 1;
delta = 1;
DG = 1;

[I J] = IJfromC(C, N);

Iup     = adjustBoundary(I-1,N);
Idown     = adjustBoundary(I+1,N);
Jright   = adjustBoundary(J-1,N);

col = zeros(1,N^2);

col(CfromIJ(Iup, J, N)) = 1/(delta^2);
col(CfromIJ(Idown, J, N)) = 1/(delta^2);
col(CfromIJ(I, Jright, N)) = 1/(delta^2);

col(C) = - 3 -(delta^2 * K(C) + qG*delta)/DG;


end

