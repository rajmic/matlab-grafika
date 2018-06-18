% DEMO - Priklad rasterizace kruznice Bresenhamovym algoritmem

% (c) 2006-2016, Petr Sysel, Pavel Rajmic, UTKO FEKT VUT v Brne

%% stred kruznice
center = [250, 250];
%% polomer
radius = 130;


home;
help( mfilename);

%% vytvoreni prostoru
screen = zeros( 640, 480);

%% inicializace pomocnych promennych
dvex = 3;
dvey = 2*radius - 2;
%% inicializace hodnoty predikce
p = 1 - radius;
%% inicializace bodu
point = [0, radius];
%%
while( point(1) <= point(2))
  %% vykresleni osmi bodu diky symetrii
  % (v prvnim a poslednim pruchodu se nektere body duplikuji)
  tmp = point*[1,0;0,1]+center;
  screen( tmp(1),tmp(2)) = 255;
  tmp = point*[1,0;0,-1]+center;
  screen( tmp(1),tmp(2)) = 255;
  tmp = point*[-1,0;0,1]+center;
  screen( tmp(1),tmp(2)) = 255;
  tmp = point*[-1,0;0,-1]+center;
  screen( tmp(1),tmp(2)) = 255;
  tmp = point*[0,1;1,0]+center;
  screen( tmp(1),tmp(2)) = 255;
  tmp = point*[0,1;-1,0]+center;
  screen( tmp(1),tmp(2)) = 255;
  tmp = point*[0,-1;1,0]+center;
  screen( tmp(1),tmp(2)) = 255;
  tmp = point*[0,-1;-1,0]+center;
  screen( tmp(1),tmp(2)) = 255;
  %% upraveni predikce
  if( p > 0)
    p = p - dvey;
    dvey = dvey - 2;
    point(2) = point(2) - 1;
  end;
  p = p + dvex;
  dvex = dvex + 2;
  point(1) = point(1) + 1;
end

%% vykresleni obrazovky
plotscreen(screen)