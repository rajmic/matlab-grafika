function [G, P] = perlininit(N)
% Funkce pro generovani tabulky nahodnych hodnot pro vytvoreni Perlinovy
% sumove funkce v 1D
%
% N - velikost tabulky, pocet bodu
% G - tabulka nahodnych hodnot
% P - tabulka indexu

% (c) 2009-2014 Petr Sysel, Pavel Rajmic


%% Inicializace
G = rand(1,N)*2-1; %pole náhodných hodnot z intervalu [-1;1]
% G = randn(1,N); %pole náhodných hodnot
P = 0:N-1; %pole indexù, zatím seøazené

%% Permutace
for i = 0:N-1
    % náhodné èíslo z intervalu [0;N-1] s rovnomìrnou distribucí
    k = randi(N)-1;
    % prohození dvou hodnot s doèasnou úschovou tøetí pomocné
    tmp = P(i+1);
    P(i+1) = P(k+1);
    P(k+1) = tmp;
end
