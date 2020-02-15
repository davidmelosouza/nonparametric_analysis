function [DATA] = ChangePDFlimit(setup,DATA,xmin,xmax);
%==========================================================================
% Objetivo: *Gerar PDF Analítica e Eventos de uma função geradora
%           *Criar as Regiões de Interesse
%==========================================================================

% => Criar PDF/Eventos
switch setup.TYPE.NAME
    case 'D1a'
        [DATA] = D1aLIMIT(setup,DATA,xmin,xmax);
    case 'D1b'
        [DATA] = D1bLIMIT(setup,DATA,xmin,xmax);
    case 'D1c'
        [DATA] = D1cLIMIT(setup,DATA,xmin,xmax);
    case 'D1d'
        [DATA] = D1dLIMIT(setup,DATA,xmin,xmax);
    case 'D2a'
        [DATA] = D2aLIMIT(setup,DATA,xmin,xmax);
    case 'D2b'
        [DATA] = D2bLIMIT(setup,DATA,xmin,xmax);
    case 'D2c'
        [DATA] = D2cLIMIT(setup,DATA,xmin,xmax);
    case 'D2d'
        [DATA] = D2dLIMIT(setup,DATA,xmin,xmax);
    case 'D3a'
        [DATA] = D3aLIMIT(setup,DATA,xmin,xmax);
    case 'D3b'
        [DATA] = D3bLIMIT(setup,DATA,xmin,xmax);
    case 'D3c'
        [DATA] = D3cLIMIT(setup,DATA,xmin,xmax);
    case 'D3d'
        [DATA] = D3dLIMIT(setup,DATA,xmin,xmax);
    case 'D4a'
        [DATA] = D4aLIMIT(setup,DATA,xmin,xmax);
    case 'D4b'
        [DATA] = D4bLIMIT(setup,DATA,xmin,xmax);
    case 'D4c'
        [DATA] = D4cLIMIT(setup,DATA,xmin,xmax);
    case 'D4d'
        [DATA] = D4dLIMIT(setup,DATA,xmin,xmax);
end
DATA.binmax = 2000;

if ~strcmp(setup.TYPE.ROI,'bypass')
    if strcmp(setup.TYPE.DATA,'bg') || strcmp(setup.TYPE.DATA,'both')
        [DATA.bg.RoI.x,DATA.bg.RoI.y,DATA.bg.RoI.Xaxis,DATA.bg.RoI.ind,DATA.bg.RoI.iRoI] = reg_choice(DATA.bg.pdf.truth.x,DATA.bg.pdf.truth.y,setup.DIV,setup.TYPE.ROI);
    end
    if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
        [DATA.sg.RoI.x,DATA.sg.RoI.y,DATA.sg.RoI.Xaxis,DATA.sg.RoI.ind,DATA.sg.RoI.iRoI] = reg_choice(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,setup.DIV,setup.TYPE.ROI);
    end
end
end