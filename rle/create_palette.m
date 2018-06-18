function [table, indexed_img, velikost] = create_palette(img)
%Program urceny pro ziskani palety barev pro dany obrazek
%Nejprve je spocten pocet stejnych hodnot pixelu, pak jsou postupne
%(od nejcetnejsich!) tyto hodnoty pixelu razeny v tabulce.
%
%img - vstupni snimek, data typu uint8
%table - vystupni tabulka (vektor typu uint8) obsahuje serazene hodnoty
%        pixelu od necetnejsich po nejmene cetne
%indexed_img - stejny obrazek ale reprezentovany v palete 'table'
%velikost - velikost vystupni tabulky v bytech
%
%Priklad pouziti - [table, ind_img, velikost] = create_palette(img);
%
%(c) 2012 Jan Masek, drobne upravy 2012-13 Pavel Rajmic, VUT v Brne


%% Prevod obrazku na vektor
[rows,cols] = size(img);
img = img(:);

%% Deklarovani promennych
hist = zeros(256, 1); %Pro cetnosti jednotlivych hodnot pixelu
table = zeros(256, 1); %Tabulka hodnot serazena podle cetnosti vyskytu hodnot pixelu 
indexed_img = uint8(zeros(size(img)));

%% Celkove pocty stejnych pixelu
for i=1:length(img)
    value = img(i);
    value = uint32(value)+1; %Pretypovani promenne a posunuti do int. [1,256]
    hist(value) = hist(value)+1; %Inkrementace poctu pro stejny pixel
end

%% Serazeni hodnot pixelu od nejcetnejsi po nejmene cetnou
for i=1:length(hist)
    maxVal=0;
    for j=1:length(hist)
        if (hist(j)>maxVal) %Najde i-tou nejcetnejsi hodnotu v seznamu
            table(i)=j;
            maxVal = hist(j);
        end
    end
    if(table(i)~=0)
        hist(table(i))=0; %Nalezena i-ta nejcetnejsi hodnota je nastavena na 0, aby uz nebyla znovu hledana
    else break; %preruseni hledani, jiz nema smysl
    end  
end

%% Zpracovani tabulky
%Odstraneni nevyuzitych alokovanych mist
table = table(1:i-1);

%Snizeni vsech hodnot v tabulce o 1 (kvuli naslednemu prevodu do uint8)
table = table-1;

%Prevedeni na vektor typu uint8
table=uint8(table);

%% Velikost tabulky v bajtech
velikost = length(table);

%% Prevod obrazku do palety
for cnt = 1:length(table)
    indexed_img(img==table(cnt)) = cnt;  %prirazeni hodnot 1,2, atd. pixelum v obrazku
end

%% zformovani zpet z vektoru do obrazku
indexed_img = reshape(indexed_img,rows,cols);