% DEMO ukazuje rozklad zkosení na posloupnost základních transformací
% (ve 2D)

% (c) 2021 Pavel Rajmic, Vysoké uèení technické v Brnì

close all

%% Volba parametru
% uhel zkoseni ve smeru x
alpha = 30   %ve stupnich

%% Vytvoreni matice zkoseni
alpha = alpha/180 * pi;  %radiany
A = [1 tan(alpha); 0 1] %matice zkoseni

%% Definice objektu
P1 = [0; 0];
P2 = [1; 0];
P3 = [1; 2];
P4 = [0; 2];
Porig = [P1 P2 P3 P4];

%% Vykresleni puvodniho a zkoseneho objektu
figure
tvar_orig = polyshape(Porig');
plot(tvar_orig)
axis equal
hold on

Pnew = A*Porig; %vypocet zkoseni
tvar_final = polyshape(Pnew');
h = plot(tvar_final);
h.FaceColor = 'none';

title('Originalni a zkoseny objekt')

%% Rozklad zkoseni (pomoci SVD -- singularniho rozkladu)
[U,S,V] = svd(A);
V', S, U
%V' bude prvni rotace (transformace urcena ortonormalnimi vektory)
%S bude skalovani (tedy natazeni ci zkraceni ve smeru hlavnich, kolmych os)
%U bude druha rotace

figure
drawnow
plot(tvar_orig)
axis equal
hold on
title('Postup pri zkoseni objektu')

Protate1 = V' * Porig; %prvni rotace
tvar_rotate1 = polyshape(Protate1');
plot(tvar_rotate1)
pause(2)

Pscale = S * Protate1; %zmena meritka
tvar_scale = polyshape(Pscale');
plot(tvar_scale)
pause(2)

Protate2 = U * Pscale; %druha rotace (tj. finalni vysledek)
tvar_rotate2 = polyshape(Protate2');
h = plot(tvar_rotate2);
h.FaceColor = 'none';