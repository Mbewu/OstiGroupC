function [ ] = RunAndVisualiseCancerSimulation()
%% First draft code to set up the initial matrix 
% This code is a first attempt at setting up the initial matrix required
% for the simulation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section 1: Defining the variables for the problem

cancervariable.matrixrownumber = 100; % number of rows for the cellular automaton grid
cancervariable.matrixcolnumber = 100; % number of columns for the cellular automaton grid
cancervariable.vesseldensity = 0.08; % gives the density of the vessels in the cellular automaton grid
% vessel density = (number of grid elements containing vessels)/(number of grid elements which is the rownumber*colnumber)
%this means the vessel density indirectly gives the number of cells
%containing vessels which will be randomly distributed in the grid.
cancervariable.initialtumourdiameter = 20; % number of tumor cells that make up the diameter of the disk of tumor cells that initially starts in the center of the grid
cancervariable.initialpH = 7.4; %Initial pH value that is uniform across the grid (i.e. every cell begins with a pH value of initialpH)
cancervariable.initialglucoseconcentration = 1; % Initial value of glucose concentration that is uniform across the grid.
cancervariable.statematrix = ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the state of each grid element (i.e. is it empty = 0, normal cell = 1, tumor cell = 2, a micro-vessel = 3). Notice that we're populating the matrix with normal cells
cancervariable.pHmatrix = cancervariable.initialpH*ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the value of the pH of the corresponding grid element
cancervariable.glucosematrix = cancervariable.initialglucoseconcentration*ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the value of the glucose concentration of the corresponding grid element
cancervariable.ghostvaluematrix = ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the "ghost values" for the grid element (only valid for grid elements that contain vessels).

cancervariable.spacestep = 0.002; %(centimetres)
cancervariable.D_G = 9.1e-5; %(centimetres^2 / s)
cancervariable.kr = zeros(4,1);
cancervariable.kr(1) = 0; % empty k
cancervariable.kr(2) = 1e-4; % normal k
cancervariable.kr(3)= 1e-3; % tumor k (1/s)
cancervariable.kr(4) = 0; %vessel dummy
cancervariable.q_G = 3.0e-5; %(centimetres / s)
cancervariable.G_S = 5.0; % (mM)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section 2: Setting up and visualise the initial state matrix

cancervariable.statematrix = initStateMatrix(cancervariable);


%Show the state matrix
imagesc(cancervariable.statematrix);
%%%%%%%%%%WHAT ARE THE GHOST VALUES?%%%%%%%%%%%%%%%%%%%%%%%%

%findGlucoseMatrix
cancervariable.glucosematrix = findGlucoseMatrix(cancervariable);

plotGlucoseMatrix(cancervariable);


end