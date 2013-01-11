function [ ] = RunAndVisualiseCancerSimulation()
%% First draft code to set up the initial matrix 
% This code is a first attempt at setting up the initial matrix required
% for the simulation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section 1: Defining the variables for the problem

cancervariable.matrixrownumber = 10; % number of rows for the cellular automaton grid
cancervariable.matrixcolnumber = 10; % number of columns for the cellular automaton grid
cancervariable.vesseldensity = 0.08; % gives the density of the vessels in the cellular automaton grid
% vessel density = (number of grid elements containing vessels)/(number of grid elements which is the rownumber*colnumber)
%this means the vessel density indirectly gives the number of cells
%containing vessels which will be randomly distributed in the grid.
% note tumour diameter must be less than matrixrow/col number
cancervariable.initialtumourdiameter = 3; % number of tumor cells that make up the diameter of the disk of tumor cells that initially starts in the center of the grid (
cancervariable.initialpH = 3.98e-5; %Initial pH value (7.4) that is uniform across the grid (i.e. every cell begins with a pH value of initialpH)
cancervariable.initialglucoseconcentration = 1; % Initial value of glucose concentration that is uniform across the grid.
cancervariable.statematrix = 3*ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the state of each grid element (i.e. is it  a micro-vessel = 1, empty = 2, normal cell = 3, activetumor cell = 4, quiescenttumor cell = 5, quiescent normal = 6). Notice that we're populating the matrix with normal cells
cancervariable.pHmatrix = cancervariable.initialpH*ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the value of the pH of the corresponding grid element
cancervariable.glucosematrix = cancervariable.initialglucoseconcentration*ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the value of the glucose concentration of the corresponding grid element
cancervariable.ghostvaluematrix = ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the "ghost values" for the grid element (only valid for grid elements that contain vessels).

cancervariable.spacestep = 0.002; %(centimetres)
cancervariable.D_G = 9.1e-9; %(centimetres^2 / s)
cancervariable.kr = zeros(6,1);
cancervariable.kr(2) = 0; % empty k
cancervariable.kr(3) = 1e-4; % normal k
cancervariable.kr(4)= 1e-3; % activetumor k (1/s)
cancervariable.kr(5)= 1e-3; % quiescenttumor k (1/s)
cancervariable.kr(6)= 1e-4; % quiescenttumor k (1/s)
cancervariable.q_G = 3.0e-5; %(centimetres / s)
cancervariable.G_S = 4.0; % (mM)
cancervariable.D_H = 1.08e-5; %(centimetres^2 / s)
cancervariable.hr = zeros(6,1);
cancervariable.hr(2) = 0; % empty k
cancervariable.hr(3) = 0; % normal k
cancervariable.hr(4)= 1e-5; % activetumor k (1/s)
cancervariable.hr(5) = 5e-7; % quiescenttumor
cancervariable.hr(6) = 5e-7; % quiescenttumor
cancervariable.q_H = 1.19e-4; %(centimetres / s)
cancervariable.H_S = 3.98e-5; % (mM)

%cellular auto

cancervariable.noofogenerations = 50;
cancervariable.GdN = 2.5; %mM
cancervariable.GdT = 2.5; %mM
cancervariable.pHdN = 1.58e-4; % 6.8
cancervariable.pHdT = 1.0e-3; % 6.0
cancervariable.pHqN = 7.94e-5; % 7.1
cancervariable.pHqT = 3.98e-4; % 6.4

cancervariable.f = 0.1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section 2: Setting up and visualise the initial state matrix

cancervariable.statematrix = initStateMatrix(cancervariable);


%Show the state matrix
figure;
imagesc(cancervariable.statematrix);
title('cell state matrix');

%findGlucoseMatrix
cancervariable.glucosematrix = findGlucoseMatrix(cancervariable);
cancervariable.pHmatrix = findPHMatrix(cancervariable);

plotGlucoseMatrix(cancervariable);
plotPHMatrix(cancervariable);

cancervariable.statematrix = cellular_automaton(cancervariable);


plotGlucoseMatrix(cancervariable);
plotPHMatrix(cancervariable);
figure;
imagesc(cancervariable.statematrix);

%r = radiusOfGyration(cancervariable);


end