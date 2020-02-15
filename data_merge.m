
vEVT = [100 500 1000 2000 5000];


for nEVT=vEVT
    load([pwd '\KDE\KDE[all]EVT[' num2str(nEVT) ']'],'H','AREA');
    H_ALL.SV= H.SV;
    H_ALL.SVM1= H.SVM1;
    H_ALL.SVM2= H.SVM2;
    H_ALL.SJ= H.SJ;
    H_ALL.SC= H.SC;
    H_ALL.MLCV= H.MLCV;
    H_ALL.UCV= H.UCV;
    H_ALL.BCV1= H.BCV1;
    H_ALL.BCV2= H.BCV2;
    H_ALL.CCV= H.CCV;
    H_ALL.MCV= H.MCV;
    H_ALL.TCV= H.TCV;
    H_ALL.TR= H.TR;
    
    AREA_ALL.SV= AREA.SV;
    AREA_ALL.SVM1= AREA.SVM1;
    AREA_ALL.SVM2= AREA.SVM2;
    AREA_ALL.SJ= AREA.SJ;
    AREA_ALL.SC= AREA.SC;
    AREA_ALL.MLCV= AREA.MLCV;
    AREA_ALL.UCV= AREA.UCV;
    AREA_ALL.BCV1= AREA.BCV1;
    AREA_ALL.BCV2= AREA.BCV2;
    AREA_ALL.CCV= AREA.CCV;
    AREA_ALL.MCV= AREA.MCV;
    AREA_ALL.TCV= AREA.TCV;
    AREA_ALL.TR= AREA.TR;
    
    load([pwd '\KDE\KDE[disc]EVT[' num2str(nEVT) ']'],'H','AREA');
    
    H_DISC.SV= H.SV;
    H_DISC.SVM1= H.SVM1;
    H_DISC.SVM2= H.SVM2;
    H_DISC.SJ= H.SJ;
    H_DISC.SC= H.SC;
    H_DISC.MLCV= H.MLCV;
    H_DISC.UCV= H.UCV;
    H_DISC.BCV1= H.BCV1;
    H_DISC.BCV2= H.BCV2;
    H_DISC.CCV= H.CCV;
    H_DISC.MCV= H.MCV;
    H_DISC.TCV= H.TCV;
    H_DISC.TR= H.TR;
    
    AREA_DISC.SV= AREA.SV;
    AREA_DISC.SVM1= AREA.SVM1;
    AREA_DISC.SVM2= AREA.SVM2;
    AREA_DISC.SJ= AREA.SJ;
    AREA_DISC.SC= AREA.SC;
    AREA_DISC.MLCV= AREA.MLCV;
    AREA_DISC.UCV= AREA.UCV;
    AREA_DISC.BCV1= AREA.BCV1;
    AREA_DISC.BCV2= AREA.BCV2;
    AREA_DISC.CCV= AREA.CCV;
    AREA_DISC.MCV= AREA.MCV;
    AREA_DISC.TCV= AREA.TCV;
    AREA_DISC.TR= AREA.TR;
    clear H AREA
    
 %% MERGE
 
    H.SV      = [H_ALL.SV H_DISC.SV];
    H.SVM1    = [H_ALL.SVM1 H_DISC.SVM1];
    H.SVM2    = [H_ALL.SVM2 H_DISC.SVM2];
    H.SJ      = [H_ALL.SJ H_DISC.SJ];
    H.SC      = [H_ALL.SC H_DISC.SC];
    H.MLCV    = [H_ALL.MLCV H_DISC.MLCV];
    H.UCV     = [H_ALL.UCV H_DISC.UCV];
    H.BCV1    = [H_ALL.BCV1 H_DISC.BCV1];
    H.BCV2    = [H_ALL.BCV2 H_DISC.BCV2];
    H.CCV     = [H_ALL.CCV H_DISC.CCV];
    H.MCV     = [H_ALL.MCV H_DISC.MCV];
    H.TCV     = [H_ALL.TCV H_DISC.TCV];
    H.TR      = [H_ALL.TR H_DISC.TR];
    
    AREA.SV    = [AREA_ALL.SV AREA_DISC.SV];
    AREA.SVM1  = [AREA_ALL.SVM1 AREA_DISC.SVM1];
    AREA.SVM2  = [AREA_ALL.SVM2 AREA_DISC.SVM2];
    AREA.SJ    = [AREA_ALL.SJ AREA_DISC.SJ];
    AREA.SC    = [AREA_ALL.SC AREA_DISC.SC];
    AREA.MLCV  = [AREA_ALL.MLCV AREA_DISC.MLCV];
    AREA.UCV   = [AREA_ALL.UCV AREA_DISC.UCV];
    AREA.BCV1  = [AREA_ALL.BCV1 AREA_DISC.BCV1];
    AREA.BCV2  = [AREA_ALL.BCV2 AREA_DISC.BCV2];
    AREA.CCV   = [AREA_ALL.CCV AREA_DISC.CCV];
    AREA.MCV   = [AREA_ALL.MCV AREA_DISC.MCV];
    AREA.TCV   = [AREA_ALL.TCV AREA_DISC.TCV];
    AREA.TR    = [AREA_ALL.TR AREA_DISC.TR];
    
    clear H_ALL AREA_ALL H_DISC AREA_DISC
     
    
        save([pwd '\KDE\KDE[full]EVT[' num2str(nEVT) ']'],'H','AREA');
    
    
end