function [ Inew ] = adjustBoundary( I, N )
%ADJUSTBOUNDARY updates index Iold to fit boundary conditions of N x N
%matirx.

Inew = I + (-I + 1).*(I > N) ...
         + (-I + N).*(I < 1);

% Inew = Iold;
% 
% if (Iold < 1)
%     Inew = N;
% else if (Iold > N)
%     Inew = 1;
%     end
% 
% end