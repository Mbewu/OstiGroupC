function [ growthRate ] = calculateGrowthRate( cancervariable )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

generations = cancervariable.noofogenerations-10:cancervariable.noofogenerations;
generations = generations';
radiusOfGyration = cancervariable.radiusOfGyration(generations);


p = polyfit(generations,radiusOfGyration,1);

yfit =  p(1) * generations + p(2);
yresid = radiusOfGyration - yfit;
SSresid = sum(yresid.^2);
SStotal = (length(radiusOfGyration)-1) * var(radiusOfGyration);
growthRate = p(1)
growthRateError = 1 - SSresid/SStotal


end

