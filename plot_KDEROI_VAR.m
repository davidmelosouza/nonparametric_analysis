nameall = {'D1a','D1b','D1c','D1d','D2a','D2b','D2c','D2d','D3a','D3b','D3c','D3d','D4a','D4b','D4c','D4d'};

d = [1 3 4 5 7 8 10 11 12 14 15 16];
for i = d    
    name = nameall{i};
    %load([pwd '\KDE\KDE[ROIKDE]DIST[' name{1} ']'],'K');
    load([pwd '\KDE\KDE[VAR]DIST[' name ']'],'K');
    vEVT = [25 50 100 500 1000];    
    DADOS = {K{1};K{2};K{3};K{4}};
    figure(3)
    title(name)
    PLOTBOXKDE_VAR(DADOS,vEVT,'Eventos','Erro (Área)','NorthEast'); hold on
    pause
    close
end 