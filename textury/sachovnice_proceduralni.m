function [color] = sachovnice_proceduralni (M, N, u, v)
% [color] = sachovnice_proceduralni (M, N, u, v)
% 
% Vrací barvu v šachovnici, kde color = -1 ... èerná
%                                     =  1 ... bílá
% 
% M,N ... poèty dílkù šachovnice ve smìru u, resp. v.
% u,v ... souøadnice bodu, ve kterém chci zjistit barvu, rozsah <0,1>
% pøièemž "u" chápeme jako vodorovnou osu a "v" jako osu svislou.
% 
% Pøedpokládáme, že šachovnice zaèíná v levém dolním rohu èerným políèkem
% (lze jednoduše zmìnit v kódu).

% (c) 2009 Petr Doležal
% drobné úpravy (c) 2009,2010 Pavel Rajmic


% Chceme-li zaèínat v levém dolním rohu bílým políèkem, nastavíme
% následující promìnnou na 0. Pøi jednièce tam bude èerná.
bool_zacni_cernou = 1;

% Vybráním minima ošetøíme mezní situaci, kdy u èi v = 1.0. Kdybychom
% neošetøili, došlo by pro okrajové pixely k nevhodnému pøeklopení již do dalšího
% dílku opaèné barvy.

m = min(floor(u*M), M-1);
n = min(floor((v)*N), N-1);
% n = min(floor((1-v)*N), N-1);

color = (-1)^(m+n+bool_zacni_cernou);