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

function [ statematrix ] = initStateMatrix( cancervariable )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

lcv_vesselposition = 1; %A loop control variable that is used for the loop when assigning the position of the vessels in the matrix.

%%%%%First thing we need to do is calculate the number of vessels that the grid
%will contain which is given by the following: 
cancervariable.numberofvessels = round(cancervariable.vesseldensity*(cancervariable.matrixrownumber*cancervariable.matrixcolnumber));
%(Note that we round the result because we want an integer number)

%now we need to randomly allocate a grid position to each of the vessels in
%the simulation. (Note that for now we are assuming that a grid element in
%the state matrix that contains a micro-vessel has value 3)
randomrownumber = randi(cancervariable.matrixrownumber,cancervariable.numberofvessels,1); % generate a vector of random integers between 1 and the matrix row number to be used as the random row number for each of the vessels
randomcolnumber = randi(cancervariable.matrixcolnumber,cancervariable.numberofvessels,1);% generate a vector of random integers between 1 and the matrix column number to be used as the random column number for each of the vessels
randomgridposition = [randomrownumber,randomcolnumber]; % store the row number and the column number in a matrix (each row of this matrix now represents the random position of a vessel)

%assign the positions in the state matrix.
for lcv_vesselposition = 1 : cancervariable.numberofvessels
   %check that for each direction there are no adjacent cells that are
   %already next to a vessel
   while((cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)-1),rowColID(randomgridposition(lcv_vesselposition,2))) ~=3 ...
           && (cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)-2),rowColID(randomgridposition(lcv_vesselposition,2))) == 3 ...
           || cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)-1),rowColID(randomgridposition(lcv_vesselposition,2)-1)) == 3 ...
           || cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)-1),rowColID(randomgridposition(lcv_vesselposition,2)+1)) == 3)) ...
           || ...
           (cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)),rowColID(randomgridposition(lcv_vesselposition,2)-1)) ~=3 ...
           && (cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)-1),rowColID(randomgridposition(lcv_vesselposition,2)-1)) == 3 ...
           || cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)),rowColID(randomgridposition(lcv_vesselposition,2)-2)) == 3 ...
           || cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)+1),rowColID(randomgridposition(lcv_vesselposition,2)-1)) == 3)) ...
           || ...
           (cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)),rowColID(randomgridposition(lcv_vesselposition,2)+1)) ~=3 ...
           && (cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)-1),rowColID(randomgridposition(lcv_vesselposition,2)+1)) == 3 ...
           || cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)),rowColID(randomgridposition(lcv_vesselposition,2)+2)) == 3 ...
           || cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)+1),rowColID(randomgridposition(lcv_vesselposition,2)+1)) == 3)) ...
           || ...
           (cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)+1),rowColID(randomgridposition(lcv_vesselposition,2))) ~=3 ...
           && (cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)+1),rowColID(randomgridposition(lcv_vesselposition,2)-1)) == 3 ...
           || cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)+2),rowColID(randomgridposition(lcv_vesselposition,2))) == 3 ...
           || cancervariable.statematrix(rowColID(randomgridposition(lcv_vesselposition,1)+1),rowColID(randomgridposition(lcv_vesselposition,2)+1)) == 3)) ...
           || ...
           cancervariable.statematrix(randomgridposition(lcv_vesselposition,1),randomgridposition(lcv_vesselposition,2)) == 3)
           
           randomgridposition(lcv_vesselposition,1) = randi(cancervariable.matrixrownumber,1);
           randomgridposition(lcv_vesselposition,2) = randi(cancervariable.matrixcolnumber,1);
   end
       
   fang = 2
   cancervariable.statematrix(randomgridposition(lcv_vesselposition,1),randomgridposition(lcv_vesselposition,2)) = 3;
end

%%%%%%%%%%NEED TO ADD CODE TO TACKLE THE PROBLEM OF THE VESSEL CONSTRAINTS%%%%%%%%%%%

%%%%% Now we need to add the disk of tumor cells with diameter given by cancervariable.initialtumourdiameter to the center of the grid
cancervariable.statematrix(round(cancervariable.matrixrownumber/2),round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2):round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2)+cancervariable.initialtumourdiameter-1)=2;
cancervariable.statematrix(round(cancervariable.matrixrownumber/2)+1,round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2):round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2)+cancervariable.initialtumourdiameter-1)=2;
cancervariable.statematrix(round(cancervariable.matrixrownumber/2)-1,round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2):round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2)+cancervariable.initialtumourdiameter-1)=2;
cancervariable.statematrix(round(cancervariable.matrixrownumber/2)+2,round(cancervariable.matrixcolnumber/2)-floor((cancervariable.initialtumourdiameter-2)/2):round(cancervariable.matrixcolnumber/2)-floor((cancervariable.initialtumourdiameter-2)/2)+cancervariable.initialtumourdiameter-3)=2;
cancervariable.statematrix(round(cancervariable.matrixrownumber/2)-2,round(cancervariable.matrixcolnumber/2)-floor((cancervariable.initialtumourdiameter-2)/2):round(cancervariable.matrixcolnumber/2)-floor((cancervariable.initialtumourdiameter-2)/2)+cancervariable.initialtumourdiameter-3)=2;

statematrix = cancervariable.statematrix;

figure;
imagesc(cancervariable.statematrix);
end

