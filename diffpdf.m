function [xd,dpdf] = diffpdf(Xpdf,pdf)

dx=diff(Xpdf); dx=dx(1);
dpdf = diff(pdf)/dx;
xd = [Xpdf(1:end-1)+Xpdf(2:end)]/2;
end