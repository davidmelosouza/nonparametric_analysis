function [A] = pA(h,data)
[x,f] = KDEfast_fixed_ep(data,h,10000);
dx = diff(x); dx = dx(1);
A = sum(sqrt(f).*dx);
end
