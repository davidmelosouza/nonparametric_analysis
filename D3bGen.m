function [DATA] = D3bGen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.rho = [10 1];
    sg.mu = [7 7];
    sg.beta= [0.1 10];
    sg.alpha  = [1 1];
    sg.mul = 0;
    sg.std = 1/2;
    if range == 1
        load([pwd '\limit\limit[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
    else
        sg.pdf.truth.x = linspace(0,13,sg.n.x);
    end
    [sg.pdf.truth.y] = (GGD_Gen(sg.pdf.truth.x,sg.mu,sg.beta,sg.rho,sg.alpha) + lognpdf(sg.pdf.truth.x,sg.mul,sg.std))/2;
    sg.n.evt = setup.EVT;
    A = GGD_DATA(sg.mu,sg.beta,sg.rho,sg.alpha,setup.EVT);
    B = random('logn',sg.mul,sg.std,1,sg.n.evt);
    C = [A; B];
    sg.evt = C(randi(length(C),sg.n.evt,1));
    DATA.sg = sg;
end


end
