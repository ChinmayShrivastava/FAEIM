function y = OptimizeParallelLinearBarElement(F, E, A_existing, L_existing, dimn) %number of elements required for given arrangement
                                                                 %remove extra elements
                                                                 %add more
                                                                 %if
%to increase k %maximise area and minimize the length
%dimn is the dimention of the structure in which the bar needs to be fitted

x = L_existing;
%assuming circular cross-section
r = sqrt(A/pi);
y = 2*r;
z = 2*r;

x_lim = dimn(1);
y_lim = dimn(2);
z_lim = dimn(3);

if x>x_lim
elseif y>y_lim
elseif z>z_lim
else
end

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