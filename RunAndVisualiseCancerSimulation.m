%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% OstiCancerC - Code to reproduce results of "Patel et al. (2001) A 
% Cellular Automaton Model of Early Tumor Growth and Invasion*: The 
% Effects of Native Tissue Vascularity and Increased Anaerobic
% Tumor Metabolism" simulating cancer growth using a hybrid cellular 
% automaton model.
%
% Copyright (C) 2013  Jackie Ang, Jonny Brook-Bartlett, Alexander Erlich,
% James Mbewu and Robert Ross.
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ] = RunAndVisualiseCancerSimulation()
%% First draft code to set up the initial matrix 
% This code is a first attempt at setting up the initial matrix required
% for the simulation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section 1: Defining the variables for the problem


phi = [0.05 0.1];
HA = [5e-5];

filename = 'data\dataFile.dat';

fileID = fopen(filename,'w+');
fprintf(fileID,'Simulation for vessel densities \n');
fprintf(fileID,'%f\n',phi);
fprintf(fileID,'and acid production rates \n');
fprintf(fileID,'%f\n',HA);
fclose(fileID);

for a = 1:length(HA)
for m = 1:length(phi)

cancervariable.matrixrownumber = 100; % number of rows for the cellular automaton grid
cancervariable.matrixcolnumber = 100; % number of columns for the cellular automaton grid
cancervariable.vesseldensity = 0.02; % gives the density of the vessels in the cellular automaton grid
% vessel density = (number of grid elements containing vessels)/(number of grid elements which is the rownumber*colnumber)
%this means the vessel density indirectly gives the number of cells
%containing vessels which will be randomly distributed in the grid.
% note tumour diameter must be less than matrixrow/col number
cancervariable.initialtumourdiameter = 5; % number of tumor cells that make up the diameter of the disk of tumor cells that initially starts in the center of the grid (
cancervariable.initialpH = 3.98e-5; %Initial pH value (7.4) that is uniform across the grid (i.e. every cell begins with a pH value of initialpH)
cancervariable.initialglucoseconcentration = 1; % Initial value of glucose concentration that is uniform across the grid.
cancervariable.statematrix = 3*ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the state of each grid element (i.e. is it  a micro-vessel = 1, empty normal = 2, normal cell = 3, activetumor cell = 4, quiescenttumor cell = 5, quiescent normal = 6, empty tumor = 7). Notice that we're populating the matrix with normal cells
cancervariable.pHmatrix = cancervariable.initialpH*ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the value of the pH of the corresponding grid element
cancervariable.glucosematrix = cancervariable.initialglucoseconcentration*ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the value of the glucose concentration of the corresponding grid element
cancervariable.ghostvaluematrix = ones(cancervariable.matrixrownumber,cancervariable.matrixcolnumber); % matrix representing the "ghost values" for the grid element (only valid for grid elements that contain vessels).


cancervariable.spacestep = 0.002; %(centimetres)
cancervariable.D_G = 9.1e-5; %(centimetres^2 / s)
cancervariable.kr = zeros(7,1);
cancervariable.kr(2) = 0; % empty k
cancervariable.kr(3) = 1e-4; % normal k
cancervariable.kr(4)= 1e-3; % activetumor k (1/s)
cancervariable.kr(5)= 1e-3; % quiescenttumor k (1/s)
cancervariable.kr(6)= 1e-4; % quiescentnormal k (1/s)
cancervariable.kr(7)= 0; % empty tumor k (1/s)
cancervariable.q_G = 3.0e-5; %(centimetres / s)
cancervariable.G_S = 5.0; % (mM)
cancervariable.D_H = 1.08e-5; %(centimetres^2 / s)
cancervariable.hr = zeros(7,1);
cancervariable.hr(2) = 0; % empty k
cancervariable.hr(3) = 0; % normal k
cancervariable.hr(4)= 5.0e-5; % activetumor k (1/s)
cancervariable.hr(5) = 5e-7; % quiescenttumor
cancervariable.hr(6) = 0; % quiescentnormal
cancervariable.hr(7) = 0; % empty tumor k
cancervariable.q_H = 1.19e-4; %(centimetres / s)
cancervariable.H_S = 3.98e-5; % (mM)

%cellular auto

cancervariable.noofogenerations = 10;
cancervariable.currentgeneration = 1;
cancervariable.GdN = 2.5; %mM
cancervariable.GdT = 2.5; %mM
cancervariable.pHdN = 6.8; % 6.8
cancervariable.pHdT = 6.0; % 6.0
cancervariable.pHqN = 7.1; % 7.1
cancervariable.pHqT = 6.4; % 6.4
cancervariable.radiusOfGyration = zeros(cancervariable.noofogenerations,1);

cancervariable.f = 0.5;

cancervariable.vesseldensity = phi(m); % gives the density of the vessels in the cellular automaton grid
cancervariable.hr(4) = HA(a);

%write to file
fileID = fopen(filename,'a+');
fprintf(fileID,'New Simulation \n');
fprintf(fileID,'vesselDensity = %f \n',cancervariable.vesseldensity);
fprintf(fileID,'tumorAcid = %f \n',cancervariable.hr(4));
fclose(fileID);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section 2: Setting up and visualise the initial state matrix


cancervariable.statematrix = initStateMatrix(cancervariable);

%findGlucoseMatrix
cancervariable.glucosematrix = findGlucoseMatrix(cancervariable);
cancervariable.pHmatrix = findPHMatrix(cancervariable);

%Show the state matrix
%visualise(cancervariable);

%plotGlucoseMatrix(cancervariable);
%plotPHMatrix(cancervariable);

[cancervariable.statematrix growthRate radiusOfGyration] = cellular_automaton(cancervariable);

%growthRates(m) = growthRate;

fileID = fopen(filename,'a+');
fprintf(fileID,'tumorSize \n');
fprintf(fileID,'%f\n',radiusOfGyration);
fprintf(fileID,'growthRate \n');
fprintf(fileID,'%f\n',growthRate);
fclose(fileID);

end
end



end