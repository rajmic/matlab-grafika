function demo_raster_kruznice_useckami
% DEMO - Priklad rasterizace kruznice pomoci lomene cary

% (c) 2006-2016, Petr Sysel, Pavel Rajmic, UTKO FEKT VUT v Brne

% poloha stredu
center = [250, 250];
% polomer kruznice
radius = 120;
% hrubost aproximace 
coarseness = 10;


home;
help( mfilename);

% vytvoreni prostoru
screen = zeros(640,480);
% pocet lomenych usecek k aproximaci kruznice
count = radius/coarseness;
% inicializace bodu a
a = [radius, 0];
% matice ktera bude pouzita pro postupne otaceni bodu
mtx_rotace = [cos( 2*pi/count), sin( 2*pi/count); -sin( 2*pi/count), cos( 2*pi/count)];

for k = [0:count-2] %akumulace zaokrouhlovacich chyb se nebere v potaz
    % transformace posledniho otocenim
    b = a * mtx_rotace;
    % vykresleni usecky
    screen = dda( screen, center + floor(a), center + floor(b));
    % posun na dalsi bod
    a = b;
end
%posledni usek (aby se jiste kruznice spojila)
screen = dda( screen, center + [radius, 0], center + floor(b));

%% vykresleni obrazovky
plotscreen(screen)




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [screen] = dda( screen, a, b)
% %% screen -- pamet obrazu
% %% a      -- souradnice bodu a
% %% b      -- souradnice bodu b
% 
% % pokud je absolutni hodnota smernice vetsi nez 1, musim prehodit osy
% if( abs( b(2)-a(2)) > abs( b(1)-a(1)))
%     % ridici je osa y
%     %ridici je osa x
%     % inicializace smernice
%     m = (b(1)-a(1))/(b(2)-a(2));
%     if( b(2) >= a(2))
%         %usecka zdola nahoru
%         % vykresleni prvniho bodu
%         point = a;
%         while( point(2) < b(2))
%           screen( floor( point(1)), point(2)) = 255;
%           point(2) = point(2) + 1;
%           point(1) = point(1) + m;
%         end;
%     else
%         %usecka zhora dolu
%         % vykresleni prvniho bodu
%         point = a;
%         while( point(2) > b(2))
%           screen( floor( point(1)), point(2)) = 255;
%           point(2) = point(2) - 1;
%           point(1) = point(1) - m;
%         end;
%     end;
% else
%     %ridici je osa x
%     % inicializace smernice
%     m = (b(2)-a(2))/(b(1)-a(1));
%     if( b(1) >= a(1))
%         %usecka zleva do prava
%         % vykresleni prvniho bodu
%         point = a;
%         while( point(1) < b(1))
%           screen(point(1),floor(point(2))) = 255;
%           point(1) = point(1) + 1;
%           point(2) = point(2) + m;
%         end;
%     else
%         %usecka zprava doleva
%         % vykresleni prvniho bodu
%         point = a;
%         while( point(1) > b(1))
%           screen(point(1),floor(point(2))) = 255;
%           point(1) = point(1) - 1;
%           point(2) = point(2) - m;
%         end;
%     end;
% end;    
