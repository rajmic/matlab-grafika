function [palette, imQ, RMSE] = median_cut(im,n_colours,param)
% performs the median-cut algorithm for generation of a palette
% for a given image
%
% im .................input image (RGB m×n×3)
% n_colours ..........number of colours in the palette
% param.avgMethod ....either 'mean' or 'median'; will be used for 
%                     assigning representative colour to each group of
%                     pixels
%
% palette ............the set of RGB colours found 
% imQ ................quntized image (RGB m×n×3), i.e. the pixels have
%                     colours from the palette
% RMSE ...............root mean square error of the original vs. quantized
%                     image

% References:
% An Overview of Color Quantization Techniques by Steven Segenchuk
% https://web.cs.wpi.edu/~matt/courses/cs563/talks/color_quant/CQindex.html
% and
% https://www.cs.tau.ac.il/~dcor/Graphics/cg-slides/color_q.pdf

% (c) 2019 Syrine Ben Ameur, Pavel Rajmic, Brno University of Technology


[h, w, ~] = size(im);
im = double(im);

% separate channels
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);


%% Initialize vectorized image
RGBmtx = zeros(h*w , 4); % each row will be RGB triplet and the pixel index

% columns with color
RGBmtx(:,1) = r(:);
RGBmtx(:,2) = g(:);
RGBmtx(:,3) = b(:);
% index column
RGBmtx(:,4) = (1:h*w);


%% Median cut algorithm

%Initialization
max_range = [];
channel = [];

max_red = [];
min_red = [];
range_red = [];

max_green = [];
min_green = [];
range_green = [];

max_blue = [];
min_blue = [];
range_blue = [];

listQ = {(RGBmtx)};
nb = 1;
for colour = 1:n_colours-1 %n_colours needed, so one less divisions of the RGB space will be done
    
    for i = 1:length(listQ) %compute ranges of colours over ALL lists (a bit redundant since only two lists change in an iteration)
        
        % The listQi is an array of listQ{i}
        listQi = listQ{i}; %pick one list after each other
        
        % Max ranges of listQ{i}
        max_red = max(listQi(:,1));
        min_red = min(listQi(:,1));
        range_red = max_red - min_red;
        
        max_green = max(listQi(:,2));
        min_green = min(listQi(:,2));
        range_green = max_green - min_green;
        
        max_blue = max(listQi(:,3));
        min_blue = min(listQi(:,3));
        range_blue = max_blue - min_blue;
        
        % Max range and corresponding channel in listQ{i}
        [max_range(i), channel(i)] = max([range_red, range_green, range_blue]);
        
        %         listQ{i} = sortrows(listQi, channel(i)); % Sorting the list in ascending order  
    end
    
    % Widest range of all lists and number(position) of the list with the max range
    [~, total_max_position] = max(max_range);
    widestList = listQ{total_max_position};
    
    %sort the widest list (in ascending order) and split it into two
    cut = floor(size(widestList,1)/2); % find the position of the median (does not depend on sorting)
    widestList = sortrows(widestList, channel(total_max_position)); % Sorting the list in ascending order
    listQ1 = widestList(1:cut, :);
    listQ2 = widestList(cut+1:end, :);
    
    % Substituting the widest sublist with the new listQ1
    listQ{total_max_position} = listQ1;
    
    % Adding to the listQ the new listQ2
    nb = nb+1;
    listQ{nb} = listQ2;
    
end


%% Create palette = assign a single representative colour to each list

palette = zeros(n_colours,3); %initialize
for cnt = 1:n_colours
    if param.avgMethod == 'mean'
        palette_red   = round(mean(listQ{cnt}(:,1)));
        palette_green = round(mean(listQ{cnt}(:,2)));
        palette_blue  = round(mean(listQ{cnt}(:,3)));
    elseif param.avgMethod == 'median'
        palette_red   = round(median(listQ{cnt}(:,1)));
        palette_green = round(median(listQ{cnt}(:,2)));
        palette_blue  = round(median(listQ{cnt}(:,3)));
    else
        error('Bad parameter')
    end
    
    palette(cnt,:) = [palette_red, palette_green, palette_blue];
end


%% Form image with colours only from palette

listQ_palette = listQ; % make a copy
for cnt = 1:n_colours
    % substitute original colours with those from palette
    listQ_palette{cnt}(:,[1 2 3]) = repmat(palette(cnt,:),size(listQ_palette{cnt},1),1);
end

RGBmtxQ = sortrows(cell2mat(listQ_palette'), 4);
imQ = reshape(RGBmtxQ(:,1:3),[h, w, 3]);


%% RMSE - Root Mean Squared Error

RGB_diff = RGBmtx(:,1:3) - RGBmtxQ(:,1:3);
norms = sum(RGB_diff.^2,2); % for each row
RMSE = sqrt(sum(norms)/(w*h));

