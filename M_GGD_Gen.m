function [DATA] = M_GGD_Gen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.rho = setup.rho;
    if range == 1
        load([pwd '\limit\TEST1SK[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']SK[' num2str(setup.ir) '][' setup.TYPE.DATA ']'],'pdf');
        sg.pdf.truth.x = linspace(min(min(pdf.xlimit)),max(max(pdf.xlimit)),sg.n.x);
%         [sg.Integral] = PDF_integral(sg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        sg.pdf.truth.x = linspace(-30,30,sg.n.x);
    end
    sg.pdf.truth.y = ggd(sg.pdf.truth.x,sg.rho)';
    sg.n.evt = setup.EVT;
    sg.evt = ggdrnd(0, 1,sg.rho,sg.n.evt)';
    DATA.sg = sg;
end

%==========================================================================
% Ruído
%==========================================================================
if strcmp(setup.TYPE.DATA,'bg') || strcmp(setup.TYPE.DATA,'both')
    bg.n.x = setup.PTS;
    bg.rho = setup.rho;
    if range == 1
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        bg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),bg.n.x);
        [bg.Integral] = PDF_integral(sg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        bg.pdf.truth.x = linspace(-6,6,bg.n.x);
    end
    ggm(x,rho)
    bg.pdf.truth.y = ggd(bg.pdf.truth.x,bg.rho);
    bg.n.evt = setup.EVT;
    bg.evt = ggdrnd(0, 1,bg.rho,bg.n.evt)   ;
    DATA.sg = sg;
end



end





