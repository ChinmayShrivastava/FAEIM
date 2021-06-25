%optimizing spring clusters that are set to fail
%cluster is nothing but any combination of springs connected between two
%nodes
%this project addresses complex arrangements of springs

%==========================================================================
%information of the structure
%All springs here have same physical properties
%==========================================================================
k = 0;%stiffness of a single spring
e = 0;%number of elements
n = 0;%number of nodes
ele_node = zeros(e, 2);%matrix of node numbering for elements from 1 to e
Ke = zeros(e, 1) + k;%initialising matrix to store element stiffness equal to k each
K = zeros(n);%initialising the global stiffness matrix
F = zeros(n, 1);%matrix of nodal forces %NaN values are unknowns
U = zeros(n, 1);%matrix of nodal displacements %NaN values are unknown
Fe = zeros(e, 1);%initilising matrix to store elemental force
Ue = zeros(e, 2);%initialising the elemental displacements for each element
umax = 0;%maximum elastic deformation of a spring
n_spring = 0;%number of extra springs available %in case of unlimited springs input a large number

%assembling the global stiffness matrix K and assigning the elemental
%stiffness values to Ke
for i = 1:e
    K = SpringAssemble(K, Ke(i), ele_node(i, 1), ele_node(i, 2));
end

index_known_forces = find(F);
f_temp = zeros(length(index_known_forces), 1);
for i = 1:length(index_known_forces)
    f_temp(i) = F(index_known_forces(i));
end

index_unknown_displacements = find(U);

k_temp = zeros(length(index_unknown_displacements), length(index_known_forces));
for i = 1:length(index_unknown_displacements)
    for j = 1:length(index_known_forces)
        k_temp(i, j) = K(index_unknown_displacements(i), index_known_forces(j));
    end
end

u_temp = k_temp\f_temp;

for i = 1:length(u_temp)
    U(index_unknown_displacements(i)) = u_temp(i);
end

F = K*U;

for i = 1:e
    Ue(i, 1) = U(ele_node(i, 1));
    Ue(i, 2) = U(ele_node(i, 2));
    ue = [Ue(i, 1); Ue(i, 2)];
    Fe(i) = SpringElementForces(K(i), ue);
end

U_check = Ue(:, 2) - Ue(:, 1);
U_check = find(U_check>umax);

%performing operation in a single index %write code to modify ine point
%check the whole configuration again and so on
iteration = 0;

ele_index = U_check(1);
uneed = Fe(ele_index)/k(ele_index);
new_ele_config = OptimiseSeriesSpringElements(umax, uneed, k, n_spring);
K(ele_index) = new_ele_config(1);
n_spring = n_spring - new_ele_config(2);

%run the simulation in a loop until the whole is optimised

%==========================================================================

%==========================================================================