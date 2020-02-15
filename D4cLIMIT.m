function [DATA] = D4cLIMIT(setup,DATA,xmin,xmax)

%==========================================================================
% Sinal
%==========================================================================
    sg.n.x = setup.PTS;
    sg.rho = 1;
    sg.pdf.truth.x = linspace(xmin,xmax,sg.n.x);
    [sg.pdf.truth.y,sg.pdf.ny] = GGD_Gen(sg.pdf.truth.x,0,1,sg.rho,1);
    icut_pdf = intersect(find(sg.pdf.truth.x>-4.5),find(sg.pdf.truth.x<4.5));
    sg.pdf.truth.y(icut_pdf) = 0;
    sg.pdf.truth.y =  sg.pdf.truth.y/area2d(sg.pdf.truth.x, sg.pdf.truth.y);

end

