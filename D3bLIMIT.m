function [DATA] = D3bLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================
    sg.n.x = setup.PTS;
    sg.rho = [10 1];
    sg.mu = [7 7];
    sg.beta= [0.1 10];
    sg.alpha  = [1 1];
    sg.mul = 0;
    sg.std = 1/2;
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
    [sg.pdf.truth.y] = (GGD_Gen(sg.pdf.truth.x,sg.mu,sg.beta,sg.rho,sg.alpha) + lognpdf(sg.pdf.truth.x,sg.mul,sg.std))/2;
    DATA.sg = sg;



end
