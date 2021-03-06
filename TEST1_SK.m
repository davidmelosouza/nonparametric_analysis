function [] = TEST1_SK(S)
%==========================================================================
% Objetivo: * Definir o Maximo e M�nimo de cada PDF
%           * Melhorar essa fun��o para o teste com DATA
%==========================================================================
% S=4;
% type = 'sg';
[AR] = STDPCT(S);
inter = 'linear';
itmax = 1;
ngrid = 200000000;
% evt =round(linspace(1000,100000,50));
evt =1000;
% for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
% for name = {'Logn'}
for name = {'Logn'}
    wb = waitbar(0,['Aguarde...[' name{1} ']' ]);
    ng = 0;
    
    if strcmp(name,'Logn')
%         range.SK =linspace(0.1,1,10);
           range.SK =linspace(0.1,1,10);
    else
        range.SK = sort([[logspace(0,1,9)] 2]);
    end
    
    
    for ir=1:length(range.SK)
        
        for nevt = evt
            ng = ng+1;
            for nt=1:itmax
                [setup] = IN(name{1},'sg','none','dist',inter,'bypass',nevt,ngrid,1000,1);   % Definir os Par�metros Iniciais
                if strcmp(name{1},'Logn')
                    setup.mu=4;
                    setup.mu=0;
                    setup.std = range.SK(ir);
                else
                    setup.rho = range.SK(ir);
                end
                setup.ir = ir;
                [DATA] = datasetGenSK(setup);                                            % Gerar os Dados � partir desses Par�metros
                [V{ng}] = MINMAX_methods(DATA.sg,name{1},AR,ngrid,nt);
                
            end
            
        end
        for i = 1:length(V)
            pdf.xlimit(i,:) = V{i}.xlimit.pdf;
            pdf.A(i) = V{i}.A.pdf;
        end
        disp(num2str(pdf.A(i)))
        %     [I,~] = PDF_integral(DATA.sg,pdf.xlimit(1),pdf.xlimit(2),name);
        %     pdf.I = I;
        save([pwd '\limit\TEST1SK[' name{1} ']STD[' num2str(S) ']SK[' num2str(ir) '][sg]'],'pdf');

        waitbar(ir/length(range.SK))
    end
    close(wb)
end
end