function [DATA] = D1bGen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.rho = 10;
    if range == 1
        load([pwd '\limit\limit[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
    else
        sg.pdf.truth.x = linspace(-2,2,sg.n.x);
    end
    [sg.pdf.truth.y,sg.pdf.ny] = GGD_Gen(sg.pdf.truth.x,0,1,sg.rho,1);
    sg.n.evt = setup.EVT;
    sg.evt = ggdrnd(0, 1,sg.rho,sg.n.evt)';
    DATA.sg = sg;
end


end



