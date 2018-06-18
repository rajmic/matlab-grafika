function [out, imgWidth, imgHeight, table] = rle_coder(in, typ_algoritmu)
%Program urceny pro kompresi obrazu algoritmem Run Length Encoding
%
%Prochazi se obraz po radcich vzdy odshora dolu, odleva doprava. Pokud je na vstupu
%obrazek RGB, je preveden na stupne sedi.
%
%in - nazev vstupniho snimku urceneho ke kodovani
%typ_algoritmu - zpusob kodovani:
%       1 - | pocet stejnych hodnot | hodnota |
%       2 - rozlisení nejvyssím bitem pro opakujici se hodnoty
%       22 - rozlišení nejvyšším bitem pro opakujici se hodnoty  za použití
%       palety barev
%       3 - rozlisení nejvyssim bitem pro neopakujici se hodnoty
%
%out - vektor vystupni zakodovane posloupnosti, cisla jsou ve formatu uint8
%table - vystupni vektor pro paletu barev, je pouzit pro zpusob kodovani 22
%imgWidth - sirka vstupniho obrazu
%imgHeight - vyska vstupniho obrazu
%
%Priklad pouziti - [out,imgWidth,imgHeight] = rle_coder('lena_32barev.png',1);

% (c) 2012 Jan Masek (xmasek10), drobne upravy 2012-14 Pavel Rajmic


%% Nacteni originalniho obrazku
img = imread(in);

% Prevedeni na sedotonovy obraz
imgChannels = ndims(img);
if (imgChannels == 3)
    img = rgb2gray(img);
end

imgWidth = size(img,2);
imgHeight = size(img,1);

%Zobrazeni vstupniho snimku
figure(1);
imshow(img);
title('Vstupni obraz');

%Prevedeni matice na vektor
img = img(:); %reshape(img', 1, imgWidth * imgHeight);

%Vypis velikosti
disp(' ') %mezera
vypis_velikost(img,'Velikost vstupniho obrazu: ')

%% Alokace vystupniho vektoru
% maximalni mozna velikost, nemusi byt pri kodovani vyuzita
out = zeros(1,length(img)*2,'uint8'); %osmibitove hodnoty
%Vytvoreni pole pro paletu barev (nadbytecne pro typy kodovani 1,2,3)
table = zeros(256,1);

%% Vyber typu kodovani
switch typ_algoritmu
    case 1
        disp('Probiha kodovani dvojbajtoveho typu:  | Pocet stejnych hodnot | Hodnota |.')
        count = 0;
        index = 1;
               
        A=img(1);
        for i = 2:1:length(img) %cyklus pres pixely
            B=img(i);
            if (A == B && count < 255) %hodnota se opakuje
                count=count+1;
            else
                out(index) = count; %pocet stejnych hodnot (max. 255)
                out(index+1) = A; %hodnota
                index = index + 2;
                A = B;
                count = 0;
            end
        end
        
        %Ulozeni poctu pro posledni stejnou hodnotu v obraze
        out(index) = count;
        out(index+1) = A;
        
        %Odstraneni nevyuzitych alokovanych mist
        out = out(1:index+1);
        vypis_velikost(out,'Velikost kodovaneho obrazu: ')
        
    case 2
        disp('Probiha kodovani typu: Rozlišení nejvyšším bitem pro opakujici se hodnoty.')
        count = 0;
        index = 1;
        
        A=img(1);
        for i = 2:1:length(img)
            B = img(i);
            if(A == B && count < 127) %hodnota se opakuje
                count = count+1; 
            elseif(A < 128 && count == 0) %zapis neopakujici se 7bitove hodnoty
                out(index) = A; %A<128, tzn. nejvyssi bit je '0'
                index = index + 1;
                A = B;
            else %zapis 8bitove hodnoty
                out(index) = 128 + count; %tzn. nejvyssi bit je '1'
                out(index+1) = A;
                index = index + 2;
                A = B;
                count = 0;
            end
        end
        
        %Ulozeni poctu pro posledni stejnou hodnotu v obraze
        %Zapis jedine 7bitove hodnoty
        if(A < 128 && count == 0)
            out(index) = A;
        else
            out(index) = 128 + count;
            index = index + 1;
            out(index) = A;
         end
        
        %Odstraneni nevyuzitych alokovanych mist
        out = out(1:index);
        vypis_velikost(out,'Velikost kodovaneho obrazu: ')
        
    case 22
        disp('Probiha kodovani typu: Rozlišení nejvyšším bitem pro opakujici se hodnoty  za použití palety barev.')
        %Volani funkce pro ziskani tabulky barevne palety
        [table,indexed_img,velikost] = create_palette(img);
        img = indexed_img;
               
        count = 0;
        index = 1;
        
        A=img(1);
        for i = 2:1:length(img)
            B = img(i);
            if(A == B && count < 127) %hodnota se opakuje
                count = count+1; 
            elseif(A < 128 && count == 0) %zapis neopakujici se 7bitove hodnoty
                out(index) = A; %A<128, tzn. nejvyssi bit je '0'
                index = index + 1;
                A = B;
            else %zapis 8bitove hodnoty
                out(index) = 128 + count; %tzn. nejvyssi bit je '1'
                out(index+1) = A;
                index = index + 2;
                A = B;
                count = 0;
            end
        end
        
        %Ulozeni poctu pro posledni stejnou hodnotu v obraze
        %Zapis jedine 7bitove hodnoty
        if(A < 128 && count == 0)
            out(index) = A;
        else
            out(index) = 128 + count;
            index = index + 1;
            out(index) = A;
         end
        
        %Odstraneni nevyuzitych alokovanych mist
        out = out(1:index);
        vypis_velikost(out,'Velikost kodovaneho obrazu: ')
        disp(['Velikost barevne palety (tabulky): ' num2str(velikost),' polozek'])
        
    case 3
        disp('Probiha kodovani typu: Rozlišení nejvyšším bitem pro neopakujici se hodnoty.')
        count = 0; %Pocet po sobe jdoucich stejnych hodnot
        count2 = 0; %Pocet po sobe jdoucich ruznych hodnot
        index = 1;
        A = img(1);
        for i = 2:1:length(img)
            B = img(i);
            if (A == B && count < 127) %Opakujici se hodnota
                count = count + 1;
                if (count2~=0)
                    index = index + count2 + 1;
                    count2 = 0;
                else
                    index = index + count2;
                end
                
            elseif (count == 0 && count2 < 128) %Zapis neopakujici se hodnoty
                out(index) = count2; %Zapis hodnoty poctu neopakujicich se hodnot, tzn. nejvyssi bit je '0'
                count2 = count2 + 1;
                out(index+count2) = A;
                A = B;
            elseif(count2 == 128) %Pokud ma citac maximalni velikost
                index = index + count2 + 1;
                count2 = 0;
                out(index) = count2;
                count2 = count2 + 1;
                out(index+count2) = A;
                A = B;
            else
                out(index) = 128 + count; %Pocet stejnych hodnot, tzn. nejvyssi bit je '1'
                out(index+1) = A;
                index = index + 2;
                A = B;
                count = 0;
            end
        end
        
        %Ulozeni poctu pro posledni stejnou hodnotu v obraze
        if (count == 0)
            out(index) = count2;
            index = index + count2 + 1;
            out(index) = A;
        else
            out(index) = 128 + count;
            index = index + 1;
            out(index) = A;
        end
        
        %Odstraneni nevyuzitych alokovanych mist
        out = out(1:index);
        vypis_velikost(out,'Velikost kodovaneho obrazu: ')
        
    otherwise
        error('Zadana spatna vstupni hodnota zpusobu kodovani!!!')
end

disp(' ')%mezera

end

function vypis_velikost(data,text)
%vypise velikost posloupnosti cisel (uint8) v kilobajtech
kB = 1024;
disp([text num2str(round(length(data)/kB)) ' kB']);
end