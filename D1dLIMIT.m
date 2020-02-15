function [DATA] = D1dLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================

    sg.n.x = setup.PTS;
    sg.rho = 1;
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
    [sg.pdf.truth.y,sg.pdf.ny] = GGD_Gen(sg.pdf.truth.x,0,1,sg.rho,1);
    sg.n.evt = setup.EVT;
    sg.evt = ggdrnd(0, 1,sg.rho,sg.n.evt)';
    DATA.sg = sg;


end



