function [hi] = hiPDF(x,h1,DATA)

fpi = interp1(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,x,'linear',0); [fpi]= protec(fpi);
lambda=exp((length(x)^-1)*sum(log(fpi)));
[hi] = hSSE(h1,lambda,fpi);[hi]= protec(hi);
end