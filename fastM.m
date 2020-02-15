function [F] = fastM(x)
XM = zeros(length(x),length(x));
XD = zeros(length(x),length(x));
XO = zeros(length(x),length(x));
F = zeros(length(x)-1,length(x));

XM=repmat(x,1,length(x));
XD=repmat(x',length(x),1);
XO = XM-XD;
remove_diagonal = @(t)reshape(t(~diag(ones(1,size(t, 1)))), size(t)-[1 0]);
F=remove_diagonal(XO);
end