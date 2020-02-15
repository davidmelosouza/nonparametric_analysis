function [DATA] = D2aGen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.g1.mu = 0;
    sg.g1.std = 0.8;
    sg.g2.mu = -1;
    sg.g2.std = 0.25;
    if range == 1
        load([pwd '\limit\limit[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
    else
        sg.pdf.truth.x = linspace(-4,6,sg.n.x);
    end
    sg.pdf.truth.y = (normpdf(sg.pdf.truth.x,sg.g1.mu,sg.g1.std) + normpdf(sg.pdf.truth.x,sg.g2.mu,sg.g2.std))/2;
    sg.n.evt = setup.EVT;
    A.sg=sg.g1.mu+sg.g1.std*randn(sg.n.evt,1);
    B.sg=sg.g2.mu+sg.g2.std*randn(sg.n.evt,1);
    C.sg=[A.sg; B.sg];
    sg.evt = C.sg(randi(length(C.sg),sg.n.evt,1));
    DATA.sg = sg;
end


end



