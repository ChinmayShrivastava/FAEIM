function y = OptimizeParallelClusterofSprings(F_known, F_zero, U, umax, k, ele_node, n, n_spring)

%variables needed - e
e = length(ele_node(:, 1));
%Assembling the initial global stiffness matrix
Ke = zeros(e, 1)+k;
K = zeros(n);
for i = 1:e
    ke_temp = SpringElementStiffness(Ke(i));
    K = SpringAssemble(K, ke_temp, ele_node(i, 1), ele_node(i, 2));
end

%setting values for the temporary force vector
%outside the loop because it's calue wont change throughout the simulation
index_unknown_displacements = find(U);
index_fknown = find(F_known);
ftemp_len = length(index_fknown);
f_temp = zeros(ftemp_len, 1);
var = 1;
for i = 1:n
    if F_known(i)~=0 && F_zero(i)~=0
        f_temp(var) = F_known(i);
        var = var+1;
    elseif F_known(i)~=0 && F_zero(i)==0
        f_temp(var) = 0;
        var = var+1;
    end
end
iteration = 0;
while true
    iteration = iteration+1;
    %calculate Ftemp
    %calculate Ktemp
    k_temp = zeros(length(index_unknown_displacements), length(index_fknown));
    for i = 1:length(index_unknown_displacements)
        for j = 1:length(index_fknown)
            k_temp(i, j) = K(index_unknown_displacements(i), index_fknown(j));
        end
    end
    %calculate Utemp
    u_temp = k_temp\f_temp;
    
    for i = 1:length(u_temp)
        U(index_unknown_displacements(i)) = u_temp(i);
    end
    
    F = K*U;
    
    Ue = zeros(e, 2);
    Fe = zeros(e, 1);
    for i = 1:e
        Ue(i, 1) = U(ele_node(i, 1));
        Ue(i, 2) = U(ele_node(i, 2));
        ue = [Ue(i, 1); Ue(i, 2)];
        fe_temp = SpringElementForces(K(i), ue);
        Fe(i) = fe_temp(2);
    end
    
    %check if U exceeds the maximum value
    U_check = Ue(:, 2) - Ue(:, 1);
    U_check_find = find(U_check>umax, 1);
    
    if isempty(U_check_find)
        break
    else
        [~, index_maxU] = max(U_check);
        ele_index = index_maxU;
        K_temp = Ke(ele_index);
        output_temp = OptimizeParallelSpringElements(Fe(ele_index), umax, k, 1, K_temp);
        old_Ke = SpringElementStiffness(Ke(ele_index));
        Ke(ele_index) = output_temp(1);
        k_new = SpringElementStiffness(Ke(ele_index));
        n_spring = n_spring-1;
        K = K-SpringAssemble(zeros(n), old_Ke, ele_node(ele_index, 1), ele_node(ele_index, 2));
        K = SpringAssemble(K, k_new, ele_node(ele_index, 1), ele_node(ele_index, 2));
        if n_spring==0
            break
        end
    end
end

y = Ke, K, U, F, n_spring;
