function [DATA] = D3cGen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.alfa1 = 2;
    sg.alfa2 = 8;
    sg.beta1 = 8;
    sg.beta2 = 2;
    if range == 1
        load([pwd '\limit\limit[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
    else
        sg.pdf.truth.x = linspace(-2,4,sg.n.x);
    end
    sg.pdf.truth.y = (betapdf(sg.pdf.truth.x,sg.alfa1,sg.beta1)+betapdf(sg.pdf.truth.x,sg.alfa2,sg.beta2)+GGD_Gen(sg.pdf.truth.x,0.5,50,1,1))/3;
    sg.n.evt = setup.EVT;
    
    A = random('beta',sg.alfa1,sg.beta1,1,sg.n.evt)';
    B = random('beta',sg.alfa2,sg.beta2,1,sg.n.evt)';
    C = GGD_DATA(0.5,50,1,1,setup.EVT)';
    D=[A; B; C];
    sg.evt = D(randi(length(D),sg.n.evt,1));
    DATA.sg = sg;
end


end
