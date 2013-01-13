function [ ] = visualise( cancervariable )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

figure;
%subplot(1,3,1);
plotStateMatrix(cancervariable);
figure;
%subplot(1,3,2);
plotGlucoseMatrix(cancervariable);
figure;
%subplot(1,3,3);
plotPHMatrix(cancervariable);



end

