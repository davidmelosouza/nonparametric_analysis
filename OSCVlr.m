% function [CV] = OSCV(data,h,sm,type)
clc
clear
n = 100;
data = randn(n,1);
x = data;
h = linspace(0.01,4,100);
% type = 'right';
type = 'Gaussian'
r = 0;
a=(2*pi)/(pi-2);
b=(-2*sqrt(2*pi))/(pi-2);
n=length(data);
ngrid=length(h);
X1=reshape(data,n,1)*ones(1,n);
X2=ones(n,1)*reshape(data,1,n);
X=X1-X2;
% Const=0.6168471
% Const=0.5730
Const =1;
h=h/Const;
%   OSCV=1:ngrid;
%   T = (gammainc(u(I)*(u(I)/2),1.5));
%   T2=u(I).*(u(I)/2);
wb = waitbar(0,'Aguarde...');
for j=1:ngrid    
%     u=(X/(sqrt(2)*h(i)));
%     if strcmp(type,'left');
%     I=(u<0);
%     end
%      if strcmp(type,'right');
%     I=(u>0);
%      end
%     if strcmp(type,'OSCV');
%     I=ones(size(u));
%     end
%     M1=(b*b/4)*(1-gammainc(u(I).*(u(I)/2),1.5));            
%     CV(i)=sum(sum(normpdf(u(I),0,1).*(M1+sqrt(2)*a*b.*normpdf(u(I),0,1)+(1-normcdf(u(I))).*(a*a-(b*b/2)*u(I).*u(I)))));
%     CV(i)=CV(i)/(sqrt(2)*n*n*h(i));
%     term=(sum(sum((a+b.*abs(X/h(i))).*normpdf(X/h(i),0,1)))-n.*a.*normpdf(0,0,1))/2;
%     CV(i)=CV(i)-((2*term)/(n.*(n-1).*h(i)));
%     

syms u
n=length(x);
term=0;

[dk] = kernel_fun_OSCV(type);
d2k = [dk] ;
cK = kernel_fun_conv_OSCV(type);
Rdk = Rg(dk);
FUCV = matlabFunction(cK-2*d2k);

for i=1:n
    ind  = 1:n;
    X = (x(ind~=i)-x(i))/h(j);   
    term=term+mean(FUCV(X));
end

CV(j)=(Rdk*(1/(n*h(j)^((2*r)+1))))+((-1)^r / ((n-1)*h(j)^((2*r)+1)))*term;
waitbar(j/ngrid)
end
close(wb)
% h = linspace(0.01,4,80);
plot(h,CV)

% end
