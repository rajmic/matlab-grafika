% Skript vypocte a zobrazi bitove roviny obrázku (normalni a Grayovy).
% Vstupní obrázek mùže být i barevný, ale v tom pøípadì se nejprve pøevede
% do stupnu sedi.

% (c) 2012-2014 Jiøí Kovaøík, Pavel Rajmic, VUT v Brnì

close all
clc

%% Vstupni parametry
filename = 'shoes.jpg'; %nazev souboru s obrazkem
Gray = true; %zda nas zajimaji take Grayovy roviny
writefiles = false; %true;%  %jestli se maji roviny ulozit jako samostatne obrazky (v aktualnim adresari)


%% Naètení obrázku
Y = imread(filename);
if ndims(Y) > 2
    Y = double(rgb2gray(Y));
end
% Y=Y(200:290,130:190);

%% Alokace pamìti pro bitové roviny
[M,N] = size(Y);
bp  = zeros(M,N,8); %3D-matice pro klasicke roviny
if Gray
    bpg = zeros(M,N,8); %3D-matice pro Grayovy roviny
end

%% Vypocet bitovych rovin klasickych
Z = Y(:); %serazeni do vektoru
disp(['Vypocet klasickych bitovych rovin'])
bitstrings = dec2bin(Z); % binarni vyjadreni

mask = zeros(M*N,1); %maska pro budouci porovnavani - alokace pameti
for cnt = 1:8
    mask = (bitstrings(:,cnt) == '1'); %porovnani retezcu - je to jednicka?
    bp(:,:,cnt) = reshape(mask*255,M,N);
end

%% Vypocet bitovych rovin Grayovych
if Gray
    disp(['Vypocet Grayovych bitovych rovin (muze trvat dlouho)'])
    bitstrings_gray = binary2gray(bitstrings); % prepocet do Grayova kodu
    
    mask = zeros(M*N,1); %maska pro budouci porovnavani - alokace pameti
    for cnt = 1:8
        mask = (bitstrings_gray(:,cnt) == '1'); %porovnani retezcu - je to jednicka?
        bpg(:,:,cnt) = reshape(mask*255,M,N);
    end
end

%% Zobrazeni v jedne figure - klasicke
figure
% Original
subplot(3,3,1)
image(uint8(Y))
colormap(gray(255))
title('Originální obrázek')
axis off
axis image

% Bitove roviny
for cnt=1:8
    subplot(3,3,cnt+1)
    image(uint8(bp(:,:,cnt)))
    colormap(gray(255))
    title([num2str(cnt) '. bitová rovina'])
    axis off
    axis image
end
    
%% Zobrazeni v jedne figure - Grayovy
if Gray
    figure
    % Original
    subplot(3,3,1)
    image(uint8(Y))
    colormap(gray(255))
    title('Originální obrázek')
    axis off
    axis image
    
    % Bitove roviny
    for cnt=1:8
        subplot(3,3,cnt+1)
        image(uint8(bpg(:,:,cnt)))
        colormap(gray(255))
        title([num2str(cnt) '. Gray-bitová rovina'])
        axis off
        axis image
    end
end

%% Samostatne obrazky zapsat na disk
if writefiles
    figure
    image(uint8(Y))
    colormap(gray(255))
    title('Vstupni obrazek')
    axis off
    axis image
    imwrite(uint8(Y),'obr-bit_roviny-vstupni.png')

    %klasicke roviny
    for cnt = 1:8
        figure
        image(uint8(bp(:,:,cnt)))
        colormap(gray(255))
        title(['Obrazek odpovidajici bitove hladine c. ' num2str(cnt)])
        axis off
        axis image
        imwrite(uint8(bp(:,:,cnt)),['obr-bitova_rovina_' num2str(cnt) '.png'])
    end
    
    %Grayovy roviny
    if Gray
        for cnt = 1:8
            figure
            image(uint8(bp(:,:,cnt)))
            colormap(gray(255))
            title(['Obrazek odpovidajici Grayove bitove hladine c. ' num2str(cnt)])
            axis off
            axis image
            imwrite(uint8(bpg(:,:,cnt)),['obr-bitova_rovina_Gray_' num2str(cnt) '.png'])
        end
    end
end