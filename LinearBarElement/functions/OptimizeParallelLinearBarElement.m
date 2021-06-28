function y = OptimizeParallelLinearBarElement(F, sigmabreak, E, dimn_one_ele, l_min, u_req) %number of elements required for given arrangement
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

x_lim = dimn_one_ele(1);
y_lim = dimn_one_ele(2);
z_lim = dimn_one_ele(3);

A_min = F/sigmabreak; %1
%assuming circular cross-section
r_max = (y_lim>=z_lim)*z_lim+(y_lim<z_lim)*y_lim; %3
A_max = pi*(r_max)*(r_max); %2
k_req = F/u_req; %4

k_max = E*A_max/l_min;%8
boolean = k_max<k_req;%7
if boolean==1 %5
    e = round(k_req/k_max);%9
    K = e*k_max;%10
    if K<k_req%11
        K = K+k_max;%12
        e = e+1;%14
    end%13
elseif boolean==0%15
    l_opt = E*A_max/k_req;%16 %maximize A for better tolerance
    if l_opt<=x_lim%17
        K = E*A_max/l_opt;%19
    elseif l_opt>x_lim%20
        l_opt = x_lim;%21
        A_opt = k_req*l_opt/E;%22
        if A_opt>=A_min%23
            K = E*A_opt/l_opt;%24
        else%25
            k_min = E*A_min/l_opt;%26
            while true%27
                e = 2;%28
                if k_min/e<=k_req%29
                    break%30
                else%31
                    e = e+1;%32
                end%33
            end%29
        end%27
    end%18
end %6

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