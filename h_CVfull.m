function [hf] = h_CVfull(setup,DATA,hf)
r = 0;
type = 'Gaussian';
[~,n,DADOS]= format_data(DATA.sg.evt);

x = DADOS';
clear DADOS
[hv] = SETrangeH(n);
syms u

[dk] = kernel_fun_der(type,r);
Rdk = Rg(dk);
mu2 = mu(kernel_function([],type,'syms'),0,2);

[d2k] = kernel_fun_der(type,2*r);
cK = kernel_fun_conv(type,r);
FUCV = matlabFunction(cK-2*d2k);

cK = kernel_fun_conv(type,r+2);
FBCV1 = matlabFunction(cK);

cK = kernel_fun_der(type,(2*r)+4);
FBCV2 = matlabFunction(cK);

L1 = matlabFunction(kernel_fun_conv(type,r));
D2 = matlabFunction(kernel_fun_der(type,2*r));
D3 = matlabFunction(kernel_fun_der(type,2*(r+1)));
D4 = matlabFunction(kernel_fun_der(type,2*(r+2)));
D5 = matlabFunction(kernel_fun_der(type,2*r+2));

R_Kr1 = A3_kM(type);

%% OSCV
a=(2*pi)/(pi-2);
b=(-2*sqrt(2*pi))/(pi-2);
n=length(x);
X1=reshape(x,n,1)*ones(1,n);
X2=ones(n,1)*reshape(x,1,n);
Xoscv=X1-X2;
%  Const=0.6168  %(smooth case)
Const=0.5730; %(nonsmooth case)
%%

% wb=waitbar(0,['Aguarde[CV][' num2str(n) ']...']);
for ih = 1:length(hv)
    term.MLCV=0;
    term.UCV=0;
    term.BCV1=0;
    term.BCV2=0;
    term.CCV=0;
    term.MCV=0;
    term.TCV=0;
    term.OSCV=0;
    hs=hv(ih);
    for i=1:n        
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
    
    B=abs(Xoscv/(sqrt(2)*hs));
    M1=((b*b)/4)*(1-gammainc(B.*(B/2),1.5));
    Cost_OSCV(ih)=sum(sum(normpdf(B,0,1).*(M1+sqrt(2)*a*b.*normpdf(B,0,1)+(1-normcdf(B)).*(a*a-(b*b/2)*B.*B))));
    Cost_OSCV(ih)=Cost_OSCV(ih)/(sqrt(2)*n*n*hs);
    termOSCV=(sum(sum((a+b.*abs(Xoscv/hs)).*normpdf(Xoscv/hs,0,1)))-n.*a.*normpdf(0,0,1))/2;
    Cost_OSCV(ih)=Cost_OSCV(ih)-((2*termOSCV)/(n.*(n-1).*hs));
    
    %=============================================================================
    % TRUTH
    %=============================================================================
    % Gaussiano
    [~,~,Cg(ih),~] = KDEfast_fixed_RANGE(setup,DATA,hs,DATA.nPoint);
    [~,~,Ce(ih),~] = KDEfast_fixed_ep_RANGE(setup,DATA,hs,DATA.nPoint);
%      [Xg,fg] = KDEfast_fixed(reshape(DATA.sg.evt,1,DATA.sg.n.evt),hs,DATA.nPoint);
%     ygridg = interp1(Xg,fg,DATA.sg.pdf.truth.x,'linear',0);
%     Cg2(ih)= area2d(DATA.sg.pdf.truth.x,abs(ygridg-DATA.sg.pdf.truth.y));
%     
%     [Xe,fe] = KDEfast_fixed_ep(reshape(DATA.sg.evt,1,DATA.sg.n.evt),hs,DATA.nPoint);
%     ygride = interp1(Xe,fe,DATA.sg.pdf.truth.x,'linear',0);
%     Ce2(ih)= area2d(DATA.sg.pdf.truth.x,abs(ygride-DATA.sg.pdf.truth.y));
end

hf.CV.range = hv;
[ind_TCV] = find(Cost_TCV==min(Cost_TCV));
hf.CV.Cost{7} =  Cost_TCV;
hf.CV.TCV=hv(ind_TCV);

[hf.CV.MLCV,hf.CV.rMLCV,ind_MLCV,Cost_MLCV]= findHCV(hv,Cost_MLCV,hf,'max');
[hf.CV.UCV,hf.CV.rUCV,ind_UCV,Cost_UCV]= findHCV(hv,Cost_UCV,hf,'min');
[hf.CV.BCV1,hf.CV.rBCV1,ind_BCV1,Cost_BCV1] = findHCV(hv,Cost_BCV1,hf,'min');
[hf.CV.BCV2,hf.CV.rBCV2,ind_BCV2,Cost_BCV2] = findHCV(hv,Cost_BCV2,hf,'min');
[hf.CV.CCV,hf.CV.rCCV,ind_CCV,Cost_CCV] = findHCV(hv,Cost_CCV,hf,'min');
[hf.CV.MCV,hf.CV.rMCV,ind_MCV,Cost_MCV] = findHCV(hv,Cost_MCV,hf,'min');
[hf.CV.TCV,hf.CV.rTCV,ind_TCV,Cost_TCV] = findHCV(hv,Cost_TCV,hf,'min');
[hf.CV.OSCV,hf.CV.rOSCV,ind_OSCV,Cost_OSCV] = findHCV(hv,Cost_OSCV,hf,'min');
hf.CV.OSCV = hf.CV.OSCV*Const;
hf.CV.rOSCV = hf.CV.rOSCV*Const;

hvnew=linspace(min(hv),max(hv),1000);
hf.CV.newrange = hvnew;
Cgnew=interp1(hv,Cg,hvnew,'pchip',0);
Cenew=interp1(hv,Ce,hvnew,'pchip',0);

hf.truthG= hvnew(find(Cgnew==min(Cgnew),1));
hf.truthE= hvnew(find(Cenew==min(Cenew),1));


% debug_methods(Cost_MLCV,hv,ind_MLCV.normal,'max'); hold on; title('MLCV')
% pause
% close
% figure
% subplot(2,3,1);debug_methods(Cost_UCV,hv,ind_UCV.normal,'min'); hold on; title('UCV')
% subplot(2,3,2);debug_methods(Cost_BCV1,hv,ind_BCV1.normal,'min'); hold on;title('BCV1')
% subplot(2,3,3);debug_methods(Cost_BCV2,hv,ind_BCV2.normal,'min'); hold on;title('BCV2')
% subplot(2,3,4);debug_methods(Cost_CCV,hv,ind_CCV.normal,'min'); hold on;title('CCV')
% subplot(2,3,5);debug_methods(Cost_MCV,hv,ind_MCV.normal,'min'); hold on;title('MCV')
% % subplot(3,3,1);debug_methods(Cost_TCV,hv,ind_TCV.normal); hold on;title('TCV')
% subplot(2,3,6);debug_methods(Cost_OSCV,hv*Const,ind_OSCV.normal,'min'); hold on;title('OSCV')
% % debug_methods(Cost_BCV2,hv,ind_BCV2.normal); hold on
% pause
% close

hf.CV.Cost{1} =  Cost_MLCV;
hf.CV.Cost{2} =  Cost_UCV;
hf.CV.Cost{3} =  Cost_BCV1;
hf.CV.Cost{4} =  Cost_BCV2;
hf.CV.Cost{5} =  Cost_CCV;
hf.CV.Cost{6} =  Cost_MCV;
hf.CV.Cost{7} =  Cost_TCV;
hf.CV.Cost{8} =  Cost_OSCV;
hf.CV.Cost{9} =  Cgnew;
hf.CV.Cost{10} =  Cenew;

hf.CV.Methods{1} =  hf.CV.rMLCV;
hf.CV.Methods{2} =  hf.CV.rUCV;
hf.CV.Methods{3} =  hf.CV.rBCV1;
hf.CV.Methods{4} =  hf.CV.rBCV2;
hf.CV.Methods{5} =  hf.CV.rCCV;
hf.CV.Methods{6} =  hf.CV.rMCV;
hf.CV.Methods{7} =  hf.CV.rTCV;
hf.CV.Methods{8} =  hf.CV.rOSCV;
hf.CV.Methods{9} =  hf.truthG;
hf.CV.Methods{10} =  hf.truthE;
% hf.CV.Cost{11} =  Cg2;
% hf.CV.Cost{12} =  Ce2;

hf.CV.n(1) =  ind_MLCV.n;
hf.CV.n(2) =  ind_UCV.n;
hf.CV.n(3) =  ind_BCV1.n;
hf.CV.n(4) =  ind_BCV2.n;
hf.CV.n(5) =  ind_CCV.n;
hf.CV.n(6) =  ind_MCV.n;
hf.CV.n(7) =  ind_TCV.n;
hf.CV.n(8) =  ind_OSCV.n;
