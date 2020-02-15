close all; clear; clc;

ESTIMADOR = 'HIST';
vEVT = [25 50 100 500 1000];
% d{id} = [1 3 4 5 7 8 10 11 12 14 15 16];
% d{1} = [1 3 4 5 7 8 10 11 12 14 15 16];
d{1} = [1 3 4];
% d{2} = [5 7 8];
% d{3} = [10 11 12];
% d{4} = [14 15 16];
for id=1:length(d)
    for i = 1:length(vEVT)
        EVENTOS = vEVT(i);
        load([pwd '\' ESTIMADOR '\' ESTIMADOR '[all]EVT[' num2str(EVENTOS) ']'],'BIN','AREA');
        
        DADOS_AREA = [vec(AREA.FD(:,d{id})');vec(AREA.SC(:,d{id})');vec(AREA.ST(:,d{id})');vec(AREA.DO(:,d{id})');vec(AREA.KN(:,d{id})');vec(AREA.WA(:,d{id})');vec(AREA.SS(:,d{id})');vec(AREA.RU(:,d{id})');vec(AREA.LH(:,d{id})');vec(AREA.TR(:,d{id})')];
        
        Pmean{i} = DADOS_AREA;
    end
    
    for ie = 1:5
        for im = 1:9
            METHOD{im}(:,ie) = Pmean{ie}(im,:);
        end
    end
    
    DATA = {METHOD{1};METHOD{2};METHOD{3};METHOD{4};METHOD{5};METHOD{6};METHOD{7};METHOD{8};METHOD{9}};
    
    
        PLOTBOX(DATA,vEVT,'Events','Average Performance','northeast'); hold on
        grid minor
        set(gca,'Gridlinestyle',':')
    
%         saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[PERFORMANCE]'],'fig');
%         saveas(gcf,[pwd '\' ESTIMADOR '\' ESTIMADOR '[PERFORMANCE]'],'png');
%         close
end

L = [{'FD'};{'Scott'};{'Sturges'};{'Doane'};{'Knuth'};{'Wand'};{'Shimazaki'};{'Rudemo'};{'LHM'};{'Bin*'}];
%% Melhor
for it=1:length(DATA)
    TABLE{1}(it,:)= median(DATA{it});
    TABLE{2}(it,:)=iqr(DATA{it});    
end
[i,j]=find(TABLE{1}==min(TABLE{1}));
GM{1}=L(i);
for it=1:5
VM{1}(it)=TABLE{1}(i(it),j(it));
end
[i,j]=find(TABLE{2}==min(TABLE{2}));
GM{2}=L(i);
for it=1:5
VM{2}(it)=TABLE{2}(i(it),j(it));
end
%% Pior
for it=1:length(DATA)
    TABLE{1}(it,:)= median(DATA{it});
    TABLE{2}(it,:)=iqr(DATA{it});    
end
[i,j]=find(TABLE{1}==max(TABLE{1}));
GP{1}=L(i);
for it=1:5
VM{1}(it)=TABLE{1}(i(it),j(it));
end
[i,j]=find(TABLE{2}==max(TABLE{2}));
GP{2}=L(i);
for it=1:5
VP{2}(it)=TABLE{2}(i(it),j(it));
end


