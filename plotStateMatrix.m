function [ ] = plotStateMatrix( cancervariable)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

imagesc(cancervariable.statematrix);
caxis([1 7]); %color range from 1 to 6
colorbar;
title(['State Matrix at generation ' num2str(cancervariable.currentgeneration) ...
    ', where 1=vessel,2=necrosisnormal,3=quiescnormal,4=activetumor,5=quiesctumor,6=quiescnorm,7=necrosistumor']);

end

