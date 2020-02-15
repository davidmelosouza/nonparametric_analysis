function [A,sg_x,sg_y] = errorSTD(sg_evt,h,nPoint,ngrid,sg_mu,sg_std)
sg_x = linspace(-4*sg_std,4*sg_std,ngrid);
[X,Y] = KDEfast_fixed(sg_evt,h,nPoint);
vmin = min([X(1) sg_x(1)]);
vmax = max([X(end) sg_x(end)]);
sg_x = linspace(vmin,vmax,ngrid);
sg_y = normpdf(sg_x,sg_mu,sg_std);
ygrid = interp1(X,Y,sg_x,'linear','extrap');
[ygrid]= protec(ygrid);
A = area2d(sg_x,abs(ygrid-sg_y));
end

%         sg_x = linspace(0,500,ngrid);
%         sg_y = lognpdf(sg_x,sg_mu,sg_std);
%         sg_evt = random('logn',sg_mu,sg_std,sg_n,1);
