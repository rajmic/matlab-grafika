function h = scatter3d(im,param)
% 3D scatter plot of pixels in image
%
% im ...... input 3D array, each coordinate corresponds to one matrix
% param ... structure of optional parameters:
%      .coloraxes .......... axes labels
%      .coloraxeslimits .... axes limits
%      .colorsToPlot ....... RGB triples in [0 1]x[0 1]x[0 1] to be used
%                            for corresponding positions in 'im';
%                            it has to bear the same structure as 'im'
%      .quantization ....... width of quantization interval 
%                            (quant. is beneficial for large images to accelerate plotting)

% (c) 2019 Syrine Ben Ameur, Pavel Rajmic, Brno University of Technology

im = double(im);

% Extract components
first = im(:,:,1);
second = im(:,:,2);
third = im(:,:,3);

% Form matrix with triplets as rows
data = [first(:) second(:) third(:)];
% maximum = max(max(data));

% Check if parameters are present
if ~exist('param','var')
    param = struct; %structure with no fields (necessary for correct further processing)
end

% Quantize if requested
if isfield(param,'quantization')  %if requested
    data =  round(data / param.quantization) * param.quantization;  %quantize
%     data(data>maximum) = maximum
end

%% Plot
% Avoid pixels with identical RGB values
if ~isfield(param,'colorsToPlot')
    data = unique(data, 'rows');
    param.colorsToPlot = data/255; %default colors are RGB values itself
else %make the colors the same structure
    firstC = param.colorsToPlot(:,:,1);
    secondC = param.colorsToPlot(:,:,2);
    thirdC = param.colorsToPlot(:,:,3);
    param.colorsToPlot = [firstC(:) secondC(:) thirdC(:)];
%     param.colorsToPlot = unique(dataC, 'rows');
end

% Plot
figure
h = scatter3(data(:,1), data(:,2), data(:,3), 20, param.colorsToPlot, 'filled');

% Axes labes
if ~isfield(param,'coloraxes')  %default is RGB axes
    param.coloraxes = {'R', 'G', 'B'};
end

xlabel(param.coloraxes{1})
ylabel(param.coloraxes{2})
zlabel(param.coloraxes{3})

% Axes limits
% please be aware that if quantization happens above, the new values can
% fall outside of the original axis limit (e.g. 255 could become 260)
if ~isfield(param,'coloraxeslimits')  %default is RGB axes
    param.coloraxeslimits = {[0 255], [0 255], [0 255]};
end

set(gca, 'XLim', param.coloraxeslimits{1})
set(gca, 'YLim', param.coloraxeslimits{2})
set(gca, 'ZLim', param.coloraxeslimits{3})

axis equal  %identical scaling
