function [ ID] = rowColID( rowColNumber)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

N = 100;
%periodic boundaries
if(rowColNumber == -1)
    ID = N-1;
elseif (rowColNumber == 0)
    ID = N;
elseif(rowColNumber == N+1)
    ID = 1;
elseif(rowColNumber == N+2)
    ID = 2;
else
    ID = rowColNumber;
end

end

