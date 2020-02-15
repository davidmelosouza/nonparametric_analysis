function [Zica] = ICAset(DATA,W) 
% [z_cw] = myCenterAndWhiten(DATA);
% Zica = A * z_cw;

[DATA, mixedmean] = remmean(DATA);
[Dim, NumOfSampl] = size(DATA);
Zica = W * DATA + (W * mixedmean) * ones(1, NumOfSampl);