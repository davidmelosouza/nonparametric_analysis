function [DATA] = datasetGenMix(setup)
%==========================================================================
% Objetivo: *Gerar PDF Analítica e Eventos de uma função geradora
%           *Criar as Regiões de Interesse
%==========================================================================
range = 1; % Define se o range da PDF é definido arbitrariamente ou
% se informações obtidas de Min\Max serão consideradas.

% => Criar PDF/Eventos
switch setup.TYPE.NAME
    case 'D1a'
        [DATA] = D1aGen(setup,range);
    case 'D1b'
        [DATA] = D1bGen(setup,range);
    case 'D1c'
        [DATA] = D1cGen(setup,range);
    case 'D1d'
        [DATA] = D1dGen(setup,range);
    case 'D2a'
        [DATA] = D2aGen(setup,range);
    case 'D2b'
        [DATA] = D2bGen(setup,range);
    case 'D2c'
        [DATA] = D2cGen(setup,range);
    case 'D2d'
        [DATA] = D2dGen(setup,range);
    case 'D3a'
        [DATA] = D3aGen(setup,range);
    case 'D3b'
        [DATA] = D3bGen(setup,range);
    case 'D3c'
        [DATA] = D3cGen(setup,range);
    case 'D3d'
        [DATA] = D3dGen(setup,range);
    case 'D4a'
        [DATA] = D4aGen(setup,range);
    case 'D4b'
        [DATA] = D4bGen(setup,range);
    case 'D4c'
        [DATA] = D4cGen(setup,range);
    case 'D4d'
        [DATA] = D4dGen(setup,range);
end

if (setup.EVT==25); DATA.binmax = 200; end
if (setup.EVT==50); DATA.binmax = 350; end
if (setup.EVT==100); DATA.binmax = 500; end
if (setup.EVT==500); DATA.binmax = 1000; end
if (setup.EVT==1000); DATA.binmax = 500; end


if ~strcmp(setup.TYPE.ROI,'bypass')
    if strcmp(setup.TYPE.DATA,'bg') || strcmp(setup.TYPE.DATA,'both')
        [DATA.bg.RoI.x,DATA.bg.RoI.y,DATA.bg.RoI.Xaxis,DATA.bg.RoI.ind,DATA.bg.RoI.iRoI] = reg_choice(DATA.bg.pdf.truth.x,DATA.bg.pdf.truth.y,setup.DIV,setup.TYPE.ROI);
    end
    if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
        [DATA.sg.RoI.x,DATA.sg.RoI.y,DATA.sg.RoI.Xaxis,DATA.sg.RoI.ind,DATA.sg.RoI.iRoI] = reg_choice(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,setup.DIV,setup.TYPE.ROI);
    end
end
end