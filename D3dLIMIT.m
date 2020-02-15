function [DATA] = D3dLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================
    sg.n.x = setup.PTS;
    sg.rho = [1 1 1];
    sg.mu = [-3 3 9];
    sg.beta = [10 20 30];
    sg.alpha = [1 1 1];
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
    [sg.pdf.truth.y,~] = GGD_Gen(sg.pdf.truth.x,sg.mu,sg.beta,sg.rho,sg.alpha);
    DATA.sg = sg;



end
