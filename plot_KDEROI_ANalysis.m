close
clear
clc

i=0;
for ie = 1:5
    i=0;
    for name ={'D1d','D2a'}
        i=i+1;
        load([pwd '\KDE\KDEROI[STAGE]DIST[' name{1} ']'],'K');
        DADOS = [(mean((K{2}(:,ie)-K{1}(:,ie))'));(mean((K{3}(:,ie)-K{1}(:,ie))'));(mean((K{4}(:,ie)-K{1}(:,ie))'))];
        DATA{ie}(i,:)=DADOS;
        %     stem(DADOS)
        
        
    end
end

for i=1:length(DATA)
M(i,:)=mean(DATA{i});
end


plot(M,'s:')
legend('S1','S2','S3')
% pause
% close

