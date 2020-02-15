function [ef,fa] = effa(yv,dl)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Fun��o para calcular efici�ncia e Falso Alarme              %      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descri��o: Esta fun��o tem como entrada o discriminante dado pela       %
%            likelihood e a valida��o dada pelo truth, e como sa�da       %  
%            a efici�ncia calculada com o conjunto  de el�trons e o       %  
%            falso alarme calculado com o conjunto de jatos.              %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajustes dos par�metros de entrada 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ycalc = dl'; %discriminante = Y calculado
Ydes = yv';  % valida��o = Y desejado
te=sum(yv);  % tamanho do conjunto de el�trons
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
% C�lculo da Efici�ncia e do Falso Alarme: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for j=1:te;
        if ((comp(j,1) == 1) && (comp(j,2) == 1)); %compara��o da matriz calculada com a desejada
            hitel = hitel +1; %eletrons certos
        else((comp(j,1) == 1) && (comp(j,2) == 0));%compara��o da matriz calculada com a desejada
            erro = erro +1;   %el�trons errados  
        end

    end
    hit(l) = hitel;
    for k=(te+1):(te+tj);
        if ((comp(k,1) == 0) && (comp(k,2) == 0)); %compara��o da matriz calculada com a desejada
            hitjet = hitjet +1; %jatos certos
        else((comp(k,1) == 0) && (comp(k,2) == 1));%compara��o da matriz calculada com a desejada
            fakeel = fakeel +1; %jatos errados(classificados como el�trons)
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
