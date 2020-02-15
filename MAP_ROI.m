function [] = MAP_ROI(DATA,DC,Y,ind)
nROI = length(ind);
Xnew=[0 DATA.sg.RoI.Xaxis];
for im=size(Y{1},1):-1:1
    D = DC(im,:);
    D=D(ind);
    indu = find(D>0);
    inds = find(D==0);
    indd = find(D<0);
    ND = max(max((abs(DC))));
    
 for i = 1:nROI
        if sum(i==indu)==1            
            cl = [1-abs(D(i)/ND) 1-abs(D(i)/ND) 1];
            if isnan(1-abs(D(i)/ND))
                cl = [1 1 1];
            end
            area([Xnew(i) Xnew(i+1)], [im im],'EdgeColor',cl,'FaceColor',cl);axis tight; hold on
        end
        if sum(i==indd)==1            
            cl = [1 1-abs(D(i)/ND) 1-abs(D(i)/ND)];
            if isnan(1-abs(D(i)/ND))
                cl = [1 1 1];
            end
            area([Xnew(i) Xnew(i+1)], [im im],'EdgeColor',cl,'FaceColor',cl);axis tight; hold on
        end
        if sum(i==inds)==1            
            area([Xnew(i) Xnew(i+1)], [im im],'EdgeColor',[1 1 1],'FaceColor',[1 1 1]);axis tight; hold on
        end
        
    end
end     

set(gca,'YTick',[1:size(Y{1},1)]-0.5,'YTickLabel',['BKDE  '; 'AKDE  ';'VKDE  ';'ROIKDE']);

for im=1:size(Y{1},1)-1
    plot([min(Xnew) max(Xnew)],[im im],'color',[1 1 1],'linewidth',2);
end