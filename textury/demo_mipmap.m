%DEMO ukazuje generovani MIP mapy pro barevny RGB obrazek (tj. 2D texturu)

% (c) 2013 Martin Sulc, Pavel Rajmic, VUT v Brne

%% vyber obrazku
obrazek = 'brick-texture11_pow2_letters.jpg';
% obrazek = 'brick-texture11_pow2.jpg';

%% zpracovani a vykresleni
home
close all

imageRGB = imread(obrazek);

[MIP, MIPcoloured] = mipmap_generation(imageRGB);

figure
image(imageRGB)
title('Originalni textura')
axis off
axis image

figure
imshow(MIP/255)
title('MIP map textury')
axis off
axis image

figure
image(MIPcoloured)
title('MIP map textury, obarveno')
axis off
axis image
