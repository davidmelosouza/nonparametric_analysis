function [ycdf,ind] = make_cdf(sg)



ycdf = docdf(sg.pdf.truth.y);
[~,ind] = unique(ycdf);





end
