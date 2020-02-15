% DiffBIC function
% mmax: max refinement
% id: decreasing or increasing
function index = DiffBIC(BIC, mmax, id)

m = 2:length(BIC)+1;
%normalized 
len = length(BIC);
mx = max(BIC);
mn = min(BIC);
BIC = (len-1)*(BIC-mn)/(mx-mn);

B1m = BIC./m; %log2(abs(B1))./m;

mx1 = max(B1m);
mn1 = min(B1m);

B1m = (len-1)*(B1m-mn1)/(mx1-mn1);
switch(id)
    case 0,
        index = abs(BIC+B1m)/2;
    case 1,
        index = abs(BIC-B1m)/2;
end
index = index(1:mmax);


