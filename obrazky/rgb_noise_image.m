function image = rgb_noise_image(rows,cols,channels,filename)

% generates (uniformly) random RGB image of specified size
% and (optionally) saves it into a file
%
% channels = 1 produces grayscale noise
% channels = 3 produces RGB noise

% 2012-13 Pavel Rajmic, Jan Zatyik

image = randi([0,255],rows,cols,channels);
image = uint8(image);

if nargin > 3
    if ischar(filename)
        imwrite(image,filename)
    end
end