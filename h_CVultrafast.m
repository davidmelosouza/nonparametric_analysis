function [hf] = h_CVultrafast(DATA,hf)
% ho = 0.5;
% ih = 1;
r = 0;
type = 'Gaussian';
[~,n,DADOS]= format_data(DATA);
x = DADOS';
clear DADOS
hv=linspace(hf.PI.SJ/10,5*hf.PI.SJ,100);
syms u

[dk] = kernel_fun_der(type,r);
Rdk = Rg(dk);
% mu2 = mu(kernel_function([],type,'syms'),0,2);
% 
% [d2k] = kernel_fun_der(type,2*r);
% cK = kernel_fun_conv(type,r);
% FUCV = matlabFunction(cK-2*d2k);
% 
% cK = kernel_fun_conv(type,r+2);
% FBCV1 = matlabFunction(cK);
% 
% cK = kernel_fun_der(type,2*r+4);
% FBCV2 = matlabFunction(cK);

L1 = matlabFunction(kernel_fun_conv(type,r));
D2 = matlabFunction(kernel_fun_der(type,2*r));
% D3 = matlabFunction(kernel_fun_der(type,2*(r+1)));
% D4 = matlabFunction(kernel_fun_der(type,2*(r+2)));
% D5 = matlabFunction(kernel_fun_der(type,2*r+2));

R_Kr1 = A3_kM(type);

% wb=waitbar(0,['Aguarde[CV][' num2str(n) ']...']);
for ih = 1:length(hv)
    [X] = fastM(x);
    hs=hv(ih);
    
%     Q1 = sum(((-1)^(r)/((n-1)*hs^(2*r+1)))*L1(X/hs));
%     Q2 = sum(((-1)^r /((n-1)*hs^(2*r+1)))*D2(X/hs));
%     Q3 = sum(((-1)^(r+1) /((n-1)*hs^(2*r+3)))*D3(X/hs));
%     Q4 = sum(((-1)^(r+2) /((n-1)*hs^(2*r+5)))*D4(X/hs));
%     
%     
% %     Q1 = ((-1)^r / ((n-1)*hs^(2*r+1)))*sum(L1(X/hs));
% %     Q2 = ((-1)^r / ((n-1)*hs^(2*r+1)))*sum(D2(X/hs));
%     Q3 = ((-1)^r / ((n-1)*hs^(2*r+1)))*sum(D5(X/hs));
%       
    indT= (abs(X/hs)>(1/(n*hs^(2*r+1)))); indT = double(indT);
    Q1 = sum(((-1)^(r)/((n-1)*hs^(2*r+1)))*indT.*L1(X/hs));
    Q2 = sum(((-1)^(r)/((n-1)*hs^(2*r+1)))*indT.*D2(X/hs));

    
  
    
%     Cost_MLCV(ih)=(n^-1)*sum(log(mean(kernel_function(X/hs,'Gaussian','none')))-log((hs*(n-1))));
%     Cost_UCV(ih)=(Rdk*(1/(n*hs^((2*r)+1))))+((-1)^r / ((n-1)*hs^((2*r)+1)))*sum(mean(FUCV(X/hs)));
%     Cost_BCV1(ih)= (Rdk*(1/(n*hs^((2*r)+1))))+((0.25*hs^4)*(mu2)^2)*sum(mean((((-1)^(r+2))/((n-1)*hs^((2*r)+5)))*FBCV1(X/hs)));
%     Cost_BCV2(ih)= (Rdk*(1/(n*hs^((2*r)+1))))+((0.25*hs^4)*(mu2)^2)*sum(mean((((-1)^(r+2))/((n-1)*hs^((2*r)+5)))*FBCV2(X/hs)));
%     Cost_CCV(ih)= (1/n)*sum((1/(n*hs^(2*r+1)))* Rdk + Q1 - Q2 + 0.5 * hs^2 *A2_kM(type) * Q3 + (hs^4 / 24) *(6*(A2_kM(type))^2 - A5_kM(type)) * Q4);
%     Cost_MCV(ih)= (1/n)*sum((1/(n*hs^(2*r+1)))*R_Kr1 + Q1 - Q2 -  0.5 * A2_kM(type) * Q3);
    Cost_TCV(ih)= (1/n)*sum((1/(n*hs^(2*r+1)))*Rdk + Q1 - 2 * Q2);
      clear X
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Truth
    
%     h=hs^2;
%     [X2,f] = KDEfixed(reshape(DATA.sg.evt,1,DATA.sg.n.evt),h,DATA.nPoint);
%     ygrid = interp1(X2,f,DATA.sg.pdf.truth.x,'linear',0);
%     C(ih)=sum(abs(ygrid-DATA.sg.pdf.truth.y));
    
%     waitbar(ih/length(hv))
end

% close(wb)
% [hf.CV.MLCV]=hv(find(Cost_MLCV==max(Cost_MLCV)));
% [hf.CV.UCV] = findmin(hv,Cost_UCV);
% [hf.CV.BCV1] = findmin(hv,Cost_BCV1);
% [hf.CV.BCV2] = findmin(hv,Cost_BCV2);
% [hf.CV.CCV] = findmin(hv,Cost_CCV);
% [hf.CV.MCV] = findmin(hv,Cost_MCV);
% [hf.CV.TCV] = findmin(hv,Cost_TCV);
% hf.truth= hv(find(C==min(C)));

% hf.CV.UCV=hv(find(Cost_UCV==min(Cost_UCV)));
% hf.CV.BCV1=hv(find(Cost_BCV1==min(Cost_BCV1)));
% hf.CV.BCV2=hv(find(Cost_BCV2==min(Cost_BCV2)));
% hf.CV.CCV=hv(find(Cost_CCV==min(Cost_CCV)));
% hf.CV.MCV=hv(find(Cost_MCV==min(Cost_MCV)));
hf.CV.TCV=hv(find(Cost_TCV==min(Cost_TCV)));
% hf.truth= hv(find(C==min(C)));

% hf.CV.Cost(1,:) =  Cost_MLCV;
% hf.CV.Cost(2,:) =  Cost_UCV;
% hf.CV.Cost(3,:) =  Cost_BCV1;
% hf.CV.Cost(4,:) =  Cost_BCV2;
% hf.CV.Cost(5,:) =  Cost_CCV;
% hf.CV.Cost(6,:) =  Cost_MCV;
% hf.CV.Cost(7,:) =  Cost_TCV;
% hf.CV.range = hv;