function [hiL1] = h_imp_L1(data)
n = length(data);
[h1] = hrefL1(data);
[A] = pA(h1,data);
[R] = pR(A,h1,data);
[h2] = h1*max(1,(10*R)^(2/5));
[B] = pB(data,h2);
hmsL1 = 2.71042*std(data)*n^(-1/5);
f1 = (((sqrt(15/(2*pi))*A)/B)^(2/5))*n^(-1/5);
f2 = hmsL1;
V = [f1 f2];
V = V(~isinf(V));
V = V(~isnan(V));
V = V(V>0);
hiL1 = min(V);
end

