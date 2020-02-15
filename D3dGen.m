function [DATA] = D3dGen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.rho = [1 1 1];
    sg.mu = [-3 3 9];
    sg.beta = [10 20 30];
    sg.alpha = [1 1 1];
    if range == 1
        load([pwd '\limit\limit[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
    else
        sg.pdf.truth.x = linspace(-10,15,sg.n.x);
    end
    [sg.pdf.truth.y,~] = GGD_Gen(sg.pdf.truth.x,sg.mu,sg.beta,sg.rho,sg.alpha);
    sg.n.evt = setup.EVT;
    sg.evt = GGD_DATA(sg.mu,sg.beta,sg.rho,sg.alpha,setup.EVT)';
    DATA.sg = sg;
end


end
