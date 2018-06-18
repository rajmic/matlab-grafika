% program demonstruje vyrobeni palety pro vstupni obraz
% Pavel Rajmic

%% vstupni parametry
input_img = 'lena_32barev.png';

%% zahajeni
img = imread(input_img);
img = uint8(img);

clc
close all

%% Vypocet palety
[table, indexed_img, velikost] = create_palette(img);
table
velikost

%% zobrazeni
%vstupniho snimku
figure;
imshow(img);
title('Vstupni obraz');
%jeho palety
figure;
imagesc(indexed_img);
colorbar
axis image
axis off
title('Paleta obrazu (na strane skutecne hodnoty, zobrazeni je vsak prepocteno)');