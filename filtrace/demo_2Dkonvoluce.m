% Demonstruje konvoluci obrazu s ruznymi filtry (tj. impulznimi odezvami)

% (c) 2020 Martin Seckar, Pavel Rajmic, VUT v Brne

clear variables;
close all;
clc;

%% Nacteni obrazku
img = double(imread('lena_grayscale-kontrast_automaticky.png'));

%% Vyber konvolucni masky (tj. impulzni odezvy)
% a/ rozostreni 5×5
mask = [1 1 1 1 1;
        1 1 1 1 1; 
        1 1 1 1 1; 
        1 1 1 1 1; 
        1 1 1 1 1]
divisor = sum(mask(:));
offset = 0;
    
% % b/ rozostreni 9×9
% mask = ones(9,9)
% divisor = sum(mask(:));
% offset = 0;

% % c/ jine rozostreni, 3×3       
% mask = [1 2 1;
%         2 4 2;
%         1 2 1]%
% divisor = sum(mask(:));
% offset = 0;
    
% % d/ horni propust -- hranovy detektor 3×3 vertikalni 
% mask = [1 1 1;
%         0 0 0;
%        -1 -1 -1]
% divisor = 1
% offset = 127;

% % e/ horni propust -- hranovy detektor 3×3 horizontalni
% mask = [1 0 -1;
%         1 0 -1;
%         1 0 -1]
% divisor = 1;
% offset = 127;

% % f/ posunuty 2D Diracuv impulz 
% mask = [1 0 0;
%         0 0 0;
%         0 0 0]
% divisor = 1;
% offset = 0;


%% Vypocet a zobrazeni
figure
imshow(img,[0 255])

img_conv = conv2(img, mask, 'same')/divisor + offset;
% alternativne je mozne konvoluci pocitat primo dle vzorecku
% img_conv = convolution2d(img, mask)/divisor + offset;
figure
imshow(img_conv,[0 255])


%% Pomocna funkce na konvoluci
function img_conv = convolution2d(img, mask, divisor, offset)
% implementuje 2D konvoluci naprimo pomoci definicniho vztahu
% (tj. nasobeni a scitani)

    img_x = size(img, 1);
    img_y = size(img, 2);
    
    mask_x = size(mask, 2);
    mask_h = (mask_x - 1)/2;
       
    %rozsireni obrazu a vsechny strany, aby vysledna konvoluce mela stejny
    %pocet pixelu jako vstup
    %padarray prodluzuje nulovymi hodnotami; nasly by se lepsi volby
    img = padarray(img, [mask_h mask_h], 0);
    
    img_out = zeros(img_x,img_y);
    
    for i = 1 + mask_h:(size(img, 1) - mask_h)
        for j = 1 + mask_h:(size(img, 2) - mask_h)
            img_temp = img((i - mask_h):(i + mask_h), (j - mask_h):(j + mask_h)) .* mask;
            img_out(i, j) = sum(img_temp(:));
        end
    end
    
    img_conv = mat2gray(img_out)/divisor + offset;
end
