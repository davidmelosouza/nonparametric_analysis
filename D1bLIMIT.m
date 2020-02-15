function [DATA] = D1bLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================
sg.n.x = setup.PTS;
sg.rho = 10;
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
[sg.pdf.truth.y,sg.pdf.ny] = GGD_Gen(sg.pdf.truth.x,0,1,sg.rho,1);
DATA.sg = sg;


end



