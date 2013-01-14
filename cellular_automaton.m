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

function [state_matrix growthRate] = cellular_automaton(cancervariable)

N = cancervariable.matrixrownumber;
M = cancervariable.matrixcolnumber;
state_matrix = cancervariable.statematrix;
f = cancervariable.f;

figure;

handles.state = subplot(2,2,1);
ax1=get(handles.state,'position'); % Save the position as ax
handles.tumorsize = subplot(2,2,2);
ax2=get(handles.tumorsize,'position'); % Save the position as ax
handles.glucose = subplot(2,2,3);
ax3=get(handles.glucose,'position'); % Save the position as ax
handles.ph = subplot(2,2,4);
ax4=get(handles.ph,'position'); % Save the position as ax

set(handles.state,'position',ax1); % Manually setting this holds the position with colorbar 
axes(handles.state);
plotStateMatrix(cancervariable);
set(handles.glucose,'position',ax3); % Manually setting this holds the position with colorbar 
axes(handles.glucose);
plotGlucoseMatrix(cancervariable);
set(handles.ph,'position',ax4); % Manually setting this holds the position with colorbar 
axes(handles.ph);
plotPHMatrix(cancervariable);

%RANDOMLY PICK 1/f OF CELLS TO UPDATE FOR SUB-GENERATION

for k = 1:cancervariable.noofogenerations
    
    solvingTime = 0;
    automatonTime = 0;
    
    cancervariable.currentgeneration = k;
    

    vector_random = randperm(N*M);
    
    %SUBGENERATIONS
    for n = 1:ceil(1/f)
        death_matrix = state_matrix;
        tic;
        %%%%%%%ENTER GLUCOSE FUNCTION%%%%%%%%%%%
        cancervariable.glucosematrix = findGlucoseMatrix(cancervariable);
        %%%%%%%ENTER LACTIC ACID FUNCTION%%%%%%%%%%%
        cancervariable.pHmatrix = findPHMatrix(cancervariable);
        solvingTime = solvingTime + toc;
        tic;
        state_matrix = subgeneration(cancervariable,n,death_matrix,state_matrix,vector_random);
        automatonTime = automatonTime + toc;
        
        cancervariable.statematrix = state_matrix;
        
        set(handles.glucose,'position',ax3); % Manually setting this holds the position with colorbar
        axes(handles.glucose);
        plotGlucoseMatrix(cancervariable);
        set(handles.ph,'position',ax4); % Manually setting this holds the position with colorbar 
        axes(handles.ph);
        plotPHMatrix(cancervariable);
    end
    
    cancervariable.statematrix = state_matrix;
    %visualise solution at ever 10 generation
    generation = cancervariable.currentgeneration
    cancervariable.radiusOfGyration(k) = radiusOfGyration(cancervariable);
    
    set(handles.state,'position',ax1); % Manually setting this holds the position with colorbar 
    axes(handles.state);
    plotStateMatrix(cancervariable);
    set(handles.tumorsize,'position',ax2); % Manually setting this holds the position with colorbar 
    axes(handles.tumorsize);
    plotRadiusOfGyration(cancervariable,k);
end

growthRate = calculateGrowthRate( cancervariable )

