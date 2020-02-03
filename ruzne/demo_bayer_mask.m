% Demonstrace Bayerovy masky na snimaci fotoaparatu + proces demozaikovani

% 2019--2020 Filip Vrba, Martin Seckar, Pavel Rajmic, VUT v Brne

%[1] Malvar, H. & He, L. & Cutler, R.: High-quality linear interpolation
%    for demosaicing of Bayer-patterned color images. Acoustics, Speech,
%    and Signal Processing, International Conference on. 2004. DOI 10.1109/ICASSP.2004.1326587
%    https://www.researchgate.net/publication/4087683_High-quality_linear_interpolation_for_demosaicing_of_Bayer-patterned_color_images

close all
clc

%% Nacteni obrazu
rgbImage = imread('bayerpic.jpg');
% rgbImage = imread('watch.jpg');
% rgbImage = imread('marbles.tif');

%% Zobrazeni originalu a jednotlivych RGB komponent
% subplot(5,2,[1 2]);
figure
imshow(rgbImage);
title('Original RGB obrazek')

figure
imshow(rgbImage(:,:,1));
title('Original kompletni R slozka')

figure
imshow(rgbImage(:,:,2));
title('Original kompletni G slozka')

figure
imshow(rgbImage(:,:,3));
title('Original kompletni B slozka')


%% Simulace Bayerovy masky
[rows, columns, numberOfColorChannels] = size(rgbImage);

%nejprve vse nastavime na nulu,
%nenulovymi cisly budou pak zaplneny jen nektere pozice
red = zeros(rows, columns, 'uint8');
green = zeros(rows, columns, 'uint8');
green2 = zeros(rows, columns, 'uint8'); %zelene jsou dva
blue = zeros(rows, columns, 'uint8');

%v tomto cyklu se prochazeji vsechny pixely a rozhoduje se, ktere masce patri
%maska odpovida usporadani 'bggr' 
for col = 1 : columns
  for row = 1 : rows
    if mod(col, 2) == 0 && mod(row, 2) == 0
      % Ziskani cervenych hodnot
      red(row, col) = rgbImage(row, col, 1);
    elseif mod(col, 2) == 0 && mod(row, 2) == 1
      % Ziskani zelenych hodnot
      green(row, col) = rgbImage(row, col, 2);
    elseif mod(col, 2) == 1 && mod(row, 2) == 0
      % Ziskani zelenych hodnot (druhych)
      green2(row, col) = rgbImage(row, col, 2);
    elseif mod(col, 2) == 1 && mod(row, 2) == 1
      % Ziskani modrych hodnot
      blue(row, col) = rgbImage(row, col, 3);
    end
  end
end
green = green + green2;  %slouceni dvou zelenych kanalu

% Dohromady jak by vypadaly intenzity na snimaci
recombinedRGBImage = red + green + blue; %nejprve jako jednokanal
figure
imshow(recombinedRGBImage);
title('Bayer RGB jako intenzity');

recombinedRGBImage_color = cat(3, red, green, blue); %pak jako barvicky
figure
imshow(recombinedRGBImage_color);
title('Bayer RGB v barvickach');

% Cerveny Bayer kanal zvlast
figure
imshow(red);
title('R slozka Bayerovy masky samostatne');

% Zeleny Bayer kanal
figure
imshow(green);
title('G slozka Bayerovy masky samostatne');

% Modry Bayer kanal
figure
imshow(blue);
title('B slozka Bayerovy masky samostatne');


%% Demozaikování bayerovy masky
% a/// Rucne podle clanku [1] (implementace Matin Seckar)
tic
demosaicedImage = demosaic_own(recombinedRGBImage_color);
toc

figure
imshow(demosaicedImage);
title('Demozaikovany obraz (vlastni)');

Z = imabsdiff(rgbImage,demosaicedImage);  %odchylka demozaikovaneho obrazu od RGB
norma_rozdilu = norm(double(Z(:)))
% ZZ = abs(rgbImage-demosaicedImage); %pozor, jednoduche odecteni versus abs. hodnota davaji neco jineho kvuli preteceni aritmetiky
figure
coef = 3; %zesileni
imshow(coef * Z);
title(['Absolutni rozdil (zesileny ' num2str(coef) 'krat)']);

% b/// Pomoci funkce Image Processing Toolboxu (odvolavaji se na stejny clanek)
tic
demosaicedImage_ = demosaic(recombinedRGBImage,'bggr');
toc

figure
imshow(demosaicedImage_);
title('Demozaikovany obraz (Matlab toolbox)');

Z_ = imabsdiff(rgbImage,demosaicedImage_);  %odchylka demozaikovaneho obrazu od RGB
norma_rozdilu_ = norm(double(Z_(:)))

figure
% imshow(10*abs(demosaicedImage_-demosaicedImage))
imshow(coef * Z_);
title(['Absolutni rozdil (zesileny ' num2str(coef) 'krat)']);


%%%%%%%%%%
function myDemosaic = demosaic_own(img)

    img_r = img(:,:,1);
    img_g = img(:,:,2);
    img_b = img(:,:,3);
    
    recomb = img_r + img_g + img_b;
    
    GR_GB = [0 0 -1 0 0; %inicializacia kernelov
         0 0 2 0 0;
        -1 2 4 2 -1;
         0 0 2 0 0;
         0 0 -1 0 0]/8 ;

    Rg_RB_Bg_BR = [0 0 0.5 0 0;
         0 -1 0 -1 0;
         -1 4 5 4 -1;
         0 -1 0 -1 0;
        0 0 0.5 0 0] /8;

    Rg_BR_Bg_RB = Rg_RB_Bg_BR';

    Rb_BB_Br_RR = [0 0 -1.5 0 0;
         0 2 0 2 0;
        -1.5 0 6 0 -1.5;
         0 2 0 2 0;
         0 0 -1.5 0 0]/8;
    
    mat_r = zeros(size(img_r)); %inicializacia matic
    mat_g1 = zeros(size(img_r));
    mat_g2 = zeros(size(img_r));
    mat_b = zeros(size(img_r));
 
    mat_r(2 : 2 : end, 2:2:end) = 1; %Bayerove masky pre kazdu farbu
    mat_g1(1 : 2 : end, 2:2:end) = 1;
    mat_g2(2 : 2 : end, 1:2:end) = 1;
    mat_b(1 : 2 : end, 1:2:end) = 1;

    G1 = conv2(recomb, GR_GB, 'same'); %G na R a B
    img_g(mat_r == 1) = G1(mat_r == 1);
    img_g(mat_b == 1) = G1(mat_b == 1);
    
    R1_B2 = conv2(recomb, Rg_BR_Bg_RB, 'same'); %R a B na G
    img_r(mat_g1 == 1) = R1_B2(mat_g1 == 1);
    img_b(mat_g2 == 1) = R1_B2(mat_g2 == 1);

    R2_B1 = conv2(recomb, Rg_RB_Bg_BR, 'same');
    img_r(mat_g2 == 1) = R2_B1(mat_g2 == 1);
    img_b(mat_g1 == 1) = R2_B1(mat_g1 == 1);

    RB_BR = conv2(recomb, Rb_BB_Br_RR, 'same'); %R a B na R a B
    img_r(mat_b == 1) = RB_BR(mat_b == 1); 
    img_b(mat_r == 1) = RB_BR(mat_r == 1); 

    myDemosaic = cat(3, img_r, img_g, img_b);
end