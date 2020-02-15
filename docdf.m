function [ecdf] = docdf(y)

ecdf(1)=0;
for i = 2:length(y)
ecdf(i)=ecdf(i-1)+y(i);
end
ecdf=ecdf/max(ecdf);
% plot(DATA.sg.pdf.truth.x,ecdf); hold on
% plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y)