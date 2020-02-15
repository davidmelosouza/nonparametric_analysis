function [hf] = h_truth(setup,DATA)

[hv] = SETrangeH(length(DATA.sg.evt));
% wb=waitbar(0,['Aguarde[CV][' num2str(n) ']...']);
for ih = 1:length(hv)
    hs = hv(ih);
    [~,~,Cg(ih),~] = KDEfast_fixed_RANGE(setup,DATA,hs,DATA.nPoint);
%     [~,~,Ce(ih),~] = KDEfast_fixed_ep_RANGE(setup,DATA,hs,DATA.nPoint);
end


hvnew=linspace(min(hv),max(hv),1000);
hf.CV.newrange = hvnew;
Cgnew=interp1(hv,Cg,hvnew,'pchip',0);
% Cenew=interp1(hv,Ce,hvnew,'pchip',0);

hf.truthG= hvnew(find(Cgnew==min(Cgnew),1));
% hf.truthE= hvnew(find(Cenew==min(Cenew),1));


end
