function [B] = pB(data,h)

[x,f] = KDEfast_fixed_ep(data,h,10000);
[x,g] = KDEfast_fixed_L(data,h,10000);
dx = diff(x); dx = dx(1);

K=Knep(x);
B = (2*sum(abs(f-g)*dx))/((h^2)*sum(((x.^2).*K)*dx));
end
