function y = OptimiseParallelSpringStiffness(Kreq, Lrange, Arange, Eavailable)%optimize k for given range of area and length and materials
%Kreq is the required stiffness value
%Lrange is the list of the lengths of availeble bars
%Arange is the cross section areas of the available bars
%Eavailable is the list of modulus of available bar materials
l = size(Lrange, 1);
m = size(Arange, 1);
n = size(Eavailable, 1);

k_val = zeros(l*m*n, 4); %values of E, A, and L along with the corresponding K value


%calculating various k values from all the possible combinations available
knumber = 0;
for i = 1:n
    for j = 1:m
        for k = 1:l
            
            knumber = knumber + 1;
            
            L_temp = Lrange(k);
            A_temp = Arange(m);
            E_temp = Eavailable(n);
            K_temp = E_temp*A_temp/L_temp;
            
            k_val(knumber, 1) = E_temp;
            k_val(knumber, 1) = A_temp;
            k_val(knumber, 1) = L_temp;
            k_val(knumber, 1) = K_temp;
        end
    end
end

K_mat = k_val(:, 4); %creating a vector K_mat for finding the required k values
K_available_index = find(K_mat>=Kreq); %indexing the k values that match the requirements

%creating a matrix of the values that match the requirements
K_available = zeros(length(K_available_index), 4);
for i = 1:length(K_available_index)
    index = K_available_index(i);
    K_available(i, :) = k_val(index); 
end

y = K_available; %returning the matrix of all the k values with the corresponding E, A, L combinations that fit the requirements