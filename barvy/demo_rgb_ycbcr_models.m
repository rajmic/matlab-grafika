% Vykresli barvy RGB modelu jako body v 3D grafu (scatter plot) a totez v YCbCr

% (c) 2022 Pavel Rajmic, Brno University of Technology

close all
clear param

%% scatterplot celeho RGB modelu
%nalezeni vsech kombinaci = zaplneni cele krychle
v = 0:31:255;
% C = nchoosek(v,3);
C = uint8(nmultichoosek(v,3));
C = [C; C(:,[1 3 2]); C(:,[3 1 2]); C(:,[3 2 1]); C(:,[2 3 1]); C(:,[2 1 3])]; %vsechny mozne kombinace trojic RGB
C = unique(C,'rows');
im = uint8(zeros(size(C,1),1,3)); %fiktivni jednosloupcovy RGB obrazek
im(:,1,1) = C(:,1);
im(:,1,2) = C(:,2);
im(:,1,3) = C(:,3);

param.quantization = 5;
scatter3d(im,param)  % plot scatter
% view(135,50)   % for baboon image
title('Distribuce barev v osach RGB')
axis square

%% scatter plot celeho YCbCr
im_ycbcr = rgb2ycbcr(im); %konverze do YCbCr (vyzaduje Image Processing Toolbox)
% preskladani kanalu pro zobrazeni, kde osa Y bude nahoru
param.coloraxes = {'Cb', 'Cr', 'Y'};
param.coloraxeslimits = {[16 235], [16 240], [16 240]};
param.colorsToPlot = double(im)/255;
param.quantization = 5;
reorder = uint8(zeros(size(im_ycbcr)));
reorder(:,:,3) = im_ycbcr(:,:,1); %Y
reorder(:,:,1) = im_ycbcr(:,:,2); %Cb
reorder(:,:,2) = im_ycbcr(:,:,3); %Cr

% vykresleni
scatter3d(reorder,param)  % plot scatter
view(-43.2910, 15.1856)
title('Distribuce barev RGB po konverzi do YCbCr') % vykresleno v originalnich RGB barvach
axis equal