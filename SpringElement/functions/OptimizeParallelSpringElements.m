function y = OptimizeParallelSpringElements(F, umax, k, n, kexisting) %number of elements required for given arrangement
                                                                 %remove extra elements
                                                                 %add more
                                                                 %if
                                                                 %required
%k is the stiffness of each element
%F and umax are the force applied and the maximum elastic deformation the
%spring can sustain
%kexisting is the existing value of equivalent stiffness in the existing
%structure
%n is the number of springs of stiffness k available to be included in the
%assembly

%assuming the equivalent k is less than the required value
e = 0;%initialising the number of elements required additionally
k_required = F/umax;
for i = 1:n
    e = e + 1;
    k_equivalent = kexisting + k*e; %parallel connection
    if k_equivalent>=k_required
        break
    end
    if n-e==0
        break
    end
end
y = [k_equivalent; e];%returning a vector of final stiffness value and the number of elements required