function [DADO] = signal_GEN(nEVT,nGRID,nEST,nROI)

norm = 'fit';
inter = 'linear';
errortype = 'none';
% name = {'D1a','D1c','D1d','D2a','D2c','D2d','D3b','D3c','D3d','D4b','D4c','D4d'}
d=0;
for name = {'D1a','D1d','D2c','D2d','D4b'}
    d=d+1;
    [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
    [DATA] = datasetGenMix(setup);
    DADO.EVT(d,:) = DATA.sg.evt;
    DADO.PDF.x(d,:) = DATA.sg.pdf.truth.x;
    DADO.PDF.y(d,:) = DATA.sg.pdf.truth.y;
end



