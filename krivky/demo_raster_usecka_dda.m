% DEMO - priklad rasterizace usecky - metodou DDA
%
% Pouze pro usecky se smernici 0 <= |m| <= 1
% (tzn. 1. a 8. oktant, kdy vodorovná osa je øídící)

% (c) 2006-2013, Petr Sysel, Pavel Rajmic, UTKO FEKT VUT v Brne


% souradnice koncovych bodu usecky
a = [150,300];
b = [507,413];

home;
help( mfilename);

% obrazovka
screen = zeros(640,480);

% èasomíra
tic;

% smernice usecky
m = (b(2) - a(2))/(b(1) - a(1));

%% vykresleni prvniho bodu
point = a;
% cyklus
while( point(1) < b(1))
  screen(point(1),floor(point(2)+0.5)) = 255; % zaokrouhleni
  point(1) = point(1) + 1;
  point(2) = point(2) + m;
end;

% casomira
time = toc;

%% vykreslení na obrazovku
plotscreen(screen);

% cas
disp( sprintf( 'Cas vypoctu: %d s\n', time));