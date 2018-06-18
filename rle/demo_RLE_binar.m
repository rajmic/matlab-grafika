% Demonstrace RLE kódování binárních posloupností
% Uživatel nastaví vstupní obrázek, který musí být monochromatický (dvì barvy)
% a poèty bitù použitých pøi kódování

% (c) 2018 M. Matisko, P. Rajmic, Brno University of Technology

%% Inicializacia premennych
% filename = 'chess-64.png'; %nazev souboru s obrazkem
filename = 'chess-64-plus-line.png'; %nazev souboru s obrazkem
no_bits_for_0 = 3;  %pocet bitu, kterymi se budou kodovat sledy nul
no_bits_for_1 = 4;  %pocet bitu, kterymi se budou kodovat sledy jednicek

%% nacitanie obrazku
disp('1. Nacitanie obrazku a prevod do stupnov sedej')
Y = imread(filename);
if ~ismatrix(Y)
    Y = rgb2gray(Y);
end
Y = double(Y);
 
[M,N] = size(Y);
 
%% Vypocet bitovych rovin klasickych
Z = Y(:); %serazeni do vektoru
disp('2. Vypocet klasickych bitovych rovin')
bitstrings = dec2bin(Z); % binarni vyjadreni
 
mask = zeros(M*N,1); %maska pro budouci porovnavani - alokace pameti
% for cnt = 1:8
    mask = (bitstrings(:) == '1'); %porovnani retezcu - je to jednicka?
% end

%% Zobrazenie povodneho obrazku v monochromatickom rezime
%{
disp('2.5 Zobrazenie povodneho obrazu')
image_size=uint16(sqrt(size(mask)));
new_image=uint8(zeros(image_size(1,1), image_size(1,1)));
index=0;
for row=1:image_size(1,1)
    for col=1:image_size(1,1)
        index=index+1;
        if (mask(index,1)==1)
            new_image(row,col)=255;
        end
    end
end
image(new_image)
%}

%% Kodovanie
disp('3. Kodovanie vstupneho obrazu')
input_data = double(mask)';
encoded_data = double(bin_rle_encoder(input_data, no_bits_for_0, no_bits_for_1));

%% Dekodovanie
disp('4. Dekodovanie kodovanych dat')
decoded_data = double(bin_rle_decoder(encoded_data, no_bits_for_0, no_bits_for_1));

%% Porovnanie obrazku pred kodovanim a po dekodovani
LogicalStr = {'rozdiel', 'zhoda'};
fprintf('5. Kontrola zhody povodnych a dekodovanych dat: %s\n', ...
 LogicalStr{isequal(input_data, decoded_data)+1} )

%% Zobrazenie dekodovaneho obrazu v monochromatickom rezime
disp('6. Zobrazenie dekodovaneho obrazu')
image_size=uint8(sqrt(size(decoded_data)));
new_image=uint8(zeros(image_size(1,2), image_size(1,2)));
index=0;
for row=1:image_size(1,2)
    for col=1:image_size(1,2)
        index=index+1;
        if (decoded_data(1,index)==1)
            new_image(row,col)=255;
        end
    end
end
new_image = new_image';
image(new_image)

%% Zapis dekodovaneho suboru na disk
%{
disp('7. Zapisanie dekodovaneho obrazu do suboru na disk')
imwrite(new_image, 'decoded_image.jpg')
%}