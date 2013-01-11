function [ output_args ] = plotGlucoseMatrix( cancervariable )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%find max that is less than G_S
max = 0;
for i=1:cancervariable.matrixrownumber
    for j = 1:cancervariable.matrixcolnumber
        if(cancervariable.glucosematrix(i,j)>max && cancervariable.glucosematrix(i,j)<cancervariable.G_S)
            max = cancervariable.glucosematrix(i,j);
        end
    end
end


figure;
pcolor(cancervariable.glucosematrix)
caxis([min(min(cancervariable.glucosematrix)) max])
colorbar
title('glucose level');


end

