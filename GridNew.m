function [ytruth] = GridNew(sg,x,name)
%==========================================================================
% Objetivo: * Gerar as probabilidades da PDF analítica de acordo com o grid
%==========================================================================
switch name
    case 'D1a'
        ytruth = normpdf(x,sg.g1.mu,sg.g1.std);
    case 'D1b'
        [ytruth,~] = GGD_Gen(x,0,1,sg.rho,1);
    case 'D1c'
        ytruth = lognpdf(x,sg.mu,sg.std);
    case 'D1d'
        [ytruth,~] = GGD_Gen(x,0,1,sg.rho,1);
    case 'D2a'
        ytruth = (normpdf(x,sg.g1.mu,sg.g1.std) + normpdf(x,sg.g2.mu,sg.g2.std))/2;
    case 'D2b'
        [ytruth,~] = GGD_Gen(x,sg.mu,sg.beta,sg.rho,[1 1]);
    case 'D2c'
        ytruth = (betapdf(x,sg.alfa1,sg.beta1)+betapdf(x,sg.alfa2,sg.beta2))/2;
    case 'D2d'
        [ytruth,~] = GGD_Gen(x,sg.mu,sg.beta,sg.rho,[1 1]);
    case 'D3a'
        [ytruth,~] = GGD_Gen(x,sg.mu,sg.beta,sg.rho,sg.alpha);
    case 'D3b'
        [ytruth] = (GGD_Gen(x,sg.mu,sg.beta,sg.rho,sg.alpha) + lognpdf(x,sg.mul,sg.std))/2;
    case 'D3c'
        ytruth = (betapdf(x,sg.alfa1,sg.beta1)+betapdf(x,sg.alfa2,sg.beta2)+GGD_Gen(x,0.5,50,1,1))/3;
    case 'D3d'
        [ytruth,~] = GGD_Gen(x,sg.mu,sg.beta,sg.rho,sg.alpha);
    case 'D4a'
        ytruth = normpdf(x,sg.g1.mu,sg.g1.std)*2;
        icut_pdf = find(x>0);
        ytruth(icut_pdf) = 0;
    case 'D4b'
        ytruth = (unifpdf(x,-6,6)+unifpdf(x,-0.5,0.5))*0.5;
    case 'D4c'
        [ytruth,~] = GGD_Gen(x,0,1,sg.rho,1);
        icut_pdf = intersect(find(x>-4.5),find(x<4.5));
        ytruth(icut_pdf) = 0;
        ytruth =  ytruth/area2d(x,ytruth);
    case 'D4d'
        ytruth = (unifpdf(x,-14.25,-13.75)+unifpdf(x,-0.5,0.5)+unifpdf(x,13.75,14.25))*(1/3);
    case 'Logn'
        ytruth = lognpdf(x,sg.mu,sg.std);
    case 'GGD'
        ytruth = ggd(x,sg.rho)';
        
end

end

