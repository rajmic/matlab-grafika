function [bitstream, RSseries, bity, DCseries] = jpeg_encode(image, Qmtx, htaclum, htdclum)

% Kódování JPEG obrazu ve stupních šedi
%
% image........vstupní obraz (predpoklada se 8bitova hloubka)
% Qmtx.........kvantovaci matice
% htaclum......Huffmanova tabulka pro kódování AC luminancnich slozek
% htdclum......Huffmanova tabulka pro kódování DC luminancni slozky
% 
% bitstream....vysledny bitovy tok
% RSseries.....posloupnost znacek R|S
% bity.........posloupnost bitovych vyjadreni cisel v paru s R|S
% DC series....posloupnost DC slozek
% % % q_transform..kvantovana matice DCT
%
% Obraz je ve stupnich sedi, 8 bpp
% DC slozka se koduje diferencne, pro kazdy radek zvlast bez navaznosti

% (c) 2010-2016 Pavel Rajmic, Jiøí Štefek, Jakub Hejda, UTKO FEKT VUT v Brne


%% Kontrola formalnich pozadavku na obraz
% Je ve stupnich sedi?
if ndims(image) ~= 2
    error('Obraz musi byt pouze jednokanalovy.');
end

% Jsou rozmery obrazu nasobky osmi
[ver, hor] = size(image);
if (rem(ver,8) ~= 0) || (rem(ver,8) ~= 0)
    error('Rozmery obrazu musi byt nasobky osmi.');
end

%Zmena datoveho typu na plovouci r. carku
image = cast(image,'double');


%% Prevod RGB -> YCbCr
% není nutný, protože pøedpokládáme obraz ve stupních šedi

%% Podvzorkovani barevnych slozek
% nemame barevne slozky, protože pøedpokládáme obraz ve stupních šedi

%% Hlavni smycky pres vsechny bloky
no_blocks_ver = ver/8;
no_blocks_hor = hor/8;

%Priprava vystupu
bitstream = '';
RSseries = cell(0,1);
bity = cell(0,1);
DCseries = [];

%smycky
for cnt_ver = 0:(no_blocks_ver-1)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% inicializace referencni DC slozky pro kazdy radek
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    previousDC=0;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    for cnt_hor = 0:(no_blocks_hor-1)
        disp(['Kodovani bloku na pozici ' num2str([cnt_ver+1 cnt_hor+1])]);
        %vyber aktualniho bloku ke zpracovani
        block = image(8*cnt_ver+1:8*cnt_ver+8 , 8*cnt_hor+1:8*cnt_hor+8);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Pridany dva parametry: htdclum(in), previousDC(in i out)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        [block_bitstream, block_RSseries, block_bity, block_q_transform, previousDC] = jpeg_encode_block(block, Qmtx, htaclum, htdclum, previousDC);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%          block_q_transform
        % Formovani vystupu
        bitstream = [bitstream block_bitstream];
        RSseries = [RSseries; block_RSseries];
        bity = [bity; block_bity];
        DCseries = [DCseries; previousDC];
    end
end

end % Konec hlavniho programu




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Pridany dva parametry: htdclum, previousDC
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
function [bitstream, RSseries, bity, q_transform, previousDC] = jpeg_encode_block(image, Qmtx, htaclum, htdclum, previousDC)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% Provadi kodovani jednoho bloku 8x8
%% DCT 2D
%centrovani dat do intervalu [-128, 127) -- to lze udìlat rychleji
%pouhým odeètením 1024 od DC složky až po provedení DCT, ale pro názornost to
%udìláme už nyní v prostorové oblasti
image = image - 128;

%samotna transformace
transform = dct2(image); %Stejny vysledek lze dostat vynasobenim matici DCT

%% Kvantizace
q_transform = transform ./ Qmtx;
q_transform = round(q_transform);
%pro testovani
% q_transform = ...
% [     1     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0];
% 

%% Cik-cak vycitani koeficientu
zig_transform = zigzag(q_transform); %s vyuzitim volani cizi funkce
% nyni jsou hodnoty z kvantizovane matice serazeny v 1D vektoru


%% Kodovani do posloupnosti R|S
% DC slozka
% zakoduj DC diferencne ....
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% volani kodovani DC slozky
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
[bin_kod_DC_huff] = encode_DC_component(previousDC, zig_transform(1), htdclum);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
previousDC = zig_transform(1); %nova "predchozi" hodnota

% AC slozka (63krat)
zig_transform = zig_transform(2:end); %DC slozku dam pryc

% %pro testovani:
% zig_transform = zeros(63,1);
% zig_transform(1:5) = [-3 2 1 -1 1];
% zig_transform(11) = [-1];
% % zig_transform(37) = [1];
% zig_transform(58) = [1];
% % zig_transform(60) = [1];

nzind = find(zig_transform ~= 0); %non-zero indexes
l = length(nzind);
RSseries = cell(0,1);
bity = cell(0,1);

predchozi = 0;
for cnt = 1:l
    R = nzind(cnt) - predchozi - 1;
    if R >= 16
        %postupne odecitani 16 a zapisovani znacky ZRL
        while R >= 16
            RSseries = [RSseries; 'f0']; %znacka ZRL
            bity = [bity;  cell(1,1) ]; %prazdny retezec - neni potreba bitove vyjadreni hodnoty
%             bitstream = ['ZLR'];
%             disp(bitstream)
            R = R-15;
        end
    end
    %binarni kod cisla
    [bin_kod] = encode_AC_component(zig_transform(nzind(cnt)));
    bity = [bity; bin_kod];
    %kategorie
    S = length(bin_kod);
    %vstup pro Huffmanovo kodovani budou dvojice R|S
    RSseries = [RSseries; [dec2hex(R) dec2hex(S)] ];
%     RSseries = [RSseries; [dec2hex(R) num2str(S)] ];
%     disp([ num2str(R) '|' num2str(S) ' ' num2str(zig_transform(nzind(cnt)))]);
%     
%     else
%         % kategorie S a binarni kod cisla
%         [bin_kod, S] = encode_AC_component(zig_transform(nzind(cnt)));
%         bitstream = [ num2str(R) '|' num2str(S) ' ' bin_kod]
%     end
    predchozi = nzind(cnt); %do dalsiho kola
end

%zapsani EOB (kdyz 63. koeficient neni nulovy, EOB se nezapise!)
if (l==0) || (nzind(end) ~= 63)
    RSseries = [RSseries; '00']; %znacka EOB
%     bitstream = 'EOB';
    bity = [bity; cell(1,1) ]; %prazdny retezec - neni potreba bitove vyjadreni hodnoty
%     disp(bitstream)
end


%% Kodovani posloupnosti R|S podle Huffmanovy tabulky
%nyni mame posloupnosti 'RSseries' a prislusnych bitovych vyjadreni 'bity'
%a je potreba pro R|S nalezt odpovidajici kody z Huffmanovy tabulky

% %nacteni Huffmanovy tabulky pro AC luminancni slozky
% htaclum = huffman_table_ac_lum();

%hledani prislusne hodnoty v tabulce, vytvoreni posloupnosti
Huffman_RS_codes = cell(0,1);
for cnt = 1:size(RSseries,1)
    index = find_ht_cell(htaclum,RSseries{cnt});
    %(hledani je vzdy jednoznacne, nemuze nastat kolize; plyne to z toho,
    %ze R muze byt v rozsahu 1--15 (tj. jeden hexadecimalni znak) a S v rozsahu 1--10)
    Huffman_RS_codes = [Huffman_RS_codes; htaclum(index,2)];
end

%% Spojeni do jednoho datoveho toku
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % DC pridano do bitstreamu
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
bitstream = [bin_kod_DC_huff];
for cnt = 1:size(RSseries,1)
    bitstream = [bitstream Huffman_RS_codes{cnt} bity{cnt}];
end

% bitstream;

end




% %Prozatim vybiram pouze prvni blok 8x8 pixelu:
% image = image(1:8,1:8);
% 
% %% Kontrola obrazu
% if size(image) ~= [8,8]
%     error('Spatna velikost')
% end
% % % Vynuceny prevod na stupne sedi
% % image = rgb2gray(image);


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% kodovani DC slozky
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
function [bin_kod] = encode_DC_component(previous, current, htdclum)

% Vraci diferencne zakodovany DC clen po Huffmanove kodovani
% DC clen se koduje jako  
% [delka_posloupnosti_prekodovana_dle_huff_tabulky,  difference_v_binarni_podobe]
%
% Pr: 
% dekadicke cislo 120 ma binarni hodnotu 111 1000, coz je 7 bitu,
% v Huffmanove tabulce si najdeme kod pro 7 bitu, tedy polozku s indexem 0x07h
% pod timto indexem je cislo: 11110
% cislo 120 tedy zakodujeme jako 1111 0111 1000
% 
% Pr:
% prijde zakodovana posloupnost: 1 1110 1111 000...
% 11110 porovnanim s Huffmanovou tabulkou znamena, ze nasledujici cislo je dlouhe 7 bitu
% vymezime si nasledujicich 7 bitu: 111 1000, coz po prevodu do desitkove
% soustavy je +120

% vypocteme rozdil od predchoziho bloku ve stejnem radku
diff = current - previous;

if diff==0 %ekvivalentni s bin_kod=='0'
    % pocet_bitu v hexadecimalnim tvaru 00 pro vyhledavani v Huffmanove tabulce
    %     hex_delka = dec2hex(0,2); %tj. '00', coz je ve std. tabulce na prvni pozici
    bin_kod = dec2hex(0,2); %tj. '00', coz je ve std. tabulce na prvni pozici
    % dalsi nulu neni potreba zapisovat, protoze je to zrejme (pro dekoder)
else
    sgn = sign(diff); %znamenko
    diff = abs(diff); %absolutni hodnota
    bin_kod = dec2bin(diff);
    if sgn == -1
        bin_kod = jedn_doplnek(bin_kod);
    end
    % pocet_bitu v hexadecimalnim tvaru 01-0B pro vyhledavani v tabulce
    hex_delka = dec2hex(length(bin_kod),2);
    % najdeme index v Huffmanove tabulce
    index = find_ht_cell(htdclum,hex_delka);
    % spojime dvojici [delka_posloupnosti_dle_huff_tabulky,
    % difference_v_binarni_podobe] do jedne posloupnosti
    bin_kod = [htdclum{index,2} bin_kod];
end
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [bin_kod] = encode_AC_component(ACcoef)
% Vraci kod kategorie a binarni hodnotu pro vlozene cislo.
% Pro plne binarni proud potom jeste pouzijeme Huffmanovu tabulku pro kodovani kategorii.

current = ACcoef;
sgn = sign(current);
current = abs(current);
bin_kod = dec2bin(current);

if sgn == -1
    bin_kod = jedn_doplnek(bin_kod);
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function index = find_ht_cell(ht,symbol)
% najde radkovy index v Huffmanove tabulce 'ht' prislusny symbolu
    found = false;
    index = 0;
    maxindex = size(ht,1);
    
    while ~found
        index = index + 1;
        if index > maxindex
            error('Symbol RS neni v Huffmanove tabulce')
        end
        found = strcmpi(ht{index},symbol);
    end
end