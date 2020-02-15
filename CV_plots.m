close all; clear; clc;

ESTIMADOR = 'KDE';
name=['[CV]MLCV';'[CV]UCV ';'[CV]BCV1';'[CV]BCV2';'[CV]CCV ';'[CV]MCV ';'[CV]TCV ';'h*      '];
for i=1:6
    ie=0;
    for EVENTOS = [100 500 1000 2000 5000]
        ie = ie+1;
        for j=1:16
            load([pwd '\' ESTIMADOR '\CVFIX[all]EVT[' num2str(EVENTOS) ']'],'H','AREA');
            
            
            H_TCV(i,:) =H{8}.min(:,j)-H{7}.min(:,j);
            H_FIND(i,:) = H{8}.min(:,j)-H{i}.find(:,j);
            H_MIN(i,:) = H{8}.min(:,j)-H{i}.min(:,j);
            
            A_TCV(i,:) =abs(AREA{7}.min(:,j));
            A_FIND(i,:) = abs(AREA{i}.find(:,j));
            A_MIN(i,:) = abs(AREA{i}.min(:,j));
            
            %    subplot(2,3,i); plot(H_TCV,A_TCV,'ok'); hold on
            %    subplot(2,3,i); plot(H_FIND,A_FIND,'+r')
            %    subplot(2,3,i); plot(H_MIN,A_MIN,'.b')
            
            %             subplot(2,4,i);errorbar(EVENTOS, mu.tcv,sd.tcv/sqrt(25),'s:k','markersize',3); hold on
            %             subplot(2,4,i);errorbar(EVENTOS,mu.find,sd.min/sqrt(25),'o:r','markersize',3);hold on
            %             subplot(2,4,i);errorbar(EVENTOS, mu.min,sd.find/sqrt(25),'^:b','markersize',3);hold on
             %         set(gca,'YScale','log')
        end
        HTCV(ie,:) =H_TCV(:);
        HFIND(ie,:) =H_FIND(:);
        HMIN(ie,:) =H_MIN(:);
        ATCV(ie,:) =A_TCV(:);
        AFIND(ie,:) =A_FIND(:);
        AMIN(ie,:) =A_MIN(:);
    end
    
    
    legend('TCV','find','min')
    x = [HTCV(:); HFIND(:); HMIN(:)];
    y = [ATCV(:); AFIND(:); AMIN(:)];
    
    for in=1:length(ATCV(:))
        method_TCV(in) = {'TCV '};
        method_FIND(in) = {'FIND'};
        method_MIN(in) = {'MIN '};
    end
    
    method = [method_TCV'; method_FIND'; method_MIN'];
    
    
    %     h = scatterhist(x,y,'Group',method,'Color','kbr','LineWidth',[2,2,2],'Marker','.+o');
    %     grid on
    %     set(h,'gridlinestyle',':')
    %     hold on;
    %     clr = get(h(1),'colororder');
    %     boxplot(h(2),x,method,'PlotStyle','compact','orientation','horizontal',...
    %         'label',{'','',''},'color','kbr');
    %     boxplot(h(3),y,method,'PlotStyle','compact','orientation','horizontal',...
    %         'label', {'','',''},'color','kbr');
    %     set(h(2:3),'XTickLabel','');
    %     view(h(3),[270,90]);  % Rotate the Y plot
    %     axis(h(1),'auto');  % Sync axes
    %     hold off;
    
    scatterhist(x,y,'Group',method,'kernel','on','Location','SouthEast',...
        'Direction','out','Color','kbr','LineStyle',{'-','-.',':'},...
        'LineWidth',[2,2,2],'Marker','+.o','MarkerSize',[4,5,6]);
    xlabel('\Deltah')
    ylabel('Error Area')
    set(gca,'YScale','log','YScale','log')
    title(name(i,:));
    pause
    close
    clear HTCV H_TCV ATCV HFIND  H_FIND AFIND HMIN H_MIN AMIN
    %     pause
    %     close
end