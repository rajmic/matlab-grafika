function [ratio, truecolorBits, indexTotalBits] = ...
    indexed_vs_truecolor_savings(rows, cols, bitdepth_true, bits_palette)

% spocita kompresni pomer pri ulozeni truecolor obrazku v palete
%
% rows, cols........rozmery obrazku
% bitdepth_true.....kolika bity je urcen kazdy pixel v obrazku
% bits_palette......kolika bity je definovana paleta
%
% Priklad volani:
%   r = indexed_vs_truecolor_savings(640, 480, 24, 8)
%   [r, a, b] = indexed_vs_truecolor_savings(320, 200, 24, 5)

% (c) 2012-2014 Pavel Rajmic, ÚTKO FEKT VUT v Brnì


%pixelu celkem
pixels = rows*cols;

% kolik bitu pri truecolor rezimu
truecolorBits = pixels * bitdepth_true;

% kolik bitu vsechny odkazy do palety
indexedBits = pixels * bits_palette;

% kolik bitu zabere paleta (zaznamy v palete jsou v presnosti truecolor)
paletteBits = 2^bits_palette * bitdepth_true;

% celkem indexovany
indexTotalBits = indexedBits + paletteBits;

% vysledny pomer
ratio = truecolorBits / indexTotalBits;