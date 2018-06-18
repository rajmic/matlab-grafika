% Nacte obrazek a zobrazi jeho histogram(y)

clc
close all

filename = 'baboon_small.jpg'
figure
imshow(imread(filename))
image_hist(filename)

%pause

filename = 'rgb_noise_512x512.png'
figure
imshow(imread(filename))
image_hist(filename)

%pause

filename = 'lena_grayscale-kontrast_automaticky.png'
figure
imshow(imread(filename))
image_hist(filename)