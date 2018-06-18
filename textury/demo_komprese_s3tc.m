function [cImage, rozdil_eukleides] = demo_komprese_s3tc()
% Demonstruje kompresi S3TC na RGB obrazku s osmi bity na kanal

% (c) 2012 Martin Kralik, Vysoke uceni technicke v Brne,
% upravy 2012, 2014, 2015 Pavel Rajmic, Vysoke uceni technicke v Brne

%% vstupni obrazek
filename = 'textura.bmp';
% filename = 'plant4.jpg';

%% nacteni a prevod do RGB 565
image = imread(filename);
imshow(image);
title('Originalni obraz')
%P�evede 24bitovou texturu RGB 888 do 16 bitov� hloubky RGB 565.
[r g b] = toRgb565(image);

%% pripadna zmena velikosti
%Uprav� velikost textury na n�sobky 4, pro kompresi se vyu��vaj� bloky 4X4.
%Rozm�r se uprav� tak, �e se p�esah odstran�.
%[r g b]=my_resize(image(:,:,1),image(:,:,2),image(:,:,3));
[r g b] = my_resize(r,g,b);

%% samotna blokova komprese
comprImag = compress(r,g,b);
[r g b] = toRgb888(comprImag(:,:,1),comprImag(:,:,2),comprImag(:,:,3));
cImage = cat(3,r,g,b); %srovnani do 3D-pole

%% vykresleni
figure
imshow(cImage);
title('Obraz po kompresi S3TC')

figure
rozdil_eukleides = image_color_difference(cImage,image);
imagesc(rozdil_eukleides)
colorbar
title('Odchylka originalu od komprimovaneho (po pixelech)')

end




function compressedImage = compress(r,g,b)
%V ka�d� barevn� slo�ce je vybr�n blok o rozm�rech 4x4 pixely, pro ka�d�
%takto vytvo�en� blok je vypo��tan� LUT tabulka. LUT tabulka obsahuje 4
%barvy, z �eho� dv� jsou vybr�ny z k�dovan�ho bloku. Vyb�r� se maxim�ln� a
%minim�ln� barva (��seln� hodnota). Dal�� dv� barvy jsou dopo��t�ny line�rn� interpolac�.
%Blok je v�sledn� zak�dov�n tak, �e ka�d� p�vodn� pixel (reprezentovan� 11
%bity) je nahrazen indexem ��seln� nejbli��� barvy zak�dovan� dv�ma bity.

[m,n]=size(r); %vime ze m,n jsou nasobky 4
compressedImage = uint8(zeros(m,n)); %alokace pameti pro vystup

for row=1:4:m-1
    for col=1:4:n-1
        %Vytvoren� bloku pro cervenou komponentu
        blockR = r(row:row+3,col:col+3);
        %Vytvoreni LUT pro dany blok,LUT je tvorena 4 barvami pro kazdy blok
        lutR = getLut(blockR);
        %Zakodov�n� bloku, vyb�r� se barva z LUT, ktera m� nejmensi vzdalenost
        %od barvy v originalu
        blockR = encodeBlock(blockR,lutR);
        
        %Vytvoren� bloku pro zelenou komponentu
        blockG = g(row:row+3,col:col+3);
        lutG = getLut(blockG);
        blockG = encodeBlock(blockG,lutG);
        
        %Vytvoren� bloku pro modrou komponentu
        blockB = b(row:row+3,col:col+3);
        lutB = getLut(blockB);
        blockB = encodeBlock(blockB,lutB);
        
        %Slozeni vysledneho komprimovaneho obrazku z jednotlivych
        %komponent
        compressedImage(row:row+3,col:col+3,1) = blockR;
        compressedImage(row:row+3,col:col+3,2) = blockG;
        compressedImage(row:row+3,col:col+3,3) = blockB;
    end
end
%     compressImageOut = compressImage;
end


function lut = getLut(block)
%Vytvoren� LUT tabulky, v bloku je nalezena minimaln� a maximalni hodnota,
%dalsi dve barvy jsou dopocitany.
maxColor1 = max(max(block,[],1),[],2);
minColor0 = min(min(block,[],1),[],2);
%Ze dvou vybranych barev jsou dalsi dve dopocitany linearni interpolaci
color2 = round((2/3)*minColor0 + (1/3)*maxColor1);
color3 = round((1/3)*minColor0 + (2/3)*maxColor1);

lut = [minColor0,maxColor1,color2,color3];
end


function [blockOut] = encodeBlock(block,lut)
%Nalezen� nejv�ce odpov�daj�c� barvy v LUT tabulce
%provede se pro kazdy pixel v bloku
for row=1:4
    for col=1:4
        
        pixel = block(row,col);
        odchylky = abs(int16(pixel)-int16(lut));
        minodchylka = min(odchylky);
        %nalezeni indexu v tabulce, ktery dava minimalni odchylku
        index = find(odchylky == minodchylka);
        %nahrazeni puvodni barvy pixelu barvou vybranou z LUT
        block(row,col) = lut(index(1));
        
%         minimum=intmax;
%         ind=0;
%         %Projdu LUT tabulku a najdi barvu s nejmensi vzdalenosti od
%         %soucasneho pixelu
%         for lutI = 1:4
%             if (abs(pixel-lut(lutI)) <minimum)
%                 %index vybrane barvy v LUT
%                 ind = lutI;
%                 minimum = abs(int16(pixel)-int16(lut(lutI)));
%             end
%         end
%         %Nahrad puvodni barvu pixelu barvou vybranou z LUT
%         block(row,col) = lut(ind);
        
%         if (lut(ind) - lut(index(1))) >0
%             error('dfdwfaf')
%         end
    end
end

blockOut=block;
end


function [r g b] = toRgb565(image) 
%prevedeni cervene komponenty na 5 bitu / kvantizace
r=image(:,:,1);
r=bitshift(r,-3);

%prevedeni zelene komponenty na 6 bitu / kvantizace
g=image(:,:,2);
g=bitshift(g,-2);

%prevedeni modre komponenty na 5 bitu / kvantizace
b=image(:,:,3);
b=bitshift(b,-3);
end

function [r g b]=my_resize(r,g,b)
%Za��znut� rozm�r� textury na n�sobek 4
[m,n]=size(r);
rowOver=m;
colOver=n;
%upraveni vysky na nasobek 4
if(mod(m,4)>0)
    rowOver=m-mod(m,4);
end
%upraveni sirky na nasobek 4
if(mod(n,4)>0)
    colOver=n-mod(n,4);
end

r=r(1:rowOver,1:colOver);
g=g(1:rowOver,1:colOver);
b=b(1:rowOver,1:colOver);
end
    

function[r g b]= toRgb888(r5, g6, b5)
%prevedeni cervene komponenty na 8 bitu
r=bitshift(r5,3);

%prevedeni zelene komponenty na 8 bitu
g=bitshift(g6,2);

%prevedeni modre komponenty na 8 bitu
b=bitshift(b5,3);
end
