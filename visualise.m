function [ ] = visualise( cancervariable , handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

figure;
%subplot(1,3,1);
plotStateMatrix(cancervariable, handles);
figure;
%subplot(1,3,2);
plotGlucoseMatrix(cancervariable, handles);
figure;
%subplot(1,3,3);
plotPHMatrix(cancervariable, handles);



end

