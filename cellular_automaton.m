function [state_matrix] = cellular_automaton(cancervariable)

N = cancervariable.matrixrownumber;
M = cancervariable.matrixcolnumber;
state_matrix = cancervariable.statematrix;
f = cancervariable.f;

%cancervariable.noofogenerations
%cancervariable.GdN
%cancervariable.GdT
%cancervariable.pHdN
%cancervariable.pHdT
%cancervariable.pHqN
%cancervariable.pHqT

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
        for i = 1:((N*M)/ceil(1/f))
            for j = 1:ceil(1/f)
                
                if ((i-1)*ceil(1/f) + j) <= N*M
                  cell_position = vector_random((i-1)*ceil(1/f) + j);
       
                %SELECT NORMAL
        
                    if state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 3 || state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 6
    
                        %LOW pH AND LOW GLUCOSE LEVEL KILLS CELLS
    
                        if cancervariable.glucosematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.GdN 
    
                             state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 2;

                        elseif cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.pHdN 
    
                            state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 2;
                            
                        elseif cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.pHqN 
                            
                            state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 6;
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
                            || death_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) == 2)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) == 2)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) == 2)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 2)
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
                            || death_matrix(N,ceil(cell_position/N)) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,ceil(cell_position/N)-1) == 2)
                                glucose(1) = cancervariable.glucosematrix(1,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(1,ceil(cell_position/N)+1) == 2)
                                glucose(2) = cancervariable.glucosematrix(1,ceil(cell_position/N)+1);
                            end
                            if(cancervariable.statematrix(2,ceil(cell_position/N)) == 2)
                                glucose(3) = cancervariable.glucosematrix(2,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(N,ceil(cell_position/N)) == 2)
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
                            || death_matrix(rem(cell_position-1,N)+1,1) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1 , M) == 2)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1 , M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,M-1) == 2)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,M-1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,M) == 2)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,1) == 2)
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
                        || death_matrix(1,ceil(cell_position/N)) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,ceil(cell_position/N)-1) == 2)
                                glucose(1) = cancervariable.glucosematrix(N,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(N,ceil(cell_position/N)+1) == 2)
                                glucose(2) = cancervariable.glucosematrix(N,ceil(cell_position/N)+1);
                            end
                            if(cancervariable.statematrix(N-1,ceil(cell_position/N)) == 2)
                                glucose(3) = cancervariable.glucosematrix(N-1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(1,ceil(cell_position/N)) == 2)
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
                            || death_matrix(rem(cell_position-1,N)+1,2) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1,1) == 2)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1,1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,M) == 2)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,1) == 2)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,2) == 2)
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
                            || death_matrix(1,M) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,2) == 2)
                                glucose(1) = cancervariable.glucosematrix(1,2);
                            end
                            if(cancervariable.statematrix(2,1) == 2)
                                glucose(2) = cancervariable.glucosematrix(2,1);
                            end
                            if(cancervariable.statematrix(N,1) == 2)
                                glucose(3) = cancervariable.glucosematrix(N,1);
                            end
                            if(cancervariable.statematrix(1,M) == 2)
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
                            || death_matrix(1,M-1) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,1) == 2)
                                glucose(1) = cancervariable.glucosematrix(1,1);
                            end
                            if(cancervariable.statematrix(2, M) == 2)
                                glucose(2) = cancervariable.glucosematrix(2, M);
                            end
                            if(cancervariable.statematrix(N,M) == 2)
                                glucose(3) = cancervariable.glucosematrix(N,M);
                            end
                            if(cancervariable.statematrix(1,M-1) == 2)
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
                            || death_matrix(N,M) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,2) == 2)
                                glucose(1) = cancervariable.glucosematrix(N,2);
                            end
                            if(cancervariable.statematrix(1,1) == 2)
                                glucose(2) = cancervariable.glucosematrix(1,1);
                            end
                            if(cancervariable.statematrix(N-1,1) == 2)
                                glucose(3) = cancervariable.glucosematrix(N-1,1);
                            end
                            if(cancervariable.statematrix(N,M) == 2)
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
                            || death_matrix(N,M-1) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,1) == 2)
                                glucose(1) = cancervariable.glucosematrix(N,1);
                            end
                            if(cancervariable.statematrix(1,M) == 2)
                                glucose(2) = cancervariable.glucosematrix(1,M);
                            end
                            if(cancervariable.statematrix(N-1,M) == 2)
                                glucose(3) = cancervariable.glucosematrix(N-1,M);
                            end
                            if(cancervariable.statematrix(N,M-1) == 2)
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
                    
                    if (state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 6 && cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) > cancervariable.pHqN)
    
                        state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 3;
                    end
                    
                    %SELECT TUMOR ACTIVE
        
                if state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 4 || state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 5
    
                        %LOW pH AND LOW GLUCOSE LEVEL KILLS CELLS
    
                    if cancervariable.glucosematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.GdT 
    
                        state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 2;

                    elseif cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.pHdT 
    
                        state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 2;
                                        
                    elseif cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) < cancervariable.pHqT
    
                        state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 5;
                    end
                end
                
                
                
                if state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 4 && cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) > cancervariable.pHqT
                        %CENTRAL GRID DIVIDING
                    if ceil(cell_position/N) ~= 1 && ceil(cell_position/N) ~= M && rem(cell_position-1,N)+1 ~= 1 && rem(cell_position-1,N)+1 ~= N 
       
                        if death_matrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) == 2 ...
                            || death_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N)) == 2)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1) == 2)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N)) == 2)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,ceil(cell_position/N)+1) == 2)
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
                            || death_matrix(N,ceil(cell_position/N)) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,ceil(cell_position/N)-1) == 2)
                                glucose(1) = cancervariable.glucosematrix(1,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(1,ceil(cell_position/N)+1) == 2)
                                glucose(2) = cancervariable.glucosematrix(1,ceil(cell_position/N)+1);
                            end
                            if(cancervariable.statematrix(2,ceil(cell_position/N)) == 2)
                                glucose(3) = cancervariable.glucosematrix(2,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(N,ceil(cell_position/N)) == 2)
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
                            || death_matrix(rem(cell_position-1,N)+1,1) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1 , M) == 2)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1 , M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,M-1) == 2)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,M-1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,M) == 2)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,1) == 2)
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
                            || death_matrix(1,ceil(cell_position/N)) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,ceil(cell_position/N)-1) == 2)
                                glucose(1) = cancervariable.glucosematrix(N,ceil(cell_position/N)-1);
                            end
                            if(cancervariable.statematrix(N,ceil(cell_position/N)+1) == 2)
                                glucose(2) = cancervariable.glucosematrix(N,ceil(cell_position/N)+1);
                            end
                            if(cancervariable.statematrix(N-1,ceil(cell_position/N)) == 2)
                                glucose(3) = cancervariable.glucosematrix(N-1,ceil(cell_position/N));
                            end
                            if(cancervariable.statematrix(1,ceil(cell_position/N)) == 2)
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
                            || death_matrix(rem(cell_position-1,N)+1,2) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1-1,1) == 2)
                                glucose(1) = cancervariable.glucosematrix(rem(cell_position-1,N)+1-1,1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,M) == 2)
                                glucose(2) = cancervariable.glucosematrix(rem(cell_position-1,N)+1,M);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1+1,1) == 2)
                                glucose(3) = cancervariable.glucosematrix(rem(cell_position-1,N)+1+1,1);
                            end
                            if(cancervariable.statematrix(rem(cell_position-1,N)+1,2) == 2)
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
                            || death_matrix(1,M) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,2) == 2)
                                glucose(1) = cancervariable.glucosematrix(1,2);
                            end
                            if(cancervariable.statematrix(2,1) == 2)
                                glucose(2) = cancervariable.glucosematrix(2,1);
                            end
                            if(cancervariable.statematrix(N,1) == 2)
                                glucose(3) = cancervariable.glucosematrix(N,1);
                            end
                            if(cancervariable.statematrix(1,M) == 2)
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
                            || death_matrix(1,M-1) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(1,1) == 2)
                                glucose(1) = cancervariable.glucosematrix(1,1);
                            end
                            if(cancervariable.statematrix(2, M) == 2)
                                glucose(2) = cancervariable.glucosematrix(2, M);
                            end
                            if(cancervariable.statematrix(N,M) == 2)
                                glucose(3) = cancervariable.glucosematrix(N,M);
                            end
                            if(cancervariable.statematrix(1,M-1) == 2)
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
                            || death_matrix(N,M) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,2) == 2)
                                glucose(1) = cancervariable.glucosematrix(N,2);
                            end
                            if(cancervariable.statematrix(1,1) == 2)
                                glucose(2) = cancervariable.glucosematrix(1,1);
                            end
                            if(cancervariable.statematrix(N-1,1) == 2)
                                glucose(3) = cancervariable.glucosematrix(N-1,1);
                            end
                            if(cancervariable.statematrix(N,M) == 2)
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
                            || death_matrix(N,M-1) == 2
        
                            glucose = zeros(4,1);
                            if(cancervariable.statematrix(N,1) == 2)
                                glucose(1) = cancervariable.glucosematrix(N,1);
                            end
                            if(cancervariable.statematrix(1,M) == 2)
                                glucose(2) = cancervariable.glucosematrix(1,M);
                            end
                            if(cancervariable.statematrix(N-1,M) == 2)
                                glucose(3) = cancervariable.glucosematrix(N-1,M);
                            end
                            if(cancervariable.statematrix(N,M-1) == 2)
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
        
                    
                    
                    if (state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) == 5 && cancervariable.pHmatrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) > cancervariable.pHqT)
    
                        state_matrix(rem(cell_position-1,N)+1,ceil(cell_position/N)) = 4;
                    end
                
                end
            end
        end
        automatonTime = automatonTime + toc;
        
    end
    
    cancervariable.statematrix = state_matrix;
    %visualise solution at ever 10 generation
    generation = cancervariable.currentgeneration
    solvingTime
    automatonTime
    if(rem(cancervariable.currentgeneration,10) == 1)
        visualise(cancervariable);
    end
end
