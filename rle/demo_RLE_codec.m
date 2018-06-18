% demo ukazujici varianty kodovani RLE

% (c) 2012-2014 Pavel Rajmic, VUT v Brne


%% vstupni parametry
varianta = 3; % 1,2,22 nebo 3
input_img = 'lena_32barev.png';


clc
close all
tic

%% kodovani
disp(['Zahajuji proces kodovani variantou ' num2str(varianta)])
[out, imgWidth, imgHeight, table] = rle_coder(input_img, varianta);

%% dekodovani
disp(' ')
disp('Zahajuji proces dekodovani')
decoded_img = rle_decoder(out, imgWidth, imgHeight, varianta, table);
disp(' ')

%% Je vstupni obraz shodny s vystupnim
input_img = imread(input_img);

if (isequal(decoded_img, input_img))
    disp('Kontrola: Vstupni obraz je shodny s vystupnim.')
else
%     norm(decoded_img - input_img) % rozdil
    error('Kontrola: Vstupni obraz NENI shodny s vystupnim!!!')
end

%% konec
disp(' ')
disp('Dokonceno.')
disp(' ')

toc