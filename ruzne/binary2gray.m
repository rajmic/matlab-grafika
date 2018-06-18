function gray = binary2gray(bin)

% Prevadi (primy) binarni kod na Grayuv
% Vstupem je binarni cislo jako textovy retezec
% nebo matice textovych retezcu
%
% Priklad: binary2gray('11011001')
%          10110101
%
% Priklad: binary2gray(['10111'; '11101'; '11000'])
%          11100
%          10011
%          10100

% (c) 2012-2014 Peter Tropp, Pavel Rajmic, Zdenek Prusa,
%               Vysoke uceni technicke v Brne


%% alokace pameti
gray = bin;

%% Vetveni podle narocnosti
% Na zacatku se rozhoduje, zda je vyhodnejsi konvertovat tak, ze se nejprve
% vytvori kompletni tabulka a z ni se pak jen vycita (vyhodne, kdyz cisel
% ke konverzi je mnoho a opakuji se), nebo naopak tak, ze se bude brat
% cislo po cisle (vyhodne, kdyz cisel je malo)

pocet_cisel = size(bin,1);
pocet_bitu = size(bin,2);

if  2^pocet_bitu < pocet_cisel %tabulkou to bude vyhodnejsi
    
    radku_tab = 2^pocet_bitu;
    table = dec2bin(0:radku_tab-1); %tabulka s primymi binarnimy kody
    
    %prvni bit je shodny, nasledujici cyklus prochazi dalsi bity ktere se XORuji 
    %s predchazejicimi az do konce
    for row = 1:radku_tab %kazdy radek tabulky zvlast
        for i = 2:pocet_bitu
            dalsibit = xor(str2num(table(row,i-1)), str2num(table(row,i)));
            table(row,i) = num2str(dalsibit);
        end
    end
    %v table je nyni Grayuv kod
    
    gray = table(bin2dec(bin)+1,:);
    
else
    
    %prvni bit je shodny, nasledujici cyklus prochazi dalsi bity ktere se XORuji
    %s predchazejicimi az do konce
    for row = 1:pocet_cisel %kazde cislo zvlast
        for i = 2:pocet_bitu
            dalsibit = xor(str2num(bin(row,i-1)), str2num(bin(row,i)));
            gray(row,i) = num2str(dalsibit);
        end
    end
    
end