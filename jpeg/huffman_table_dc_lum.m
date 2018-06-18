function ht = huffman_table_dc_lum()

% vraci Huffmanovu tabulku pro DC koeficienty luminancní slozky
%
% vychazi se pritom ze souboru "jcparam.c" stahnuteho z netu', kde je jako
% standardni Huff. tabulka uvedeno toto:
% 
%   static const UINT8 bits_dc_luminance[17] =
%     { /* 0-base */ 0, 0, 1, 5, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 };
%   static const UINT8 val_dc_luminance[] =
%     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 };

%% Definice tabulky nerozvinuta
NoOfRepresentants = [0, 1, 5, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0];
Symbols_Hex = ['00'; '01'; '02'; '03'; '04'; '05'; '06'; '07'; '08'; '09'; '0A'; '0B']; %cisla 0 az 11 jako retezce (hexadecimalne)
% Symbols_Hex = (0:11)';


ht = extract_huffman_table(NoOfRepresentants, Symbols_Hex);