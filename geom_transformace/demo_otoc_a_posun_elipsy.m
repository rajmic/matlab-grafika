% DEMO - Priklad otoceni (+posunuti) elipsy, která je rasterizovaná
% Bresenhamovým algoritmem

% (c) 2006-2018, Petr Sysel, Pavel Rajmic, UTKO FEKT VUT v Brne

home;
help( mfilename);

%% excentricita elipsy
b = 100;
a = 200;

%% priprava plochy
screen = zeros(640, 480);

%% Matice posunu (tzn. je tim urcen stred elipsy)
Mposun = translating_matrix(250, 300, 0)';

%% Matice pøevrácení os (používá se pøi symetrizaci vykreslování)
MotocI  = scaling_matrix( [ 1  1 1 1]); %identita
Motocy  = scaling_matrix( [ 1 -1 1 1]); 
Motocx  = scaling_matrix( [-1  1 1 1]); 
Motocxy = scaling_matrix( [-1 -1 1 1]); 

%% Matice rotace
alpha = 35; %uhel ve stupnich
Mrotace = rotating_matrix(alpha, [0 0 -1]);
  
%% Predpocet slozenych matic
MslozenaI = MotocI*Mrotace*Mposun;
Mslozenay = Motocy*Mrotace*Mposun;
Mslozenax = Motocx*Mrotace*Mposun;
Mslozenaxy = Motocxy*Mrotace*Mposun;

%% Cast elipsy kde ridici osou je x
%% inicializace bodu
point = [0,b,0,1];
%% inicializace predikce
p = floor(b^2 - a^2*b - a^2/4);
%% opakuj
while( b^2 * point(1) <= a^2*point(2))
    %% vykresleni bodu (se zaokrouhlenim kvuli necelym cislum vzniklym pri
    %% rotaci)
    tmp = round( point*MslozenaI);
    screen(tmp(1),tmp(2)) = 255;
    tmp = round( point*Mslozenay);
    screen(tmp(1), tmp(2)) = 255;
    tmp = round( point*Mslozenax);
    screen(tmp(1), tmp(2)) = 255;
    tmp = round( point*Mslozenaxy);
    screen(tmp(1), tmp(2)) = 255;
    %% aktualizace predikce
    if( p > 0)
      p = p + b^2*(2*point(1)+3) - 2*a^2*(point(2)-1);
      point(2) = point(2) - 1;
    else
      p = p + b^2*(2*point(1)+3);
    end;
    %% posun
    point(1) = point(1) + 1;
end;

%% zamen osy a dokresli zbyle casti
%% inicializace bodu
point = [a,0,0,1];
%% inicializace predikce
p = floor(a^2 - b^2*a - b^2/4);
%% opakuj
while( b^2 * point(1) >= a^2*point(2))
    %% vykresleni bodu
    tmp = round( point*MslozenaI);
    screen(tmp(1),tmp(2)) = 255;
    tmp = round( point*Mslozenay);
    screen(tmp(1), tmp(2)) = 255;
    tmp = round( point*Mslozenax);
    screen(tmp(1), tmp(2)) = 255;
    tmp = round( point*Mslozenaxy);
    screen(tmp(1), tmp(2)) = 255;
    %% aktualizace predikce
    if( p > 0)
      p = p + a^2*(2*point(2)+3) - 2*b^2*(point(1)-1);
      point(1) = point(1) - 1;
    else
      p = p + a^2*(2*point(2)+3);
    end;
    %% posun
    point(2) = point(2) + 1;
end;

plotscreen(screen);