function CV=TCVfast(x,h,r,type)
% x is the input data
% h is the bandwidth
syms u
n=length(x);
% F=zeros(n-1,n);
[F] = fastM(x);

L1 = matlabFunction(kernel_fun_conv(type,r));
D2 = matlabFunction(kernel_fun_der(type,2*r));

Rdk = Rg(kernel_fun_der(type,r));

X = (F)/h;
% X = X(abs(X)>(1/(n*h^(2*r+1))));

indT= (abs(X)>(1/(n*h^(2*r+1)))); indT = double(indT);
Q1 = sum(((-1)^(r)/((n-1)*h^(2*r+1)))*indT.*L1(X));
Q2 = sum(((-1)^(r)/((n-1)*h^(2*r+1)))*indT.*D2(X));
% Q1 = sum(((-1)^(r)/((n-1)*h^(2*r+1)))*L1(X));
% Q2 = sum(((-1)^(r)/((n-1)*h^(2*r+1)))*D2(X));

S=sum((1/(n*h^(2*r+1)))*Rdk + Q1 - 2 * Q2);

CV = S*(1/n);


