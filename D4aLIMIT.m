function [DATA] = D4aLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================
sg.n.x = setup.PTS;
sg.g1.mu = 0;
sg.g1.std = 1;
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
sg.pdf.truth.y = normpdf(sg.pdf.truth.x,sg.g1.mu,sg.g1.std)*2;
icut_pdf = find(sg.pdf.truth.x>0);
sg.pdf.truth.y(icut_pdf) = 0;
DATA.sg = sg;


end



