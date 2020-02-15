function [DATA] = D3cLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================
    sg.n.x = setup.PTS;
    sg.alfa1 = 2;
    sg.alfa2 = 8;
    sg.beta1 = 8;
    sg.beta2 = 2;
sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
    sg.pdf.truth.y = (betapdf(sg.pdf.truth.x,sg.alfa1,sg.beta1)+betapdf(sg.pdf.truth.x,sg.alfa2,sg.beta2)+GGD_Gen(sg.pdf.truth.x,0.5,50,1,1))/3;
    DATA.sg = sg;



end
