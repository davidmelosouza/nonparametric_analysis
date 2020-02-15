function [DATA] = D3aLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================

    sg.n.x = setup.PTS;
    sg.mu=[-2 0 2];
    sg.beta= [1 1 1];
    sg.rho=[1 2 10];
    sg.alpha = [0.5 0.2 0.3];
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
    [sg.pdf.truth.y,~] = GGD_Gen(sg.pdf.truth.x,sg.mu,sg.beta,sg.rho,sg.alpha);
    DATA.sg = sg;



end
