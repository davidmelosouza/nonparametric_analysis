function [X,Y,hi,hf]=KDE_STAGES(DATA,h,nPoint)
x = sort(DATA.sg.evt);
%% Estágio 0:
htruthG = h.truthG;
[hi0] = hiKDE(x,h.CV.rOSCV,nPoint);
[X.s0,Y.s0,hi.s0] = KDESSEROI(x,{hi0},nPoint,h.CV.rOSCV);
hf.s0=h.CV.rOSCV^2;
%% Estágio 1:
[h] = h_methods_ATLAS(data_robust(x));
[hi1] = hiKDE(x,h.CV.rOSCV,nPoint);
[X.s1,Y.s1,hi.s1] = KDESSEROI(x,{hi1},nPoint,h.CV.rOSCV);
hf.s1=h.CV.rOSCV^2;
%% Estágio 2:
[he2,R] = stage1(x,h);
[hi2] = hiKDE(x,he2,nPoint);
[X.s2,Y.s2,hi.s2] = KDESSEROI(x,{hi2},nPoint,he2);
hf.s2=he2^2;
%% Estágio 3:
if length(x)<100
    [hi3] = stage23(x,he2,h,R,nPoint,2,'KDE','PROB','ON','ON');
end

if length(x)>=100 && length(x)<=500
    [hi3] = stage23(x,he2,h,R,nPoint,2,'KDE','PROB','ON','ON');
end

if length(x)>=1000
    [hi3] = stage23(x,he2,h,R,nPoint,2,'KDE','PROB','ON','ON');
end
[hi3]= protec(hi3);
hi3 = hi3(:)'.^2;
hf.s3=he2^2;
[X.s3,Y.s3,hi.s3] = KDESSEROI_Hi(x,{hi3},nPoint,he2);

[hiT] = hiPDF(x,htruthG,DATA);
hf.T=htruthG^2;
hiT = hiT.^2;
[X.T,Y.T,hi.T] = KDESSEROI_Hi(x,{hiT},nPoint,htruthG);


end