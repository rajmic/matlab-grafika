% Vykresli barvy RGB modelu jako body v 3D grafu (scatter plot) a ukaze totez pro barvy prevedene do stupnu sedi

% (c) 2022 Pavel Rajmic, Brno University of Technology

close all
clear param

%% vstupni parametry
%RGB vahy (museji dohromady dat jednicku)
weights = [1 1 1]/3   %prumerovani
% weights = [.299 .587 0.114]
% weights = [.2126 .7152 .0722]  %HDTV, ITU-R BT.709-3

%% scatterplot celeho RGB modelu
%nalezeni vsech kombinaci = zaplneni cele krychle
% v = 0:31:255;
v = round(linspace(0,255,5));
C = uint8(nmultichoosek(v,3));
C = [C; C(:,[1 3 2]); C(:,[3 1 2]); C(:,[3 2 1]); C(:,[2 3 1]); C(:,[2 1 3])]; %vsechny mozne kombinace trojic RGB
C = unique(C,'rows');

image = uint8(zeros(size(C,1),1,3)); %fiktivni jednosloupcovy RGB obrazek
image(:,1,1) = C(:,1);
image(:,1,2) = C(:,2);
image(:,1,3) = C(:,3);

%vykresleni
param.quantization = 5;
scatter3d(image,param);  % plot scatter
title('Barvy v modelu RGB')
axis square

%% Prepocet do stupnu sedi
%Prepocet lze realizovat pomoci nasobeni matici, ale pre- a postprocessing je zbytecne zdlouhavy...
image_projected = zeros(size(image));
image_projected(:,:,1) = weights(1)*image(:,:,1) + weights(2)*image(:,:,2) + weights(3)*image(:,:,3); %kanal R
image_projected(:,:,2) = image_projected(:,:,1); %kopie do kanalu G
image_projected(:,:,3) = image_projected(:,:,1); %kopie do kanalu B
image_projected = uint8(image_projected);  %se zaokrouhlenim

%% Scatter prepocteneho
param.quantization = 1;
scatter3d(image_projected,param);  % plot scatter
% view(135,50)   % for baboon image
title(['Stupne sedi z modelu RGB, vahy [' num2str(weights) ']'])
axis square

%% Dokresleni sipek
hold on
%prevod na double kvuli odecitani poli (aby mohlo byt zaporne)
image = double(image);
image_projected = double(image_projected);
%vykresleni vektoroveho pole
quiver3(image(:,:,1), image(:,:,2), image(:,:,3), ...
    image_projected(:,:,1)-image(:,:,1), image_projected(:,:,2)-image(:,:,2), image_projected(:,:,3)-image(:,:,3),0);
% view(-7.6413, 22.3926)
% view(9.4302, 36.4062)
view(30.3944, 38.8085)

% plot3([image(:,:,1) image_projected(:,:,1)], ...
%       [image(:,:,2), image_projected(:,:,2)], ...
%       [image(:,:,3), image_projected(:,:,3)]);