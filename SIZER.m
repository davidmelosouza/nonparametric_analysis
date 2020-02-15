function [x,dy,h,yn] = SIZER(data,href)

nPoint = 1000;
n=length(data);
% hSJ = SJbandwidth(data);
% h = linspace(0.01*hSJ,10*hSJ,200);
[h] = [SETrangeH(n) href];
% h = [logspace(-3,0.5,100) href];
% 
for i=1:length(h)
    H=h(i);
    [X,pdf] = KDEfast_fixed_fit(data,H,nPoint);
%     plot(X,pdf)
%     pause
%     close
    dx =diff(X); dx=dx(1);
    dy(i,:) = diff(pdf)/dx;
    y(i,:) = pdf*(n*H);
    yn(i,:) = pdf;
end
yn = yn(:,1:end-1);


y=y(1:i,1:end-1);
dy(abs(dy)<0.5)=2;
dy(dy>=0&dy~=2)=1;
dy(dy<0&dy~=2)=-1;

dy(y<round(0.015*n))=0;
x = X(1:end-1);
% plot(x,yn);
% pause
% close
end

