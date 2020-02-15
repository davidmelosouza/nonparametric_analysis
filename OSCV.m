% function [CV] = OSCV(data,h,sm,type)
clc
clear
data = randn(25,1);
h = linspace(0.01,4,80);
a=(2*pi)/(pi-2);
b=(-2*sqrt(2*pi))/(pi-2);
n=length(data);
ngrid=length(h);
X1=reshape(data,n,1)*ones(1,n);
X2=ones(n,1)*reshape(data,1,n);
X=X1-X2;
%  Const=0.6168  %(smooth case)
Const=0.5730; %(nonsmooth case)
% Const =1;
% h=h/Const;
%   OSCV=1:ngrid;
%   T = (gammainc(B*(B/2),1.5));
%   T2=B.*(B/2);
wb = waitbar(0,'Aguarde...')
for i=1:ngrid    
    B=abs(X/(sqrt(2)*h(i)));
    M1=((b*b)/4)*(1-gammainc(B.*(B/2),1.5));            
    CV(i)=sum(sum(normpdf(B,0,1).*(M1+sqrt(2)*a*b.*normpdf(B,0,1)+(1-normcdf(B)).*(a*a-(b*b/2)*B.*B))));
    CV(i)=CV(i)/(sqrt(2)*n*n*h(i));
    term=(sum(sum((a+b.*abs(X/h(i))).*normpdf(X/h(i),0,1)))-n.*a.*normpdf(0,0,1))/2;
    CV(i)=CV(i)-((2*term)/(n.*(n-1).*h(i)));
    waitbar(i/ngrid)
end
close(wb)
h = Const*h;
[b,ind]=min(CV);
plot(h,CV); hold on
plot(h(ind),CV(ind),'ok')
% end
% end
[h] = h_plugin(data);
h.PI
