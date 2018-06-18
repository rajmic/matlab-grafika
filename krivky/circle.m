function [x,y] = circle(stred,r,pocet)

% vraci urceny pocet vypocitanych souradnic x a y bodu na kruznici
% o danem stredu a polomeru

% (c) 2010-2012, Štefek, Rajmic, VUT v Brnì

x = zeros(pocet,1); %alokace
y = zeros(pocet,1); %alokace
zmenaUhlu= 2*pi/pocet;

uhel=0;
for i=1:pocet
    x(i) = stred(1) + r*cos(uhel);
    y(i) = stred(2) + r*sin(uhel);
    uhel = uhel + zmenaUhlu;
end
end