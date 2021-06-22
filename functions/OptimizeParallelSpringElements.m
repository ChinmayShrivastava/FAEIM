function y = OptimizeParallelSpringElements(F, umax, k) %number of elements required for given arrangement
                                                                 %remove extra elements
                                                                 %add more
                                                                 %if
                                                                 %required
%k is the stiffness of each element
%F and umax are the force applied and the maximum elastic deformation the
%spring can sustain
e = 0;%initialising the number of elements
while true
    e = e + 1;
    k_equivalent = k*e; %parallel connection
    if k_equivalent*umax>=F
        break
    end
end
y = [k_equivalent; e];%returning a vector of final stiffness value and the number of elements required
end