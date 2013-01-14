delta = 0.002;
qG = 3e-5;
Gs = 5;
DG = 9.1e-5;
kN = 1e-4;
kT = 1e-3;


N = 10;
Dmat = zeros(N^2,N^2); col = zeros(1,N^2);
bvec = zeros(N^2,1);

%%  constructing the k matrix
%   by forming tensor product of a one-dimensional Gaussian, 
%   then filtering values.

X = linspace(-3,3,N);
Y = exp(-X.*X);
K = Y'*Y;

temp = K;
K(temp>0.5) = kT;
K(temp<=0.5) = kN;

% putting in vessels
V = rand(N);
K(V>0.7) =  0;

pcolor(K);
colorbar;

K = reshape(K,N^2,1);

%% constructing columns WITHOUT boundary conditions

C = (1:N^2)';
Cstar = find(K==0);
[I J] = IJfromC(C,N);

CUp = CfromIJ(adjustBoundary(I-1, N), J, N);
CDown = CfromIJ(adjustBoundary(I+1, N), J, N);
CLeft = CfromIJ(I,  adjustBoundary(J-1, N), N);
CRight = CfromIJ(I,  adjustBoundary(J+1, N), N);

% reusing CfromIJ but this time applying to N^2 dim instead of N dim
Dmat(CfromIJ(C,CUp,N^2)) = 1/delta^2;
Dmat(CfromIJ(C,CDown,N^2)) = 1/delta^2;
Dmat(CfromIJ(C,CLeft,N^2)) = 1/delta^2;
Dmat(CfromIJ(C,CRight,N^2)) = 1/delta^2;
Dmat(CfromIJ(C,C,N^2)) = -4/(delta^2)-K/DG;

Dmat(CfromIJ(Cstar,Cstar,N^2)) = 1;
% bvec(Cstar) = 1; % not sure here

%% above of vessel

% Itemp = adjustBoundary(I(Cstar)-1, N); Jtemp = J(Cstar);
% 
% CUp = CfromIJ(adjustBoundary(Itemp-1, N), Jtemp, N);
% CLeft = CfromIJ(Itemp,  adjustBoundary(Jtemp-1, N), N);
% CRight = CfromIJ(Itemp,  adjustBoundary(Jtemp+1, N), N);
% Dmat(CfromIJ(Cstar,CUp,N^2)) = 1/delta^2;
% Dmat(CfromIJ(Cstar,CLeft,N^2)) = 1/delta^2;
% Dmat(CfromIJ(Cstar,CRight,N^2)) = 1/delta^2;
% 
% %% below of vessel
% 
% Itemp = adjustBoundary(I(Cstar)+1, N); Jtemp = J(Cstar);
% CDown = CfromIJ(adjustBoundary(Itemp+1, N), Jtemp, N);
% CLeft = CfromIJ(Itemp,  adjustBoundary(Jtemp-1, N), N);
% CRight = CfromIJ(Itemp,  adjustBoundary(Jtemp+1, N), N);
% Dmat(CfromIJ(Cstar,CDown,N^2)) = 1/delta^2;
% Dmat(CfromIJ(Cstar,CLeft,N^2)) = 1/delta^2;
% Dmat(CfromIJ(Cstar,CRight,N^2)) = 1/delta^2;
% 
% %% left of vessel
% 
% Itemp = I(Cstar); Jtemp = adjustBoundary(J(Cstar)-1, N);
% CUp = CfromIJ(adjustBoundary(Itemp-1, N), Jtemp, N);
% CDown = CfromIJ(adjustBoundary(Itemp+1, N), Jtemp, N);
% CLeft = CfromIJ(Itemp,  adjustBoundary(Jtemp-1, N), N);
% Dmat(CfromIJ(Cstar,CUp,N^2)) = 1/delta^2;
% Dmat(CfromIJ(Cstar,CDown,N^2)) = 1/delta^2;
% Dmat(CfromIJ(Cstar,CLeft,N^2)) = 1/delta^2;
% 
% %% right of vessel
% 
% Itemp = I(Cstar); Jtemp = adjustBoundary(J(Cstar)+1, N);
% CUp = CfromIJ(adjustBoundary(Itemp-1, N), Jtemp, N);
% CDown = CfromIJ(adjustBoundary(Itemp+1, N), Jtemp, N);
% CRight = CfromIJ(Itemp,  adjustBoundary(Jtemp+1, N), N);
% Dmat(CfromIJ(Cstar,CUp,N^2)) = 1/delta^2;
% Dmat(CfromIJ(Cstar,CDown,N^2)) = 1/delta^2;
% Dmat(CfromIJ(Cstar,CRight,N^2)) = 1/delta^2;
% 


pcolor(Dmat);
colorbar;



% 
% for i=1:N^2
%     Dmat(C(i), CUp(i)) = 1/delta^2;
%     Dmat(C(i), CDown(i)) = 1/delta^2;
%     Dmat(C(i), CLeft(i)) = 1/delta^2;
%     Dmat(C(i), CRight(i)) = 1/delta^2;
%     Dmat(C(i), C(i)) = -4/(delta^2)-K(C(i))/DG;
% end
% Dmat


% col = zeros(1,N^2); 
% col(CfromIJ(    adjustBoundary(I-1, N), J, N)) = 1/delta^2;
% Dmat(C, :) = col;
% Dmat(C, CfromIJ(    adjustBoundary(I+1, N), J, N)) = 1/delta^2;
% Dmat(C, CfromIJ(I,  adjustBoundary(J-1, N), N)) = 1/delta^2;
% Dmat(C, CfromIJ(I,  adjustBoundary(J+1, N), N)) = 1/delta^2;
% Dmat(C,C) = -4/(delta^2)-K(C)/DG;


% for C=1:(N^2)
%     Dmat(C, :) = colConstruct(C,K, N, DG, delta);
% end
% Dmat;
% 
% figure(1);
% spy(diag(K));
% 
% % G = Dmat\ones(N^2,1)
% 
% for C=1:(N^2)
%    if(K(C) == 1)
%       [I J] = IJfromC(C,N);
% 
%       % left, right, above, below the vessel
%   
%       Itemp = I; Jtemp = adjustBoundary(J-1, N);
%       Dmat(CfromIJ(Itemp, Jtemp, N), :) = colLeftOfVessel(CfromIJ(Itemp, Jtemp, N), K, B, N, delta, DG, qG, Gs);
%       B(CfromIJ(Itemp, Jtemp, N)) = -qG*delta*Gs/DG;
%       
%       Itemp = I; Jtemp = adjustBoundary(J+1, N);
%       Dmat(CfromIJ(Itemp, Jtemp, N), :) = colRightOfVessel(CfromIJ(Itemp, Jtemp, N), K, B, N, delta, DG, qG, Gs);
%       B(CfromIJ(Itemp, Jtemp, N)) = -qG*delta*Gs/DG;
% 
%       Itemp = adjustBoundary(I+1, N); Jtemp = J;
%       Dmat(CfromIJ(Itemp, Jtemp, N), :) = colBelowOfVessel(CfromIJ(Itemp, Jtemp, N), K, B, N, delta, DG, qG, Gs);
%       B(CfromIJ(Itemp, Jtemp, N)) = -qG*delta*Gs/DG;
%       
%       Itemp = adjustBoundary(I-1, N); Jtemp = J;
%       Dmat(CfromIJ(Itemp, Jtemp, N), :) = colAboveOfVessel(CfromIJ(Itemp, Jtemp, N), K, B, N, delta, DG, qG, Gs);
%       B(CfromIJ(Itemp, Jtemp, N)) = -qG*delta*Gs/DG;
%       
%       Dmat(C,:) = zeros(N^2,1);
%       Dmat(C,C) = 1;
%       B(C) = 1;
% 
%    end
%     
% end
% 
% 
% % inversion and plot
% G = Dmat \ B;
% Gmat = zeros(N,N);
% 
% for C=1:(N^2)
%    [I, J] = IJfromC(C, N);
%    Gmat(I,J) = G(C);
% end
% 
% figure(2);
% pcolor(Gmat);
% colorbar;