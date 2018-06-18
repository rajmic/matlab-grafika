% Demonstrates the 3D-histogram made from an RGB image

% 2012-13 Pavel Rajmic, Jan Zatyik

close all
clc

%% 1
filename = 'baboon_small.jpg'
figure
imshow(filename);
[freq, freq_emph, freq_ly] = image_hist_RGB_3d(filename,6)
% pause

%% 2
filename = 'clown.jpg'
figure
imshow(filename);
[freq, freq_emph, freq_ly] = image_hist_RGB_3d(filename,5);
% pause

%% 3
% generate noise image
filename = 'rgb_noise.png'
im = rgb_noise_image(200,300,3,filename);
figure
imshow(filename);
[freq, freq_emph, freq_ly] = image_hist_RGB_3d(filename,4);