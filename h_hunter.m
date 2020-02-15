function [h,htruth]=h_hunter(DATA,nPoint,method)
r = 0;
type = 'Gaussian';
[~,n,x]= format_data(DATA.sg.evt);
ho = ((4/3)^(1/5))*(std(DATA.sg.evt)*n^(-1/5));
hv=linspace(0.05*ho,6*ho,50);

wb=waitbar(0,'Aguarde[CV]...');
for i = 1:length(hv)
    if strcmp(method,'MLCV');  Cost_MLCV(i)=MLCVfast(x,hv(i)); end
    if strcmp(method,'UCV');  Cost_UCV(i)=UCVfast(x,hv(i),r,type); end
    if strcmp(method,'BCV1');  Cost_BCV1(i)=BCV1fast(x,hv(i),r,type); end
    if strcmp(method,'BCV2');  Cost_BCV2(i)=BCV2fast(x,hv(i),r,type); end
    if strcmp(method,'CCV');  Cost_CCV(i)=CCVfast(x,hv(i),r,type); end
    if strcmp(method,'MCV');  Cost_MCV(i)=MCVfast(x,hv(i),r,type); end
    if strcmp(method,'TCV');  Cost_TCV(i)=TCV(x,hv(i),r,type); end
    if strcmp(method,'LSCV');  Cost_LSCV(i)=LSCVfast(x,hv(i)); end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    h=hv(i)^2;  
    [X,f] = KDEfixed(reshape(DATA.sg.evt,1,DATA.sg.n.evt),h,nPoint);
    ygrid = interp1(X,f,DATA.sg.pdf.truth.x,'linear',0);
    ygrid = reshape(ygrid,1,length(ygrid));
    C(i)=sum(abs(ygrid-DATA.sg.pdf.truth.y));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    waitbar(i/length(hv))
end
close(wb)

if strcmp(method,'MLCV'); h=hv(find(Cost_MLCV==max(Cost_MLCV))); end
if strcmp(method,'UCV'); h=hv(find(Cost_UCV==min(Cost_UCV))); end
if strcmp(method,'BCV1'); h=hv(find(Cost_BCV1==min(Cost_BCV1))); end
if strcmp(method,'BCV2'); h=hv(find(Cost_BCV2==min(Cost_BCV2))); end
if strcmp(method,'CCV'); h=hv(find(Cost_CCV==min(Cost_CCV))); end
if strcmp(method,'MCV'); h=hv(find(Cost_MCV==min(Cost_MCV))); end
if strcmp(method,'TCV'); h=hv(find(Cost_TCV==min(Cost_TCV))); end
if strcmp(method,'LSCV'); h=hv(find(Cost_LSCV==min(Cost_LSCV))); end

if strcmp(method,'SV'); h = ((4/3)^(1/5))*(std(x)*n^(-1/5));  end
if strcmp(method,'SVM1'); h = 0.79*diff(prctile(x, [25; 75]))*(n^(-1/5));  end
if strcmp(method,'SVM2'); h = 0.9*min(std(x),diff(prctile(x, [25; 75]))/1.34)*(n^(-1/5));  end
if strcmp(method,'SJ'); h = SJbandwidth(x'); end
if strcmp(method,'SC'); h = ((243 *(2*r+1)*Rg(kernel_fun_der(type,r)))/(35* A2_kM(type)^2))^(1/(2*r+5)) * std(x) * n^(-1/(2*r+5)); end
% if strcmp(method,'truth'); h = h_truth(DATA,nPoint); end
htruth = hv(find(C==min(C)));
end