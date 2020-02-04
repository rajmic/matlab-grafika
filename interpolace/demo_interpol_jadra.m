% Demo ukazuje podobu interpolacnich jader v 1D

% (c) 2020 Lubomir Skvarenina, Pavel Rajmic, VUT v Brne

%% Cistka
close all;
% clear all;
clc;


%% Nastaveni
dx=0.001;
x = -6:dx:6;

% a_cela = 1;
% a_pol = 1/2;
% N = 12;

cropbox = [-3.8, 3.8, -0.25, 1.1];


%% Vypocet jader
y_neigh = interp_jadro(x,'neigh');
y_linear = interp_jadro(x,'linear');
y_cubic = interp_jadro(x,'cubic'); % volani bez dalsiho parametru vrati optimalni kubicky interpolator
y_sinc = interp_jadro(x,'sinc');


%% Vykresleni
% Interpolacni jadro soused
f_neigh = figure('name','Jadro nejblizsi soused','NumberTitle','off');
plot(x, y_neigh, 'LineWidth', 2);
% title('Konvolucne jadro ^{Sused}{\ith}_{1}({\itx})');
axis(cropbox);
grid on;

% Interpolacni jadro linearni
f_linear = figure('name','Jadro linearni','NumberTitle','off');
plot(x, y_linear, 'LineWidth', 2);
axis(cropbox);
grid on;

% Interpolacni jadro kubicke
f_cubic = figure('name','Jadro kubicke','NumberTitle','off');
plot(x, y_cubic, 'LineWidth', 2);
axis(cropbox);
grid on;

% Interpolacni jadro sinc
f_sinc = figure('name','Jadro sinc','NumberTitle','off');
plot(x, y_sinc, 'LineWidth', 2);
axis(cropbox);
grid on;

% Vsecky jadra
f = figure('name','Vsetky jadra','NumberTitle','off');
plot(x, y_neigh, 'k-', x, y_linear, 'r-', x, y_cubic, 'b-', x, y_sinc, 'g-');
title('Konvolucni jadra');
axis(cropbox);
grid on;
legend('Nejblizsi soused',...
       'Linearni',...
       'Kubicke',...
       'Sinc')
%        'Location','EastOutside');


%% Ulozeni obrazku
figure(f_neigh), print('interpolacni_jadro_neigh','-depsc2');
figure(f_linear), print('interpolacni_jadro_linear','-depsc2');
figure(f_cubic), print('interpolacni_jadro_cubic','-depsc2');
figure(f_sinc), print('interpolacni_jadro_sinc','-depsc2');
figure(f), print('interpolacni_jadra_vsecka','-depsc2');