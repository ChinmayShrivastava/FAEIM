%optimization problem
%parallel connection

%\|
%\|--\/\/\/\/\/\/--|common node
%\|
%\|--\//\/\/\/\/\/--|common node
%\|

% e springs attached parallely to a single node
% to find the optimal number of springs to sustain a given load on the
% common node

e = 0; %number of springs
k = 0.5; %spring stiffness
number = 3;%number of springs available
umax = 1; %maximum elastic deformation

F = 2; %applied load
kinitial = 0; %initial stiffness value of the system

y = OptimizeParallelSpringElements(F, umax, k, number, kinitial);
kequi = y(1); %final stiffness of the structure
efinal = y(2); %final number of spring elements in the structure

%will the structure fail?
if F/kequi>umax
    fail = true;
else
    fail = false;
end