% DEMO - obecná parametrická polynomiální køivka a její vykreslení

krok = 0.05; %jemnost pro casovy prubeh
t = (0:krok:1)'; %cas
C = randn(5,2); %definujici matice - zde nahodna
[x,y] = polyn_curve(C,t); %vygenerovani prubehu krivky
plot_curve(x,y,t); %vykresleni jejiho prubehu