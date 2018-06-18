% Dekoder zalozeny na prediktoru s primou vazbou

%% parametry
W = [0.5 -0.5 1]; %volitelne vahy

%% Výchozí matice predikcí
figure
subplot(1,2,1);
imagesc(output)
axis image
colorbar
% mesh(output);
title('Matice predikci');


%% Poèítání (dekomprese)
%output je vstupni matice
img = zeros(size(output));
sW = numel(W);

for(y = 1:1:size(img,1))
    img(y,1:sW) = output(y,1:sW);
    for(x = sW+1:size(img,2))
        predikce = img(y,x - sW:x - 1) * W';
        img(y,x) = output(y,x) + predikce;
    end
end

subplot(1,2,2);
title('Vysledny obrazek');
imshow(img);