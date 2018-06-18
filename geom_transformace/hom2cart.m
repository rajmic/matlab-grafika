function cartCoord = hom2cart(homCoord,shrink)

% Prevadi homogenni souradnice na kartezske
% (delka vektoru zustava STEJNA, z posledniho prvku se stane jednicka).
% Je mozne na vstup dat vektor (radkovy ci sloupcovy) nebo matici.
% V pripade matice se berou jeji sloupce jako vektory homogennich souradnic.
% Jestlize parametr 'shrink' je pritomen a je neprazdny, pak se vysledne
% souradnice zkrati o tu posledni.

% (c) 2012 Pavel Rajmic, UTKO FEKT VUT v Brne

%%Kontrola parametru
if nargin < 1
    error('Nedostatecny pocet parametru')
elseif (nargin == 1) || (isempty(shrink))
    shrink = false;
else
    shrink = true;
end

if isvector(homCoord) %vektor
    cartCoord = homCoord ./ homCoord(end); %podeleni posledni slozkou
    if shrink
        cartCoord = cartCoord(1:end-1);
    end
else %matice
%     [m,n] = size(homCoord);
    % slo by jednoduseji, ale pro prehlednost postupne po sloupcich:
    for cnt = 1:size(homCoord,2)
        cartCoord(:,cnt) = homCoord(:,cnt) ./ homCoord(end,cnt);
    end
    if shrink
        cartCoord = cartCoord(1:end-1,:);
    end
end