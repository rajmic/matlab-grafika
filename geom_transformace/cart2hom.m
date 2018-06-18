function homCoord = cart2hom(cartCoord)

% Prevadi kartezske souradnice na homogenni
% (delka vektoru se o jedno zvysi pridanim jednotkove souradnice).
% Je mozne na vstup dat vektor (radkovy ci sloupcovy) nebo matici.
% V pripade matice se berou jeji
% sloupce jako vektory kartezskych souradnic.

% (c) 2012 Pavel Rajmic, UTKO FEKT VUT v Brne

[m,n] = size(cartCoord);
if isvector(cartCoord) %vektor
    homCoord = [cartCoord(:); 1]; %pridam ke sloupci jednicku
    if m == 1 %jestlize byl radkovy
        homCoord = homCoord.';
    end
else %matice
    homCoord = cartCoord;
    homCoord(m+1,:) = ones(1,n);
end