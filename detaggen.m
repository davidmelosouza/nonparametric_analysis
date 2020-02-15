function [] = detaggen(name)

%% Essa função decodifica o TAG dos nomes dos arquivos:
syms M R P C 

i=0;
aux=0;
while(aux==0);
    i=i+1;
    aux=strcmp('K',name(i));       
end

dt = name(i-1);

utility=name(1:i-2);

k.eta.min = name(i+1:i+2);
k.eta.max = name(i+3:i+4);
k.et.min = name(i+5:i+6);
k.et.max = name(i+7:i+8);
k.pct = name(i+9:i+10);
k.p = name(i+11);

v.eta.min =name(i+13:i+14);
v.eta.max =name(i+15:i+16);
v.et.min =name(i+17:i+18);
v.et.max =name(i+19:i+20);
v.pct = name(i+21:i+22);
v.p = name(i+23);


%% Utility
disp('==============================================')
if(strcmp('CORR',utility))
    disp('Correlation between all variables')
end
if(strcmp('PDF',utility(1:3)))
    if(strcmp('X',utility(4)))
        ax='X';
    end
    if(strcmp('Y',utility(4)))
        ax='Y';
    end
    if(strcmp('E',utility(5)))
        kind='Electron';
    end
    if(strcmp('J',utility(5)))
        kind='Jet';
    end
    str=[ax,' Axis PDF´s of ',kind];
    disp(str)
end

if length(utility)>=7
    if(strcmp('NVTXH2D',utility(1:7)))
        if(strcmp('E',utility(8)))
            kind='Electron';
        end
        if(strcmp('J',utility(8)))
            kind='Jet';
        end
        str=['2D Histogram (pileup vs discriminant) ',kind];
        disp(str)
    end
end


%% Histograma Likelihood
if(strcmp('HLH',utility(1:3)))
    if(strcmp('X',utility(4)))
        ax='X';
    end
    if(strcmp('Y',utility(4)))
        ax='Y';
    end
    if(strcmp('E',utility(5)))
        kind='Electron';
    end
    if(strcmp('J',utility(5)))
        kind='Jet';
    end
    str=[ax,' Axis likelihood discriminant of ',kind];
    disp(str)
end

if(strcmp('ETB',utility))
    disp('Background rejection by Et regions ')
end
if(strcmp('ETS',utility))
    disp('Signal Efficiency by Et regions ')
end
if(strcmp('ETAB',utility))
    disp('Background rejection by Eta regions ')
end
if(strcmp('ETAS',utility))
    disp('Signal Efficiency by Eta regions ')
end
if(strcmp('DLR',utility))
    disp('Likelihood discriminant removing each variable')
end
if(strcmp('ROCC',utility))
    disp('ROC removing each variable')
end

%% Variable

if length(utility)>=4
    if(strcmp('GPDF',utility(1:4)))
        if(strcmp('E',utility(5)))
            ax='Electron';
        end
        if(strcmp('J',utility(5)))
            ax='Jet';
        end
        kind=utility(7:length(utility)-1);


        str=[ax, ' PDF plot of ', kind, ' variable'];
        disp(str)
    end
end

%%

if(strcmp('NVTXE',utility))
    disp('Signal Pileup dependence')
end
if(strcmp('NVTXJ',utility))
    disp('Background Pileup dependence')
end
%%
if(strcmp('NVTXB',utility))
    disp('Background Pileup dependence')
end

if(strcmp('NVTXS',utility))
    disp('Signal Pileup dependence')
end
%%
if(strcmp('ROC',utility))
    disp('Likelihood ROC output')
end
%%
if length(utility)>=6
    if(strcmp('NVTXBR',utility(1:6)))
        kind=utility(8:length(utility)-1);
        str=['Background Pileup dependence removing ', kind, ' variable'];
        disp(str)
    end

    if(strcmp('NVTXSR',utility(1:6)))
        kind=utility(8:length(utility)-1);
        str=['Signal Pileup dependence removing ', kind, ' variable'];
        disp(str)
    end
end

disp('==============================================')
%% Data Type
if dt == M
disp('Data Type: Monte Carlo')
else
disp('Data Type: Real')
end

%% Kernel Setup
disp('==============================================')
disp('Kernel Setup: ')
str=[num2str(hex2dec(k.eta.min)/100), ' < |eta| < ' ,num2str(hex2dec(k.eta.max)/100)];
disp(str)
str=[num2str(hex2dec(k.et.min)), ' < et < ' ,num2str(hex2dec(k.et.max)), ' GeV'];
disp(str)
str=['Percentage: ' ,num2str(hex2dec(k.pct)), '%'];
disp(str)

if k.p == P
disp('Electron is Prompt')
else
disp('Electron is Conversion')
end

%% Validation Setup
disp('==============================================')
disp('Validation Setup: ')
str=[num2str(hex2dec(v.eta.min)/100), ' < |eta| < ' ,num2str(hex2dec(v.eta.max)/100)];
disp(str)
str=[num2str(hex2dec(v.et.min)), ' < et < ' ,num2str(hex2dec(v.et.max)), ' GeV'];
disp(str)
str=['Percentage: ' ,num2str(hex2dec(v.pct)), '%'];
disp(str)

if v.p == P
disp('Electron is Prompt')
else
disp('Electron is Conversion')
end
disp('==============================================')