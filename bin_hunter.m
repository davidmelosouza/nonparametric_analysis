function bin = bin_hunter(DATA,method,est)
x = DATA.sg.evt;
bincommon = calcnbins(x,method);
load binmax
switch est
    case 'HIST'
        bin = bincommon;
        [bin.truth,~,~]=bintruth(DATA,binmax,'nearest');
    case 'PF'
        bin = bincommon;
        h = 2.15*std(x)*length(x)^(-1/5);
        bin.scott = ceil((max(x)-min(x))/h);
        [bin.LHM,~,~] = LHM(DATA.sg.evt,'linear');
        [bin.truth,~,~]=bintruth(DATA,binmax,'linear');
    case 'ASH'
        bin = bincommon;
         h = 2.576*std(x)*length(x)^(-1/5);
        bin.scott = ceil((max(x)-min(x))/h);
        [bin.LHM,~,~] = LHM(DATA.sg.evt,'linear');
        [bin.truth,~,~]=ASHtruth(DATA,10,binmax,'linear');
    case 'all'
        bin.HIST = bincommon;
        [bin.HIST.truth,~,~]=bintruth(DATA,binmax,'nearest');
        
        bin.PF = bincommon;
        h = 2.15*std(x)*length(x)^(-1/5);
        bin.PF.scott = ceil((max(x)-min(x))/h);
        [bin.PF.LHM,~,~] = LHM(DATA.sg.evt,'linear');
        [bin.PF.truth,~,~]=bintruth(DATA,binmax,'linear');
        
        bin.ASH = bincommon;
        h = 2.576*std(x)*length(x)^(-1/5);
        bin.ASH.scott = ceil((max(x)-min(x))/h);
        [bin.ASH.LHM,~,~] = LHM(DATA.sg.evt,'linear');
        [bin.ASH.truth,~,~]=ASHtruth(DATA,10,binmax,'linear');
        
end