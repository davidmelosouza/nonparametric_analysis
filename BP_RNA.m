function [net] = BP_RNA(x,t,n,ind)

% x = X_training';
% t = Y_training';

trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = n;
net = patternnet(hiddenLayerSize, trainFcn);
% net = patternnet([10,10]); %or patternnet(10)
% Setup Division of Data for Training, Validation, Testing
net.divideFcn = 'divideind';
net.divideParam.trainInd = ind.train;
net.divideParam.valInd   = ind.val;
net.divideParam.testInd  = ind.test;

net.trainParam.showWindow=0;
% Train the Network
[net,~] = train(net,x,t);
end
% y = net(x);
