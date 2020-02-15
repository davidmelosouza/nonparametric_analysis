function [DATA] = D4cGen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.rho = 1;
    if range == 1
        load([pwd '\limit\limit[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
    else
        sg.pdf.truth.x = linspace(-20,20,sg.n.x);
    end
    [sg.pdf.truth.y,sg.pdf.ny] = GGD_Gen(sg.pdf.truth.x,0,1,sg.rho,1);
    icut_pdf = intersect(find(sg.pdf.truth.x>-4.5),find(sg.pdf.truth.x<4.5));
    sg.pdf.truth.y(icut_pdf) = 0;
    sg.pdf.truth.y =  sg.pdf.truth.y/area2d(sg.pdf.truth.x, sg.pdf.truth.y);
    sg.n.evt = setup.EVT;
    sg.evt = ggdrnd(0, 1,sg.rho,sg.n.evt*500)';
    indcut_evt = [find(sg.evt<-4.5); find(sg.evt>4.5)];
    sg.evt = sg.evt(indcut_evt);
     sg.evt = sg.evt(randperm(length(sg.evt),sg.n.evt));
    DATA.sg = sg;
end


end

