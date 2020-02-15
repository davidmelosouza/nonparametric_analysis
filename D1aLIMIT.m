function [DATA] = D1aLIMIT(setup,DATA,xmin,xmax)
sg.n.x = setup.PTS;
sg.g1.mu = 0;
sg.g1.std = 1;
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
sg.pdf.truth.y = normpdf(sg.pdf.truth.x,sg.g1.mu,sg.g1.std);
DATA.sg = sg;
end



