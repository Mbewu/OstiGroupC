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

    vector_random = randperm(N*M);
    
    %SUBGENERATIONS
    for n = 1:ceil(1/f)
        death_matrix = state_matrix;
        %%%%%%%ENTER GLUCOSE FUNCTION%%%%%%%%%%%
        %%%%%%%ENTER LACTIC ACID FUNCTION%%%%%%%%%%%
        for i = 1:((N*M)/ceil(1/f))
            for j = 1:ceil(1/f)
                
                if ((i-1)*ceil(1/f) + j)> N*M
                cell_position = vector_random((i-1)*ceil(1/f) + j);
       
                %SELECT NORMAL
        
                    if state_matrix(rem(cell_position,N),ceil(cell_position/N)) == 3 
    
                        %LOW pH AND LOW GLUCOSE LEVEL KILLS CELLS
    
                            if cancervariable.glucosematrix(rem(cell_position,N),ceil(cell_position/N)) < cancervariable.GdN 
    
                         state_matrix(rem(cell_position,N),ceil(cell_position/N)) = 2;

                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) < cancervariable.pHdN 
    
                        state_matrix(rem(cell_position,N),ceil(cell_position/N)) = 2;
    
                        %HIGH pH ALLOWS CELLS TO DIVIDE - CELL DIVIDES INTO FREE SPACE WITH HIGHEST
                        %GLUCOSE CONCENTRATION IF AVAILABLE
                        
                        %CENTRAL GRID DIVIDING
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                        && ceil(cell_position/N) ~= 1 || cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                        && ceil(cell_position/N) ~= M || cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                        && rem(cell_position,N) ~= 1 || cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                        && rem(cell_position,N) ~= N 
       
                        if death_matrix(rem(cell_position,N)-1,ceil(cell_position/N)) == 2 ...
                            || death_matrix(rem(cell_position,N),ceil(cell_position/N)-1) == 2 ...
                            || death_matrix(rem(cell_position,N)+1,ceil(cell_position/N)) == 2 ...
                            || death_matrix(rem(cell_position,N),ceil(cell_position/N)+1) == 2
        
                            a = find(max([cancervariable.glucosematrix(rem(cell_position,N)-1,ceil(cell_position/N)),cancervariable.glucosematrix(rem(cell_position,N),ceil(cell_position/N)-1),cancervariable.glucosematrix(rem(cell_position,N)+1,ceil(cell_position/N)),cancervariable.glucosematrix(rem(cell_position,N),ceil(cell_position/N)+1)]) ...
                            == [cancervariable.glucosematrix(rem(cell_position,N)-1,ceil(cell_position/N)),cancervariable.glucosematrix(rem(cell_position,N),ceil(cell_position/N)-1),cancervariable.glucosematrix(rem(cell_position,N)+1,ceil(cell_position/N)),cancervariable.glucosematrix(rem(cell_position,N),ceil(cell_position/N)+1)]);
            
                            if a == 1
                                state_matrix(rem(cell_position,N)-1,ceil(cell_position/N)) = 3;
                            elseif a == 2
                                state_matrix(rem(cell_position,N),ceil(cell_position/N)-1) = 3;
                            elseif a == 3
                                state_matrix(rem(cell_position,N)+1,ceil(cell_position/N)) = 3;
                            elseif a == 4
                                state_matrix(rem(cell_position,N),ceil(cell_position/N)+1) = 3;    
                            end
                        end
                        
                        
        
                    %DIVIDING CELLS - SIDES
                    %TOP   
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                        && rem(cell_position,N) == 1 && ceil(cell_position/N) ~= 1 || rem(cell_position,N) == 1 && ceil(cell_position/N) ~= M
                        if death_matrix(1,ceil(cell_position/N)-1) == 2 ...
                            || death_matrix(1,ceil(cell_position/N)+1) == 2 ...
                            || death_matrix(2,ceil(cell_position/N)) == 2 ...
                            || death_matrix(N,ceil(cell_position/N)) == 2
        
                            a = find(max([cancervariable.glucosematrix(1,ceil(cell_position/N)-1),cancervariable.glucosematrix(1,ceil(cell_position/N)+1),cancervariable.glucosematrix(2,ceil(cell_position/N)),cancervariable.glucosematrix(N,ceil(cell_position/N))]) ...
                            == [cancervariable.glucosematrix(1,ceil(cell_position/N)-1),cancervariable.glucosematrix(1,ceil(cell_position/N)+1),cancervariable.glucosematrix(2,ceil(cell_position/N)),cancervariable.glucosematrix(N,ceil(cell_position/N))]);
            
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
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                        && ceil(cell_position/N) == M && rem(cell_position,N) ~= 1 || ceil(cell_position/N) == M && rem(cell_position,N) ~= N
                        if death_matrix(rem(cell_position,N)-1 , M) == 2 ...
                            || death_matrix(rem(cell_position,N),M-1) == 2 ...
                            || death_matrix(rem(cell_position,N)+1,M) == 2 ...
                            || death_matrix(rem(cell_position,N),1) == 2
        
                            a = find(max([cancervariable.glucosematrix(rem(cell_position,N)-1 , M),cancervariable.glucosematrix(rem(cell_position,N),M-1),cancervariable.glucosematrix(rem(cell_position,N)+1,M),cancervariable.glucosematrix(rem(cell_position,N),1)]) ...
                            == [cancervariable.glucosematrix(rem(cell_position,N)-1 , M),cancervariable.glucosematrix(rem(cell_position,N),M-1),cancervariable.glucosematrix(rem(cell_position,N)+1,M),cancervariable.glucosematrix(rem(cell_position,N),1)]);
            
                            if a == 1
                                state_matrix(rem(cell_position,N)-1,M) = 3;
                            elseif a == 2
                                state_matrix(rem(cell_position,N),M-1) = 3;
                            elseif a == 3
                                state_matrix(rem(cell_position,N)+1,M) = 3;
                            elseif a == 4
                                state_matrix(rem(cell_position,N),1) = 3;    
                            end
                        end  
        
                    %BOTTOM   
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                        && rem(cell_position,N) == N && ceil(cell_position/N) ~= 1 || rem(cell_position,N) == N && ceil(cell_position/N) ~= M
                        if death_matrix(N,ceil(cell_position/N)-1) == 2 ...
                        || death_matrix(N,ceil(cell_position/N)+1) == 2 ...
                        || death_matrix(N-1,ceil(cell_position/N)) == 2 ...
                        || death_matrix(1,ceil(cell_position/N)) == 2
        
                        a = find(max([cancervariable.glucosematrix(N,ceil(cell_position/N)-1),cancervariable.glucosematrix(N,ceil(cell_position/N)+1),cancervariable.glucosematrix(N-1,ceil(cell_position/N)),cancervariable.glucosematrix(1,ceil(cell_position/N))]) ...
                         == [cancervariable.glucosematrix(N,ceil(cell_position/N)-1),cancervariable.glucosematrix(N,ceil(cell_position/N)+1),cancervariable.glucosematrix(N-1,ceil(cell_position/N)),cancervariable.glucosematrix(1,ceil(cell_position/N))]);
            
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
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                        && ceil(cell_position/N) == 1 && rem(cell_position,N) ~= 1 || ceil(cell_position/N) == 1 && rem(cell_position,N) ~= N
                        if death_matrix(rem(cell_position,N)-1,1) == 2 ...
                            || death_matrix(rem(cell_position,N),M) == 2 ...
                            || death_matrix(rem(cell_position,N)+1,1) == 2 ...
                            || death_matrix(rem(cell_position,N),2) == 2
        
                            a = find(max([cancervariable.glucosematrix(rem(cell_position,N)-1 , 1),cancervariable.glucosematrix(rem(cell_position,N),M),cancervariable.glucosematrix(rem(cell_position,N)+1,1),cancervariable.glucosematrix(rem(cell_position,N),2)]) ...
                            == [cancervariable.glucosematrix(rem(cell_position,N)-1 , 1),cancervariable.glucosematrix(rem(cell_position,N),M),cancervariable.glucosematrix(rem(cell_position,N)+1,1),cancervariable.glucosematrix(rem(cell_position,N),2)]);
            
                            if a == 1
                                state_matrix(rem(cell_position,N)-1,1) = 3;
                            elseif a == 2
                                state_matrix(rem(cell_position,N),M) = 3;
                            elseif a == 3
                                state_matrix(rem(cell_position,N)+1,1) = 3;
                            elseif a == 4
                                state_matrix(rem(cell_position,N),2) = 3;    
                            end
                        end 
        
                                   
                    %DIVIDING CELLS - CORNERS
    
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                        && rem(cell_position,N) == 1 && ceil(cell_position/N) == 1
                         if death_matrix(1,2) == 2 ...
                            || death_matrix(2,1) == 2 ...
                            || death_matrix(N,1) == 2 ...
                            || death_matrix(1,M) == 2
        
                                a = find(max([cancervariable.glucosematrix(1,2),cancervariable.glucosematrix(2,1),cancervariable.glucosematrix(N,1),cancervariable.glucosematrix(1,M)]) ...
                                     == [cancervariable.glucosematrix(1,2),cancervariable.glucosematrix(2,1),cancervariable.glucosematrix(N,1),cancervariable.glucosematrix(1,M)]);
            
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
                         
        
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                        && rem(cell_position,N) == 1 && ceil(cell_position/N) == M
                        if death_matrix(1,1) == 2 ...
                            || death_matrix(2, M) == 2 ...
                            || death_matrix(N,M) == 2 ...
                            || death_matrix(1,M-1) == 2
        
                            a = find(max([cancervariable.glucosematrix(1,1),cancervariable.glucosematrix(2,M),cancervariable.glucosematrix(N,M),cancervariable.glucosematrix(1,M-1)]) ...
                             == [cancervariable.glucosematrix(1,1),cancervariable.glucosematrix(2,M),cancervariable.glucosematrix(N,M),cancervariable.glucosematrix(1,M-1)]);
            
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
        
        
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                     && rem(cell_position,N) == N && ceil(cell_position/N) == 1
                        if death_matrix(N,2) == 2 ...
                            || death_matrix(1,1) == 2 ...
                            || death_matrix(N-1,1) == 2 ...
                            || death_matrix(N,M) == 2
        
                            a = find(max([cancervariable.glucosematrix(N,2),cancervariable.glucosematrix(1,1),cancervariable.glucosematrix(N-1,1),cancervariable.glucosematrix(N,M)]) ...
                            == [cancervariable.glucosematrix(N,2),cancervariable.glucosematrix(1,1),cancervariable.glucosematrix(N-1,1),cancervariable.glucosematrix(N,M)]);
            
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
            
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqN...
                        && rem(cell_position,N) == N && ceil(cell_position/N) == M
                        if death_matrix(N,1) == 2 ...
                            || death_matrix(1,M) == 2 ...
                            || death_matrix(N-1,M) == 2 ...
                            || death_matrix(N,M-1) == 2
        
                            a = find(max([cancervariable.glucosematrix(N,1),cancervariable.glucosematrix(1,M),cancervariable.glucosematrix(N-1,M),cancervariable.glucosematrix(N,M-1)]) ...
                            == [cancervariable.glucosematrix(N,1),cancervariable.glucosematrix(1,M),cancervariable.glucosematrix(N-1,M),cancervariable.glucosematrix(N,M-1)]);
            
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
        
                if state_matrix(rem(cell_position,N),ceil(cell_position/N)) == 4 || state_matrix(rem(cell_position,N),ceil(cell_position/N)) == 5
    
                        %LOW pH AND LOW GLUCOSE LEVEL KILLS CELLS
    
                    if cancervariable.glucosematrix(rem(cell_position,N),ceil(cell_position/N)) < cancervariable.GdT 
    
                        state_matrix(rem(cell_position,N),ceil(cell_position/N)) = 2;

                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) < cancervariable.pHdT 
    
                        state_matrix(rem(cell_position,N),ceil(cell_position/N)) = 2;
                        
                        %CENTRAL GRID DIVIDING
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                    && ceil(cell_position/N) ~= 1 || cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                    && ceil(cell_position/N) ~= M || cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                    && rem(cell_position,N) ~= 1 || cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                    && rem(cell_position,N) ~= N 
       
                        if death_matrix(rem(cell_position,N)-1,ceil(cell_position/N)) == 2 ...
                            || death_matrix(rem(cell_position,N),ceil(cell_position/N)-1) == 2 ...
                            || death_matrix(rem(cell_position,N)+1,ceil(cell_position/N)) == 2 ...
                            || death_matrix(rem(cell_position,N),ceil(cell_position/N)+1) == 2
        
                            a = find(max([cancervariable.glucosematrix(rem(cell_position,N)-1,ceil(cell_position/N)),cancervariable.glucosematrix(rem(cell_position,N),ceil(cell_position/N)-1),cancervariable.glucosematrix(rem(cell_position,N)+1,ceil(cell_position/N)),cancervariable.glucosematrix(rem(cell_position,N),ceil(cell_position/N)+1)]) ...
                            == [cancervariable.glucosematrix(rem(cell_position,N)-1,ceil(cell_position/N)),cancervariable.glucosematrix(rem(cell_position,N),ceil(cell_position/N)-1),cancervariable.glucosematrix(rem(cell_position,N)+1,ceil(cell_position/N)),cancervariable.glucosematrix(rem(cell_position,N),ceil(cell_position/N)+1)]);
            
                            if a == 1
                                state_matrix(rem(cell_position,N)-1,ceil(cell_position/N)) = 4;
                            elseif a == 2
                                state_matrix(rem(cell_position,N),ceil(cell_position/N)-1) = 4;
                            elseif a == 3
                                state_matrix(rem(cell_position,N)+1,ceil(cell_position/N)) = 4;
                            elseif a == 4
                                state_matrix(rem(cell_position,N),ceil(cell_position/N)+1) = 4;    
                            end
                        end
    
    
                        
        
                    %DIVIDING CELLS - SIDES
                    %TOP   
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                        && rem(cell_position,N) == 1 && ceil(cell_position/N) ~= 1 || rem(cell_position,N) == 1 && ceil(cell_position/N) ~= M
                        if death_matrix(1,ceil(cell_position/N)-1) == 2 ...
                            || death_matrix(1,ceil(cell_position/N)+1) == 2 ...
                            || death_matrix(2,ceil(cell_position/N)) == 2 ...
                            || death_matrix(N,ceil(cell_position/N)) == 2
        
                            a = find(max([cancervariable.glucosematrix(1,ceil(cell_position/N)-1),cancervariable.glucosematrix(1,ceil(cell_position/N)+1),cancervariable.glucosematrix(2,ceil(cell_position/N)),cancervariable.glucosematrix(N,ceil(cell_position/N))]) ...
                            == [cancervariable.glucosematrix(1,ceil(cell_position/N)-1),cancervariable.glucosematrix(1,ceil(cell_position/N)+1),cancervariable.glucosematrix(2,ceil(cell_position/N)),cancervariable.glucosematrix(N,ceil(cell_position/N))]);
            
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
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                        && ceil(cell_position/N) == M && rem(cell_position,N) ~= 1 || ceil(cell_position/N) == M && rem(cell_position,N) ~= N
                        if death_matrix(rem(cell_position,N)-1 , M) == 2 ...
                            || death_matrix(rem(cell_position,N),M-1) == 2 ...
                            || death_matrix(rem(cell_position,N)+1,M) == 2 ...
                            || death_matrix(rem(cell_position,N),1) == 2
        
                            a = find(max([cancervariable.glucosematrix(rem(cell_position,N)-1 , M),cancervariable.glucosematrix(rem(cell_position,N),M-1),cancervariable.glucosematrix(rem(cell_position,N)+1,M),cancervariable.glucosematrix(rem(cell_position,N),1)]) ...
                            == [cancervariable.glucosematrix(rem(cell_position,N)-1 , M),cancervariable.glucosematrix(rem(cell_position,N),M-1),cancervariable.glucosematrix(rem(cell_position,N)+1,M),cancervariable.glucosematrix(rem(cell_position,N),1)]);
            
                            if a == 1
                                state_matrix(rem(cell_position,N)-1,M) = 4;
                            elseif a == 2
                                state_matrix(rem(cell_position,N),M-1) = 4;
                            elseif a == 3
                                state_matrix(rem(cell_position,N)+1,M) = 4;
                            elseif a == 4
                                state_matrix(rem(cell_position,N),1) = 4;    
                            end
                        end  
        
                    %BOTTOM   
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                        && rem(cell_position,N) == N && ceil(cell_position/N) ~= 1 || rem(cell_position,N) == N && ceil(cell_position/N) ~= M
                        if death_matrix(N,ceil(cell_position/N)-1) == 2 ...
                            || death_matrix(N,ceil(cell_position/N)+1) == 2 ...
                            || death_matrix(N-1,ceil(cell_position/N)) == 2 ...
                            || death_matrix(1,ceil(cell_position/N)) == 2
        
                            a = find(max([cancervariable.glucosematrix(N,ceil(cell_position/N)-1),cancervariable.glucosematrix(N,ceil(cell_position/N)+1),cancervariable.glucosematrix(N-1,ceil(cell_position/N)),cancervariable.glucosematrix(1,ceil(cell_position/N))]) ...
                            == [cancervariable.glucosematrix(N,ceil(cell_position/N)-1),cancervariable.glucosematrix(N,ceil(cell_position/N)+1),cancervariable.glucosematrix(N-1,ceil(cell_position/N)),cancervariable.glucosematrix(1,ceil(cell_position/N))]);
            
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
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                        && ceil(cell_position/N) == 1 && rem(cell_position,N) ~= 1 || ceil(cell_position/N) == 1 && rem(cell_position,N) ~= N
                        if death_matrix(rem(cell_position,N)-1,1) == 2 ...
                            || death_matrix(rem(cell_position,N),M) == 2 ...
                            || death_matrix(rem(cell_position,N)+1,1) == 2 ...
                            || death_matrix(rem(cell_position,N),2) == 2
        
                            a = find(max([cancervariable.glucosematrix(rem(cell_position,N)-1 , 1),cancervariable.glucosematrix(rem(cell_position,N),M),cancervariable.glucosematrix(rem(cell_position,N)+1,1),cancervariable.glucosematrix(rem(cell_position,N),2)]) ...
                            == [cancervariable.glucosematrix(rem(cell_position,N)-1 , 1),cancervariable.glucosematrix(rem(cell_position,N),M),cancervariable.glucosematrix(rem(cell_position,N)+1,1),cancervariable.glucosematrix(rem(cell_position,N),2)]);
            
                            if a == 1
                                state_matrix(rem(cell_position,N)-1,1) = 4;
                            elseif a == 2
                                state_matrix(rem(cell_position,N),M) = 4;
                            elseif a == 3
                                state_matrix(rem(cell_position,N)+1,1) = 4;
                            elseif a == 4
                                state_matrix(rem(cell_position,N),2) = 4;    
                            end
                        end 
        
                %DIVIDING CELLS - CORNERS
    
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                            && rem(cell_position,N) == 1 && ceil(cell_position/N) == 1
                        if death_matrix(1,2) == 2 ...
                            || death_matrix(2,1) == 2 ...
                            || death_matrix(N,1) == 2 ...
                            || death_matrix(1,M) == 2
        
                            a = find(max([cancervariable.glucosematrix(1,2),cancervariable.glucosematrix(2,1),cancervariable.glucosematrix(N,1),cancervariable.glucosematrix(1,M)]) ...
                            == [cancervariable.glucosematrix(1,2),cancervariable.glucosematrix(2,1),cancervariable.glucosematrix(N,1),cancervariable.glucosematrix(1,M)]);
            
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
        
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                            && rem(cell_position,N) == 1 && ceil(cell_position/N) == M
                        if death_matrix(1,1) == 2 ...
                            || death_matrix(2, M) == 2 ...
                            || death_matrix(N,M) == 2 ...
                            || death_matrix(1,M-1) == 2
        
                            a = find(max([cancervariable.glucosematrix(1,1),cancervariable.glucosematrix(2,M),cancervariable.glucosematrix(N,M),cancervariable.glucosematrix(1,M-1)]) ...
                            == [cancervariable.glucosematrix(1,1),cancervariable.glucosematrix(2,M),cancervariable.glucosematrix(N,M),cancervariable.glucosematrix(1,M-1)]);
            
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
        
        
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                        && rem(cell_position,N) == N && ceil(cell_position/N) == 1
                        if death_matrix(N,2) == 2 ...
                            || death_matrix(1,1) == 2 ...
                            || death_matrix(N-1,1) == 2 ...
                            || death_matrix(N,M) == 2
        
                            a = find(max([cancervariable.glucosematrix(N,2),cancervariable.glucosematrix(1,1),cancervariable.glucosematrix(N-1,1),cancervariable.glucosematrix(N,M)]) ...
                            == [cancervariable.glucosematrix(N,2),cancervariable.glucosematrix(1,1),cancervariable.glucosematrix(N-1,1),cancervariable.glucosematrix(N,M)]);
            
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
            
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHqT...
                        && rem(cell_position,N) == N && ceil(cell_position/N) == M
                        if death_matrix(N,1) == 2 ...
                            || death_matrix(1,M) == 2 ...
                            || death_matrix(N-1,M) == 2 ...
                            || death_matrix(N,M-1) == 2
        
                            a = find(max([cancervariable.glucosematrix(N,1),cancervariable.glucosematrix(1,M),cancervariable.glucosematrix(N-1,M),cancervariable.glucosematrix(N,M-1)]) ...
                            == [cancervariable.glucosematrix(N,1),cancervariable.glucosematrix(1,M),cancervariable.glucosematrix(N-1,M),cancervariable.glucosematrix(N,M-1)]);
            
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
        
                    elseif cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) > cancervariable.pHdT && cancervariable.pHmatrix(rem(cell_position,N),ceil(cell_position/N)) < cancervariable.pHqT
    
                        state_matrix(rem(cell_position,N),ceil(cell_position/N)) = 5;
                    end
                end
                end
            end
        end
    end
end
