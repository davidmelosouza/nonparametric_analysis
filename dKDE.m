function [X,df] = dKDE(DATA,h,r,nPoint)

x = DATA;
type = 'Gaussian';
[dk] = matlabFunction(kernel_fun_der(type,r));

X=linspace(min(x)-4*h,max(x)+4*h,nPoint);
n = length(x);
nd = 1;
 df=(1/(n*h^(r+1)))*sum(dk((repmat(X,length(x),1)-x)/h));


% d = diff(DATA.sg.pdf.truth.x); d=d(1);
% dy=diff(DATA.sg.pdf.truth.y,r)/d;
% 
% plot(DATA.sg.pdf.truth.x(1:end-r),dy,'-k'); hold on
% plot(X,df,':r')