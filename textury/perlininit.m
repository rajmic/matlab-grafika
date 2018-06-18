function [G, P] = perlininit(N)
% Funkce pro generovani tabulky nahodnych hodnot pro vytvoreni Perlinovy
% sumove funkce v 1D
%
% N - velikost tabulky, pocet bodu
% G - tabulka nahodnych hodnot
% P - tabulka indexu

% (c) 2009-2014 Petr Sysel, Pavel Rajmic


%% Inicializace
G = rand(1,N)*2-1; %pole n�hodn�ch hodnot z intervalu [-1;1]
% G = randn(1,N); %pole n�hodn�ch hodnot
P = 0:N-1; %pole index�, zat�m se�azen�

%% Permutace
for i = 0:N-1
    % n�hodn� ��slo z intervalu [0;N-1] s rovnom�rnou distribuc�
    k = randi(N)-1;
    % prohozen� dvou hodnot s do�asnou �schovou t�et� pomocn�
    tmp = P(i+1);
    P(i+1) = P(k+1);
    P(k+1) = tmp;
end
