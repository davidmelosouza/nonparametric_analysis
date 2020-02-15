function [DATA] = D3aGen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.mu=[-2 0 2];
    sg.beta= [1 1 1];
    sg.rho=[1 2 10];
    sg.alpha = [0.5 0.2 0.3];
    if range == 1
        load([pwd '\limit\limit[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
    else
        sg.pdf.truth.x = linspace(-20,15,sg.n.x);
    end
    [sg.pdf.truth.y,~] = GGD_Gen(sg.pdf.truth.x,sg.mu,sg.beta,sg.rho,sg.alpha);
    sg.n.evt = setup.EVT;
    sg.evt = GGD_DATA(sg.mu,sg.beta,sg.rho,sg.alpha,setup.EVT)';
    DATA.sg = sg;
end


end
