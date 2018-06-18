function image = rle_decoder(in, imgWidth, imgHeight, typ_algoritmu, table)
%Program urceny pro dekompresi obrazu algoritmem Run Length Encoding
%
%Ze vstupniho vektoru zakodovane poslopnosti je provedeno dekodovani podle
%zvoleneho typu algoritmu a podle hodnot sirky a vysky je
%provedena rekonstrukce obrazu, ktery je pak vykreslen.
%
%in - vektor vstupni zakodovane posloupnosti, cisla jsou ve formatu uint8
%typ - zpusob kodovani:
%       1 - | pocet stejnych hodnot | hodnota |
%       2 - rozlišení nejvyšším bitem pro opakujici se hodnoty
%       22 - rozlišení nejvyšším bitem pro opakujici se hodnoty  za použití
%       palety barev
%       3 - rozlišení nejvyšším bitem pro neopakujici se hodnoty
%
%imgWidth - sirka obrazu
%imgHeight - vyska obrazu
%table - vstupni vektor pro paletu barev, je pouzit pro zpusob dekodovani 22
%
%Priklad pouziti - image=rle_decoder(in, 512, 512, table, 1);
%
%(c) 2012 Jan Masek (xmasek10), drobne upravy 2012 Pavel Rajmic

%% Alokovani vektoru pro vystupni obraz
out = zeros(imgWidth*imgHeight,1,'uint8'); %osmibitove hodnoty
disp(' ') %mezera

%% Vyber typu dekodovani
switch typ_algoritmu
    case 1
        disp('Probiha dekodovani dvojbajtoveho typu:  | Pocet stejnych hodnot | Hodnota |.')
        index = 0;
        
        for i = 1:2:length(in)
            number = in(i); %Pocet stejnych hodnot
            number = uint32(number)+1; %Pretypovani promenne
            value = in(i+1); %hodnota
            for j = 1:number
                out(index+j) = value; %Nahrani hodnoty pixelu
            end
            index = index + number;
        end
              
    case 2
        disp('Probiha dekodovani typu: Rozlišení nejvyšším bitem pro opakujici se hodnoty.')
        index = 0;
        i = 1;
        
        while (i <= length(in))
            
            if (in(i) < 128) %Pro neopakujici se 7bitove hodnoty
                value = in(i); %hodnota
                index = index + 1;
                out(index) = value; %Nahrani hodnoty pixelu
                i = i + 1;
            else %Pro 8bitove hodnoty
                number = in(i);
                number = uint32(number) + 1 - 128; %Pocet 8bitovych hodnot, pretypovani promenne
                value = in(i+1); %hodnota
                i = i + 2;
                for j = 1:number
                    out(index+j) = value; %Nahrani hodnoty pixelu
                end
                index = index + number;
            end
        end
        
    case 22
        disp('Probiha dekodovani typu: Rozlišení nejvyšším bitem pro opakujici se hodnoty za použití palety barev.')
        index = 0;
        i = 1;
        
        while (i <= length(in))
            
            if (in(i) < 128) %Pro neopakujici se 7bitove hodnoty
                value = in(i); %hodnota
                index = index + 1;
                out(index) = value; %Nahrani hodnoty pixelu
                i = i + 1;
            else %Pro 8bitove hodnoty
                number = in(i);
                number = uint32(number) + 1 - 128; %Pocet 8bitovych hodnot, pretypovani promenne
                value = in(i+1); %hodnota
                i = i + 2;
                for j = 1:number
                    out(index+j) = value; %Nahrani hodnoty pixelu
                end
                index = index + number;
            end
        end
        
        %Vytvoreni docasne promene pro obraz
        temp_out = out;
        
        %Prevod obrazu zpet s vyuzitim palety barev
        for cnt = 1:length(table)
            out(temp_out==cnt) = table(cnt);
        end
                
    case 3
        disp('Probiha dekodovani typu: Rozlišení nejvyšším bitem pro neopakujici se hodnoty.')
        index = 0;
        i=1;
        
        while(i <= length(in))
            
            if(in(i) < 128) %Pro neopakujici se hodnoty
                number = in(i); %maximum je 127
                number = uint32(number)+1; %Pocet po sobe jdoucich ruznych hodnot
                for j = 1:number
                    out(index+j)= in(i+j); %Ulozeni hodnoty  pixelu
                end
                i = i + number + 1;
                index = index + number;
                
            else
                number = in(i);
                number = uint32(number) + 1 - 128; %Pocet stejnych hodnot
                i = i + 1;
                value = in(i); %hodnota pixelu
                i = i + 1;
                for j = 1:number
                    out(index+j) = value; %Ulozeni hodnoty  pixelu
                end
                index = index + number;
            end
        end
                
    otherwise
        disp('Zadana spatna vstupni hodnota zpusobu dekodovani!!!')
end

%% Zobrazeni
%Prevedeni vektoru na matici
image = reshape(out, imgHeight, imgWidth);
%vykresleni
figure(2);
imshow(image);
title('Dekodovany obraz')

end