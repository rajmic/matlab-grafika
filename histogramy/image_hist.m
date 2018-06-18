function image_hist(filename)
% function [R,Rout,G,Gout,B,Bout] = image_hist(filename)

% Spocita a nakresli histogram(y) složek obrazku 8 bpp/kanal
%
% jednokanalovy obrazek se povazuje za stupne sedi,
% trikanalovy za RGB truecolor

%% Nacteni obrazku
img = imread(filename);

%% Rozhodnuti
channels = size(img,3)
if channels == 3 %RGB
    popisky = {'Kanal R' 'Kanal B' 'Kanal G'};
    barvicky = {'r' 'g' 'b'};
elseif channels == 1 %stupne sedi
    popisky = {'Stupne sedi'};
    barvicky = {'k'};
else
    error('Chyba')
end

%% Vykreslovani kanal po kanalu
for chan = 1:channels
    kanal = img(:,:,chan);
    kanal_vec = double(kanal(:));
    
    [H, Hout] = hist(kanal_vec,256); %vypocet histogramu Matlabem
    
    figure
    bar(Hout, H, 1.0, barvicky{chan})
    h = gca;
    set(h,'XLim',[0 255]);
    set(h,'YTick',[]);
    title(popisky{chan});
end