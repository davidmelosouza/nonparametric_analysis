function [DATA] = D2dGen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.rho = [1 1];
    sg.mu = [-3 3];
    sg.beta = [10 10];
    if range == 1
        load([pwd '\limit\limit[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
    else
        sg.pdf.truth.x = linspace(-10,10,sg.n.x);
    end
    [sg.pdf.truth.y,~] = GGD_Gen(sg.pdf.truth.x,sg.mu,sg.beta,sg.rho,[1 1]);
    sg.n.evt = setup.EVT;
    A = ggdrnd(sg.mu(1), sg.beta(1),sg.rho(1),sg.n.evt)';
    B = ggdrnd(sg.mu(2), sg.beta(2),sg.rho(2),sg.n.evt)';
    C = [A; B];
    sg.evt = C(randi(length(C),sg.n.evt,1));
    DATA.sg = sg;
end


end
