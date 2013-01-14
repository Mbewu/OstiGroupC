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



% Script designed to test whether IJfromC and CfromIJ do what they are
% supposed to. N2, N3, N4 and N5 contain indices I, J in the first two
% columns and C in the third. They have been obtained NOT from code. They
% are used to test whether IJfromC and CfromIJ return the same
% correspondence. 

% This rountine is here only for completeness and because it was once
% helpful. It is now obsolete and not supposed to run correctly any longer.


clear all; clc;

N2 = [  1 1 1
        1 2 2
        2 1 3
        2 2 4       ];
        
N3 = [  1	1	1
        1	2	2
        1	3	3
        2	1	4
        2	2	5
        2	3	6
        3	1	7
        3	2	8
        3	3	9   ];
    
        
N4 = [  1	1	1
        1	2	2
        1	3	3
        1	4	4
        2	1	5
        2	2	6
        2	3	7
        2	4	8
        3	1	9
        3	2	10
        3	3	11
        3	4	12
        4	1	13
        4	2	14
        4	3	15
        4	4	16   ];
    
N5 = [  1	1	1
        1	2	2
        1	3	3
        1	4	4
        1	5	5
        2	1	6
        2	2	7
        2	3	8
        2	4	9
        2	5	10
        3	1	11
        3	2	12
        3	3	13
        3	4	14
        3	5	15
        4	1	16
        4	2	17
        4	3	18
        4	4	19
        4	5	20
        5	1	21
        5	2	22
        5	3	23
        5	4	24
        5	5	25  ];

    
D4=[    -5     1     0     1     1     0     0     0     0     0     0     0     1     0     0     0
         1    -5     1     0     0     1     0     0     0     0     0     0     0     1     0     0
         0     1    -5     1     0     0     1     0     0     0     0     0     0     0     1     0
         1     0     1    -5     0     0     0     1     0     0     0     0     0     0     0     1
         1     0     0     0    -5     1     0     1     1     0     0     0     0     0     0     0
         0     1     0     0     1    -5     1     0     0     1     0     0     0     0     0     0
         0     0     1     0     0     1    -5     1     0     0     1     0     0     0     0     0
         0     0     0     1     1     0     1    -5     0     0     0     1     0     0     0     0
         0     0     0     0     1     0     0     0    -5     1     0     1     1     0     0     0
         0     0     0     0     0     1     0     0     1    -5     1     0     0     1     0     0
         0     0     0     0     0     0     1     0     0     1    -5     1     0     0     1     0
         0     0     0     0     0     0     0     1     1     0     1    -5     0     0     0     1
         1     0     0     0     0     0     0     0     1     0     0     0    -5     1     0     1
         0     1     0     0     0     0     0     0     0     1     0     0     1    -5     1     0
         0     0     1     0     0     0     0     0     0     0     1     0     0     1    -5     1
         0     0     0     1     0     0     0     0     0     0     0     1     1     0     1    -5 ];   
    

N = 5;
CfromIJ(N5(:,1), N5(:,2), N)== N5(:,3)

N = 4;
Ncurr = N4;

for i=1:(N^2)
    [I J] = IJfromC(i, N);
    [I(1) J(1)] == [Ncurr(i,1) Ncurr(i,2)]

end


