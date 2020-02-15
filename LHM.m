function [BIN,nbin,C,iknee]= LHM(DATA,interp)
load binmax
[ycdf,xcdf]=ecdf(DATA);
nEVT=length(DATA);
x = linspace(min(DATA),max(DATA),10^5);
% nbin=[2:sqrt(nEVT) round(nEVT/sqrt(nEVT)):nEVT/4 nEVT];
% nbin=[2:4:200 floor(linspace(50+1,nEVT,100))];
% nbin=[2:1:50 50:2:100 floor(linspace(100+2,nEVT,10))];
nbin=[2:1:binmax];
for ibin = 1:length(nbin)
    bin=nbin(ibin);
R = linspace(min(DATA),max(DATA),bin+1);
I=0;
for i=1:bin
    I=I + sum(DATA>=R(i) &  DATA<=R(i+1));
    CDFbin(i)=I/length(DATA);
end
d=diff(R); d=d(1)/2;
CDFrange = R(2:end);

CDFgrid_bin=interp1(CDFrange,CDFbin,x,interp,'extrap');
[~,ind] = unique(xcdf);
CDFgrid_e=interp1(xcdf(ind),ycdf(ind),x,interp,'extrap');
C(ibin) = sum(abs(CDFgrid_bin-CDFgrid_e));

% plot(x,CDFgrid_e,'r'); hold on
% plot(x,CDFgrid_bin,'k');
% pause
clear CDFbin
end
% [~, iknee] = knee_pt(C,nbin);
% C=smooth(nbin,C);
C = reshape(C,1,length(C));

DBICM = DiffBIC(C, 149, 0);
[~, b] = max(DBICM);
DBIC = b+1;

ABIC=AngleCalc(C)+1;
[DP]=kneepoint(C);
% disp(DBIC);
iknee = max([DBIC ABIC DP]);

BIN = nbin(iknee);
% save C C
% pause
% plot(nbin,C,':k'); hold on
% plot(nbin(iknee),C(iknee),'or')
% pause
% close
% 
% pause
% close

