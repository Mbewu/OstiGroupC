function [ ] = plotStateMatrix( cancervariable )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

imagesc(cancervariable.statematrix);
caxis([1 6]); %color range from 1 to 6
colorbar;
title(['State Matrix at generation ' num2str(cancervariable.currentgeneration)]);

end

