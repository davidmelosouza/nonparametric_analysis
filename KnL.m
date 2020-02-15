function [K]=KnL(u)

K = zeros(size(u,1),size(u,2));

I1=(abs(u)<=1/2);
f1 = (7-(31*u.^2))/4;
K(I1)= f1(I1);

I2=(abs(u)>=1/2 & abs(u)<=1);
f2 = (((u.^2)-1)/4);
K(I2)= f2(I2);

I3=(abs(u)>=1);
f3 = 0*u;
K(I3)= f3(I3);

end

