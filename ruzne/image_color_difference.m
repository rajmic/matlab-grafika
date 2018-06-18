function [distance, difr] = image_color_difference(X,Y)

%Computes the difference between two images, and the Eucleidean distance
%for each pixel
%
%If X and Y are of size m x n x p, distance and difr are matrices of size m x n

% (c) 2015 Pavel Rajmic, BUT

[m,n,o] = size(X);

difr = X-Y;

distance = zeros(m,n);
for cnt_m = 1:m
    for cnt_n = 1:n
        dif_colour = zeros(o,1);
        for cnt_o = 1:o %if X,Y are only matrices, this does not have an effect
            dif_colour(cnt_o) = double(difr(cnt_m,cnt_n,cnt_o));
        end
        distance(cnt_m,cnt_n) = norm(dif_colour);
    end
end