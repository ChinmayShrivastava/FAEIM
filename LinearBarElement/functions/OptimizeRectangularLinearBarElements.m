function [K, e, E, A, L, arrangement] = OptimizeRectangularLinearBarElements(F, sigmabreak, E, dimn_one_ele, l_min, u_req) %number of elements required for given arrangement
                                                                 %remove extra elements
                                                                 %add more
                                                                 %if
%to increase k %maximise area and minimize the length
%dimn is the dimention of the structure in which the bar needs to be fitted

x_lim = dimn_one_ele(1);
y_lim = dimn_one_ele(2);
z_lim = dimn_one_ele(3);

A_min = F/sigmabreak;
%assuming rectangular cross-section
A_max = y_lim*z_lim;%27
k_req = F/u_req;

k_max = E*A_max/l_min;
boolean = k_max<=k_req;%2
if boolean==1
    e = round(k_req/k_max);
    K = e*k_max;
    A = A_max;%6
    L = l_min;%7
    if K<k_req
        K = K+k_max;
        e = e+1;
    end
    if e>1%21
        arrangement = "parallel";%20
    else
        arrangement = "single";%23
    end%22
elseif boolean==0
    l_opt = E*A_max/k_req; %maximize A for better tolerance
    if l_opt<=x_lim
        K = E*A_max/l_opt;
        A = A_max;%9
        L = l_opt;%8
        e = 1;%3
        arrangement = "single";%24
    elseif l_opt>x_lim
        l_opt = x_lim;
        L = l_opt;%10
        A_opt = k_req*l_opt/E;
        if A_opt>=A_min
            K = E*A_opt/l_opt;
            A = A_opt;%11
            e = 1;%4
            arrangement = "single";%25
        else
            k_min = E*A_min/l_opt;
            A = A_min;%12
            arrangement = "series";%26
            e = 2;
            while true
                if k_min/e<=k_req
                    K = k_min/e;%5   
                    break
                else
                    e = e+1;
                end
            end
        end
    end
end