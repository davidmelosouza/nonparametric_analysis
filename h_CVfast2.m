function [hf] = h_CVfast2(DATA,hf)
r = 0;
type = 'Gaussian';
[~,n,DADOS]= format_data(DATA);
x = DADOS';

hv=linspace(hf.PI.SJ/10,5*hf.PI.SJ,100);
syms u

[dk] = kernel_fun_der(type,r);
Rdk = Rg(dk);
mu2 = mu(kernel_function([],type,'syms'),0,2);

[d2k] = kernel_fun_der(type,2*r);
cK = kernel_fun_conv(type,r);
FUCV = matlabFunction(cK-2*d2k);

cK = kernel_fun_conv(type,r+2);
FBCV1 = matlabFunction(cK);

cK = kernel_fun_der(type,2*r+4);
FBCV2 = matlabFunction(cK);

L1 = matlabFunction(kernel_fun_conv(type,r));
D2 = matlabFunction(kernel_fun_der(type,2*r));
D3 = matlabFunction(kernel_fun_der(type,2*(r+1)));
D4 = matlabFunction(kernel_fun_der(type,2*(r+2)));
D5 = matlabFunction(kernel_fun_der(type,2*r+2));

R_Kr1 = A3_kM(type);

% wb=waitbar(0,['Aguarde[CV][' num2str(n) ']...']);
for ih = 1:length(hv)
    term.MLCV=0;
    term.UCV=0;
    term.BCV1=0;
    term.BCV2=0;
    term.CCV=0;
    term.MCV=0;
    term.TCV=0;
    hs=hv(ih);
    for i=1:n
        %X = (x(x~=x(i))-x(i))/hs;
        ind  = 1:n;
        X = (x(ind~=i)-x(i))/hs;
        P1 = log(mean(kernel_function(X,'Gaussian','none')));
        P2 = log((hs*(n-1)));
        if isinf(P1)
            P1 = log(1e-256);
        end
        if isinf(P2)
            P2 = log(1e-256);
        end
        
        term.MLCV=term.MLCV+P1-P2;   %  The sqrt(2) factors are for
        term.UCV=term.UCV+mean(FUCV(X));
        term.BCV1=term.BCV1+mean((((-1)^(r+2))/((n-1)*hs^((2*r)+5)))*FBCV1(X));
        term.BCV2=term.BCV2+mean((((-1)^(r+2))/((n-1)*hs^((2*r)+5)))*FBCV2(X));
        
        Q1 = sum(((-1)^(r)/((n-1)*hs^(2*r+1)))*L1(X));
        Q2 = sum(((-1)^r /((n-1)*hs^(2*r+1)))*D2(X));
        Q3 = sum(((-1)^(r+1) /((n-1)*hs^(2*r+3)))*D3(X));
        Q4 = sum(((-1)^(r+2) /((n-1)*hs^(2*r+5)))*D4(X));
        term.CCV=term.CCV+(1/(n*hs^(2*r+1)))* Rdk + Q1 - Q2 + 0.5 * hs^2 *A2_kM(type) * Q3 + (hs^4 / 24) *(6*(A2_kM(type))^2 - A5_kM(type)) * Q4;
        
        Q1 = ((-1)^r / ((n-1)*hs^(2*r+1)))*sum(L1(X));
        Q2 = ((-1)^r / ((n-1)*hs^(2*r+1)))*sum(D2(X));
        Q3 = ((-1)^r / ((n-1)*hs^(2*r+1)))*sum(D5(X));
        term.MCV=term.MCV+ (1/(n*hs^(2*r+1)))*R_Kr1 + Q1 - Q2 -  0.5 * A2_kM(type) * Q3 ;
        
        IC = abs(X)>(1/(n*hs^(2*r+1)));
        X = X(IC);
       
        Q1 = sum(((-1)^(r)/((n-1)*hs^(2*r+1)))*L1(X));
        Q2 = sum(((-1)^(r)/((n-1)*hs^(2*r+1)))*D2(X));
        term.TCV=term.TCV+(1/(n*hs^(2*r+1)))*Rdk + Q1 - 2 * Q2 ;
        
    end
    Cost_MLCV(ih)=(n^-1)*term.MLCV;
    Cost_UCV(ih)=(Rdk*(1/(n*hs^((2*r)+1))))+((-1)^r / ((n-1)*hs^((2*r)+1)))*term.UCV;
    Cost_BCV1(ih)= (Rdk*(1/(n*hs^((2*r)+1))))+((0.25*hs^4)*(mu2)^2)*term.BCV1;
    Cost_BCV2(ih)= (Rdk*(1/(n*hs^((2*r)+1))))+((0.25*hs^4)*(mu2)^2)*term.BCV2;
    Cost_CCV(ih)= (1/n)*term.CCV;
    Cost_MCV(ih)= (1/n)*term.MCV;
    Cost_TCV(ih)= (1/n)*term.TCV;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Truth
%     h=hs^2;
%     [X,f] = KDEfixed(reshape(DATA.sg.evt,1,DATA.sg.n.evt),h,DATA.nPoint);
%     ygrid = interp1(X,f,DATA.sg.pdf.truth.x,'linear',0);
%     %     ygrid = reshape(ygrid,length(ygrid),1);
%     C(ih)=sum(abs(ygrid-DATA.sg.pdf.truth.y));
    
    %     waitbar(ih/length(hv))
end



% close(wb)

[hf.CV.MLCV]=hv(find(Cost_MLCV==max(Cost_MLCV))); hf.CV.MLCV = hf.CV.MLCV(1);
% [hf.CV.UCV] = findmin(hv,Cost_UCV);
% [hf.CV.BCV1] = findmin(hv,Cost_BCV1);
% [hf.CV.BCV2] = findmin(hv,Cost_BCV2);
% [hf.CV.CCV] = findmin(hv,Cost_CCV);
% [hf.CV.MCV] = findmin(hv,Cost_MCV);
% [hf.CV.TCV] = findmin(hv,Cost_TCV);
% hf.truth= hv(find(C==min(C)));
%
% if isempty(hf.CV.MLCV); hf.CV.MLCV = ho; end
% if isempty(hf.CV.UCV); hf.CV.UCV = ho; end
% if isempty(hf.CV.BCV1); hf.CV.BCV1 = ho; end
% if isempty(hf.CV.BCV2); hf.CV.BCV2 = ho; end
% if isempty(hf.CV.CCV); hf.CV.CCV = ho; end
% if isempty(hf.CV.MCV); hf.CV.MCV = ho; end
% if isempty(hf.CV.TCV); hf.CV.TCV = ho; end

hf.CV.UCV=hv(find(Cost_UCV==min(Cost_UCV)));
hf.CV.BCV1=hv(find(Cost_BCV1==min(Cost_BCV1)));
hf.CV.BCV2=hv(find(Cost_BCV2==min(Cost_BCV2)));
hf.CV.CCV=hv(find(Cost_CCV==min(Cost_CCV)));
hf.CV.MCV=hv(find(Cost_MCV==min(Cost_MCV)));
hf.CV.TCV=hv(find(Cost_TCV==min(Cost_TCV)));
% hf.truth= hv(find(C==min(C)));

if (hf.CV.MLCV==hv(end)); hf.CV.MLCV = hf.CV.TCV; end
if (hf.CV.UCV==hv(end)); hf.CV.UCV = hf.CV.TCV; end
if (hf.CV.BCV1==hv(end)); hf.CV.BCV1 = hf.CV.TCV; end
if (hf.CV.BCV2==hv(end)); hf.CV.BCV2 = hf.CV.TCV; end
if (hf.CV.CCV==hv(end)); hf.CV.CCV = hf.CV.TCV; end
if (hf.CV.MCV==hv(end)); hf.CV.MCV = hf.CV.TCV; end
if (hf.CV.TCV==hv(end)); hf.CV.TCV = hf.CV.TCV; end


hf.CV.Cost(1,:) =  Cost_MLCV;
hf.CV.Cost(2,:) =  Cost_UCV;
hf.CV.Cost(3,:) =  Cost_BCV1;
hf.CV.Cost(4,:) =  Cost_BCV2;
hf.CV.Cost(5,:) =  Cost_CCV;
hf.CV.Cost(6,:) =  Cost_MCV;
hf.CV.Cost(7,:) =  Cost_TCV;
hf.CV.range = hv;