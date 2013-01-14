function [ C ] = CfromIJ( I, J, N )
%CFROMIJ obtains row c from indices i, j

C = (J-1).*N+I;

end

