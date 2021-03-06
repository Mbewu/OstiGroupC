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

function [ state_matrix ] = subgeneration( cancervariable,subgenno , death_matrix, state_matrix , vector_random)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

N = cancervariable.matrixrownumber;
M = cancervariable.matrixcolnumber;
f = cancervariable.f;

n = subgenno;


        for i = 1:((N*M)/ceil(1/f))
            
                if (n-1)*((N*M)/ceil(1/f)) + i > N*M
                    break
                else
                  cell_position = vector_random((n-1)*((N*M)/ceil(1/f)) + i);
       
                %SELECT NORMAL
        
                    if state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 3 || state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 6
    
                        %LOW pH AND LOW GLUCOSE LEVEL KILLS CELLS
    
                        if cancervariable.glucosematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.GdN 
    
                             state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 2;

                        elseif cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.pHdN 
    
                            state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 2;
                            
                        elseif cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.pHqN 
                            
                            state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 6;
                        elseif (cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) > cancervariable.pHqN)
    
                            state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 3;
                        end
                    end
                            
                    
                        %HIGH pH ALLOWS CELLS TO DIVIDE - CELL DIVIDES INTO FREE SPACE WITH HIGHEST
                        %GLUCOSE CONCENTRATION IF AVAILABLE
                    if state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 3 ...
                            && cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) > cancervariable.pHqN
                        
                        %CENTRAL GRID DIVIDING
                    if ceil(cell_position/N) ~= 1 && ceil(cell_position/N) ~= M && rem(cell_position-1,N)+1 ~= 1 && rem(cell_position-1,N)+1 ~= N 
       
                        if death_matrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) == 7)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) == 7)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) == 7)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 7)
                                glucose(4) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1);
                            end
                                
                            a = find(max(glucose) == glucose);
                                                        
                            %maybe a(1)
                            if a == 1
                                state_matrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) = 3;
                            elseif a == 2
                                state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) = 3;
                            elseif a == 3
                                state_matrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) = 3;
                            elseif a == 4
                                state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) = 3;    
                            end
                        end
                        
                        
        
                    %DIVIDING CELLS - SIDES
                    %TOP   
                    elseif rem(cell_position-1,N)+1 == 1 && ceil(cell_position/N) ~= 1 && ceil(cell_position/N) ~= M
                        if death_matrix(1,ceil(cell_position/N)-1) == 2 ...
                            || death_matrix(1,ceil(cell_position/N)+1) == 2 ...
                            || death_matrix(2,ceil(cell_position/N)) == 2 ...
                            || death_matrix(N,ceil(cell_position/N)) == 2 ...
                            || death_matrix(1,ceil(cell_position/N)-1) == 7 ...
                            || death_matrix(1,ceil(cell_position/N)+1) == 7 ...
                            || death_matrix(2,ceil(cell_position/N)) == 7 ...
                            || death_matrix(N,ceil(cell_position/N)) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,ceil(cell_position/N)-1) == 2 ...
                                    || cancervariable.statematrix(1,ceil(cell_position/N)-1) == 7)
                                glucose(1) = cancervariable.glucosematrix(1,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(1,ceil(cell_position/N)+1) == 2 ...
                                    || cancervariable.statematrix(1,ceil(cell_position/N)+1) == 7)
                                glucose(2) = cancervariable.glucosematrix(1,ceil(cell_position/N)+1);
                            end
                            if(cancervariable.statematrix(2,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(2,ceil(cell_position/N)) == 7)
                                glucose(3) = cancervariable.glucosematrix(2,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(N,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(N,ceil(cell_position/N)) == 7)
                                glucose(4) = cancervariable.glucosematrix(N,ceil(cell_position/N));
                            end
                                
                            a = find(max(glucose) == glucose);
                                   
                        
                            if a == 1
                                state_matrix(1,ceil(cell_position/N)-1) = 3;
                            elseif a == 2
                                state_matrix(1,ceil(cell_position/N)+1) = 3;
                            elseif a == 3
                                state_matrix(2,ceil(cell_position/N)) = 3;
                            elseif a == 4
                                state_matrix(N,ceil(cell_position/N)) = 3;    
                            end
                        end
        
                    %RIGHT    
                    elseif ceil(cell_position/N) == M && rem(cell_position-1,N)+1 ~= 1 && rem(cell_position-1,N)+1 ~= N
                        if death_matrix(rem(cell_position-1,N)+1-1 , M) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,M-1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,M) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1-1 , M) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,M-1) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,M) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,1) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1 , M) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1-1 , M) == 7)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1 , M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,M-1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,M-1) == 7)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,M-1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,M) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1+1,M) == 7)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,1) == 7)
                                glucose(4) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,1);
                            end
                                
                            a = find(max(glucose) == glucose);
                                   
                            if a == 1
                                state_matrix(rem(cell_position-1,N)+1-1,M) = 3;
                            elseif a == 2
                                state_matrix(rem(cell_position-1,N)+1,M-1) = 3;
                            elseif a == 3
                                state_matrix(rem(cell_position-1,N)+1+1,M) = 3;
                            elseif a == 4
                                state_matrix(rem(cell_position-1,N)+1,1) = 3;    
                            end
                        end  
        
                    %BOTTOM   
                    elseif rem(cell_position-1,N)+1 == N && ceil(cell_position/N) ~= 1 && ceil(cell_position/N) ~= M
                        if death_matrix(N,ceil(cell_position/N)-1) == 2 ...
                        || death_matrix(N,ceil(cell_position/N)+1) == 2 ...
                        || death_matrix(N-1,ceil(cell_position/N)) == 2 ...
                        || death_matrix(1,ceil(cell_position/N)) == 2 ...
                        || death_matrix(N,ceil(cell_position/N)-1) == 7 ...
                        || death_matrix(N,ceil(cell_position/N)+1) == 7 ...
                        || death_matrix(N-1,ceil(cell_position/N)) == 7 ...
                        || death_matrix(1,ceil(cell_position/N)) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,ceil(cell_position/N)-1) == 2 ... 
                                || cancervariable.statematrix(N,ceil(cell_position/N)-1) == 7)
                                glucose(1) = cancervariable.glucosematrix(N,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(N,ceil(cell_position/N)+1) == 2 ...
                                    || cancervariable.statematrix(N,ceil(cell_position/N)+1) == 7)
                                glucose(2) = cancervariable.glucosematrix(N,ceil(cell_position/N)+1);
                            end
                            if(cancervariable.statematrix(N-1,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(N-1,ceil(cell_position/N)) == 7)
                                glucose(3) = cancervariable.glucosematrix(N-1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(1,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(1,ceil(cell_position/N)) == 7)
                                glucose(4) = cancervariable.glucosematrix(1,ceil(cell_position/N));
                            end
                                
                            a = find(max(glucose) == glucose);
                                   
                            if a == 1
                                state_matrix(N,ceil(cell_position/N)-1) = 3;
                            elseif a == 2
                                state_matrix(N,ceil(cell_position/N)+1) = 3;
                            elseif a == 3
                                state_matrix(N-1,ceil(cell_position/N)) = 3;
                            elseif a == 4
                                state_matrix(1,ceil(cell_position/N)) = 3;    
                            end
                        end
     
                    %LEFT
                    elseif ceil(cell_position/N) == 1 && rem(cell_position-1,N)+1 ~= 1 && rem(cell_position-1,N)+1 ~= N
                        if death_matrix(rem(cell_position-1,N)+1-1,1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,M) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,2) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1-1,1) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,M) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,1) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,2) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1,1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1-1,1) == 7)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1,1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,M) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,M) == 7)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1+1,1) == 7)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,2) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,2) == 7)
                                glucose(4) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,2);
                            end
                                
                            a = find(max(glucose) == glucose);
                                   
                            if a == 1
                                state_matrix(rem(cell_position-1,N)+1-1,1) = 3;
                            elseif a == 2
                                state_matrix(rem(cell_position-1,N)+1,M) = 3;
                            elseif a == 3
                                state_matrix(rem(cell_position-1,N)+1+1,1) = 3;
                            elseif a == 4
                                state_matrix(rem(cell_position-1,N)+1,2) = 3;    
                            end
                        end 
        
                                   
                    %DIVIDING CELLS - CORNERS
    
                    elseif rem(cell_position-1,N)+1 == 1 && ceil(cell_position/N) == 1
                         if death_matrix(1,2) == 2 ...
                            || death_matrix(2,1) == 2 ...
                            || death_matrix(N,1) == 2 ...
                            || death_matrix(1,M) == 2 ...
                            || death_matrix(1,2) == 7 ...
                            || death_matrix(2,1) == 7 ...
                            || death_matrix(N,1) == 7 ...
                            || death_matrix(1,M) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,2) == 2 || cancervariable.statematrix(1,2) == 7)
                                glucose(1) = cancervariable.glucosematrix(1,2);
                            end
                            if(cancervariable.statematrix(2,1) == 2 || cancervariable.statematrix(2,1) == 7)
                                glucose(2) = cancervariable.glucosematrix(2,1);
                            end
                            if(cancervariable.statematrix(N,1) == 2 || cancervariable.statematrix(N,1) == 7)
                                glucose(3) = cancervariable.glucosematrix(N,1);
                            end
                            if(cancervariable.statematrix(1,M) == 2 || cancervariable.statematrix(1,M) == 7)
                                glucose(4) = cancervariable.glucosematrix(1,M);
                            end
                                
                            a = find(max(glucose) == glucose);
                                   
                                if a == 1
                                    state_matrix(1,2) = 3;
                                elseif a == 2
                                    state_matrix(2,1) = 3;
                                elseif a == 3
                                     state_matrix(N,1) = 3;
                                elseif a == 4
                                     state_matrix(1,M) = 3;    
                                end
                         end
                         
        
                    elseif rem(cell_position-1,N)+1 == 1 && ceil(cell_position/N) == M
                        if death_matrix(1,1) == 2 ...
                            || death_matrix(2, M) == 2 ...
                            || death_matrix(N,M) == 2 ...
                            || death_matrix(1,M-1) == 2 ...
                            || death_matrix(1,1) == 7 ...
                            || death_matrix(2, M) == 7 ...
                            || death_matrix(N,M) == 7 ...
                            || death_matrix(1,M-1) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,1) == 2 || cancervariable.statematrix(1,1) == 7)
                                glucose(1) = cancervariable.glucosematrix(1,1);
                            end
                            if(cancervariable.statematrix(2, M) == 2 || cancervariable.statematrix(2, M) == 7)
                                glucose(2) = cancervariable.glucosematrix(2, M);
                            end
                            if(cancervariable.statematrix(N,M) == 2 || cancervariable.statematrix(N,M) == 7)
                                glucose(3) = cancervariable.glucosematrix(N,M);
                            end
                            if(cancervariable.statematrix(1,M-1) == 2 || cancervariable.statematrix(1,M-1) == 7)
                                glucose(4) = cancervariable.glucosematrix(1,M-1);
                            end
                                
                            a = find(max(glucose) == glucose);
                                   
                            if a == 1
                                state_matrix(1,1) = 3;
                            elseif a == 2
                                state_matrix(2,M) = 3;
                            elseif a == 3
                                state_matrix(N,M) = 3;
                            elseif a == 4
                                state_matrix(1,M-1) = 3;    
                            end
                        end
        
        
                    elseif rem(cell_position-1,N)+1 == N && ceil(cell_position/N) == 1
                        if death_matrix(N,2) == 2 ...
                            || death_matrix(1,1) == 2 ...
                            || death_matrix(N-1,1) == 2 ...
                            || death_matrix(N,M) == 2 ...
                            || death_matrix(N,2) == 7 ...
                            || death_matrix(1,1) == 7 ...
                            || death_matrix(N-1,1) == 7 ...
                            || death_matrix(N,M) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,2) == 2 || cancervariable.statematrix(N,2) == 7)
                                glucose(1) = cancervariable.glucosematrix(N,2);
                            end
                            if(cancervariable.statematrix(1,1) == 2 || cancervariable.statematrix(1,1) == 7)
                                glucose(2) = cancervariable.glucosematrix(1,1);
                            end
                            if(cancervariable.statematrix(N-1,1) == 2 || cancervariable.statematrix(N-1,1) == 7)
                                glucose(3) = cancervariable.glucosematrix(N-1,1);
                            end
                            if(cancervariable.statematrix(N,M) == 2 || cancervariable.statematrix(N,M) == 7)
                                glucose(4) = cancervariable.glucosematrix(N,M);
                            end
                                
                            a = find(max(glucose) == glucose);
                                   
                            if a == 1
                                state_matrix(N,2) = 3;
                            elseif a == 2
                                state_matrix(1,1) = 3;
                            elseif a == 3
                                state_matrix(N-1,1) = 3;
                            elseif a == 4
                                state_matrix(N,M) = 3;    
                            end
                        end
            
                        elseif rem(cell_position-1,N)+1 == N && ceil(cell_position/N) == M
                        if death_matrix(N,1) == 2 ...
                            || death_matrix(1,M) == 2 ...
                            || death_matrix(N-1,M) == 2 ...
                            || death_matrix(N,M-1) == 2 ...
                            || death_matrix(N,1) == 7 ...
                            || death_matrix(1,M) == 7 ...
                            || death_matrix(N-1,M) == 7 ...
                            || death_matrix(N,M-1) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,1) == 2 || cancervariable.statematrix(N,1) == 7)
                                glucose(1) = cancervariable.glucosematrix(N,1);
                            end
                            if(cancervariable.statematrix(1,M) == 2 || cancervariable.statematrix(1,M) == 7)
                                glucose(2) = cancervariable.glucosematrix(1,M);
                            end
                            if(cancervariable.statematrix(N-1,M) == 2 || cancervariable.statematrix(N-1,M) == 7)
                                glucose(3) = cancervariable.glucosematrix(N-1,M);
                            end
                            if(cancervariable.statematrix(N,M-1) == 2 || cancervariable.statematrix(N,M-1) == 7)
                                glucose(4) = cancervariable.glucosematrix(N,M-1);
                            end
                                
                            a = find(max(glucose) == glucose);
                                   
                            if a == 1
                                state_matrix(N,1) = 3;
                            elseif a == 2
                                state_matrix(1,M) = 3;
                            elseif a == 3
                                state_matrix(N-1,M) = 3;
                            elseif a == 4
                                state_matrix(N,M-1) = 3;    
                            end
                        end
                    end
                            
                    end
                    
                    
                    %SELECT TUMOR ACTIVE
        
                if state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 4 || state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 5
    
                        %LOW pH AND LOW GLUCOSE LEVEL KILLS CELLS
    
                    if cancervariable.glucosematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.GdT 
    
                        state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 7;

                    elseif cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.pHdT 
    
                        state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 7;
                                        
                    elseif cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.pHqT
    
                        state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 5;
                    elseif (cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) > cancervariable.pHqT)
    
                        state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 4;
                    end
                end
                
                
                
                if state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 4 && cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) > cancervariable.pHqT
                        %CENTRAL GRID DIVIDING
                    if ceil(cell_position/N) ~= 1 && ceil(cell_position/N) ~= M && rem(cell_position-1,N)+1 ~= 1 && rem(cell_position-1,N)+1 ~= N 
       
                        if death_matrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) == 7)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) == 7)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) == 7)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 7)
                                glucose(4) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1);
                            end
                            
                            a = find(max(glucose) == glucose);
                                      
                            if a == 1
                                state_matrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) = 4;
                            elseif a == 2
                                state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) = 4;
                            elseif a == 3
                                state_matrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) = 4;
                            elseif a == 4
                                state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) = 4;    
                            end
                        end
    
    
                        
        
                    %DIVIDING CELLS - SIDES
                    %TOP   
                    elseif rem(cell_position-1,N)+1 == 1 && ceil(cell_position/N) ~= 1 && ceil(cell_position/N) ~= M
                        if death_matrix(1,ceil(cell_position/N)-1) == 2 ...
                            || death_matrix(1,ceil(cell_position/N)+1) == 2 ...
                            || death_matrix(2,ceil(cell_position/N)) == 2 ...
                            || death_matrix(N,ceil(cell_position/N)) == 2 ...
                            || death_matrix(1,ceil(cell_position/N)-1) == 7 ...
                            || death_matrix(1,ceil(cell_position/N)+1) == 7 ...
                            || death_matrix(2,ceil(cell_position/N)) == 7 ...
                            || death_matrix(N,ceil(cell_position/N)) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,ceil(cell_position/N)-1) == 2 ...
                                    || cancervariable.statematrix(1,ceil(cell_position/N)-1) == 7)
                                glucose(1) = cancervariable.glucosematrix(1,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(1,ceil(cell_position/N)+1) == 2 ...
                                    || cancervariable.statematrix(1,ceil(cell_position/N)+1) == 7)
                                glucose(2) = cancervariable.glucosematrix(1,ceil(cell_position/N)+1);
                            end
                            if(cancervariable.statematrix(2,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(2,ceil(cell_position/N)) == 7)
                                glucose(3) = cancervariable.glucosematrix(2,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(N,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(N,ceil(cell_position/N)) == 7)
                                glucose(4) = cancervariable.glucosematrix(N,ceil(cell_position/N));
                            end
                                
                            a = find(max(glucose) == glucose);
                                
                            if a == 1
                                state_matrix(1,ceil(cell_position/N)-1) = 4;
                            elseif a == 2
                                state_matrix(1,ceil(cell_position/N)+1) = 4;
                            elseif a == 3
                                state_matrix(2,ceil(cell_position/N)) = 4;
                            elseif a == 4
                                state_matrix(N,ceil(cell_position/N)) = 4;    
                            end
                        end
        
                    %RIGHT    
                    elseif ceil(cell_position/N) == M && rem(cell_position-1,N)+1 ~= 1 && rem(cell_position-1,N)+1 ~= N
                        if death_matrix(rem(cell_position-1,N)+1-1 , M) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,M-1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,M) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1-1 , M) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,M-1) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,M) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,1) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1 , M) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1-1 , M) == 7)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1 , M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,M-1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,M-1) == 7)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,M-1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,M) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1+1,M) == 7)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,1) == 7)
                                glucose(4) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,1);
                            end
                                
                            a = find(max(glucose) == glucose);
                                   
                            if a == 1
                                state_matrix(rem(cell_position-1,N)+1-1,M) = 4;
                            elseif a == 2
                                state_matrix(rem(cell_position-1,N)+1,M-1) = 4;
                            elseif a == 3
                                state_matrix(rem(cell_position-1,N)+1+1,M) = 4;
                            elseif a == 4
                                state_matrix(rem(cell_position-1,N)+1,1) = 4;    
                            end
                        end  
        
                    %BOTTOM   
                    elseif rem(cell_position-1,N)+1 == N && ceil(cell_position/N) ~= 1 && ceil(cell_position/N) ~= M
                        if death_matrix(N,ceil(cell_position/N)-1) == 2 ...
                        || death_matrix(N,ceil(cell_position/N)+1) == 2 ...
                        || death_matrix(N-1,ceil(cell_position/N)) == 2 ...
                        || death_matrix(1,ceil(cell_position/N)) == 2 ...
                        || death_matrix(N,ceil(cell_position/N)-1) == 7 ...
                        || death_matrix(N,ceil(cell_position/N)+1) == 7 ...
                        || death_matrix(N-1,ceil(cell_position/N)) == 7 ...
                        || death_matrix(1,ceil(cell_position/N)) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,ceil(cell_position/N)-1) == 2 ... 
                                || cancervariable.statematrix(N,ceil(cell_position/N)-1) == 7)
                                glucose(1) = cancervariable.glucosematrix(N,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(N,ceil(cell_position/N)+1) == 2 ...
                                    || cancervariable.statematrix(N,ceil(cell_position/N)+1) == 7)
                                glucose(2) = cancervariable.glucosematrix(N,ceil(cell_position/N)+1);
                            end
                            if(cancervariable.statematrix(N-1,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(N-1,ceil(cell_position/N)) == 7)
                                glucose(3) = cancervariable.glucosematrix(N-1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(1,ceil(cell_position/N)) == 2 ...
                                    || cancervariable.statematrix(1,ceil(cell_position/N)) == 7)
                                glucose(4) = cancervariable.glucosematrix(1,ceil(cell_position/N));
                            end
                                
                            a = find(max(glucose) == glucose);
                                
                            if a == 1
                                state_matrix(N,ceil(cell_position/N)-1) = 4;
                            elseif a == 2
                                state_matrix(N,ceil(cell_position/N)+1) = 4;
                            elseif a == 3
                                state_matrix(N-1,ceil(cell_position/N)) = 4;
                            elseif a == 4
                                state_matrix(1,ceil(cell_position/N)) = 4;    
                            end
                        end
     
                    %LEFT
                    elseif ceil(cell_position/N) == 1 && rem(cell_position-1,N)+1 ~= 1 && rem(cell_position-1,N)+1 ~= N
                        if death_matrix(rem(cell_position-1,N)+1-1,1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,M) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,2) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1-1,1) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,M) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,1) == 7 ...
                            || death_matrix(rem(cell_position-1,N)+1,2) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1,1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1-1,1) == 7)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1,1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,M) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,M) == 7)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,1) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1+1,1) == 7)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,2) == 2 ...
                                    || cancervariable.statematrix(rem(cell_position-1,N)+1,2) == 7)
                                glucose(4) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,2);
                            end
                                
                            a = find(max(glucose) == glucose);
                                 
                            if a == 1
                                state_matrix(rem(cell_position-1,N)+1-1,1) = 4;
                            elseif a == 2
                                state_matrix(rem(cell_position-1,N)+1,M) = 4;
                            elseif a == 3
                                state_matrix(rem(cell_position-1,N)+1+1,1) = 4;
                            elseif a == 4
                                state_matrix(rem(cell_position-1,N)+1,2) = 4;    
                            end
                        end 
        
                %DIVIDING CELLS - CORNERS
    
                    elseif rem(cell_position-1,N)+1 == 1 && ceil(cell_position/N) == 1
                        if death_matrix(1,2) == 2 ...
                            || death_matrix(2,1) == 2 ...
                            || death_matrix(N,1) == 2 ...
                            || death_matrix(1,M) == 2 ...
                            || death_matrix(1,2) == 7 ...
                            || death_matrix(2,1) == 7 ...
                            || death_matrix(N,1) == 7 ...
                            || death_matrix(1,M) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,2) == 2 || cancervariable.statematrix(1,2) == 7)
                                glucose(1) = cancervariable.glucosematrix(1,2);
                            end
                            if(cancervariable.statematrix(2,1) == 2 || cancervariable.statematrix(2,1) == 7)
                                glucose(2) = cancervariable.glucosematrix(2,1);
                            end
                            if(cancervariable.statematrix(N,1) == 2 || cancervariable.statematrix(N,1) == 7)
                                glucose(3) = cancervariable.glucosematrix(N,1);
                            end
                            if(cancervariable.statematrix(1,M) == 2 || cancervariable.statematrix(1,M) == 7)
                                glucose(4) = cancervariable.glucosematrix(1,M);
                            end
                            
                            a = find(max(glucose) == glucose);
                            
                            
                            if a == 1
                                state_matrix(1,2) = 4;
                            elseif a == 2
                                state_matrix(2,1) = 4;
                            elseif a == 3
                                state_matrix(N,1) = 4;
                            elseif a == 4
                                state_matrix(1,M) = 4;    
                            end
                        end
        
                    elseif rem(cell_position-1,N)+1 == 1 && ceil(cell_position/N) == M
                        if death_matrix(1,1) == 2 ...
                            || death_matrix(2, M) == 2 ...
                            || death_matrix(N,M) == 2 ...
                            || death_matrix(1,M-1) == 2 ...
                            || death_matrix(1,1) == 7 ...
                            || death_matrix(2, M) == 7 ...
                            || death_matrix(N,M) == 7 ...
                            || death_matrix(1,M-1) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,1) == 2 || cancervariable.statematrix(1,1) == 7)
                                glucose(1) = cancervariable.glucosematrix(1,1);
                            end
                            if(cancervariable.statematrix(2, M) == 2 || cancervariable.statematrix(2, M) == 7)
                                glucose(2) = cancervariable.glucosematrix(2, M);
                            end
                            if(cancervariable.statematrix(N,M) == 2 || cancervariable.statematrix(N,M) == 7)
                                glucose(3) = cancervariable.glucosematrix(N,M);
                            end
                            if(cancervariable.statematrix(1,M-1) == 2 || cancervariable.statematrix(1,M-1) == 7)
                                glucose(4) = cancervariable.glucosematrix(1,M-1);
                            end
                                
                            a = find(max(glucose) == glucose);
                                 
                            if a == 1
                                state_matrix(1,1) = 4;
                            elseif a == 2
                                state_matrix(2,M) = 4;
                            elseif a == 3
                                state_matrix(N,M) = 4;
                            elseif a == 4
                                state_matrix(1,M-1) = 4;    
                            end
                        end
        
        
                    elseif rem(cell_position-1,N)+1 == N && ceil(cell_position/N) == 1
                        if death_matrix(N,2) == 2 ...
                            || death_matrix(1,1) == 2 ...
                            || death_matrix(N-1,1) == 2 ...
                            || death_matrix(N,M) == 2 ...
                            || death_matrix(N,2) == 7 ...
                            || death_matrix(1,1) == 7 ...
                            || death_matrix(N-1,1) == 7 ...
                            || death_matrix(N,M) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,2) == 2 || cancervariable.statematrix(N,2) == 7)
                                glucose(1) = cancervariable.glucosematrix(N,2);
                            end
                            if(cancervariable.statematrix(1,1) == 2 || cancervariable.statematrix(1,1) == 7)
                                glucose(2) = cancervariable.glucosematrix(1,1);
                            end
                            if(cancervariable.statematrix(N-1,1) == 2 || cancervariable.statematrix(N-1,1) == 7)
                                glucose(3) = cancervariable.glucosematrix(N-1,1);
                            end
                            if(cancervariable.statematrix(N,M) == 2 || cancervariable.statematrix(N,M) == 7)
                                glucose(4) = cancervariable.glucosematrix(N,M);
                            end
                                
                            a = find(max(glucose) == glucose);
                                   
                            if a == 1
                                state_matrix(N,2) = 4;
                            elseif a == 2
                                state_matrix(1,1) = 4;
                            elseif a == 3
                                state_matrix(N-1,1) = 4;
                            elseif a == 4
                                state_matrix(N,M) = 4;    
                            end
                        end
            
                    elseif rem(cell_position-1,N)+1 == N && ceil(cell_position/N) == M
                        if death_matrix(N,1) == 2 ...
                            || death_matrix(1,M) == 2 ...
                            || death_matrix(N-1,M) == 2 ...
                            || death_matrix(N,M-1) == 2 ...
                            || death_matrix(N,1) == 7 ...
                            || death_matrix(1,M) == 7 ...
                            || death_matrix(N-1,M) == 7 ...
                            || death_matrix(N,M-1) == 7
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,1) == 2 || cancervariable.statematrix(N,1) == 7)
                                glucose(1) = cancervariable.glucosematrix(N,1);
                            end
                            if(cancervariable.statematrix(1,M) == 2 || cancervariable.statematrix(1,M) == 7)
                                glucose(2) = cancervariable.glucosematrix(1,M);
                            end
                            if(cancervariable.statematrix(N-1,M) == 2 || cancervariable.statematrix(N-1,M) == 7)
                                glucose(3) = cancervariable.glucosematrix(N-1,M);
                            end
                            if(cancervariable.statematrix(N,M-1) == 2 || cancervariable.statematrix(N,M-1) == 7)
                                glucose(4) = cancervariable.glucosematrix(N,M-1);
                            end
                                
                            a = find(max(glucose) == glucose);
                                  
                            if a == 1
                                state_matrix(N,1) = 4;
                            elseif a == 2
                                state_matrix(1,M) = 4;
                            elseif a == 3
                                state_matrix(N-1,M) = 4;
                            elseif a == 4
                                state_matrix(N,M-1) = 4;    
                            end
                        end
                    end
                end
        
                    
                
                end
        end

end

