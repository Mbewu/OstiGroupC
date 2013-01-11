function [ C ] = CfromIJ( I, J, N )
%CFROMIJ obtains row c from indices i, j

C = (I-1).*N+J;

end

