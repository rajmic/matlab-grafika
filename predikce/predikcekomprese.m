% Koder zalozeny na prediktoru s primou vazbou

%% parametry
W = [0.5 -0.5 1] %volitelne vahy (logicke je aby jejich soucet byl 1)
obrazek = 'most512.jpg' %most obsahuje hrany, ktere pri predikci vyuzijeme 

%% Nacteni obrazku
img = im2double(rgb2gray(imread(obrazek)));
img = img'; %transpozice abychom dostali strukturu mostu do spravneho smeru

close all
home

figure
subplot(1,2,1);
imshow(img);
axis image
title('Puvodni obrazek');


%% Poèítání predikce
output = zeros(size(img));
sW = numel(W);

for (y = 1:1:size(img,1))
    output(y,1:sW) = img(y,1:sW);
    for (x = sW+1:size(img,2))
        predikce = img(y,(x - sW):(x - 1)) * W';
        output(y,x) = img(y,x) - predikce;
    end
end

subplot(1,2,2);
imagesc(output)
axis image
colorbar
% mesh(output);
title('Vysledna matice');

colormap(gray)