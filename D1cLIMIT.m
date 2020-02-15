function [DATA] = D1cLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================
sg.n.x = setup.PTS;
sg.mu = 0;
sg.std = 1/2;
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
sg.pdf.truth.y = lognpdf(sg.pdf.truth.x,sg.mu,sg.std);
DATA.sg = sg;



end



