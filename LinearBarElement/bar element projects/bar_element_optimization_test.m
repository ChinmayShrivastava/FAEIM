F = 1;%14
sigmabreak = 1;%15
E = 1;%16
dimn_one_ele = [1, 1, 1];%17
l_min = 0.5;%18
u_req = 1;%19


[K, e, E, A, L] = OptimizeParallelLinearBarElement(F, sigmabreak, E, dimn_one_ele, l_min, u_req);
%13