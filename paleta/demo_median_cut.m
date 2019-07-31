% Demo ukazuje vytvoøení palety barev za použití algoritmu Median-cut

close all
clear variables

%% Read the image and set parameters
im = imread('baboon_small.jpg'); %image
n_colours = 10;  %number of colors to be used
param.avgMethod = 'mean'; %or use 'median'

%% Displaying original image and RGB scatter
figure %1
imshow(im);    %show the image
param.quantization = 5; %how much to reduce number of pixels for plotting
scatter3d(im,param)  %scatter plot in RGB model
% view(40,35)
view(73,26)

%% Median-cut
[paleta, quantized_image, RMSE] = median_cut(im,n_colours,param);

%% Display processed image and scatter RGB
figure
imshow(uint8(quantized_image))

% Colors
param.colorsToPlot = quantized_image/255;
param.quantization = 5; %how much to reduce number of pixels for plotting
handle = scatter3d(im,param);  % plot scatter
% view(40,35)
view(73,26)
handle.MarkerFaceAlpha = 0.25;

% plot colours from palette
hold on
scatter3(paleta(:,1), paleta(:,2), paleta(:,3), 100, paleta/255,...
                                               'MarkerEdgeColor','k',...
                                                'MarkerFaceColor', 'w',...
                                                'LineWidth', 1.5);
% set(gco,'Marker','s')
% % set(gco,'MarkerEdgeColor','k')
% % set(gco,'MarkerFaceColor', palette/255)
% set(gco,'LineWidth', 5)

hold off

%% Print out
param.avgMethod
paleta
RMSE

