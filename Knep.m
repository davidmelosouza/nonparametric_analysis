function [K]=Knep(u)
% u = u(:);
I=(abs(u)<=1);
K=(3/4)*(1-u.^2).*I;
% K = K(:);
end

