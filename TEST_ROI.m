clear;
close;
clc;
ROItype = 'deriv';
vEVT = [25 50 100 500 1000];
g = [{'SMOOTH'};{'FAR'};{'ALL'}];
for ig = 1:length(g)
    group = g{ig};
    if strcmp(group,'ALL')
        G = {'D1a','D1c','D1d','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'};
    elseif strcmp(group,'SMOOTH')
        G = {'D1a','D1c','D1d','D2a'};
    elseif strcmp(group,'FAR')
        G = {'D2c','D3a','D3c','D4c'};
    end
    rangeV=[{1:5};{45:50};{1:50}];
    
    for r=1:length(rangeV)
        if r ==1
            rname = 'min';
        elseif r==2
            rname = 'max';
        elseif r==3
             rname = 'full';
        end
        range = rangeV{r};
        for ie = 1:length(vEVT)
            nEVT=vEVT(ie);
            L = [{'[PI]SV'};{'[PI]SVM1'};{'[PI]SVM2'};{'[PI]SJ'};{'[PI]SC'};{'[PI]L1I'};{'[CV]MLCV'};{'[CV]UCV'};{'[CV]BCV1'};{'[CV]BCV2'};{'[CV]CCV'};{'[CV]MCV'};{'[CV]TCV'};{'[CV]OSCV'};{'[G]h*'};{'[E]h*'}];
            id=0;
            for name = G
                load([pwd '\KDE\Stage2\KDE[2oSTAGE][' ROItype ']DIST[' name{1} ']EVT[' num2str(nEVT) ']'],'e');
                id = id+1;
                for ir=1:50
                    for in=1:25
                        for im=1:14
                            M(in,ir,im) = e{im}(in,ir);
                        end
                    end
                end
                
                MF(id,:,:)=reshape(mean(M),ir,im);
                
            end
            MFT(ie,:,:)=reshape(mean(MF),ir,im);
        end
        MFTE=reshape(mean(MFT),ir,im);
        
        figure
           if strcmp(ROItype,'deriv')
               colormap(gray)
           elseif strcmp(ROItype,'prob')
               colormap(hot)
           end
        plotSURF(MFTE,range); hold on
        grid minor
        set(gca,'Gridlinestyle',':')
        set(gca,'LooseInset',get(gca,'TightInset'))
        
        saveas(gcf,[pwd '\KDE\Stage2\Figuras\ROI[' ROItype ']GROUP[' group ']RANGE[' rname ']'] ,'fig');     
        saveas(gcf,[pwd '\KDE\Stage2\Figuras\ROI[' ROItype ']GROUP[' group ']RANGE[' rname ']'] ,'png');
        close
    end
    
end

