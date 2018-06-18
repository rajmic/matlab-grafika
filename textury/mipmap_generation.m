function [MIP, MIPcoloured] = mipmap_generation(imageRGB)

% Generuje MIP mapu pro vstupni texturu
%
% imageRGB......RGB obrazek jako trirozmerna matice, obrazek se predpoklada
%               ctvercovy, rozmen je mocninou dvojky, 2^n
% MIP...........obrazek MIP mapy rozmeru 2^(n+1)
% MIPcoloured...obrazek MIP mapy, ale jednotlive kanaly jsou obrarveny (3D matice RGB)

% (c) 2013 Martin Sulc, Pavel Rajmic, VUT v Brne


%% kontrola vstupu, jestli má dobré rozmìry
[cols,rows,colours] = size(imageRGB);

assert(2^nextpow2(cols)==cols)
assert(cols==rows)
assert(colours==3)

r = imageRGB(:,:,1);
g = imageRGB(:,:,2);
b = imageRGB(:,:,3);

%% skladani matice MIP
%alokace prostoru
MIPcoloured = zeros(2*cols, 2*cols, 3, 'uint8');
p2 = cols;
p3 = 2*cols;

%Obrazek puvodni velikosti pujde nezmeneny na tyto pozice
MIPcoloured(1:p2,1:p2, 1) = r;
MIPcoloured((p2+1):p3,1:p2, 2) = g;
MIPcoloured(1:p2,(p2+1):p3, 3) = b;

%inicializace pro while
delicka = 1;
[X, Y] = meshgrid (1:cols);

while p2+1 < 2*cols
    delicka = delicka*2;
    p1 = p2; %p1 je prvni bod, p2 je v pulce mezi p1 a koncem(p3)
    p2 = p1+cols/delicka;
    [IX, IY] = meshgrid((1:cols/delicka)*delicka); % násobení je tam pro zachování rozsahu
    r2 = double(r); %kvuli interpolaci, asi by to šlo dìlat celé v double, ale já jsem chtìl vidìt ty hodnoty v 0--255
    g2 = double(g);
    b2 = double(b);
    
    pulr = interp2(X, Y, r2, IX, IY, 'cubic'); %asi by to šlo rovnou pro rgb pomoci interp3 pravdìpodobnì
    pulg = interp2(X, Y, g2, IX, IY, 'cubic');
    pulb = interp2(X, Y, b2, IX, IY, 'cubic');
    
    pr = uint8(pulr); %zpìt zase kvuli image
    pg = uint8(pulg);
    pb = uint8(pulb);
    
    MIPcoloured((p1+1):p2,(p1+1):p2,1) = pr;
    MIPcoloured((p2+1):p3,(p1+1):p2,2) = pg;
    MIPcoloured((p1+1):p2,(p2+1):p3,3) = pb;
end

%% Non-coloured version
MIP = zeros(2*cols, 2*cols, 'uint8'); %alokace prostoru
%suma podel treti dimenze; v kazdem kanalu jsou dve nuly a jedno cislo
MIP = sum(MIPcoloured,3);