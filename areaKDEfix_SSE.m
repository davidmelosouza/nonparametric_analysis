function [A,L2,X,pdf] = areaKDEfix_SSE(setup,DATA,nPoint,h)

[X.SV,pdf.SV,A(1),L2(1)] = KDE_SSE(setup,DATA,h.PI.SV,nPoint);
[X.SVM1,pdf.SVM1,A(2),L2(2)] = KDE_SSE(setup,DATA,h.PI.SVM1,nPoint);
[X.SVM2,pdf.SVM2,A(3),L2(3)] = KDE_SSE(setup,DATA,h.PI.SVM2,nPoint);
[X.SJ,pdf.SJ,A(4),L2(4)] = KDE_SSE(setup,DATA,h.PI.SJ,nPoint);
[X.SC,pdf.SC,A(5),L2(5)] = KDE_SSE(setup,DATA,h.PI.SC,nPoint);
[X.L1I,pdf.L1I,A(6),L2(6)] = KDE_SSE_ep(setup,DATA,h.PI.L1I,nPoint);
[X.MLCV,pdf.MLCV,A(7),L2(7)] = KDE_SSE(setup,DATA,h.CV.MLCV,nPoint);
[X.UCV,pdf.UCV,A(8),L2(8)] = KDE_SSE(setup,DATA,h.CV.UCV,nPoint);
[X.BCV1,pdf.BCV1,A(9),L2(9)] = KDE_SSE(setup,DATA,h.CV.BCV1,nPoint);
[X.BCV2,pdf.BCV2,A(10),L2(10)] = KDE_SSE(setup,DATA,h.CV.BCV2,nPoint);
[X.CCV,pdf.CCV,A(11),L2(11)] = KDE_SSE(setup,DATA,h.CV.CCV,nPoint);
[X.MCV,pdf.MCV,A(12),L2(12)] = KDE_SSE(setup,DATA,h.CV.MCV,nPoint);
[X.TCV,pdf.TCV,A(13),L2(13)] = KDE_SSE(setup,DATA,h.CV.TCV,nPoint);
[X.OSCV,pdf.OSCV,A(14),L2(14)] = KDE_SSE(setup,DATA,h.CV.OSCV,nPoint);
[X.TRUTHG,pdf.TRUTHG,A(15),L2(15)] = KDEfast_fixed_RANGE(setup,DATA,h.truthG,nPoint);
[X.TRUTHE,pdf.TRUTHE,A(16),L2(16)] = KDE_SSE_ep(setup,DATA,h.truthE,nPoint);

[X.rMLCV,pdf.rMLCV,A(17),L2(17)] = KDE_SSE(setup,DATA,h.CV.rMLCV,nPoint);
[X.rUCV,pdf.rUCV,A(18),L2(18)] = KDE_SSE(setup,DATA,h.CV.rUCV,nPoint);
[X.rBCV1,pdf.rBCV1,A(19),L2(19)] = KDE_SSE(setup,DATA,h.CV.rBCV1,nPoint);
[X.rBCV2,pdf.rBCV2,A(20),L2(20)] = KDE_SSE(setup,DATA,h.CV.rBCV2,nPoint);
[X.rCCV,pdf.rCCV,A(21),L2(21)] = KDE_SSE(setup,DATA,h.CV.rCCV,nPoint);
[X.rMCV,pdf.rMCV,A(22),L2(22)] = KDE_SSE(setup,DATA,h.CV.rMCV,nPoint);
[X.rOSCV,pdf.rOSCV,A(23),L2(23)] = KDE_SSE(setup,DATA,h.CV.rOSCV,nPoint);


end