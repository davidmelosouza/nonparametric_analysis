% optBINS finds the optimal number of bins for a one-dimensional
% data set using the posterior probability for the number of bins
% This algorithm uses a brute-force search trying every possible
% bin number in the given range. This can of course be improved.
% Generalization to multidimensional data sets is straightforward.
%
% Usage:
% optM = optBINS(data,maxM);
% Where:
% data is a (1,N) vector of data points
% maxM is the maximum number of bins to consider
%
% Ref: K.H. Knuth. 2012. Optimal data-based binning for histograms
% and histogram-based probability density models, Entropy.
function [optM,logp] = optKnuth(data,maxM)
data = reshape(data,1,length(data));
% if size(data)>2 || size(data,1)>1
% error('data dimensions must be (1,N)');
% end
N = size(data,2);
% Simply loop through the different numbers of bins
% and compute the posterior probability for each.
logp = zeros(1,maxM);
for M = 1:maxM
n = hist(data,M); % Bin the data (equal width bins here)
part1 = N*log(M) + gammaln(M/2) - gammaln(N+M/2);
part2 = - M*gammaln(1/2) + sum(gammaln(n+0.5));
logp(M) = part1 + part2;
end
[maximum, optM] = max(logp);
if optM <= 1
    optM = 2;
end
return;