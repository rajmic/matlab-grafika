function [ h] = perlin( x, G, P)
% Vypocet Perlinovy sumove funkce
%
% x - nezavisla promenna (skalar ci vektor)
% G - tabulka nahodnych hodnot
% P - tabulka indexu
% h - vystupni hodnoty Perlinovy sumove funkce pro x

% (c) 2009 Petr Sysel; drobne upravy 2014 Pavel Rajmic


N = length( G);

i = mod( floor( x), N); %levý nejbližší integer
j = mod( floor( x) + 1, N); %pravý nejbližší integer

s = x - floor( x);

u = s.*G( P(i+1)+1);
v = (s-1).*G( P(j+1)+1);

t = s.*s.*(3-2*s);
h = u + t.*( v - u);