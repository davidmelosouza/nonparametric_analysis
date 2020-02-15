function [e] = eRoI(setup,DATA,x,y) 

for ir=1:length(DATA.sg.RoI.ind)
    xmin=min(x);
    xmax=max(x);
    iRoI=DATA.sg.RoI.ind{ir};
    [DATA] = ChangePDFlimit(setup,DATA,xmin,xmax);
    ygrid= interp1(x,y,DATA.sg.pdf.truth.x(iRoI),'linear',0);
    e(ir)=area2d(DATA.sg.pdf.truth.x(iRoI),abs(DATA.sg.pdf.truth.y(iRoI)-ygrid));
%     plot(DATA.sg.pdf.truth.x(iRoI),DATA.sg.pdf.truth.y(iRoI),'.k'); hold on
%     plot(DATA.sg.pdf.truth.x(iRoI),ygrid,'.r'); hold on
%     pause(0.1)
end