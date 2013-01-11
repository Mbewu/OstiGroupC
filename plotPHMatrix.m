function [ ] = plotPHMatrix( cancervariable )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

figure;
pcolor(cancervariable.pHmatrix)
caxis([min(min(cancervariable.pHmatrix)) max(max(cancervariable.pHmatrix))])
title('H+ level');
colorbar


end

