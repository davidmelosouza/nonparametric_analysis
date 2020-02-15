function [R] = pR(A,h,data)

n = length(data);
[x,f] = KDEfast_fixed_ep(data,h,10000);
[x,g] = KDEfast_fixed_L(data,h,10000);
dx = diff(x); dx = dx(1);

K=Knep(x);
L=KnL(x);

% plot(x,K);hold on
% plot(x,L)

R = A*sqrt(sum(((K-L).^2))*dx)/ ((n*h)*sum(abs(f-g)*dx));
end
