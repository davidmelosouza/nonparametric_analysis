function [DATA] = D4bLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================
    sg.n.x = setup.PTS;
    sg.g1.mu = 0;
    sg.g1.std = 1;
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
    sg.pdf.truth.y = (unifpdf(sg.pdf.truth.x,-6,6)+unifpdf(sg.pdf.truth.x,-0.5,0.5))*0.5;
    DATA.sg = sg;

end



