F_known = [0; 2; 2];%matrix of nodal forces %0 values are unknowns %nan are known but equal to zero
F_zero = [12131; 12131; 12131];%matrix of zero nodal forces is known %non-zero values are either unknown forces or externally applied ones
U = [0; nan; nan];%matrix of nodal displacements %NaN values are unknown
umax = 1;%maximum elastic deformation of a spring
k = 1;%stiffness of a single spring
ele_node = [1 2; 2 3; 1 3];%matrix of node numbering for elements from 1 to e
n = 3;%number of nodes
n_spring = 1000;%number of extra springs available %in case of unlimited springs input a large number

y = OptimizeParallelClusterofSprings(F_known, F_zero, U, umax, k, ele_node, n, n_spring);