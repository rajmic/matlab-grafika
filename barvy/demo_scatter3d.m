% Vykresli pixely RGB obrazku jako body v 3D grafu (scatter plot)

% (c) 2019--2022 Syrine Ben Ameur, Pavel Rajmic, Brno University of Technology


close all
clear param

im = imread('baboon_small.jpg');    % load image

%% RGB scatter plot
figure
imshow(im)     % show image
param.quantization = 5;
scatter3d(im,param)  % plot scatter
view(135,50)   % for baboon image
title('Distribuce pixelu RGB v osach RGB')
axis square

%% YCbCr scatter plot
im_ycbcr = rgb2ycbcr(im); %convert to YCbCr (requires Image Processing Toolbox)
param.coloraxes = {'Cb', 'Cr', 'Y'};
param.coloraxeslimits = {[16 240], [16 240], [16 235]};
param.colorsToPlot = double(im)/255;
param.quantization = 5;

reorder = uint8(zeros(size(im_ycbcr)));
reorder(:,:,3) = im_ycbcr(:,:,1); %Y
reorder(:,:,1) = im_ycbcr(:,:,2); %Cb
reorder(:,:,2) = im_ycbcr(:,:,3); %Cr

scatter3d(reorder,param)  % plot scatter
view(-212.0865, 17.5879)   % pro baboon obrazek v YCbCr
title('Distribuce pixelu RGB po konverzi do YCbCr')
axis equal
axis([16 240 16 240 16 235])
