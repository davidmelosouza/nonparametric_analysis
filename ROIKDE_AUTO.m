function [Xpdf,Ypdf]=ROIKDE_AUTO(x,nPoint)

[h] = h_methods_ATLAS(data_robust(x)');
[h1,R] = stage1(x,h);

if length(x)<=100
    [hf] = stage23(x,h1,h,R,nPoint,2,'KDE','PROB','OFF','OFF');
end

if length(x)>100 && length(x)<=500
    [hf] = stage23(x,h1,h,R,nPoint,2,'KDE','PROB','ON','ON');
end

if length(x)>500
    [hf] = stage23(x,h1,h,R,nPoint,2,'KDE','DERIV','ON','ON');
end
[hf]= protec(hf);
hf = hf(:)'.^2;
[Xpdf,Ypdf,~] = KDESSEROI_Hi(x,{hf},nPoint,h1);

end