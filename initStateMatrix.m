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
%the state matrix that contains a micro-vessel has value 0)
randomrownumber = randi(cancervariable.matrixrownumber,cancervariable.numberofvessels,1); % generate a vector of random integers between 1 and the matrix row number to be used as the random row number for each of the vessels
randomcolnumber = randi(cancervariable.matrixcolnumber,cancervariable.numberofvessels,1);% generate a vector of random integers between 1 and the matrix column number to be used as the random column number for each of the vessels
randomgridposition = [randomrownumber,randomcolnumber]; % store the row number and the column number in a matrix (each row of this matrix now represents the random position of a vessel)

%assign the positions in the state matrix.
for lcv_vesselposition = 1 : cancervariable.numberofvessels
   %check that for each direction there are no adjacent cells that are
   %already next to a vessel
   while( isNotAllowedVesselPosition(cancervariable,randomgridposition,lcv_vesselposition))           
           randomgridposition(lcv_vesselposition,1) = randi(cancervariable.matrixrownumber,1);
           randomgridposition(lcv_vesselposition,2) = randi(cancervariable.matrixcolnumber,1);
   end
       
   cancervariable.statematrix(randomgridposition(lcv_vesselposition,1),randomgridposition(lcv_vesselposition,2)) = 1;
end

%%%%% Now we need to add the disk of tumor cells with diameter given by cancervariable.initialtumourdiameter to the center of the grid
%cancervariable.statematrix(round(cancervariable.matrixrownumber/2),round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2):round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2)+cancervariable.initialtumourdiameter-1)=4;
%cancervariable.statematrix(round(cancervariable.matrixrownumber/2)+1,round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2):round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2)+cancervariable.initialtumourdiameter-1)=4;
%cancervariable.statematrix(round(cancervariable.matrixrownumber/2)-1,round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2):round(cancervariable.matrixcolnumber/2)-floor(cancervariable.initialtumourdiameter/2)+cancervariable.initialtumourdiameter-1)=4;
%cancervariable.statematrix(round(cancervariable.matrixrownumber/2)+2,round(cancervariable.matrixcolnumber/2)-floor((cancervariable.initialtumourdiameter-2)/2):round(cancervariable.matrixcolnumber/2)-floor((cancervariable.initialtumourdiameter-2)/2)+cancervariable.initialtumourdiameter-3)=4;
%cancervariable.statematrix(round(cancervariable.matrixrownumber/2)-2,round(cancervariable.matrixcolnumber/2)-floor((cancervariable.initialtumourdiameter-2)/2):round(cancervariable.matrixcolnumber/2)-floor((cancervariable.initialtumourdiameter-2)/2)+cancervariable.initialtumourdiameter-3)=4;

[rr cc] = meshgrid(1:cancervariable.matrixrownumber,1:cancervariable.matrixcolnumber);
C = sqrt((rr-round(cancervariable.matrixrownumber/2)).^2+(cc-round(cancervariable.matrixcolnumber/2)).^2)<=floor(cancervariable.initialtumourdiameter/2);

for i=1:cancervariable.matrixrownumber
    for j=1:cancervariable.matrixcolnumber
        if (C(i,j) == 1)
            cancervariable.statematrix(i,j) = 4;
        end
    end
end

statematrix = cancervariable.statematrix;

end

