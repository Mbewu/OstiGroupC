function [ col ] = colConstruct( C, K, N, DG, delta)
%COLCONSTRUCT Constructs C-th column of D matrix WITHOUT the inclusion of
%boundary conditions (for which colCorrect() is responsible). 

[I J] = IJfromC(C,N);

neighbors = [   I-1 J
                I+1 J
                I   J-1 
                I   J+1 ];       

neighbors = adjustBoundary(neighbors, N);



% 
% [I J] = IJfromC(C, N);
% 
% Iup   = adjustBoundary(I-1,N);
% Idown     = adjustBoundary(I+1,N);
% Jright   = adjustBoundary(J-1,N);
% Jleft  = adjustBoundary(J+1,N);
% 
% col = zeros(1,N^2);
% 
% col(CfromIJ(Iup, J, N)) = 1/(delta^2);
% col(CfromIJ(Idown, J, N)) = 1/(delta^2);
% col(CfromIJ(I, Jright, N)) = 1/(delta^2);
% col(CfromIJ(I, Jleft, N)) = 1/(delta^2);
% 
% col(C) = -4/(delta^2)-K(C)/DG;
% 
% end