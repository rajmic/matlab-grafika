function demo_raster_usecka_prerusovana_Bresenham

% DEMO - Priklad rasterizace prerusovane usecky Bresenhamovym algoritmem
%
% Pouze pro usecky se smernici 0 <= |m| <= 1.
% Delky usecek zde merime *v pravouhle metrice*.

% (c) 2006-2013, Petr Sysel, Pavel Rajmic, UTKO FEKT VUT v Brne

%% definice prerusovani
% 10 bodu je cara, 5 bodu je mezera
style = [1 1 1 1 1 1 1 1 1 1 1 0 0 0 0];


home;
help( mfilename);

% vytvoreni prostoru
screen = int16(zeros( 640,480));

%%
% pocet usecek
count = 10;
for( k = 0:count)
    % zadani koncovych bodu
    a = [100,100];
    b = a + floor(250*[cos( pi*k/(4*count)), sin(pi*k/(4*count))]);
    % vykresleni usecky
    screen = bresenham_pravouhly( screen, a, b, style);
end

%% vykresleni obrazovky
plotscreen(screen)