function [DATA] = D2aLIMIT(setup,DATA,xmin,xmax)


    sg.n.x = setup.PTS;
    sg.g1.mu = 0;
    sg.g1.std = 0.8;
    sg.g2.mu = -1;
    sg.g2.std = 0.25;
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
    sg.pdf.truth.y = (normpdf(sg.pdf.truth.x,sg.g1.mu,sg.g1.std) + normpdf(sg.pdf.truth.x,sg.g2.mu,sg.g2.std))/2;
 DATA.sg = sg;
end



