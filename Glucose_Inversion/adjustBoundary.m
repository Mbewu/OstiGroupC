function [ Inew ] = adjustBoundary( Iold, N )
%ADJUSTBOUNDARY updates index Iold to fit boundary conditions of N x N
%matirx.

Inew = Iold;

if (Iold < 1)
    Inew = N;
else if (Iold > N)
    Inew = 1;
    end

end