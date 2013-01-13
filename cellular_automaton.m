function [state_matrix] = cellular_automaton(cancervariable)

N = cancervariable.matrixrownumber;
M = cancervariable.matrixcolnumber;
state_matrix = cancervariable.statematrix;
f = cancervariable.f;

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
        
    end
    
    cancervariable.statematrix = state_matrix;
    %visualise solution at ever 10 generation
    generation = cancervariable.currentgeneration
    solvingTime
    automatonTime
    cancervariable.radiusOfGyration(k) = radiusOfGyration(cancervariable);
    if(rem(cancervariable.currentgeneration,10) == 1)
        visualise(cancervariable);
        figure;
        plot(cancervariable.radiusOfGyration(1:cancervariable.currentgeneration));
        title(['radius of gyration (HA = ' num2str(cancervariable.hr(4))  ') until generation ' num2str(cancervariable.currentgeneration)])
        
    end
end

