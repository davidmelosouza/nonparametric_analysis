function [H] = HM(h,im,id)

H.SV(im,id)= h.PI.SV;
H.SVM1(im,id)= h.PI.SVM1;
H.SVM2(im,id)= h.PI.SVM2;
H.SJ(im,id)= h.PI.SJ;
H.SC(im,id)= h.PI.SC;
H.L1I(im,id)= h.PI.L1I;

H.MLCV(im,id)= h.CV.MLCV;
H.UCV(im,id)= h.CV.UCV;
H.BCV1(im,id)= h.CV.BCV1;
H.BCV2(im,id)= h.CV.BCV2;
H.CCV(im,id)= h.CV.CCV;
H.MCV(im,id)= h.CV.MCV;
H.TCV(im,id)= h.CV.TCV;
H.OSCV(im,id)= h.CV.OSCV;
H.TR(im,id)= h.truth;

H.nMLCV(im,id)= h.CV.nMLCV;
H.nUCV(im,id)= h.CV.nUCV;
H.nBCV1(im,id)= h.CV.nBCV1;
H.nBCV2(im,id)= h.CV.nBCV2;
H.nCCV(im,id)= h.CV.nCCV;
H.nMCV(im,id)= h.CV.nMCV;
H.nTCV(im,id)= NaN;
H.nOSCV(im,id)= h.CV.nOSCV;
H.nTR(im,id)= NaN;

end