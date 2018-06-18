% DEMO - Priklad rasterizace usecky Bresenhamovym algoritmem

% (c) 2006-2009, Petr Sysel, Pavel Rajmic, UTKO FEKT VUT v Brne


% souradnice koncovych bodu
a = int16([150,300]);
b = int16([507,413]);

home;
help( mfilename);

% vytvoreni prostoru
screen = int16(zeros( 640,480));

% spusteni stopek
tic;

% inicializace konstant
k1 = int16( 2*(b(2) - a(2)));
k2 = int16( 2*((b(2) - a(2))-(b(1) - a(1))));
% inicializace predikce
p = 2*(b(2) - a(2)) - (b(1) - a(1));
% inicializace bodu
point = a;

%% vykresleni bodu 
screen( point) = 255;
while( point(1) < b(1))
  point(1) = point(1) + 1;
  if( p > 0)
    point( 2) = point( 2) + 1;
    p = p + k2;
  else
    p = p + k1;
  end
  screen(point(1),point(2)) = 255;
end;

% zastaveni stopek
time = toc;

%% vykreslení na obrazovku
plotscreen(screen);

% cas
disp( sprintf( 'Cas vypoctu: %d s\n', time));
