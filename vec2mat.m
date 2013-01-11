function [ rowID, colID ] = vec2mat( vecID, m2v )
%vec2mat converts the vector ID to corresponding matrix ID
%   N is the size of the square domain

rowID = floor(vecID/N);
colID = mod(vecID,N);

end

