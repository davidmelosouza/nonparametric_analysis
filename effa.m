function [ef,fa] = effa(yv,dl)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Função para calcular eficiência e Falso Alarme              %      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descrição: Esta função tem como entrada o discriminante dado pela       %
%            likelihood e a validação dada pelo truth, e como saída       %  
%            a eficiência calculada com o conjunto  de elétrons e o       %  
%            falso alarme calculado com o conjunto de jatos.              %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajustes dos parâmetros de entrada 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ycalc = dl'; %discriminante = Y calculado
Ydes = yv';  % validação = Y desejado
te=sum(yv);  % tamanho do conjunto de elétrons
tj=length(dl)-te; % tamando do conjunto de jatos
p    = 0.001; %passo da ROC(se ultilizar esse algortimo para ROC)
l = 0;        %inicializando contagem

% for i = min(dl):p:max(dl); %utilizar para ROC
for i =0.5; %limiar = 0.5
    l = l+1;    
    c       = i;
    % corte   = c;
    hitel   =  0;
    hitjet  =  0;
    erro    =  0;
    fake    =  0;
    fakeel  =  0;
    Y       =  0;
    Y   =  (Ycalc > c);
    comp  =  [Ydes,Y];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cálculo da Eficiência e do Falso Alarme: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for j=1:te;
        if ((comp(j,1) == 1) && (comp(j,2) == 1)); %comparação da matriz calculada com a desejada
            hitel = hitel +1; %eletrons certos
        else((comp(j,1) == 1) && (comp(j,2) == 0));%comparação da matriz calculada com a desejada
            erro = erro +1;   %elétrons errados  
        end

    end
    hit(l) = hitel;
    for k=(te+1):(te+tj);
        if ((comp(k,1) == 0) && (comp(k,2) == 0)); %comparação da matriz calculada com a desejada
            hitjet = hitjet +1; %jatos certos
        else((comp(k,1) == 0) && (comp(k,2) == 1));%comparação da matriz calculada com a desejada
            fakeel = fakeel +1; %jatos errados(classificados como elétrons)
        end

    end
    fake(l) = fakeel;

    ef(l) = [hit(l)/te]*100;
    fa(l) = [fake(l)/tj]*100;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Resultados finais
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ef = ef/100;
fa = fa/100;
end
