x = -2:0.01:2;
x = x(abs(x)<=1);
 y = (3/4).*(1-(x.^2));
 plot(x,y)
hold on
 %
%  area2d(x,y)

x = -2:0.01:2;
x1 = x(abs(x)<=1/2);
y1 = (7-(31*x1.^2))/4;
x2 = x(abs(x)>=1/2 & abs(x)<=1);
y2 = ((x2.^2)-1)/4;
x3 = x(abs(x)>=1);
y3 = x3*0;

% plot([x1 x2 x3], [y1 y2 y3],'-')

X = [x1 x2];
Y = [y1 y2];
[a,b]=sort(X);
plot(X(b),Y(b),'-')

area2d(X(b),Y(b))