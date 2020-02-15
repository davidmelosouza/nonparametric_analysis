function [DATA] = D2dLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================
sg.n.x = setup.PTS;
sg.rho = [1 1];
sg.mu = [-3 3];
sg.beta = [10 10];
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
[sg.pdf.truth.y,~] = GGD_Gen(sg.pdf.truth.x,sg.mu,sg.beta,sg.rho,[1 1]);
DATA.sg = sg;


end
