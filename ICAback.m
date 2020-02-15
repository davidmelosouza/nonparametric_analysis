function [Zout] = ICAback(ICA) 
Zout = ICA.T \ pinv(ICA.A) * ICA.DATA + repmat(ICA.mu,1,length(ICA.DATA)); % Low-dimensional approximation of z

