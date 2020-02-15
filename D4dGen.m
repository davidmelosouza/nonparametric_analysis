function [DATA] = D4dGen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.g1.mu = 0;
    sg.g1.std = 1;
    if range == 1
        load([pwd '\limit\limit[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1)-0.5,pdf.xlimit(2)+0.5,sg.n.x);
    else
        sg.pdf.truth.x = linspace(-15,15,sg.n.x);
    end
    sg.pdf.truth.y = (unifpdf(sg.pdf.truth.x,-14.25,-13.75)+unifpdf(sg.pdf.truth.x,-0.5,0.5)+unifpdf(sg.pdf.truth.x,13.75,14.25))/3;
    sg.n.evt = setup.EVT;
    [sg.evt] =  [random('Uniform',-14.25,-13.75,1,sg.n.evt); random('Uniform',-0.5,0.5,1,sg.n.evt); random('Uniform',13.75,14.25,1,sg.n.evt)];
    sg.evt = sg.evt(randperm(length(sg.evt),sg.n.evt))';
    DATA.sg = sg;
end

end



