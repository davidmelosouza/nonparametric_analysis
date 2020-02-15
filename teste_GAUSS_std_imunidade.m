clear;
nPoint = 10^4;
ngrid = 10^5;
sg_n = 25;
r = 0;
sg_stdv = logspace(-1,2,50);
for isk=1:100
    isk
    for istd=1:length(sg_stdv)
        sg_std=sg_stdv(istd);
        sg_mu = 0;
        
        sg_evt = sg_mu+sg_std*randn(sg_n,1);
        [h] = h_plugin(sg_evt);
        [h] = h_CVfull_ATLAS(sg_evt,h);
        [A.TCV(isk,istd)] = errorSTD(sg_evt,h.CV.TCV,nPoint,ngrid,sg_mu,sg_std);
        [A.L1I(isk,istd),sg_x] = errorSTD(sg_evt,h.PI.L1I,nPoint,ngrid,sg_mu,sg_std);
        [A.SVM2(isk,istd)] = errorSTD(sg_evt,h.PI.SVM2,nPoint,ngrid,sg_mu,sg_std);
        
        for i=1:length(sg_evt)
            ind  = 1:sg_n;
            X = (sg_evt(ind~=i)-sg_evt(i))/h.CV.TCV;
            nS.TCV(i)= sum(abs(X)>(1/(sg_n*h.CV.TCV^(2*r+1))))/sg_n;
%             nS.L1I(i)= sum(abs(X)<=1)/sg_n;
            
        end
        
        for j=1:ngrid
            u = (sg_x(j)-sg_evt)/h.PI.L1I;
            nS.L1I(j)= sum(abs(u)<=1)/sg_n;
        end
        
        
        sk(isk,istd)= skewness(sg_evt);
        pS.L1I(isk,istd)= mean(nS.L1I);
        pS.TCV(isk,istd)= mean(nS.TCV);
        [max(nS.L1I) max(nS.TCV)]
        %             plot(sg_x,sg_y); hold on
    end
    
    %     pause(0.05)
end

errorbar(sg_stdv,mean(A.TCV),std(A.TCV)/(sqrt(length(A.TCV))),'sb:'); hold on
errorbar(sg_stdv,mean(A.L1I),std(A.L1I)/(sqrt(length(A.L1I))),'sk:');
errorbar(sg_stdv,mean(A.SVM2),std(A.SVM2)/(sqrt(length(A.SVM2))),'sr:');
legend('TCV','L1I','SVM2')
set(gca,'Xscale','log')
set(gca,'Yscale','log')
