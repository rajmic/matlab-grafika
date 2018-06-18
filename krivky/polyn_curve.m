function [x,y] = polyn_curve(C,t)

% POLYN_CURVE vypocita souradnice bodu na polynomialni 2D krivce

% Funkce vrací souradnice bodu køivky Q=T*C. Prùbìh køivky je urèen
% maticí 'C'.
%
% C.........matice o dvou sloupcich, ve sloupcich jsou parametry pro
%           x-ovou resp. y-ovou slozku. Napr. pro kubiku to bude 4x2
%           parametru (ax,bx,cx,dx,ay,by,cy,dy), ktere vlastne predstavuji
%           koeficienty polynomu.
% t.........casovy vektor, pro ktery se maji hodnoty na krivce pocitat.
%           Obvykle t zacina 0 a konci 1.
% x,y.......[x(t),y(t)]; vystupem jsou dva sloupcove vektory souradnic
%
% Priklad:
% krok = 0.05;
% t = (0:krok:1)';
% C = randn(5,2);
% [x,y] = polyn_curve(C,t);

% (c) 2009, Pavel Rajmic, UTKO FEKT VUT v Brne

%% Inicializace
[n,m] = size(C);
if (m > 2) error; end
if (n < 3) error; end
rad_polynomu = n-1; % jaka bude nejvyssi mocnina polynomu
% lt = length(t);

%% generovani casove matice
T = timevector(t,rad_polynomu);

%% vypocet
pointsOnCurve = T*C;
x = pointsOnCurve(:,1);
y = pointsOnCurve(:,2);