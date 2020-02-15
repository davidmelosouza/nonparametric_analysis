function [DATA] = D1cGen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.mu = 0;
    sg.std = 1/2;
    if range == 1
        load([pwd '\limit\limit[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
    else
        sg.pdf.truth.x = linspace(0,20,sg.n.x);
    end
    sg.pdf.truth.y = lognpdf(sg.pdf.truth.x,sg.mu,sg.std);
    sg.n.evt = setup.EVT;
    sg.evt = random('logn',sg.mu,sg.std,1,sg.n.evt)';
    DATA.sg = sg;
end


end



