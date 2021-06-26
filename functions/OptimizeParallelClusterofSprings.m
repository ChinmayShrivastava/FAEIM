function y = OptimizeParallelClusterofSprings(F_known, F_zero, k, ele_nodes, n_spring)

%variables needed - e

%Assembling the initial global stiffness matrix
Ke = zeros(e, 1)+k;
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

while true
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
    
    %check if U exceeds the maximum value
    U_check = Ue(:, 2) - Ue(:, 1);
    U_check_find = find(U_check>umax);
    
    if isempty(U_check_find)
        break
    else
        [maxU, index_maxU] = max(U_check);
        u_need_temp = maxU;
        ele_index = index_maxU;
    end
end
