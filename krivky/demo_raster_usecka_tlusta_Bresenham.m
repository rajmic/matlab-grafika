function demo_raster_usecka_tlusta_Bresenham
% DEMO - Priklad rasterizace tluste usecky Bresenhamovym algoritmem
%
% Pouze pro usecky se smernici 0 <= |m| <= 1.

% (c) 2006-2013, Petr Sysel, Pavel Rajmic, UTKO FEKT VUT v Brne


%% definice prerusovani
% 10 bodu je cara, 5 bodu je mezera
style = [1 1 1 1 1 1 1 1 1 1 0 0 0 0 0];
%% tloustka
thickness = 7;

home;
help( mfilename);

% vytvoreni prostoru
screen = int16(zeros( 640,480));

%%
% pocet usecek
count = 5;
for( k = [0:count])
    % zadani koncovych bodu
    a = [100,100];
    b = a + floor(250*[cos( k*pi/(4*count)), sin(k*pi/(4*count))]);
    % vykresleni usecky
    screen = bresenham_tlusty( screen, a, b, style,thickness);
end

%% vykresleni obrazovky
plotscreen(screen)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [screen] = bresenham_tlusty( screen, a, b, style, thickness)
%% screen -- pamet obrazu
%% a      -- souradnice bodu a
%% b      -- souradnice bodu b
%% style  -- sablona vzoru

% inicializace konstant
k1 = 2*(b(2) - a(2));
k2 = 2*((b(2) - a(2))-(b(1) - a(1)));
%% inicializace predikce
p = 2*(b(2) - a(2)) - (b(1) - a(1));
% inicializace bodu
point = a;
% inicializace stylu
done = 1; rest = length( style);
%% vykresleni bodu 
screen( point) = 255;
while( point(1) < b(1))
  point(1) = point(1) + 1;
  if( p > 0)
    point( 2) = point( 2) + 1;
    p = p + k2;
  else
    p = p + k1;
  end;
  % vykresleni pouze pokud to odpovida vzoru
  % zjisteni vzdalenosti od pocatecniho bodu
  tmp = mod( floor( sqrt(double(( point(1) - a(1))^2 + ( point(2) - a(2))^2))), length( style))+1;
  if( style( tmp) == 1)
    screen(point(1), point(2)+[-floor(thickness-1)/2:floor(thickness-1)/2]) = 255;
  end;
  done = done + 1;
  rest = rest - 1;
  if( rest == 0)
    done = 1;
    rest = length( style);
  end
end;
