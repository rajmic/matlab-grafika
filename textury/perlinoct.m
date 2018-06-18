function [h] = perlinoct( x, count, alpha, beta)

% Funkce pro generaci oktavy perlinovych sumovych funkci
%
% x - vstupni hodnoty, pro ktere chceme hodnoty získat
% count - pocet oktav
% alpha - podil modulu mezi oktavami
% beta - podil kmitoctoveho rozsahu mezi oktavami
% h - hodnoty Perlinovy sumove funkce

% (c) 2009 Petr Sysel


[G, P] = perlininit( 256);
amp = 1;

h = zeros( size( x));
for i = 0:count-1
    h = h + amp*perlin( x, G, P);
    x = x*beta;
    amp = amp/alpha;
end
