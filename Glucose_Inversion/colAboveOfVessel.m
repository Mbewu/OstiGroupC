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

