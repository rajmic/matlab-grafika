% demo, ktere ukazuje koder JPEG az do urovne bitu
% sedotonovy obrazek na vstupu

% (c) 2010-2016 Pavel Rajmic, Brno University of Technology

home;
close all
% clear variables
% clear all;
param.verbose = true; %false; %zda se maji vypisovat meziinformace z koderu/dekoderu

%% kvalita [0,100]
%kvalita 100 jeste neznamena bezeztratovost -- kvantizace DCT ma za dusledek zaokrouhlovaci chyby
quality = 20; %vychozi je 50  

%% nacteni obrazku ke komprimaci
image = imread('0.tif');
% image = imread('16x16.tif');
% image = imread('160x104.tif');
[dim_vert, dim_horiz] = size(image); %zjisteni velikosti

%% vyvolani tabulek
Qmtx = quant_matrix(quality); 
htaclum = huffman_table_ac_lum();
htdclum = huffman_table_dc_lum();

%% kodovani
disp(['Zahajeni kodovani...'])
[bitstream, RSseries, bity] = jpeg_encode(image, Qmtx, htaclum, htdclum, param);

%% vypis
disp(' ')
disp(['Delka vysledneho bitoveho toku: ' num2str(length(bitstream)) ' bitu'])
disp(['Vysledny bitovy tok po kodovani:'])
disp(bitstream)
disp(' ')
disp(' ')
disp('Zahajeni dekodovani...')

%% dekodovani
[ image_recon ] = jpeg_decode(bitstream, Qmtx, htaclum, htdclum, dim_horiz, dim_vert, param);

%% PSNR
MSEr = norm(double(image-image_recon),'fro')^2 / dim_vert / dim_horiz;
PSNR = 10*log10(255^2 / MSEr ) 

%% zobrazeni, porovnani
%figure
%imshow(image)

figure
%imshow(image_recon)
subplot(1,3,1), subimage(image), title('Original'), axis square tight off
subplot(1,3,2), subimage(image_recon), title(['JPEG kodek, Q=' num2str(quality)]), axis square tight off
subplot(1,3,3), imagesc(abs(image_recon-image)), title(['Absolutni rozdily; PSNR=' num2str(PSNR)]), axis square tight off, colorbar

% figure
% imagesc(abs(image_recon-image))
% colorbar