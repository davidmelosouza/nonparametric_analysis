function [map]=colordegree(f)

fl = sort(f(:));
V=fl-0.5; ind=find(abs(V)==min(abs(V)));


rs=linspace(1,0,ind);
ks=linspace(1,0,length(V)-ind);

for ir = 1:ind
mr(ir,:)=[rs(ir) 0 0];
end

for ik = 1:length(V)-ind
mk(ik,:)=ks(ik)*[1 1 1];
end

map = [mr; mk];
