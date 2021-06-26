function y = OptimiseSeriesSpringElements(umax, uneed, k, n)
%===============================
%to achieve a given displacement
%===============================
%n is the number of elements available
%umax is the maximum deformation the spring can sustain
%k is the individual spring stiffness
%uneed is the displacement required

e_ideal = round(uneed/umax) + 1;%additional element for tolerance
k_required = k/e_ideal;%required equivalent stiffness

%returning the final equivalent stiffness and number elements required in
%the series connection
if n>=e_ideal
    y = [k_required, e_ideal];
else
    y = [k/n, n];
end