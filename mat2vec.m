function [ vecID ] = mat2vec( rowID, colID, m2v )
%mat2vec converts the matrix ID to corresponding vector ID
%   m2v is a matrix with the vector numbers

N = size(m2v,1);

%periodic boundaries
if (rowID == 0)
    rowID = N;
elseif(rowID == N+1)
    rowID = 1;
end

if (colID == 0)
    colID = N;
elseif(colID == N+1)
    colID = 1;
end

%convert
vecID = m2v(rowID,colID);

end

