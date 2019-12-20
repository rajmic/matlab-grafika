% Demonstrace Bayerovy masky na snímaèi fotoaparátu

% 2019 Filip Vrba, Pavel Rajmic, VUT v Brne

close all

%% Nacteni obrazu
 rgbImage = imread('bayerpic.jpg');
% rgbImage = imread('marbles.tif');

%% Zobrazení originálu a jednotlivých komponent
% subplot(5,2,[1 2]);
figure
imshow(rgbImage);
title('Original RGB image')

figure
imshow(rgbImage(:,:,1));
title('Original R component')

figure
imshow(rgbImage(:,:,2));
title('Original G component')

figure
imshow(rgbImage(:,:,3));
title('Original B component')


%% Simulace Bayerovy masky
[rows, columns, numberOfColorChannels] = size(rgbImage);

%nejprve vse nastavime na nulu, nenulovymi cisly budou pak zaplneny jen nektere pozice
red = zeros(rows, columns, 'uint8');
green = zeros(rows, columns, 'uint8');
green2 = zeros(rows, columns, 'uint8'); %zelene jsou dva
blue = zeros(rows, columns, 'uint8');

%v tomto cyklu se prochazeji vsechny pixely a rozhoduje se, ktere masce patri
%maska odpovida usporadani 'bggr' 
for col = 1 : columns
  for row = 1 : rows
    if mod(col, 2) == 0 && mod(row, 2) == 0
      % Ziskani cervených hodnot
      red(row, col) = rgbImage(row, col, 1);
    elseif mod(col, 2) == 0 && mod(row, 2) == 1
      % Získání zelených hodnot
      green(row, col) = rgbImage(row, col, 2);
    elseif mod(col, 2) == 1 && mod(row, 2) == 0
      % Získání zelených hodnot (druhych)
      green2(row, col) = rgbImage(row, col, 2);
    elseif mod(col, 2) == 1 && mod(row, 2) == 1
      % Získání modrých hodnot
      blue(row, col) = rgbImage(row, col, 3);
    end
  end
end
green = green + green2;  %slouceni dvou zelenych kanalu

% Dohromady jak by vypadaly intenzity na snimaci
recombinedRGBImage = red + green + blue; %nejprve jako jednokanal
figure
imshow(recombinedRGBImage);
title('Bayer RGB');

recombinedRGBImage_color = cat(3, red, green, blue); %pak jako barvicky
figure
imshow(recombinedRGBImage_color);
title('Bayer RGB');

% Cerveny Bayer kanal zvlast
figure
imshow(red);
title('Bayer R');

% Zeleny Bayer kanal
figure
imshow(green);
title('Bayer G');

% Modry Bayer kanal
figure
imshow(blue);
title('Bayer B');


%% Demozaikování bayerovy masky
demosaicedImage = demosaic(recombinedRGBImage,'bggr');  %funkce Image Processing Toolboxu

figure
imshow(demosaicedImage);
title('Demosaiced image');

% Vyhodnoceni odchylky demozaikovaneho obrazu od RGB
Z = imabsdiff(rgbImage,demosaicedImage);
norma_rozdilu = norm(double(Z(:)))
% ZZ = abs(rgbImage-demosaicedImage); %pozor, jednoduche odecteni a abs. hodnota dava neco jineho kvuli preteceni aritmetiky
figure
coef = 3;
imshow(coef * Z);
title('Absolutni rozdil (zesileny)');