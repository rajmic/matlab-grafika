% DEMO: posunuti elipsy, ktera je rastrovana Bresenhamov�m algoritmem

% (c) 2006-2018, Petr Sysel, Pavel Rajmic, UTKO FEKT VUT v Brne

home;
help( mfilename);

%% parametry elipsy -- excentricity
b = 51; %100;
a = 173;  %200;

%% priprava plochy
screen = zeros(640, 480);

%% Matice posunu (tim je vlastne urcen stred elipsy)
Mposun = translating_matrix(250, 250, 0)';

%% Matice p�evr�cen� os (pou��v� se p�i symetrizaci vykreslov�n�)
MotocI  = scaling_matrix( [ 1  1 1 1]); %identita
Motocy  = scaling_matrix( [ 1 -1 1 1]); 
Motocx  = scaling_matrix( [-1  1 1 1]); 
Motocxy = scaling_matrix( [-1 -1 1 1]); 

%% Predpocitat slozene matice
MslozenaI = MotocI*Mposun;
Mslozenay = Motocy*Mposun;
Mslozenax = Motocx*Mposun;
Mslozenaxy = Motocxy*Mposun;


%% Vykresleni casti elipsy kde ridici osou je x
%% inicializace bodu
point = [0,b,0,1];
%% inicializace predikce
p = floor(b^2 - a^2*b - a^2/4);
%% opakuj
while( b^2 * point(1) <= a^2*point(2))
    %% vykresleni bodu (ctyri body v jednom cyklu diky symetrii)
    tmp = point*MslozenaI;   % nic nezpusobi
    screen(tmp(1),tmp(2)) = 255;
    tmp = point*Mslozenay;
    screen(tmp(1), tmp(2)) = 255;
    tmp = point*Mslozenax;
    screen(tmp(1), tmp(2)) = 255;
    tmp = point*Mslozenaxy;
    screen(tmp(1), tmp(2)) = 255;
    %% aktualizace predikce
    if( p > 0)
      p = p + b^2*(2*point(1)+3) - 2*a^2*(point(2)-1);
      point(2) = point(2) - 1;
    else
      p = p + b^2*(2*point(1)+3);
    end;
    %% posun k dalsimu
    point(1) = point(1) + 1;
end;

%% Zamen osy a dokresli zbyle casti
%% inicializace bodu
point = [a,0,0,1];
%% inicializace predikce
p = floor(a^2 - b^2*a - b^2/4);
%% opakuj
while( b^2 * point(1) >= a^2*point(2))
    %% vykresleni bodu (opet ctyrikrat)
    tmp = point*MslozenaI;
    screen(tmp(1),tmp(2)) = 255;
    tmp = point*Mslozenay;
    screen(tmp(1), tmp(2)) = 255;
    tmp = point*Mslozenax;
    screen(tmp(1), tmp(2)) = 255;
    tmp = point*Mslozenaxy;
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