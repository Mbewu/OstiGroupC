function [ radius ] = radiusOfGyration( cancervariable )
%radiusOfGyration Summary of this function goes here
%   Calculates radius of gyration of cancerous region

length = cancervariable.spacestep;
centroid = zeros(2,1);
Jlocal = length^4/12;
count = 0;
for i=1:cancervariable.matrixrownumber
    for j=1:cancervariable.matrixcolnumber
        
        if (cancervariable.statematrix(i,j) == 4 ...
            || cancervariable.statematrix(i,j) == 5)
            centroid(1) = centroid(1) + (i-1)*length + length/2;
            centroid(2) = centroid(2) + (j-1)*length + length/2;
            
            count = count + 1;
        end
    end
end

centroid = centroid/count

area = cancervariable.spacestep*cancervariable.spacestep;
%calculate second moment
radius = 0;
for i=1:cancervariable.matrixrownumber
    for j=1:cancervariable.matrixcolnumber
        
        if (cancervariable.statematrix(i,j) == 4 ...
            || cancervariable.statematrix(i,j) == 5)
            radius = radius + Jlocal + area * ((i-1)*cancervariable.spacestep + length/2 - centroid(2))^2;
        end
    end
end

secondMoment = radius
secondMomentAdjusted = radius + area*count*centroid(2)^2
%radius = radius*area;% + count*area*(distance^2);
radius = sqrt(radius/(area*count))
radiusAdjusted = sqrt(secondMomentAdjusted/(area*count))







end

