function Qmtx = quant_matrix(quality)

% Funkce pro generovani kvantizacni matice 8x8 pro JPEG podle kvalitativniho faktoru
% pro LUMINANCNI slozku
% Qmtx = quant_matrix(quality)
% 
% quality.....cislo mezi 1 a 100 (vyssi cislo odpovida mensi kompresi)
%             pokud argument neni specifikovan, pouzije se vychozi
%             hodnota 50
%
% Defaultni kvantizacni matice JPEG podle Wikipedie
% http://en.wikipedia.org/wiki/Quantization_matrix

% (c) 2010, 2011, 2016 J. Štefek, P. Rajmic


% Pokud se nezada vstupni argument, vezme se defaultni kvalita
if (nargin == 0)
    quality = 50;
end

defaultBlockSize = 8;

% Matice pro vychozi kvalitu (50)
Qmtx = [    16 11 10 16  24  40  51  61
            12 12 14 19  26  58  60  55
            14 13 16 24  40  57  69  56
            14 17 22 29  51  87  80  62
            18 22 37 56  68 109 103  77
            24 35 55 64  81 104 113  92
            49 64 78 87 103 121 120 101
            72 92 95 98 112 100 103 99];
        
if (quality >= 1) && (quality <= 100) && (ceil(quality) == quality)
    alfa = 1; % pro kvalitu 50
    
%   Vypocet alfa pro kvalitu <1;50)
    if quality < 50
        alfa = 50 / quality;
    end
    
%   Vypocet alfa pro kvalitu (51;100)
    if quality > 50
        alfa = 2 - 2*quality/100;
    end

%   Vypocet pro kvalitu 100    
    if quality == 100
        Qmtx = ones(defaultBlockSize,defaultBlockSize);
        return; %vyskoc
    end
    
%   Uprava kvantizacni matice s ohledem na kvalitu  
    Qmtx = Qmtx .* alfa;
    Qmtx = round(Qmtx);
    Qmtx(Qmtx==0) = 1; % nejlepsi kvalita je 1, ne 0, nutno timto spravit
    
else 
    error('Parametr ''quality'' musi byt cele cislo 1 az 100.')
end