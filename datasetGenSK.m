function [DATA] = datasetGenSK(setup)
%==========================================================================
% Objetivo: *Gerar PDF Analítica e Eventos de uma função geradora
%           *Criar as Regiões de Interesse
%==========================================================================
range = 1; % Define se o range da PDF é definido arbitrariamente ou
% se informações obtidas de Min\Max serão consideradas.

% => Criar PDF/Eventos
switch setup.TYPE.NAME
    case 'Logn'
        [DATA] = M_LogN_GenSK(setup,range);
    case 'GGD'
        [DATA] = M_GGD_Gen(setup,range);
end

% % => Criar Região de Interesse
% if ~strcmp(setup.TYPE.ROI,'bypass')
%     if strcmp(setup.TYPE.DATA,'bg') || strcmp(setup.TYPE.DATA,'both')
%         [DATA.bg.RoI.x,DATA.bg.RoI.y,DATA.bg.RoI.Xaxis,DATA.bg.RoI.ind,DATA.bg.RoI.iRoI] = reg_choice(DATA.bg.pdf.truth.x,DATA.bg.pdf.truth.y,setup.DIV,setup.TYPE.ROI);
%     end
%     if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
%         [DATA.sg.RoI.x,DATA.sg.RoI.y,DATA.sg.RoI.Xaxis,DATA.sg.RoI.ind,DATA.sg.RoI.iRoI] = reg_choice(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,setup.DIV,setup.TYPE.ROI);
%     end
% end

end