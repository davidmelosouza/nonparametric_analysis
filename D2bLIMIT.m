function [DATA] = D2bLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================
    sg.n.x = setup.PTS;
    sg.rho = [10 1];
    sg.mu = [0 0];
    sg.beta= [0.1 10];
    sg.alpha  = [1 1];
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
    [sg.pdf.truth.y,~] = GGD_Gen(sg.pdf.truth.x,sg.mu,sg.beta,sg.rho,[1 1]);
    DATA.sg = sg;


end
