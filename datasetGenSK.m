function [DATA] = datasetGenSK(setup)
%==========================================================================
% Objetivo: *Gerar PDF Anal�tica e Eventos de uma fun��o geradora
%           *Criar as Regi�es de Interesse
%==========================================================================
range = 1; % Define se o range da PDF � definido arbitrariamente ou
% se informa��es obtidas de Min\Max ser�o consideradas.

% => Criar PDF/Eventos
switch setup.TYPE.NAME
    case 'Logn'
        [DATA] = M_LogN_GenSK(setup,range);
    case 'GGD'
        [DATA] = M_GGD_Gen(setup,range);
end

% % => Criar Regi�o de Interesse
% if ~strcmp(setup.TYPE.ROI,'bypass')
%     if strcmp(setup.TYPE.DATA,'bg') || strcmp(setup.TYPE.DATA,'both')
%         [DATA.bg.RoI.x,DATA.bg.RoI.y,DATA.bg.RoI.Xaxis,DATA.bg.RoI.ind,DATA.bg.RoI.iRoI] = reg_choice(DATA.bg.pdf.truth.x,DATA.bg.pdf.truth.y,setup.DIV,setup.TYPE.ROI);
%     end
%     if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
%         [DATA.sg.RoI.x,DATA.sg.RoI.y,DATA.sg.RoI.Xaxis,DATA.sg.RoI.ind,DATA.sg.RoI.iRoI] = reg_choice(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,setup.DIV,setup.TYPE.ROI);
%     end
% end

end