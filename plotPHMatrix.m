function [ ] = plotPHMatrix( cancervariable )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

imagesc(cancervariable.pHmatrix)
caxis([min(min(cancervariable.pHmatrix)) max(max(cancervariable.pHmatrix))])
title(['H+ concentration at generation ' num2str(cancervariable.currentgeneration)]);
colorbar


end

