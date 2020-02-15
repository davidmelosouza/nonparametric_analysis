function [Xpdf,Ypdf]=ROIKDE(x,h,nPoint,deriv_mode,smooth_mode,alpha,enable_stage2,enable_stage3)
[h1,R] = stage1(x,h);

[hf] = stage23(x,h1,h,R,nPoint,deriv_mode,smooth_mode,alpha,enable_stage2,enable_stage3);

[Xpdf,Ypdf,~] = KDESSEROI(x,{hf},nPoint,h1);
end