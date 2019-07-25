% Vykresli pixely RGB obrazku jako body v 3D grafu

% (c) 2019 Syrine Ben Ameur, Pavel Rajmic, Brno University of Technology


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

%% YCbCr scatter plot
im_ycbcr = rgb2ycbcr(im); %convert to YCbCr (requires Image Processing Toolbox)
param.coloraxes = {'Y', 'Cb', 'Cr'};
param.coloraxeslimits = {[16 235], [16 240], [16 240]};
param.colorsToPlot = double(im)/255;
param.quantization = 5;
scatter3d(im_ycbcr,param)  % plot scatter
view(-49,14)   % for baboon image in YCbCr
title('Distribuce pixelu RGB po konverzi do YCbCr') % in original RGB colours