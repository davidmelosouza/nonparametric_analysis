function [DATA] = D2bGen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.rho = [10 1];
    sg.mu = [0 0];
    sg.beta= [0.1 10];
    sg.alpha  = [1 1];
    if range == 1
        load([pwd '\limit\limit[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
    else
        sg.pdf.truth.x = linspace(-6,6,sg.n.x);
    end
    [sg.pdf.truth.y,~] = GGD_Gen(sg.pdf.truth.x,sg.mu,sg.beta,sg.rho,[1 1]);
    sg.n.evt = setup.EVT;
    A = ggdrnd(0, 0.1,sg.rho(1),sg.n.evt)';
    B = ggdrnd(0, 10,sg.rho(2),sg.n.evt)';
    C = [A; B];
    sg.evt = C(randi(length(C),sg.n.evt,1));
    DATA.sg = sg;
end


end
