function [ I J ] = IJfromC( C, N )
%IJFROMC obtains indices i, j from row c

if (mod(C,N) == 0)
    J = N;
    I = C / N;
else
    J = mod(C,N);
    I = (C-J+N)/N;
end

