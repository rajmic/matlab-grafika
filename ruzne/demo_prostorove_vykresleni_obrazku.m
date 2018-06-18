% demo zobrazuje 2D obrazek jako funkci dvou promennych
% v prostorovem pohledu

% 2011-2013 Ján Zátyik, Pavel Rajmic

clc
clear all
close all

%% Vstupni parametry

%obrazek k zobrazeni - ve stupnich sedi!
obrazek = 'lena_grayscale.png';
% obrazek = 'obrazek_textu.png';

%azimut a elevace 3d pohledu
ViewParameters = [-30 80];


%% Priprava obrazku
im = imread(obrazek);
imd = double(im);

%% Vykresleni standardne 2D
figure
imagesc(imd)
colormap gray
axis image
axis off

%% Prevraceni kvuli zobrazeni "hlavou nahoru"
imdf = flipud(imd);

%% Vykresleni pixel po pixelu, neinterpolovane
figure
if isoctave
    surf(imdf,imdf,'EdgeColor','none')
else
    surf(imdf,imdf,'EdgeColor','none','FaceLighting','phong')
end
colormap gray
axis tight
view(ViewParameters)
colorbar
title('Prostorovy pohled na obrazek')


%% Vykresleni interpolovane
figure
if isoctave
    surf(imdf,imdf,'FaceColor','interp','EdgeColor','none')
else
    surf(imdf,imdf,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
end
colormap gray
axis tight
view(ViewParameters)
colorbar
title('Prostorovy pohled na obrazek, s vypomoci trochy vyhlazeni')


%% Velikost tøetí souøadnice je jas, pseudobarvy "jet"
figure
mesh(imdf);
axis tight
view(ViewParameters)
colormap jet
axis tight
colorbar
title('Prostorovy pohled na obrazek, paleta ''jet''')
